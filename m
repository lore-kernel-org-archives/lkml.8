Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF51C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:03:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0065B205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 20:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ifxOKiq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390829AbgEMUDQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 16:03:16 -0400
Received: from mail-mw2nam12on2075.outbound.protection.outlook.com ([40.107.244.75]:37921
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387898AbgEMUDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 16:03:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ewdnOJvvpsGK2j/1S42ijBIbFO0dIMFzlhuKuCIoVsbXoHNwCV6Z2tcoMP5xpKhEp/weidUYTDEsrE6eguK56jok3+foLSXp9vPmoSMaRHlMciC5ZqIXWdgK4BmAiz3UYmkyeFhJYqdEBBXsaecUtkot9O+NVZX55LEKeok4u83dmKpij0/sJjik3IKQ3GMvWw/Ez515oQdANhgos4ewR16T7F65LeEL0pzPKci2IdY10DBUc/Hf0oSsEs6gG2+4IvtYI3IeMNuH8ErNf7Qp8GNlRYEiFAtq36QZFHUAqwldJYdbBwS+hMNz5ccBge2/3msEAhMQSW02auaApDDz/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFGWfrXWfFu6ykq0wngkRNlTkhvt/8wG0Ro0evEZBXU=;
 b=eQI6OXfMXWtuaYGzQ4mX4WMHwhiIADZdY0Uetc/UgG/Tv60iWi0IvQsK1lzTpjDtoqRlvLA6r57j6VMkQpLPL3TvcRb7OdfDs4/71AMc3latG1z54USy4FJ8d9BugJ64D3hsFzx/YB1FWltWfY1goE6JVekdenj2Rj/h5f+zr2jgDK/OVrfHjWX5VZOMvlhD00fldZsVK+katpwpTdfez2lG6XmbYsT7LMUHmZShkdLRT4GfRBoG5kJio4hRkXpyjqv/v7Jtey54QerlGWlGamCjMa7kfjVmwKfnAHjuklxYM/4D/X0AfOebunmkHEcxDXiX2xnqAZkdFXQnmAbAvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kFGWfrXWfFu6ykq0wngkRNlTkhvt/8wG0Ro0evEZBXU=;
 b=ifxOKiq1OzWMhG/4ZoKo3llh8WNKGVPsHA8rE/FMdJ3sWtFCdaVUhtyOEiWevXX5mmJPQWV72A8F0jbt140aPnAYu7mF+pfDj6eqSKol0rg13ndVkfhmpx0P+r9EXx8yiGI2nglzaBZI6oVMCOsf9Lug+jYZrCSTCPP5lVpTJoc=
Authentication-Results: zytor.com; dkim=none (message not signed)
 header.d=none;zytor.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2560.namprd12.prod.outlook.com (2603:10b6:802:26::19)
 by SN1PR12MB2511.namprd12.prod.outlook.com (2603:10b6:802:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26; Wed, 13 May
 2020 20:03:12 +0000
Received: from SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d]) by SN1PR12MB2560.namprd12.prod.outlook.com
 ([fe80::c0f:2938:784f:ed8d%7]) with mapi id 15.20.3000.022; Wed, 13 May 2020
 20:03:11 +0000
