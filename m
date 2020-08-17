Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD94C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB7F20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BPBPDco5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729930AbgHQWHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:07:55 -0400
Received: from mail-mw2nam10on2080.outbound.protection.outlook.com ([40.107.94.80]:22913
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729822AbgHQWHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:07:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HCxXyMJC4n6HPsftUwRUKbbRTl9Nv8IkHMZZnfjA5hMVGGP9hOR00gkU3APRtSOWfO4BDhC62sief1Hjmn6JBHzADyaoa86C+qa3wjOasx6i8Ub5UO+OdHPr4E/wablBRThe6Ytzl9VheDD8K/AhP0qubnNb3Meuc/HyV+PbW41yo/QOyKJTVHvI0nTeRbsu4IexZJxgalx+0Ka9Ox+Y5xUax10s5fYVSe5c8FAfdOA5feVTrUwkAxXF3rnofc7c6qHtWE8kBKc6l1X6vwJRJcaU8E/+qZsaqhlmmGAao+Wdm5uG8eywS/z9RqhBv1CDR3U/P1wNomMQZe4V/a+fhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eq+vMfF/XW9WMgWoUPnGITlVFQ991nWpZdMPiAnueM=;
 b=Iky7meQA/APK8I3IXdUGABo4r3zUdRrDoCH9r7H1Jl9GMfYtG7uaxcHwkMOQ3E2GEv9C4kot8VFF9HVO+o1TNQeOy0BbXuYZM/ksLRVAoqi0VID+U3hd4Tg3oRIKnya59JHtS2NO4adH0Ng0JpZNF+pcABkN1uL5VTaL28rnzmiV0j/eqR9M0sYBB3l9u0TthmvhXqwutu0ZRowyidJgx7ozmcmaOe3g/HtbxNgbtgDMVy/rfLw3+2/x+ZNoZnfT/AExBRAUlPyFOj5runcQY72slDg+C1VaiykKe+j91gi9F2TDDfcPav9JeClKbRRwYicnHFHuaviVGOFfESLBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eq+vMfF/XW9WMgWoUPnGITlVFQ991nWpZdMPiAnueM=;
 b=BPBPDco5rf9YYbTGaDSCbIvlktP6wCgZmZBPkeYfnjUkgF6UMtc6bLCj6FZtgOzfxFscVGDRD5YdsWXJxBCYHR7hxB4k3QaYin8Ck/NNLeq1SbQtsGCcqjeSbEr8viCtl4QU81cE3xukYEIDJ8LnMb9LDbQcX41TH+dqXM+wxgg=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 22:07:42 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0%5]) with mapi id 15.20.3283.024; Mon, 17 Aug 2020
 22:07:42 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH 6/7] perf/x86/amd/ibs: Support 27-bit extended Op/cycle counter
