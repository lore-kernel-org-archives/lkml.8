Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB853C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:06:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86474214AF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 23:06:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="cLm6p4Xg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727478AbgBGXGi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 18:06:38 -0500
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:38039
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727048AbgBGXGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 18:06:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bqv8bHya3amvloSncxdYapWRrOBEnR7JuhWUDBCZhWZwCmjnNULtHCDYKtafGGVT1K8w0irJz4LUlO036Yx+DKSy9QQATF9vLf6LIEW7hI3I0yfSgn2CH3cd4n1Qvlo6Dctw8wyim3ru2kI//lH83biT2145mIP8NtExAwrWCZNrHclCKp9AwepeiW1YJNyIHmHJkLfQF+FJjMl2IQG0f3KG2kd3yZM7WfQMW4Txkw3PHvUsa88bZfAS84grr6MKqiATG8LLxBPiorf+B+HqeyrmdL3mfqeDW8lwKlBZoQygr+KfE7xmTE4CFl7GKHGqdDL57mOJXtAna4fuJdT8MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW8qW9NCOxkuPbINFkKQErrdNyHVY8ox4ducMOz++Fk=;
 b=Im+S5bcUKEktV35PUWNAwMgIcI9mkI7k/i2r/Jbe9b371lFGBSmQy362sxI/KwcYfvAAxqLO8k5inTJGGJPfzdEKUKUjik92dFSsd/hVJP10ffYIscZaQsShHCiZLhNhqsGKdT8U1TpkOZ4uyDdB8dwJ+LSmqnERLsUYLcfOXedkpre3g5KqY8tN7e15/v9aiuqsRyZ4KA95cqyXM0GMhfJDGswDjg59D6CCROWuJEwHQeuKh3JcTUbeIWRgRy0wciXtEbVbkrjVe6IDWinj098qLfl43KbcI/9Fsts9R0s89gz0rRuRGnV3j0DV6S4t/999TzvPAHY0lSGNvzIyVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gW8qW9NCOxkuPbINFkKQErrdNyHVY8ox4ducMOz++Fk=;
 b=cLm6p4XgWFSbBcGghpLvcPu5FygogXUbhsV0fEhFRT9o6+wK9aU+PovCGNaWSi9UuPscSMS5/0P7NY5VjSVvQdIOACBiYV9BQHm70axg7ZvlJdig78OukBCD0uShEY8ximkUJtYrESXHM2w8AJ/nNXMQCaNylBcc4u17SKJi0yA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2766.namprd12.prod.outlook.com (52.135.107.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 23:06:34 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 23:06:34 +0000
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
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 2/3 v2] perf symbols: Update the list of kernel idle symbols
Date:   Fri,  7 Feb 2020 17:06:12 -0600
Message-Id: <20200207230613.26709-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207230613.26709-1-kim.phillips@amd.com>
References: <20200207230613.26709-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:805:106::27) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by SN6PR2101CA0017.namprd21.prod.outlook.com (2603:10b6:805:106::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.6 via Frontend Transport; Fri, 7 Feb 2020 23:06:33 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fa874c2c-ad5a-48dd-d9f5-08d7ac226029
X-MS-TrafficTypeDiagnostic: SN6PR12MB2766:|SN6PR12MB2766:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27668AA758A819E947CD91FD871C0@SN6PR12MB2766.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0306EE2ED4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(199004)(189003)(16526019)(6916009)(186003)(81156014)(66476007)(81166006)(26005)(7696005)(8676002)(478600001)(4326008)(1076003)(966005)(2906002)(52116002)(66946007)(7416002)(66556008)(5660300002)(6666004)(316002)(956004)(36756003)(54906003)(44832011)(2616005)(8936002)(86362001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2766;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JuDmzs8Z5McVAxQmK1PHtaXXe3g0kEGu5xAsUw7HVlAVY39MS8Kbp7FCoK4CFAmHThb9+3YuSFRfLtdj1c7+d+wb5bgXsCh0pm4J0NWkDzWWcZrklwX5mjABhYmK5lEy6OTBqDwzFnGGPKS9o++Wu9Rqt92cUEZij9UGs+SK79qFtgp8SrYWsfx4mCw2x6ywgigKu9iNb8H8CgKVh6+Mn50ztTzmbzxn19shLYfrodPwoLkgWOOfABopWYsmYMaoxKLivsiYB3SFhmeW1XgVAvdszWaLI/JMAMqKQKGqtHkVhw5tkBaRknmvZ/Srz2dPg7o/I42jR3KHqeBImqDxMtZN7l4LHmfm07bpyoF1zigkqXKWefMNZnE2u8BWeMlzlePyvpygxAzpRgweGMxhJx/MCw+iW1gywCCCAEFEEkuKYN0v62MH746hSGcNtB4RVN6XAzPzwDN3XQtPyyJ9KehKIxAeuIvJeB5kapbacnk+a4OI5R28ljla7e/BZ987Oq9CRyobQftZivHCrQH5Cw==
X-MS-Exchange-AntiSpam-MessageData: oir6A0VMUnf/MDp8O90jAOrIsSjoykoWTsUo2IXkZv0hpGjw/FXM+xBlph5GGLPzewNck6LNAfbLsKwTS8sLJFUILbDXNgJk5O2mb2O6A/Oz6Eia21T9exD0ITXXm02aYtN48VE1FNg16ZAULpQtlw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa874c2c-ad5a-48dd-d9f5-08d7ac226029
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2020 23:06:34.0144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AITQgVUXrRBOoEcqSY+7ByU46GbNQYpZe0ZdbN8sCEXYn4oSVUjzQxdPVU2bcPHuOfsgiYno1gYO/y19eZHgCw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2766
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"acpi_idle_do_entry", "acpi_processor_ffh_cstate_enter", and "idle_cpu"
appear in 'perf top' output, at least on AMD systems.

Add them to perf's idle_symbols list, so they don't dominate 'perf top'
output.

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
Acked-by: Jiri Olsa <jolsa@redhat.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
v2: Added Jiri Olsa's acked-by:

https://lore.kernel.org/lkml/20200120092844.GC608405@krava/

 tools/perf/util/symbol.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 3b379b1296f1..f3120c4f47ad 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -635,9 +635,12 @@ int modules__parse(const char *filename, void *arg,
 static bool symbol__is_idle(const char *name)
 {
 	const char * const idle_symbols[] = {
+		"acpi_idle_do_entry",
+		"acpi_processor_ffh_cstate_enter",
 		"arch_cpu_idle",
 		"cpu_idle",
 		"cpu_startup_entry",
+		"idle_cpu",
 		"intel_idle",
 		"default_idle",
 		"native_safe_halt",
-- 
2.25.0

