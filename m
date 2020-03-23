Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F66C4332B
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD3DC2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 09:22:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgCWJWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:22:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:24184 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbgCWJWj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 05:22:39 -0400
IronPort-SDR: k80O12gl9ZmleMzebJ7i65jnN96s7xZtTZ6/oBwxLOOsqPTDJF21i67WIrCbJzEDGXLse9DqjI
 Br8ZJIXwcoAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 02:22:37 -0700
IronPort-SDR: RhJ5hieVCYUCJbFJYb6x+p0rqKHXTvL9ZT8VPk037JG8vrByh6vuzmSJlQU9YtVSol7DT0me2B
 mTsK+GRcwg/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,295,1580803200"; 
   d="scan'208";a="445744294"
Received: from jieliu-mobl1.ccr.corp.intel.com (HELO dell-xps.ccr.corp.intel.com) ([10.255.31.30])
  by fmsmga005.fm.intel.com with ESMTP; 23 Mar 2020 02:22:36 -0700
From:   Zhenyu Wang <zhenyuw@linux.intel.com>
To:     pbonzini@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: x86: Expose fast short REP MOV for supported cpuid
Date:   Mon, 23 Mar 2020 17:22:36 +0800
Message-Id: <20200323092236.3703-1-zhenyuw@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For CPU supporting fast short REP MOV (XF86_FEATURE_FSRM) e.g Icelake,
Tigerlake, expose it in KVM supported cpuid as well.

Signed-off-by: Zhenyu Wang <zhenyuw@linux.intel.com>
---
 arch/x86/kvm/cpuid.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 435a7da07d5f..cf6da12bd17a 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -338,7 +338,7 @@ void kvm_set_cpu_caps(void)
 	kvm_cpu_cap_mask(CPUID_7_EDX,
 		F(AVX512_4VNNIW) | F(AVX512_4FMAPS) | F(SPEC_CTRL) |
 		F(SPEC_CTRL_SSBD) | F(ARCH_CAPABILITIES) | F(INTEL_STIBP) |
-		F(MD_CLEAR) | F(AVX512_VP2INTERSECT)
+		F(MD_CLEAR) | F(AVX512_VP2INTERSECT) | F(FSRM)
 	);
 
 	/* TSC_ADJUST and ARCH_CAPABILITIES are emulated in software. */
-- 
2.25.1

