Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8302C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97EBA20575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:14:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XcvwTxMn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731140AbgCKTOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:14:12 -0400
Received: from mail-bn8nam12on2066.outbound.protection.outlook.com ([40.107.237.66]:6033
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731104AbgCKTOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:14:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQztyBk/PlS9Y/kTtOGtpucKxZCRGomRPtjKHriDwAntAx9P49PJeEdXCtnTw+Jfx6zA9w1Mv2Gb8al6SUVarygt3pjKg00tMGM27DZdGa/AzfnGGy0DukbD8+6DOr1+NnOZy5VW6NCt4kxJklzrX1ond/c2wNsQdnKiHU8Owl+jzRxk0V37ynxTbjJLlP+D9lFm/xBkY/8t6iDjcUaU6gcNE9KZvYCXtBJtkp2Zv2eytJH1gEajah3seFU8QOzLCqHZXukn4V0/0awHnmctSbjkcRaaf1p4Tw9vQtMo3kK/sfgyB0m4U0XKeT61vxEVDEBe8D2aKI+18KtCEWW42g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIMA6d+XfRdhBHbRXj8EcHyIEMDlbvBXLWFwk0//MxE=;
 b=A0gCCFklUn1WNuH7lSnfYxWKfT13HTKRJbspKsfEYiIMTnCNc40F+M5g9ifDd5kVhOc8wBxIXxw+stdyAj8b2nfVNppKQeyC4jvQwtWzCKRrweRjLipCR8jNXEWlAi5QtXtG0DQfv4uPzL+foAAO3MqF74llV5TP6nsmCawFOR+IRuq6VdEvlFrOlR+in5Z3WK7EjXEiyEDocw4I9XMbvudIHxUBGhxKL3xRu6Yur8CANxTHgVj344gQfnztA9Fu8tX+faGDS4XG+bYDil9fCPMLW8PHwfM0qCjMXAdlDFnClU7WsOuhOa0SKxqghXWhWJQsinAvi8P14n6q3Ndcmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JIMA6d+XfRdhBHbRXj8EcHyIEMDlbvBXLWFwk0//MxE=;
 b=XcvwTxMniMdT4pvMu3xSuSfny+0WUw32lSJN0g40fdNzsOnJ5ooEfe31BWvbzfEuLhzC62Nn/LdoVg/u8A8/8r1tRqSt26Rvmv9VqLD2nTpBG4OwFR5KoVZFSU9EpY/gq7rlq60xTUGia2+WOh+reO2b93BrlO6dA5+7L4zR1gg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 11 Mar
 2020 19:14:03 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 19:14:02 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kim.phillips@amd.com
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 3/3 RESEND] perf/amd/uncore: Add support for Family 19h L3 PMU
Date:   Wed, 11 Mar 2020 14:13:23 -0500
Message-Id: <20200311191323.13124-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191323.13124-1-kim.phillips@amd.com>
References: <20200311191323.13124-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0066.namprd07.prod.outlook.com
 (2603:10b6:4:ad::31) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by DM5PR07CA0066.namprd07.prod.outlook.com (2603:10b6:4:ad::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Wed, 11 Mar 2020 19:14:01 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 87712052-f898-4594-72d9-08d7c5f05c4b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2830:|SN6PR12MB2830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2830C99001C50690BD4D1F2187FC0@SN6PR12MB2830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(2616005)(956004)(6486002)(6666004)(7696005)(316002)(52116002)(8936002)(36756003)(110136005)(44832011)(478600001)(54906003)(26005)(16526019)(186003)(66556008)(66946007)(2906002)(1076003)(86362001)(5660300002)(8676002)(966005)(66476007)(4326008)(81166006)(81156014)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2830;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HAZC47Jdj1C5vZxS48sIAFs3U4X3Ba/oL3z5QeQXYbOqTv7OgHFtNhzLKk+3xtz12i1FVFXkjyKcc9ztwmhpQdFFR5hicnWGh+FjsrJpeCZChj1X9/r5Lci7XQkg5AUCiPftDlUvVgkWkTwcLwOwMhFSYHVPf3o6DUeh2dAGM107UY/qsOHB6ITTXJ6zlU47uNgP9Jnw0V1fFEAnRHu6Vbk1FQWtanc222UNr1OnKxQPcWgnxjDnBROGzD7OOLzWx0p+ylfXdI0ZUapm5mlIvHYoZ9UA5EsT97+IMIIKopuQzkcp9jem6S+xUIyIkDtx4JWO0n+uPw5QtH9UUN/FWWQrocVUlm5KQd6oGd9v4px1SA2foaV5Pz7mW+0h8cBWveM9uGU++jdYWRbg8eiOKqaOXxNnqrv+SEjggqNVJBHROnRcfIQkw2ox5XRrJsfYn5gc1xZL1YyJ4Xbi/ohFMjA5jvoOTjOEO+SlArZapHwh412+cNosK6L2OIViG80A1fNN8do7p4rSVqaRnh5wRg==
X-MS-Exchange-AntiSpam-MessageData: m6A2mqtideA2nsa19MwjCD3QPkYjbmOhxU5q4iLalMMh6TMLerC9CIcysttyCLZNU0DeOqShqogDJ3q/4/hoEeSNig6J0rn4Kwj5Oi7u1WmoJ4c84SbBJpnsWfFrN2+ZMpxFvV1yrJSIcohqjFX2oA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87712052-f898-4594-72d9-08d7c5f05c4b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 19:14:02.9114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hZKAH2daEdiknKkCn6sMCDk1T0y8y+ajuoHZX9p6P6fSMTYqSWgRDS1VnbaQuomhcoNbvqEpTyygxiO4uiYcVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Family 19h introduces a change in slice, core and thread specification
in its L3 Performance Event Select (ChL3PmcCfg) register. We implement
the new bitmask conversions in a new path in l3_thread_slice_mask()
based on a family 19h-and-above check.

We also change the uncore_init() family check to 19h-and-above, so as
to not revert to the Family 16h-or-below L2/NB code paths in the driver.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
RESEND.  No changes since original submission:

https://lkml.org/lkml/2020/2/19/1193

 arch/x86/events/amd/uncore.c      | 20 ++++++++++++++------
 arch/x86/include/asm/perf_event.h | 15 +++++++++++++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e635c40ca9c4..78b4fb917ad6 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -191,10 +191,18 @@ static u64 l3_thread_slice_mask(int cpu)
 	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
 		thread = 1;
 
-	shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+	if (boot_cpu_data.x86 <= 0x18) {
+		shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+		thread_mask = BIT_ULL(shift);
+
+		return AMD64_L3_SLICE_MASK | thread_mask;
+	}
+
+	core = (core << AMD64_L3_COREID_SHIFT) & AMD64_L3_COREID_MASK;
+	shift = AMD64_L3_THREAD_SHIFT + thread;
 	thread_mask = BIT_ULL(shift);
 
-	return AMD64_L3_SLICE_MASK | thread_mask;
+	return AMD64_L3_EN_ALL_SLICES | core | thread_mask;
 }
 
 static int amd_uncore_event_init(struct perf_event *event)
