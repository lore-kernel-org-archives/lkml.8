Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A33C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B054820714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 16:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbgCQQ0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 12:26:53 -0400
Received: from mga17.intel.com ([192.55.52.151]:60668 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726082AbgCQQ0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 12:26:53 -0400
IronPort-SDR: wxM5gfHesnbqJyCURgpd/4lOq+yGbC4GIcGGOLobnUF8NbMzyvumHBs88jhFS6lqUt4t0BDD8t
 XPM/DJpD4jeQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:26:52 -0700
IronPort-SDR: 5sJQC8mpecwiXgdj9P9ed5N2YqvExySFjwF6A6vuCxy0XtwABcdBjxLZRM95CuAtsPEOiSVE/W
 z9Aoh8NsX2QA==
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="443814680"
Received: from rchatre-s.jf.intel.com ([10.54.70.76])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 09:26:52 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     tglx@linutronix.de, fenghua.yu@intel.com, bp@alien8.de,
        tony.luck@intel.com
Cc:     mingo@redhat.com, hpa@zytor.com, kuo-lang.tseng@intel.com,
        xiaochen.shen@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        stable@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH] x86/resctrl: Fix invalid attempt at removing default resource group
Date:   Tue, 17 Mar 2020 09:26:45 -0700
Message-Id: <884cbe1773496b5dbec1b6bd11bb50cffa83603d.1584461853.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default resource group ("rdtgroup_default") is associated with the
root of the resctrl filesystem and should never be removed. New resource
groups can be created as subdirectories of the resctrl filesystem and
they can be removed from user space. There exists a safeguard in the
directory removal code (rdtgroup_rmdir()) that ensures that only
subdirectories can be removed by testing that the directory to be
removed has to be a child of the root directory.

A possible deadlock was recently fixed with commit 334b0f4e9b1b
("x86/resctrl: Fix a deadlock due to inaccurate reference"). This fix
involved associating the private data of the "mon_groups" and "mon_data"
directories to the resource group to which they belong instead of NULL
as before. A consequence of this change was that the original safeguard
code preventing removal of "mon_groups" and "mon_data" found in the root
directory failed resulting in attempts to remove the default resource
group that ends in a BUG:

kernel BUG at mm/slub.c:3969!
invalid opcode: 0000 [#1] SMP PTI

Call Trace:
rdtgroup_rmdir+0x16b/0x2c0
kernfs_iop_rmdir+0x5c/0x90
vfs_rmdir+0x7a/0x160
do_rmdir+0x17d/0x1e0
do_syscall_64+0x55/0x1d0
entry_SYSCALL_64_after_hwframe+0x44/0xa9

Fix this by improving the directory removal safeguard to ensure that
subdirectories of the resctrl root directory can only be removed if
they are a child of the resctrl filesystem's root _and_ not associated
with the default resource group.

Fixes: 334b0f4e9b1b ("x86/resctrl: Fix a deadlock due to inaccurate reference")
Cc: stable@vger.kernel.org
Reported-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Tested-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 064e9ef44cd6..9d4e73a9b5a9 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3072,7 +3072,8 @@ static int rdtgroup_rmdir(struct kernfs_node *kn)
 	 * If the rdtgroup is a mon group and parent directory
 	 * is a valid "mon_groups" directory, remove the mon group.
 	 */
-	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn) {
+	if (rdtgrp->type == RDTCTRL_GROUP && parent_kn == rdtgroup_default.kn &&
+	    rdtgrp != &rdtgroup_default) {
 		if (rdtgrp->mode == RDT_MODE_PSEUDO_LOCKSETUP ||
 		    rdtgrp->mode == RDT_MODE_PSEUDO_LOCKED) {
 			ret = rdtgroup_ctrl_remove(kn, rdtgrp);
-- 
2.21.0

