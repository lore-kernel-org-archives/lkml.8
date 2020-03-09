Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B12DC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 259422067C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 14:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="34xYvzUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbgCIOpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 10:45:23 -0400
Received: from mail-mw2nam10on2051.outbound.protection.outlook.com ([40.107.94.51]:6167
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726650AbgCIOpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 10:45:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjRfyWa8zSMWNV3NBq7tVSfi0WlUdlWs0z390Pr7Yo2ynNOEgsT3NBc9wGo5KiF+loPcRJFz+DiMUCLTcnTQISqBqIAhwc9yk/hp+WyC5bduUDx2ObhrWErNvriORMMM2oLku4v4UXnpRxT8xERCNLifK3jZNBT3h3FfmNbmYgvYiyYFClAST/kghVDbzk7ke/8eFiB0oFFLcgo795D26dE2CB+BYFb8jNvj5hus3ZEqrcZayiRom3mZIfVuFhN0MHV6fdVFEMRLo1WfFsBzmJ7Tx4CQCuXib82y7jkMLXJs6d98k1COEF/78PQRviWV4FL2ZUAb/X/shT9Uol8t9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxt2o9IsuYXBt4nIRTbZ4kMSuWJmei+C7yIetWZBkPk=;
 b=RJqE4VZoXVUeKt27Y2dD0GYZTPcsMdKHgyXxdwc71xGgRuUhTfjw4Pr86MtVft90uYa7O+mXn91j5zIUBDmLYgENa8goH5LtPDuf+nH3/Vp7P/TWy9daggk3WIffkOCzSq07lcCAQA57jycxsEDq2HALmuyZedrrMDzTFd+KV3evJ6EmhGCrQQrH3kSDc/MGZdBHm53Uwjl79E1bV8AlCTFnqH1txFuRW0FsVjGeDz3CPn3i2ZG7P4ExNDEtLVQgWaaYfQ5gMRcERN2yL8NGzbOwOgzCxA0AYue90v7qeFeoXmVv1Nm1EowMmo834HcmTGA9+AXvqBkZuN0t4+9Xfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxt2o9IsuYXBt4nIRTbZ4kMSuWJmei+C7yIetWZBkPk=;
 b=34xYvzUEFnZTzVW1Y3W+nbnzMKtVsXwibhtVww1lHNbqgIrP5Kr6TKohN9oKsnVoekyBL5mcUeE0vfRBnbT/G2xLCUcwHkT6LYdIBLQUcKH4mAg0GrPPTMoYMe2BSnGxcvPhJI+/ZMkqfwq/RpgjLhAD2/vS3rSlArwiVtuVjis=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (2603:10b6:3:10c::22)
 by DM5PR12MB1353.namprd12.prod.outlook.com (2603:10b6:3:76::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.17; Mon, 9 Mar
 2020 14:45:18 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::d40e:7339:8605:bc92%11]) with mapi id 15.20.2793.013; Mon, 9 Mar 2020
 14:45:18 +0000
Subject: Re: [PATCH] drm/amdgpu: Correct the condition of warning while bo
 release
To:     xinhui pan <xinhui.pan@amd.com>, linux-kernel@vger.kernel.org
Cc:     nicholas.johnson-opensource@outlook.com.au, Felix.Kuehling@amd.com,
        Alexander.Deucher@amd.com
References: <20200309143458.18411-1-xinhui.pan@amd.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <9da8f3a9-5d28-37b9-cda6-8be336068e7b@amd.com>
Date:   Mon, 9 Mar 2020 15:45:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200309143458.18411-1-xinhui.pan@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::11) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0024.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.14 via Frontend Transport; Mon, 9 Mar 2020 14:45:11 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c2d19feb-a126-412c-ef76-08d7c4387c37
X-MS-TrafficTypeDiagnostic: DM5PR12MB1353:|DM5PR12MB1353:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB135336EB596824A305EB5C9283FE0@DM5PR12MB1353.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-Forefront-PRVS: 0337AFFE9A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(346002)(39860400002)(366004)(396003)(136003)(199004)(189003)(66556008)(86362001)(31696002)(81166006)(81156014)(8676002)(8936002)(478600001)(52116002)(66476007)(66946007)(36756003)(5660300002)(186003)(16526019)(4326008)(66574012)(2616005)(2906002)(31686004)(6666004)(316002)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR12MB1353;H:DM5PR12MB1705.namprd12.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hs33sSkPQElKS4tZ1cQ51zL6vZF2P1BbHFkNC4MzMWXzOqMN7dxKTzH9rTxPTHXSGHWOcmTDGBNbJdR7cMgVZff0LB71TeKDvmecEMGNHZc7WcPTmbYu1aJ2O8ZbmLjxHm98H5bau8oUvfyk0yjClhccNA+TQqmgUOU8YRu6ED4rm2fqBtcFut71IAJOe9iNgeiwcy2uhrTm67uyFUvV8BdjS1bgOnVMi09s/xXRV99lnjroeiW5TJ94dEj/bAf5hRtQSiT2PJexdo7YDA4vKamHBWN4+ByAVp5uB+H6gERIFTYLnrCa89ESyjxQy+Zzq8H/d4XTPlgfLe2gNuPJdDlq5bjAYWBB7/A1pcUcdJE5E0CnzfKI5oaYvnd9mh6ifQb4SEZ5o1zFXqUQ0GGgKyiXXDzTIzmQCj9F1bsv3A4n5nfU5BhfiXDLxdBsIqbg
X-MS-Exchange-AntiSpam-MessageData: XV0GAgQsDIWFGPQXQfx4aL3t1h9M//k9vaIIOl57soktFwgg43IFYCDL3ib1FK6KtM984j6RICtP4EF+L/ADx+6o5/mhjaKolwcWxfHXVGZBL/AW6EctKXAss9tkmBoWY3SEgIcD2+TCpOpsYgzLJtDGjmeElI29WH/YIt26F7CKT5bSLytjet/pvuwFMcWUF+JbamVb8c9kYUOIzfmstA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d19feb-a126-412c-ef76-08d7c4387c37
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2020 14:45:18.0836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CtGsOkYPETFSr0JHj6hRj/0HwJsHCnhvA5mINAxQO8gxYYQEnQ+6jeiZ6rGsReTP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 09.03.20 um 15:34 schrieb xinhui pan:
> Only kernel bo has kfd eviction fence.
> This warning is to give a notice that kfd only remove eviction fence on
> individual bos.
>
> Signed-off-by: xinhui pan <xinhui.pan@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 5766d20f29d8..e99f68af2bf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -1308,7 +1308,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>   		amdgpu_amdkfd_unreserve_memory_limit(abo);
>   
>   	/* We only remove the fence if the resv has individualized. */
> -	WARN_ON_ONCE(bo->base.resv != &bo->base._resv);
> +	WARN_ON_ONCE(bo->type == ttm_bo_type_kernel
> +			&& bo->base.resv != &bo->base._resv);
>   	if (bo->base.resv == &bo->base._resv)
>   		amdgpu_amdkfd_remove_fence_on_pt_pd_bos(abo);
>   

