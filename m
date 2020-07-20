Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6168C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865E021775
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 08:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727965AbgGTI0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 04:26:38 -0400
Received: from spam01.hygon.cn ([110.188.70.11]:59526 "EHLO spam2.hygon.cn"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726611AbgGTI0g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 04:26:36 -0400
Received: from MK-DB.hygon.cn ([172.23.18.60])
        by spam2.hygon.cn with ESMTP id 06K8NRZW082690;
        Mon, 20 Jul 2020 16:23:27 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from cncheex01.Hygon.cn ([172.23.18.10])
        by MK-DB.hygon.cn with ESMTP id 06K8NL5A027822;
        Mon, 20 Jul 2020 16:23:21 +0800 (GMT-8)
        (envelope-from puwen@hygon.cn)
Received: from ubuntu1604-2.higon.com (172.23.18.44) by cncheex01.Hygon.cn
 (172.23.18.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1466.3; Mon, 20 Jul
 2020 16:23:06 +0800
From:   Pu Wen <puwen@hygon.cn>
To:     <linux-kernel@vger.kernel.org>
CC:     <peterz@infradead.org>, <mingo@kernel.org>, <jolsa@redhat.com>,
        <bp@alien8.de>, <eranian@google.com>, Pu Wen <puwen@hygon.cn>
Subject: [RFC PATCH RESEND] perf/x86/rapl: Add Hygon Fam18h RAPL support
Date:   Mon, 20 Jul 2020 16:22:05 +0800
Message-ID: <20200720082205.1307-1-puwen@hygon.cn>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.23.18.44]
X-ClientProxiedBy: cncheex02.Hygon.cn (172.23.18.12) To cncheex01.Hygon.cn
 (172.23.18.10)
X-MAIL: spam2.hygon.cn 06K8NRZW082690
X-DNSRBL: 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hygon Family 18h(Dhyana) support RAPL in bit 14 of CPUID 0x80000007 EDX,
and has MSRs RAPL_PWR_UNIT/CORE_ENERGY_STAT/PKG_ENERGY_STAT. So add Hygon
Dhyana Family 18h support for RAPL.

The output is available via the energy-pkg pseudo event:
  $ perf stat -a -I 1000 --per-socket -e power/energy-pkg/

Signed-off-by: Pu Wen <puwen@hygon.cn>
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 0f2bf59f4354..18c69d84b031 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -788,6 +788,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
 	X86_MATCH_VENDOR_FAM(AMD, 0x17, &model_amd_fam17h),
+	X86_MATCH_VENDOR_FAM(HYGON, 0x18, &model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.23.0

