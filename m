Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BF3C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:42:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BC352082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 15:42:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qqmYf/Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbgBYPmX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 10:42:23 -0500
Received: from mail-bn8nam12on2087.outbound.protection.outlook.com ([40.107.237.87]:13828
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726019AbgBYPmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 10:42:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxW+8p14xqIPxF7fxiEAYsvx7BXgwB8Qh9ZLnaxEbBQw/vYfRorD76ITA6ZcuO3twHWVgdCMB3Q+EDTlMjAi1zw80uB0rOp/R2YsSDR0DQ0hRL0dZuGVArC5Pt0nhaltYV1KGT7V2rvmh9PHYJ8ET9IuM6zd/0w76zrgdcPC5nF4r0ULKsBre+M44iUe+kjv7YFKTbdkcedVlHVanQUzW9Hh8kNrm5FwYBLGnYNIb4+1Ri+f+F9zZhnHGse5NHtqdbOvOt9h4bqcryY5N1sbPXHs/1F5xnkKwPG2jflpnA1ECitibBw6imEDK7P+5FWLYh5zMcf79O/NKaOLZRn0iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NcONSiqzydKWcvnUwQSL/J/9oqn92TDVf2tJKrrunk=;
 b=R6kJmWrMhk77uKD2zl4RV8hgSPmQjMiwFKfy9ZKcvJVimVWRNTjdZXzkPFudDTiAj/yu2C6uoiFunEG9H0EA49EESng8wH3zrb5UBhpoG0zCj2t8hEaLHWijBVSOeoXRRRSPqCum9XZLdqLRbW0BAryOKSvdyloXDQsEmeE3K0nZJDs6+2z1+9JVhsB5X5yadqbucIpNjKJ9suIRSDQ/xrQ1f15tnhB8FRcjwffhVccPYrv41docqHfw91UWPwrK9ZpQeHoz90/PHf61dGHgfhRG6SoDddbnL/rIZJsJtttjDC6S34pCd9/OI2EWyTrCaXupxU6SyA3uGjfsB6JLqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1NcONSiqzydKWcvnUwQSL/J/9oqn92TDVf2tJKrrunk=;
 b=qqmYf/DqKwAjj0wHYeI5R7fEJFeJqLcsQq35bfqWcfYGsCOiUeENgclEmWebtjUCBa60g0jePk3uHhaJ3+KAikCsBiGtxhsMgMzLEdLlrfRsnXgMHd7MfLTF8KPWvBK6mO//Wn+Onwo+cegJoqPYvyEEMTCd4S2lOfvFxD/Y/y8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB2985.namprd12.prod.outlook.com (2603:10b6:5:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 15:42:19 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 15:42:19 +0000
From:   Tom Lendacky <thomas.lendacky@amd.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Bruce Rogers <brogers@suse.com>, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH] x86/ioremap: Map EFI runtime services data as encrypted for SEV
Date:   Tue, 25 Feb 2020 09:42:07 -0600
Message-Id: <2d9e16eb5b53dc82665c95c6764b7407719df7a0.1582645327.git.thomas.lendacky@amd.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM6PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:5:190::25) To DM6PR12MB3163.namprd12.prod.outlook.com
 (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from tlendack-t1.amd.com (165.204.77.1) by DM6PR11CA0012.namprd11.prod.outlook.com (2603:10b6:5:190::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.18 via Frontend Transport; Tue, 25 Feb 2020 15:42:18 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: caf28504-d10d-4457-eef8-08d7ba094c2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB2985:|DM6PR12MB2985:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB29850C08CAEC8AC0DE7D8BC3ECED0@DM6PR12MB2985.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0324C2C0E2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(189003)(199004)(478600001)(52116002)(6666004)(7696005)(81156014)(86362001)(956004)(5660300002)(2906002)(66946007)(36756003)(4326008)(66556008)(66476007)(8936002)(2616005)(81166006)(8676002)(54906003)(316002)(186003)(16526019)(26005)(6486002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB2985;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z/3xgVpiMvqgMY93yw7kQmBDWb/4/hJjTDVt7mCD/tNx+x9PxV0+PBpbYTskYKKRTnYgKya8KGf2A2UHyuAWl3/vCGRGFHlndBM258OFcqTCWwiCvAY23bD2riUcnaYISVBm5pQglmQ0GCXueeIqqdvI8uXdmsATnUy2LkfLXzBdEdDMzPmaox5ohfsNsLgwH2yTHiklICMLeES0cQu0/O1cQhp+W2besk5AL7hzvU+JPJgRq36C5YsdNv+QKX6L0TYijLhLNjy+j0wOOxcgbRKRW+C4UdV4M69rxgQJWHB6eDjTYmtCqc+/7eiKMzlX8THF82L56JHWm92ef8KTx232QWtSYwEYXrFd4EEtmbb6A5c8Oobm0fX4GCVUMAHifJGrWNyqAkJ6mYMer9dww2GkKZ9PEZ5+G5AympqB4vUoX55OcnU9MOREzQP9wMAX
X-MS-Exchange-AntiSpam-MessageData: p9z+bUm6Ws3LgEB2jHgfla2Cy3o6bGn41gVsJsrc4ZPgSAqZ1Lwhr5cZFuqFCOIZJpQ/c8pbMP5u+0yGKezwE13rQmGu5BmAuTq0VMTL5fX2qZBPSfxEI08ksUvVpEJ2vuppgfhS/Hgp3vBYrw9uOA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caf28504-d10d-4457-eef8-08d7ba094c2a
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2020 15:42:19.4936
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +tCrnsDYN6wCWOwLi4+FJSu6x0gDtxLEmcBDYVdoWQyfZi45Zk+6+gevXLvJpy0l5FCB1oXydh7yqivkjqb+Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2985
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dmidecode program fails to properly decode the SMBIOS data supplied
by OVMF/UEFI when running on an SEV guest. The SMBIOS area, under SEV, is
encrypted and resides in reserved memory that is marked as EFI runtime
services data. As a result, when memremap() is attempted for the SMBIOS
data, it can't be mapped as regular RAM (through try_ram_remap()) and,
since the address isn't part of the iomem resources list, it isn't mapped
encrypted through the fallback ioremap().

Update __ioremap_check_mem() to set the IORES_MAP_ENCRYPTED flag if SEV is
active and the memory being mapped is part of EFI runtime services data.
This allows any runtime services data, which has been created encrypted,
to be mapped encrypted.

Cc: Bruce Rogers <brogers@suse.com>
Cc: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
---
 arch/x86/mm/ioremap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 44e4beb4239f..382b6ca66820 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -135,6 +135,13 @@ static void __ioremap_check_mem(resource_size_t addr, unsigned long size,
 	memset(desc, 0, sizeof(struct ioremap_desc));
 
 	walk_mem_res(start, end, desc, __ioremap_collect_map_flags);
+
+	/*
+	 * The EFI runtime services data area is not covered by walk_mem_res(),
+	 * but must be mapped encrypted when SEV is active.
+	 */
+	if (sev_active() && efi_mem_type(addr) == EFI_RUNTIME_SERVICES_DATA)
+		desc->flags |= IORES_MAP_ENCRYPTED;
 }
 
 /*
-- 
2.17.1

