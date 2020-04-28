Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82967C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FB082072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 21:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fn6nBVEh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD1VsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 17:48:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:26342 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726256AbgD1Vqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 17:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588110390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uPf8FVl+LaDkZPh9Aa0QYEw5bI73NFU9LEE23US3XSU=;
        b=Fn6nBVEhVI5kI8rbdt1iVNpI9bKTwmO7FV6nrm7ORYcEnZGCkbZsFVj6ZxvNANxym6zWa+
        fcAqjJp8PpkjvtP4g/RxYbcSHvmcqVeMgJW3iLBDQsT8/2w8uy8HK1gR4tvYg8PCMLrLHd
        0Q+kvv0b5bua+ugtoOBDs7XKCvP1Bck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-108-DT06ddlwMQmto9bgs-R9Tw-1; Tue, 28 Apr 2020 17:46:28 -0400
X-MC-Unique: DT06ddlwMQmto9bgs-R9Tw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C0D918FF666;
        Tue, 28 Apr 2020 21:46:27 +0000 (UTC)
Received: from treble.redhat.com (ovpn-112-209.rdu2.redhat.com [10.10.112.209])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9C0E45D71E;
        Tue, 28 Apr 2020 21:46:25 +0000 (UTC)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Julien Thierry <jthierry@redhat.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>
Subject: [PATCH] objtool: Fix infinite loop in find_jump_table()
Date:   Tue, 28 Apr 2020 16:45:16 -0500
Message-Id: <378b51c9d9c894dc3294bc460b4b0869e950b7c5.1588110291.git.jpoimboe@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kristen found a hang in objtool when building with -ffunction-sections.

It was caused by evergreen_pcie_gen2_enable.cold() being laid out
immediately before evergreen_pcie_gen2_enable().  Since their "pfunc" is
always the same, find_jump_table() got into an infinite loop because it
didn't recognize the boundary between the two functions.

Fix that with a new prev_insn_same_sym() helper, which doesn't cross
subfunction boundaries.

Reported-by: Kristen Carlson Accardi <kristen@linux.intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/objtool/check.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0c732d586924..4b51a06c7683 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -73,6 +73,17 @@ static struct instruction *next_insn_same_func(struct =
objtool_file *file,
 	return find_insn(file, func->cfunc->sec, func->cfunc->offset);
 }
=20
+static struct instruction *prev_insn_same_sym(struct objtool_file *file,
+					       struct instruction *insn)
+{
+	struct instruction *prev =3D list_prev_entry(insn, list);
+
+	if (&prev->list !=3D &file->insn_list && prev->func =3D=3D insn->func)
+		return prev;
+
+	return NULL;
+}
+
 #define func_for_each_insn(file, func, insn)				\
 	for (insn =3D find_insn(file, func->sec, func->offset);		\
 	     insn;							\
@@ -1096,8 +1107,8 @@ static struct rela *find_jump_table(struct objtool_=
file *file,
 	 * it.
 	 */
 	for (;
-	     &insn->list !=3D &file->insn_list && insn->func && insn->func->pfu=
nc =3D=3D func;
-	     insn =3D insn->first_jump_src ?: list_prev_entry(insn, list)) {
+	     insn && insn->func && insn->func->pfunc =3D=3D func;
+	     insn =3D insn->first_jump_src ?: prev_insn_same_sym(file, insn)) {
=20
 		if (insn !=3D orig_insn && insn->type =3D=3D INSN_JUMP_DYNAMIC)
 			break;
--=20
2.21.1