Date:   Mon, 17 Aug 2020 17:06:27 -0500
Message-Id: <20200817220628.7604-6-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817220628.7604-1-kim.phillips@amd.com>
References: <20200817220628.7604-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0201CA0042.namprd02.prod.outlook.com
 (2603:10b6:803:2e::28) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (70.114.200.6) by SN4PR0201CA0042.namprd02.prod.outlook.com (2603:10b6:803:2e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16 via Frontend Transport; Mon, 17 Aug 2020 22:07:41 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [70.114.200.6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d3a5ae83-8c33-4487-37ee-08d842f9f6c2
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB1652479084E0BC1883DB0828875F0@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g7/oawF8y+QasQQzV1cgFGdqNzVSc1h/SJWbvviZZArVHHWjL2dnAl9OmbThUCxBMIHaTT+64CYmtQEu1G/9JjrqB5WInkMzIv6WXFgLJJqwjlCOcZX6G2c7bBQ1FJ1+XgVcmaMr5ajRFbCB/ey9pkWe9Hxl31CvG1+FxEVVmIICWE5rMqNB+1QUAVMMoN+G+vKjPu8BpKLKWeyFZH7asnQgArSRF2ez/yqwlwXMtMtZj05SuLcLcWQEcQv7YJ5yLwQlCnvz5gwI6DAXCKWzeErbEmDCSk3qt6lSKT+xEOLgC7FBcD1lXIpOnxOv3ZWINmCn4iacyHNsxzvQqbNaug24SoNegsv5ycbJp1Vt8nrNgXoFy75FPjvWm/yrXFAe
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(110136005)(86362001)(6506007)(4326008)(956004)(16526019)(36756003)(44832011)(2616005)(5660300002)(186003)(83380400001)(6666004)(7049001)(66946007)(7416002)(2906002)(6486002)(6512007)(8936002)(52116002)(69590400007)(66556008)(54906003)(66476007)(316002)(1076003)(478600001)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: zWdZCbhWxfuu/KS5ru3uWnOtOLuTb2nHTGEu8qHKVf4Y7IhjvmJP8htpWG8u4p1b9rt2a5PyU2392ZCBPGYocc12h5GkVCjrykMvkNQ2zmWSO39HDILYqrdv/IyJg0tMkFZ1fIdF41sxhKBRcsgrFDBW0TWxLo3vlrBFAADrwtXMjsa49XLg3vVQK09SIOPhdtIwUhZyVICZokWIINpWIlOwt9/Gm3uXjaTQ1wHhhgir/275OvugWBAOWNPfMHZfvY0q8//vw1RXkITg93NIQVtyTK79EpsRzHoOhKe5bYk8MwhjeYZP4vcp82Nm7zkwkJ7eM/PCdc36Brtclkg96OTiRvYT2LMcW8jAwnbqrP1tg2g2AX33JzEFmmXwMOpSDouYdnfnhK9tig4iczDdb1aBW4O4lyH4MaZzT2+S+5hDxknrQsV0UYgj7Jkk1GO4kbgf3rELRpllDbuVe/IJG8FXpcMs/GpAk5AMX4CVOeGduBMPOlP3+cFNbeCpnbSmd0VaOJ2JcKS7nzvIhn9R8S6mjdkuSo1VszUFvqPUfq+5g94mAFe3QW0mdQjop5bOGHAxacEqfhrtspLPu7KDEYDfyfoshF8tIRIypv8MZdtFNeg10K5Xu8/PTVjAAjqF9cF63/H1BMelYRZsUmETeQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3a5ae83-8c33-4487-37ee-08d842f9f6c2
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 22:07:42.8787
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T98bKKdGybSZgc7uw3q4gdaytkIBXw4o2+lqJigTscu3JAtd0hbLVOUy+UFfH5td0aOn1MTLelNY2/8WZ5HLnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IBS hardware with the OpCntExt feature gets a 7-bit wider internal
counter.  Both the maximum and current count bitfields in the
IBS_OP_CTL register are extended to support reading and writing it.

No changes are necessary to the driver for handling the extra
contiguous current count bits (IbsOpCurCnt), as the driver already
passes through 32 bits of that field.  However, the driver has to do
some extra bit manipulation when converting from a period to the
non-contiguous (although conveniently aligned) extra bits in the
IbsOpMaxCnt bitfield.

This decreases IBS Op interrupt overhead when the period is over
1,048,560 (0xffff0), which would previously activate the driver's
software counter.  That threshold is now 134,217,712 (0x7fffff0).

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Cc: x86 <x86@kernel.org>
---
 arch/x86/events/amd/ibs.c         | 42 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index 609ae7d165c1..3a32c523cc12 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -339,10 +339,13 @@ static u64 get_ibs_op_count(u64 config)
 	 * and the lower 7 bits of CurCnt are randomized.
 	 * Otherwise CurCnt has the full 27-bit current counter value.
 	 */
-	if (config & IBS_OP_VAL)
+	if (config & IBS_OP_VAL) {
 		count = (config & IBS_OP_MAX_CNT) << 4;
-	else if (ibs_caps & IBS_CAPS_RDWROPCNT)
+		if (ibs_caps & IBS_CAPS_OPCNTEXT)
+			count += config & IBS_OP_MAX_CNT_EXT_MASK;
+	} else if (ibs_caps & IBS_CAPS_RDWROPCNT) {
 		count = (config & IBS_OP_CUR_CNT) >> 32;
+	}
 
 	return count;
 }
@@ -405,7 +408,7 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	struct perf_ibs *perf_ibs = container_of(event->pmu, struct perf_ibs, pmu);
 	struct cpu_perf_ibs *pcpu = this_cpu_ptr(perf_ibs->pcpu);
-	u64 period;
+	u64 period, config = 0;
 
 	if (WARN_ON_ONCE(!(hwc->state & PERF_HES_STOPPED)))
 		return;
@@ -414,13 +417,19 @@ static void perf_ibs_start(struct perf_event *event, int flags)
 	hwc->state = 0;
 
 	perf_ibs_set_period(perf_ibs, hwc, &period);
+	if (perf_ibs == &perf_ibs_op && (ibs_caps & IBS_CAPS_OPCNTEXT)) {
+		config |= period & IBS_OP_MAX_CNT_EXT_MASK;
+		period &= ~IBS_OP_MAX_CNT_EXT_MASK;
+	}
+	config |= period >> 4;
+
 	/*
 	 * Set STARTED before enabling the hardware, such that a subsequent NMI
 	 * must observe it.
 	 */
 	set_bit(IBS_STARTED,    pcpu->state);
 	clear_bit(IBS_STOPPING, pcpu->state);
-	perf_ibs_enable_event(perf_ibs, hwc, period >> 4);
+	perf_ibs_enable_event(perf_ibs, hwc, config); 
 
 	perf_event_update_userpage(event);
 }
