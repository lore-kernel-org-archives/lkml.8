Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E0C9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57A1C207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728535AbgEVDhj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:37:39 -0400
Received: from mail.windriver.com ([147.11.1.11]:58649 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgEVDhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:37:36 -0400
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com [147.11.189.41])
        by mail.windriver.com (8.15.2/8.15.2) with ESMTPS id 04M3bUlM018958
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 20:37:31 -0700 (PDT)
Received: from pek-lpg-core1-vm1.wrs.com (128.224.156.106) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.487.0; Thu, 21 May 2020 20:37:26 -0700
From:   <qiang.zhang@windriver.com>
To:     <linux-kernel@vger.kernel.org>
Subject: [PATCH] kernel/hung_task: Use task_pid_nr function to get pid
Date:   Fri, 22 May 2020 11:46:09 +0800
Message-ID: <20200522034609.2048-1-qiang.zhang@windriver.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Qiang <qiang.zhang@windriver.com>

Use task_pid_nr(t) function instead of t->pid when printing
task pid

Signed-off-by: Zhang Qiang <qiang.zhang@windriver.com>
---
 kernel/hung_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index 14a625c16cb3..f397beb8c9e1 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -128,7 +128,7 @@ static void check_hung_task(struct task_struct *t, unsigned long timeout)
 		if (sysctl_hung_task_warnings > 0)
 			sysctl_hung_task_warnings--;
 		pr_err("INFO: task %s:%d blocked for more than %ld seconds.\n",
-		       t->comm, t->pid, (jiffies - t->last_switch_time) / HZ);
+		       t->comm, task_pid_nr(t), (jiffies - t->last_switch_time) / HZ);
 		pr_err("      %s %s %.*s\n",
 			print_tainted(), init_utsname()->release,
 			(int)strcspn(init_utsname()->version, " "),
-- 
2.24.1

