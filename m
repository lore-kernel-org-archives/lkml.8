Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE70C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01A4C206F5
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgGFNjU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:39:20 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:52476 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729160AbgGFNjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:39:20 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 94431C96B0A586C9ED94;
        Mon,  6 Jul 2020 21:39:16 +0800 (CST)
Received: from kernelci-master.huawei.com (10.175.101.6) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Mon, 6 Jul 2020 21:39:09 +0800
From:   Wei Yongjun <weiyongjun1@huawei.com>
To:     Hulk Robot <hulkci@huawei.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Xu <peterx@redhat.com>
CC:     Wei Yongjun <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] smp: Fix unused-but-set-variable warning
Date:   Mon, 6 Jul 2020 21:49:19 +0800
Message-ID: <20200706134919.80407-1-weiyongjun1@huawei.com>
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

Gcc report build warning as follows:

kernel/smp.c:126:15: warning:
 variable 'csd_type' set but not used [-Wunused-but-set-variable]
  126 |  unsigned int csd_type;
      |               ^~~~~~~~

'csd_type' is only used when CONFIG_64BIT defined, so move them
under '#ifdef'.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 kernel/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index 6ec6c9578225..0130bdcf6d26 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -123,10 +123,10 @@ static void csd_lock_record(call_single_data_t *csd)
 
 static __always_inline int csd_lock_wait_getcpu(call_single_data_t *csd)
 {
+#ifdef CONFIG_64BIT
 	unsigned int csd_type;
 
 	csd_type = CSD_TYPE(csd);
-#ifdef CONFIG_64BIT
 	if (csd_type == CSD_TYPE_ASYNC || csd_type == CSD_TYPE_SYNC)
 		return csd->dst; // Other CSD_TYPE_ values might not have ->dst.
 #endif

