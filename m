Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7461C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A022F20575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 19:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="l+sSda6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731342AbgCKTPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 15:15:43 -0400
Received: from mail-bn7nam10on2052.outbound.protection.outlook.com ([40.107.92.52]:6105
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731247AbgCKTPJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 15:15:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IMVxOqOvNbExEaKczcPKJB5t8PoHPbsbiTvHkhguxML1zZRexVBwo1CDqSW00ZIZH2MlXB8yiHrpEOv3QKha03Uukc3aoIEarKmBCSOR8RH623h/BwFP2iZ4sgD3Ka38hPz6oYmjbKssY3zdkfptj4/oUvLQvCmQQXS+2kfgZ5DeU9et3IWduwjBXOBI7x3Hh1YueGNXaMfKKmu+9Vh5gXMRD52Q6zZ2gsxPV1WxHpx5XvixJu9gMdB1hWP21MSvZ2HM+xW43/ItUP7nj9jV1PORwWEOHMlNp7RP9oPhgOoxhvSDpcE0ohD0CrlZBnh8o/uyJcD5avR2u0doo+01Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plTDMSWVjxHN0IZEB7K3wz6JjWCy37OOmu6z1doPAww=;
 b=ORN1cR3QWuBIUeSSC1wt0PIceF6GatFcyyr5Z2MveFdKu17zmGN88mWTa8ASx5g2EzWWuEb1Slb1i/OMbynU4kiv2RJfbYm0zAeI9ztrOmp3w0WDsTstbdcGGQFexNM33tbiW3NGc/a09iTbfACDHmdgpXArlRHjTDBTNzZiJ31W4QVYysG94akbNKBSmr+Y3rBj1ep7vRlA540fmg/uL3d2QWDUFXWPidItKDw2ceTt6BGBWntfbN6s08CX0GUq43jNsk6Eqw0nAHL7dBGcEzHmXI5Ryh3zMpfk5dxqGcswbcoCWX5XNTfgs1/jbiZpcHyi7W19o+Hs8wEJp7priQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=plTDMSWVjxHN0IZEB7K3wz6JjWCy37OOmu6z1doPAww=;
 b=l+sSda6VWdTiT3AFZw1rmcP2YDiBMXTbnsQ/elOtNxlyHsDMrQzNgUlJaznDwSiRFn+TW78FtI30zKXCbluYm0rvKJxivmxRVs+wi+xYRBteuBN1VdsyCgy/K487yKIn2YwjS7VN8DctVqqPrDIDLpRF0K86Msas9QXleycI/tg=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2799.namprd12.prod.outlook.com (2603:10b6:805:77::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Wed, 11 Mar
 2020 19:15:02 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::dd6f:a575:af8e:4f1b%7]) with mapi id 15.20.2793.018; Wed, 11 Mar 2020
 19:15:02 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, kim.phillips@amd.com
Cc:     "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frank van der Linden <fllinden@amazon.com>,
        Michael Petlan <mpetlan@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu/amd: Extend calling init_amd_zn() to Family 19h processors
Date:   Wed, 11 Mar 2020 14:14:51 -0500
Message-Id: <20200311191451.13221-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DM6PR17CA0004.namprd17.prod.outlook.com
 (2603:10b6:5:1b3::17) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from fritz.amd.com (165.204.77.1) by DM6PR17CA0004.namprd17.prod.outlook.com (2603:10b6:5:1b3::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.14 via Frontend Transport; Wed, 11 Mar 2020 19:15:01 +0000
X-Mailer: git-send-email 2.25.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ba9e32f8-8b69-43e9-40c2-08d7c5f07ff1
X-MS-TrafficTypeDiagnostic: SN6PR12MB2799:|SN6PR12MB2799:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB279974DC816A3372C312470E87FC0@SN6PR12MB2799.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0339F89554
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(7696005)(52116002)(5660300002)(4326008)(16526019)(186003)(26005)(66946007)(66476007)(66556008)(6666004)(956004)(2616005)(316002)(6486002)(1076003)(44832011)(86362001)(8676002)(54906003)(110136005)(7416002)(2906002)(478600001)(81166006)(36756003)(81156014)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR12MB2799;H:SN6PR12MB2845.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zeHAPKO31GuxtkSXpttQCG5jNmd0Ygx0jTYhyrrqHdyZVdT2Rf+zrEwO652sm7vUQEYN4z9Yp3zlRmomnvrkYF8j5Dp1/t36drFlH2H/1XVHpRR1WOIKvz5FieCERcxwEfI722pE8sx2Lm3j4GgtHetLsZwnplhLyqhryhIsx3tdI8z17jdDb8rSy8ZOBSOyvUNi4pRicZauMsbBWKu7rS3tH3hoW707L/v6nQcl0FHHMBx0Pq4u0wcwfisN4qsB4QxEvb6T9EWNE36865XlSFkYZR1DoQ17D8gkdmg+icti4bjZmTgrPhAw1kBEZt2R7WJH3UbJZ/3LZKBZ9HnJNB6L+39Rdf+18FeUatj/LsAqhL1hu5mxdHr35gcmtSd/zobXNokwBfSY3yf0i+NCQJMEqJdsCzWvRjpFpBahxOVRxzDGoN2A4D33DB09yhDj
X-MS-Exchange-AntiSpam-MessageData: Kb8QB6QUBMcesU++FNOv7u7k+FKlfmLLSlRtE9apAdl+cI5bfORHQSAQb/YIcZCBhj09s44SmZ4CQ9enZn6b784w6tQ0BubuqFUeC9GTsXIwK7dKy2MGnkNbHgCvUnZsOwJzmcTKlZKNf4hI9YMcog==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba9e32f8-8b69-43e9-40c2-08d7c5f07ff1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2020 19:15:02.7133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H263JKfavAgxG16inYo1jYf1YHk7hl5G8070OnfaB6i+L9eqxWER1nbQsVRof7+C3JwrQfD36ONRPtuUrd/zjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2799
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Family 19h CPUs are Zen based and still share most architectural
features with Family 17h CPUs, and therefore still need to call
init_amd_zn() e.g., to set the RECLAIM_DISTANCE override.

init_amd_zn() also sets X86_FEATURE_ZEN, which today is only used
in amd_set_core_ssb_state(), which isn't called on some late
model Family 17h CPUs, nor on any Family 19h CPUs:
X86_FEATURE_AMD_SSBD replaces X86_FEATURE_LS_CFG_SSBD on those
later model CPUs, where the SSBD mitigation is done via the
SPEC_CTRL MSR instead of the LS_CFG MSR.

Family 19h CPUs also don't have the erratum where the CPB feature
bit isn't set, but that code can stay unchanged and run safely
on Family 19h.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Frank van der Linden <fllinden@amazon.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/include/asm/cpufeatures.h | 2 +-
 arch/x86/kernel/cpu/amd.c          | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f3327cb56edf..f980efcacfeb 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -217,7 +217,7 @@
 #define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
 #define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
 #define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 (Zen) */
+#define X86_FEATURE_ZEN			( 7*32+28) /* "" CPU is AMD family 0x17 or above (Zen) */
 #define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
 #define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
 #define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1f875fbe1384..af952d7ed2fc 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -926,7 +926,8 @@ static void init_amd(struct cpuinfo_x86 *c)
 	case 0x12: init_amd_ln(c); break;
 	case 0x15: init_amd_bd(c); break;
 	case 0x16: init_amd_jg(c); break;
-	case 0x17: init_amd_zn(c); break;
+	case 0x17: fallthrough;
+	case 0x19: init_amd_zn(c); break;
 	}
 
 	/*
-- 
2.25.1

