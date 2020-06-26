Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDEAFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADADA20836
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 18:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726507AbgFZSYu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 14:24:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:59785 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgFZSXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 14:23:37 -0400
IronPort-SDR: 0kAMg/S/TPGDtqTLisiNXAiGLwUL/ut2whrsx0tAkvrJUdl40eGCjikBW/iBDKhLSEv+s2tTOr
 RPD626D2PH7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9664"; a="210512901"
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="210512901"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2020 11:23:34 -0700
IronPort-SDR: 8Uhk8gAeu+jzA16CD59lxFW9RH0EmWUfLd6/r/m7yXrKSv0nTXK+TFfmVuDQKcmUdNElksj/LQ
 xUL8arHPQohQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,284,1589266800"; 
   d="scan'208";a="424153853"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by orsmga004.jf.intel.com with ESMTP; 26 Jun 2020 11:23:34 -0700
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
Subject: [PATCH V2 07/23] x86/msr-index: Add bunch of MSRs for Arch LBR
Date:   Fri, 26 Jun 2020 11:20:04 -0700
Message-Id: <1593195620-116988-8-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
References: <1593195620-116988-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add Arch LBR related MSRs and the new LBR INFO bits in MSR-index.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e8370e6..bdc07fc 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -158,7 +158,23 @@
 #define LBR_INFO_MISPRED		BIT_ULL(63)
 #define LBR_INFO_IN_TX			BIT_ULL(62)
 #define LBR_INFO_ABORT			BIT_ULL(61)
+#define LBR_INFO_CYC_CNT_VALID		BIT_ULL(60)
 #define LBR_INFO_CYCLES			0xffff
+#define LBR_INFO_BR_TYPE_OFFSET		56
+#define LBR_INFO_BR_TYPE		(0xfull << LBR_INFO_BR_TYPE_OFFSET)
+
+#define MSR_ARCH_LBR_CTL		0x000014ce
+#define ARCH_LBR_CTL_LBREN		BIT(0)
+#define ARCH_LBR_CTL_CPL_OFFSET		1
+#define ARCH_LBR_CTL_CPL		(0x3ull << ARCH_LBR_CTL_CPL_OFFSET)
+#define ARCH_LBR_CTL_STACK_OFFSET	3
+#define ARCH_LBR_CTL_STACK		(0x1ull << ARCH_LBR_CTL_STACK_OFFSET)
+#define ARCH_LBR_CTL_FILTER_OFFSET	16
+#define ARCH_LBR_CTL_FILTER		(0x7full << ARCH_LBR_CTL_FILTER_OFFSET)
+#define MSR_ARCH_LBR_DEPTH		0x000014cf
+#define MSR_ARCH_LBR_FROM_0		0x00001500
+#define MSR_ARCH_LBR_TO_0		0x00001600
+#define MSR_ARCH_LBR_INFO_0		0x00001200
 
 #define MSR_IA32_PEBS_ENABLE		0x000003f1
 #define MSR_PEBS_DATA_CFG		0x000003f2
-- 
2.7.4

