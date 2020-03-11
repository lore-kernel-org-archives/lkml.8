Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5690EC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:13:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E9BC20736
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PvSoPoNZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731062AbgCKTNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:13:54 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:6207
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730705AbgCKTNx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:13:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NpEtf5CM+YGPx60IhWFCSHO7po7VQabmMbKgSjkq1uYDI7FoxEPGEchyXjy/V/DsnuZsz1EKn54as2wu9vYZ6usAeE3t/c63ocwab+sohgJ9mNr76W89nifhnS6hTnufHRkA3vzx9ITOiRMULNzN7qUpiZlG6+74nDLY671XEg3h0FKwAoW8WCKLAX7MufOL4vVf8Qi5EogB+cJQIy9mp/Tkbi4juTf9atz65Ff3roeKLNRLrFfZ5LEJmD4m6pU/U9NOTIOJgTDcc2Bj+XLqapWqws/4sqH7TC0FJcijpQAV/ajYTzeNxweXe7Yj1kEH6He3ZGMrlhO/FxIZfOJ+WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaKRcao1SGeyL0eviR3QgveFsCkA3vn9l+H1j4J4pU8=;
 b=AG15gnVAjNfvQb9VXmrl/Mz+3UPvxUip95iVFO9lSZeppkx+Kc+solyMydAwx/xKUTih7CCdWnGzLCime9j1Rrp1BQcX/y7HdfdhEj1tbRp0IBKzxy/zAakHI0PH6hJ4kJnlewrwFth6mUCHNLNykMbb/e1wjLk07+oyLKISE6PqQOUjB7Xaq4t8Ki8k7uwd392uui7v4n6C8wJNXMoWcDPWVVjo0SVs8PO1cNRsMidXF8ATIv/Y0TwCDPslITZM08qA81ei9I0N8T6YMVtvNyOnggKVg+0ckg/wNwVmVSmn1YBEOt8pXkf3T9omRzBfiYhUUXPh8g8xuogqnI+yEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uaKRcao1SGeyL0eviR3QgveFsCkA3vn9l+H1j4J4pU8=;
 b=PvSoPoNZowUU0Z4h6Syty+U7ynLVCU8FIqWqRz91TZnxzNLMHZokMnYzqunXbEbXS6tOkbKOH4dtQGiQhQztNfkuYNI0b8uzSdxJ10gN9sHVDLePYx20SvMyyh8goITsVqyI3GfBC/wb49nCIGagA/3Mdvi0j4UDsb6rvixXlsM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2830.namprd12.prod.outlook.com (2603:10b6:805:e0::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Wed, 11 Mar
 2020 19:13:50 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 19:13:50 +0000
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
Subject: [PATCH 2/3 RESEND] perf/amd/uncore: Prepare L3 thread mask code for Family 19h support
Date:   Wed, 11 Mar 2020 14:13:22 -0500
Message-Id: <20200311191323.13124-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200311191323.13124-1-kim.phillips@amd.com>
References: <20200311191323.13124-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR13CA0008.namprd13.prod.outlook.com
 (2603:10b6:3:23::18) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by DM5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:3:23::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.6 via Frontend Transport; Wed, 11 Mar 2020 19:13:49 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 534444d9-fbe5-446a-4f74-08d7c5f054cb
X-MS-TrafficTypeDiagnostic: SN6PR12MB2830:|SN6PR12MB2830:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2830912C7D0E1376605F247B87FC0@SN6PR12MB2830.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(366004)(396003)(136003)(376002)(39860400002)(199004)(2616005)(956004)(6486002)(6666004)(7696005)(316002)(52116002)(8936002)(36756003)(110136005)(44832011)(478600001)(54906003)(26005)(16526019)(186003)(66556008)(66946007)(2906002)(1076003)(86362001)(5660300002)(8676002)(966005)(66476007)(4326008)(81166006)(81156014)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2830;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gu1VYTxDPu+aatj2Z7DROw7LzMnmA5CsKdZO/zI3SBtbdYgZPZhcwwjnL60AUBZ46Fr3hz+IZxfeOi9+l5qA8DZKMi3x8rYFvr4PcmpVQwCwYz2h1QM5jsCgr5Nlc2Ek9HWefZ8h7Kj2ubr8meBoELOftfzdVcU3FvcKbJZEP2gRbqX2qIMJusvfXSuGcVJlsx3kD3g/gx+YB0zxZTil+NdPQHla1ZJ5nYmVpBDiaoVPWImOoRoddPlRsD6+nuQtdyuGhQQQ0ziQg7kfsoHf8b+FPNb9t6F8w1zJs/sVSFG0U/AUExb6eJdyVMIlwJ3I54+e3uuPMJCg0BHduSo4h1CafkmPckVdsA3Xf/FlbTUAlwh4lOGahC3sgJlivQQ6ecfaEXPmpkG4OtG31T+qVic5tWnV1ytEQd/hanqW25l84+3MqDsyRh+XGZupaVR+pxyc+FKGOgDApnnzwnwG42g6oZDO1SnMfwL0wiz5FN7n2gz7OyAiki7cntkTSL0FzgF6Ck6ZmOK6b6gZU0JUXQ==
X-MS-Exchange-AntiSpam-MessageData: Vd06w+M9NGzFhrPRu2aFlVRTlcWveHqIVLaTkEz+e5SMBvr1AJg8qlGZlUEGlBbAe5tsPfJKmOdims74MrwBX0TAue0KxTNOohc6AvZVtJs6IGGuGdt82EwlRCQ7qQvdRGEviVBDH0Wry3y4kJ6oPg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 534444d9-fbe5-446a-4f74-08d7c5f054cb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 19:13:50.3226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AuGHsvv9E/7EP3zjWoodSHFzcUo0tv/pPyyxFoIhEq1P4/mudlbiSvfU8/M+LKTCr6hnzJXiet7P8t39QVN3Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2830
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better accommodate the upcoming Family 19h support,
given the 80-char line limit, we move the existing code into a new
l3_thread_slice_mask function, and convert it to use the more
readable topology_* helper functions.

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
RESEND.  No changes since original submission 19 Feb 2020:

https://lkml.org/lkml/2020/2/19/1192

 arch/x86/events/amd/uncore.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4d867a752f0e..e635c40ca9c4 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -180,6 +180,23 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	hwc->idx = -1;
 }
 
+/*
+ * Convert logical cpu number to L3 PMC Config ThreadMask format
+ */
+static u64 l3_thread_slice_mask(int cpu)
+{
+	unsigned int shift, thread = 0;
+	u64 thread_mask, core = topology_core_id(cpu);
+
+	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
+		thread = 1;
+
+	shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+	thread_mask = BIT_ULL(shift);
+
+	return AMD64_L3_SLICE_MASK | thread_mask;
+}
+
 static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore *uncore;
@@ -206,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
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

