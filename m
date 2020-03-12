Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF70CC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE212071C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 17:31:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z8M+Lum9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbgCLRbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 13:31:13 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34488 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbgCLRbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 13:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584034269;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hDxUNunCB687wAIPkmJJmgGhqlolBxvPaWThLpEgQnk=;
        b=Z8M+Lum9SOT7Erxn5GFFag4J7FwkoxDjyTS46/1RSZOpfPoPf4SdZVDXKFVYcE5L9v8htd
        kE/k+POnSSBRrArDE8pWMCW+zxAzyxOM/XHMetBVTuayEwKoXMD0VcBPDfLLolqq4CMlm9
        HVpUjuUuxSH22uz5P70ex0SwasvNWVs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-411-2Rrpm0NNPxCKXvu6PLiXNg-1; Thu, 12 Mar 2020 13:31:08 -0400
X-MC-Unique: 2Rrpm0NNPxCKXvu6PLiXNg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1BFED800D48;
        Thu, 12 Mar 2020 17:31:06 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-137.rdu2.redhat.com [10.10.122.137])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFCA360BEC;
        Thu, 12 Mar 2020 17:31:04 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Vince Weaver <vincent.weaver@maine.edu>,
        Dave Jones <dsj@fb.com>, Jann Horn <jannh@google.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 10/14] x86/unwind/orc: Prevent unwinding before ORC initialization
Date:   Thu, 12 Mar 2020 12:30:29 -0500
Message-Id: <5b3e0cbab4a5e6cf5e3cab87f18f2ae582ec01d7.1584033751.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1584033751.git.jpoimboe@redhat.com>
References: <cover.1584033751.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the unwinder is called before the ORC data has been initialized,
orc_find() returns NULL, and it tries to fall back to using frame
pointers.  This can cause some unexpected warnings during boot.

Move the 'orc_init' check from orc_find() to __unwind_init(), so that it
doesn't even try to unwind from an uninitialized state.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/unwind_orc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index e9f5a20c69c6..cb11567361cc 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -148,9 +148,6 @@ static struct orc_entry *orc_find(unsigned long ip)
 {
 	static struct orc_entry *orc;
=20
-	if (!orc_init)
-		return NULL;
-
 	if (ip =3D=3D 0)
 		return &null_orc_entry;
=20
@@ -591,6 +588,9 @@ EXPORT_SYMBOL_GPL(unwind_next_frame);
 void __unwind_start(struct unwind_state *state, struct task_struct *task=
,
 		    struct pt_regs *regs, unsigned long *first_frame)
 {
+	if (!orc_init)
+		goto done;
+
 	memset(state, 0, sizeof(*state));
 	state->task =3D task;
=20
--=20
2.21.1

