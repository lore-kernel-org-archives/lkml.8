Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB50C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56A242073D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 16:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729165AbgATQrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 11:47:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33645 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbgATQrS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 11:47:18 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1itaCm-000438-81; Mon, 20 Jan 2020 17:47:12 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C22301C1A41;
        Mon, 20 Jan 2020 17:47:11 +0100 (CET)
Date:   Mon, 20 Jan 2020 16:47:11 -0000
From:   "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Clean up unused function parameter in
 mkdir path
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1578500886-21771-5-git-send-email-xiaochen.shen@intel.com>
References: <1578500886-21771-5-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Message-ID: <157953883153.396.9276824335957965312.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     32ada3b9e04c6f6d4916967bd8bbe2450ad5bc5e
Gitweb:        https://git.kernel.org/tip/32ada3b9e04c6f6d4916967bd8bbe2450ad5bc5e
Author:        Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate:    Thu, 09 Jan 2020 00:28:06 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 20 Jan 2020 17:00:41 +01:00

x86/resctrl: Clean up unused function parameter in mkdir path

Commit

  334b0f4e9b1b ("x86/resctrl: Fix a deadlock due to inaccurate reference")

changed the argument to rdtgroup_kn_lock_live()/rdtgroup_kn_unlock()
within mkdir_rdt_prepare(). That change resulted in an unused function
parameter to mkdir_rdt_prepare().

Clean up the unused function parameter in mkdir_rdt_prepare() and its
callers rdtgroup_mkdir_mon() and rdtgroup_mkdir_ctrl_mon().

Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1578500886-21771-5-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 954fd04..2804562 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -2644,7 +2644,6 @@ static int rdtgroup_init_alloc(struct rdtgroup *rdtgrp)
 }
 
 static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
-			     struct kernfs_node *prgrp_kn,
 			     const char *name, umode_t mode,
 			     enum rdt_group_type rtype, struct rdtgroup **r)
 {
@@ -2754,15 +2753,12 @@ static void mkdir_rdt_prepare_clean(struct rdtgroup *rgrp)
  * to monitor a subset of tasks and cpus in its parent ctrl_mon group.
  */
 static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
-			      struct kernfs_node *prgrp_kn,
-			      const char *name,
-			      umode_t mode)
+			      const char *name, umode_t mode)
 {
 	struct rdtgroup *rdtgrp, *prgrp;
 	int ret;
 
-	ret = mkdir_rdt_prepare(parent_kn, prgrp_kn, name, mode, RDTMON_GROUP,
-				&rdtgrp);
+	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTMON_GROUP, &rdtgrp);
 	if (ret)
 		return ret;
 
@@ -2784,7 +2780,6 @@ static int rdtgroup_mkdir_mon(struct kernfs_node *parent_kn,
  * to allocate and monitor resources.
  */
 static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
-				   struct kernfs_node *prgrp_kn,
 				   const char *name, umode_t mode)
 {
 	struct rdtgroup *rdtgrp;
@@ -2792,8 +2787,7 @@ static int rdtgroup_mkdir_ctrl_mon(struct kernfs_node *parent_kn,
 	u32 closid;
 	int ret;
 
-	ret = mkdir_rdt_prepare(parent_kn, prgrp_kn, name, mode, RDTCTRL_GROUP,
-				&rdtgrp);
+	ret = mkdir_rdt_prepare(parent_kn, name, mode, RDTCTRL_GROUP, &rdtgrp);
 	if (ret)
 		return ret;
 
@@ -2867,14 +2861,14 @@ static int rdtgroup_mkdir(struct kernfs_node *parent_kn, const char *name,
 	 * subdirectory
 	 */
 	if (rdt_alloc_capable && parent_kn == rdtgroup_default.kn)
-		return rdtgroup_mkdir_ctrl_mon(parent_kn, parent_kn, name, mode);
+		return rdtgroup_mkdir_ctrl_mon(parent_kn, name, mode);
 
 	/*
 	 * If RDT monitoring is supported and the parent directory is a valid
 	 * "mon_groups" directory, add a monitoring subdirectory.
 	 */
 	if (rdt_mon_capable && is_mon_groups(parent_kn, name))
-		return rdtgroup_mkdir_mon(parent_kn, parent_kn->parent, name, mode);
+		return rdtgroup_mkdir_mon(parent_kn, name, mode);
 
 	return -EPERM;
 }
