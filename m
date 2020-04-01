Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD00C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DFBD20719
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 18:23:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eaFAU3Xz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732824AbgDASXm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 14:23:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52354 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732285AbgDASXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 14:23:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585765420;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qLxBO84kF8H5EGei+//43ik3y+DXrskN0pkB/NdJH9g=;
        b=eaFAU3XzOF3AQWPeRhwlhwQZrTZeoBzlZFKM1EyYbkjQFYr0MTdIKPx1CtI0mQT+tF+2X2
        T0c3PSZQZJj7X1Q+heiwGKFo9c9/D0blw/k7zD1UW1BP8u1ZX49eQCup06ujByhtZVtsxj
        H5qQ87YrC5CZ98WfyXrBy99EEcfye8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-u02ICRzSMVaOtQ3WiV-PWA-1; Wed, 01 Apr 2020 14:23:39 -0400
X-MC-Unique: u02ICRzSMVaOtQ3WiV-PWA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF333800D5B;
        Wed,  1 Apr 2020 18:23:37 +0000 (UTC)
Received: from treble.redhat.com (ovpn-118-135.phx2.redhat.com [10.3.118.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 439B660BEC;
        Wed,  1 Apr 2020 18:23:37 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 1/5] objtool: Fix CONFIG_UBSAN_TRAP unreachable warnings
Date:   Wed,  1 Apr 2020 13:23:25 -0500
Message-Id: <6653ad73c6b59c049211bd7c11ed3809c20ee9f5.1585761021.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1585761021.git.jpoimboe@redhat.com>
References: <cover.1585761021.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_UBSAN_TRAP causes GCC to emit a UD2 whenever it encounters an
unreachable code path.  This includes __builtin_unreachable().  Because
the BUG() macro uses __builtin_unreachable() after it emits its own UD2,
this results in a double UD2.  In this case objtool rightfully detects
that the second UD2 is unreachable:

  init/main.o: warning: objtool: repair_env_string()+0x1c8: unreachable i=
nstruction

We weren't able to figure out a way to get rid of the double UD2s, so
just silence the warning.

Cc: Kees Cook <keescook@chromium.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e3bb76358148..aaec5e1277ea 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2382,14 +2382,27 @@ static bool ignore_unreachable_insn(struct instru=
ction *insn)
 	    !strcmp(insn->sec->name, ".altinstr_aux"))
 		return true;
=20
+	if (!insn->func)
+		return false;
+
+	/*
+	 * CONFIG_UBSAN_TRAP inserts a UD2 when it sees
+	 * __builtin_unreachable().  The BUG() macro has an unreachable() after
+	 * the UD2, which causes GCC's undefined trap logic to emit another UD2
+	 * (or occasionally a JMP to UD2).
+	 */
+	if (list_prev_entry(insn, list)->dead_end &&
+	    (insn->type =3D=3D INSN_BUG ||
+	     (insn->type =3D=3D INSN_JUMP_UNCONDITIONAL &&
+	      insn->jump_dest && insn->jump_dest->type =3D=3D INSN_BUG)))
+		return true;
+
 	/*
 	 * Check if this (or a subsequent) instruction is related to
 	 * CONFIG_UBSAN or CONFIG_KASAN.
 	 *
 	 * End the search at 5 instructions to avoid going into the weeds.
 	 */
-	if (!insn->func)
-		return false;
 	for (i =3D 0; i < 5; i++) {
=20
 		if (is_kasan_insn(insn) || is_ubsan_insn(insn))
--=20
2.21.1

