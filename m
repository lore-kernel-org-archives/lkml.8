Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4091EC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 174AD24671
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:11:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726472AbgAOIK6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:10:58 -0500
Received: from ZXSHCAS1.zhaoxin.com ([203.148.12.81]:29677 "EHLO
        ZXSHCAS1.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726100AbgAOIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:10:58 -0500
X-Greylist: delayed 623 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jan 2020 03:10:58 EST
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:10:55 +0800
Received: from tony-HX002EA.zhaoxin.com (10.32.64.11) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 15 Jan
 2020 16:10:53 +0800
From:   Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <luto@kernel.org>,
        <peterz@infradead.org>, <pawan.kumar.gupta@linux.intel.com>,
        <fenghua.yu@intel.com>, <vineela.tummalapalli@intel.com>,
        <linux-kernel@vger.kernel.org>
CC:     <DavidWang@zhaoxin.com>, <CooperYan@zhaoxin.com>,
        <QiyuanWang@zhaoxin.com>, <HerryYang@zhaoxin.com>
Subject: [PATCH] x86/cpu: Add Zhaoxin CPUs to the cpu vulnerability whitelist
Date:   Wed, 15 Jan 2020 16:11:22 +0800
Message-ID: <1579075882-7162-1-git-send-email-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.32.64.11]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New Zhaoxin family 7 CPUs are not affected by SWAPGS, add these CPUs
to the cpu vulnerability whitelist.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/kernel/cpu/common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 2e4d902..3488507 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1084,6 +1084,10 @@ static const __initconst struct x86_cpu_id cpu_vuln_whitelist[] = {
 	/* FAMILY_ANY must be last, otherwise 0x0f - 0x12 matches won't work */
 	VULNWL_AMD(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
 	VULNWL_HYGON(X86_FAMILY_ANY,	NO_MELTDOWN | NO_L1TF | NO_MDS | NO_SWAPGS | NO_ITLB_MULTIHIT),
+
+	/* Zhaoxin Family 7 */
+	VULNWL(CENTAUR, 7, X86_MODEL_ANY,       NO_SWAPGS),
+	VULNWL(ZHAOXIN, 7, X86_MODEL_ANY,       NO_SWAPGS),
 	{}
 };
 
-- 
2.7.4

