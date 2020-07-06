Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04B18C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:39:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCAB9206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbgGFNj5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:39:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52978 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729133AbgGFNj5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:39:57 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EA76D61F1028F2C7B9E9;
        Mon,  6 Jul 2020 21:39:41 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 21:39:31 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Qais Yousef <qais.yousef@arm.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] smp: Make symbol 'csd_bug_count' static
Date:   Mon, 6 Jul 2020 21:49:41 +0800
Message-ID: <20200706134941.80472-1-weiyongjun1@huawei.com>
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

The sparse tool complains as follows

kernel/smp.c:107:10: warning:
 symbol 'csd_bug_count' was not declared. Should it be static?

This variable is not used outside of smp.c, s this commit marks
it static.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 6ec6c9578225..65822c1c3e67 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -104,7 +104,7 @@ void __init call_function_init(void)
 }
 
 #define CSD_LOCK_TIMEOUT (5 * 1000ULL) /* Milliseconds. */
-atomic_t csd_bug_count = ATOMIC_INIT(0);
+static atomic_t csd_bug_count = ATOMIC_INIT(0);
 
 /* Record current CSD work for current CPU, NULL to erase. */
 static void csd_lock_record(call_single_data_t *csd)

