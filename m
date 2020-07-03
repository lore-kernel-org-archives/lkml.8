Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90CFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A65A520CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgGCMxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:53:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:25737 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgGCMxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:53:39 -0400
IronPort-SDR: MZG/MuXnQL8zCKngamNY/y2EVPrHHnQd1WdiVI9NHp0IDHSzxKK5acDpKvEqhfM0kAruTwOV1j
 aOsszT4X/bUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="134598379"
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="134598379"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 05:53:38 -0700
IronPort-SDR: VhssFHKJyNeB50G5kYaIzZVgQp8fRLUNKEXdnDcAtXxa3IwzUTYGt+hmdxvsvQJIrT4eFa4tyJ
 gHxwR4lqPBiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,308,1589266800"; 
   d="scan'208";a="265964005"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga007.fm.intel.com with ESMTP; 03 Jul 2020 05:53:38 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, wei.w.wang@intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH V3 11/23] perf/x86/intel/lbr: Mark the {rd,wr}lbr_{to,from} wrappers __always_inline
Date:   Fri,  3 Jul 2020 05:49:17 -0700
Message-Id: <1593780569-62993-12-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

The {rd,wr}lbr_{to,from} wrappers are invoked in hot paths, e.g. context
switch and NMI handler. They should be always inline to achieve better
performance. However, the CONFIG_OPTIMIZE_INLINING allows the compiler
to uninline functions marked 'inline'.

Mark the {rd,wr}lbr_{to,from} wrappers as __always_inline to force
inline the wrappers.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/intel/lbr.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 815b3ce..e3574a8 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -332,18 +332,18 @@ static u64 lbr_from_signext_quirk_rd(u64 val)
 	return val;
 }
 
-static inline void wrlbr_from(unsigned int idx, u64 val)
+static __always_inline void wrlbr_from(unsigned int idx, u64 val)
 {
 	val = lbr_from_signext_quirk_wr(val);
 	wrmsrl(x86_pmu.lbr_from + idx, val);
 }
 
-static inline void wrlbr_to(unsigned int idx, u64 val)
+static __always_inline void wrlbr_to(unsigned int idx, u64 val)
 {
 	wrmsrl(x86_pmu.lbr_to + idx, val);
 }
 
-static inline u64 rdlbr_from(unsigned int idx)
+static __always_inline u64 rdlbr_from(unsigned int idx)
 {
 	u64 val;
 
@@ -352,7 +352,7 @@ static inline u64 rdlbr_from(unsigned int idx)
 	return lbr_from_signext_quirk_rd(val);
 }
 
-static inline u64 rdlbr_to(unsigned int idx)
+static __always_inline u64 rdlbr_to(unsigned int idx)
 {
 	u64 val;
 
-- 
2.7.4

