Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1CEEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99A6A20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 11:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728776AbgGBLo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 07:44:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:57680 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727016AbgGBLo5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 07:44:57 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2A7A9ED5C325D3C76CEC;
        Thu,  2 Jul 2020 19:44:54 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Thu, 2 Jul 2020 19:44:47 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] kcov: make some symbols static
Date:   Thu, 2 Jul 2020 19:55:01 +0800
Message-ID: <20200702115501.73077-1-weiyongjun1@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix sparse build warnings:

kernel/kcov.c:99:1: warning:
 symbol '__pcpu_scope_kcov_percpu_data' was not declared. Should it be static?
kernel/kcov.c:778:6: warning:
 symbol 'kcov_remote_softirq_start' was not declared. Should it be static?
kernel/kcov.c:795:6: warning:
 symbol 'kcov_remote_softirq_stop' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/kcov.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 6afae0bcbac4..6b8368be89c8 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -96,7 +96,7 @@ struct kcov_percpu_data {
 	int			saved_sequence;
 };
 
-DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
+static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data);
 
 /* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_find(u64 handle)
@@ -775,7 +775,7 @@ static inline bool kcov_mode_enabled(unsigned int mode)
 	return (mode & ~KCOV_IN_CTXSW) != KCOV_MODE_DISABLED;
 }
 
-void kcov_remote_softirq_start(struct task_struct *t)
+static void kcov_remote_softirq_start(struct task_struct *t)
 {
 	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
 	unsigned int mode;
@@ -792,7 +792,7 @@ void kcov_remote_softirq_start(struct task_struct *t)
 	}
 }
 
-void kcov_remote_softirq_stop(struct task_struct *t)
+static void kcov_remote_softirq_stop(struct task_struct *t)
 {
 	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
 

