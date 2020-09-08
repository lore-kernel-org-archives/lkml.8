Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C17BEC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714552087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="n/3SFlur"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgIHVtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:49:31 -0400
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:8416
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728463AbgIHVt1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:49:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ooi7TOinq/hdKuf/i+mfhw/STSEEWP9ONVLzb7ReblA+9mDe7wxksspf5ZrzcSUroTztXn3ArH2dvmwZZIAIBAZNbGMmTLC9GsuaC5Uhls4kmdwXdWORfnR0P9xBWkwCVFVMub463vhmSRc3WP723TM3STt4GjIBf4JOmIm27N7JIGt7En8sAKC0hpHecfVfHhp+KjZaO11C8ooAZ+LG3uWPrUjDnjd1ypTO5cMQfMYqqZyCmF3Lj8b820cgxKkXFWXGvUds37ZYjkgN0KVrde2agxA0hVyNAj/7wWpCQpnGnc1lMw3VSIOsW2I9gFSLNuBTUB/zcivxeH18XXxNZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEQnhvTlZWKFxSMxgKqVncBHmwMvbKWTYRskdjYXSbM=;
 b=Ey7yRmMGOE8pFTVMl8UFsQ5ffMqNBuNlHGLI7dKltbvwnab47LnSG/vZdHqWMg/bXiFd8Im7zbqaTNVUp73hHSzuA5jL9wJVUkVcb4UWCGNv9OZ9TlMe1GRri/8521LpRM0sInNFSNJh4UGKq4LRGYghOQxZDJCSyuVrcQBgbwxck+gPZvZ2vHLZyJH64ht74lNaZx2F7r8CkKi14ULSSetep7ZRW3ki94T53Gwcvgv4ImpH9V+6PHeVV/jaN8pxGeUGb5uZ31doY6NpX3sUyXsNDRywbHYXuYSiAh6AKeedo2dLfpyUx/oa4xfUgwuVNYCZce4dx+woBfjQWRgUAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEQnhvTlZWKFxSMxgKqVncBHmwMvbKWTYRskdjYXSbM=;
 b=n/3SFlurFm/FsQhgz9lmBUTZdVlMCjM3QNsNut0r/onsZRq2hpennvHbCzJ4sPMvmqzt4FrwUfdu4aYx5Vzx6RqUJOuqILdwIWk3UbAx+jh8mAXkqhnp5aNsHJlWljASeB0UHHYHK2E3ge8Gu0SLG8w6yrVxfLdqSd4jR3zGc6E=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB2882.namprd12.prod.outlook.com (2603:10b6:408:96::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 21:49:17 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 21:49:17 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kim.phillips@amd.com
Cc:     Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH v2 6/7] perf/x86/amd/ibs: Support 27-bit extended Op/cycle counter
Date:   Tue,  8 Sep 2020 16:47:39 -0500
Message-Id: <20200908214740.18097-7-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908214740.18097-1-kim.phillips@amd.com>
References: <20200908214740.18097-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR04CA0032.namprd04.prod.outlook.com
 (2603:10b6:3:12b::18) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by DM5PR04CA0032.namprd04.prod.outlook.com (2603:10b6:3:12b::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.16 via Frontend Transport; Tue, 8 Sep 2020 21:49:15 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d67a78ef-d749-445c-ffca-08d8544108b9
X-MS-TrafficTypeDiagnostic: BN8PR12MB2882:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB288241A0D37C65E735FDBA0587290@BN8PR12MB2882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n02zRzL45Z37YESqtiNd7ozd3X8FdS/wEF8mmB2rLWJF8uieqkYD9CaCnv5wZzTqM1LxW1gT9etIrs8vZn0cYjboYbCinqxCbFKmaj1Gjnvur25sdC6EO9U9b4GC1MSEVuvp+w6pgRD6PTKy7MJlSQ1Al3i/PWi4ep4zdNtwS/wRYkkOsnqten5fvjGCJ2OiUnvbEQCm5nZaoU2kBrfQDDDpWgOfpE7IwGSnjvV4nSrYGDc5ri4orUfvN/lm7H2kpYu6nx9kf9K6pYcBTWYWj/6zV7MFiHpT/BdL7oPx63GaLLpEFxZjT8mco9Nxgu0+IdDETizh7V1OXpv8PP9lqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(136003)(376002)(39860400002)(396003)(54906003)(52116002)(7696005)(4326008)(26005)(186003)(110136005)(66556008)(66476007)(66946007)(5660300002)(2906002)(1076003)(36756003)(86362001)(6666004)(316002)(16526019)(44832011)(6486002)(478600001)(2616005)(8936002)(956004)(8676002)(83380400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: hhzVYQq8y5BHHMRjKsvucuyAJSE/yYVGJ9uKIjod5e+gOe6VLv6tqRGnme6dNkJOXwBAg2TS6nga7tFgSrqtAGA6NaygeawItEauql+xHC61jPkPmXD7mZsvqv3g/MSOWXK1nNX51RhDy844c4vJ5nUbDuvIFAkg4UIwlJUtwPiIafRvcaqFSKwDxZ55wzRc7JfYB1pBlrIh5QvKmlU/Id9K/Zn17MNjsFeMXRKrgNUDzCgJOJ1buZ7yiyAqxPHAODhtRhv6mCyJU04gbnv0AW6K2656vXL444gTg//eXJoTn5xCnCmvIgaS2t5UFZ0jF+tGooaAHoSW7JyNjkkx2R6OWdHy+KKZT6oxaVnltx4jQM3cOIxOmnc2QFu1PDK4lsLkleqPUQkVFYonag84NLv7uFs4bqFoqw9QHgKgIbBlyKrjcbUIZe0LVbgT73W8sT4pP293EYU7xzihNiZWWyoVumzXv+/qOkI0pdsHadigle9Qu5P39DJlEs2Q0haIStLCJc6UpXRpz3XyHKkN5RfFdYUqAFGsLQBeM+upqMPwCiVrLZ2WF/787p1s4gRRbNRMmMFuW9zhCQ+Cf1EdPjpDcAH69eD/8nrCnI5VLrLifabf8H+OZMEFWoA/HOFF119RQuOKt7IockFvvVRKbQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d67a78ef-d749-445c-ffca-08d8544108b9
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 21:49:17.0948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Yw3EHK49Lmlzav6uA9imPEJ2B4QkcLvZn9QXrbt7/fKTy0xIrVDXgsUAlOSNsGLQHs416yqPM+BC9k9K09wsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2882
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
v2: no changes.

 arch/x86/events/amd/ibs.c         | 42 +++++++++++++++++++++++--------
 arch/x86/include/asm/perf_event.h |  1 +
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index ace28be4cbda..2766a7763d38 100644
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

