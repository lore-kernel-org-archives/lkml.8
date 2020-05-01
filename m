Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A11BC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE4F32495E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730560AbgEASWQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729599AbgEASWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:22:12 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A28FC061A0E;
        Fri,  1 May 2020 11:22:12 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIY-0003WQ-Ev; Fri, 01 May 2020 20:22:06 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8FC751C0085;
        Fri,  1 May 2020 20:22:05 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:05 -0000
From:   "tip-bot2 for Paul Gortmaker" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/pt: Drop pointless NULL assignment.
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200408235216.108980-1-paul.gortmaker@windriver.com>
References: <20200408235216.108980-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Message-ID: <158835732546.8414.11934148365397136617.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4bd30106ddb26d2304adc5bb7bd269825300440d
Gitweb:        https://git.kernel.org/tip/4bd30106ddb26d2304adc5bb7bd269825300440d
Author:        Paul Gortmaker <paul.gortmaker@windriver.com>
AuthorDate:    Wed, 08 Apr 2020 19:52:16 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:36 +02:00

perf/x86/intel/pt: Drop pointless NULL assignment.

Only a few lines below this removed line is this:

  attrs = kzalloc(size, GFP_KERNEL);

and since there is no code path where this could be avoided, the
NULL assignment is a pointless relic of history and can be removed.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200408235216.108980-1-paul.gortmaker@windriver.com
---
 arch/x86/events/intel/pt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/events/intel/pt.c b/arch/x86/events/intel/pt.c
index 1db7a51..e94af4a 100644
--- a/arch/x86/events/intel/pt.c
+++ b/arch/x86/events/intel/pt.c
@@ -226,8 +226,6 @@ static int __init pt_pmu_hw_init(void)
 			pt_pmu.vmx = true;
 	}
 
-	attrs = NULL;
-
 	for (i = 0; i < PT_CPUID_LEAVES; i++) {
 		cpuid_count(20, i,
 			    &pt_pmu.caps[CPUID_EAX + i*PT_CPUID_REGS_NUM],
