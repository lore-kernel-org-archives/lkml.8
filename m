Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCD56C5ACC5
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:28:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981CB207FD
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 23:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GAmENHew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgBSX2H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 18:28:07 -0500
Received: from mail-bn8nam11on2073.outbound.protection.outlook.com ([40.107.236.73]:32576
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726681AbgBSX2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 18:28:07 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOuxbK9HYVmGq7db4ZOKBe/ZUyKCl02cYnqzkCU+CAycJR1/wkv8q8udffy7fnRNFUE2KPPMzoAcuB89zjrtKsEfLDwgQdRgHHV8KCdfuUO5jF9PkkXKuIZgXnHky4+1mC34UTyCT3dlrkyZV8AgZIu0qnWFicsOJs5hUYcvI2Oy2JdjAh4/gc7T8p3MRHn5hCl5SuzFtdtwabVEOoCtE+9Fmgr7nLp6JuUGg9ODcofS+HmEia/n96LDYO5CAabixKnJ8g3vvFexALMmyypEUt/o9t1KgVukvSIxcB490NMKAeSTbHml6TiYzXED8Rpmk8l4d6i6gvp+pNquFhXqAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n+R9qMS5MEemkGY55if34HNcWyhq9oPlIRhhyiTcuk=;
 b=JSkcs7H7/xit8tc14RCbOhohLqKoGuWxn4um5upaXgnrlIC0NiBCbr9Mr0CM6mHaYixyCA+zOC0SZhN1f+xLHyzwGP/6SUNM4o4QQ4Oe3Da0f1kcDmw8SG/HUpriiFguNeQbL5cW+0Nc7kIhW2OLSRKa/Nic3pL61vcWd15Z+V36DMDID2tMQIs1CZf4tOcXzuWMFfE8ZvtvlopnYtBuXAPX0BNTSuW/4docxT8GSTGhKYLs/E05wK9CdupMyqjDWPQvXS8Y+vsfVSb97cLhyi03TDmnlwtC4LOOhlloMImFdmWHqznT0jq3Q3YxCFRh43AlgeC5fWNQoHme6ajrig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+n+R9qMS5MEemkGY55if34HNcWyhq9oPlIRhhyiTcuk=;
 b=GAmENHew14PPQMShvT1tIIQvSzjxBw6cuI2RO7X3vc9CxarK4+u2a+jyHCwDP++IGC9kF+90U7mzBo3gjxLDmTifNhAQzf3VwJVUvohzt6Le8QLj19/JCf+piYehKkCllz6wQJjOFXx7mIn40vdorerI6YfT1zcIvOsjMqH6QPw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (52.135.106.33) by
 SN6PR12MB2605.namprd12.prod.outlook.com (52.135.100.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.24; Wed, 19 Feb 2020 23:28:02 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2729.032; Wed, 19 Feb 2020
 23:28:02 +0000
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
Subject: [PATCH 2/3] perf/amd/uncore: Prepare L3 thread mask code for Family 19h support
Date:   Wed, 19 Feb 2020 17:27:28 -0600
Message-Id: <20200219232729.21460-2-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219232729.21460-1-kim.phillips@amd.com>
References: <20200219232729.21460-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR14CA0064.namprd14.prod.outlook.com
 (2603:10b6:5:18f::41) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
Received: from fritz.amd.com (165.204.77.1) by DM6PR14CA0064.namprd14.prod.outlook.com (2603:10b6:5:18f::41) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25 via Frontend Transport; Wed, 19 Feb 2020 23:28:00 +0000
X-Mailer: git-send-email 2.25.0
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 5dfa5b66-68d7-4635-f453-08d7b5935cc3
X-MS-TrafficTypeDiagnostic: SN6PR12MB2605:|SN6PR12MB2605:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB2605048711BDA73202E6085287100@SN6PR12MB2605.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0318501FAE
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(136003)(346002)(39860400002)(199004)(189003)(8936002)(44832011)(8676002)(5660300002)(7416002)(66556008)(2616005)(4326008)(66946007)(956004)(81166006)(66476007)(110136005)(36756003)(81156014)(7696005)(26005)(316002)(52116002)(2906002)(1076003)(54906003)(16526019)(6486002)(478600001)(86362001)(6666004)(186003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2605;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5BmEqbjntQXdK8hZDv2tgW/GsuPZpQ4M1gy6TDoB9HNadkal6z50gfkRDt8MZYVbLsfn2GNGpT5FbVzofBaYtKuBsE9hKUIEC5utPRSarpqGagDeyG3qstysP47xL3vLoScWqlWUwyIo9JcPtdE0zFPIfoBW4gAPHHIsGCDMc7YQ4is10D0a0al/Hjl3AoAZHFaOm3TyFf0wRyFtUZhSLCT1CoalmAhv7CR8sRhwHFjXTDlMP6IFpcwRJiEZitn3g/OHajELswnRXYYaXE4RPRRYPDp5p4O/BvHHeHa0jbWO36ikf9kThkCXVeJS8MhfZG6SRvC8s+Pn6+JYbTWtPWvAUsJ0TIs4APbkfPf08LqI1e5vZNPgB+lg7Y8HkXTmDmNGMys6lUsJ2/eftkz3f93V4xOThtTHFlAiekmQmwmnwx1it3Xy4IUUPeROBcf0
X-MS-Exchange-AntiSpam-MessageData: WpTfrpypDgM/Hn8kj3KUfmWQiPRNG/orEbMfT/p373tgg3tOi+sZNxgEAmbVKllzZ+FeXuz9d92Bvg2tEydhrLbitlvyoZAHlViN54K7f3MXOZ6DbEgLRXf2v7hiSL4NwgNvovcDXE4C0m3q9f341Q==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dfa5b66-68d7-4635-f453-08d7b5935cc3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2020 23:28:01.9289
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOjwuQRBzpUpOqDvqsyPh9J15E4bsX8t+ZKrk7l0ssW5hQ0ITA96fF7WloirslAI0xKeA93lBsDL5j3JVlr9xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2605
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to better accommodate the upcoming Family 19h support,
given the 80-char line limit, we move the existing code into a new
l3_thread_slice_mask function, and convert it to use the more
readable topology_* helper functions.

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
 arch/x86/events/amd/uncore.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 4d867a752f0e..e635c40ca9c4 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -180,6 +180,23 @@ static void amd_uncore_del(struct perf_event *event, int flags)
 	hwc->idx = -1;
 }
 
+/*
+ * Convert logical cpu number to L3 PMC Config ThreadMask format
+ */
+static u64 l3_thread_slice_mask(int cpu)
+{
+	unsigned int shift, thread = 0;
+	u64 thread_mask, core = topology_core_id(cpu);
+
+	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
+		thread = 1;
+
+	shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+	thread_mask = BIT_ULL(shift);
+
+	return AMD64_L3_SLICE_MASK | thread_mask;
+}
+
 static int amd_uncore_event_init(struct perf_event *event)
 {
 	struct amd_uncore *uncore;
@@ -206,15 +223,8 @@ static int amd_uncore_event_init(struct perf_event *event)
 	 * SliceMask and ThreadMask need to be set for certain L3 events in
 	 * Family 17h. For other events, the two fields do not affect the count.
 	 */
-	if (l3_mask && is_llc_event(event)) {
-		int thread = 2 * (cpu_data(event->cpu).cpu_core_id % 4);
-
-		if (smp_num_siblings > 1)
-			thread += cpu_data(event->cpu).apicid & 1;
-
-		hwc->config |= (1ULL << (AMD64_L3_THREAD_SHIFT + thread) &
-				AMD64_L3_THREAD_MASK) | AMD64_L3_SLICE_MASK;
-	}
+	if (l3_mask && is_llc_event(event))
+		hwc->config |= l3_thread_slice_mask(event->cpu);
 
 	uncore = event_to_amd_uncore(event);
 	if (!uncore)
-- 
2.25.0

