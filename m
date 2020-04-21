Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C082AC54FC9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 982902076A
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 13:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="VL3t/Npj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgDUNDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 09:03:34 -0400
Received: from mail-mw2nam10on2053.outbound.protection.outlook.com ([40.107.94.53]:16289
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726780AbgDUNDd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 09:03:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e4F6X40vhgg9D0xivejDf8h841gM6TCd5bfJDuD52HZbG3rKw7Qm3MaaJOEX/2VUIq1kPYGmiMmkUxnDGMI89tLj8y0hyrkumA2DXRndChhMVMtF3AJ9g+vPt2T73VYGZIy1S58h8Og4LR8ZCx3rb62AvZXsfv9P6TUE+G6Vhzx3fuMM2fvfmixbhMOGqKtdT3LgFh/IvwFAO0Nc9wBzLhKm8Nf1F/yFFqnzSgI4vzPG5DtFZdwd00KruR293xXw6xBC6QVe+FEUhckryM6+so62iCJWILqx1uVtdyu4Xa3tvmkiUNVQGBnGbUuXWRwm8rpnA5dIva0M1grfpFPRHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDUEgxeWOZ78A9hE1wo///i8Z9K2dkaaghMy/aorsU8=;
 b=TFH48YMEk70oC7g1B9K4L/LYMWrp/6qmvbuoqx56nS/hTaeTOCeIVl+6VTquYT8C16PJOdnZvqTElNxREXCneOtkF3SyKf8A2U4Ll7aPg/MpN8/7QII9vEvNpcnSWZOjCR4WyJH2VLon7Yna2XmIRdhsuSGjVbT14dCgnXYFSZg0EWpvuDjsd5YsFXXmzcy0QjXF8/kClwF0MTQJgCg80he+t5BZ+hAIlMrRYIR9STM6Fd22r3Rv9QCfomsuRVF0+L7AYOMUW60qaS5zwQ92xjvn4zvC7Naft2IHgM2GbxaeabQMbqGlODu5u7e0BN9MGVhV1bhHVo4d/0gUDHRp7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YDUEgxeWOZ78A9hE1wo///i8Z9K2dkaaghMy/aorsU8=;
 b=VL3t/Npj62wnUJCkvdV4lgy5Jp1v2BOF/pvFr/Omh4f+WMsPH7ikrjN1iyLv4+8TK1y0FKF4eRh8Tzk8wktaJWKVDgB0ncF+UrZ4seYQDlrkfVbbAGCVFIwunoZV2FlMQ9Z08R1/hLx8W+zARAtKZN9d1E5c1Rmk1E3CVIYP+MU=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2892.namprd12.prod.outlook.com (2603:10b6:5:182::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 13:03:29 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 13:03:29 +0000
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
References: <AIEABQDACBGx7eaGVybumqrT.3.1587470983521.Hmail.bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5c1510e2-9007-50b8-9be9-b8a00f943c9b@amd.com>
Date:   Tue, 21 Apr 2020 15:02:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <AIEABQDACBGx7eaGVybumqrT.3.1587470983521.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0P190CA0018.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::28) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0P190CA0018.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.26 via Frontend Transport; Tue, 21 Apr 2020 13:03:27 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: dd3f655c-9fba-4a0e-99a9-08d7e5f46305
X-MS-TrafficTypeDiagnostic: DM6PR12MB2892:|DM6PR12MB2892:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2892044145B348086456514483D50@DM6PR12MB2892.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(346002)(136003)(376002)(366004)(39860400002)(396003)(81156014)(6916009)(53546011)(2906002)(86362001)(6486002)(478600001)(52116002)(4326008)(316002)(8936002)(8676002)(31686004)(36756003)(66946007)(186003)(66574012)(31696002)(2616005)(5660300002)(66476007)(66556008)(16526019)(54906003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8y1aS+CHxjBo6SUmRJbTiGK8XNtY/HpVRaZCVIaBWKANR/XRsJQcXSOPnmfwVuu6SoE06qrJMNxRjekRsMAzyq/g6ydIVm+HUr0GuJgWBeLdunZYmAXqZAr6o3CSNOAWZMXkKQld7tdf92WUHN4CMIYM14+4UxnBZgW/GmbM7PlLP75DeFjTT1xDZmwzaHNut+CTlkTUsny/CJKJvMVflNyMf2U4SYOhmo6UebyBzxBp6Nc+WHuiOjfk9xB7E5qXxrqdtxSl8rN5wQbkweNXuJNXTaHjFpqJ0MjkaW4aSvlNEAvDLPTt/GRu4d8PvDXP2TRGLBDr+cIq9ZouP/+dN520I6f/MDi2/J9nhpEc9CsF1Nb6kWGLTBWy4rATgzG/FfdjveF+NZ2rjUPPnpB51IBh4LUwPDBMNQ11UJEnvhYG1gAgYLmbWtHKNLbdx3OQ
X-MS-Exchange-AntiSpam-MessageData: p5951OFVyXqmNn9OBxXg5y2/JccIUBDxn0O3IPTfE+DjsGy614GSUIJ/fmnvqIiN0jaC3MI+p0EMv2BKEAzCcpa2CgNy0t7D/ZbSVoNiA1b2t6ganHCa4kvoYNJNbEo+thZEOog9+KmLVybe+Gz3FYP6TQs3bdKRs8ZZeyey4fe1n9o7ZCUqolfZ8kf/zVkFss1KbQif1KvtwgmJYT0HX85L6PU5YTKkKSgAi561B3JH5nfc+RajagfvV7F9V0SeU4cFHaE+Jw68FMwomZp3bsWEmt3W7yR2lN22FQQsXZe2vkDhA7cLpomaLgY1yFfTCebudEaq6yZRSb76yFaJSiPVtmPVjE70CByZLUbPX4Oe5ISGIJBgaTN5o6lS+LTUWNxTng1LCV3/v9XfQfbwcicHTgMMAI45zIIyXMJ3qhVjp2sCHYtNIPoEH52P1wUWmPibolhbgI2Q7u0xlMNm1GEHC4WHhgdHfb0tAcGLb63gdcuB3DfszVmSbaMpVsdF8MTgWOej0RTVqEaclhNUrnH90AshEc3RAILJ4ryBj26u+fE70/KQ0tEwQZqAq4IwNOqfYtF3ef5E3q/yDCHgP3n9n6CWAZhFMcqHxD2uxWHkbMA+zIHMtcFq0nQrcWZ6fFEEWxuBuJTfVZHF9I16wZxLahaSUkEQyvO7UNqkpwEZ1S/02c5iyQKm/wBKNwcFHK2SuJ3CvJ46A/8y8EbsVi6Ijd6no8fC/xQzYm8VqycfGMgYfYloRZJk4MvkuS8VOfMsgrLexMrblE7qOgDz5/gE1FFBnLBx230vgDckBN8mYcgQBu97Pw8Bk1YpE6bl+/szjPBfEgZZ1m9HWPVY5hAtxNP8RhzPq/80DsrXb5U=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3f655c-9fba-4a0e-99a9-08d7e5f46305
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 13:03:29.4905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jSaXiebFt/Tty9sqPbznCV9BRGfEQMPDVmqRsEQNVdYahXBgDGAZsyx7JT0qrPGS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2892
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.04.20 um 14:09 schrieb 赵军奎:
> From: "Christian König" <christian.koenig@amd.com>
> Date: 2020-04-21 19:22:49
> To:  Bernard Zhao <bernard@vivo.com>,Alex Deucher <alexander.deucher@amd.com>,"David (ChunMing) Zhou" <David1.Zhou@amd.com>,David Airlie <airlied@linux.ie>,Daniel Vetter <daniel@ffwll.ch>,Tom St Denis <tom.stdenis@amd.com>,Ori Messinger <Ori.Messinger@amd.com>,Sam Ravnborg <sam@ravnborg.org>,amd-gfx@lists.freedesktop.org,dri-devel@lists.freedesktop.org,linux-kernel@vger.kernel.org
> Cc:  opensource.kernel@vivo.com
> Subject: Re: [PATCH] amdgpu: fixes memleak issue when init failed>Am 21.04.20 um 13:17 schrieb Bernard Zhao:
>>> VRAM manager and DRM MM when init failed, there is no operaction
>>> to free kzalloc memory & remove device file.
>>> This will lead to memleak & cause stability issue.
>> NAK, failure to create sysfs nodes are not critical.
>>
>> Christian.
>>
> OK, get it.
> By the way, should i modify this patch to just handle <kfree(mgr)> in error branch, or that it is also unnecessary?

What you can do is to drop the "return ret" if anything with the sysfs 
nodes goes wrong and instead print the error code.

It's really annoying that loading, unloading and loading the driver 
again sometimes fails because we have a bug in the sysfs files cleanup.

We certainly should fix those bugs as well, but they are just not 
critical for correct driver functionality.

Regards,
Christian.

>
> Regards,
> Bernard
>
>>> Signed-off-by: Bernard Zhao <bernard@vivo.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 24 ++++++++++++++++----
>>>    1 file changed, 19 insertions(+), 5 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> index 82a3299e53c0..4c5fb153e6b4 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
>>> @@ -175,30 +175,44 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
>>>    	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
>>>    	if (ret) {
>>>    		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
>>> -		return ret;
>>> +		goto VRAM_TOTAL_FAIL;
>>>    	}
>>>    	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
>>>    	if (ret) {
>>>    		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
>>> -		return ret;
>>> +		goto VIS_VRAM_TOTA_FAIL;
>>>    	}
>>>    	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
>>>    	if (ret) {
>>>    		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
>>> -		return ret;
>>> +		goto VRAM_USED_FAIL;
>>>    	}
>>>    	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
>>>    	if (ret) {
>>>    		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
>>> -		return ret;
>>> +		goto VIS_VRAM_USED_FAIL;
>>>    	}
>>>    	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
>>>    	if (ret) {
>>>    		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
>>> -		return ret;
>>> +		goto VRAM_VERDOR_FAIL;
>>>    	}
>>>    
>>>    	return 0;
>>> +
>>> +VRAM_VERDOR_FAIL:
>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
>>> +VIS_VRAM_USED_FAIL:
>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
>>> +RVAM_USED_FAIL:
>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
>>> +VIS_VRAM_TOTA_FAIL:
>>> +	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
>>> +VRAM_TOTAL_FAIL:
>>> +	kfree(mgr);
>>> +	man->priv = NULL;
>>> +
>>> +	return ret;
>>>    }
>>>    
>>>    /**
>

