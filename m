Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B681C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D28A20795
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:58:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TC6Owbu7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgIJI6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:58:44 -0400
Received: from mail-eopbgr770041.outbound.protection.outlook.com ([40.107.77.41]:49838
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730323AbgIJI4M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:56:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XOG6DY+EPqE6P9wHG/AISnV8fsRGtz/cy6yymJUD7lhMN+yGvjD7j7bvsD/PEa4MtMpAQx4UApF61rUjnHYe0iDMy505rdSDQ1VbqvoV1Ef1QmJQnXHtf9lZlVbiwMBEZTyKgJhWbKaeF8/SPqVku5Qf2lGruH0zmAcNAVgViS2WeO/RY5ZlRS+YlFWC19N7lqNj37v6bntbYidx837t8l3b21ImS2DQal+uAW1o0zJ8wKbS0Dp0n54wuqg7A4V5oOtK4BP3e01aVLUQANLuo3h1lU46rF2f44XbZ3cs5sthC7bW7TSCyhRViuBbWnCp/BZlC7RZfhz1CNVCTyFKyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNRQaZoogK/2ZM/LPwm0vzzFVmdCm+IHMPGyq+vgVC4=;
 b=fdbemJV17ZwWat1bE8lxZGZN3Do350otK/e8AZ3gD/FFKaopAwVvI5bxLmSi6vxww/h0gUeu1sdt5cc2Rzk8M+sIpaLBXoGN5qs3t2VKSTLbW49Xd1D7p1TSbXg9yUvmR89Tqc6WYu/Lm6D6wLDKprBnM/BMISUNrJ21zDSPAa4RW1ft0PfidB95MbNEKfqVeu4yUDyn9o3kp7WdKR4TF9rhM+4D/6fPpKnMEYFqiTYVRC6yMnwzmVWZ1Oz/2UXl4wVt7jNkvXpoXlECccgmIMqnsZeRoNaLRisRyjaqoMmi1yIIs4VtEzYwTfPYfP5uMghRJyZ8e5HNw6a+iCer0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VNRQaZoogK/2ZM/LPwm0vzzFVmdCm+IHMPGyq+vgVC4=;
 b=TC6Owbu7hSzGjgPce4C7Lee2NO0McEvlRFzp4a1CosbxSuVr+Y8a+jkXoJcz0imXiBZCm6WEI08Vtrzr4dcQPP8ZATClK6yzvec22Ifa+y+6CMT9Dg2GmDyFW0bmBc/0d3AjHQkJn34RT+zz4YC/veMhoOQcFSDE7lW0wxspMgw=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4125.namprd12.prod.outlook.com (2603:10b6:208:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 10 Sep
 2020 08:56:10 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3370.016; Thu, 10 Sep 2020
 08:56:10 +0000
Subject: Re: [PATCH -next] drm/ttm/agp: Fix Wunused-variable warning
To:     YueHaibing <yuehaibing@huawei.com>, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200910023345.20428-1-yuehaibing@huawei.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1226ea65-a957-baa2-e9c7-fe88b1aae620@amd.com>
Date:   Thu, 10 Sep 2020 10:56:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200910023345.20428-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0133.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::38) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0133.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::38) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 08:56:09 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 06d6f89a-da56-46c9-6cae-08d855675cff
X-MS-TrafficTypeDiagnostic: MN2PR12MB4125:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4125753B30C6C4CCE9D2758983270@MN2PR12MB4125.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:644;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VTuP6JNvr/DnGVcfz7rrkXKB/DO5QbJfBP6lOYjOaM7GpqV1RBvLk6TsI19tdkxAUt/WJGgXCw2JS+JbCvi6aj6hWwU0cvB5S9FpTy/ZUPAtMdmPwMvh+RivLU96JSp+xxS/Mz7hqO9cDNxlgabW9Nm4AovbdEm7oFweZqFNO8CMvg8nRkRZf2l9DGWbDnIMrfnIpwrYdIYbtYa8hPLNwQu/JZ4e+1iEVe4ehpGsPv/EU0yJMKG7HXXebxiiUqtD6Jn5dy+bQGNylB1LE0YnzjE06jzodkbCNK1EZpuiGyjB/SNEG7aGa7089ZClKtrj2YcRCtPp/CdSH5MSPftyLxBCcsgrEAqv3GeUJA6ZLY5jinh9/IHuMVNjg1RlNP6w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(376002)(366004)(346002)(136003)(396003)(5660300002)(16526019)(2616005)(4326008)(31696002)(36756003)(8676002)(8936002)(52116002)(66946007)(66556008)(66476007)(86362001)(478600001)(316002)(6666004)(66574015)(186003)(2906002)(31686004)(6486002)(83380400001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xoc+rpqzqoN4Meoz7OOGwpFUsXmtTdEGAnRRVgEmOlZmWbv/SjZ7H2xs0zmYjValBgAaFy7jpWNVIF+ZqgF8ZUuNoRs8sBozpWTUNIze4YB+kezm4ZVpzyl+vnBH1T3CQ6dvdOeRXwwWv+038YY2bmRWNFYKSMktPY2D5ZXdGpxT2X9aJ2YwHqseK6WFfMGMo3rG0pqFzVk/OwiYg6BP55avb2uMDT2d2oPMTGcZpTzI+MQ6DlVhYczmH1GYSd0HgZunPRSZHBJkeWBTq/Rh6Tl5Cr4LsQSG8rdfL7Z2eDcmXsRniWCqBlWNQQ229S3cqpr54N7as8tElYeVisdkM5kZYfSld6kzgjZhfgsj/1uKmBRAPDZx9MrBWZRmxHBwL+ep7wqtwSaMmdPv1TEfACjwZfu5D5C+degZGm3/yG/y+gZR7pjk8uj7nJHxGIF6nGDgSzZp+KuS9YeBcuOB38LYPZFVHIyuaj/lEDlmAUQu0rzqnL8Yv5GytuGS9LHpN7KAGypoqzpGbABkki+ezCkwx6JsbS3qi1uDeWkwe3gSrHPrKLm+8sp6byDTmgQ+yhj8N4k8WesRutPfgBX0RsmKvxSaW2LEN1OSzRRKFi4PqYES7dQixO4lIi7kH8yQv5JBnDuNvEn9SOiUbiROSwNoZNNtVRXF+x9fGup0nu5ynbsfnjBn2St3YaBVpLzsbQy7kwwOiHEHA8rZiHDuJQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06d6f89a-da56-46c9-6cae-08d855675cff
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 08:56:10.5889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSGKjYzdUsbpD9aj2IMfQWyzMCyiQ3xXHcFXheuXd/oBsG84OIqu4EbgcLGDbP8r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 10.09.20 um 04:33 schrieb YueHaibing:
> If CONFIG_AGP is not set, gcc warns:
>
> drivers/gpu/drm/radeon/radeon_ttm.c: In function ‘radeon_ttm_tt_bind’:
> drivers/gpu/drm/radeon/radeon_ttm.c:692:24: warning: unused variable ‘rdev’ [-Wunused-variable]
>    struct radeon_device *rdev = radeon_get_rdev(bdev);
>                          ^~~~
>
> Move it to ifdef block to fix this.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
> index 31c63d339629..449e77eb75f9 100644
> --- a/drivers/gpu/drm/radeon/radeon_ttm.c
> +++ b/drivers/gpu/drm/radeon/radeon_ttm.c
> @@ -689,9 +689,9 @@ static int radeon_ttm_tt_bind(struct ttm_bo_device *bdev,
>   			      struct ttm_tt *ttm,
>   			      struct ttm_resource *bo_mem)
>   {
> +#if IS_ENABLED(CONFIG_AGP)
>   	struct radeon_device *rdev = radeon_get_rdev(bdev);
>   
> -#if IS_ENABLED(CONFIG_AGP)
>   	if (rdev->flags & RADEON_IS_AGP)
>   		return ttm_agp_bind(ttm, bo_mem);
>   #endif

