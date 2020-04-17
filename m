Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9052FC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 679882087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 14:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nsw1SJvN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbgDQOe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726517AbgDQOe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 10:34:28 -0400
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (mail-cys01nam02on0621.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe45::621])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831B1C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 07:34:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdsTzwLEChMWX4vSRht2cG9/6SfHJcQhDRMJ+8USYoTmBrW5zoqb+O/2hT4g1nnmgQr/1inqXHaGHm8O815iSWOu0LNPuZ407DNr/Ny4vV4wIhTM5PAhyhqExJ1PLB2ANSkznFaJcy8ELgGwZLA9p1FGAOdfLfUYlfuPtscRigyG9YJUzSjhay50KpcpmJQN85bPbTFIYeEIWDvZRQxDHXb7agyvxrvleXQRZJsqv45dBSPaccdey8jRXDCYmcO92sdi9cTSQ6iB3aGcNLt9PbTokAMJMSeP6tIO6W71P7xM68BQ85eSsvOJIxqsP2kf2OTr//qdZuyCbraAaq3qCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLDRkH5YqrcqmI5fXymtvwQr3T9BWZGJCtot4z7LpNE=;
 b=NKySorpQHCXbNNuFdnOWM1asJ4SKF2RZNgmWlMUynNStafQn4HYmsS9BJeB2NX8WCYNvDRbr+j13H4b1ntHFR141iKp6YXpi5poylxIxj5gIDSaE95uOMqk7nedvze6MwtKfLjiBF0WPXLZ+wVl31awGs4wDYXWCL/G1Wl/XMF9LWH8EPP2wD3k0vHUU7Bz2Bi7lLCZhHY67rKNmLEDF/lsS1GypkxVUEBoL7pX5fUo3HWY9duqs09pJTIKABnA8+RneTaH8uXEpVNsK5zzQpUe/veK/QguwXdyoshCyD7PH5IgaSDTr6Ok+NC1OP+3Hvw/jQwl0cTD7SMPUeZSfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fLDRkH5YqrcqmI5fXymtvwQr3T9BWZGJCtot4z7LpNE=;
 b=nsw1SJvNakWEmE5n2kTCaw5EbYJSa31qmK2Wp1MqvbB8b+0ithEOrExu9Lt5j6qEJwICCr1dqprYdZumFIzZFs7rNxEsG4TJZf8ZVIMsM0mneHmzGEyGNVj+pyuZLo3yawTnNA5j8BemCj6U9OW8xyp7Gpy4kzgVJJdJ4z9tz8U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=kim.phillips@amd.com; 
Received: from SN6PR12MB2845.namprd12.prod.outlook.com (2603:10b6:805:75::33)
 by SN6PR12MB2784.namprd12.prod.outlook.com (2603:10b6:805:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Fri, 17 Apr
 2020 14:34:23 +0000
Received: from SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::f14e:e4c1:2f8e:f8e7]) by SN6PR12MB2845.namprd12.prod.outlook.com
 ([fe80::f14e:e4c1:2f8e:f8e7%5]) with mapi id 15.20.2921.027; Fri, 17 Apr 2020
 14:34:23 +0000
