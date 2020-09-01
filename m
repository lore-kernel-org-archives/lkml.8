Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,RCVD_ILLEGAL_IP,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD06C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:10:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 910EE206F0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 22:10:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zTowO2Ns"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgIAWKp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 18:10:45 -0400
Received: from mail-bn8nam12on2073.outbound.protection.outlook.com ([40.107.237.73]:21376
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726352AbgIAWKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 18:10:41 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFHWe8v+Isi4WBcSEWZYX04uyodpz+qDxgGPd+Lb4iXzaDV6e22GF7kAN7DU1uLrXzuxoSPcntRDcSlc7pMmw+EM8YK9xkeUYQ289g6tZsUHvnHVttMYWwssNVYUzrlP+pDPn92HgwrlV2i6xPmYsVcMqL0JLn+LPgFFBxPBYE2dTqczi/NFHwQ2KgQjb+AwZ4O7/8CHQBNZfCOV9tUSB9Ygst+JXTUXccuxO6a+aQBlEtyJlqb3SX6U7sQAmrDqc6ipZvDz/vbL9Sc3JdIX+sqRM7LocTcuactECG4rePi4le+lDwjPOB4gaNJUZ3S/g/WOmU+rkEXrdeoCKlkDrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po4lD1ys5PDqVitz+XOgdy4gqzcRu+wiDZweXjr/CmE=;
 b=DgwrdTDvJjpKWHkWpeTOmpncXL1AGX1J/KV+Web90/E48NOtZwFngIclUgq54yPvKDI4ZjszgtZMCTY2d5z2xm5wsn4OeSNpnkhLhecNr4SU5VehQ3CfkHNpi3hJ5bAQOwi9Qtl6AEuz/PO0j+ZBOMURIqzD94FwBUXNiBVSw7ivRGhnq49wdNYmN6sDhrHkHanZKdLRPfrxj8ml/jFj1EMdBAFnk5bpm7hdBObPMjuQc7gBffdCvTumImOOUcAejfXSyDhN7i3LVI4laEbHPRK72DK6B2XSde3ymjR813DX+ln4hcYSv7wjpWRt7QPU4m2jdw6vV8x3I0uwptiLcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po4lD1ys5PDqVitz+XOgdy4gqzcRu+wiDZweXjr/CmE=;
 b=zTowO2Nse33D7Jr3QJ8zy/SSsJP93iV4PeodNq9ANq3AY2yFDQoVseb6EzymcYWyr6C5/OTWUwACpkRRS1erUZxq7wXAintrI33CfimVMMmRwKLpsWlRmdFp5a7t+AUmfk5JgqdkkoMQQPMhQdrZhCu9ltIabyek8rJX8Bc9Kdg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR1201MB0148.namprd12.prod.outlook.com (2603:10b6:405:55::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 22:10:30 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 22:10:30 +0000
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
Subject: [PATCH 3/4] perf vendor events amd: Add recommended events
Date:   Tue,  1 Sep 2020 17:09:43 -0500
Message-Id: <20200901220944.277505-3-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200901220944.277505-1-kim.phillips@amd.com>
References: <20200901220944.277505-1-kim.phillips@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM3PR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:0:50::11) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by DM3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:0:50::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15 via Frontend Transport; Tue, 1 Sep 2020 22:10:27 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a28d0922-b1de-4508-98da-08d84ec3d6b8
X-MS-TrafficTypeDiagnostic: BN6PR1201MB0148:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR1201MB014884247BD0824A26E23BD4872E0@BN6PR1201MB0148.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o3HnHEOwpNwllX48lCmhag7hnHhr8SN9UlpltjXdZJxuSlY1JcNODWiU893GmFKTP+KeJSyEjqXmt+Pw4jh5PS3TNsV3EKFog94BYrMK0tz8xruy56wZXrj86Jj42L43NAO8CX4zjOWesQ3CdQTfq7/4SkLoBdQE1VIgZ5hF0vozGg4E7X4Q9jtE37E178cR/dt+tgXSx+VUqVs/A+D1EUfZfGNNy8wFvTDfeTjZd9rZ1DPoy4jGz5D7DxG3WqMhK1LfTt7AOxfP7zWmqJ31PTrhX9iUAh6lPYd3zCsNcY6DcaYgYJ34Rcl4l+HwI7VqTTSE2FUCo/9T+2ZaHogLwHR52vGjnY1LXpjGLC8Nk8uKJbYrtwIZL95EZmEWFMtgEKouWQghOWGLpdRNAg8LCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(136003)(366004)(376002)(66556008)(66476007)(66946007)(6666004)(52116002)(30864003)(5660300002)(2906002)(956004)(8936002)(2616005)(66574015)(316002)(83380400001)(1076003)(8676002)(44832011)(4326008)(36756003)(16576012)(186003)(26005)(966005)(7416002)(478600001)(54906003)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: veQgVUA/YlL6B/kKhmDwzc1OYiPGtA4H/zAYe9C7Lw9xjUn4A1Vm6L9ycl1UZ0xA6bey8dljVGFjaGHrEg8xQtqOBljfkTgP/Zw7vMOymLcMvrEGRswdQTKrmm0oYQnR3WfItzk/3y0bOG7iW/Rlx9BSOcvhIvnUIDLm6gV6ghR87NcNtKsCFQ9ER3ENrAziMS7th7BzSlDin1EK+MpBkORBk5N4i/YaAsbdiu/1IYyVJHMdmRVNjcVw38o012J0xfs6PfFcP1Mt3N3ul849ashM3SJChbV6vcjJ+Eyi4jDqWaoH2duJkj9xGiONwMTJWfbZwmgekMpc3uEagBDHoQ4kJWsbvmSopSHcW/FIlvODQ1TPXxVGoorhiKmRdUNs8v6bRwsqsVdz0kvSU6RLw5/dFh5vLRrrHf4WMbn5HrpZyC3jsMbpxHcXOTCf43ty1VNhpr2vGQDlUVfSGjc0WoxqKELp/f8LjwTL1KVPs2DMWB+Kyo5QPViqy1KD7BSSvEesiGfgSKMc3ciDgspgzzU7IH+wmIHHg+997f2DudJ0CG5Udx5PIaT95qiZYWDQvxKK01t+FhYN3JL6xnpKHZ45e++IDGckJ0AJhqgDRCoFjOU9AMdZggEr9212Adon2G07WQzXZ1Bb+ExJdqU0Eg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a28d0922-b1de-4508-98da-08d84ec3d6b8
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2020 22:10:30.5393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eNaadUk6n16Q3WbM1uUZDzS7RAwVY/s/eqt39znsDGHIOb0cv2x23g6IyA1h/OT7O0LTyn5w3taVzU+ypQRVbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0148
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for events listed in Section 2.1.15.2 "Performance
Measurement" of "PPR for AMD Family 17h Model 31h B0 - 55803
Rev 0.54 - Sep 12, 2019".

perf now supports these new events (-e):

  all_dc_accesses
  all_tlbs_flushed
  l1_dtlb_misses
  l2_cache_accesses_from_dc_misses
  l2_cache_accesses_from_ic_misses
  l2_cache_hits_from_dc_misses
  l2_cache_hits_from_ic_misses
  l2_cache_misses_from_dc_misses
  l2_cache_misses_from_ic_miss
  l2_dtlb_misses
  l2_itlb_misses
  sse_avx_stalls
  uops_dispatched
  uops_retired
  l3_accesses
  l3_misses

and these metrics (-M):

  branch_misprediction_ratio
  all_l2_cache_accesses
  all_l2_cache_hits
  all_l2_cache_misses
  ic_fetch_miss_ratio
  l2_cache_accesses_from_l2_hwpf
  l2_cache_hits_from_l2_hwpf
  l2_cache_misses_from_l2_hwpf
  l3_read_miss_latency
  l1_itlb_misses
  all_remote_links_outbound
  nps1_die_to_dram

The nps1_die_to_dram event may need perf stat's --metric-no-group
switch if the number of available data fabric counters is less
than the number it uses (8).

Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
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
 .../pmu-events/arch/x86/amdzen1/cache.json    |  23 +++
 .../arch/x86/amdzen1/data-fabric.json         |  98 ++++++++++
 .../arch/x86/amdzen1/recommended.json         | 178 ++++++++++++++++++
 .../pmu-events/arch/x86/amdzen2/cache.json    |  23 +++
 .../arch/x86/amdzen2/data-fabric.json         |  98 ++++++++++
 .../arch/x86/amdzen2/recommended.json         | 178 ++++++++++++++++++
 tools/perf/pmu-events/jevents.c               |   1 +
 7 files changed, 599 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
 create mode 100644 tools/perf/pmu-events/arch/x86/amdzen2/recommended.json

diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
index 695ed3ffa3a6..4ea7ec4f496e 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/cache.json
@@ -117,6 +117,11 @@
     "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
     "UMask": "0x1"
   },
