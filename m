Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF9C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2D3C2074E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="yG7+/Gin"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727582AbgCMXKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:10:53 -0400
Received: from mail-eopbgr760052.outbound.protection.outlook.com ([40.107.76.52]:55042
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbgCMXKx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:10:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnhJN4oCyYuLvDIE3lbp7iEqvnNvYnkxbDYtHvT05csWlb0q+X1ujdSWWlYW5EvTnfajhzP56/a+TobHI4T9CZV+keX1IJeN+mCMVevDjPR7I3a7CZGi3WsUrc4M2ZHH2aryZqrWirIADBXe7EbIpgS0xOPnPiYfcaI4pKRXesDhxunsEFZ02+HRMPnE9kyRyH74B+dA3K6l6pF6m9Op+lHUiwuFQzD4YZVCCHYlHXyW0nrVLmYr4DmToenWUelcOj+pvzlWiIl/3OAF5utbKyYGaTdNaK2gXuzOjZo3vUXk04SucDYwpBz7cv6XfajOQtiTKdkfbN5feWbdk5y7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMSnkJSkmKSSb/Zv/mRm0xxucNgrzF2sFKNKOPnK4aw=;
 b=QRRjiVyyLTkjjX1KXBJ8ukyraRV4KlDOx8hjSqorTDFmunj4HSGtRnHy2QBRmujHJvQhhomCabkl1w+RX+w2zKCIahZiT+ADyxrJHjQfPeab7yWfyfkSf3sykqbTbF5aKe4m6IM+lgN9UVHGkrKmZfk6I6T8j1+Q9ylOykdL/gYT0h8hIGUJDZ3xZ9RVa1hsjxP8LkDORV9XJKoNp57Irl0tpI2X7WvLsoE55uyHEZqL0LbXHT0rQ5fQk7oYVm/RzdjCpTaFlH8LvtVAslnxpO1j+8G8oss9bAuZO994b4e+etJcFrlhIk5KTa4EbbTtGL+Z54OZs1ZaSJae0OXIgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMSnkJSkmKSSb/Zv/mRm0xxucNgrzF2sFKNKOPnK4aw=;
 b=yG7+/GinQ2ApQkum1o+o6ZGRS+3lFCGZ8WwLX81ty+vSXFskLD+X0YNmkqpJfiS9lS7H0Se69oXhOZL0LjPrhlCClzKhOkY/nYsR2KT8pc23DAdBRaPGAJMafQjjwD/DNHjHQ1Wh7emqT6uQ0LE1s/5cAX3575U/NY/p12kWEEw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2846.namprd12.prod.outlook.com (2603:10b6:805:70::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14; Fri, 13 Mar
 2020 23:10:49 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2814.019; Fri, 13 Mar 2020
 23:10:49 +0000
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
Subject: [PATCH 2/3 v2] perf/amd/uncore: Make L3 thread mask code more readable
Date:   Fri, 13 Mar 2020 18:10:23 -0500
Message-Id: <20200313231024.17601-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200313231024.17601-1-kim.phillips@amd.com>
References: <20200313231024.17601-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM3PR08CA0003.namprd08.prod.outlook.com
 (2603:10b6:0:52::13) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by DM3PR08CA0003.namprd08.prod.outlook.com (2603:10b6:0:52::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17 via Frontend Transport; Fri, 13 Mar 2020 23:10:47 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 90b1c137-99ec-4106-8a4a-08d7c7a3c48a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2846:|SN6PR12MB2846:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2846A37BE237F21F4156880087FA0@SN6PR12MB2846.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 034119E4F6
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(376002)(136003)(396003)(346002)(199004)(81166006)(81156014)(86362001)(110136005)(6666004)(316002)(7049001)(966005)(186003)(52116002)(66946007)(36756003)(66556008)(54906003)(66476007)(7696005)(4326008)(1076003)(44832011)(2906002)(5660300002)(26005)(2616005)(956004)(8676002)(16526019)(478600001)(8936002)(6486002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2846;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0EogkjeC3l/MJodwd2imrK0EAJbJ0V2IDuDCnxCxgJ8zq566zyB6VvqnbzupX+VSrOW0dQqHqwU1V7aJPjdQTE+vsBjA9LOCd1kkJhGQdfO2duMwN1Co2kJSrl30taWrE9kBEh80xj1cg1/ZBwhTcQaYVis6ILRqdTzDL8Oh+OIKgltD72hF/fwB7URrrzyqSWCNy7OlOcd5JJtpaf7fieJk0Ip7INfSTVS31+tTmRutgwIBkBfnhEZ/6tE66QFyg7O8UD9kqtCXR04l5qy15wdSV1wAbJKQFxwUs5iUrGC9+F7hieCWyHx3aFWby7DfzuVDP+uspUxgmWblhi4baRLcuOjN990Xc7O44wxWEnCoNU1LaLKqW0jlsIIKXMRypiNxicMSkgvvzkvn1js1U6Pio76rYERkbdGHBHI6DA0b9ltXSTAWvjMooh9XlT/bBuroxP3YEvfILEgxemMOLOEiiiBaDDXvVS3QJfmVULy57JnfaeysAyAoAvOHN37iWkn2rU2PPwH/IZe0KQn73w==
X-MS-Exchange-AntiSpam-MessageData: RyQ27qEjAoLm/1nY6gkaKX/KkByg8f9D1PqbJmVZMh6noZVBcuE9Ppn8SENWrFXAlDVhKkBUfrk1SHyhtAMEg8dK/Cv6EqMHJ/xtn5LhcAsGM+8UFO97G+3h45CpdkdBGgjfrysK9hnwwSr4Aisu/A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90b1c137-99ec-4106-8a4a-08d7c7a3c48a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2020 23:10:48.9171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JX2+Sud4CuZ6f+hD69e4fv5D0D/h3MoP6A2udlqHUkwR2FTx5zYU/92tCTioXBHKGLxjGb+mgN4XyZJpCPu2+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2846
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the l3_thread_slice_mask function to use the more
readable topology_* helper functions, more intuitive
variable names like shift and thread_mask, and BIT_ULL.

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
v2: new this series based on splitting into two parts,
    this one being the one with the non-move related changes,
    based on Boris' review comments:

	https://lkml.org/lkml/2020/3/12/581

 arch/x86/events/amd/uncore.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index dcdac001431e..b622e59ccdd0 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -185,13 +185,16 @@ static void amd_uncore_del(struct perf_event *event, int flags)
  */
 static u64 l3_thread_slice_mask(int cpu)
 {
-	int thread = 2 * (cpu_data(cpu).cpu_core_id % 4);
+	unsigned int shift, thread = 0;
+	u64 thread_mask, core = topology_core_id(cpu);
 
-	if (smp_num_siblings > 1)
-		thread += cpu_data(cpu).apicid & 1;
+	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
+		thread = 1;
 
-	return (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
-		AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
+	shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+	thread_mask = BIT_ULL(shift);
+
+	return AMD64_L3_SLICE_MASK | thread_mask;
 }
 
 static int amd_uncore_event_init(struct perf_event *event)
-- 
2.25.1

