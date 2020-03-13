Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6867AC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32B7A2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="AetYuXZr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbgCMXLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:11:07 -0400
Received: from mail-eopbgr760042.outbound.protection.outlook.com ([40.107.76.42]:33607
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbgCMXLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:11:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jx2PZV1e9cMXExtDZ0JAChgSxsDE+NZHwI5T7v5RNeUbJkZeQmnMevPyMPeoLBUqUUM7ishcsvhuz8yWYZVoJEQfxXkXdAOs3ynDdON84EN/SEjV+TeeGg/+NMJmjkoq+gY8qezBJc98ZSz+Oq0eJw3T1W8+nNa2s3ICA+slsFj5UrqGkddyPA5g0iRnkRm61t5+TQB3ZWsHZJ0OLX39Bk5EjIqWIn75V7c6SmtRvQ35BaIJkE/4HRlZyvBAxkfSuJig2Ju2Ru/RpbIc8okgTL9dgHKgqxKNXbiTtZbb8tBBxt9Bq038SoXbhihV8l93Cb/PFvDE3xvovNT76tx87Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz9sJLh4cWRSjcLMlJdzqxTCHghX+M7J3OICEWPnVTo=;
 b=GiOUdJfUEwWC2nK13setF4pSQLmDIppiTq214P6xWp/OZ4cG4K/XOBp0YJZgKzjLAbKj7e3p4x7TvG3AvYHpuPyEwEGbhif0asNRGvhKQulQjfh6sBsJMmvN0PBqvVMzZAbohch5J7u8RVET2EL+YLpnvXZ+RXOOo0x8bIVcl+t5gBmXQVnnMD35ekisf3xZ6XevsZM4t0/eC1DtNJuN9yNqVDWjN+q+k9sRJOLrITb8ie5YqkXTNDSy7EbCQe+lPqdbw9wrtYw9PGOa4Ba9XM9ZL/f6FkqhPVfYphi083tHgcNx8TtVAGwNcDbncDqHwXmlCt9AmgrDiElazhYwNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cz9sJLh4cWRSjcLMlJdzqxTCHghX+M7J3OICEWPnVTo=;
 b=AetYuXZr8rJoLf0znfZNclXDDqZgdy+ScwRtNh1ZIrsjcAjbCF29Cd5HhTz4Q4Nuow2KQvt/DxM6GgdeG3pH/vX6vB9zOzSidq7UJYkWh+riZz1ZOupRpzR0Ggaooo1nxAF9fqfUe02iffKALz4BM9YNe8m/Pr/m8TtVnIFHrlk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 13 Mar
 2020 23:11:01 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2814.019; Fri, 13 Mar 2020
 23:11:01 +0000
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
Subject: [PATCH 3/3 v2] perf/amd/uncore: Add support for Family 19h L3 PMU
Date:   Fri, 13 Mar 2020 18:10:24 -0500
Message-Id: <20200313231024.17601-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313231024.17601-1-kim.phillips@amd.com>
References: <20200313231024.17601-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:0:52::23) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by DM3PR08CA0013.namprd08.prod.outlook.com (2603:10b6:0:52::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 23:11:00 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ca667cde-c73c-4a3b-1111-08d7c7a3cc24
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:|SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB28463DDF1966BFACA3F7C8EC87FA0@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(81166006)(81156014)(86362001)(110136005)(6666004)(316002)(7049001)(966005)(186003)(52116002)(66946007)(36756003)(66556008)(54906003)(66476007)(7696005)(4326008)(1076003)(44832011)(2906002)(5660300002)(26005)(2616005)(956004)(8676002)(16526019)(478600001)(8936002)(6486002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2846;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlZUv/9/oAbiYp0/EUd7U6kfw2Nyi1EKXWRRrHEbKSttbBgxZxnkPQ1OJvYV8jm/Ux/TZ/YONOvDkdlZEMRnkMgtbSNdZwUXO+3c+FcRWzBs4UstiUKWK32hM/6bsU+IsVILm5J0HsR61nMi7MaCcsBSHj+kBE6irOXFK7ke04f8Po4SC0RU6qaWFzdc88k7KBdu81wuAh73S64M0uo7dVtpV7OQRNBhBLlPytla/HTgLqxEkzCgR9RRFdEzA1SpVOY4dyOUiyviwzJlXaYneqhlsyFBH6K0zzjIYM93oY5aEr/qaxbJ8IBInhAP91I3eJO9iE7TUMr2WIqWTv8zMLpIRuQYwoTdjvRHBQht2LicZww/uhhkl7hIEx/u7d69JVogyJ3crBWM6LM7agODUYqFrz+SS9GNcUnkuUANKlJp1fYy9sybFmdaOuCCTm2cdWGxOFhtoj5otdqCKiJ0jJdvfv+BDEG1k6oWepXgpcYQxSTjvrlrrETIamgVekK4kD4ue4vBOhhi8BuDeLlTRw==
X-MS-Exchange-AntiSpam-MessageData: z/AqCj/kSA5LU49Pwwi6qnjVXoQQ17zusymdFEo+jHxaiWWt/pMe/8mF03bUfAQRD3gG+c/bKiZrkrzmPsyrgaK4cisxDly9RJEh4I/xID9cmKFqpTCHcI8sCRap/PtDNBTk9fnDcj/yZl+8r5ylhw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca667cde-c73c-4a3b-1111-08d7c7a3cc24
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 23:11:01.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ONqwDEUNM1vC46DdTGPWloZgCArI3VhkDmjR0Bh58dowZE1SU75+9ioQmsSMo9GhAlAlJmKPN+ug4xjuo4LjbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Family 19h introduces change in slice, core and thread specification
in its L3 Performance Event Select (ChL3PmcCfg) h/w register.  The
change is incompatible with Family 17h's version of the register.

Introduce a new path in l3_thread_slice_mask() do things differently
for Family 19h vs. Family 17h, otherwise the new hardware doesn't
get programmed correctly.

Instead of a linear core--thread bitmask, Family 19h takes
an encoded core number, and a separate thread mask.  There are
new bits that are set for all cores and all slices, of which
only the latter is used, since the driver counts events
for all slices on behalf of the specified cpu.

Also update amd_uncore_init() to base its L2/NB vs. L3/Data Fabric
mode decision based on Family 17h or above, not just 17h and 18h:
the Family 19h Data Fabric PMC is compatible with the Family 17h
DF PMC.

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
v2: rewrote commit text to not use "We" etc.,
    based on Boris' comments:

	https://lkml.org/lkml/2020/3/12/583

 arch/x86/events/amd/uncore.c      | 20 ++++++++++++++------
 arch/x86/include/asm/perf_event.h | 15 +++++++++++++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index b622e59ccdd0..f3d5e4e2f285 100644
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
@@ -223,8 +231,8 @@ static int amd_uncore_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/*
-	 * SliceMask and ThreadMask need to be set for certain L3 events in
-	 * Family 17h. For other events, the two fields do not affect the count.
+	 * SliceMask and ThreadMask need to be set for certain L3 events.
+	 * For other events, the two fields do not affect the count.
 	 */
 	if (l3_mask && is_llc_event(event))
 		hwc->config |= l3_thread_slice_mask(event->cpu);
@@ -533,9 +541,9 @@ static int __init amd_uncore_init(void)
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