+  {
+    "EventName": "l2_request_g1.all_no_prefetch",
+    "EventCode": "0x60",
+    "UMask": "0xf9"
+  },
   {
     "EventName": "l2_request_g2.group1",
     "EventCode": "0x61",
@@ -243,6 +248,24 @@
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2.",
     "UMask": "0x1"
   },
+  {
+    "EventName": "l2_cache_req_stat.ic_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache requests in L2.",
+    "UMask": "0x7"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2 and Data cache request miss in L2 (all types).",
+    "UMask": "0x9"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request hit in L2 and Data cache request hit in L2 (all types).",
+    "UMask": "0xf6"
+  },
   {
     "EventName": "l2_fill_pending.l2_fill_busy",
     "EventCode": "0x6d",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json b/tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
new file mode 100644
index 000000000000..40271df40015
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/data-fabric.json
@@ -0,0 +1,98 @@
+[
+  {
+    "EventName": "remote_outbound_data_controller_0",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 0",
+    "EventCode": "0x7c7",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_1",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 1",
+    "EventCode": "0x807",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_2",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 2",
+    "EventCode": "0x847",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_3",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 3",
+    "EventCode": "0x887",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_0",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x07",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_1",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x47",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_2",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x87",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_3",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0xc7",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_4",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x107",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_5",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x147",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_6",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x187",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_7",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x1c7",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
new file mode 100644
index 000000000000..2cfe2d2f3bfd
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen1/recommended.json
@@ -0,0 +1,178 @@
+[
+  {
+    "MetricName": "branch_misprediction_ratio",
+    "BriefDescription": "Execution-Time Branch Misprediction Ratio (Non-Speculative)",
+    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
+    "MetricGroup": "branch_prediction",
+    "ScaleUnit": "100%"
+  },
+  {
+    "EventName": "all_dc_accesses",
+    "EventCode": "0x29",
+    "BriefDescription": "All L1 Data Cache Accesses",
+    "UMask": "0x7"
+  },
+  {
+    "MetricName": "all_l2_cache_accesses",
+    "BriefDescription": "All L2 Cache Accesses",
+    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_accesses_from_ic_misses",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 Cache Accesses from L1 Instruction Cache Misses (including prefetch)",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_accesses_from_dc_misses",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 Cache Accesses from L1 Data Cache Misses (including prefetch)",
+    "UMask": "0xc8"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Accesses from L2 HWPF",
+    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_misses",
+    "BriefDescription": "All L2 Cache Misses",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_misses_from_ic_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Misses from L1 Instruction Cache Misses",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_misses_from_dc_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Misses from L1 Data Cache Misses",
+    "UMask": "0x08"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Misses from L2 HWPF",
+    "MetricExpr": "l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_hits",
+    "BriefDescription": "All L2 Cache Hits",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_hits_from_ic_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Hits from L1 Instruction Cache Misses",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "l2_cache_hits_from_dc_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Hits from L1 Data Cache Misses",
+    "UMask": "0x70"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Hits from L2 HWPF",
+    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l3_accesses",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 Accesses",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_misses",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 Misses (includes Chg2X)",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "MetricName": "l3_read_miss_latency",
+    "BriefDescription": "Average L3 Read Miss Latency (in core clocks)",
+    "MetricExpr": "(xi_sys_fill_latency * 16) / xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1core clocks"
+  },
+  {
+    "MetricName": "ic_fetch_miss_ratio",
+    "BriefDescription": "L1 Instruction Cache (32B) Fetch Miss Ratio",
+    "MetricExpr": "d_ratio(l2_cache_req_stat.ic_access_in_l2, bp_l1_tlb_fetch_hit + bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_miss)",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "l1_itlb_misses",
+    "BriefDescription": "L1 ITLB Misses",
+    "MetricExpr": "bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_miss",
+    "MetricGroup": "tlb"
+  },
+  {
+    "EventName": "l2_itlb_misses",
+    "EventCode": "0x85",
+    "BriefDescription": "L2 ITLB Misses & Instruction page walks",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "l1_dtlb_misses",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Misses",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_dtlb_misses",
+    "EventCode": "0x45",
+    "BriefDescription": "L2 DTLB Misses & Data page walks",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "all_tlbs_flushed",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLBs Flushed",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "uops_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Micro-ops Dispatched",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "sse_avx_stalls",
+    "EventCode": "0x0e",
+    "BriefDescription": "Mixed SSE/AVX Stalls",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "uops_retired",
+    "EventCode": "0xc1",
+    "BriefDescription": "Micro-ops Retired"
+  },
+  {
+    "MetricName": "all_remote_links_outbound",
+    "BriefDescription": "Approximate: Outbound data bytes for all Remote Links for a node (die)",
+    "MetricExpr": "remote_outbound_data_controller_0 + remote_outbound_data_controller_1 + remote_outbound_data_controller_2 + remote_outbound_data_controller_3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3e-5MiB"
+  },
+  {
+    "MetricName": "nps1_die_to_dram",
+    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
+    "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.1e-5MiB"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
index 1c60bfa0f00b..f61b982f83ca 100644
--- a/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/cache.json
@@ -47,6 +47,11 @@
     "BriefDescription": "Miscellaneous events covered in more detail by l2_request_g2 (PMCx061).",
     "UMask": "0x1"
   },
+  {
+    "EventName": "l2_request_g1.all_no_prefetch",
+    "EventCode": "0x60",
+    "UMask": "0xf9"
+  },
   {
     "EventName": "l2_request_g2.group1",
     "EventCode": "0x61",
@@ -173,6 +178,24 @@
     "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2.",
     "UMask": "0x1"
   },
+  {
+    "EventName": "l2_cache_req_stat.ic_access_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache requests in L2.",
+    "UMask": "0x7"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_miss_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request miss in L2 and Data cache request miss in L2 (all types).",
+    "UMask": "0x9"
+  },
+  {
+    "EventName": "l2_cache_req_stat.ic_dc_hit_in_l2",
+    "EventCode": "0x64",
+    "BriefDescription": "Core to L2 cacheable request access status (not including L2 Prefetch). Instruction cache request hit in L2 and Data cache request hit in L2 (all types).",
+    "UMask": "0xf6"
+  },
   {
     "EventName": "l2_fill_pending.l2_fill_busy",
     "EventCode": "0x6d",
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json b/tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
new file mode 100644
index 000000000000..40271df40015
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/data-fabric.json
@@ -0,0 +1,98 @@
+[
+  {
+    "EventName": "remote_outbound_data_controller_0",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 0",
+    "EventCode": "0x7c7",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_1",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 1",
+    "EventCode": "0x807",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_2",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 2",
+    "EventCode": "0x847",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "remote_outbound_data_controller_3",
+    "PublicDescription": "Remote Link Controller Outbound Packet Types: Data (32B): Remote Link Controller 3",
+    "EventCode": "0x887",
+    "UMask": "0x02",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_0",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x07",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_1",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x47",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_2",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x87",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_3",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0xc7",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_4",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x107",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_5",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x147",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_6",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x187",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  },
+  {
+    "EventName": "dram_channel_data_controller_7",
+    "PublicDescription": "DRAM Channel Controller Request Types: Requests with Data (64B): DRAM Channel Controller 0",
+    "EventCode": "0x1c7",
+    "UMask": "0x38",
+    "PerPkg": "1",
+    "Unit": "DFPMC"
+  }
+]
diff --git a/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
new file mode 100644
index 000000000000..2ef91e25e661
--- /dev/null
+++ b/tools/perf/pmu-events/arch/x86/amdzen2/recommended.json
@@ -0,0 +1,178 @@
+[
+  {
+    "MetricName": "branch_misprediction_ratio",
+    "BriefDescription": "Execution-Time Branch Misprediction Ratio (Non-Speculative)",
+    "MetricExpr": "d_ratio(ex_ret_brn_misp, ex_ret_brn)",
+    "MetricGroup": "branch_prediction",
+    "ScaleUnit": "100%"
+  },
+  {
+    "EventName": "all_dc_accesses",
+    "EventCode": "0x29",
+    "BriefDescription": "All L1 Data Cache Accesses",
+    "UMask": "0x7"
+  },
+  {
+    "MetricName": "all_l2_cache_accesses",
+    "BriefDescription": "All L2 Cache Accesses",
+    "MetricExpr": "l2_request_g1.all_no_prefetch + l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_accesses_from_ic_misses",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 Cache Accesses from L1 Instruction Cache Misses (including prefetch)",
+    "UMask": "0x10"
+  },
+  {
+    "EventName": "l2_cache_accesses_from_dc_misses",
+    "EventCode": "0x60",
+    "BriefDescription": "L2 Cache Accesses from L1 Data Cache Misses (including prefetch)",
+    "UMask": "0xc8"
+  },
+  {
+    "MetricName": "l2_cache_accesses_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Accesses from L2 HWPF",
+    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_misses",
+    "BriefDescription": "All L2 Cache Misses",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_miss_in_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_misses_from_ic_miss",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Misses from L1 Instruction Cache Misses",
+    "UMask": "0x01"
+  },
+  {
+    "EventName": "l2_cache_misses_from_dc_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Misses from L1 Data Cache Misses",
+    "UMask": "0x08"
+  },
+  {
+    "MetricName": "l2_cache_misses_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Misses from L2 HWPF",
+    "MetricExpr": "l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "MetricName": "all_l2_cache_hits",
+    "BriefDescription": "All L2 Cache Hits",
+    "MetricExpr": "l2_cache_req_stat.ic_dc_hit_in_l2 + l2_pf_hit_l2",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l2_cache_hits_from_ic_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Hits from L1 Instruction Cache Misses",
+    "UMask": "0x06"
+  },
+  {
+    "EventName": "l2_cache_hits_from_dc_misses",
+    "EventCode": "0x64",
+    "BriefDescription": "L2 Cache Hits from L1 Data Cache Misses",
+    "UMask": "0x70"
+  },
+  {
+    "MetricName": "l2_cache_hits_from_l2_hwpf",
+    "BriefDescription": "L2 Cache Hits from L2 HWPF",
+    "MetricExpr": "l2_pf_hit_l2 + l2_pf_miss_l2_hit_l3 + l2_pf_miss_l2_l3",
+    "MetricGroup": "l2_cache"
+  },
+  {
+    "EventName": "l3_accesses",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 Accesses",
+    "UMask": "0xff",
+    "Unit": "L3PMC"
+  },
+  {
+    "EventName": "l3_misses",
+    "EventCode": "0x04",
+    "BriefDescription": "L3 Misses (includes Chg2X)",
+    "UMask": "0x01",
+    "Unit": "L3PMC"
+  },
+  {
+    "MetricName": "l3_read_miss_latency",
+    "BriefDescription": "Average L3 Read Miss Latency (in core clocks)",
+    "MetricExpr": "(xi_sys_fill_latency * 16) / xi_ccx_sdp_req1.all_l3_miss_req_typs",
+    "MetricGroup": "l3_cache",
+    "ScaleUnit": "1core clocks"
+  },
+  {
+    "MetricName": "ic_fetch_miss_ratio",
+    "BriefDescription": "L1 Instruction Cache (32B) Fetch Miss Ratio",
+    "MetricExpr": "d_ratio(l2_cache_req_stat.ic_access_in_l2, bp_l1_tlb_fetch_hit + bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_tlb_miss)",
+    "MetricGroup": "l2_cache",
+    "ScaleUnit": "100%"
+  },
+  {
+    "MetricName": "l1_itlb_misses",
+    "BriefDescription": "L1 ITLB Misses",
+    "MetricExpr": "bp_l1_tlb_miss_l2_hit + bp_l1_tlb_miss_l2_tlb_miss",
+    "MetricGroup": "tlb"
+  },
+  {
+    "EventName": "l2_itlb_misses",
+    "EventCode": "0x85",
+    "BriefDescription": "L2 ITLB Misses & Instruction page walks",
+    "UMask": "0x07"
+  },
+  {
+    "EventName": "l1_dtlb_misses",
+    "EventCode": "0x45",
+    "BriefDescription": "L1 DTLB Misses",
+    "UMask": "0xff"
+  },
+  {
+    "EventName": "l2_dtlb_misses",
+    "EventCode": "0x45",
+    "BriefDescription": "L2 DTLB Misses & Data page walks",
+    "UMask": "0xf0"
+  },
+  {
+    "EventName": "all_tlbs_flushed",
+    "EventCode": "0x78",
+    "BriefDescription": "All TLBs Flushed",
+    "UMask": "0xdf"
+  },
+  {
+    "EventName": "uops_dispatched",
+    "EventCode": "0xaa",
+    "BriefDescription": "Micro-ops Dispatched",
+    "UMask": "0x03"
+  },
+  {
+    "EventName": "sse_avx_stalls",
+    "EventCode": "0x0e",
+    "BriefDescription": "Mixed SSE/AVX Stalls",
+    "UMask": "0x0e"
+  },
+  {
+    "EventName": "uops_retired",
+    "EventCode": "0xc1",
+    "BriefDescription": "Micro-ops Retired"
+  },
+  {
+    "MetricName": "all_remote_links_outbound",
+    "BriefDescription": "Approximate: Outbound data bytes for all Remote Links for a node (die)",
+    "MetricExpr": "remote_outbound_data_controller_0 + remote_outbound_data_controller_1 + remote_outbound_data_controller_2 + remote_outbound_data_controller_3",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "3e-5MiB"
+  },
+  {
+    "MetricName": "nps1_die_to_dram",
+    "BriefDescription": "Approximate: Combined DRAM B/bytes of all channels on a NPS1 node (die) (may need --metric-no-group)",
+    "MetricExpr": "dram_channel_data_controller_0 + dram_channel_data_controller_1 + dram_channel_data_controller_2 + dram_channel_data_controller_3 + dram_channel_data_controller_4 + dram_channel_data_controller_5 + dram_channel_data_controller_6 + dram_channel_data_controller_7",
+    "MetricGroup": "data_fabric",
+    "PerPkg": "1",
+    "ScaleUnit": "6.1e-5MiB"
+  }
+]
diff --git a/tools/perf/pmu-events/jevents.c b/tools/perf/pmu-events/jevents.c
index fa86c5f997cc..5984906b6893 100644
--- a/tools/perf/pmu-events/jevents.c
+++ b/tools/perf/pmu-events/jevents.c
@@ -240,6 +240,7 @@ static struct map {
 	{ "hisi_sccl,hha", "hisi_sccl,hha" },
 	{ "hisi_sccl,l3c", "hisi_sccl,l3c" },
 	{ "L3PMC", "amd_l3" },
+	{ "DFPMC", "amd_df" },
 	{}
 };
 
-- 
2.27.0

