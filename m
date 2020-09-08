Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F1EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 361DD2087C
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 21:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NlRZCu2i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730206AbgIHVth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 17:49:37 -0400
Received: from mail-bn7nam10on2082.outbound.protection.outlook.com ([40.107.92.82]:28000
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730188AbgIHVtf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 17:49:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiQs/g9A4Qr5x7wtxOTCtCGMN8KEx6VF/+rVsIIeVAZKAN1uZih7+r01aGki9R6R3u4x1l/GYHxLb55vvwcejqmesSZE/O0/4VeaLeYkjvMabmnbIrV8iZDr5uQUjNn1o1LZJiJ64JbysoTbaF7lTOFddHwmmUwVyIVp9jiCzJrWjPTeMTuagTo6ed2kBNSVnnsbiGekN5D2kPh+XasyHrJAaGadL/iQvgYX5OzWRnvRO7KMeBopm2SKYO5LEKwsZK4WBMY3qiiwdyLeXQCjD1klqsL/ShubtNbl+hcJQMfTH+kAxVmEd4JF5Iz+arjPDhSQdDfmeg1xfeENYBGsWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M86oX52X8WRvrmvvXZXmteBXuJj081LORUzps9NtYKU=;
 b=XZQ38b9oktakbWFt4eO7ZwL77DCz9WfqAnaWjcnHfa7j0IYwlivnnjwIinmZFJOw/OH1ZgfZXmGEt1wlmyon/HRBsJ2vL600FhOaBvvKFARiJTBgHhkyNNWaeK8n37t04o2vAV6GScvdblHk3hWSAudXuBXXmshLbwzsHeoI90Yfq7YTUalQHT3k5FEtLlaclN2Glmmnu8f8Oj2LN9EzvpyRucyt8E9ifhtsyt7oQ7gzqir2ALwIs6Dn2Vi0kb5Qk8T/1KLhHmjZIU7QGgWKrs3shUdzkbDuc3OKiJJ+ahtSaskHCHkAv7HtbBjNvwJmQOVuAg5vuhdHJK5I1Yx0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M86oX52X8WRvrmvvXZXmteBXuJj081LORUzps9NtYKU=;
 b=NlRZCu2iXx9lMnqzzWbN1MHUuGIISQnjnj4XzeQrU8J6RQiiUAugQh8G650RKcsD1/rqPNgdqN/+UcP1US/R0WQlSoJD6pVjS7U46lzxdUgN9o+XKUxKLRI7mnidQmLPPspzZ0dQ3PEVJrD6DpA/wa10i+UL+lbiRkwxP7bWQsk=
Authentication-Results: alien8.de; dkim=none (message not signed)
 header.d=none;alien8.de; dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB2946.namprd12.prod.outlook.com (2603:10b6:408:9d::13)
 by BN8PR12MB2881.namprd12.prod.outlook.com (2603:10b6:408:9d::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Tue, 8 Sep
 2020 21:49:31 +0000
Received: from BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6]) by BN8PR12MB2946.namprd12.prod.outlook.com
 ([fe80::a92d:18c0:971b:48e6%6]) with mapi id 15.20.3348.019; Tue, 8 Sep 2020
 21:49:31 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kim.phillips@amd.com
Cc:     Stephane Eranian <eranian@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: [PATCH v2 7/7] perf/x86/rapl: Add AMD Fam19h RAPL support
Date:   Tue,  8 Sep 2020 16:47:40 -0500
Message-Id: <20200908214740.18097-8-kim.phillips@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908214740.18097-1-kim.phillips@amd.com>
References: <20200908214740.18097-1-kim.phillips@amd.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM5PR1401CA0018.namprd14.prod.outlook.com
 (2603:10b6:4:4a::28) To BN8PR12MB2946.namprd12.prod.outlook.com
 (2603:10b6:408:9d::13)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.11) by DM5PR1401CA0018.namprd14.prod.outlook.com (2603:10b6:4:4a::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Tue, 8 Sep 2020 21:49:29 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [165.204.77.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84df05b8-315a-4090-aa20-08d854411138
X-MS-TrafficTypeDiagnostic: BN8PR12MB2881:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB2881C2C151DEE1C8EF46C3B487290@BN8PR12MB2881.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1332;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0aRB4NEN7kTkI5WkHuD5epwIDm/lPEM9f+a/eKWeWQFMr6J9zvb/sGcuMd8HCaYg5GFV1QVwJV+CgR1FUfouJVJ24nzEThtqx6MrTupNl/ioCO4XhonUcvOj42K9lwWmY4iK3pjDrY94QtZPRotrNYjDKkWh63gshdPMLeJlokSYtlVtLAgLRpqlicSgiPGkjctyMDrCA8HsfmHdJAcNwjpk6Er6Stk6kRzWZGHleYJjk2tXotIloNbREUGMoN+NhFH/TBsOImJzc1Wd9OGURH/Hy4p8rBKH67m738VOWXXPSpKZlBV+k8rMwH4MgytGZRuuyfaXCZOofji0CCiuMg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB2946.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(2616005)(54906003)(110136005)(4326008)(6666004)(36756003)(8676002)(1076003)(66946007)(66476007)(44832011)(66556008)(6486002)(86362001)(7696005)(52116002)(956004)(316002)(186003)(7416002)(478600001)(26005)(8936002)(2906002)(16526019)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: /qLmwdvrKjhXPwXJ4BT7hF6FDPRDdD8QTJMw7LPH3P65pJYZ2/Uyddqwque2dco7nCOzUEo+7ZxGZPgHE9wp2VLFZyxjcpcRW8k8mqobwDSJGQC9x5lYrmzPZBazvRJpDtklEEQ5E6VvtUE16xAcFaSp5hnyUB+hrCvfF0QMQN2HhwpIkCw2ZrT8L9j+fAQFgk8BHzXGs9l2a6DL/4Vz9yQjRvXVNFG9KcVxMIsiIselGs1f479zErLsakQCrfB2umL033hSr1ZQmDkKPfD3IBA3pExOdFf1L4PPevyn9OfkwsHaKkn58z2qePN984TSZvAZloQ4iGbH2KB4x9kQjFu9qqi3Id9nBSTRtN8y3Y+5nlk0N/QGZWuNv8kCPMMpghjiMZ8Mkty7DFQxEhHo6gqlthhXOuJxSCmLEbyvBlrVAfEsGzFgOTtQcnPW3Yo+HsWjPnruaWU0FaU4gQ7deJFrohhlMJABYpnDWg2WHXtoOoObtSzVUCeZBDP0YHriJjdDORPZmKVCcGzniKtQTtkpnctrX73Xxy2Zw4DWF2g6HsZKZfX6phqjUq8OEKIj62k9RH0WpBsKVu+9NI4wp791JKaHKyhz1sqRPsUWsvEfwJsERSX31WwEY8OgyRQ4a22gqtnETT8muckTnVHjEA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84df05b8-315a-4090-aa20-08d854411138
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB2946.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2020 21:49:31.3447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oiNv+weOk7mCvmdzgdJL7jQOlqGf/RfYK6nlE4c/RNUPet9xVK6eOsrBjttNqZlSyPXd60YwaFOm8NRXKpzg7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB2881
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
v2: no changes.

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

