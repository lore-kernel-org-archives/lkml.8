Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A17BC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C846206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="SM3XVIsH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727949AbgIAWKY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:10:24 -0400
Received: from mail-bn8nam12on2089.outbound.protection.outlook.com ([40.107.237.89]:35265
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgIAWKW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:10:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgcxHHXq6r7EoTjEOvZI+107MU3bi3zsFc4LF0Ifwi11/hkzc1gEpegENwtxjX6oSHRTq5cOMLbhOTj4OI5dFgGwIXddmgxY6eiH9jbjHirBhxLZ+TtnzaAZws81pMGWkdjR/oD5pMtwslw/RUnKWG9H7+EOCiefDXS6CH3HaQCXx9+UO2bo0eyupaRiahnI9f+6ipqwP3ZsKs/UIjeMIoe+Pba63aYDPeRcU1S7x9m3oCVATl/Ojn7hDpTMbZcUSA31x9loJeouNS+KHhoIDt0nOs14t/hRGyaIBXhGlTWcnThv4ankfAb+VihloFPuaWZ9M0boCBM/W0OesDO3cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au/LVITQyPULlI7PidbrpByUwTrfy0cMmAUOdtJBB44=;
 b=BVL9GQjgbQfSIymHcS6LQS2TsOj3VOi7L3mLVnfdElPdmS6q4Ct7nzH/NTjds9PCB6EAZix06kIqknnJWm7bRo/8vbH34HBiZUkMKWGiZJJj1S45sarfTEQ85TJWLmow08FHpjqWpo4p9HixpAgMdyPyu6Tftu8UUT0xDlh0jSc89Nxoh9YnAXvtGmBTCjFm9t9q12MvTZb8Aalu+4R6ModTCmjJUTUEk4sGT+ZRoNRDVjHFOLFBKvCwp05vVOEtAlTZDC+w/TaEfGc1buV18FC80KntVv0yUvF7X7Ho5Az0fW8jatN9PbNF5FYPWqipSExCkisuYhuu/su62f2qJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Au/LVITQyPULlI7PidbrpByUwTrfy0cMmAUOdtJBB44=;
 b=SM3XVIsHUG1suuzMvT8oKD2EbLjdcXN/lKamFF9YOAY9nsQE4Cwk3zn27kWyNGr/OM1+139NbIm0obG4K3kdpcxJKuYpj+6sRfODs8gCAWcKs+JTHaWZ8mRvRHsi6SlREr4ZYK+v6rAvMFdA3ejU1HZFpVY84jV2bKZYwsVyh7c=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 22:10:15 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 22:10:15 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Arnaldo Carvalho de Melo <acme@redhat.com>, kim.phillips@amd.com
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Vijay Thakkar <vijaythakkar@me.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        =?UTF-8?q?Martin=20Li=C5=A1ka?= <mliska@suse.cz>,
        Borislav Petkov <bp@suse.de>, Jon Grimm <jon.grimm@amd.com>,
        Martin Jambor <mjambor@suse.cz>,
        Michael Petlan <mpetlan@redhat.com>,
        William Cohen <wcohen@redhat.com>,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] perf vendor events amd: Add ITLB Instruction Fetch Hits event for zen1