Subject: RE: [PATCH v2 00/10] x86/resctrl: Misc cleanup
To:     James Morse <james.morse@arm.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>
References: <20200430170400.21501-1-james.morse@arm.com>
From:   Babu Moger <babu.moger@amd.com>
Message-ID: <83fcdce7-1ecb-7314-ed03-05ae25d90259@amd.com>
Date:   Wed, 13 May 2020 15:03:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200430170400.21501-1-james.morse@arm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM5PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:3:13f::27) To SN1PR12MB2560.namprd12.prod.outlook.com
 (2603:10b6:802:26::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.87] (165.204.77.1) by DM5PR17CA0065.namprd17.prod.outlook.com (2603:10b6:3:13f::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.24 via Frontend Transport; Wed, 13 May 2020 20:03:10 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c41f82d3-0fa3-46a2-f9f8-08d7f778aa05
X-MS-TrafficTypeDiagnostic: SN1PR12MB2511:
X-Microsoft-Antispam-PRVS: <SN1PR12MB25113FDCBC30D6D2B83B3EEE95BF0@SN1PR12MB2511.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0402872DA1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: poH9r2ix7lY5rjkPP1SHyZjH9vRSG+cYvieOr5JVUlN0WCK4qnChUw60FZ/J+ak0gchH7Nmyxl8DceuTpedqzjff+pMIkw6E5ScPuarN1DHVuEcB5Yr5xM2pATLRunzEwfMvRIbtu5PO06EsTsURjwCC+TPAVEuWIPDzJfQJljeT8weRu1CiBUzAvlaMM9uBQ0THWsAb4PnQfhfbowB2D/59LKQxIAg3gbgValayNv+NYbaBJSb3e+amoAjLqqhYBURTp6lVpD/WZR2YBl03vypdl3JYCv1hGDLS4XChCvCQP0aXHheeW0iKc949IOUSQK4dDdxFj1OQ4YgrvFR75JaSCFz2DsbuQMGcbbhOh7LX/CZZ+xCZVuVEjAgB6jRAMYPm/yDV1MqgWHziiJzCUum0jnxRPyDVsgoLqOzOPAJXMTJ3423qqUOFagH6wjGCanSEq1KC7YlY9TCDEsmdg9pTkGz9GklnPIHKYxNb7Jjo7CR6ZBEA6Iva3Mp2E4PjfwVlmuCJLe9speiBi7ePCTBO2lKN/HL3Mf+6g7IAHs3AOBJCrVJ8t+N6uy947zbgsR0lbOYRqxoQNC8Krx6+hN3DuwCID16/1VEzR2y6Nbs6x3vE3dKS9WvSGY5OOSaWkVMRPAN/D0/L0s+WKKtkEw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(376002)(366004)(346002)(33430700001)(33440700001)(8676002)(6486002)(66476007)(66556008)(5660300002)(86362001)(26005)(66946007)(186003)(31696002)(52116002)(4326008)(53546011)(45080400002)(478600001)(2616005)(31686004)(36756003)(956004)(110136005)(16526019)(8936002)(16576012)(316002)(83080400001)(966005)(54906003)(2906002)(44832011)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LHBFiUfijtCCiKMN5Hxsdl+6jVrJTWfN/KnQ/FJZbXXJo0PNPlaz2BV5Mtf2sCbTKOGfSsw+lIwGaZvUrvWsaftF39jfuBBE4FOirFDq895YvMnASgI/om1cDv5wgN6aE9kTbpe1zmojjBVExamXTJk76D504Bqi7Y2PvdvdxSxwGPLwlS/yPV42u2OlMtVs9bZ2cuPVT5Iyes9QeHuQWPf16IQZW0SolDilZmRwX7AWPm46Allaui5uCWexVyiqrae/hinWLmvY9mH6LAlRxUz7Q8hkumuTL26jQrLgTW7TF6v9TnnZnZKSaLV6sCEF2zLkwfbnvInrT8QNV2Rta3zgHl2nJIp2uSr05yh+dbk+b1g5T9GLDHovk7xINPj8duHvrtfw1o8tTiu+eSpj2p+HDrpuqJcdJaWf21EdCE13T5QCc3sriXyFGeyZT1ICJHMlDHWpXWsk/7y1J5roXWHszmLHDbmey+rtkPwJksI=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c41f82d3-0fa3-46a2-f9f8-08d7f778aa05
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2020 20:03:11.9247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtiAGf0oAsqByPsSTOSNGG7p32NzqIeFmpCMQlh+WwP9GQjJ/Dul4Vya+MQpybFr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2511
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,
Patches all look good. Tested on AMD platform and working as expected.

Reviewed-by: Babu Moger <babu.moger@amd.com>

Thanks

> -----Original Message-----
> From: James Morse <james.morse@arm.com>
> Sent: Thursday, April 30, 2020 12:04 PM
> To: x86@kernel.org; linux-kernel@vger.kernel.org
> Cc: Fenghua Yu <fenghua.yu@intel.com>; Reinette Chatre
> <reinette.chatre@intel.com>; Thomas Gleixner <tglx@linutronix.de>; Ingo
> Molnar <mingo@redhat.com>; Borislav Petkov <bp@alien8.de>; H Peter Anvin
> <hpa@zytor.com>; Moger, Babu <Babu.Moger@amd.com>; James Morse
> <james.morse@arm.com>
> Subject: [PATCH v2 00/10] x86/resctrl: Misc cleanup
> 
> Hello!
> 
> These are the miscellaneous cleanup patches that floated to the top of
> the MPAM tree.
> 
> The only interesting thing are the patches to make the AMD/Intel
> differences something resctrl understands, instead of just 'happening'
> because of the different function pointers.
> This will become more important once MPAM support is added. parse_bw()
> and friends are what enforces resctrl's ABI resctrl. Allowing an
> architecture/platform to provide a subtly different function here would
> be bad for user-space.
> 
> MPAM would set arch_has_sparse_bitmaps, but not arch_needs_linear.
> 
> Since [v1], I've picked up all the review feedback and collected the
> tags.
> 
> Nothing in this series should change any behaviour.
> This series is based on v5.7-rc3.
> 
> Thanks,
> 
> James
> 
> [v1]
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.ker
> nel.org%2Flkml%2F20200214182401.39008-1-
> james.morse%40arm.com%2F&amp;data=02%7C01%7CBabu.Moger%40amd.c
> om%7C1d3c1ee27e204ebece3808d7ed288034%7C3dd8961fe4884e608e11a82d
> 994e183d%7C0%7C0%7C637238630922264101&amp;sdata=Gcfop8YPzsPFq8fk
> bgnR%2FZgQApnQYVbaCdRlhpE2YPE%3D&amp;reserved=0
> 
> James Morse (10):
>   x86/resctrl: Nothing uses struct mbm_state chunks_bw
>   x86/resctrl: Remove max_delay
>   x86/resctrl: Fix stale comment
>   x86/resctrl: use container_of() in delayed_work handlers
>   x86/resctrl: Include pid.h
>   x86/resctrl: Use is_closid_match() in more places
>   x86/resctrl: Add arch_needs_linear to explain AMD/Intel MBA difference
>   x86/resctrl: Merge AMD/Intel parse_bw() calls
>   x86/resctrl: Add arch_has_sparse_bitmaps to explain AMD/Intel CAT
>     difference
>   cacheinfo: Move resctrl's get_cache_id() to the cacheinfo header file
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 35 +++------
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 89 +++--------------------
>  arch/x86/kernel/cpu/resctrl/internal.h    | 19 ++---
>  arch/x86/kernel/cpu/resctrl/monitor.c     | 15 +---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c    | 32 ++++----
>  include/linux/cacheinfo.h                 | 21 ++++++
>  include/linux/resctrl.h                   |  2 +
>  7 files changed, 70 insertions(+), 143 deletions(-)
> 
> --
> 2.26.1

