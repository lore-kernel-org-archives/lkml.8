Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C188DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 959E52072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 22:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="JrzOd7pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729949AbgHQWIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:08:07 -0400
Received: from mail-eopbgr690048.outbound.protection.outlook.com ([40.107.69.48]:40102
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729822AbgHQWH6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 18:07:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bqYZF0bcDkXDIPuzqraorNKj+J4BfI6a0FoJY7UZnwraQOsabMloW3/AeeuFMOfrYMQ4KqgudVHt/wt/7tOB3fOk1LFzT/P1kbDcRnjLhwaaNvfWAuOSElv0Kgu2Y4tXThUMKyzSu6vPNvrrek87/cxoWEdfv86psZAxpxRODA86JCKXxO9QBE1X//mTGiq0JVtaScYI3+LXwhHCrL1426n99dpJ50Ll4s+csYkX+AwFaN4hwKlcnBoKZpIcl9yzyu52W0sh+cZedQ1vrggWThjpK4bE8eF5sv1AFAV3UDZdkTOe3hBNLW93XwW3iOWU5+/DFfi+/ATcQbyA3SJktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dviX8vsCgOook7eJmYSHr6hGg3XLhVKjJaE2j9Gwnhc=;
 b=lgf5tAFK1SvTWh1hCV6f0Hi6z35iz9de6ZqfFEQ6ubErIMGEZRE5htfB50p48kjdW8LdYZwYXdXcQJaIn4VzI9TAT3tmuxErOm78Dlh30squJpZk0TPs+qx3ENYrjWXgfyDC/cZWQ3E4e3UKUDjd3zpI2AfEJ2jIK13olYStCFwogllM8M0PQAl3+A2vRYM1CPCYE4aSuK1JhXS5klvwy0C2BQ69CKVHDcRGpHyhuqPd/spjvWlPEucdSIXkwCC6LKcT3Py7JQSy2i+w89m1MvT8i+Su1DozSZPEu7l+XL+/5ffZ7k3TGXTFj2nDn96r7qQfAGRGK1ZGq10aF8yYVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dviX8vsCgOook7eJmYSHr6hGg3XLhVKjJaE2j9Gwnhc=;
 b=JrzOd7pnHr5s/JpKUoW/YWIHTsVcan8YIvnhkeIuIFd3wwkDCM5+5LhhWTsac5+OVNz8zW0p1EhYl7sVKDYp5L+o3+w95jz/i1+KVhur0xokOhVHrGQhiBGXcHxn2tuFq77O02X3V7ZFQJ1mxpV0txNlq9r5FOvmd4bDYCuOOF4=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN6PR12MB1652.namprd12.prod.outlook.com (2603:10b6:405:6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.22; Mon, 17 Aug
 2020 22:07:56 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::ac22:9457:4d25:5ff0%5]) with mapi id 15.20.3283.024; Mon, 17 Aug 2020
 22:07:56 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Kim Phillips <kim.phillips@amd.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH 7/7] perf/x86/rapl: Add AMD Fam19h RAPL support
Date:   Mon, 17 Aug 2020 17:06:28 -0500
Message-Id: <20200817220628.7604-7-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200817220628.7604-1-kim.phillips@amd.com>
References: <20200817220628.7604-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR07CA0063.namprd07.prod.outlook.com
 (2603:10b6:4:ad::28) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (70.114.200.6) by DM5PR07CA0063.namprd07.prod.outlook.com (2603:10b6:4:ad::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.15 via Frontend Transport; Mon, 17 Aug 2020 22:07:54 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [70.114.200.6]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a26a493b-ac33-417e-0336-08d842f9fe68
X-MS-TrafficTypeDiagnostic: BN6PR12MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR12MB16529827D865EA9F757AE8DF875F0@BN6PR12MB1652.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlAzdKAhM8dPRAq5uyOWN/2uR1l0OShqf2fxQWm+LQyw3DDuvVK5RGFzAIj01ob+tHOfp7Ew4qNZhEdQunusAkaJ4zV6qQ8XnmxmID2+WE9XgfRNZmUqn29mSf3dvtPNQEVPavgoJu6z/kWmFNef8Jkr3UbVp1EWG9HDWkci4Qzwv7ItzudDvlHPOxVUWrbgYlcBf7chrfWyLfHTED4CW74IHTJkKLHVqTo87el7Sh0O8CVgRBLeMAdSb2QaD9Ed6Zp7Klo/nXmZRDC7DRUAPTt5CRkKN7NATEpAhXOqlxC8tK+1LUXcaqcxK8VBinD8ivu4Z5RlKsfj4AK1YvNB+njfz6eJ08UMOZuGYXi4U3u67QhNdBdGdAvi/LsaRajl
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(110136005)(86362001)(6506007)(4326008)(956004)(16526019)(36756003)(44832011)(2616005)(5660300002)(186003)(6666004)(7049001)(66946007)(7416002)(2906002)(6486002)(6512007)(8936002)(52116002)(69590400007)(66556008)(54906003)(66476007)(316002)(1076003)(478600001)(26005)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vjUDOtRdjCbHc7viWggk4EyPFbZYAW1rhGgQiH4/j2y/H38giMR/ZSEDX9Uimjl4gZjFhUJ1yIKrZE8cXfBqXl8Qc9HLLjjF3xCx6dnZfibnvewNE//3M/XXNb7m2iUFbyaFUXMeybUeXqLLX9C/3ba62jz8q8wfvklSTFRpVkIib9+pYlkcULXZmFGOtxW9bwPmr7Jv881J9A/7uKSF5ax8XJe3uqaD+znwn8hSnRTzUo65e2++w7I54YhcSSfOuhF9WPe0OMAO++58H+G/6tlXKzVfvcykTybcThSIOaazTQpTqL3IlbpYGtskuI22Oijf12tfsmyoGUBVSZdTA1rOlq6SxIAjlLgc4neMcX5LffrE+9HcZRAszN40ydiDdCEaz78fb//9UmdRDe6ePQiAREb2NG/2XkzW9PXDAr/H140+mRzVzCz1tQlEIdkiq2RXp34d5QR/kJ6khDWToPAB9I/6ouDVvU4dAdsZ5AqbKIbUfvOFRJk4VC9O8rZggAP+7cj3ZRYcBzdXO7tBY7b5yyYWEoo7eakI9aQEaVl/X+EqBYQ0vfV3RKwQ8r9fXVmYtpmEU2t+dBiF554Bmtf1Qg2nTRhH21Dl7HerSoVtFmg8SBQuschdxHg30UFCDjBwXLviynVgAtiDMl9+ww==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a26a493b-ac33-417e-0336-08d842f9fe68
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2020 22:07:56.0401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oAkFe6vIZU0SA5PMQ+7v3fc8D8lwPS3yqngl8bdUBO79KJwlYOTQimzWLUmIz8j/lPayj49+8vGoSM735ekT0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1652
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Family 19h RAPL support did not change from Family 17h; extend
the existing Fam17h support to work on Family 19h too.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
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
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 67b411f7e8c4..7c0120e2e957 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -815,6 +815,7 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
+	X86_MATCH_VENDOR_FAM(AMD,	0x19,		&model_amd_fam17h),
 	{},
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
-- 
2.27.0

