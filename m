Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC8AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FBC207BB
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 23:00:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="UDd3YMXu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgFAXAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 19:00:35 -0400
Received: from mail-dm6nam11on2053.outbound.protection.outlook.com ([40.107.223.53]:56198
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725766AbgFAXAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 19:00:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UX91NdKMz3hMXvqO95FL630+Km6Ls2qah4kRZZQVIxP7NB5bc0Lje3/k4NiYcFShhfLf1xig7GZ/9eXp4EOPNox0xchx+MyWwln7uzU7CPnaKh/9kqJW7j0oesRpNW472UFHf+kb9bv5Lg6ff30gsUgLxn3WJM7kLS1iSjNDmvQ2PKsKwPFtmc10bkBghQDUqojovxSVxqedbakPGatOAXO5CE88W2McIZixyXuOpRmMqepGEQiJbwh9f4wvqSa3vk/1fmcaD4agFAHELuifdZyJ5aTpLmJcC8xEZWr8SvdXTqBh63KBxzr6AzfARIbgKplDObG/5hkgjZdx7UTNEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGpDagtdKw9HPvqbkWvkj8dEj9cIC7DSyfKlhmMfkIY=;
 b=T4kAy/nTFg1bvT6W5IIK01YizSt+Ja+tm87UEgiEE2+NX/ptoT+GLRGI+rKCeecqnN/bW39+HMnQpyBLVFQS4rxmy2AVDRegah4BiB48fPnhVtpSMy9N1gpaY5daRKJklm+rg9Hr28yvLDrgVnWESs1ap7WSG1ti+pTyvl4gQi3VZfS4lrXrDT3O//GVv/oxLWSQsZf5jxtAIpuf9mxoCmFCWAoyiyieuvWjKgKqq0DQjHvLp8aqko3ErB68ICJq8rgcvFBdtvxe+3JKQzZWXhNhy7heDVAsalvUQfmo1SV/J5vISLys6DkY+Jez8BIO0VaVZnVEdL65dIgUoo4OyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGpDagtdKw9HPvqbkWvkj8dEj9cIC7DSyfKlhmMfkIY=;
 b=UDd3YMXuksLeCkF1gBSFzY8KmtqqE8+rpLjL/FO9U6I70nSVYrxtMiwXyNxT70y3ie+KC6xz/aLsQECw/TxIaKV3HNPByoMcFVNVzYOJEZVnZIx+THwH4qHb+Emf/dIcCirV1Z80jYA4iEeRGhWbN6D34DRWOEVrEyhk+q40U+E=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2367.namprd12.prod.outlook.com (2603:10b6:802:26::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.18; Mon, 1 Jun
 2020 23:00:30 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::2102:cc6b:b2db:4c2%3]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 23:00:30 +0000
Subject: [PATCH] x86/resctrl: Fix memory bandwidth counter width for AMD
From:   Babu Moger <babu.moger@amd.com>
To:     fenghua.yu@intel.com, reinette.chatre@intel.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
Date:   Mon, 01 Jun 2020 18:00:29 -0500
Message-ID: <159105232628.48268.7763865625735367523.stgit@naples-babu.amd.com>
User-Agent: StGit/unknown-version
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN6PR08CA0026.namprd08.prod.outlook.com
 (2603:10b6:805:66::39) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from naples-babu.amd.com (165.204.78.2) by SN6PR08CA0026.namprd08.prod.outlook.com (2603:10b6:805:66::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17 via Frontend Transport; Mon, 1 Jun 2020 23:00:30 +0000
X-Originating-IP: [165.204.78.2]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d2045ef4-ab3b-443b-857e-08d8067f9504
X-MS-TrafficTypeDiagnostic: SN1PR12MB2367:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB23674A181DBC3D0E148B93A1958A0@SN1PR12MB2367.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-Forefront-PRVS: 0421BF7135
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEnhiGOwQb71o8cb2dC2pn7yInCN2PHqWgCiBnZOWF7yhdft+lYD+gZgRyxL4UXjamRCkkjm83Q3kkkuYn4VcpV8mRjtd6o3TkiqpQ5G9U3tkhNj8E3bIRA7gde6FAbAqK8vqGnrnNLxU6kaBM+QWjDyqUFz61P+RJXvQDyTjF2xk0BAA1SrU7aSlTguGVWYQoCUQn1APXZ4QDWpMTvmpiNbJm6ziYMLYlvD78G6AW5m8QmwatS4EF2nyH50yAwCVSBbe8XZUbPvuyVZV1vqmw0c+A5zWXK7GfsfbsrCQpxDIZXWTv4yY4JYjg1nMo0SGsnA7LHAAzacCZczDNKthg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(8936002)(86362001)(103116003)(44832011)(478600001)(8676002)(52116002)(7696005)(956004)(2906002)(83380400001)(66946007)(186003)(66556008)(66476007)(55016002)(26005)(316002)(5660300002)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2fb8jNTfUVO5km954x4IVBwhSr8Omd8BM0HU9HZV6st4eI9EUoA/XFHeGMZNac/I28XmzbuZcMVWaq75Jhtan4ymfm7EspIpMXGHwKoNCbiQotVG3q8fDQlhGBUM5J0QxZT1nFjka1Raz36aGmP34l5lMWNIw5WF2vvUPteupdNVJsYt8JTMA3M/BQDBJUmPAAVA2KuET6KHbKCvDglUeI436Zkoj/Wh+SJZydsYP+YB8MK88xN45uDOiWVkzjiCGp6Qw1lq8OEV4E8bD7eAsYqgEidp/YVwnW3x+58C8b8iMAPzn5E98BYW9vAhc/SSdQzTdEh+SoPYiz1grI2bkYmUJE9mU0OwJafPmLYGaoiT0pGvsYZxjqM/EUGFurreyK1wzmurbu4ApGV2G2GSHBnGknYSWTHJCLiNbUjVWQAcGE0GVYDE6psmS23CmXdbrPt7lJRqg01XHp2Oxy/DbBVd/+BIrblrFI8RoS1atbE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d2045ef4-ab3b-443b-857e-08d8067f9504
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2020 23:00:30.5768
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7x4tcRX7YzXm9o0JjcYiDG63jBZsIvdbPer3MScSkjXc6IwaNI/PHeqqfDPBt68s
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2367
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

Signed-off-by: Babu Moger <babu.moger@amd.com>
---
- Sending it second time. Email client had some issues first time.
- Generated the patch on top of 
   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git (x86/cache).

 arch/x86/kernel/cpu/resctrl/core.c     |    8 +++++++-
 arch/x86/kernel/cpu/resctrl/internal.h |    1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index 12f967c6b603..6040e9ae541b 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -983,7 +983,13 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
 		c->x86_cache_occ_scale = ebx;
 		if (c->x86_vendor == X86_VENDOR_INTEL)
 			c->x86_cache_mbm_width_offset = eax & 0xff;
-		else
+		else if (c->x86_vendor == X86_VENDOR_AMD) {
+			if (eax)
+				c->x86_cache_mbm_width_offset = eax & 0xff;
+			else
+				c->x86_cache_mbm_width_offset =
+					MBM_CNTR_WIDTH_OFFSET_AMD;
+		} else
 			c->x86_cache_mbm_width_offset = -1;
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

