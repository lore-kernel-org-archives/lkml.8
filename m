Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D11DC5518B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E73DE2074F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="oAW0gxON"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgDVH1l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:27:41 -0400
Received: from mail-bn8nam12on2055.outbound.protection.outlook.com ([40.107.237.55]:33697
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725835AbgDVH1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:27:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oTsF/Qxw3vYTQ9s/pTYAbZqanaQ/vfBFbjc2P9KV0MyW8wL8epXS5/tb0HH52Wnru1Htv3/XBYV16ptYmJbqbxoWKGO33wkVw7gSwsNX/eUi/XQ4NZWCaWyrffGvMx6B/Vq0tWyWidnM+5A5AEcKtu50B9jqVxY/QP6jgSUq40grjnNBTIxn7Bt6sOjgqBqCJoi2y4VIU51Kk02C/3AOSppQVdJmAuHgK9Vuxop4N536YGR5qP8mlKS6f53IFX9DaLD/lL9PHP7inSZxkAmcZEusr8wig+3RtvSMZ3ryW9RZmvl9oSnA1eaR74AZzecJ+V+bi0+tOkFLu63jfBZGvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Hu4fnHgrIBo9bMY+tgFFyQLMP9QTTdpstcbGSqg9E=;
 b=ME326Ekz0nadyj/Cp6wXcfZgY2sw8QXf39pcueK6lLlzSQ6eX4exv9vSvoANOM7XEIGnlVo6B1hXkiKC/Cvf4G6X4xhirt14bCrGxRywPLR/ZSuhTqHSqSScRiqz3cq6GASUqh8/3b7vzC88HK3YriurH6+rMSMslkTy+qzfFFbFf8AOli7g/KVF0F+L3s4hzYw3m1TV7UzmJRWVB55tXX0xWkcwSGeRGDqfZaRYy6FGxr3GLRpfHUs8/9J3ZoQrI3gtlBMA+DDIl9JWO1cZjyXXADQdIIVKmrM7/vHVKinKKtyat28JzppRVBfQF2Vhj/lt0JoX25CfkxBp8V1A0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T2Hu4fnHgrIBo9bMY+tgFFyQLMP9QTTdpstcbGSqg9E=;
 b=oAW0gxONI4ZZB41n2a44rFSyuU1qthItbklP7lrmnrUG2LqSaMF8LPZ3NISOeatHZultLELkNQzqPxNHzECftd96LDsq/SmBOwROms89p3cukc2fTjF3QdTWSEPbKNlcDXNjWWaQ+AoblEWPBS0HL+aySMihqk3Npyakr3zB/OY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2875.namprd12.prod.outlook.com (2603:10b6:5:15c::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Wed, 22 Apr
 2020 07:27:33 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Wed, 22 Apr 2020
 07:27:33 +0000
Subject: Re: [PATCH] amdgpu: fixes memleak issue when init failed
To:     =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Cc:     Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        Ori Messinger <Ori.Messinger@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com
References: <AKoA0wCVCNOygUrJso2wM4qv.3.1587516987209.Hmail.bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bbb231fc-228d-d22f-2922-4868ab5ddc80@amd.com>
Date:   Wed, 22 Apr 2020 09:27:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <AKoA0wCVCNOygUrJso2wM4qv.3.1587516987209.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM5PR0502CA0019.eurprd05.prod.outlook.com
 (2603:10a6:203:91::29) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM5PR0502CA0019.eurprd05.prod.outlook.com (2603:10a6:203:91::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Wed, 22 Apr 2020 07:27:30 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a453fcdf-1b50-410f-d6fc-08d7e68e9f5d
X-MS-TrafficTypeDiagnostic: DM6PR12MB2875:|DM6PR12MB2875:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB287541E9DB3B274C4282812583D20@DM6PR12MB2875.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 03818C953D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39850400004)(376002)(396003)(346002)(366004)(136003)(31696002)(36756003)(478600001)(54906003)(52116002)(31686004)(316002)(6666004)(6486002)(2616005)(2906002)(66574012)(186003)(66476007)(16526019)(6916009)(66946007)(86362001)(53546011)(8936002)(5660300002)(66556008)(81156014)(8676002)(4326008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cx2eg8ALbM09ACzzSBk/9TP2BqgdEORdig8gvTUT+G8wjYUjKGBNQXSQjvhD+UC6FUdWYk2GdxaVIp/e2YGojjjf3iPNyw0/u78fWzvt/eeAo/II9iDWiWb7HnLYMZ3rAU/XRyfM2ljAu56gMRcD94zt2vynwTFylNG0KXckr6mI4gneaAmY8ApgwJ9UXfYWQplxhouewGBQIL+l05jw6fA7ucb95yJnIWY9z9tBv7/tysPr+92b1WcU9Txadho/PFvuqPXwXhYrjJgP+fV8+JSzS8lyCueDeyvgH7930jDj4PPr2HVXObXUHcpg1UMnbC4OMRjo6eV1X6J263S65BObN8qXmSCiBvcXQlPWq6ZxW2umx02Mrfo5RCVDNTyoerDvRrjwvciUDorjj+1HqJi2OrHTm+HNdE09JbRQw2bSjdcViRLc5X6t4G3wC+cw
X-MS-Exchange-AntiSpam-MessageData: fZCtxmbFq0cTtYE+Lg1k7I7U2wCy+BHbCn5jHW0P0654sYATf8cc+hg3Omc4ZYer2+45/h+pXEsTJw0s/C1EKH+NNQJBbmrK91QtWqqwJPwsFo0a7LhloKMQyO3TlsugFqxS8MIPct/Bsz3oWjvyVlaXFpk98i0efsIatyng5THWL0Ra4yNeWJYxeHzPkvukSAq5yn2uFfaSJ5omGDs9RNp7VebJxnwZ1VmK6JBNojq88sqvZZ+1KTrimaUdbkCMRmSj025W9pAcwzLFdsYDjP/sibSixDE8h2Q18zgh49WP1dUXwF7xTHnQcmJ8OrxYOKrvVPRPIzHg4CGmD66XH3inH4qHZZEBZMHDIbALJd13Cutm1HLVDuYPKF8/XbHIvj7nLOCAIDY6Yv1pscpZmIJVFG7k+WTOghXFPxXFpgZaYg+CvTBk35oqG6Zw8SQdE1+ZQE8ec6gjrN68Qaw84OTA/6efVffN/bzU4wfe9J8dNss9S7i6ij9CwV1nQS+YbhkENb7gOf/509y1PwuKV1iCxe1N3bzYijUIbukiY3fdS4uNOrAVcmyDzggxfG5moZ3hud/8Stb1b+ipmJfaBUrjZputGnVUL2il8SDDO3Ul3DAMnEOJOeK6uxIuCendjgCc5zuwm/Miw8NcHwIS63F69+lns5Hvgis51Ud1auHf0FOCQcI9bcxp6IVKwU7N5gnzCyFJIUeVj943L8HxFI/Jecd2QJGaYxckGWEdalerUElGZCYPnxQEpjsv8nluuEkBQ65YE0jT/Rs2DyURhnbHNbze/4GdXFGLWkzFdcyr/XQIUW1+3zDKbkpETlBTTmjrcrQqll3et+UkjDQoEi9mETENJZH5r9WawtE+1bg=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a453fcdf-1b50-410f-d6fc-08d7e68e9f5d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2020 07:27:33.1906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LKpbXvIzOVuxtvyYCEQKEBMn3SAjKYjj6NenpKH38RO8EaPHToRlLI8vrOlzosBm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2875
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 22.04.20 um 02:56 schrieb 赵军奎:
> 发件人："Christian König" <christian.koenig@amd.com>
> 发送日期：2020-04-21 22:53:47
> 收件人："赵军奎" <bernard@vivo.com>
> 抄送人：Alex Deucher <alexander.deucher@amd.com>,"David (ChunMing) Zhou" <David1.Zhou@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,Tom St Denis <tom.stdenis@amd.com>,Ori Messinger <Ori.Messinger@amd.com>,Sam Ravnborg <sam@ravnborg.org>,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,opensource.kernel@vivo.com
> 主题：Re: [PATCH] amdgpu: fixes memleak issue when init failed>Am 21.04.20 um 15:39 schrieb 赵军奎:
>>> 发件人："Christian König" <christian.koenig@amd.com>
>>> 发送日期：2020-04-21 21:02:27
>>> 收件人："赵军奎" <bernard@vivo.com>
>>> 抄送人：Alex Deucher <alexander.deucher@amd.com>,"David (ChunMing) Zhou" <David1.Zhou@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,Tom St Denis <tom.stdenis@amd.com>,Ori Messinger <Ori.Messinger@amd.com>,Sam Ravnborg <sam@ravnborg.org>,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,opensource.kernel@vivo.com
>>> 主题：Re: [PATCH] amdgpu: fixes memleak issue when init failed>Am 21.04.20 um 14:09 schrieb 赵军奎:
>>>>> From: "Christian König" <christian.koenig@amd.com>
>>>>> Date: 2020-04-21 19:22:49
>>>>> To:  Bernard Zhao <bernard@vivo.com>,Alex Deucher <alexander.deucher@amd.com>,"David (ChunMing) Zhou" <David1.Zhou@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,Tom St Denis <tom.stdenis@amd.com>,Ori Messinger <Ori.Messinger@amd.com>,Sam Ravnborg <sam@ravnborg.org>,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
>>>>> Cc:  opensource.kernel@vivo.com
>>>>> Subject: Re: [PATCH] amdgpu: fixes memleak issue when init failed>Am 21.04.20 um 13:17 schrieb Bernard Zhao:
>>>>>>> VRAM manager and DRM MM when init failed, there is no operaction
>>>>>>> to free kzalloc memory & remove device file.
>>>>>>> This will lead to memleak & cause stability issue.
>>>>>> NAK, failure to create sysfs nodes are not critical.
>>>>>>
>>>>>> Christian.
>>>>>>
>>>>> OK, get it.
>>>>> By the way, should i modify this patch to just handle <kfree(mgr)> in error branch, or that it is also unnecessary?
>>>> What you can do is to drop the "return ret" if anything with the sysfs
>>>> nodes goes wrong and instead print the error code.
>>> Emmm, for this part, i am not sure, my modify first print the error, secone release not free memory,
>>> and last return error, make everything clear to the system.
>>> I think it`s the same with what you mentioned, is there something that I misunderstood?
>> Yes, maybe an example makes it more clear what to do here. Currently we
>> print and error and return when something with the sysfs files goes wrong:
>>
>> if (ret) {
>>      DRM_ERROR("Failed to create device file mem_info_vram_total\n");
>>      return ret;
>> }
>>
>> But what we should do instead is just to print an error and continue and
>> in the end return success status:
>>
>> if (ret)
>>      DRM_ERROR("Failed to create device file mem_info_vram_total
>> (%d)\n", r);
>>
>> ...
>> return 0;
>>
>> Regards,
>> Christian.
>>
> Emmm,  i am still confused about two points:
> 1 Does that mean there is no failed case in this function?

Well the kzalloc can still fail.

> 2 There is no need to free the kzmalloc space(no possibility of memory leak )?

Correct, yes.

Regards,
Christian.

>
> Regards,
> Bernard
>
>>>> It's really annoying that loading, unloading and loading the driver
>>>> again sometimes fails because we have a bug in the sysfs files cleanup.
>>>>
>>>> We certainly should fix those bugs as well, but they are just not
>>>> critical for correct driver functionality.
>>>>
>>>> Regards,
>>>> Christian.
>>>>> Regards,
>>>>> Bernard
>>>>>
>>>>>>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>>>>>>> ---
>>>>>>>      drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 24 ++++++++++++++++----
>>>>>>>      1 file changed, 19 insertions(+), 5 deletions(-)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>> index 82a3299e53c0..4c5fb153e6b4 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>>>> @@ -175,30 +175,44 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
>>>>>>>      	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
>>>>>>>      	if (ret) {
>>>>>>>      		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
>>>>>>> -		return ret;
>>>>>>> +		goto VRAM_TOTAL_FAIL;
>>>>>>>      	}
>>>>>>>      	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
>>>>>>>      	if (ret) {
>>>>>>>      		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
>>>>>>> -		return ret;
>>>>>>> +		goto VIS_VRAM_TOTA_FAIL;
>>>>>>>      	}
>>>>>>>      	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
>>>>>>>      	if (ret) {
>>>>>>>      		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
>>>>>>> -		return ret;
>>>>>>> +		goto VRAM_USED_FAIL;
>>>>>>>      	}
>>>>>>>      	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
>>>>>>>      	if (ret) {
>>>>>>>      		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
>>>>>>> -		return ret;
>>>>>>> +		goto VIS_VRAM_USED_FAIL;
>>>>>>>      	}
>>>>>>>      	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
>>>>>>>      	if (ret) {
>>>>>>>      		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
>>>>>>> -		return ret;
>>>>>>> +		goto VRAM_VERDOR_FAIL;
>>>>>>>      	}
>>>>>>>      
>>>>>>>      	return 0;
>>>>>>> +
>>>>>>> +VRAM_VERDOR_FAIL:
>>>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
>>>>>>> +VIS_VRAM_USED_FAIL:
>>>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
>>>>>>> +RVAM_USED_FAIL:
>>>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
>>>>>>> +VIS_VRAM_TOTA_FAIL:
>>>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
>>>>>>> +VRAM_TOTAL_FAIL:
>>>>>>> +	kfree(mgr);
>>>>>>> +	man->priv = NULL;
>>>>>>> +
>>>>>>> +	return ret;
>>>>>>>      }
>>>>>>>      
>>>>>>>      /**
>

