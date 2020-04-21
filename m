Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09778C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3D9020882
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 04:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oEFuCFGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgDUEYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 00:24:25 -0400
Received: from mail-bn7nam10on2083.outbound.protection.outlook.com ([40.107.92.83]:34848
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725904AbgDUEYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 00:24:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nGbGp+uYwaGicVM4nsaF0yoUO7keluSj0BUukqAOz7z3Lo+Hl5L35bBaOAifUumUYzkEByIhZv34a6mt5u+tYQovZZquLBIrMmp948R1KGyku3qpQEh7Nr6Zjt3BqtEUdw94Up1YteSkiVRsvkIsJoAOZEaesWXeLa4PQQeWKyZj2/1Z69vdHgR9KBSfpFTokqEeDHeI3Fchrh9osQ124fJ1iHOyEBaPSA76OKYNoipNUvXtxEFmTg1SXexeyC+xFsuhFr1cLxVi5FjLLpCtOTF8iY57VdMLgg2MXKJQh3FDIWnH4bDa5dB/N8Cvik6mJsu5tYNcIMcnJy4fZZO/eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD5NizHRGj0I9gxECMqK3hkrXrT+bz07WHXVMFTolVk=;
 b=b5re075T6maFL7KlyAU34QW7w/DbBsQtRPjbFR8hV2ekJGlBmz4TiaXPqA9bFihpET8gmqgDS6HQQOIWhviZOfwYe71SbTSQWao5AX/1GudtHgoNPY3EB9TdLiLIYMduN0lcMZjKAmSFFFiPg8qipxZpSLq/IWuOaa721O6Pto5P5LITc1JDaVGSUEqGGg0xHudlhkpXJeP0PgBhlLxqaSw5X6MtAosT5zmgDrZFBQLPj5+HQzzynStvwpqHK90duNtEb7rIRC1cIjGii472XuSC8cmj6irT92ajtagaADnKfab2jwjKdH4DrtPvcvR70lgw8ciBMRDDLUz4nrqG4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aD5NizHRGj0I9gxECMqK3hkrXrT+bz07WHXVMFTolVk=;
 b=oEFuCFGOOzxx9GJY9IrJGLf/lXh2NTOZ4/y+4aspbtI26izgSimeFhwUzXYHz4S1RWk1JrbOhE0GkciB21MtdTyHKnXbQr3T22Rcti+1Y19gnzRx/rzpw78BSx56pAqHzlnAgqBQjlVb7a0F4lpUsAcMLGRdm5LwGXnhYL0RENU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from DM5PR12MB2407.namprd12.prod.outlook.com (2603:10b6:4:b4::24) by
 DM5PR12MB1548.namprd12.prod.outlook.com (2603:10b6:4:a::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2921.29; Tue, 21 Apr 2020 04:24:21 +0000
Received: from DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f]) by DM5PR12MB2407.namprd12.prod.outlook.com
 ([fe80::7d36:4eac:2088:637f%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 04:24:21 +0000
Subject: Re: [PATCH V2] amdgpu: remove unnecessary condition check
To:     1587180037-113840-1-git-send-email-bernard@vivo.com,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
References: <20200421024159.126753-1-bernard@vivo.com>
From:   Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <7fe6eeef-3129-3e54-67a2-46eccca9f529@amd.com>
Date:   Tue, 21 Apr 2020 00:24:19 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
In-Reply-To: <20200421024159.126753-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::26) To DM5PR12MB2407.namprd12.prod.outlook.com
 (2603:10b6:4:b4::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by YT1PR01CA0117.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2c::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 04:24:20 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 990e234a-2325-47d3-5e4b-08d7e5abdd32
X-MS-TrafficTypeDiagnostic: DM5PR12MB1548:|DM5PR12MB1548:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB154840A2A45FBB18FED246AD92D50@DM5PR12MB1548.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:873;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2407.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(16526019)(956004)(2906002)(5660300002)(44832011)(31696002)(478600001)(186003)(26005)(36756003)(86362001)(31686004)(2616005)(966005)(81156014)(66556008)(8936002)(16576012)(6486002)(52116002)(110136005)(66946007)(66476007)(4326008)(8676002)(316002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2IZ0OOX7LFD3OjvGaQvxPsGlz55U4rgOTMHlkvro4soabEEdDFX1ArFv7OPxE91JCQhQQIZfwGO4OlMzUW5vgnxLlGyb/viEeZliu7msDTsskAwSxT/oS93MLCaUBlDnqtABfgU8tVwsfRZIzju1pR2rwD1Wke42N/OJwIjr4ZOjZZ7I+CjariLXGb0p0S4ANQIMm34w0h+PQ5d5bdm2tWYJSnNCh3qSynq9/XQ9kwqIfXvL1m4aL4pK21edrUrotULKsAQChICfxLSOnnW182S2SVuJ9MF8Unq974AYd9iZsE5wz11N5Hme+58NmmnzmUJ/tcFz2oRD7YDr9xIsboh/n+CJTr38pFpDTMtbHYLfb2JtYJesGtmAPg0CBKnslWOvKB7UggTOGqD+dMMlokzixkBIYsPUvApQpBEFWh8GciMRrPjA9IuDRVLM8ce8bY2dc0Pj/Sf649YpZhzXrT0W5qMOSC7KLJxEGRSOCyft0V2BDt+k4tNhdThno+viz0OZDCgZTcuq70A0mrf+bw==
X-MS-Exchange-AntiSpam-MessageData: o5dYl1/jTuWpYb5bkSYLXyKY/0uwsKtZ5nVvuNvmcIrsgFvekYp/5qRrsXFUPw+cbw7WztMxxtdC3LGz7SpWckIuRiHRX2XPFDrGzxOnMnCYIkcSA7iwkIIRVMUoe3UNpf1q9Yh65KadQkmrsBFckw==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 990e234a-2325-47d3-5e4b-08d7e5abdd32
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 04:24:21.0947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fVrIoCOqNiQObYKJ46RRGAbL6osF/U7U7F93dzY+AGJZ/xlup7kINFTJMdK9BHWYmvhjoifABLGbl1Sh24X0pQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1548
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bernard,

Please see comments inline.

Am 2020-04-20 um 10:41 p.m. schrieb Bernard Zhao:
> There is no need to if check again, maybe we could merge
> into the above else branch.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>
> ---
> Changes since V1:
> *commit message improve
> *code style refactoring
>
> Link for V1:
> * https://lore.kernel.org/patchwork/patch/1226587/
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index 9dff792c9290..a64eeb07bec4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -660,13 +660,15 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
>  
>  	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
>  				     false, &ctx->duplicates);
> -	if (!ret)
> -		ctx->reserved = true;
> -	else {
> +
> +	if (ret) {
>  		pr_err("Failed to reserve buffers in ttm\n");
>  		kfree(ctx->vm_pd);
>  		ctx->vm_pd = NULL;
>  	}
> +	else {
> +		ctx->reserved = true;
> +	}

Here you're just reversing the if and else branches. This change looks
completely superfluous to me.

You're also breaking coding style conventions. The "else" should be on
the same line as the closing brace "}". I'm pretty sure checkpatch.pl
will complain about this.


>  
>  	return ret;
>  }
> @@ -733,15 +735,15 @@ static int reserve_bo_and_cond_vms(struct kgd_mem *mem,
>  
>  	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
>  				     false, &ctx->duplicates);
> -	if (!ret)
> -		ctx->reserved = true;
> -	else
> -		pr_err("Failed to reserve buffers in ttm.\n");
>  
>  	if (ret) {
> +		pr_err("Failed to reserve buffers in ttm.\n");
>  		kfree(ctx->vm_pd);
>  		ctx->vm_pd = NULL;
>  	}
> +	else {
> +		ctx->reserved = true;
> +	}

Same as above regarding coding style.

To minimize unnecessary code changes, you can merge the "if (ret) ..."
code into the else-branch of the previous if.

Regards,
  Felix


>  
>  	return ret;
>  }
