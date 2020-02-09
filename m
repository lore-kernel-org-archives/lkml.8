Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111B7C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8EBF2080C
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581253001;
	bh=UzFJVOYPOVgXmoTrDrMUaZer8nC8kfZFkwknGpfqs1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=pSV5t96ZTqaUJKMMQr395pDFVGP2h0FZBCcVkUfKxNc0+u1B81FiEj6cAh5QCPaTV
	 WhsbB9OfPKbIj4D+jPSvZnMJ+EmhwKQKWtPWypPQCfUjmijV9/tLpeX1RE904LK2Pu
	 sVNmAqDXu7rmKMC5UjvKKZ258y6+dSEBxb9QfyyE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727778AbgBIM4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:56:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:44762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbgBIM4k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:56:40 -0500
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CAD920733;
        Sun,  9 Feb 2020 12:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581252999;
        bh=UzFJVOYPOVgXmoTrDrMUaZer8nC8kfZFkwknGpfqs1I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LhQ9KwU6fGCTULt/7XZhHCoUrOzlIM7eMTU729gLOaiSMegw4FwVUufLZSL4WbD76
         aY/eyGG2Xo8Y4X9FcDgunhxQo8HeC9vr3V0dEQ48wxPVuC1kfULpmRW0nmEB+8x5Lk
         w4sveno6NnMei9TbyD/26Opae/+G7KaXaeJJWIQI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 4/6] powerpc: mm: ptdump: no need to check return value of debugfs_create functions
Date:   Sun,  9 Feb 2020 11:58:59 +0100
Message-Id: <20200209105901.1620958-4-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
References: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When calling debugfs functions, there is no need to ever check the
return value.  The function can work or not, but the code logic should
never do something different based on this.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/mm/ptdump/bats.c          | 8 +++-----
 arch/powerpc/mm/ptdump/hashpagetable.c | 7 ++-----
 arch/powerpc/mm/ptdump/ptdump.c        | 8 +++-----
 arch/powerpc/mm/ptdump/segment_regs.c  | 8 +++-----
 4 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/bats.c b/arch/powerpc/mm/ptdump/bats.c
index 4154feac1da3..d3a5d6b318d1 100644
--- a/arch/powerpc/mm/ptdump/bats.c
+++ b/arch/powerpc/mm/ptdump/bats.c
@@ -164,10 +164,8 @@ static const struct file_operations bats_fops = {
 
 static int __init bats_init(void)
 {
-	struct dentry *debugfs_file;
-
-	debugfs_file = debugfs_create_file("block_address_translation", 0400,
-					   powerpc_debugfs_root, NULL, &bats_fops);
-	return debugfs_file ? 0 : -ENOMEM;
+	debugfs_create_file("block_address_translation", 0400,
+			    powerpc_debugfs_root, NULL, &bats_fops);
+	return 0;
 }
 device_initcall(bats_init);
diff --git a/arch/powerpc/mm/ptdump/hashpagetable.c b/arch/powerpc/mm/ptdump/hashpagetable.c
index a07278027c6f..b6ed9578382f 100644
--- a/arch/powerpc/mm/ptdump/hashpagetable.c
+++ b/arch/powerpc/mm/ptdump/hashpagetable.c
@@ -527,13 +527,10 @@ static const struct file_operations ptdump_fops = {
 
 static int ptdump_init(void)
 {
-	struct dentry *debugfs_file;
-
 	if (!radix_enabled()) {
 		populate_markers();
-		debugfs_file = debugfs_create_file("kernel_hash_pagetable",
-				0400, NULL, NULL, &ptdump_fops);
-		return debugfs_file ? 0 : -ENOMEM;
+		debugfs_create_file("kernel_hash_pagetable", 0400, NULL, NULL,
+				    &ptdump_fops);
 	}
 	return 0;
 }
diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
index 206156255247..d92bb8ea229c 100644
--- a/arch/powerpc/mm/ptdump/ptdump.c
+++ b/arch/powerpc/mm/ptdump/ptdump.c
@@ -417,12 +417,10 @@ void ptdump_check_wx(void)
 
 static int ptdump_init(void)
 {
-	struct dentry *debugfs_file;
-
 	populate_markers();
 	build_pgtable_complete_mask();
-	debugfs_file = debugfs_create_file("kernel_page_tables", 0400, NULL,
-			NULL, &ptdump_fops);
-	return debugfs_file ? 0 : -ENOMEM;
+	debugfs_create_file("kernel_page_tables", 0400, NULL, NULL,
+			    &ptdump_fops);
+	return 0;
 }
 device_initcall(ptdump_init);
diff --git a/arch/powerpc/mm/ptdump/segment_regs.c b/arch/powerpc/mm/ptdump/segment_regs.c
index 501843664bb9..dde2fe8de4b2 100644
--- a/arch/powerpc/mm/ptdump/segment_regs.c
+++ b/arch/powerpc/mm/ptdump/segment_regs.c
@@ -55,10 +55,8 @@ static const struct file_operations sr_fops = {
 
 static int __init sr_init(void)
 {
-	struct dentry *debugfs_file;
-
-	debugfs_file = debugfs_create_file("segment_registers", 0400,
-					   powerpc_debugfs_root, NULL, &sr_fops);
-	return debugfs_file ? 0 : -ENOMEM;
+	debugfs_create_file("segment_registers", 0400, powerpc_debugfs_root,
+			    NULL, &sr_fops);
+	return 0;
 }
 device_initcall(sr_init);
-- 
2.25.0

