Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F87BC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0836B2465A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:30:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="S02rQzF3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730216AbgAOWaf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:30:35 -0500
Received: from mail-eopbgr770040.outbound.protection.outlook.com ([40.107.77.40]:56832
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728899AbgAOWaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:30:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oAJvtlX+r837dxiKqYeXfh7/y9CR2Q1FKt8IcGYzFT1Jc6k7inSqqMK7caPOfjkS8KYAxIpmIsnPB5uWnuLLO+jl79oCkfh5C8xopRQzRCPx8zlFuplx4zepaW4DA4pE8zrTIy4UMUc8jCevtv9B56q3pTSYeDtBau0eCUgq+jc/kB2KV/tNwwgw0wBsZ+RnUogvSc+QFTyo+AJ6Im5qdt9LSiWcE9Ll4WWg10myq/0Kb1Lp3ZMxmyDFBk3HKRvh/Kj/g5KectgZxHadB2Wz4LVVfbAubu4Fads7ZvGBq1o6auRHPoAVEJCkfSjwTAClLa+8wcf0voyEPXev+2cyAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy6hBmLkh91640EBj6ZUlCc0lZHvTpFkbkW/Zpa+J18=;
 b=LyeTGcIgmLtIV9+KKoglVNgMS+fg1eotOb+lPXNos8JawUECah3D4Bwt4+JlxZ/kItvOVoC9XdDiQ4249HsD929DoSk+sm9iWscdqjS8CAt8D3mJxfzDIlJZgllYsoAU/d5WtgTJTiJfZJC4zmMLPUlmOi9tk5uJz6wytnrFRvtXGyUUexcg10pnoo54ugNNtCzYcgWcKOdpzmxKyJHASS9x40KepoWncqP3zQvjwMP1avTEbTVH8S+Izg54EctICKcMfrSQKU+QtXE987bsN3Xfd5N0nXO3YYzOlo6zEbyO3m9tUgrV26DX1Ma9Bm6NySYc0X5/xEtO+JdF0Lpk5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xy6hBmLkh91640EBj6ZUlCc0lZHvTpFkbkW/Zpa+J18=;
 b=S02rQzF3g7scZfKj5G9QHY3XRNHeT2LK2hK7PR9rG2wsa5t/CeR8JoFNZe5nPn9BPArSWWedCjLh8HlmZYUhMiPrN3MsiZMw3lyl02MSG5fSaDeccgPeGW44xuLCfijA7hoDEg1xzjvLk8y50l/8+2mCMgpRCLz3/tDShLUHytc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 22:30:29 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 22:30:29 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] perf stat: don't report a null stalled cycles per insn metric
