Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 368EFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F282320768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TCPvpvo1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731048AbgF3IFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:05:43 -0400
Received: from mail-dm6nam11on2088.outbound.protection.outlook.com ([40.107.223.88]:6021
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730993AbgF3IF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:05:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M4arbnuq3tpAzuJoYRrqSxNxDrI+mdDvtWn/aaw3NXmggPTcz0J0Df5z+MrRXF7pwMZCQKrTGKMkUo6vhatgOkJ+FYyyeiH7ax2/k6D/2BtnszEwLaev+2QSO5VoMj5KZ6qV5F7jsOrcOz40amZ2OHylzc/TdJGAC9RQw1/2uWA1y8qkGsP43Ff16pTDWgQXjQ67HgAiPw46iXDsXfdCq/Z6QBfXOMN4pPglawoutusvVnP5Fooy9eEy2/6wt4MIRbiahNROO8wN5uLk+xsED2qO5bm8YurV2JJ3RplFiSR9CWZaYGD+PQUI4NySSTR0m0Axi4mYv6M3MPkoq7mOCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTzsDbRyzcH/KAgeP7px6IIx/n9epAkYHt3PToPOesw=;
 b=CwmFs0iejuHT7+FFFa7WmGZQLxw5fC+AsE/KjI7/nP37z5IAQlJiaLam/gbnbrtC/JcjavxejVG5JF3g5j7sQm1EhU4byfSoHtAed8vckPMPFZ8PsW/z5UpbqssDkLy32ESpUhyVsTwBVYijF9jYwABTOzBYZJDvWM993APZSI6oWFkrpHcHCCAwYkVYWDJ5KW3P3ouq1X7MPisCIo1j+mB/KSZDs/l0Hh7tUroNQbBkCglGJHLM5NJKsOECJE35jL2R8RHDhzwW6DApVNelio5u2I2B7veQfM35EvIv80UT1wjyCEXE9Bsx4Bg7S8xxuHw7edySREAWhCQ4p/GlzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tTzsDbRyzcH/KAgeP7px6IIx/n9epAkYHt3PToPOesw=;
 b=TCPvpvo1Idua5fTr4Vg/6GAJ7lFWFRdkNKBXvQWO5VQAXa0HyOe5lk/Prf2cpliWoukaADkmtdpmXzW5t0lBzYsAdB4uS17TR6EMvqvZvisPwwcSbVGKOUfER1DkWiIfn4UC1ykACwpJB4EZP5Wm9bQrF+HCeW4mPplL3hARPMc=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2515.namprd12.prod.outlook.com (2603:10b6:207:40::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Tue, 30 Jun
 2020 08:05:21 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3131.027; Tue, 30 Jun 2020
 08:05:21 +0000
Subject: Re: [PATCH] gpu/drm: Replace "%p" with "%pK"
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1593502561-15190-1-git-send-email-yangtiezhu@loongson.cn>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <26fcd5ec-4e90-8b98-8fbb-605f5906ad75@amd.com>
Date:   Tue, 30 Jun 2020 10:05:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1593502561-15190-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR05CA0127.eurprd05.prod.outlook.com
 (2603:10a6:207:2::29) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR05CA0127.eurprd05.prod.outlook.com (2603:10a6:207:2::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20 via Frontend Transport; Tue, 30 Jun 2020 08:05:20 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 404334cd-f06b-4961-7fc5-08d81ccc5593
X-MS-TrafficTypeDiagnostic: BL0PR12MB2515:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB251581E39ECC75E8BFB5FD33836F0@BL0PR12MB2515.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:298;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BnKO4hF/8Fo14mLOTuHfyFYjRBBmPNShjivcJlKzpB390tNEYaukwDE3F2qwXVXvIslhOtyfbm2rMs07cIP+GNCvHoXVJ4QJZqZI6XY+5HSGzfOWCtB6mNRx/+SYOpMeKgBPwMtcvtreykaBmKCv/r/UPMy5pu6JyyV4r2oRw76VXBRrDb052pHIsZ35sxbhot6sGhpr647Tqe+fQT0eHf7ibdCG2ST/O5rfDMq5E8cc/Q5iIGy/18j5ZiE54W3pdjk/db3rQpp6Mzn8RcMQF6MGpQTEQEIWJivapYoRpHBch8MXQaQYW6WUh9mtytVNZRpKBnXRRYbvH3tHk6W8CYXAHf8e/xL+TaRb5bVIdk/PGWEa6XDWzi3lSPF7IA5s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(366004)(16526019)(110136005)(31696002)(478600001)(86362001)(8676002)(4326008)(83380400001)(5660300002)(8936002)(186003)(6666004)(36756003)(52116002)(2906002)(31686004)(316002)(6636002)(6486002)(66946007)(66476007)(66556008)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dFLUDjdn/Ns7XVcssuFo2CRnZfz6F0n2/1OcVgk2dXMQbrJNFPJQ06TMMVCLbXREBR32/hUYgSZHLrah0UQzo9ogHxRHNfCmhi75781F9Q9wdHa9QfQEp6pl2OvLr+baupts+l6E7YDAwwgHmrs5L4REE8AJ2lCHZBvon3FYx4vmuIiixTpswDITKwkhO/hyXl2KBYwdIhpF6LSoT3DXOKOIg/PR7rJDzBx4VQLkyHpbtU9PtGRDNJU/ZRSrU4zTCH5ZoLyG/XSewy6g2sRhCXC2rrSV6Zj3aVZRimnLJmRDwNAZ8hCZ16Gi+cuZPyB5kiLyqD6JKvv9TtPMJFx6wVV+sKAiwUKULQdetY+iqV/OszYTIQRmm8zwW3xYnl0MMU4AFRz2K2CfmeeBqZ4za2RC3TAOm8aVnAcdtL1iUcaClsryUgOGpMCOQGg+OLtj3LZkhreI5V2247Edskme03Y4G0QBCBk0TT9TkopBfdR8TyKfUtmYi5HfSyA0ifmenMRIg6FqzcUrR6rDVkd3RT9a8uJJCWuaUDhm46n4Izf1lAUzkJcgDomiQh3wgozN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 404334cd-f06b-4961-7fc5-08d81ccc5593
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 08:05:21.0609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Tk0qewnCQ7fw7+jXYcmrwDUasRgY8tnLD9jl9XiMtv3V2vdPCXwX0ZcalU5AaaJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.06.20 um 09:36 schrieb Tiezhu Yang:
> When I update the latest kernel, I see the following "____ptrval____" boot
> messages. Use "%pK" instead of "%p" so that the cpu address can be printed
> when the kptr_restrict sysctl is set to 1.
>
> Both radeon_fence_driver_start_ring() and amdgpu_fence_driver_start_ring()
> have this similar issue, fix them.
>
> [    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
> [    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu addr 0x0000000040056038 and cpu addr 0x(____ptrval____)

We can probably just completely drop the CPU address here.

Christian.

>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
>   drivers/gpu/drm/radeon/radeon_fence.c     | 2 +-
>   2 files changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d878fe7..d4d1e8c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -422,9 +422,8 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   	ring->fence_drv.irq_type = irq_type;
>   	ring->fence_drv.initialized = true;
>   
> -	DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr "
> -		      "0x%016llx, cpu addr 0x%p\n", ring->name,
> -		      ring->fence_drv.gpu_addr, ring->fence_drv.cpu_addr);
> +	DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr 0x%016llx, cpu addr 0x%pK\n",
> +		      ring->name, ring->fence_drv.gpu_addr, ring->fence_drv.cpu_addr);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 43f2f93..c51b094 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -865,7 +865,7 @@ int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring)
>   	}
>   	radeon_fence_write(rdev, atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
>   	rdev->fence_drv[ring].initialized = true;
> -	dev_info(rdev->dev, "fence driver on ring %d use gpu addr 0x%016llx and cpu addr 0x%p\n",
> +	dev_info(rdev->dev, "fence driver on ring %d use gpu addr 0x%016llx and cpu addr 0x%pK\n",
>   		 ring, rdev->fence_drv[ring].gpu_addr, rdev->fence_drv[ring].cpu_addr);
>   	return 0;
>   }

