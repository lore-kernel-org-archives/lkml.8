Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CBEC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCEAB2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="gZsRAVlN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636217AbgDONpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:45:22 -0400
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:22369
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2633518AbgDONpP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:45:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeE8sd/JKLclgGUFIfGItgCyPIstnnyTn0uU/YJEhhGDNsvQX/MDf4CjZC3WfS72EDGQIKcZBBIN5fRy0XLwxI/bmIaWEuLZzwx5zXs84MKxcD+9YHW9aj6MpNRQL6QA07VPZFRxCuO1mQBPEKnCKQA1cQvhwIHNbQ7Xihp6loEUroyD0LsgkfIArFofG3OSmK/eQ4OXpj5HNFqWeWDhgoDxu55KBHT8HKA9MKaPqBv06OOJ+ug7DVOESmd214XKIJQhOx8EqEQMpj/KvU5tyGAI1nDQ/TuSR++c5o+KIG/wGvhVzGUKnTU1FcB176K/7AWczwDUJVnFZHDqpzFWAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56Tde8n5DYeayScoe3+lRWv9tHtRPzimG2RbSCK73TQ=;
 b=QjQsr8MJeOKMpt7LPf9KHzU+/sCq2y8s2e1Exw4QQJlQKu5M/uWjZTtHP5Kph7xO+eXw16jfOCmswmp1pKwVfn/w/bAAuBjLseYw8/i8PwCI4DwcMKOe2j+yTMzJE/3gyG1pD7tCkEyzdvXV60f38MAphXTGcaHeoPoon5i5QIjNTL2hZE7QkAb8ZFG8sYjPSrqeljnQw3gt5RyRWvahDBwZqzTu+Pt405klmcVP0jARwbj9/xH6ehirr/0WN5FSpUrlrLrqgn4n1lSbyoZl3ov/6TwaLqQkCSIhExoqz5b1S1UxRtSrvbg95lMqmWwSIeffTLv9Q0gdpF1VkSjeoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=56Tde8n5DYeayScoe3+lRWv9tHtRPzimG2RbSCK73TQ=;
 b=gZsRAVlNU5po33U5b//eh3xyRMBRn/jhHaatbt3HV5e+n6tVJ4PefhxbZfiYGMzg93/bYd7Myr9Qsg86trqTfqeEUPq8X/EV6dE60qC2VMS3Q9hMlPJPx1J4FMB12efnmyreKZkPmM05AzY/hSLvxlkPWCVdff8RdwKoaUwEchI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com; 
Received: from DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
 by DM6PR12MB3915.namprd12.prod.outlook.com (2603:10b6:5:1c4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Wed, 15 Apr
 2020 13:45:12 +0000
Received: from DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733]) by DM6PR12MB3163.namprd12.prod.outlook.com
 ([fe80::f0f9:a88f:f840:2733%7]) with mapi id 15.20.2900.028; Wed, 15 Apr 2020
 13:45:11 +0000
Subject: Re: [patch 5/7] dma-pool: add pool sizes to debugfs
To:     David Rientjes <rientjes@google.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Jon Grimm <jon.grimm@amd.com>, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
References: <alpine.DEB.2.22.394.2004141700480.68516@chino.kir.corp.google.com>
 <alpine.DEB.2.22.394.2004141704050.68516@chino.kir.corp.google.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
