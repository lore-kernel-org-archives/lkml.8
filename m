Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21ABBC352A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC2BD208C4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHQvFQBb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727753AbgBJSd1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 13:33:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36268 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727681AbgBJSdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 13:33:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581359604;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GVRr/YGcOp02+ZNDUsafnMKJg+BaB8QtZpyHsk3wnVo=;
        b=LHQvFQBb9X0yNt6f8tkX2rnn0kWV0Vanb0yUV3uZ5Tqk/s5vGTaIAyyUkLyee/8MHLLjgF
        WPHxm71iNyML55AUT8IDKEIGRsgwNCWULjppF6k71E0eGs6N3HERhH6+TxnyeLxZVV4FLu
        eKQrSPNLUjSoDMaYx5I8cx5b+xPH3+4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-XBKl2AwvM3mqMCL5iYDJgw-1; Mon, 10 Feb 2020 13:33:23 -0500
X-MC-Unique: XBKl2AwvM3mqMCL5iYDJgw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1196A8017CC;
        Mon, 10 Feb 2020 18:33:22 +0000 (UTC)
Received: from treble.redhat.com (ovpn-122-45.rdu2.redhat.com [10.10.122.45])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 94D1410013A7;
        Mon, 10 Feb 2020 18:33:20 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Julien Thierry <jthierry@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 3/3] objtool: Add relocation check for alternative sections
Date:   Mon, 10 Feb 2020 12:32:40 -0600
Message-Id: <7b90b68d093311e4e8f6b504a9e1c758fd7e0002.1581359535.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1581359535.git.jpoimboe@redhat.com>
References: <cover.1581359535.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Relocations in alternative code can be dangerous, because the code is
copy/pasted to the text section after relocations have been resolved,
which can corrupt PC-relative addresses.

However, relocations might be acceptable in some cases, depending on the
architecture.  For example, the x86 alternatives code manually fixes up
the target addresses for PC-relative jumps and calls.

So disallow relocations in alternative code, except where the x86 arch
code allows it.

This code may need to be tweaked for other arches when objtool gets
support for them.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 5ea2ce7ed8a3..2d52a40e6cb9 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -786,6 +786,27 @@ static int handle_group_alt(struct objtool_file *fil=
e,
 		insn->ignore =3D orig_insn->ignore_alts;
 		insn->func =3D orig_insn->func;
=20
+		/*
+		 * Since alternative replacement code is copy/pasted by the
+		 * kernel after applying relocations, generally such code can't
+		 * have relative-address relocation references to outside the
+		 * .altinstr_replacement section, unless the arch's
+		 * alternatives code can adjust the relative offsets
+		 * accordingly.
+		 *
+		 * The x86 alternatives code adjusts the offsets only when it
+		 * encounters a branch instruction at the very beginning of the
+		 * replacement group.
+		 */
+		if ((insn->offset !=3D special_alt->new_off ||
+		    (insn->type !=3D INSN_CALL && !is_static_jump(insn))) &&
+		    find_rela_by_dest_range(insn->sec, insn->offset, insn->len)) {
+
+			WARN_FUNC("unsupported relocation in alternatives section",
+				  insn->sec, insn->offset);
+			return -1;
+		}
+
 		if (!is_static_jump(insn))
 			continue;
=20
--=20
2.21.1

