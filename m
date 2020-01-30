Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F33C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:09:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FCCB2082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 13:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgA3NJJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 08:09:09 -0500
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:51125 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726980AbgA3NJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 08:09:08 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TomDHZ2_1580389719;
Received: from localhost(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0TomDHZ2_1580389719)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 30 Jan 2020 21:08:46 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, hpa@zytor.com,
        Ingo Molnar <mingo@redhat.com>
Cc:     Wen Yang <wenyang@linux.alibaba.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tsc: improve arithmetic division
Date:   Thu, 30 Jan 2020 21:08:38 +0800
Message-Id: <20200130130838.29157-1-wenyang@linux.alibaba.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

do_div() does a 64-by-32 division. Use div64_ul64() or div64_ul()
instead of it if the divisor is 'ul64' or 'unsigned long', to avoid
truncation to lower 32-bit.
And as a nice side effect also cleans up the function a bit.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/tsc.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 7e322e2daaf5..4c0320e68699 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -357,9 +357,7 @@ static unsigned long calc_pmtimer_ref(u64 deltatsc, u64 pm1, u64 pm2)
 	pm2 -= pm1;
 	tmp = pm2 * 1000000000LL;
 	do_div(tmp, PMTMR_TICKS_PER_SEC);
-	do_div(deltatsc, tmp);
-
-	return (unsigned long) deltatsc;
+	return (unsigned long) div64_u64(deltatsc, tmp);
 }
 
 #define CAL_MS		10
@@ -778,8 +776,7 @@ static unsigned long pit_hpet_ptimer_calibrate_cpu(void)
 		tsc_ref_min = min(tsc_ref_min, (unsigned long) tsc2);
 
 		/* Check the reference deviation */
-		delta = ((u64) tsc_pit_min) * 100;
-		do_div(delta, tsc_ref_min);
+		delta = div64_ul(((u64) tsc_pit_min) * 100, tsc_ref_min);
 
 		/*
 		 * If both calibration results are inside a 10% window
-- 
2.23.0