Message-ID: <0c7144e3-057a-959d-0b7d-4a718bd6076c@amd.com>
Date:   Wed, 15 Apr 2020 08:45:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <alpine.DEB.2.22.394.2004141704050.68516@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46)
 To DM6PR12MB3163.namprd12.prod.outlook.com (2603:10b6:5:15e::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from office-linux.texastahm.com (67.79.209.213) by SN6PR01CA0033.prod.exchangelabs.com (2603:10b6:805:b6::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Wed, 15 Apr 2020 13:45:10 +0000
X-Originating-IP: [67.79.209.213]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a45046c3-3089-4356-63c8-08d7e14337a3
X-MS-TrafficTypeDiagnostic: DM6PR12MB3915:|DM6PR12MB3915:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB391572CCC26184D63BD0A6D3ECDB0@DM6PR12MB3915.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0374433C81
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3163.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(376002)(366004)(396003)(39860400002)(346002)(136003)(110136005)(86362001)(53546011)(478600001)(52116002)(8936002)(36756003)(31696002)(81156014)(6486002)(54906003)(8676002)(2906002)(66476007)(66556008)(6506007)(26005)(316002)(66946007)(2616005)(956004)(4326008)(31686004)(186003)(6512007)(16526019)(5660300002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Os9UcVQ1IphYmlX+p7VLkP2HjBW1Qn4uPZVRx0yzoz9I8i+4P9GbF7II/i0NFRFDw/SxPo/HwR6koSdRqYNitqrDZyFX0sq2Zl049qpTyKbu4PcM57ui0c7DYbsQNm7oZLNwMQ868psXm7jiPVPfn9UcDLb0L4WO9VJRq7xd1XniMBwvoY3XUAJbWfps3riLJetFyrQiB1T69sjc7eHjPqfhjJxW/Kr9qk5TJFSC3kkOAZRTnUjZ3hi3boiwMXRkFk+lgGZaDJtBZVyVa57IgqO2j4aoUQUhAodOWrpP9SJ8Imzu3sOaWZI3fOqAWU5BkpxBUwexaF0Bt4+yODcxv7yBzWCMw1L86bt9L7XkjucP9+HlNDl93ibBDfxI4ZWbNflNfBy5DyXyF08pCPKXVyk0zfkTu6LzFLpvAL5eOD/D5fNEgWyvSmrYtlIir5aR
X-MS-Exchange-AntiSpam-MessageData: kkJzg9pd+/tWkqHuZEWJCtLCb5g0xYtRhjhLnw0exwXlpvBrGKP8Dv6PWZ+mhP/p9MDXOj+50uxCOI/nhyN7cisrvdh5hM5e3b4gDPAR1X8Da1yFrRBopStxkruTGkFgutEjGaRtGQTWgnYp/bBAcw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a45046c3-3089-4356-63c8-08d7e14337a3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2020 13:45:11.6963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKSWeSXnZnY015HTvOmB/ivb5v4pN8LNDVjfYI8RtVTxLW88wOpjq6zpnG4NTXmjqqJArA4bfF2OwXx4YZUNGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3915
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/14/20 7:04 PM, David Rientjes wrote:
> The atomic DMA pools can dynamically expand based on non-blocking
> allocations that need to use it.
> 
> Export the sizes of each of these pools, in bytes, through debugfs for
> measurement.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: David Rientjes <rientjes@google.com>
> ---
>   kernel/dma/pool.c | 41 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index cf052314d9e4..3e22022c933b 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -2,6 +2,7 @@
>   /*
>    * Copyright (C) 2020 Google LLC
>    */
> +#include <linux/debugfs.h>
>   #include <linux/dma-direct.h>
>   #include <linux/dma-noncoherent.h>
>   #include <linux/dma-contiguous.h>
> @@ -15,6 +16,11 @@
>   static struct gen_pool *atomic_pool_dma __ro_after_init;
>   static struct gen_pool *atomic_pool_dma32 __ro_after_init;
>   static struct gen_pool *atomic_pool_kernel __ro_after_init;
> +#ifdef CONFIG_DEBUG_FS

I don't think you need the #ifdef any more unless you just want to save 
space. All of the debugfs routines have versions for whether 
CONFIG_DEBUG_FS is defined or not.

> +static unsigned long pool_size_dma;
> +static unsigned long pool_size_dma32;
> +static unsigned long pool_size_kernel;
> +#endif
>   
>   #define DEFAULT_DMA_COHERENT_POOL_SIZE  SZ_256K
>   static size_t atomic_pool_size = DEFAULT_DMA_COHERENT_POOL_SIZE;
> @@ -29,6 +35,38 @@ static int __init early_coherent_pool(char *p)
>   }
>   early_param("coherent_pool", early_coherent_pool);
>   
> +#ifdef CONFIG_DEBUG_FS
> +static void __init dma_atomic_pool_debugfs_init(void)
> +{
> +	struct dentry *root;
> +
> +	root = debugfs_create_dir("dma_pools", NULL);
> +	if (IS_ERR_OR_NULL(root))
> +		return;

I believe GregKH went through and removed a lot of these error checks (see 
9e3926df8779 ("xgbe: no need to check return value of debugfs_create 
functions") for an example).

Thanks,
Tom

> +
> +	debugfs_create_ulong("pool_size_dma", 0400, root, &pool_size_dma);
> +	debugfs_create_ulong("pool_size_dma32", 0400, root, &pool_size_dma32);
> +	debugfs_create_ulong("pool_size_kernel", 0400, root, &pool_size_kernel);
> +}
> +
> +static void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
> +{
> +	if (gfp & __GFP_DMA)
> +		pool_size_dma += size;
> +	else if (gfp & __GFP_DMA32)
> +		pool_size_dma32 += size;
> +	else
> +		pool_size_kernel += size;
> +}
> +#else
> +static inline void dma_atomic_pool_debugfs_init(void)
> +{
> +}
> +static inline void dma_atomic_pool_size_add(gfp_t gfp, size_t size)
> +{
> +}
> +#endif /* CONFIG_DEBUG_FS */
> +
>   static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   			      gfp_t gfp)
>   {
> @@ -76,6 +114,7 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>   	if (ret)
>   		goto encrypt_mapping;
>   
> +	dma_atomic_pool_size_add(gfp, pool_size);
>   	return 0;
>   
>   encrypt_mapping:
> @@ -160,6 +199,8 @@ static int __init dma_atomic_pool_init(void)
>   		if (!atomic_pool_dma32)
>   			ret = -ENOMEM;
>   	}
> +
> +	dma_atomic_pool_debugfs_init();
>   	return ret;
>   }
>   postcore_initcall(dma_atomic_pool_init);
> 
