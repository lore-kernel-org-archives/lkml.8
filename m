Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41559C433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16792206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="R1xQb0aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727869AbgGBI1q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:27:46 -0400
Received: from mail-mw2nam10on2048.outbound.protection.outlook.com ([40.107.94.48]:6587
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726826AbgGBI1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:27:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ionEQZhZERczV8fvMKkvVIMrnpfNFgtN/k97wJ4TCGP7i8hnvJD5FononLor2WXr8jgWYHHID8dITk5mfq1BmgTXYUWq/6XPUYEKlbREvSRhKm6hJlhZr2eEY3CbBkkxMTm57hKDv7XQd47fAZ25qhm3R1fzqbzwBmNby2Yk9FmS+jE8MGYK18mb0jwXuq7OdjiwbYNAyb1Y8aUwPY4DbdIoL0eAv6Gb5PJxTqFpj74fswyc9qUc3nu3TFfMWfLCUXacnyRQjpAnFgm8eVaRQRKtlT5Mr/h3LFaBdh3WG7wUjw3kI25clbZVvioswKmXvLqqNwn2NOnhq7BQEl2Jdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jic++Pjt+AbaWSXNM34Q9swXGEU/xIaLtpHNEd0dqL0=;
 b=IQVuPPrXesc24HWu4QIDm2VaymnGow8LV5bgVwBExBeTTrWoCKenWX+vykUA6+8vbSuB164WuXV1M9qMnG6SOkmqhWzO4h8rMLX3yR4kPuGZCNLpSKJJ02QI9rJWGtBfV5mrLQu6+deFotdUJ4R75b26kr/LzEzTUAg3qjmeb9soe7f42T+R8S719MbcPYzokyo1LHpYudkYzl/uFyZ9+9TKk2NUCgYDnnxR/qBsWs2/uwaWrINmdj4RPYH3enwrS60SJzSs6SvycaMiF1FV54x21yYf8/W5m84/1ogtiS8+MZVLutmNeBym5LeX5v/l54cTv/6EcwApRLHEZgOjBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jic++Pjt+AbaWSXNM34Q9swXGEU/xIaLtpHNEd0dqL0=;
 b=R1xQb0aMhPLApiq0MHIJl6u1TGTJna5Ji/lqvmENd6JObjBJLniRIuCO48rIKBDN/2aTQ410XMTWWh4WJzyD+oBf2tG3QKfGwpJM5QY1my6MjAU03+pdpkxZbDuQyaN4X+IaYZMkqqG/NH762KDHmEuYJ7r7DFcc1xV3NTpJGOQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.24; Thu, 2 Jul
 2020 08:27:42 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.021; Thu, 2 Jul 2020
 08:27:42 +0000
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
Date:   Thu, 2 Jul 2020 10:27:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0003.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR02CA0003.eurprd02.prod.outlook.com (2603:10a6:208:3e::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Thu, 2 Jul 2020 08:27:40 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92c488c9-fa4b-4491-db1e-08d81e61c953
X-MS-TrafficTypeDiagnostic: MN2PR12MB4110:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB4110B8A4B2A55AAA2AA5EFA8836D0@MN2PR12MB4110.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:390;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: blRJRg2MZr0quI3406aqxLVUJALQK8KQ4zDTmzFzZx80JEyceuV5WM3ZZKjaLHFiZ1Skzd04eMY1qXLZep1RDDoqemakQYkoh6lrcB7+pGCIEaTQtYK1W7a6jWfkV+x7SxHJdCW0BYzUh63SgcoK7TphWD0lZBBCgbG/8x4pFcIEn2e9Krx2D8J3RZFNoTngaELh8KW5NxWtnXAm/JEsduf0a982PrPMT5EQrqbnA6iy2HcbHa7Y41RCBLt46VcZx41jajWB0dLTxu84a0A1ZR9X2+0vZI9hX/GjPAeKOvABUUlgvYJmVaWJOjIPcQEWYyM0XJomHbCVDGZ0NOF8rYR2HJOfv0gGbcL216VSjjL4npFHAIp6OulG3UPsbB6f
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(376002)(39860400002)(396003)(366004)(2616005)(36756003)(86362001)(6486002)(6666004)(31696002)(4326008)(6636002)(316002)(16526019)(186003)(52116002)(31686004)(66574015)(2906002)(478600001)(5660300002)(8676002)(8936002)(66946007)(66556008)(83380400001)(66476007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: syVtL3tfWUCCzdaYLZsRLtmKJSChkMAkto+KP0epknEQvqkPAKVW8DaybxY1u1NHCbeDrJdE6vbYjmVFLs73ehMxWzJ7cH7RTfkEhhVzvqYF5d6EivKVx/vxlQsqw6dvqbZPQnMTDbV5Ye+7hrR4urdTRmDMUlG2LRG4WFurdpL6mfasza4MYhjqNtKSS2XCxWiyWa+bcRGnAKimzRJ0i40rAZ5sL4f3tnhbww0zdcGlKbpUpcwNif6NUFhIQ4xLCFwzjmX3PanU6x2KGHz0bZsI2aCiwRDsGjtU8sJQH/g2DF818UmhqU4c1zWC73g4zjYjEUyazfhFmAMMsvGwb4zRvWllQtPc+Y8zdT9VvJkEwQiev4NNdgVPI2XnhJhUhRbG1qmrkdNE2OyMYdN8nOcX48sU25lvxQAY/SW0wuQDTtxOetPot77VnfXSE0mhGqaf/c2S/F/BH0aWJUIrPHNHFeSVToP3maK46VxenizhFCNJ0x3a0NUOzLnFkg/Dh/FKJDtBXg9RTR0p/vX6RE1jxQljfbguQpMQi5Psgp9v4Awe3b2jpj+0zLjiFZgf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92c488c9-fa4b-4491-db1e-08d81e61c953
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 08:27:41.9097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JuSeSsRqmsD/koA1hC3ZRo/LTQRPYoobCYM+eJH3WjYRWA3h0s+fnUm7EdHj8MM5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.07.20 um 04:27 schrieb Tiezhu Yang:
> When I update the latest kernel, I see the following "____ptrval____" boot
> messages.
>
> [    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
> [    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu addr 0x0000000040056038 and cpu addr 0x(____ptrval____)
>
> Both radeon_fence_driver_start_ring() and amdgpu_fence_driver_start_ring()
> have the similar issue, there exists the following two methods to solve it:
> (1) Use "%pK" instead of "%p" so that the CPU address can be printed when
> the kptr_restrict sysctl is set to 1.
> (2) Just completely drop the CPU address suggested by Christian, because
> the CPU address was useful in the past, but isn't any more. We now have a
> debugfs file to read the current fence values.
>
> Since the CPU address is not much useful, just remove the debug info about
> CPU address.
>
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>

Splitting it into one patch for radeon and one for amdgpu might be nice 
to have.

But either way Reviewed-by: Christian König <christian.koenig@amd.com> 
for the patch.

Thanks,
Christian.

> ---
>
> v2:
>    - Just remove the debug info about CPU address suggested by Christian
>    - Modify the patch subject and update the commit message
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
>   drivers/gpu/drm/radeon/radeon_fence.c     | 4 ++--
>   2 files changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index d878fe7..a29f2f9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -422,9 +422,8 @@ int amdgpu_fence_driver_start_ring(struct amdgpu_ring *ring,
>   	ring->fence_drv.irq_type = irq_type;
>   	ring->fence_drv.initialized = true;
>   
> -	DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr "
> -		      "0x%016llx, cpu addr 0x%p\n", ring->name,
> -		      ring->fence_drv.gpu_addr, ring->fence_drv.cpu_addr);
> +	DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr 0x%016llx\n",
> +		      ring->name, ring->fence_drv.gpu_addr);
>   	return 0;
>   }
>   
> diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
> index 43f2f93..8735bf2 100644
> --- a/drivers/gpu/drm/radeon/radeon_fence.c
> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
> @@ -865,8 +865,8 @@ int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring)
>   	}
>   	radeon_fence_write(rdev, atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
>   	rdev->fence_drv[ring].initialized = true;
> -	dev_info(rdev->dev, "fence driver on ring %d use gpu addr 0x%016llx and cpu addr 0x%p\n",
> -		 ring, rdev->fence_drv[ring].gpu_addr, rdev->fence_drv[ring].cpu_addr);
> +	dev_info(rdev->dev, "fence driver on ring %d use gpu addr 0x%016llx\n",
> +		 ring, rdev->fence_drv[ring].gpu_addr);
>   	return 0;
>   }
>   

