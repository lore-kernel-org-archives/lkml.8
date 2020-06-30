Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 611E2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B42D2068F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 13:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="bbvCSFjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388133AbgF3NCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 09:02:07 -0400
Received: from mail-eopbgr690041.outbound.protection.outlook.com ([40.107.69.41]:21692
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387860AbgF3NCF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 09:02:05 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SPn9gVc2Kmv1qBWzFvLC+UJuZuSO1Nqrm8QZEYJaXSpGUEBMHiFHtPWfuyuQSpDPhmT/T3QHDibuThGbNQki50SqKdEM53Zr6AnBmBfVBJ8PIEGBIfjPIZZOQVbufq8Uw1B373rZULSUh0MSAlBJ6Vgv/KdB31eK2hkqSoOUuHybNbIr/4m2HuKQleAwmORc6Wl0VVyKsvPun0uyHGCdz2rGFbxfrAL33jmp5qmNnyEuV+E+OALNeAPLCir1BP0zVvj/UPOmgb4X1TRXJoGFjC3pWi7+jmAXVIb3LiMD/mRhWTZf5eoicrgK7iwMEB28Solo8LqAE1qN3BV2auL9Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1CFGK1/F0n49LRCMzEpQY93gxye3tt5JWlXWdka8hA=;
 b=mm5G6UeipYUDjF6xJ2iCGRqqhe/GbNL6h9WKGluXL/35f9rjvsSLkQ3qsz39L7xl/ragluNigTUjgNyQHC7hC3kVvkTg38a+VJH/Sd19ohro7vCkqGZqgaj+ly7JJqmypntqHQGY2FsH20iPII+xZpJbnGanEMDek6qhwBH1tQ0CU2FaDmPDIwv0nAhaHnf4L/ImDD29r6NgFv7m5o/jCBSN4GvKRQaS0ePPnOMBTRXYeuQsGw14rSE7dqQFlfPCo/sEx3tp06MSqUDIG9GCMTOKqzi4p5g14oi4AAE2vn6JoU3JD/jczh+imFfQam8Wewv7jsqOFrMgplQoC0lG0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b1CFGK1/F0n49LRCMzEpQY93gxye3tt5JWlXWdka8hA=;
 b=bbvCSFjQPFWz8EfVHQeMx2iURwHn8Wd7vu2nYF+gHL6hD5EGy3fvjpe1/SWvXgqgNEzR2e31bFmvB/rd0FrX31lDnEyiYvopAEZbg48XUh00EJFIpDWCwEmckc0SOItcPBw1bhYu/BO65SEzrflo/4jP74fLoyu5i/squQyV4I4=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.20; Tue, 30 Jun
 2020 13:02:01 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3131.028; Tue, 30 Jun 2020
 13:02:01 +0000
Subject: Re: [PATCH] gpu/drm: Replace "%p" with "%pK"
To:     Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1593502561-15190-1-git-send-email-yangtiezhu@loongson.cn>
 <26fcd5ec-4e90-8b98-8fbb-605f5906ad75@amd.com>
 <286d0a26-c0bd-f151-12c7-dafb34016230@loongson.cn>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <d29e6b5d-da4d-fde3-dd85-80e69bb5e497@amd.com>
Date:   Tue, 30 Jun 2020 15:01:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <286d0a26-c0bd-f151-12c7-dafb34016230@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.20 via Frontend Transport; Tue, 30 Jun 2020 13:01:59 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8e7f5fa0-b62a-4cac-ae24-08d81cf5c710
X-MS-TrafficTypeDiagnostic: MN2PR12MB4222:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB42228AAE090D7B44D7865582836F0@MN2PR12MB4222.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-Forefront-PRVS: 0450A714CB
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 09GnjYlSGzBJ2HqNM+NjVFNaUcFKd9cLXjEJZ5LUBLDvz9lkqAk+Q1BtahD+eQ5A7JCMNee8vDbCONckEwVgM5PmjaRiiV5UzMO64N08l1Q/4bxPgSSZkCJcN0zwoHa0l51Cc17mZg+BQ9D/dVd37e6VS4M1j3/V9NYw4d6k/8iGsaFa8Kn/Is9td/NODHf9Fek39Mcfwrdk9BUZwJlVkoEURpKPfFJoGDPnuhHOJfkGy4XuI/HOjL84dUtZsH2jYbC1NBbHzy7nuTog0KXeRpqJ3f0KRTlo91S5U6fK32d9tDRFKln7Sm+sa4yxDKuuwEy4GM/nw1knVESOHuwE0Z68GzPXLS9E3y7cxN3ybuN3uDCGn45WHCSWd58pAQEp
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(376002)(39860400002)(136003)(366004)(346002)(31696002)(2906002)(66574015)(36756003)(86362001)(4326008)(53546011)(52116002)(66946007)(66556008)(66476007)(8936002)(83380400001)(5660300002)(8676002)(186003)(31686004)(478600001)(2616005)(6636002)(110136005)(6486002)(6666004)(16526019)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: glI5PGrrMGOsCHsUBK/kpkqolKBKXufIiZRbRqBMYz+ds546+Iwoe/465mlLJIEKBu+qImcZSgUgD4iTScB+cylaJUawl7RvbhGayLlkw8RRbPaPJ9isOQyFWWk6WpYONUXP3gIEphklKX5n6bBJCERAm7wKvOO5fYoTXU6WsbdiPkMr6k9OIDmvKnRzjDGcupp812uVVAdrKTNim9Ws3ibDoGR9p4AU9OIWuHLRx6wlc9vy1YRCXxWeMj9SSml9I3hOUypmCaGSs61AgNYeNNh5vADyNuXLc2K8a35+NxqZFsQC24gTEw2A8xr27XZrfn/9git59HHWRoYk7iUkZsLNZgOnYP9nz6Ve6QWp5urlQZ5nmh7ARwGf2jS79LT2ltZxgmq5Gzn6UeqRWD6iC0ieqSFvdwMBFXycgG4oJ0VhKj9fHW5LgyGohI0JKV4aMMLhHvScPZOCw1hgwDxgRrYtlI5LLj/mIPlOmk1qvbN+gDQ9hGkOLjHCzagoDqABxUvufU0D3ejbaV+kvm0NCXeBPziMKDbddjBXNP1NDBK5ag7Rjr73oY4deGm0ZjqK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e7f5fa0-b62a-4cac-ae24-08d81cf5c710
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2020 13:02:01.1685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CckNhqIpW040pcyIXkC4Ywa++5DoycdKXjeQk27gQgNbLFWk+7wbHgisGf0PkEGI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 30.06.20 um 14:14 schrieb Tiezhu Yang:
> On 06/30/2020 04:05 PM, Christian König wrote:
>> Am 30.06.20 um 09:36 schrieb Tiezhu Yang:
>>> When I update the latest kernel, I see the following 
>>> "____ptrval____" boot
>>> messages. Use "%pK" instead of "%p" so that the cpu address can be 
>>> printed
>>> when the kptr_restrict sysctl is set to 1.
>>>
>>> Both radeon_fence_driver_start_ring() and 
>>> amdgpu_fence_driver_start_ring()
>>> have this similar issue, fix them.
>>>
>>> [    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu 
>>> addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
>>> [    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu 
>>> addr 0x0000000040056038 and cpu addr 0x(____ptrval____)
>>
>> We can probably just completely drop the CPU address here.
>
> OK, maybe the CPU address is not much useful. If nobody has any 
> objections,
> I will send v2 to remove the debug info about CPU address.

The CPU address was useful in the past, but isn't any more. We now have 
a debugfs file to read the current fence values.

Please go ahead and send a patch to just remove printing them.

Thanks,
Christian.

>
> Thanks,
> Tiezhu
>
>>
>> Christian.
>>
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>> ---
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
>>>   drivers/gpu/drm/radeon/radeon_fence.c     | 2 +-
>>>   2 files changed, 3 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index d878fe7..d4d1e8c 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> @@ -422,9 +422,8 @@ int amdgpu_fence_driver_start_ring(struct 
>>> amdgpu_ring *ring,
>>>       ring->fence_drv.irq_type = irq_type;
>>>       ring->fence_drv.initialized = true;
>>>   -    DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr "
>>> -              "0x%016llx, cpu addr 0x%p\n", ring->name,
>>> -              ring->fence_drv.gpu_addr, ring->fence_drv.cpu_addr);
>>> +    DRM_DEV_DEBUG(adev->dev, "fence driver on ring %s use gpu addr 
>>> 0x%016llx, cpu addr 0x%pK\n",
>>> +              ring->name, ring->fence_drv.gpu_addr, 
>>> ring->fence_drv.cpu_addr);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/radeon/radeon_fence.c 
>>> b/drivers/gpu/drm/radeon/radeon_fence.c
>>> index 43f2f93..c51b094 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_fence.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
>>> @@ -865,7 +865,7 @@ int radeon_fence_driver_start_ring(struct 
>>> radeon_device *rdev, int ring)
>>>       }
>>>       radeon_fence_write(rdev, 
>>> atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
>>>       rdev->fence_drv[ring].initialized = true;
>>> -    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>>> 0x%016llx and cpu addr 0x%p\n",
>>> +    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>>> 0x%016llx and cpu addr 0x%pK\n",
>>>            ring, rdev->fence_drv[ring].gpu_addr, 
>>> rdev->fence_drv[ring].cpu_addr);
>>>       return 0;
>>>   }
>

