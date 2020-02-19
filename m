Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624A8C5ACC5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B823207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:28:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="x77kjjOn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgBSX2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:28:19 -0500
Received: from mail-bn8nam11on2046.outbound.protection.outlook.com ([40.107.236.46]:6139
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbgBSX2T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:28:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cj0/S8RhUTviiqvJsr/t4Q+B9iM4tJxC7GfgBqHXEK6lMSLS6hQAmuNBr6gjJAobRHY505cxzJuHGG2q8M6bo+6LEVe5ahbhGHY0mwFVJjoO6em6b7xYfZk3t5Ny/vWFyOu9SSI95zQsWD2TvyKmv9gAoJGdoHuODozqlnJ8ESCttir2TgLGqEl5oRK0MvzDiYjWSOsgllS7ziTOlGPSnd5Cm/yiI4Ho6qXqnTgWa0os2JGvhBcnZAyCFM42z9VnCdlFZCrbSIliKAK/+OTx0/Izq3oJyAwEatnSO6HhBP4W6pyX9F16yBePftAvY61twc2nqYD36GQDIXvI//jP8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eqBskMnbMUsnxqydtvwkFXzMJnyKFpuUriwJWdxoRA=;
 b=HjylukfdHqtn8kZNBsX1VJRvSzm3sF369S/+VP/5ZHojM4QUnMh8w28s08eUC5oVvltm12xgq35VmEm89RrbmoEfw5355MGKAOZM1uJmHIK5H6yz2U/CvTtX4wcIpZ5exZ7yF6ZryFx7ScVL/VAYF8xhaX+qeNI5rxpHKwKnBgm2Yr3P1f/8DO4C/1JKTcvLxYU1KYprD9djV40UHtorfbSuv5RiB01hqf63miQ+QYhZc0f+km4foTYCyeBxWftr5q4tG9W8bssfh2twt/XIvHPHQuKW79s345sRouIyTMI3gS35+CKFWNuh/qapIdeXw98Qe7VruJPR/piyJryWLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eqBskMnbMUsnxqydtvwkFXzMJnyKFpuUriwJWdxoRA=;
 b=x77kjjOnFbkIN/FwcF56qXp5P4fTp+snx04E95SHgKnydf1zq4RmHuLaVecihjE8Mku4fH0QVyAM8YpN7wy5R2XwRTOBroRaPbvGvwDtuoOeyyy+DorUfAfBxvEIggLcT6syOhg3+C2hEfeS7f+tpdcY8Lk/mzNAfOFrAAITSjA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2605.namprd12.prod.outlook.com (52.135.100.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 23:28:14 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 23:28:14 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [PATCH 3/3] perf/amd/uncore: Add support for Family 19h L3 PMU
Date:   Wed, 19 Feb 2020 17:27:29 -0600
Message-Id: <20200219232729.21460-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219232729.21460-1-kim.phillips@amd.com>
References: <20200219232729.21460-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR14CA0066.namprd14.prod.outlook.com
 (2603:10b6:5:18f::43) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by DM6PR14CA0066.namprd14.prod.outlook.com (2603:10b6:5:18f::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 23:28:13 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9e1e4789-897d-4ba1-dac6-08d7b593642b
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:|SN6PR12MB2605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26053AF39FC7F5C1A62C88B487100@SN6PR12MB2605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(8936002)(44832011)(8676002)(5660300002)(7416002)(66556008)(2616005)(4326008)(66946007)(956004)(81166006)(66476007)(110136005)(36756003)(81156014)(7696005)(26005)(316002)(52116002)(2906002)(1076003)(54906003)(16526019)(6486002)(478600001)(86362001)(6666004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2605;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zu36luH/MbX+uOrgHnzgCnCgbiHOrxENy2I9jPTWnNHEk2UbnQ7seHU0PeilI1aZOJCGovYgBCU/DSuIcH1yhvXtLtqtpmTH6iC+GbXphwJ2TXHKqfXS57PkDjKABBtExiryQCpIhlVfrc40vYA8lxosmNudPbjgB2/Xjo4mMXZ9k6fHYeBGRrZW9XF+h5D8X03eVs98qL4LiIRozu2eIwrDJk8Z6+gtDqYGdeH1CN5Dwwoa9myl8Mi+M7f3Ij1KBoGnB0TveF8QMNvWf2BvoQ0ucBxxQ/1mn3TvHRVFYYqqCaOlj/rdBF+fa6cMpmaH5kEZmJTzeOFLd9vgiWZWs51vxjVeM9OJvAfVgzdhfhGPE5UzjHo1EPe0fVNZzeb3WuL+FDHhFb8jatj/GGT0BBVXBBmYweNbQCS50hPmZe1vp7ctZI83PQMq5WIvup4u
X-MS-Exchange-AntiSpam-MessageData: 4/KddZivGO2z6bAB856R3GBdlfpBU0qnMMWAJm3B7jT3YOHsV4IjzsByHiOztzpcxFAxdQbMYon8KXSNJJARAjXu0O77j13PNgmbCXi+GvlqHzSVIOfJgsa2i7oGUw/qZ0tgpv6co30GP+/nbQ5ycA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e1e4789-897d-4ba1-dac6-08d7b593642b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 23:28:14.3559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpR8/C97YhRFmHcebd7/9aOVcAc5LsK8/UIPE2CbP5GuRdV00FD3KxmjX16EZege9dQ1z1bsK9sQMVDvL7hBBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
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
2.25.0

