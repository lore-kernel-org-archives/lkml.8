Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2266C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:10:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A65F2074C
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:10:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="h+owYq0Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727470AbgCMXKl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:10:41 -0400
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:43315
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbgCMXKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:10:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ph7oXOuwsx1jrPjpZfJG9GWM/ANkbSEELnYAsb8lzk4RQIH/f9xQFox3oE2bq8jF5zWAHfn+MCwQegVAqNQL/OrJc5FqGLoLegpvJJL4sOjmca6N6SmmHBnDW+F4E3T9Snos9X+dVg5mWtvItEd7o+Xth5jYMaBtHx8iWGth/LLmCQhdcU76UeOWNyQchceadts0W+SC7v5b2Mpkx0s5cb0x2rdjg/2fVCXfh2bsNXP6kdaT8dLyrnb7OhJD/Kmq/s1CvPWOxszJeK7sH/vA23YafNxWGWsbqScjh4oISOswtM/K5kZJW8WgGCI+Habf/VMGm4dttNO2u0sesih3Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV+sRkglfNqzwBh9NW2f7/+bSX5mszxZb/AYsyrxLcQ=;
 b=LbADY8F4gHXNrv2HzMeDEPgh3kLaYAo6vLiQxt+gI2sIXk3vQpBhqA/zaY4lVygALN5FnmuTGtYlj70Ym0UWiAZb5jhkX0lz2DftUs21okYja4RtN8qDsnXBUOjrcyuFPDtIkounxeP2zGhkkw7a8Tv5WF+BnG2pRFiWuBxepBZzrfi13Vr/FlvzVNXX6uWeM43mmbzhm2M5cacpOPZjqFVLH/NxCAqehMC7mF55xNTpjb1xeOm3l4OaJNwA5Z49Wt+c1dvrLpLlQtQ377jVPy97fgLzS9kYMd0BxMm2dTTd4oL7DBCSHAm+5KdUe5p8xnmcFXKzCcxWo9UhNhJtow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV+sRkglfNqzwBh9NW2f7/+bSX5mszxZb/AYsyrxLcQ=;
 b=h+owYq0Q8HHeh+sBVhLVmZ1cLpwhp06bCHYrIMmyo1BSd0zqMe/pl0kBcJlkzKiHmRQnZzv1gc9xCr64H0YS6aztQpEvRQJGulysTFWKP9HONRiIzmeoAd3lai9wsReAoxSki6hWEuu9vnmT0/fA89/o8RrUdGP61fxTJRf3eFo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 13 Mar
 2020 23:10:35 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2814.019; Fri, 13 Mar 2020
 23:10:35 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Stephane Eranian <eranian@google.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 1/3 v2] perf/amd/uncore: Prepare L3 thread mask code for Family 19h support
Date:   Fri, 13 Mar 2020 18:10:22 -0500
Message-Id: <20200313231024.17601-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR08CA0019.namprd08.prod.outlook.com
 (2603:10b6:0:52::29) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by DM3PR08CA0019.namprd08.prod.outlook.com (2603:10b6:0:52::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Fri, 13 Mar 2020 23:10:34 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5fbe7199-3590-463d-5501-08d7c7a3bcb3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:|SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28469C6F81DAF50F5DB2A29187FA0@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(81166006)(81156014)(86362001)(110136005)(6666004)(316002)(7049001)(966005)(186003)(52116002)(66946007)(36756003)(66556008)(54906003)(66476007)(7696005)(4326008)(1076003)(44832011)(2906002)(5660300002)(26005)(2616005)(956004)(8676002)(16526019)(478600001)(8936002)(6486002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2846;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XEDggDY2LlH6xg9qjPLrw0LeMM/qxRsS9RsNeRvjWnoU/roNEtyjeXpN0G7x6gJbOw1kH1TDXqr0Wf1td3qazT34Nl/DwkFfakiAOy2yTG+W5hKEpka2jZoiu+uE2c3skE5g0ZiZBFu45/y5WUEV5C5hCNo9EjGtD/uugXAPHg4YwYVzylQ17KfU8oFrPFuFDeHEXcZTIGEwSLYQZLrrOtv5OncoHuuo8z0XSqCw1HrJvCWiRWjfoq+l7m7qRzBtxX/wWf3bhAnEFFTEruybKvlHfVHRPehMBW4Q/20pqTRm6Edzcupae44x5vXy9QScESrRu/1EhdcfSj5rERljzGB0DdwiB8qo9IvXMeWz6iEmNkspobwL80+c0Str49VP0kEJQZg44n4Mga1tqhHR2OS5rrxKa1u4pqxtASSGA/qD30rgtF1plXxVkoHCHIFS7LDIqeqSmmlqbOzgUbMJytdT6eRIbyFGm16UMEPfze6dNByR1CtqdLXxLOnMcN58QVAF0/czlNOYS0zpbXNb6g==
X-MS-Exchange-AntiSpam-MessageData: 4IKErrVZyQSZEnKktaIXXIc84NoXtR6SQp1VEyeI5lDGcJotqNd0xq8DFBomAq+6detnPLGMlTCvtKzyEt5La5I6R5LLpDBBWTYY2apwhSYcAB0ERiue5euAq1o+sGIY4mG3pQZczhWvkBie3EOJYA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fbe7199-3590-463d-5501-08d7c7a3bcb3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 23:10:35.7512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iRD5iknQh1wfn2j2qZYTHqnxG7x83gYD9OCyFFYXoU8SOoQuAB2i8dRqXqpCjgSwLd7Rwekj5SNpK+lrxB5ucQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better accommodate the upcoming Family 19h support,
given the 80-char line limit, move the existing code into a new
l3_thread_slice_mask function.

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
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: x86@kernel.org
---
v2: split into two parts, this one being the mechanical
    move based on Boris' review comments:

	https://lkml.org/lkml/2020/3/12/581

 arch/x86/events/amd/uncore.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index a6ea07f2aa84..dcdac001431e 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -180,6 +180,20 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	hwc->idx = -1;
 }
 
+/*
+ * Convert logical cpu number to L3 PMC Config ThreadMask format
+ */
+static u64 l3_thread_slice_mask(int cpu)
+{
+	int thread = 2 * (cpu_data(cpu).cpu_core_id % 4);
+
+	if (smp_num_siblings > 1)
+		thread += cpu_data(cpu).apicid & 1;
+
+	return (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
+		AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
+}
+
 static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore *uncore;
@@ -209,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * SliceMask and ThreadMask need to be set for certain L3 events in
 	 * Family 17h. For other events, the two fields do not affect the count.
 	 */
-	if (l3_mask && is_llc_event(event)) {
-		int thread = 2 * (cpu_data(event->cpu).cpu_core_id % 4);
-
-		if (smp_num_siblings > 1)
-			thread += cpu_data(event->cpu).apicid & 1;
-
-		hwc->config |= (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
-				AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
-	}
+	if (l3_mask && is_llc_event(event))
+		hwc->config |= l3_thread_slice_mask(event->cpu);
 
 	uncore = event_to_amd_uncore(event);
 	if (!uncore)
-- 
2.25.1

