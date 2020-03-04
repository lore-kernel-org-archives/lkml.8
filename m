Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E86C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:20:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A2620705
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:20:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729114AbgCDJUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:20:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728953AbgCDJUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:20:16 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j9QCJ-0007fz-7g; Wed, 04 Mar 2020 10:20:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D1B151C21B0;
        Wed,  4 Mar 2020 10:20:10 +0100 (CET)
Date:   Wed, 04 Mar 2020 09:20:10 -0000
From:   "tip-bot2 for Wen Yang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Cast explicitely to u32t in __ktime_divns()
Cc:     Wen Yang <wenyang@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200130130851.29204-1-wenyang@linux.alibaba.com>
References: <20200130130851.29204-1-wenyang@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <158331361059.28353.6154145435691851897.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     38f7b0b1316d435f38ec3f2bb078897b7a1cfdea
Gitweb:        https://git.kernel.org/tip/38f7b0b1316d435f38ec3f2bb078897b7a1cfdea
Author:        Wen Yang <wenyang@linux.alibaba.com>
AuthorDate:    Thu, 30 Jan 2020 21:08:51 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 04 Mar 2020 10:17:51 +01:00

hrtimer: Cast explicitely to u32t in __ktime_divns()

do_div() does a 64-by-32 division at least on 32bit platforms, while the
divisor 'div' is explicitly casted to unsigned long, thus 64-bit on 64-bit
platforms.

The code already ensures that the divisor is less than 2^32. Hence the
proper cast type is u32.

Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200130130851.29204-1-wenyang@linux.alibaba.com

---
 kernel/time/hrtimer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3a609e7..d74fdcd 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -311,7 +311,7 @@ s64 __ktime_divns(const ktime_t kt, s64 div)
 		div >>= 1;
 	}
 	tmp >>= sft;
-	do_div(tmp, (unsigned long) div);
+	do_div(tmp, (u32) div);
 	return dclc < 0 ? -tmp : tmp;
 }
 EXPORT_SYMBOL_GPL(__ktime_divns);
