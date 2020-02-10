Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAE6C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E27A20675
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K58RblsK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgBJSd0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:33:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54273 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727671AbgBJSdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:33:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581359603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i8fRUGFIHBnfJGjUZdlQ+TJpifnArFyNjaK/G+n3xX4=;
        b=K58RblsKSUpMBpVZM7uwgHM3e90ubLEKYOyV7TW/XGEuIx+/eF14cry8B8ou3zxSXjci9O
        qqq/rHPfZa2Qhsr0kXfO17JFhQB1/rW+8W/oscBFGa1Gi5df41q8vqIS6avfRrkAFAcMMj
        ieJkaqGXhlT4jUZZBIsibXZUqVk4hcg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-2mSjX6BaMkaeu-PE7fAcpw-1; Mon, 10 Feb 2020 13:33:21 -0500
X-MC-Unique: 2mSjX6BaMkaeu-PE7fAcpw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366291005514;
        Mon, 10 Feb 2020 18:33:20 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-45.rdu2.redhat.com [10.10.122.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 12F2910013A7;
        Mon, 10 Feb 2020 18:33:18 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 2/3] objtool: Add is_static_jump() helper
Date:   Mon, 10 Feb 2020 12:32:39 -0600
Message-Id: <9b8b438df918276315e4765c60d2587f3c7ad698.1581359535.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1581359535.git.jpoimboe@redhat.com>
References: <cover.1581359535.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several places where objtool tests for a non-dynamic (aka
direct) jump.  Move the check to a helper function.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 61d2d1877fd2..5ea2ce7ed8a3 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -97,14 +97,19 @@ static struct instruction *next_insn_same_func(struct=
 objtool_file *file,
 	for (insn =3D next_insn_same_sec(file, insn); insn;		\
 	     insn =3D next_insn_same_sec(file, insn))
=20
+static bool is_static_jump(struct instruction *insn)
+{
+	return insn->type =3D=3D INSN_JUMP_CONDITIONAL ||
+	       insn->type =3D=3D INSN_JUMP_UNCONDITIONAL;
+}
+
 static bool is_sibling_call(struct instruction *insn)
 {
 	/* An indirect jump is either a sibling call or a jump to a table. */
 	if (insn->type =3D=3D INSN_JUMP_DYNAMIC)
 		return list_empty(&insn->alts);
=20
-	if (insn->type !=3D INSN_JUMP_CONDITIONAL &&
-	    insn->type !=3D INSN_JUMP_UNCONDITIONAL)
+	if (!is_static_jump(insn))
 		return false;
=20
 	/* add_jump_destinations() sets insn->call_dest for sibling calls. */
@@ -571,8 +576,7 @@ static int add_jump_destinations(struct objtool_file =
*file)
 	unsigned long dest_off;
=20
 	for_each_insn(file, insn) {
-		if (insn->type !=3D INSN_JUMP_CONDITIONAL &&
-		    insn->type !=3D INSN_JUMP_UNCONDITIONAL)
+		if (!is_static_jump(insn))
 			continue;
=20
 		if (insn->ignore || insn->offset =3D=3D FAKE_JUMP_OFFSET)
@@ -782,8 +786,7 @@ static int handle_group_alt(struct objtool_file *file=
,
 		insn->ignore =3D orig_insn->ignore_alts;
 		insn->func =3D orig_insn->func;
=20
-		if (insn->type !=3D INSN_JUMP_CONDITIONAL &&
-		    insn->type !=3D INSN_JUMP_UNCONDITIONAL)
+		if (!is_static_jump(insn))
 			continue;
=20
 		if (!insn->immediate)
--=20
2.21.1

