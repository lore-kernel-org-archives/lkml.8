Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F448C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:32:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09149206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 23:32:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZuvilEIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCWXcR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 19:32:17 -0400
Received: from mail-dm6nam11on2074.outbound.protection.outlook.com ([40.107.223.74]:25448
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726203AbgCWXcR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 19:32:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iHzFXlgGnK1yPle8nkEviHuyI4NPuTaaiGEkSgmhSYziA2irD0l8auocvthrbswUa8RmxfKEn6vYGXslRFh5DVQLiI+qctD8nKcZRPA4QI2SiBruLwpB6y8Gm+w+Mr+Q7WvrZasBSZjwP+J1qGXPm/pahxQVOgcXr+TIInhR0gDzb1ynTkq4HAxG3vlWjIjUZHYNAtjIw3E6AmJctVAbaBp/1wTtiH25stto2ZE2Oir0uBGYvPZBBcYJAKtRTRs4IBnM8h5Xyl1L2qUqG67pVBZGBU/xTkmL8Z9vHHGkva8KCyFtBdz5f3+OcYCWnS+REN8CZgjpcEicYow4MIcAjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbWjwDyJbgKKIFJ/eDK+V+dNv09mkJebB/TfuX4qZ5s=;
 b=kRDP+nda43f1xNsTBQF4NBo1JVtS3Pg6GoqE9dAsHO1onkJAuy32O/JtCLe0NWfiL8rDeGF8/sfcHby5EvbhxQD7kqKTkmAJPQ+lDPlgVTNYWsXzaTKDP+1u4aEemfsZmfUhs5Mkdu0KbP2Gsoh88pvwyouQ0+4Q8o+1LBxz/YaQjIgrZJDgHzyLIZop7ucd0TIWaANfPBGqEgPoDijxP9im7Zz6E00w09U8HAyatzLVDfQhbiz1VojwIPtA+eujPBh8qBWYUvyYfh4Uu3wBSJwH6VB9k9/1V/RMmWtk2bxc5DbA0Ba6Y/3uQOn0FMmcKOLQlxOAHa31FOmGEyhWxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wbWjwDyJbgKKIFJ/eDK+V+dNv09mkJebB/TfuX4qZ5s=;
 b=ZuvilEILL3H9lLBBQ5WjqSM7yHc+//0ZDesShP/HFL2n2xO93z+NpyUXmfayxg7zQs05lzhivouF0E+msmJWjDegQV19Gd2wR2s2lTNdzXymB8vuiJydfq+Sjs8I48dOo1NDxPE6eCFOa2gb5FMmCEJ1nQFQUQfVn0pBJglhsKo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2718.namprd12.prod.outlook.com (2603:10b6:805:6f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.22; Mon, 23 Mar
 2020 23:32:11 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2835.021; Mon, 23 Mar 2020
 23:32:11 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Stephane Eranian <eranian@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH] perf/amd/uncore: Set all slices and threads to restore perf stat -a behaviour