From:   Kim Phillips <kim.phillips@amd.com>
To:     Borislav Petkov <bp@alien8.de>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kim.phillips@amd.com
Cc:     Andrew Cooper <andrew.cooper3@citrix.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Frank van der Linden <fllinden@amazon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/cpu/amd: Make erratum #1054 a legacy erratum
Date:   Fri, 17 Apr 2020 09:33:56 -0500
Message-Id: <20200417143356.26054-1-kim.phillips@amd.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN6PR08CA0091.namprd08.prod.outlook.com
 (2603:10b6:404:b6::29) To SN6PR12MB2845.namprd12.prod.outlook.com
 (2603:10b6:805:75::33)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from amdsos-demo.kimphillips.home (165.204.84.11) by BN6PR08CA0091.namprd08.prod.outlook.com (2603:10b6:404:b6::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Fri, 17 Apr 2020 14:34:17 +0000
X-Mailer: git-send-email 2.20.1
X-Originating-IP: [165.204.84.11]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c4316cf-a8d7-45e0-52b7-08d7e2dc6c12
X-MS-TrafficTypeDiagnostic: SN6PR12MB2784:|SN6PR12MB2784:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB27846A47DED74F9C64D0078C87D90@SN6PR12MB2784.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 0376ECF4DD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2845.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(2906002)(66556008)(66476007)(66946007)(81156014)(7416002)(8676002)(6506007)(26005)(54906003)(52116002)(110136005)(478600001)(186003)(966005)(5660300002)(4326008)(956004)(2616005)(316002)(16526019)(44832011)(6666004)(86362001)(8936002)(6512007)(36756003)(6486002)(1076003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fiVeMlCFLNDivW4Bf32GXZznZRyv0xTQi4q8RiEQMzkr2Y1duAVRaa8TNIFl18lAnchx4fhCVCierMvgaEC4PhR/V6GYNGw2yV6B6eJ271sWGOS2mM63c1OnSEGMaic7RiRZcR8pBcRkuSzKzTjvDclqVxO2b8KzfFCbKSj6yByog/H+t2u7SQDryNVlastyaK6w/Ey8weufqUTpouGqKSrQ3xuHmuSgWPu/FxTU7Inbsy2UPQpf3o75PIHt2A2UCdd9ez+iF53TOkN5cOAD0mDISwOuLoAGgOytaH+rY07amSus/PnOBJJpRW6RAiGfRLwyeywlCFCdXUzaAGG6WrwuKh5HiGCuCI5jfiY7bRLxIIUSPyG3Tj1TrbE64SZzSpQkXet/5SVhbbfyw6KmTuuFBA6IHCAtJc8mobVFdcowGh2CMgiZsj37ergy8kJyk32uodQaOACqNrieRLr/GY7Vt0dVCDJyi0hBspKK0g49jx+9xUEvWJcaqJvy9H47KJm9lbvkzhdhcLII6XtM9A==
X-MS-Exchange-AntiSpam-MessageData: Z2hUn3PRA4cupC7YwL+nshemhRUyhFVoKChtz989TFAnAitKoQ8kIVyXNA6vHjeLjtGe005CHUuDSiRxwieq6J8XqXVQK7UFM9dFKt4PRcPOktyV8Ww4BLuDYpRfxVCel+hV+1wjAb/Jk37fqLsnhA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c4316cf-a8d7-45e0-52b7-08d7e2dc6c12
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2020 14:34:23.3575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yphnWCIyo8nNdYHQdkVMNTVARnzwwG13ef8uMOfywErW9PCzPxGIXSFN46/A4NH4aRLwcHGtunp0nOBBxdaIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit

  21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired
		 counter IRPERF")

mistakenly added erratum #1054 as OS Visible Work-around (OSVW)
ID 0.  Erratum #1054 is not OSVW ID 0 [1], so make it a legacy
erratum.

There would never have been a false positive on older hardware that
has OSVW bit 0 set, since the IRPERF feature was not available.

We do however save a couple of rdmsrs per thread, on modern system
configurations that correctly set non-zero values in their
OSVW_ID_Length MSRs.

[1] Revision Guide for AMD Family 17h Models 00h-0Fh Processors

The revision guide is available from the bugzilla link below.

Fixes: 21b5ee59ef18 ("x86/cpu/amd: Enable the fixed Instructions Retired counter IRPERF")
Reported-by: Andrew Cooper <andrew.cooper3@citrix.com>
Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
Cc: Borislav Petkov <bp@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Matt Fleming <matt@codeblueprint.co.uk>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Frank van der Linden <fllinden@amazon.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/cpu/amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 1f875fbe1384..8caf29706eac 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -1111,7 +1111,7 @@ static const int amd_erratum_383[] =
 
 /* #1054: Instructions Retired Performance Counter May Be Inaccurate */
 static const int amd_erratum_1054[] =
-	AMD_OSVW_ERRATUM(0, AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
+	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
 
 
 static bool cpu_has_amd_erratum(struct cpuinfo_x86 *cpu, const int *erratum)
-- 
2.20.1

