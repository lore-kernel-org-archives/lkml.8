Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2826DC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FAF20727
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:32:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgCINcl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:32:41 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11610 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726427AbgCINcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:32:41 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 24BECA8427454E02611F;
        Mon,  9 Mar 2020 21:32:09 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Mon, 9 Mar 2020
 21:31:59 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>
Subject: [PATCH v2] kretprobe: check re-registration of the same kretprobe earlier
Date:   Mon, 9 Mar 2020 21:39:13 +0800
Message-ID: <1583761153-13876-1-git-send-email-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our system encountered a use-after-free when re-register the same
kretprobe, it access the kretprobe_instance in rp->free_instances
which has been released already.

Prevent re-registration has been implemented for kprobe before, but
it's too late for kretprobe. We must check the re-registration before
re-initializing the kretprobe, otherwise it will destroy the data and
struct of the kretprobe registered, it can lead to use-after-free,
memory leak, system crash, and even other unexpected behaviors.

Use check_kprobe_rereg() to check re-registration, also give a warning
message.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/kprobes.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c24..9cb2a0d 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1946,6 +1946,14 @@ int register_kretprobe(struct kretprobe *rp)
 		}
 	}
 
+	/*
+	 * Return error if it's being re-registered,
+	 * also give a warning message to the developer.
+	 */
+	ret = check_kprobe_rereg(&rp->kp);
+	if (WARN_ON(ret))
+		return ret;
+
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
-- 
2.7.4

