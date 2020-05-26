Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C69C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 837C52068D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 13:41:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388955AbgEZNlR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 09:41:17 -0400
Received: from foss.arm.com ([217.140.110.172]:50950 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388814AbgEZNlP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 09:41:15 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C05BE106F;
        Tue, 26 May 2020 06:41:14 -0700 (PDT)
Received: from melchizedek.cambridge.arm.com (melchizedek.cambridge.arm.com [10.1.196.50])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4C0403F6C4;
        Tue, 26 May 2020 06:41:13 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        James Morse <james.morse@arm.com>
Subject: [PATCH v4 03/10] x86/resctrl: Fix stale comment
Date:   Tue, 26 May 2020 14:40:52 +0100
Message-Id: <20200526134059.1690-4-james.morse@arm.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20200526134059.1690-1-james.morse@arm.com>
References: <20200526134059.1690-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment in rdtgroup_init() refers to the non existent function
rdt_mount(), which has now been renamed rdt_get_tree(). Fix the
comment.

Signed-off-by: James Morse <james.morse@arm.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index d7cb5ab0d1f0..24bdb52446aa 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -3195,7 +3195,7 @@ int __init rdtgroup_init(void)
 	 * It may also be ok since that would enable debugging of RDT before
 	 * resctrl is mounted.
 	 * The reason why the debugfs directory is created here and not in
-	 * rdt_mount() is because rdt_mount() takes rdtgroup_mutex and
+	 * rdt_get_tree() is because rdt_get_tree() takes rdtgroup_mutex and
 	 * during the debugfs directory creation also &sb->s_type->i_mutex_key
 	 * (the lockdep class of inode->i_rwsem). Other filesystem
 	 * interactions (eg. SyS_getdents) have the lock ordering:
-- 
2.19.1

