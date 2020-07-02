Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 309EEC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03E782084C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 08:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Kr/wIE18"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGBIjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:39:10 -0400
Received: from mail-dm6nam12on2055.outbound.protection.outlook.com ([40.107.243.55]:15000
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726462AbgGBIjJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 04:39:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnKJYgzy/mV98SixZLf7euG/8+MrC40EmhuPVIOiJC8iB+0BhWWGNx3TaIC8+SKlHTfRHOK/xpYFFprJwxLK3zHtI+ZFo1/KjOI3Kdopyr4ZY0OhOF7qWJRLncYY5QEoHCMEgvvcVWDrjri3Mxxv7yqP+inlJ7Z2DHu1HCkMlsVcFpjE0lqmPDoAMscQN2iNZwZQWmDUL/LakEQOZAuXYyAOMhvNteiR7Pw7SdI77qlSyalkaU3dUQisjXn3hZWBDS18nRzJXdCwQUpT5n10spHXwafF4AfUEVDavqUPoLYmcS9wiHKDUdva3mVa79KVBy0RgfLhD/uBpYfuNRfFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PasxLQoyH2QT9ekzgjo7YSu56aRPm4Zxf1lQkmX8GVs=;
 b=lADq7/tbChlf1pJ4QJLOsUMRoonPDPg+tawafbGZ1tfGsq8Knyfx0y+3ie/M/UC2cvLPgQsNA8PkbiRbZw/lgJNRC9SSxrV/h6t+VGK839ENPNiqhR4iyNfRSbh/KjfY22nrjuftAk5U4nWdvs0R4FYcD9T1XIsvtrJS7G4h1keFJyz5lwh3Uvca/ojeO2Xs4s/D/mO/o0E1ZW6niUrcctEjzRPnT62YyvC7EtmL4CYqQ897BsEXbMb9oHPys+RDlHRjzTcSOVxEoLtac9srG91P63ktFLZucBb887E5RSxK1/ZIl1M29cjoNqSKHERBb06akhOsj8blu16FZKscWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PasxLQoyH2QT9ekzgjo7YSu56aRPm4Zxf1lQkmX8GVs=;
 b=Kr/wIE18fjDBe5bFUdrd6tLMf+TDIylLTfhAfamIw7oX+Zt/7V9aIiztn/MpIgljbpP0tgk9n0/D3EgySY+9giuMWc2j11BpiK7YVsgs7jscaLt7k74ika7hy5QcbZ8ItOMLcwIyl/tsSOvWVhwNtnH9ZeDWsWhgA+TxPmdrFuY=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4126.namprd12.prod.outlook.com (2603:10b6:208:199::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22; Thu, 2 Jul
 2020 08:39:07 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.021; Thu, 2 Jul 2020
 08:39:07 +0000
Subject: Re: [PATCH v2] gpu/drm: Remove debug info about CPU address
To:     Tiezhu Yang <yangtiezhu@loongson.cn>, alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <1593656863-1894-1-git-send-email-yangtiezhu@loongson.cn>
 <85c81fa9-2994-d861-0690-a79600ed84b3@amd.com>
 <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7aa4d0c5-14ba-594d-e3fb-9acba82cf45d@amd.com>
Date:   Thu, 2 Jul 2020 10:39:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <af4f9870-3161-87f7-ff4f-1c0ad7869717@loongson.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR07CA0057.eurprd07.prod.outlook.com
 (2603:10a6:207:4::15) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR07CA0057.eurprd07.prod.outlook.com (2603:10a6:207:4::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.12 via Frontend Transport; Thu, 2 Jul 2020 08:39:06 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6c658345-8eb2-434e-4a85-08d81e636206
X-MS-TrafficTypeDiagnostic: MN2PR12MB4126:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB41269BCF4CA49DC22C96F4D8836D0@MN2PR12MB4126.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:551;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kP/c3i6EMQJWY2ovu8Uoxvw/15wlJ2JMILyV8d8NNPzDEoTdGOf3mBn7+iJCmUGwitiyKyFfuWGyWA6FJoiSvia0ftPud1dTm8co+4lEP441XLYn0+BOiF24bSuq24x4X6Ez7TAkJI3LQyUWpN6GsbvqdrNGxnsPqRsstLtQieyQNgQXtYFBeLgjb7ZeAv1+6XUsbqomuN9NYR5o0JQuOnNRqEs1BxZ759V3GIyn1iXmpcXln9U806T/NL25PfMdyD1cRdEC0SqH7PG2iRz1H3E4pID78r6z1y+EZC0yV/TGlefrXy+1OWiWPVPqWoxv4JxqcITBKhTKIBL9Cl/X3T700eTirDitcQaQrYcG5m0UdCaQQDHzcS6shs/XMth0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(31686004)(36756003)(66574015)(2616005)(316002)(6666004)(4326008)(8936002)(83380400001)(52116002)(8676002)(53546011)(6486002)(6636002)(2906002)(31696002)(16526019)(186003)(478600001)(66946007)(66556008)(66476007)(86362001)(5660300002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: xzROn6ZyzO1fthFk2i+be9Ss7TEYa/sTaPztLEWhZGtHAUSWt1bfRtXM2rKIwESt8DWfZgjSOLBJnKbAUeoM09ecwkzdtA8wXi0On72q9a4OUY1JcLFkiIOpTloszy4YjoWjmajMGkBOB1x4LPOn6aKPyqD01rslJRz60gPFqe23AkcKpbcQ0fF8T9XuxUutho246uFP1ZnROJ04iVBDqvYWpDrFzlba9X0qcuQZycbhC5OekZiLKz5cqJ3u+wVVN0xVBy/Xc6pWQWCZHB3RfXXG8ZXynKgozGjzGku7XRO6D289iAVgA0/Um6fA37VH0XXhb6uN+TEh7HnbUELTnn3R8pefUkNcaj0C6aTPfRTTG5Q55YfKkstG6J/UiFCIRPZv8E8D70GYGHm9j/hf7l6x4LIvbr+G5JtD+0H8eBv2MkNIxiaWC8sStJts1+z4YU3ElorbwI0GeL6Murumaf0SMiEWPBCmrV6SCFUxc8zwm3Z72cfspbG8vnaYHQRaXsoCnTkvq3zcVv+g4jKc5F9YXOhF9WtxlgNRAI4E8VykxMc7kjwylgui68G0X6Bt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c658345-8eb2-434e-4a85-08d81e636206
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 08:39:06.9679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pE2EzDgpg/9bWT596zdQVOGPRZvjB8RR4sXbJmG6vjHFM23q9qca4e43JOC7zKfe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4126
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.07.20 um 10:35 schrieb Tiezhu Yang:
> On 07/02/2020 04:27 PM, Christian König wrote:
>> Am 02.07.20 um 04:27 schrieb Tiezhu Yang:
>>> When I update the latest kernel, I see the following 
>>> "____ptrval____" boot
>>> messages.
>>>
>>> [    1.872600] radeon 0000:01:05.0: fence driver on ring 0 use gpu 
>>> addr 0x0000000048000c00 and cpu addr 0x(____ptrval____)
>>> [    1.879095] radeon 0000:01:05.0: fence driver on ring 5 use gpu 
>>> addr 0x0000000040056038 and cpu addr 0x(____ptrval____)
>>>
>>> Both radeon_fence_driver_start_ring() and 
>>> amdgpu_fence_driver_start_ring()
>>> have the similar issue, there exists the following two methods to 
>>> solve it:
>>> (1) Use "%pK" instead of "%p" so that the CPU address can be printed 
>>> when
>>> the kptr_restrict sysctl is set to 1.
>>> (2) Just completely drop the CPU address suggested by Christian, 
>>> because
>>> the CPU address was useful in the past, but isn't any more. We now 
>>> have a
>>> debugfs file to read the current fence values.
>>>
>>> Since the CPU address is not much useful, just remove the debug info 
>>> about
>>> CPU address.
>>>
>>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>>
>> Splitting it into one patch for radeon and one for amdgpu might be 
>> nice to have.
>
> Should I split this patch into two patches and then send v3?
> If yes, I will do it soon.

For me it's ok to merge it like it is now.

Only Alex could insists to split the patches, but then he will probably 
do it himself.

Thanks for the help,
Christian.

>
>>
>> But either way Reviewed-by: Christian König 
>> <christian.koenig@amd.com> for the patch.
>>
>> Thanks,
>> Christian.
>>
>>> ---
>>>
>>> v2:
>>>    - Just remove the debug info about CPU address suggested by 
>>> Christian
>>>    - Modify the patch subject and update the commit message
>>>
>>>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 5 ++---
>>>   drivers/gpu/drm/radeon/radeon_fence.c     | 4 ++--
>>>   2 files changed, 4 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c 
>>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
>>> index d878fe7..a29f2f9 100644
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
>>> 0x%016llx\n",
>>> +              ring->name, ring->fence_drv.gpu_addr);
>>>       return 0;
>>>   }
>>>   diff --git a/drivers/gpu/drm/radeon/radeon_fence.c 
>>> b/drivers/gpu/drm/radeon/radeon_fence.c
>>> index 43f2f93..8735bf2 100644
>>> --- a/drivers/gpu/drm/radeon/radeon_fence.c
>>> +++ b/drivers/gpu/drm/radeon/radeon_fence.c
>>> @@ -865,8 +865,8 @@ int radeon_fence_driver_start_ring(struct 
>>> radeon_device *rdev, int ring)
>>>       }
>>>       radeon_fence_write(rdev, 
>>> atomic64_read(&rdev->fence_drv[ring].last_seq), ring);
>>>       rdev->fence_drv[ring].initialized = true;
>>> -    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>>> 0x%016llx and cpu addr 0x%p\n",
>>> -         ring, rdev->fence_drv[ring].gpu_addr, 
>>> rdev->fence_drv[ring].cpu_addr);
>>> +    dev_info(rdev->dev, "fence driver on ring %d use gpu addr 
>>> 0x%016llx\n",
>>> +         ring, rdev->fence_drv[ring].gpu_addr);
>>>       return 0;
>>>   }
>

