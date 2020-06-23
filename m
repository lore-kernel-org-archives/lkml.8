Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97E9C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B1AA20663
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:00:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="X85CBh4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404232AbgFWVAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:00:38 -0400
Received: from mail-eopbgr700056.outbound.protection.outlook.com ([40.107.70.56]:39137
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2392144AbgFWUkK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:40:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TSb50AcM+VMJWs8bBxSPU62fbc6P4n6DbmTHidOeDiUapzV6i42a1KSx3SO01MtqPjnqlG8hk7vGO3yY7da587knZZerkWAJRdT7KYTt+WxMUtj1KFUfMksHDX3/nXx0Ip+3D9R4k2/hFzY52/gGv+ojPvF+cAmcmIiIQzRY1EQOpYB9xh3rfVYwOaCLyDYhDgoYrOlN+uX4v277LJ2fWZSHjQZG8wRDcBO72JCmDyYhJp5Se+oVF8fz9qXQM7IXhYWo3NWqd6vnPHBu8COZhO83exB0Vs/eqVnwBEDke1h9tjj0BUp3Z+13cOEqvA8Pj5l5HGgnyqIyLbmimewUFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1nbJ2IyEeTDOYfPR3PSP4zkaz7uaxyFk3aPsK3t/Gs=;
 b=KC5lGDHF+8BGWDvuszVoUZ8Q616uOhuKSQOLlX+PaZ/rtWFaA3c1BzybBQHotwUHzvOy+QPXOzPWqhY1/l6lmWwepsOZ9tdwnatzk9KHUjF+WCivuTpzDScrno16QBHeE875+l9vfWq/oUbnzKd7jyzx8hsbcJDRnnNUjxBWn+Rtvxak1C0Wqg8U3ET/mBP7Ry7DZw3vCOg6bCmYLhmKp2rEY1s71ANDUOS9EHvPhcNbYRmA/FWIsw83rLR4oUq39g1e+qWp3Qp1fp6it1JUcSlNVzfjF6gtktIGRSyiWJqqSI5OhwGW0ID2eT4Qp9NYpWjLTYOaWqy2VCNIzNokuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+1nbJ2IyEeTDOYfPR3PSP4zkaz7uaxyFk3aPsK3t/Gs=;
 b=X85CBh4lTkoJQfESJ2/v3bXi98IJscvUAUIBXVtVTYakMrIqe32xr8C2xVJHceNJtnUtezKIkG/914qvo63v1oaFQNNxkiZ+t3vNn11+uRNPZghuvTW+h+Foyo1RDRNYHKM9Ouu1ZdXSOcVYEP8A1ZyWvboyMs0nE/nob3msEtA=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=amd.com;
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SA0PR12MB4525.namprd12.prod.outlook.com (2603:10b6:806:92::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Tue, 23 Jun
 2020 20:40:06 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::18d:97b:661f:9314%7]) with mapi id 15.20.3109.021; Tue, 23 Jun 2020
 20:40:06 +0000