Date:   Mon, 23 Mar 2020 18:31:59 -0500
Message-Id: <20200323233159.19601-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN6PR11CA0016.namprd11.prod.outlook.com
 (2603:10b6:405:2::26) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amdsos-demo.kimphillips.home (165.204.84.11) by BN6PR11CA0016.namprd11.prod.outlook.com (2603:10b6:405:2::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.19 via Frontend Transport; Mon, 23 Mar 2020 23:32:09 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 28bc6f60-1aa3-4e67-1fe7-08d7cf826916
X-MS-TrafficTypeDiagnostic: SN6PR12MB2718:|SN6PR12MB2718:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27181C34AD965A547A3D97FB87F00@SN6PR12MB2718.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:655;
X-Forefront-PRVS: 0351D213B3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39850400004)(376002)(346002)(396003)(366004)(136003)(81166006)(2906002)(6486002)(316002)(8936002)(81156014)(66556008)(6512007)(478600001)(66476007)(66946007)(5660300002)(16526019)(26005)(6666004)(186003)(7416002)(44832011)(86362001)(956004)(2616005)(36756003)(52116002)(54906003)(7049001)(4326008)(8676002)(6506007)(110136005)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2718;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bDd9tMB6RcPMV/22r5apSOeWE+KZ2RjhKf4pZJGf+iTjYWekQ5tZ5Y1VkY3qnPRwu2vMjx2M0idP1N0LEtynJVQUWiblpIdlrhwaETVapqXkpAxr+R6obAv73c3j7tkQ3Jb/pd/tzKArDF13swFAcP91r80g324nR+7gMZPszQ2bwiob74WjC669pGchy/wayS3LendwfjgBO0wgtEfcUcizGk0y8p4oYWYLsQoUyI1sVfZILOOFTYeooCrvVg4f8+3ZFKhpjlFOfzuA5T/StLY2SrdzkXRKWP16GODqQYaxYUud3CbHPFQ4Dj2nwHZKbDTJl9J//kh+YMUsUNR//zDUmtgJjwlL/Rwnl3txZXxegH2GPV3/mfeOYSebDcppvl16ThEdW4N5TiAFgbfiLEDwxfuXSFhf48qPwjTAEMYGIKThYRYKp1b5d7aGdvhB
X-MS-Exchange-AntiSpam-MessageData: kX/XsMNgJol779mccvnMSkUHRKpcSMOiP+q5wdAzcNpKZczWw4w8gBMeobG/gby7A79kdLiJ9S5A36sdzSd46g6+m5xIseiGWWOUTObw1Xw1Y3VXPEtq754pjZGHQ3tNfQ0IfXMBWTqj5SDDMA3Lgg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 28bc6f60-1aa3-4e67-1fe7-08d7cf826916
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2020 23:32:11.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4SAY4r9AGeDC9/tVjTiLqrh8QY5wjjUZ2ZypEGM5cIcPIiZ5z8JVENMqVwVlUU6onQCCUXywQt3vRJZcIeKhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2718
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2f217d58a8a0 ("perf/x86/amd/uncore: Set the thread mask for
F17h L3 PMCs") inadvertently changed the uncore driver's behaviour
wrt perf tool invocations with or without a CPU list, specified with
-C / --cpu=.

Change the behaviour of the driver to assume the former all-cpu (-a)
case, which is the more commonly desired default.  This fixes
'-a -A' invocations without explicit cpu lists (-C) to not count
L3 events only on behalf of the first thread of the first core
in the L3 domain.

BEFORE:

Activity performed by the first thread of the last core (CPU#43) in
CPU#40's L3 domain is not reported by CPU#40:

sudo perf stat -a -A -e l3_request_g1.caching_l3_cache_accesses taskset -c 43 perf bench mem memcpy -s 32mb -l 100 -f default
...
CPU36                 21,835      l3_request_g1.caching_l3_cache_accesses
CPU40                 87,066      l3_request_g1.caching_l3_cache_accesses
CPU44                 17,360      l3_request_g1.caching_l3_cache_accesses
...

AFTER:

The L3 domain activity is now reported by CPU#40:

sudo perf stat -a -A -e l3_request_g1.caching_l3_cache_accesses taskset -c 43 perf bench mem memcpy -s 32mb -l 100 -f default
...
CPU36                354,891      l3_request_g1.caching_l3_cache_accesses
CPU40              1,780,870      l3_request_g1.caching_l3_cache_accesses
CPU44                315,062      l3_request_g1.caching_l3_cache_accesses
...

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Fixes: 2f217d58a8a0 ("perf/x86/amd/uncore: Set the thread mask for F17h L3 PMCs")
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
Stephane, if you want to replace this with the manual thread
specification patch you have, that's fine with me.

 arch/x86/events/amd/uncore.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 76400c052b0e..e7e61c8b56bd 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -181,28 +181,16 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 }
 
 /*
- * Convert logical CPU number to L3 PMC Config ThreadMask format
+ * Return a full thread and slice mask until per-CPU is
+ * properly supported.
  */
-static u64 l3_thread_slice_mask(int cpu)
+static u64 l3_thread_slice_mask(void)
 {
-	u64 thread_mask, core = topology_core_id(cpu);
-	unsigned int shift, thread = 0;
+	if (boot_cpu_data.x86 <= 0x18)
+		return AMD64_L3_SLICE_MASK | AMD64_L3_THREAD_MASK;
 
-	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
-		thread = 1;
-
-	if (boot_cpu_data.x86 <= 0x18) {
-		shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
-		thread_mask = BIT_ULL(shift);
-
-		return AMD64_L3_SLICE_MASK | thread_mask;
-	}
-
-	core = (core << AMD64_L3_COREID_SHIFT) & AMD64_L3_COREID_MASK;
-	shift = AMD64_L3_THREAD_SHIFT + thread;
-	thread_mask = BIT_ULL(shift);
-
-	return AMD64_L3_EN_ALL_SLICES | core | thread_mask;
+	return AMD64_L3_EN_ALL_SLICES | AMD64_L3_EN_ALL_CORES |
+	       AMD64_L3_F19H_THREAD_MASK;
 }
 
 static int amd_uncore_event_init(struct perf_event *event)
@@ -232,7 +220,7 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * For other events, the two fields do not affect the count.
 	 */
 	if (l3_mask && is_llc_event(event))
-		hwc->config |= l3_thread_slice_mask(event->cpu);
+		hwc->config |= l3_thread_slice_mask();
 
 	uncore = event_to_amd_uncore(event);
 	if (!uncore)
-- 
2.20.1

