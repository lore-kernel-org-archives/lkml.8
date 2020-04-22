Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2417C55181
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8166C20722
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 02:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="DKg61iHT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDVCfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 22:35:46 -0400
Received: from mail-mw2nam10on2077.outbound.protection.outlook.com ([40.107.94.77]:38113
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725912AbgDVCfq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 22:35:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV34iB+UzKPY5oJzKrUDBg73qTxmsWueJaZLF8vjDVlgTV1fH4o68KPbtGWJWYh8wfRsNF+IUAZ3tlgvtZuKIiseGGGd0Z0Uunr60evqY8IXawv87Qarb/SrAYAZywzaa9msGbmxUT/hd+1mzbsQpyGsBMbFJvBXSqdafK4Wzy/Nl+//1BgDJx2E7eigbDNdaEcLdwvxS/lc/YCjOZyO9Qtr9809RAXc+YYdL32LN2BfYvl7K142EZsBCjLAiNTrBEz4akE7/Gp8Wt8TECZNB9t4JGXFXVx6OXeF7evS6L4/nUWoa0noHZlYUFBkO44e6RkItui9CLc/9wketBZU6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gEAf3FfvU4u+UHJeR0OMF5JozqCFY1AsVUY7XQo1hQ=;
 b=KC6aa2QA6cCFnrhR0Nydpim7xp4D08qWwZz6S+f3EcTyo6f8MadZQ/alLeUH77X71oAaXOSU5Wmad+vA8ethd9wDqqmdYmnbO8JNG6jjcy7r4R4MNID/KJ5GCa6t904VXNvUx6U4tUO3gI0RGvov4WScsyL/ri/UyQ82VLLSK9IgXzzQm7kOeZznJ2zlty0mSlA9jH7BKvNnLWo601r+3grvh6ppjJii/lHdsD91GsAq5fn+O5zIuSurCrvQpBL3+wCizsooaw6XBuU5dOYNS8/ESO7P+WhY4wNUJ/hYrNsAF1phXBEIMvAUeccaXBoONSpw/gwZL1EAVrrwL8nXJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/gEAf3FfvU4u+UHJeR0OMF5JozqCFY1AsVUY7XQo1hQ=;
 b=DKg61iHT6LLLTzYW1uyyWsTLslZKuhp40Mw8ae5MGVKUP+I2nlWOlk4sbSLEijTGyx/ihgR1P9Oh2vAiJKtV4I2a/cXnSqbmKjoddMRPqDMdB4X1WtXmbScigsqC03N+xIKjwC3L0LLaQatRsfvVOXgchVthQ01YB+I8lyn7+SI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2494.namprd12.prod.outlook.com (2603:10b6:802:29::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25; Wed, 22 Apr
 2020 02:35:38 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 02:35:38 +0000
Subject: Re: [PATCH v5] drm/amdgpu: cleanup coding style in amdkfd a bit
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200422014618.4020-1-bernard@vivo.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <33574896-c858-8929-aeb6-24ff4dc26b5b@amd.com>
Date:   Tue, 21 Apr 2020 22:35:35 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
In-Reply-To: <20200422014618.4020-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::39) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.31.150.44] (165.204.55.211) by YTBPR01CA0026.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::39) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Wed, 22 Apr 2020 02:35:37 +0000
X-Originating-IP: [165.204.55.211]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 01318721-b96d-4916-405e-08d7e665d788
X-MS-TrafficTypeDiagnostic: SN1PR12MB2494:|SN1PR12MB2494:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2494B2EDA787E3837079FB3392D20@SN1PR12MB2494.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN1PR12MB2414.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(478600001)(36756003)(81156014)(2906002)(8676002)(45080400002)(66556008)(186003)(16526019)(16576012)(316002)(66476007)(956004)(2616005)(66946007)(44832011)(110136005)(8936002)(5660300002)(31696002)(52116002)(86362001)(26005)(53546011)(66574012)(4326008)(6486002)(31686004);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZbV8aj1yienlknJTvkxCfo2p42L8+K5gMUb37a9zPupheaZT8oatnvrSGAT3Se0n1Kj2Ur0AeOLo/syg5teXFipW6mrSokqWZUxrgU1tNAB+wuYLrKrE+oIOqnbElFeELawYDniQZGlcfIvJeQEUtPAYYmMnbJJIZeEmtdCRh5T5M53Ux6wx0rdjQO9vrrYL5RNHBIyrZoRAtDlSquW5onSYes/XMUhDSKAEmfh8PEcBCoCTQqYZElVU+vs07fC+ozgVwhaWv2bxgt08mdu7qWOfKQgNw+rVlCz5e/9DJk5HcZK1T3DW8x8eXohm0nOowoA4qsioOfJN3C28RJRXP9SPPLjsomwGgRW/oX2nA6NbrMOPnky4e5JdrCCWvN9G3goC9EWej4oaFK7WhuJaldLZfkHuY84WD7XiqcJJnW4GHCMAmSq5XJPZLs1XkOMGPzS5pQgpG2aNNZ22xS1Nekjlp9AolA3nHP2k7WbNBLpZ6XN0SwoM7TekmSrusHEiDkacGwne/liZfgZF8kIjUA==
X-MS-Exchange-AntiSpam-MessageData: tMZB5AQPAzwvBnGY51vUNO0uGVJ4knG/6WUdJOTB3Mvlh5rQ3+zzejqTH68fUysYlPMl+wREgkea0B7M/0gk3bMvoIJwBRSOCrFDWnZq+7VMiIc1bbFiJGLEzidNw+twYJvfkG4ODemrfu1u+Pxd+A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01318721-b96d-4916-405e-08d7e665d788
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 02:35:38.0679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpYTzhCC/gzhWAZSCwdmDuNI/GqLoo0OfTsA/dcpQwZswxW+saweHcg5LUVRlrViVl4v84ryq0//bh8wFMtpwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2494
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020-04-21 21:46, Bernard Zhao wrote:
> Make the code a bit more readable by using a common
> error handling pattern.
> With that done the patch is Reviewed-by: Christian König
> <christian.koenig@amd.com>.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Thanks. The patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>

I removed the history from the commit message, made Christian's 
Reviewed-by official and applied the patch.

Regards,
   Felix

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
> Changes since V4:
> *Improve the subject line and commit message
>
> Link for V1:
> *https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fpatchwork%2Fpatch%2F1226587%2F&amp;data=02%7C01%7CFelix.Kuehling%40amd.com%7C27509aa0455042beedc708d7e65efc22%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637231167951862118&amp;sdata=JPCxsDycw0JvZfym1akV7d%2B4oPzvzQ04Zl1rv3WN%2Fj0%3D&amp;reserved=0
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
