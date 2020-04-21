Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447A1C54FCC
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:54:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A9E7206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 14:54:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fX12I1vy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgDUOyE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 10:54:04 -0400
Received: from mail-co1nam11on2051.outbound.protection.outlook.com ([40.107.220.51]:18145
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726018AbgDUOyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 10:54:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JYlmDHfO0u1PKyMSBLX7TKAmYyqrv02DAWtMktwJPl+nzhUPS2sDBqkdoJvojYZmy0NgshE9JsbReIjJSeIHQuRhkA3kPrnUFAXvOaYhH9CvrhPzDg3CBoZhQdFvKcx8mw5FTpw7zGlpvgsDFKT6QuNJnz78H7KusueSJwkvHtLfvSaLkx+yqbV0l7sTRe7YWnadIdJVNxH8FJoVoZ9xQRVcdybYa5HWq8b0K5YflSSKq0MMy4w+5LdR0JJKcpqmCXte7oMZBqyE8Yewy3kFiWT8lrZm+1rnKd7zFZh6eckGthBDojnDhQk0vkKNX9JrOIHZ+wHdmZ+UBo2T+KdWPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJaGMag7E/9msg3SpoiF8BjPkw91dGGcCCMm6BmDFhE=;
 b=TwxXVknDeNfEyZ9/IA8BxN7fVFsU1N1Uqk1mAynQyTvMv/eULmqy/CHF4kNawtT8jzesueBtXfQyryh98pzmDPIA8pYx3NC53zNq3KUT0jsT36C013RiykSVOsFBtwspnH2HMYOchvoM2lvQVrm2ThfesWudpAvbLmYqXriTCH8mn3o1yApBgipGA5oMhQZzy/GKRYib4gMP4CoohQxFj9IrzeXEJeu+hkWyYrr9gI7z5McPaiaXvE0W0+yOL1unV2INuegwhWr/oGa6ePSAV3rrk6aBlG06oFcgODY7dq/Q+uBOXALaFiR3w0QKKnAcSwyt7mcc2f7t+c8qvWmLWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wJaGMag7E/9msg3SpoiF8BjPkw91dGGcCCMm6BmDFhE=;
 b=fX12I1vy13B8BpmRnb2MBADjFdQIu965Rp+Uxjpp3ABmqqaRkf7xbVisElAPSh7FyCco7qQXqYFDJezkJe6nCKsmuRC02JgB5+e3J02TFLB782W6UpflcViOY5ImDdfS92awcuDrVaU6d6aIz3cqaSNIPVjO5rONSc1dTi7+wpw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 14:53:59 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 14:53:59 +0000
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
References: <ABgAqADYCC8xUvKN7bT8YKp1.3.1587476387645.Hmail.bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7fdc9db9-f259-e0de-646f-863e438d68ed@amd.com>
Date:   Tue, 21 Apr 2020 16:53:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <ABgAqADYCC8xUvKN7bT8YKp1.3.1587476387645.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0075.eurprd03.prod.outlook.com
 (2603:10a6:207:5::33) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR03CA0075.eurprd03.prod.outlook.com (2603:10a6:207:5::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend Transport; Tue, 21 Apr 2020 14:53:54 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8c3f561f-5b14-4f27-c145-08d7e603d29e
X-MS-TrafficTypeDiagnostic: DM6PR12MB4580:|DM6PR12MB4580:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45801D1FD1439EB5B0CB7E9783D50@DM6PR12MB4580.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(66556008)(2906002)(66476007)(5660300002)(6486002)(31696002)(66574012)(52116002)(478600001)(316002)(16526019)(2616005)(66946007)(53546011)(186003)(86362001)(6916009)(8936002)(6666004)(31686004)(36756003)(54906003)(81156014)(8676002)(4326008);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsVUDdQFZQ4K2CsZiD+jT6Zgh259ofTGgfcBsms/dODW1HULaxyAlV5th3iOh6jtBMQniHImMcEV9EstyfEDJYwGzbjUx7Na7uEWwzg15VER3E96zdgS9g3yWPsbdsfDPY60We3yJHQOtgV3Ehd3j6AOZTuCUHpZnbyOtqLqG0HYt4UuKcxuRuFh/ZDvpzS6Q2dlJQGkDVhjMuBrNjc+Hv0m6mQxfCjDGwPgG3t63bWz3Ek2yBOT5AHM7xuZStP0M3jHM7h8srkOada4/qcWBCTmicEo6WtBKEAgED767KpMVnJaBMltPXSZ1BFxIi7QlV+nQqRciLZXoF+3qiud4tNa0jKCTjROnoMxusVBpjg+Fb+mJsD1LEnAl5B1hZk93pqhO2g2PHtIprDMYwwFbeJU7FgaRMfxmDYbUUA2PPFiqrZMs8m11MV0tPi6yTrL
X-MS-Exchange-AntiSpam-MessageData: DCALR6iSkLY4YsUweP+xFQ/mJMFKSxpViFBY2BIGqbx252SLeu9gclcXX/wZ9G75vdvr+aI11y83DuAkGgKvzTiX80259cEPevAjis9+RfvD1QlFcBd7Fk+P08+qMbauOFs0GUMcSpnB4zk7x52uetRnDp05vQhVC1IIGbl9Iwp+jHOL39CAr+40qfFFJSa7/NZHLu1Xi7dw15FUrB2ddhOas/NLO2Y77QpW1VjlawewMoK+3iEf9vJ/1QR3yp2EqJOlOdlKuuUyGz+1l3D2zDAKwL8oHoJI0B+mcMGn8Ru7dugoHfWaE907AoMmfnY6BT/U4GyAWlVBhPAK8802T3Mmj/5Qe2HmncuJNWJCDlOz+wvQoQm3jifJ3Ng1M9bNwzUQMLZI3e4J1J9M5zC9miDIaSlOktf+hK6aPacZlScJ/QBYDr1CR7QJ19uE6NZ+CR0k5fa0Xnw07w1K3sDi6+kFzzhDHTXX2E8jhSkWHHTt+kHrx8S8qEAv1A0tTt0JPM92dJZV1CNs9gDOjlSyDBmtUhZnbiWT7GH4hM3vwBfNaIlW0qbKuMqTN4Ee5k5+T/aGXKKWbKpYDKomSoahjgh+krx9ExiM5ADgJkotYY53kqTf45y4i79D7+ks2dFsgb7gUi+YwhnRweJ+Jc3ksbDtPf+UjXlwWQFizgziSn/IKNhvNe61gPBN5GZGcOPhgK/vs/9yB+0rWUdcPV9S/wHC1G/G/r1f3XUn4qufHmEw7BTDyNbRs29U8T6hxacP0Ivi2L4fFQTO915DjIYtmh7ZLEAISeG3sJ9TnvfLgj1MMVOLgcy/1X6d+RWGJW7EQMBbpM6YbbrqrqHkZpfaBWfwVNkivu/2O0ZmWXNlwXA=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c3f561f-5b14-4f27-c145-08d7e603d29e
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 14:53:59.0986
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UI5QsZ2Ebpj7oxoedgsBllkx2XYVHIm/5ZrLpunFpSy6wSG/9RsNcqB1v/4aDR9M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.04.20 um 15:39 schrieb 赵军奎:
> 发件人："Christian König" <christian.koenig@amd.com>
> 发送日期：2020-04-21 21:02:27
> 收件人："赵军奎" <bernard@vivo.com>
> 抄送人：Alex Deucher <alexander.deucher@amd.com>,"David (ChunMing) Zhou" <David1.Zhou@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,Tom St Denis <tom.stdenis@amd.com>,Ori Messinger <Ori.Messinger@amd.com>,Sam Ravnborg <sam@ravnborg.org>,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org,opensource.kernel@vivo.com
> 主题：Re: [PATCH] amdgpu: fixes memleak issue when init failed>Am 21.04.20 um 14:09 schrieb 赵军奎:
>>> From: "Christian König" <christian.koenig@amd.com>
>>> Date: 2020-04-21 19:22:49
>>> To:  Bernard Zhao <bernard@vivo.com>,Alex Deucher <alexander.deucher@amd.com>,"David (ChunMing) Zhou" <David1.Zhou@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,Tom St Denis <tom.stdenis@amd.com>,Ori Messinger <Ori.Messinger@amd.com>,Sam Ravnborg <sam@ravnborg.org>,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
>>> Cc:  opensource.kernel@vivo.com
>>> Subject: Re: [PATCH] amdgpu: fixes memleak issue when init failed>Am 21.04.20 um 13:17 schrieb Bernard Zhao:
>>>>> VRAM manager and DRM MM when init failed, there is no operaction
>>>>> to free kzalloc memory & remove device file.
>>>>> This will lead to memleak & cause stability issue.
>>>> NAK, failure to create sysfs nodes are not critical.
>>>>
>>>> Christian.
>>>>
>>> OK, get it.
>>> By the way, should i modify this patch to just handle <kfree(mgr)> in error branch, or that it is also unnecessary?
>> What you can do is to drop the "return ret" if anything with the sysfs
>> nodes goes wrong and instead print the error code.
> Emmm, for this part, i am not sure, my modify first print the error, secone release not free memory,
> and last return error, make everything clear to the system.
> I think it`s the same with what you mentioned, is there something that I misunderstood?

Yes, maybe an example makes it more clear what to do here. Currently we 
print and error and return when something with the sysfs files goes wrong:

if (ret) {
     DRM_ERROR("Failed to create device file mem_info_vram_total\n");
     return ret;
}

But what we should do instead is just to print an error and continue and 
in the end return success status:

if (ret)
     DRM_ERROR("Failed to create device file mem_info_vram_total 
(%d)\n", r);

...
return 0;

Regards,
Christian.


>
>> It's really annoying that loading, unloading and loading the driver
>> again sometimes fails because we have a bug in the sysfs files cleanup.
>>
>> We certainly should fix those bugs as well, but they are just not
>> critical for correct driver functionality.
>>
>> Regards,
>> Christian.
>
>>> Regards,
>>> Bernard
>>>
>>>>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>>>>> ---
>>>>>     drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 24 ++++++++++++++++----
>>>>>     1 file changed, 19 insertions(+), 5 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> index 82a3299e53c0..4c5fb153e6b4 100644
>>>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>>>> @@ -175,30 +175,44 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
>>>>>     	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
>>>>>     	if (ret) {
>>>>>     		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
>>>>> -		return ret;
>>>>> +		goto VRAM_TOTAL_FAIL;
>>>>>     	}
>>>>>     	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
>>>>>     	if (ret) {
>>>>>     		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
>>>>> -		return ret;
>>>>> +		goto VIS_VRAM_TOTA_FAIL;
>>>>>     	}
>>>>>     	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
>>>>>     	if (ret) {
>>>>>     		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
>>>>> -		return ret;
>>>>> +		goto VRAM_USED_FAIL;
>>>>>     	}
>>>>>     	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
>>>>>     	if (ret) {
>>>>>     		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
>>>>> -		return ret;
>>>>> +		goto VIS_VRAM_USED_FAIL;
>>>>>     	}
>>>>>     	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
>>>>>     	if (ret) {
>>>>>     		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
>>>>> -		return ret;
>>>>> +		goto VRAM_VERDOR_FAIL;
>>>>>     	}
>>>>>     
>>>>>     	return 0;
>>>>> +
>>>>> +VRAM_VERDOR_FAIL:
>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
>>>>> +VIS_VRAM_USED_FAIL:
>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
>>>>> +RVAM_USED_FAIL:
>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
>>>>> +VIS_VRAM_TOTA_FAIL:
>>>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
>>>>> +VRAM_TOTAL_FAIL:
>>>>> +	kfree(mgr);
>>>>> +	man->priv = NULL;
>>>>> +
>>>>> +	return ret;
>>>>>     }
>>>>>     
>>>>>     /**
>

