Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A1C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB0AF2064C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 19:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Hwd+0a2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgFDTpY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 15:45:24 -0400
Received: from mail-co1nam11on2066.outbound.protection.outlook.com ([40.107.220.66]:6258
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727950AbgFDTpV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 15:45:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S/+vwbpPHAbwM+o9FD6SuM+eqMf5ZPrycd1tujISc9Rpv4fL6HO/TGzBSvjQNpM0oC4tsDW1qmNXXY/tgKid4MC33j76iktsw9ybNkUWhD8Tb4EACY34q6tziwT6C7KLJSQ8Re1m+35F2eQQHCop4ATWyFvb/bWErVHzd6LQ8MeE/dUgpYyy7DaUK+Gq7JpOhYYMeGQBXq6iEOIkmH0cOzOYFbJ+BlkbkpUD2b18bD2TV6zdc28gpgy7myHmFqT/rDRCR3YBJLCKU0njJ3m2yCsS5UaSO7elmr2yhl/vZ3u6X/gQx4meQ3H3GpO33qJlFhlF1U/+kattProdICcpYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMzXpvheOjgEVl1aMxzKNMEgVOeTpIT3+P4VjHzdlvI=;
 b=dFbsY8kY1gB7Rc97BTrZzLO4SclSOiNrLNagJWgNpvFQp+c2DUtP3DSPX8ROjurWRQW0+5bd6JA1aA8rzpNOi9N68cTloG65K2pz2ETKpsf16GWLY+/vlzj36SxSd/POOkKcS7N1EMMutKqMmrMLCLTf9XZAbrjxSl2hmj873oQxYOayFDmCCFmsnXC3g4URTC2mtIVKVlamQKV2CzvupqPX8Q+eYEubyqrK4f8UJUgiJQJ5FeYtYo8UT0LhWX5NhhHDYs467WZeZtYLKdgys5MwHCenCKvok8tQUzstrqoXVW0cSoUhCp91bl563sjKTUdXQ1vZabZpVuXDG7+4xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMzXpvheOjgEVl1aMxzKNMEgVOeTpIT3+P4VjHzdlvI=;
 b=Hwd+0a2q707DfQ1Xj2rHNVoAwiEdYPugq4LCrsIwd8Q+fIKXrtABiN6NYqWbp7YXhkeZR26Vy7aXo3LkMipsl46L9nNWHmDgGLm2iPXsi978xIQVnt6/mOHzBvbmb5Q+I7ryk0E/DOaj8JE4a6ESkHkWBYlOGl3Fk4ePIrQ9bjU=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2384.namprd12.prod.outlook.com (2603:10b6:802:25::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.19; Thu, 4 Jun
 2020 19:45:17 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Thu, 4 Jun 2020
 19:45:17 +0000
Subject: [PATCH v2] x86/resctrl: Fix memory bandwidth counter width for AMD
From:   Babu Moger <babu.moger@amd.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Date:   Thu, 04 Jun 2020 14:45:16 -0500
Message-ID: <159129975546.62538.5656031125604254041.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN4PR0201CA0016.namprd02.prod.outlook.com
 (2603:10b6:803:2b::26) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by SN4PR0201CA0016.namprd02.prod.outlook.com (2603:10b6:803:2b::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3066.18 via Frontend Transport; Thu, 4 Jun 2020 19:45:17 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9d1e532-6883-48f0-513d-08d808bfced1
X-MS-TrafficTypeDiagnostic: SN1PR12MB2384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2384BF7AFE211B102557313695890@SN1PR12MB2384.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2043;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e0w+jKydlFcbYGZtSGG0x1/xHy5dyl0dW/FN/IiBVtj8bnO6bk01tlGwG1rRy5w7Q9j+mGXhpq0mHtBqSqRTAeCugMi2gOfSR1lxZJQzje5BkJRUddrWTb8PgMvB0yTvwaRgf/6Cih3QD6uXSgetPVJSCaPkdfUDwl0J4KHN4IwXUYxkY9YTAZyGyu/sVTQThrvUtl9nY4u7S0ZmWUEORQDZuFnuk/2s+5clLDwugrlI8PL2wNRxxhcXN8eTaXen4nCME0+blbFAEXYGqLi0pdPw1jHlK4qYnX+P0AvsGO+27Rkwu0s7lLOvjNz+BQgRzmHf4JrpSIo1qzeomeudCfzTPs8qBWqS2vFPUqTD16ERFT01fg108+e1+z3EJ4lLeCbArFM6c7wY7foWITYn4Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(366004)(376002)(39860400002)(346002)(44832011)(66476007)(2906002)(5660300002)(26005)(66946007)(956004)(8936002)(7696005)(316002)(52116002)(55016002)(103116003)(83380400001)(8676002)(478600001)(66556008)(86362001)(16526019)(966005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: EpC6XMfm3ik/8E/kf9cbruFP0bHM85CGkYlKFi4hLd0q+Rkp3Y0ySe/ovW7N5PRaQieDp+z7oTsUIBHXTO4GZC2xiVR79I9vKzVwe4xPX+B5qvpfg5nsyH98YqtfM3asODrZ9soB8DmiHXljTwFxhFzjFgx2ppkvDDXpOgsZAvAtSdbIAUNdtBeOVEVrsDLZa6lxgEju2AWdQ+lgio00QAtIvD+M+BBZCrDr6DDWnuKDycOfaX+6LRWeQgUD8hvIbmurjY24jZKgePSEyB25W0+CKp5We+3/Ah8mwrmc4E6MaZjKnZYHLEgx//jEyzSrzmbsyWzQ4OSePuDQ+oiCeNU0+D3EfPGfd8P77Kw6gMzaWHUR9vCbg+/GAXKpTbDeBdWJvuhoAKrz2M0ZWBh4O5gG6HG01Genv1/W27vGcmhsMjdibVi5Vbf/zjjW/JwXrVOeMAxKx6qq5YC1zWLTwC4qt0MhFED64abXvf4zI28=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d1e532-6883-48f0-513d-08d808bfced1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 19:45:17.6024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvSe6wDo2yBNNuZUNfCvwX7VWHRuf2+UH2QdWALkGTfZZggOlORqR/NzMx5ha3KO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2384
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memory bandwidth is calculated reading the monitoring counter
at two intervals and calculating the delta. It is the software’s
responsibility to read the count often enough to avoid having
the count roll over _twice_ between reads.

The current code hardcodes the bandwidth monitoring counter's width
to 24 bits for AMD. This is due to default base counter width which
is 24. Currently, AMD does not implement the CPUID 0xF.[ECX=1]:EAX
to adjust the counter width. But, the AMD hardware supports much
wider bandwidth counter with the default width of 44 bits.

Kernel reads these monitoring counters every 1 second and adjusts the
counter value for overflow. With 24 bits and scale value of 64 for AMD,
it can only measure up to 1GB/s without overflowing. For the rates
above 1GB/s this will fail to measure the bandwidth.

Fix the issue setting the default width to 44 bits by adjusting the
offset.

AMD future products will implement the CPUID 0xF.[ECX=1]:EAX.

Fixes: 4d05bf71f157 ("x86/resctrl: Introduce AMD QOS feature")
Signed-off-by: Babu Moger <babu.moger@amd.com>
---
v2:
 -Added Fixes tag. The problem was there from the day one when
  AMD resctrl feature was added. So, added fixes tag when AMD
  support was introduced.
 -Will send separate patches for the stable kernels because this
  patch does not apply on stable.
 -Made changes suggested by Reinette.

v1:
 https://lore.kernel.org/lkml/159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com/

 arch/x86/kernel/cpu/resctrl/core.c     |   10 ++++++----
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 12f967c6b603..5e045e90877e 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -981,10 +981,12 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 
 		c->x86_cache_max_rmid  = ecx;
 		c->x86_cache_occ_scale = ebx;
-		if (c->x86_vendor == X86_VENDOR_INTEL)
-			c->x86_cache_mbm_width_offset = eax & 0xff;
-		else
-			c->x86_cache_mbm_width_offset = -1;
+		c->x86_cache_mbm_width_offset = eax & 0xff;
+		if (c->x86_vendor == X86_VENDOR_AMD &&
+		    c->x86_cache_mbm_width_offset == 0) {
+			c->x86_cache_mbm_width_offset =
+				MBM_CNTR_WIDTH_OFFSET_AMD;
+		}
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index f20a47d120b1..5ffa32256b3b 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -37,6 +37,7 @@
 #define MBA_IS_LINEAR			0x4
 #define MBA_MAX_MBPS			U32_MAX
 #define MAX_MBA_BW_AMD			0x800
+#define MBM_CNTR_WIDTH_OFFSET_AMD	20
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)