Date:   Wed, 15 Jan 2020 16:29:49 -0600
Message-Id: <20200115222949.7247-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200115222949.7247-1-kim.phillips@amd.com>
References: <20200115222949.7247-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0020.namprd05.prod.outlook.com
 (2603:10b6:805:de::33) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by SN6PR05CA0020.namprd05.prod.outlook.com (2603:10b6:805:de::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.10 via Frontend Transport; Wed, 15 Jan 2020 22:30:28 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 35c7f93a-ed8e-4378-e116-08d79a0a8698
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:|SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2688C69C9884EA33EF8711CB87370@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(8936002)(478600001)(44832011)(6486002)(316002)(66476007)(4326008)(1076003)(7696005)(66556008)(186003)(16526019)(86362001)(36756003)(5660300002)(2616005)(81156014)(6666004)(8676002)(66946007)(54906003)(52116002)(2906002)(7416002)(81166006)(26005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zNyOQaliUPv6o42AnT7lUPtST+UXNIQJ8Rxljd16rz8R07ZSo0xRSJq01I3TdO+tETLTM4x06CL+7M8wGlgqXoHtzp6pQuCCWIbaa8kK6JorSxEYU6/7CnIeLE+dKQZyjBKTddTW5A4hsf5WKx79kCnJx3rUqtXIOPvWqJQ3cvAjTpHgASGqlKiOtg38Wn3UHque3ds7PKv9B6f4K8AQOtmezpvV4Oy8oL6YBc57stsnW3zbqH/v5r7/OI9EEbgQrK8NQXYcycsT4diNyc1KNKGWRZBqqkfENeMTf1SooOZVaRcGIcMgd4Lwrsn63b2B6Q2AFj65hMzXrRKYf2jxWhnyL/YHCqp18ef//3iayqbaQyASULe4vmhW5DOucOvIXRJ1iMi30VvMENv/81Kt+nsJDzOR5SHLarDQBIFHbIQPuYWibrrq8EmB+76QTiPy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35c7f93a-ed8e-4378-e116-08d79a0a8698
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 22:30:29.5950
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iXkZGmvhCNMqP+FcHFPKOYNEGnbeoK60Uk0SQ3q20GoxXL4ZXZFTyFQqhbvQ3ZaWbKhHlGIVozL8GqQn8E/1KA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For data collected on machines with front end stalled cycles supported,
such as found on modern AMD CPU families, commit 146540fb545b ("perf
stat: Always separate stalled cycles per insn") introduces a new line
in CSV output with a leading comma that upsets some automated scripts.
Scripts have to use "-e ex_ret_instr" to work around this issue, after
upgrading to a version of perf with that commit.

We could add "if (have_frontend_stalled && !config->csv_sep)"
to the not (total && avg) else clause, to emphasize that CSV users
are usually scripts, and are written to do only what is needed, i.e.,
they wouldn't typically invoke "perf stat" without specifying an
explicit event list.

But - let alone CSV output - why should users now tolerate a constant
0-reporting extra line in regular terminal output?:

BEFORE:

$ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1

 Performance counter stats for 'system wide':

       181,110,981      instructions              #    0.58  insn per cycle
                                                  #    0.00  stalled cycles per insn
       309,876,469      cycles

       1.002202582 seconds time elapsed

The user would not like to see the now permanent
"0.00  stalled cycles per insn" line fixture, as it gives
no useful information.

So this patch removes the printing of the zeroed stalled cycles
line altogether, almost reverting the very original commit fb4605ba47e7
("perf stat: Check for frontend stalled for metrics"), which seems
like it was written to normalize --metric-only column output
of common Intel machines at the time: modern Intel machines
have ceased to support the genericised frontend stalled metrics AFAICT.

AFTER:

$ sudo perf stat --all-cpus -einstructions,cycles -- sleep 1

 Performance counter stats for 'system wide':

       244,071,432      instructions              #    0.69  insn per cycle
       355,353,490      cycles

       1.001862516 seconds time elapsed

Output behaviour when stalled cycles is indeed measured is not affected
(BEFORE == AFTER):

$ sudo perf stat --all-cpus -einstructions,cycles,stalled-cycles-frontend -- sleep 1

 Performance counter stats for 'system wide':

       247,227,799      instructions              #    0.63  insn per cycle
                                                  #    0.26  stalled cycles per insn
       394,745,636      cycles
        63,194,485      stalled-cycles-frontend   #   16.01% frontend cycles idle

       1.002079770 seconds time elapsed

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Cong Wang <xiyou.wangcong@gmail.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Fixes: 146540fb545b ("perf stat: Always separate stalled cycles per insn")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
 tools/perf/util/stat-shadow.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 2c41d47f6f83..90d23cc3c8d4 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -18,7 +18,6 @@
  * AGGR_NONE: Use matching CPU
  * AGGR_THREAD: Not supported?
  */
-static bool have_frontend_stalled;
 
 struct runtime_stat rt_stat;
 struct stats walltime_nsecs_stats;
@@ -144,7 +143,6 @@ void runtime_stat__exit(struct runtime_stat *st)
 
 void perf_stat__init_shadow_stats(void)
 {
-	have_frontend_stalled = pmu_have_event("cpu", "stalled-cycles-frontend");
 	runtime_stat__init(&rt_stat);
 }
 
@@ -853,10 +851,6 @@ void perf_stat__print_shadow_stats(struct perf_stat_config *config,
 			print_metric(config, ctxp, NULL, "%7.2f ",
 					"stalled cycles per insn",
 					ratio);
-		} else if (have_frontend_stalled) {
-			out->new_line(config, ctxp);
-			print_metric(config, ctxp, NULL, "%7.2f ",
-				     "stalled cycles per insn", 0);
 		}
 	} else if (perf_evsel__match(evsel, HARDWARE, HW_BRANCH_MISSES)) {
 		if (runtime_stat_n(st, STAT_BRANCHES, ctx, cpu) != 0)
-- 
2.24.1