Date:   Tue,  1 Sep 2020 17:09:42 -0500
Message-Id: <20200901220944.277505-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901220944.277505-1-kim.phillips@amd.com>
References: <20200901220944.277505-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM3PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:0:50::12) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM3PR03CA0002.namprd03.prod.outlook.com (2603:10b6:0:50::12) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Tue, 1 Sep 2020 22:10:12 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eb340166-9f69-4156-8f58-08d84ec3cdc0
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB01486855F86BE906ED78B5B5872E0@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rh/MTuH2A5PvfVVKsflBQ4EHS6IocnvHxtStyUs15cwZMYEVX4UJuQQ/S5lDQ7FvTjOVPU2QRpAUUZIJr7jGDR6LvXXrUaC9VgQkS6X3yK0U9qZ1SKZdiT+HHebMtUV3d8LTTCz5vfccIhXJcwCQhdKO7a2x4LxzjbOHAz1ZIHaLAo8MYK6AuJp5xyqJsh8S8HFJy/CYzHKXAp2u5xQ90bMneXJzd7DMu0F9wRThvh2+9JAqpmMuzRrUrgADdjVdUloi+g1Oy3YgkLSBayg3Fil2kyukGiavqG76adXh1ejYzL5uGzMq7Yk706EsGFGaNdt3aTGZNM9V1qrdcQo8FA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(66556008)(66476007)(66946007)(6666004)(52116002)(5660300002)(2906002)(956004)(8936002)(2616005)(316002)(1076003)(8676002)(44832011)(4326008)(36756003)(16576012)(186003)(26005)(7416002)(478600001)(54906003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: uf7DH2/Bd/BoQvY6MzWceTpiE3rBug0//g4T27u1hIX8nrc5JHyBqHEHaBYHVZQve+rbtqYHwXBNaiWTfn/rPR8vxJlRtZvDzZ9SsTWsOYaVNutXvjofj6hi3CvBX6lE9cVqj3gQ4Zt6I8OL7UKpfuUMQOhVbvrM1mtM5BT+7W8zhLUhZm2+gp+Y5UZeHvdYer9zA5WZR3iDlzINeAUHOLssrwe0ZXs8BU1bvoaiR0gkp/GdJdVrkWh/AFTZcQ9rCSnqZnTF+14dGVBG2mEy2Ih0N7KJcCrUABHt04mVz+wGPHZlmZtODvPp08Jf867uegn49c7OBRoYMhYvUrLVmzgz0dMTNDa+NOxxJiB0378SQpjkASWJq+TIEcez/Q/DTanP9C4t0lUgHIEQw6R3vCnpIJVAmHZggcHk23Sqi1VTuLe8LUvkXTbelrhrmA03Pl6UOLHe/XH13nOdC8sKgGfMbCWfqF/tGNUAIWkzvsrYVOD9nbbDKVdG+NARyfeYoFAZlIIMlhmt9HemqH7GI6g1P/Wq22wcdH4j7rEs/tODieFFgdleO/WxykxpO8DtbJdNUum1HW1a+8ulQnMgjz/2icBRj+f5soYDaJe9LK1YdsUnXSN1uHMIuEh3w7o9p0jKU2or3KkebgmO0PI4KA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb340166-9f69-4156-8f58-08d84ec3cdc0
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 22:10:15.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aLMSbXzi86hVzZ1ANbQNJetVIf2PiO2YaSnGHNIbfA+CgaeErsYboCVtH/ImeRV5CvsOdVGeRo9AHj9koq0ZSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ITLB Instruction Fetch Hits event isn't documented even in
later zen1 PPRs, but it seems to count correctly on zen1 hardware.

Add it to zen1 group so zen1 users can use the upcoming IC Fetch Miss
Ratio Metric.

The IF1G, 1IF2M, IF4K (Instruction fetches to a 1 GB, 2 MB, and 4K page)
unit masks are not added because unlike zen2 hardware, zen1 hardware
counts all its unit masks with a 0 unit mask according to the old
convention:

zen1$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1

 Performance counter stats for 'sleep 1':

           211,318      cpu/event=0x94/u
           211,318      cpu/event=0x94,umask=0xff/u

Rome/zen2:

zen2$ perf stat -e cpu/event=0x94/,cpu/event=0x94,umask=0xff/ sleep 1

 Performance counter stats for 'sleep 1':

                 0      cpu/event=0x94/u
           190,744      cpu/event=0x94,umask=0xff/u

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Vijay Thakkar <vijaythakkar@me.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Yunfeng Ye <yeyunfeng@huawei.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: "Martin Liška" <mliska@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jon Grimm <jon.grimm@amd.com>
Cc: Martin Jambor <mjambor@suse.cz>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: William Cohen <wcohen@redhat.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/perf/pmu-events/arch/x86/amdzen1/branch.json | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
index a9943eeb8d6b..4ceb67a0db21 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/branch.json
@@ -19,5 +19,10 @@
     "EventName": "bp_de_redirect",
     "EventCode": "0x91",
     "BriefDescription": "Decoder Overrides Existing Branch Prediction (speculative)."
+  },
+  {
+    "EventName": "bp_l1_tlb_fetch_hit",
+    "EventCode": "0x94",
+    "BriefDescription": "The number of instruction fetches that hit in the L1 ITLB."
   }
 ]
-- 
2.27.0

