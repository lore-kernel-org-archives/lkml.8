Return-Path: <SRS0=6uoK=35=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9548C35250
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E95120733
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Feb 2020 12:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581253027;
	bh=GZDs+2I8Zu/fkAf+zMYTdMQ6mWpB0sh+HmrhjqeNZpg=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=B+UEw2+7gvCFnzlTxGu0ZVAhz1cx12RoVX6TBLkjzO8LlgVVHyH5EDmCA/vy/GXB3
	 YspMx0fBDgz/bLRPT313gfOK0NeYtZSAhTX/O/Wf1DQD67S2Ye6IJV9zUvbrxfXqq8
	 oBBULW6w3259vRRTMRO+3fKefEZDCqOOgJCvfOrw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgBIM5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Feb 2020 07:57:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:44988 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727514AbgBIM5G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Feb 2020 07:57:06 -0500
Received: from localhost (unknown [38.98.37.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA792081E;
        Sun,  9 Feb 2020 12:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581253025;
        bh=GZDs+2I8Zu/fkAf+zMYTdMQ6mWpB0sh+HmrhjqeNZpg=;
        h=From:To:Cc:Subject:Date:From;
        b=ZGX16Twk8Pz+EE4u2eqM+8EbdYsiuKKWGuWzdgzHlY/QQnjZQL9WZkAWA82l8Z6Lp
         W8C4yqkbHO2YyaSjMg73C/hyrhcqKWcc1XFA/1s5M84U4XWSIR3hCWYE0/58Wbwnv7
         SZtwray3/cEojve2FxyFkSS3YwBTrLoGbgTQpFaA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Hari Bathini <hbathini@linux.ibm.com>
Subject: [PATCH 1/6] powerpc: kernel: no need to check return value of debugfs_create functions
Date:   Sun,  9 Feb 2020 11:58:56 +0100
Message-Id: <20200209105901.1620958-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
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
Cc: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/fadump.c       |  9 ++-------
 arch/powerpc/kernel/setup-common.c |  3 +--
 arch/powerpc/kernel/traps.c        | 25 +++++--------------------
 3 files changed, 8 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/kernel/fadump.c b/arch/powerpc/kernel/fadump.c
index ff0114aeba9b..b83fa42c19e1 100644
--- a/arch/powerpc/kernel/fadump.c
+++ b/arch/powerpc/kernel/fadump.c
@@ -1432,7 +1432,6 @@ DEFINE_SHOW_ATTRIBUTE(fadump_region);
 
 static void fadump_init_files(void)
 {
-	struct dentry *debugfs_file;
 	int rc = 0;
 
 	rc = sysfs_create_file(kernel_kobj, &fadump_attr.attr);
@@ -1445,12 +1444,8 @@ static void fadump_init_files(void)
 		printk(KERN_ERR "fadump: unable to create sysfs file"
 			" fadump_registered (%d)\n", rc);
 
-	debugfs_file = debugfs_create_file("fadump_region", 0444,
-					powerpc_debugfs_root, NULL,
-					&fadump_region_fops);
-	if (!debugfs_file)
-		printk(KERN_ERR "fadump: unable to create debugfs file"
-				" fadump_region\n");
+	debugfs_create_file("fadump_region", 0444, powerpc_debugfs_root, NULL,
+			    &fadump_region_fops);
 
 	if (fw_dump.dump_active) {
 		rc = sysfs_create_file(kernel_kobj, &fadump_release_attr.attr);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 7f8c890360fe..f9c0d888ce8a 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -787,8 +787,7 @@ EXPORT_SYMBOL(powerpc_debugfs_root);
 static int powerpc_debugfs_init(void)
 {
 	powerpc_debugfs_root = debugfs_create_dir("powerpc", NULL);
-
-	return powerpc_debugfs_root == NULL;
+	return 0;
 }
 arch_initcall(powerpc_debugfs_init);
 #endif
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 82a3438300fd..3fca22276bb1 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -2278,35 +2278,20 @@ void ppc_warn_emulated_print(const char *type)
 
 static int __init ppc_warn_emulated_init(void)
 {
-	struct dentry *dir, *d;
+	struct dentry *dir;
 	unsigned int i;
 	struct ppc_emulated_entry *entries = (void *)&ppc_emulated;
 
-	if (!powerpc_debugfs_root)
-		return -ENODEV;
-
 	dir = debugfs_create_dir("emulated_instructions",
 				 powerpc_debugfs_root);
-	if (!dir)
-		return -ENOMEM;
 
-	d = debugfs_create_u32("do_warn", 0644, dir,
-			       &ppc_warn_emulated);
-	if (!d)
-		goto fail;
+	debugfs_create_u32("do_warn", 0644, dir, &ppc_warn_emulated);
 
-	for (i = 0; i < sizeof(ppc_emulated)/sizeof(*entries); i++) {
-		d = debugfs_create_u32(entries[i].name, 0644, dir,
-				       (u32 *)&entries[i].val.counter);
-		if (!d)
-			goto fail;
-	}
+	for (i = 0; i < sizeof(ppc_emulated)/sizeof(*entries); i++)
+		debugfs_create_u32(entries[i].name, 0644, dir,
+				   (u32 *)&entries[i].val.counter);
 
 	return 0;
-
-fail:
-	debugfs_remove_recursive(dir);
-	return -ENOMEM;
 }
 
 device_initcall(ppc_warn_emulated_init);
-- 
2.25.0

