Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7498DC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56B622070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbgCFJ2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:28:01 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:34148 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgCFJ2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:28:01 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 531A4C252A699F9FD0B1;
        Fri,  6 Mar 2020 17:27:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.439.0; Fri, 6 Mar 2020
 17:27:52 +0800
From:   Cheng Jian <cj.chengjian@huawei.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <cj.chengjian@huawei.com>, <huawei.libin@huawei.com>,
        <xiexiuqi@huawei.com>, <bobo.shaobowang@huawei.com>,
        <naveen.n.rao@linux.ibm.com>, <anil.s.keshavamurthy@intel.com>,
        <davem@davemloft.net>, <mhiramat@kernel.org>
Subject: [PATCH] kretprobe: check re-registration of the same kretprobe earlier
Date:   Fri, 6 Mar 2020 17:35:06 +0800
Message-ID: <1583487306-81985-1-git-send-email-cj.chengjian@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Our system encountered a use-after-free when re-register a
same kretprobe. it access the hlist node in rp->free_instances
which has been released already.

Prevent re-registration has been implemented for kprobe before,
but it's too late for kretprobe. We must check the re-registration
before re-initializing the kretprobe, otherwise it will destroy the
data and struct of the kretprobe registered, it can lead to memory
leak and use-after-free.

Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
---
 kernel/kprobes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 2625c24..f1fc921 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1946,6 +1946,11 @@ int register_kretprobe(struct kretprobe *rp)
 		}
 	}
 
+	/* Return error if it's being re-registered */
+	ret = check_kprobe_rereg(&rp->kp);
+	if (ret)
+		return ret;
+
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
 	rp->kp.fault_handler = NULL;
-- 
2.7.4

