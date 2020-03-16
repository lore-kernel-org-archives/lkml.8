Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59A8FC0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22CB420772
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 19:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="wd/DZjs4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732462AbgCPTns (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 15:43:48 -0400
Received: from mail-bn8nam12on2084.outbound.protection.outlook.com ([40.107.237.84]:41665
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732413AbgCPTnr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 15:43:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fDjY7rLxxl4HUnjLMS5FMR8s7y/Ku8WKETGSp3UNQ3t3P007F3Pb/106Uqrof1axqlg0t/RiooHkYPpN56QsvbOrYK5yESfujeK5QU3hpHaOoItfGjfly/PqeDPnHxn23bqISZP67y0/cdAfS963M6SF6DhZCMBfZmqdCF1w97jbeTby+Kp2b7UmhXKIbRKXaUSUiVPJh15mPu4IEKFhINd01kT9uKfIbYnG9yY06z1rdSbXaIpyeKr32pmE3mGQuR/gDZVjYB4UQcuQxeGpcRhDUe8GXjZs/vPiGrIo4Po+I+t8GLZKhpBhSfEEhJHWLbcOoW1WkKY+MJa621o47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrvNRANh/YZFmJb/0y4D2jkQScDb7TZfNmx9GfyroaU=;
 b=NuTT+NmhtpbqhVA62xxA6T7gnlt9IaUOkBNUcZ3uwzyPIVFKK0VgwjGNz5n5/wKvP9gHU1f+WdJzqRHVvg4J/roInyQrAGgZVwFrK4NkYPaVTSEXuQsAMJgLM1YKn1l+pxRcGAyCHMjojv1aErxei1pcZZWwwcWVfuY9BwKTxRd6noiiqjV5rKLCUd65VFWYo6All0O7oMj87BAIqJu/I3BYHYX+azsK69CF6V/SlbOF9JIZoOZ1Bo887nKFRHKhc+NwzbVpTYPNFTtkECxpXiHOKEnv3aAUnZn+xUjFUICsJ1FuKqRhH4AE8LnQEcJULMMZwIqwpxCxa7eK5JYSsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FrvNRANh/YZFmJb/0y4D2jkQScDb7TZfNmx9GfyroaU=;
 b=wd/DZjs4SKJU0PNPGvwRvyrxjYflyDy/pPPBzehI4wJckNeQaQHgQqtochepOKXkF2pQwZCvgHeWwdp+10BxvtDTbxMQKEiLh4BfvcsT07HlhRP2f9HPq1v1CAkpgzxspVcjFGJ5fcT5yUe7GqbSKgdGQwQ5YR8HXxnf37f4PJY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3515.namprd12.prod.outlook.com (2603:10b6:5:15f::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.22; Mon, 16 Mar
 2020 19:43:43 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2814.021; Mon, 16 Mar 2020
 19:43:43 +0000
Subject: Re: [PATCH v3 1/2] x86: Don't let pgprot_modify() change the page
 encryption bit
To:     =?UTF-8?Q?Thomas_Hellstr=c3=b6m_=28VMware=29?= 
        <thomas_os@shipmail.org>, x86@kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20200304114527.3636-1-thomas_os@shipmail.org>
 <20200304114527.3636-2-thomas_os@shipmail.org>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <eb422a3d-9f0e-5101-ebb6-c16f90219c3c@amd.com>
Date:   Mon, 16 Mar 2020 14:43:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <20200304114527.3636-2-thomas_os@shipmail.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.236.30.118] (165.204.77.1) by SN2PR01CA0027.prod.exchangelabs.com (2603:10b6:804:2::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.18 via Frontend Transport; Mon, 16 Mar 2020 19:43:42 +0000
X-Originating-IP: [165.204.77.1]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: bafcb9b0-e840-4e9d-e48b-08d7c9e25576
X-MS-TrafficTypeDiagnostic: DM6PR12MB3515:|DM6PR12MB3515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3515180387A628859F467DF6ECF90@DM6PR12MB3515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:565;
X-Forefront-PRVS: 03449D5DD1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(199004)(4326008)(66574012)(110136005)(8936002)(7416002)(81156014)(81166006)(2906002)(8676002)(36756003)(31696002)(16576012)(186003)(53546011)(16526019)(86362001)(52116002)(2616005)(956004)(26005)(316002)(66556008)(66946007)(66476007)(5660300002)(31686004)(54906003)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR12MB3515;H:DM6PR12MB3163.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: S6/nmY/IC56qZe/xkgaebyAwW0wpKCWRwWbIwzsC4/bHBc+pwyhINv3QpQx0JSk0i52gJBLjnvvBYRrjRr6GNVQ7w4kcvdX5y9sgSdlBNR+zu58GPqLHmF+/V9OeroBzQbWc+7waOM4NMrX1XThqANmL7RI/e4QlfXbGvqV0NvMct0PpIVGoQBX4STJHMNzKQZ3bw90YDNLNEW2sPUEYQQCDxoaQBi1bVsa8lqOrYzNH1r5fJz0o+1mUpcsEUMO7Twopf3F+4v4lW3EJ4Jha8OikKOuxpIKHqVqwfyajfqOH0DAgFwuVnRimugdBkdjqJmeRvd4y0IyvT9d71JzgRU5kVrOMPPWRYdb6DkO/sdTEIlZgF1bNZLHRH0ou3oMEQ279k91Pwe+vL33owO3AnVZ35T1axc/c2GhG84K2pzqOwtDZAdP6CN+yYIG3DI4z
X-MS-Exchange-AntiSpam-MessageData: TTMhJHUr7UpwknGTvMXufcrn4ROhVgT3Q+lRezuIKNb6aKcljpCoJi8CQuYvJAKoRyZNcb0veIP9IriiqHWf9RfsYpTkwkbcwL88rlduFAwAH0A5LeGvVkj0l46/W9YEAEl9N+AKxxzlyk73HkV7SQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bafcb9b0-e840-4e9d-e48b-08d7c9e25576
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2020 19:43:43.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ur3wCdCcQkpW491b9e4spKCprxCgxy5z+qrWD8RmSDAMUCK24lCj5i8/xC+EGdLf8bKox2r/+sgLl255C8UxGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/4/20 5:45 AM, Thomas Hellström (VMware) wrote:
> From: Thomas Hellstrom <thellstrom@vmware.com>
> 
> When SEV or SME is enabled and active, vm_get_page_prot() typically
> returns with the encryption bit set. This means that users of
> pgprot_modify(, vm_get_page_prot()) (mprotect_fixup, do_mmap) end up with
> a value of vma->vm_pg_prot that is not consistent with the intended
> protection of the PTEs. This is also important for fault handlers that
> rely on the VMA vm_page_prot to set the page protection. Fix this by
> not allowing pgprot_modify() to change the encryption bit, similar to
> how it's done for PAT bits.
> 
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Thomas Hellstrom <thellstrom@vmware.com>
> Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>

Acked-by: Tom Lendacky <thomas.lendacky@amd.com>

> ---
>  arch/x86/include/asm/pgtable.h       | 7 +++++--
>  arch/x86/include/asm/pgtable_types.h | 2 +-
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index d9925b10e326..c4615032c5ef 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -627,12 +627,15 @@ static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>  	return __pmd(val);
>  }
>  
> -/* mprotect needs to preserve PAT bits when updating vm_page_prot */
> +/*
> + * mprotect needs to preserve PAT and encryption bits when updating
> + * vm_page_prot
> + */
>  #define pgprot_modify pgprot_modify
>  static inline pgprot_t pgprot_modify(pgprot_t oldprot, pgprot_t newprot)
>  {
>  	pgprotval_t preservebits = pgprot_val(oldprot) & _PAGE_CHG_MASK;
> -	pgprotval_t addbits = pgprot_val(newprot);
> +	pgprotval_t addbits = pgprot_val(newprot) & ~_PAGE_CHG_MASK;
>  	return __pgprot(preservebits | addbits);
>  }
>  
> diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
> index 0239998d8cdc..65c2ecd730c5 100644
> --- a/arch/x86/include/asm/pgtable_types.h
> +++ b/arch/x86/include/asm/pgtable_types.h
> @@ -118,7 +118,7 @@
>   */
>  #define _PAGE_CHG_MASK	(PTE_PFN_MASK | _PAGE_PCD | _PAGE_PWT |		\
>  			 _PAGE_SPECIAL | _PAGE_ACCESSED | _PAGE_DIRTY |	\
> -			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP)
> +			 _PAGE_SOFT_DIRTY | _PAGE_DEVMAP | _PAGE_ENC)
>  #define _HPAGE_CHG_MASK (_PAGE_CHG_MASK | _PAGE_PSE)
>  
>  /*
> 
