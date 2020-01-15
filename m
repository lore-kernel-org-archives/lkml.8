Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF913C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1E652467C
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 22:30:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JzcWo0Ti"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729883AbgAOWaX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 17:30:23 -0500
Received: from mail-eopbgr770043.outbound.protection.outlook.com ([40.107.77.43]:44102
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728899AbgAOWaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 17:30:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bs/tKgQ7Vk9jMK0RW5x1nAuogrqj6Vu1Ws5qp/keqYOaLgibo+F9dAlIoI7Om6K/odN1gtUGgsPF4pEzhd7iyMbY5vwxrMQ7xYJ4UIzTOSJ1PX6m1Yx6cFWz86HP4UeTV9A4DDKu6Z/wpx8Acol3zoAqHMUoFj+bXtmkPuOXmISjs5myS8l/5kZIHcyDS/Q/gh/gB6IBecNdlwSsll+HfBa5DB4OKaydPVrKTOM0mlucbSXIztR4KIXugxMLCDwz6oFYrNq82FKg2+6mIBqiIHFtoppWu4XtVKbAoti9bvvOtu5yQbFJspspo1884Euy3YUEaF9A3G0Ta5Cs5kguVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYrYmQookhPqxvv+OcZhTxStZ53YL+IbmwpCMy51vPY=;
 b=Pa6/fcKrztIbQIejODxr2jBiweIk4bww8LNc6E6S+V/E9RxSOKh6UDzQdlqu2GYxswjD+jJxUjV64d98NIls7VrjnCEUzukfevcWcI3kiLC1DqR8rzhfJb4K2/PNkEk5gXSZH4H+QOyINk2Upyf8KS1XLOzEB8DeAXUNoOLtNa69OvDqjvhG5ATFsP63EBS6fA3Ps4uFT6ncJdeC6FQLHdR9Jv6gcgqRIqWZocA5LC/vFTLbKpevAQRpFv7ghAPw4odrvx3D/irKIlxeZJINU6iA2no8a813VEHZQ/mPTzjLvea2OvqU/FQoGNgYpJfIczp6v9+zECj/BVi+u1MDRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sYrYmQookhPqxvv+OcZhTxStZ53YL+IbmwpCMy51vPY=;
 b=JzcWo0TinDIkA1nCvuwE7whu4P6JLoAnMYTCqrIdrNQPlgyNghRiNc8a2HwNQEwx/jY4fXC6iISjn2jCXkKMJR42I/2VUamWBsVdymb3vv2Y9kYYPDWdsDrujaUl61i3NJVlydoCczZqd0lobDeRcf+2/N6T2Vvu/19CFaKMdpU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2688.namprd12.prod.outlook.com (52.135.103.29) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.9; Wed, 15 Jan 2020 22:30:17 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::48af:8c71:edee:5bc%7]) with mapi id 15.20.2644.015; Wed, 15 Jan 2020
 22:30:17 +0000
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
Subject: [PATCH 1/2] perf symbols: Update the list of kernel idle symbols
Date:   Wed, 15 Jan 2020 16:29:48 -0600
Message-Id: <20200115222949.7247-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:805:ca::41) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by SN6PR16CA0064.namprd16.prod.outlook.com (2603:10b6:805:ca::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.13 via Frontend Transport; Wed, 15 Jan 2020 22:30:17 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 795a9f95-47a2-4269-61e2-08d79a0a7f98
X-MS-TrafficTypeDiagnostic: SN6PR12MB2688:|SN6PR12MB2688:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26888286A56DEDF825B4291B87370@SN6PR12MB2688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(199004)(189003)(8936002)(478600001)(44832011)(6486002)(316002)(66476007)(4326008)(1076003)(7696005)(66556008)(186003)(16526019)(86362001)(36756003)(5660300002)(2616005)(81156014)(6666004)(8676002)(66946007)(54906003)(52116002)(2906002)(7416002)(81166006)(26005)(956004);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2688;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rn3S6box8SJen86XKNTRUN7aOr9jRUevm/ikpVmJQw0yjedxWL8SwPL9y8FR90CSuEMyrdVzjLXsQLRV1Cd75y+yjit9gYdFpU+KGeUBDUIRB1cYtCzxCYpURseKjmi92LqnplU+MOjw3rutAcMZkkS8eY4phsPPS8XyZZhLqgtVxUZ0RNHmHjWDAV42yvxV5ScAUKBaXs22ZwgBnfvVclYqLIgrz+4nydMDm2sj9nOsknKkeSS1EDvVHrpklZO0Ens3P45LBr8+lVUMT4q1irzjP+OGHiWgi/DOhvxpPvmOQh9pHiai6r/0KJzLYrOjojFI+TGCyEa9NsNO/IQnxYbgM0nn5Ycc88UbOulhf7co7cDgJEmB68brzB1VsH1skVfX0tt/gtJI3OnsfvIw4sd2DTndYW58+Z1FTnGSCrDMna6pczk9zYord1TYvWE/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 795a9f95-47a2-4269-61e2-08d79a0a7f98
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 22:30:17.8607
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XM9HnzvpiYwRh8dswkNhM0gzt3fYIsge/lEbbRYDxGn5U+h6F+y4eG1c6TVLpy36nJ7pTgYIdicE/IOCAltoJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2688
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
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
---
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
2.24.1

