Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC077C54FD0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C19E8206F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="caWv+7KM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbgDUNFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:05:33 -0400
Received: from mail-mw2nam10on2059.outbound.protection.outlook.com ([40.107.94.59]:13396
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726628AbgDUNFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:05:31 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=emlaL6yRkjQE0ZFz2rddeTg2UhdBnF9YNl5kp3tPGvTHwuQDVb4Kbsg12Q3znQEM9qvYv7qhDh/OBTAk++C6Xw7OopDUsRI38XpziLkJ4BM7DpdSZIHsJuYVnSHlFG+GLhv5IkJ9eYAUwtDibzgJ5Ugjf4yejNzJQPSPQIOhZO1pTLNgyykU3sR5l52NR8zW0DaFSZPTVDrHIROgy+2qTL8ysk7S7DIA1xQccvTn+zb91na2LZLEhlD28K2lxLFguDCM9Y1DnZBgTkVQ54oM4FwIwyWEULTvvJyHu41XTa1uvn1yCb61NrAZKWWXGrvBRxSzVPhYx/y8f5yLxGwe2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHwImg6UcA0H14EWa04BcH/A19IRKG+d7fxqX2m8Fbo=;
 b=eCFzcJ3UPPA9ytkgBqjfXn14okKCfLqgiastUZpV8f6owmARfM1ynpQciGzOzZp/eoxODZTspd5zEnUVHWsjheHe6+EPVOtn5dxMzG3Wa1DQ7HMryTE44qzF/a4+AOxsnzvFc678+dtQ3VX8ahkUf9i31Y0/JmZS56hIoCHkMfb1UO9S8ZxExVuurBu0faWsK1K5rueRanFGze/Kz6v6fCiSioJPHSPrut76tT9jcngVVaPjehcEyPS/DXkdipM/MQ2Rb+xkRaf2oNdu+xh2L3s8ZkqZp+oSaHisr54hiT1Vhu+soQLrlpS6fCxucoaJLnh/4/UtAWiB+vZZupG8SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHwImg6UcA0H14EWa04BcH/A19IRKG+d7fxqX2m8Fbo=;
 b=caWv+7KMyJhZD9NRe/GKHgvYJL1F6gWKB9TjhBqY+GdFe7ASavwXSrKdgJ6VReZIbxD8TRKAHq82NEWCJ8efQp3kplVLi3S8xSONIX56qXLVWZn5mEuJ3WXUZKQQUL4oIXkNsTyiwDaXnZqfjagFEi/GB3IQBmPu6D9oI+d04us=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 13:05:28 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 13:05:28 +0000
Subject: Re: [PATCH v4] amdgpu: remove unnecessary condition check
To:     Bernard Zhao <bernard@vivo.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200421122218.1849-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5b4923f6-7f02-ce90-d250-4600616d2176@amd.com>
Date:   Tue, 21 Apr 2020 15:05:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200421122218.1849-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0024.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::34) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0902CA0024.eurprd09.prod.outlook.com (2603:10a6:200:9b::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 13:05:23 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: eaff50fd-e452-4e71-7a66-08d7e5f4aa14
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:|DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892BB438993B57797476A6D83D50@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:883;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(346002)(366004)(376002)(136003)(39860400002)(8676002)(36756003)(31686004)(316002)(8936002)(4326008)(110136005)(66556008)(66476007)(16526019)(186003)(66574012)(66946007)(2616005)(5660300002)(31696002)(2906002)(86362001)(81156014)(6666004)(45080400002)(52116002)(478600001)(6486002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7R8x8xsdLfzqrMNhFpywcjQyU03t02G3k4JzC25lArEMNDjsXkMZUGcbpTDKcpVQ8b/NYHKspHQyBWbtHNirc/hEaiC96sgOD033VzK5SvCMsliYRFtsRXeI5q/FJ5prkOvupuSok7Rf332tNe6BuDYOe+/U22eOTXcrCp3ncRqZfg3thWoN+gIA+2VVV8XepwsEoxnR8GVVlObdgMvOmFpWizmakKLWgbDZyexZGrPO9bMCGG57IwC8j1LTHPKUpoWfmmbdsc8+sjMLzm/U4lqIZXsLVggJ2jY7JArp8HRetSg0f49zCyBswuVcXZ+nmvPELtLeqlwI8rUdDbjat2/L/Jzq6Qn9dLK8kSZMmddXnQfEALSYCpqZex65UbgKVLbREg/VAPyPKv+nsXuP9j74Ek3ATFWRPBKRGWw2piSfJ51gg8ENTAjYxWnfj38X++04CJl3M4uqjhAFaUCm+OSIZr5jZ7aEcWswBGV4af7b+r8/fKnsI1poxrH18e33DX+hK7RkP3ecPPF4zAWx5A==
X-MS-Exchange-AntiSpam-MessageData: CmiHnCrUCo/0BOCMrE9G/tH5uIiFPwB6nJAnbhnj76otSLqjv1w2hz8HEwHYrSoXc2s9//C7LFCwc1C9h/ObWM4K4Wc2mjRHzdvi/J4VKZmOp/G3CQel1njR7RiHigWYNFnxjoGRV61jFruskzY7Fetx/grGA7sCR75Alk+wDjds+RFdwEGSfMBaECFiKy4UB9fHaN64B7GXTAHxQ2DpedxCdYWcF6prt5/C8nK/Jdw0Uy4SRrgoGj/2Qunvx6n8kpwGL8mShlBS9+qKPDzRfrEnAPVzukwJqpv8tmgGFsRNtTjXsR9j0Ati6BE6R7n0TpmHoXutLeVY89XiOGiP9V4YqkUgFrIlFq/69m0Jo39cYUFTb0BEO29sUH+2LvXewHuA3v7nrM5B9pyQ8G4VQ+5ZigZGsMIkpWrgc7xymXqvEXjNbPJgp+ShFlg8qn2ndLJdbWBT7A2Khza0o3K5wfOvsrm1FXEDipPkCaSe2eQw+3+FnskAdFpXNrs+C4ASirEA6oOqhPDbEtcDtPtTYhqybjDiNX01j7lYlt1G0KUDN/kjCwjTawtpKbQA1IMLTC/H83FncjJShYj4kQXYxxVnauXoJU4o/5y12WJLQrHmD2Rp3AOmMafiQTW6mxdgWRfaI7V2NYXzlLtO21Oh1uZwy1Whqo+OS2ZIjHijBqfQBhZyfgBnhqO/f9ygFMXdAauQRX2C8QovK9e1iQKMm6hVTieHb/ssAhSbx66qSOyO1qnBfgX2TrIbe50cMmFtvy0KWwg/YfoHuQeQtFASWOe+bFaKyqf9WiaFSJq4Vf28DxHflPa8/vI6hu7LmiLLoAmugWm3nS61VSpzUSiQX7TonYDPbNUfsNKzlMV3gqc=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaff50fd-e452-4e71-7a66-08d7e5f4aa14
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 13:05:28.8367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xDoKcfZu2YOJSB7AGJ8734GtqpkOhQhSBdn7s7o52w8HinvuJJ00Agpdmj2ZvWFo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.04.20 um 14:22 schrieb Bernard Zhao:
> There is no need to if check again, maybe we could merge
> into the above else branch.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

You could improve the subject line and commit message a bit, e.g. 
something like:

[PATCH] drm/amdgpu: cleanup coding style in amdkfd a bit

Make the code a bit more readable by using a common error handling pattern.


With that done the patch is Reviewed-by: Christian König 
<christian.koenig@amd.com>.

>
> Changes since V1:
> *commit message improve
> *code style refactoring
>
> Changes since V2:
> *code style adjust
>
> Changes since V3:
> *find the best way to merge unnecessary if/else check branch
>
> Link for V1:
> *https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fpatchwork%2Fpatch%2F1226587%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C6b521b697ea84cfd324308d7e5eeab7f%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637230685564330098&amp;sdata=m2lhfgcINuB%2BT3%2BhhQjtROI3Zp38QDEilF9RTceg3HY%3D&amp;reserved=0
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 20 +++++++++----------
>   1 file changed, 9 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 9dff792c9290..acb612c53b9c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -660,15 +660,15 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
>   
>   	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
>   				     false, &ctx->duplicates);
> -	if (!ret)
> -		ctx->reserved = true;
> -	else {
> -		pr_err("Failed to reserve buffers in ttm\n");
> +	if (ret) {
> +		pr_err("Failed to reserve buffers in ttm.\n");
>   		kfree(ctx->vm_pd);
>   		ctx->vm_pd = NULL;
> +		return ret;
>   	}
>   
> -	return ret;
> +	ctx->reserved = true;
> +	return 0;
>   }
>   
>   /**
> @@ -733,17 +733,15 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
>   
>   	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
>   				     false, &ctx->duplicates);
> -	if (!ret)
> -		ctx->reserved = true;
> -	else
> -		pr_err("Failed to reserve buffers in ttm.\n");
> -
>   	if (ret) {
> +		pr_err("Failed to reserve buffers in ttm.\n");
>   		kfree(ctx->vm_pd);
>   		ctx->vm_pd = NULL;
> +		return ret;
>   	}
>   
> -	return ret;
> +	ctx->reserved = true;
> +	return 0;
>   }
>   
>   /**

