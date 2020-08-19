Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D46C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E0AF206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DS+M9xQF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwnnw3fQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725997AbgHSI4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgHSIxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:53:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B259C061346;
        Wed, 19 Aug 2020 01:52:12 -0700 (PDT)
Date:   Wed, 19 Aug 2020 08:52:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597827130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6CFsOUoNTluhfglb0v5+LmkpgxLObqsXne93Y1Feuo=;
        b=DS+M9xQFtnTV+CZgGdKkLr4Jn8NV7KfAV0Kyw7R7PNAytocOsXuYEdUEdHHnNmHrj4DpMC
        X2ND3xYqqJfa8pMB2iiZWPSkPV7aA9s3sK2oDJ/73HMzArP1j8dfN+aMNZHaWpzBYciUqz
        pXB0b2WDavBL1DC899+EzKllGX3HY1eXxyFJl0u0R8zbDjvkWRH580UNFx1RexVgmd9BnR
        ih1e1c2PihB7m0fSE92VSsV0qK0QxoaPiIXu3x/Fd/5/xYbOKeBb4lYn9AzYxTb/M1J3+o
        aen1lumKRTQWihKYo/mbD+EvcIYl7U4mle49OfmMwykPBSgYBvmQS3YfYl8OvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597827130;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Q6CFsOUoNTluhfglb0v5+LmkpgxLObqsXne93Y1Feuo=;
        b=wwnnw3fQP87jZBSg2wFImOgIuErzCUC9MaGrHj3OHdPIQkYDr/Z/AfNKUHiMcnyBPzc5t5
        AwMdQxAscHJTabDA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Move BTS index to 47
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200723171117.9918-5-kan.liang@linux.intel.com>
References: <20200723171117.9918-5-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159782712960.3192.1851522875229637809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d39fcc32893dac2d02900d99c38276a00cc54d60
Gitweb:        https://git.kernel.org/tip/d39fcc32893dac2d02900d99c38276a00cc54d60
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 23 Jul 2020 10:11:07 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Aug 2020 16:34:35 +02:00

perf/x86/intel: Move BTS index to 47

The bit 48 in the PERF_GLOBAL_STATUS is used to indicate the overflow
status of the PERF_METRICS counters.

Move the BTS index to the bit 47.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200723171117.9918-5-kan.liang@linux.intel.com
---
 arch/x86/include/asm/perf_event.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index fe8110a..58419e5 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -238,11 +238,11 @@ struct x86_pmu_capability {
 /*
  * We model BTS tracing as another fixed-mode PMC.
  *
- * We choose a value in the middle of the fixed event range, since lower
+ * We choose the value 47 for the fixed index of BTS, since lower
  * values are used by actual fixed events and higher values are used
  * to indicate other overflow conditions in the PERF_GLOBAL_STATUS msr.
  */
-#define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 16)
+#define INTEL_PMC_IDX_FIXED_BTS			(INTEL_PMC_IDX_FIXED + 15)
 
 #define GLOBAL_STATUS_COND_CHG			BIT_ULL(63)
 #define GLOBAL_STATUS_BUFFER_OVF_BIT		62