Subject: Re: [PATCH v2] drm/amd: fix potential memleak in err branch
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200620085407.21922-1-bernard@vivo.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <44839e7c-2b97-a06f-b1c8-af3fa3d52e13@amd.com>
Date:   Tue, 23 Jun 2020 16:40:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
In-Reply-To: <20200620085407.21922-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YQXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00:14::20) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YQXPR0101CA0043.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c00:14::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 23 Jun 2020 20:40:05 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6f314ea3-10f6-4950-fded-08d817b59caf
X-MS-TrafficTypeDiagnostic: SA0PR12MB4525:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR12MB4525440A80C6C5F88A0B900D92940@SA0PR12MB4525.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 04433051BF
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kd3QFKOIEN9imQwaa58gHZ0AfjaL3URfb6zwv3m01ZQaAlhc/z+5bhdEx33rpDW8aIxDOVDKJj6XsJ2LYq0PUWhzI/JRc84CSXKCjAiG2mOjHzoxWjbswYtUh8TgDucdBFI5XolYkQROEDz+DGd3IshK9cbSeNLNVW4/+8dvHlDC1r2PjNeKW/jZI7ryle5qhUucVGCGWGwB3SIEhyx2MRHJq2W1dHS0E1Tuwyx2eQkKn9Dw8hmVTpurC7558EtUk97pWZWssahK5GFQZDS6+JkjVdd/vk6QeVcdOVvtaeAqLKzIx8DfLVtBYznpg2z2uu8p1jS4sME0tbkYjVS963MLvj+RjASdRJB0KWFN6w+UvBH/RCfgQyaAa9kANJPJ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(8936002)(498600001)(5660300002)(2906002)(6666004)(66946007)(66476007)(66556008)(8676002)(52116002)(44832011)(6486002)(31686004)(2616005)(956004)(36756003)(4326008)(31696002)(16526019)(186003)(16576012)(110136005)(86362001)(26005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: sjraJlb8BXBWHSqEl3PnOsYt8Dt/lO2sjSONTjZjshcgSS4tmjQKRY4PUUNXoM5WGANw9M/0fkvGGQF9bxtRh5v+hGH0k8XU2ZWpZb9kjit/F17B6tRvFs/Ema+F+T56SCa3iRIBCqCQJSEb7xVq0S5/TJj8gcFMRF1fOH4/pFG32q5ZehYNPtWQVia+/FWdTaR1ko6fiE6GwypD2myTtnWgArDSVos4Ha8r60Rfpmf1FXUjZYepeRWy+9eMYVT+2K5aU79PzWTeXfymSkOPmaLkVRqdx3LBZqBrzG4UHXZDursKyOD7jwdBobKiS6VF6ZkIBYe8B2XDJ3rT6lZNqY+dc2bwtHQaX0PycP1ItxfNSE/xfROsgye5aLLzd+51mWYi3SDOO86WlnxyZ0sqOejV0J9RZxeffJVjjsXmd8Pu8fB3ZC1MXRiWjyQVRxMaq8IxZq4EUPuaHDy918y3mrTyq8nArFyt08RXBTjreGJtd4fCqn3PKb79jereBUM5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f314ea3-10f6-4950-fded-08d817b59caf
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2020 20:40:06.0702
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rykK2pa1oy7Bz0dGSdQew4DTENaDcyMgo4Y6RRloiFPcuZ/dNmFyYYPoJYEKzglqdir11eLLZMdfUHJz5yejdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4525
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Am 2020-06-20 um 4:54 a.m. schrieb Bernard Zhao:
> The function kobject_init_and_add alloc memory like:
> kobject_init_and_add->kobject_add_varg->kobject_set_name_vargs
> ->kvasprintf_const->kstrdup_const->kstrdup->kmalloc_track_caller
> ->kmalloc_slab, in err branch this memory not free. If use
> kmemleak, this path maybe catched.
> These changes are to add kobject_put in kobject_init_and_add
> failed branch, fix potential memleak.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I'll apply it to amd-staging-drm-next.

Thanks,
  Felix

> ---
> Changes since V1:
> *Remove duplicate changed file kfd_topology.c, this file`s fix
> already applied to the main line.
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_process.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> index d27221ddcdeb..5ee4d6cfb16d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> @@ -124,6 +124,7 @@ void kfd_procfs_init(void)
>  	if (ret) {
>  		pr_warn("Could not create procfs proc folder");
>  		/* If we fail to create the procfs, clean up */
> +		kobject_put(procfs.kobj);
>  		kfd_procfs_shutdown();
>  	}
>  }
> @@ -428,6 +429,7 @@ struct kfd_process *kfd_create_process(struct file *filep)
>  					   (int)process->lead_thread->pid);
>  		if (ret) {
>  			pr_warn("Creating procfs pid directory failed");
> +			kobject_put(process->kobj);
>  			goto out;
>  		}
>  