@@ -220,8 +228,8 @@ static int amd_uncore_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/*
-	 * SliceMask and ThreadMask need to be set for certain L3 events in
-	 * Family 17h. For other events, the two fields do not affect the count.
+	 * SliceMask and ThreadMask need to be set for certain L3 events.
+	 * For other events, the two fields do not affect the count.
 	 */
 	if (l3_mask && is_llc_event(event))
 		hwc->config |= l3_thread_slice_mask(event->cpu);
@@ -530,9 +538,9 @@ static int __init amd_uncore_init(void)
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
-	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
+	if (boot_cpu_data.x86 >= 0x17) {
 		/*
-		 * For F17h or F18h, the Northbridge counters are
+		 * For F17h and above, the Northbridge counters are
 		 * repurposed as Data Fabric counters. Also, L3
 		 * counters are supported too. The PMUs are exported
 		 * based on family as either L2 or L3 and NB or DF.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 29964b0e1075..e855e9cf2c37 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -50,11 +50,22 @@
 
 #define AMD64_L3_SLICE_SHIFT				48
 #define AMD64_L3_SLICE_MASK				\
-	((0xFULL) << AMD64_L3_SLICE_SHIFT)
+	(0xFULL << AMD64_L3_SLICE_SHIFT)
+#define AMD64_L3_SLICEID_MASK				\
+	(0x7ULL << AMD64_L3_SLICE_SHIFT)
 
 #define AMD64_L3_THREAD_SHIFT				56
 #define AMD64_L3_THREAD_MASK				\
-	((0xFFULL) << AMD64_L3_THREAD_SHIFT)
+	(0xFFULL << AMD64_L3_THREAD_SHIFT)
+#define AMD64_L3_F19H_THREAD_MASK			\
+	(0x3ULL << AMD64_L3_THREAD_SHIFT)
+
+#define AMD64_L3_EN_ALL_CORES				BIT_ULL(47)
+#define AMD64_L3_EN_ALL_SLICES				BIT_ULL(46)
+
+#define AMD64_L3_COREID_SHIFT				42
+#define AMD64_L3_COREID_MASK				\
+	(0x7ULL << AMD64_L3_COREID_SHIFT)
 
 #define X86_RAW_EVENT_MASK		\
 	(ARCH_PERFMON_EVENTSEL_EVENT |	\
-- 
2.25.1

