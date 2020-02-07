Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22D0C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77C0721775
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cgweB7c4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727317AbgBGXG1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 18:06:27 -0500
Received: from mail-bn8nam12on2068.outbound.protection.outlook.com ([40.107.237.68]:37345
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbgBGXG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 18:06:26 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gNNZe6q0bydAItExf++he1abeeawb3yhaWV/H/zdQR9oeg0J8vYh8OG3LOig3NDZiplmSvaxShqRVuYVshBdqcGEXHuPwQbb7DFGyCda+MK/c0A5vx0zvWXDzcNlmCI7PrfvLdnTphPLoG6jqxIAbhmr3MkgOl+muQ3oYhz4pWSea7JV0Sr7LRBvjXz+ocGECUbv98rLFt9d2gLbeOAAU8JT6t7dc5GyHXanBu0dBdY+TQvJ4BSszvpzW4EJ+FCbb7tpdwhuAfYOHkAUewyu9xARuAtBT++6xuaOFwQKzwBRZU4RrfafmGnRcgvEJS/LaQkgjCylaOFBNOsuzkxXZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Byz6SExST8j/v9mevD5QssBqC/QSBNYvQTyA4/SlD3E=;
 b=bxzJ6DdY9A2oxsta4zEFyzr/Q51xSiqvGTVPdBCjCT6/0QrP6CvsFlONTw5VtSSA6Ahieb9IdZ3qkLot8Jz1u2v4WdW2Nr+kkY0AwU+bLeFI6/pM4U9/AF0qMaa/PomkfSbtUqq+9L7UXO3aANJSFg19TT7rpD5KxjCViaugRQv63hMbMHua09mwHA6SQpq1XKGYpUQwd0g2sJGBFRfgdGErosj1Yon2wMXQsnV2UXkJdveN1LDxIIxSKNUCvyVn6gjg9u2v13N5R1KkqWtPMa58k29TufQXDtObzavd+EuFGyTDODJ7FNiTpo3IgcNm6n+NLJbP2k40efujbYp3lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Byz6SExST8j/v9mevD5QssBqC/QSBNYvQTyA4/SlD3E=;
 b=cgweB7c4f2D7uGCsgueuCtJDMkQWSCpXZLec3gx6EMFiWxPFf961iXP0muUtWY66Zx75ETh5Ut7xz7hEeAbyG+wCIhxpxKpHcMrUMSXpLB9VDggw89kV7zkgW6BEk/zQg7Lw/sfA3tbMX/sNs1sN3EZ3PmclQp9gmyPWmrSsZwE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2766.namprd12.prod.outlook.com (52.135.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 23:06:22 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 23:06:22 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
Cc:     Kim Phillips <kim.phillips@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 1/3 v2] perf stat: don't report a null stalled cycles per insn metric
Date:   Fri,  7 Feb 2020 17:06:11 -0600
Message-Id: <20200207230613.26709-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0029.namprd21.prod.outlook.com
 (2603:10b6:805:106::39) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by SN6PR2101CA0029.namprd21.prod.outlook.com (2603:10b6:805:106::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.5 via Frontend Transport; Fri, 7 Feb 2020 23:06:21 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d7591ecb-525d-4303-2b3e-08d7ac225958
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:|SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2766E84C445132ECE5EF74B3871C0@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(16526019)(6916009)(186003)(81156014)(66476007)(81166006)(26005)(7696005)(8676002)(478600001)(4326008)(1076003)(966005)(2906002)(52116002)(66946007)(7416002)(66556008)(5660300002)(6666004)(316002)(956004)(36756003)(54906003)(44832011)(2616005)(8936002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2766;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2OdiN6wwA+P12u8hpI/3rXJNJLiqJ3cXl11M26bBZRlYRK83U+K43N1M6xugJ9/8I4TLJcQlVkQcFzJfxd0qKoTclWeJY0eDOOarw4L7CBC8bYN21ub2zPRwci1iPqHDI9UrqD+7aAEgyq8aunA8m+Sa1vegi9rGLEEJrW3pEnhoLzW7gJ1DJNJATfKzakV9pqi6tIYQbFU6M/+KMrq/6ytuwJIYH9DvWn9LoSPbdbRhph7F4f8G3JK0WmaJEWw6p63jUuEr3xYqMSVP9SV+zAz9j0NEDUdlvvL+ytaMy1kreakt8um7iD/lsrASDoS4gZm+B4Y3475TFfGJA/fY/KW6ipOuOzMqOokWF0i39874YCPVHhQXenkO/sS7T7u4rETUjcllTIPAGOAEw0ec27IHfMegQhLGCfYXfLjtj3P+b16o3cpdtc9N9BgnMeorV7XzSfvekSvYNUYMUqZY5fAVp6pmgtWt+u72gS4GLfg+Gd7o6o4uMlll0YBObg4cHcUoVKP+vPf4pNpouc4TUQ==
X-MS-Exchange-AntiSpam-MessageData: y3FYkCmSERV5Lim1mGbADCtoz7iVhhjokUdl/cyb7+AprzKkUBTEL996wZtFzyzzlq3Rz1BkHNxn9zL10cv6MuRBTQ6F34cPnYXOxPVt+DSlJQgIYUiK1//vQszstaVU/64WahP/W1taR9zrkvZzrg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7591ecb-525d-4303-2b3e-08d7ac225958
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 23:06:22.5869
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ol9sCPJVfW7M+iFJXc15uHr/FhT+Fg/iyGgwlw0zIoh9ZKd/pdvQTiNoM85eTU46t0jtc00YAGFvqr0/jXogrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
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
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Kim Phillips <kim.phillips@amd.com>
Cc: Song Liu <songliubraving@fb.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Jiri Olsa <jolsa@redhat.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Fixes: 146540fb545b ("perf stat: Always separate stalled cycles per insn")
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v2: Added Acked-bys from Jiri Olsa:

https://lore.kernel.org/lkml/20200120092928.GD608405@krava/

and Andi Kleen:

https://lore.kernel.org/lkml/20200120115720.GQ302770@tassilo.jf.intel.com/

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
2.25.0