@@ -588,7 +597,7 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	struct perf_ibs_data ibs_data;
 	int offset, size, check_rip, offset_max, throttle = 0;
 	unsigned int msr;
-	u64 *buf, *config, period;
+	u64 *buf, *config, period, new_config = 0;
 
 	if (!test_bit(IBS_STARTED, pcpu->state)) {
 fail:
@@ -683,13 +692,17 @@ static int perf_ibs_handle_irq(struct perf_ibs *perf_ibs, struct pt_regs *iregs)
 	if (throttle) {
 		perf_ibs_stop(event, 0);
 	} else {
-		period >>= 4;
-
-		if ((ibs_caps & IBS_CAPS_RDWROPCNT) &&
-		    (*config & IBS_OP_CNT_CTL))
-			period |= *config & IBS_OP_CUR_CNT_RAND;
+		if (perf_ibs == &perf_ibs_op) {
+			if (ibs_caps & IBS_CAPS_OPCNTEXT) {
+				new_config = period & IBS_OP_MAX_CNT_EXT_MASK;
+				period &= ~IBS_OP_MAX_CNT_EXT_MASK;
+			}
+			if ((ibs_caps & IBS_CAPS_RDWROPCNT) && (*config & IBS_OP_CNT_CTL))
+				new_config |= *config & IBS_OP_CUR_CNT_RAND;
+		}
+		new_config |= period >> 4;
 
-		perf_ibs_enable_event(perf_ibs, hwc, period);
+		perf_ibs_enable_event(perf_ibs, hwc, new_config);
 	}
 
 	perf_event_update_userpage(event);
@@ -756,6 +769,13 @@ static __init void perf_event_ibs_init(void)
 		perf_ibs_op.config_mask |= IBS_OP_CNT_CTL;
 		*attr++ = &format_attr_cnt_ctl.attr;
 	}
+
+	if (ibs_caps & IBS_CAPS_OPCNTEXT) {
+		perf_ibs_op.max_period  |= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.config_mask	|= IBS_OP_MAX_CNT_EXT_MASK;
+		perf_ibs_op.cnt_mask    |= IBS_OP_MAX_CNT_EXT_MASK;
+	}
+
 	perf_ibs_pmu_init(&perf_ibs_op, "ibs_op");
 
 	register_nmi_handler(NMI_LOCAL, perf_ibs_nmi_handler, 0, "perf_ibs");
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 0c1b13720525..841b0006c74b 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -334,6 +334,7 @@ struct pebs_xmm {
 #define IBS_OP_ENABLE		(1ULL<<17)
 #define IBS_OP_MAX_CNT		0x0000FFFFULL
 #define IBS_OP_MAX_CNT_EXT	0x007FFFFFULL	/* not a register bit mask */
+#define IBS_OP_MAX_CNT_EXT_MASK	(0x7FULL<<20)	/* separate upper 7 bits */
 #define IBS_RIP_INVALID		(1ULL<<38)
 
 #ifdef CONFIG_X86_LOCAL_APIC
-- 
2.27.0

