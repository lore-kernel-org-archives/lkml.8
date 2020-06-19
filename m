Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8017CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AC95207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733058AbgFSOIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:08:06 -0400
Received: from mga06.intel.com ([134.134.136.31]:54745 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732957AbgFSOHx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:07:53 -0400
IronPort-SDR: GHkbpMjzvIypzssKIYmk6G+sMvpYQGNDh1ZP4lROhUwbSQE+AoOso1L1K6Xs323sBJpsm1pEAq
 teHhFt+3KZqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9656"; a="204452835"
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="204452835"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2020 07:07:52 -0700
IronPort-SDR: 06J1HOVQ2GSMi/POoRyDuuwUcnu0CcZ01G9eNXCYwj8KhB9UGvQ82UPnSRpol7se8roWwQHJJe
 uYr5kueH/vig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,255,1589266800"; 
   d="scan'208";a="383837449"
Received: from otc-lr-04.jf.intel.com ([10.54.39.143])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jun 2020 07:07:51 -0700
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        tglx@linutronix.de, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, namhyung@kernel.org, dave.hansen@intel.com,
        yu-cheng.yu@intel.com, bigeasy@linutronix.de, gorcunov@gmail.com,
        hpa@zytor.com, alexey.budankov@linux.intel.com, eranian@google.com,
        ak@linux.intel.com, like.xu@linux.intel.com,
        yao.jin@linux.intel.com, Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 08/21] x86/msr-index: Add bunch of MSRs for Arch LBR
Date:   Fri, 19 Jun 2020 07:03:56 -0700
Message-Id: <1592575449-64278-9-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
References: <1592575449-64278-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Add Arch LBR related MSRs in MSR-index.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/include/asm/msr-index.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 12c9684..7b7d82f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -156,6 +156,26 @@
 #define LBR_INFO_ABORT			BIT_ULL(61)
 #define LBR_INFO_CYCLES			0xffff
 
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
+#define ARCH_LBR_INFO_MISPRED		BIT_ULL(63)
+#define ARCH_LBR_INFO_IN_TSX		BIT_ULL(62)
+#define ARCH_LBR_INFO_TSX_ABORT		BIT_ULL(61)
+#define ARCH_LBR_INFO_CYC_CNT_VALID	BIT_ULL(60)
+#define ARCH_LBR_INFO_BR_TYPE_OFFSET	56
+#define ARCH_LBR_INFO_BR_TYPE		(0xfull << ARCH_LBR_INFO_BR_TYPE_OFFSET)
+#define ARCH_LBR_INFO_CYC_CNT		0xffff
+
 #define MSR_IA32_PEBS_ENABLE		0x000003f1
 #define MSR_PEBS_DATA_CFG		0x000003f2
 #define MSR_IA32_DS_AREA		0x00000600
-- 
2.7.4

