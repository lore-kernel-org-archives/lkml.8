Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87661C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B97A206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 09:48:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="MdgVrLsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgDUJso (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 05:48:44 -0400
Received: from mail-dm6nam12on2068.outbound.protection.outlook.com ([40.107.243.68]:6203
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726691AbgDUJsn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 05:48:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XYncF7qEkMpsq9Uk5ZRmVJ4X2B4kY1Lps2AJM+JX5xxmIfp266zQkgPZILZjvpKAfJtLHyHamtj+bIGhsIUBE+0yriR38okaFZM7B7UvGrKgqazIV3XOiFcxGbjoZv/E63mZG6tfzAuZ7qlDQc7Nfk9fzk1Ft/VyVtThLq9C+CY8oGt2jK8PBaYNJ98+H6Xl9UJX0L0YvrWsovYhrDyadmQMNgtahnhOo7mddf6zJtfSps/o8XLv3QDmtPpqKmcVLTFublYWguDry6L1x+N75DsUEnthD3M7699CBtnoO6Lq4nnNBKAI/YS6GiyI7W4PSF4TA62N3qEEhU4RwFnyXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtS95uol8q4ubWpRU4UduZfVz4ZbS63erd7K8JjFavU=;
 b=d6EQ/LFphOTlb6bu6U0/+TMmZedWXJ5tmFZ8SmZw/QhFBscH+V1TwrUgSxH+6l7njTb60xj+ZGVSXAVqj8aNbyZyYFO6nClac/YltiRoLsp+NerJX8NU94DivzzZefJ17LsWkNPGfBv8dAfpMgK5McYMstXv1JMQszi+kQ86+orJdLTof9neiFtybC1kEuWGDEx6DnDttaFpvDlAfDVNn/bcxgsbF9KKSw9uVcxcMnGj/DoFHu5ptAsgQfbBVWJeOphmbQT4EUyxXaUYiwk3k21N29oLMaky+aTLiAqrSyOIZn3TwGyU1XWP4q8Gt7P0QX+KZ2jMtDgjV3revPDCmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtS95uol8q4ubWpRU4UduZfVz4ZbS63erd7K8JjFavU=;
 b=MdgVrLsXP2l03CId++rErdcN6xgIaXeNLQ/YRQW5p79CwglFuuTgR5wuDqZIfojhBnBdX6rNnb6pIb43iloi2i3uwSFEqs6cwnSL0ZMPN5fOm78a9H+j8Zfw39unaQiHES90QPMDl9l62H8NAPSKtUUkZ24RHgyUt3BGeCWfl+w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3546.namprd12.prod.outlook.com (2603:10b6:5:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Tue, 21 Apr
 2020 09:48:40 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 09:48:39 +0000
Subject: Re: [PATCH V3] amdgpu: remove unnecessary condition check
To:     =?UTF-8?B?6LW15Yab5aWO?= <bernard@vivo.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        opensource.kernel@vivo.com, Elfring <Markus.Elfring@web.de>
References: <AIsA-wCZCFCxiq0WKb3WjKr*.3.1587458683834.Hmail.bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ccd14dee-f275-5de4-b5c1-4f359d155288@amd.com>
Date:   Tue, 21 Apr 2020 11:48:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <AIsA-wCZCFCxiq0WKb3WjKr*.3.1587458683834.Hmail.bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM3PR03CA0072.eurprd03.prod.outlook.com
 (2603:10a6:207:5::30) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM3PR03CA0072.eurprd03.prod.outlook.com (2603:10a6:207:5::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend Transport; Tue, 21 Apr 2020 09:48:35 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2ec64341-fd56-4dd6-4aa3-08d7e5d92b7f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3546:|DM6PR12MB3546:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB354600A9D1C2FAA75D6D94C383D50@DM6PR12MB3546.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(6666004)(31696002)(5660300002)(4326008)(31686004)(16526019)(66946007)(6486002)(2616005)(186003)(8936002)(66556008)(2906002)(66476007)(52116002)(81156014)(8676002)(36756003)(478600001)(54906003)(316002)(6916009)(86362001)(45080400002)(966005);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IT0YgfjQ56TRQY8166MCMEMF5y/CNBYVbUGE1sd4c7PoR9IpgUTKaPSv9G1+8VPwWNr88XY4uhk8OTRsMpVeg6qtfGhMpNerD1O+VpdIv8J2tepaMfsbmqLsK/64B4lUy6gyK2CdTdod2jCq+V45Pb81+B3VyeBTnQ3xKQocLDyzIwjzX0VRMSbsdIVOFqOnqI2vjo+V8YDxrQ3G+lPIxr5ejhqjadio2r0pZ9R5z1wkqkPcrxEHjSCiYmgnXtBTyxyjUUKL02ca2vVJHAqOxsl/h1j1c7HHlh0I6UlYee+XyFobH0Knd4BlK808INwwsvRlHi2tUfFeeTd3l/OWHRuLBKUsey4KjG6M2zAUZk5YGHEZSiwAiFmi5XARUJ2X7SwyHS1IlBfPfWvayOlmxqEa3dbEiyocLpDKO3BOv7JCXsHNVo0BZrS8Gtxj7kACeD4acMguobBDVarTzlroU4FU8rhQbF3p+yHxEp8y+YWDXgv8hu+VRwvOJq4nAikJ7JRDwKrbh51bQY3kqUCdBw==
X-MS-Exchange-AntiSpam-MessageData: lthqa8eWjf+PakVzws6yCWpH4eY7T8FnaI0NeSjMIEjjR5L2rVRkOOeeQRz/s8zLHZX6zNbCOVkfYI4MI6av7uajSrNofT18NcH+mY976ARiZ97W/bTwbThIzQllDo5MboEu8kwJQ87qhFwy0KA2b45u5520m8YUmCF5MbarjjfbJrJJ5roliftrV1FSSr1LgYBYLQ6WyNnxTKlz7wXV1pFfQlyaWA6uYrGQPTr19gX8+1JiuTObbf9zM3WVVusta4vtRihRAX1wYl5x0wJtsr6qy2E5aeqqK/B4JsVr9I39pdlDY3sNA1Pq/nqqHCazE6Tk3G1pc/tQRZO8iodD1l2MzwOSd/AKxjNiYNO1R/CCZyYzyASN2SS/kc5hmXv2o85xpoJHGIPFHt6PfjGVTuB4EoobX6s3geY1q6I4q0ivQk8Ey+IntLmYjTqcschiTyD83eiuJMj/2UsHVav3EQLPACzz256MBJQUVH/pyt0cigZ/0EH7MbGokj7iGxnvC+XsXbJT3skEeiMqhpHQYnb8dmerO3k1ZJzCdn7TL/XvYsQCzZ/zRtTZ/TzUix1i4Gl98/dND6cIIieN8xemxqXEw3fTvzNewnU7I6hDClAaA/Q10K/Ytzth7HRMDOYqLj2SIfraZ5MSJd8vpYGCIz5zhhRcu4kA19a35/Ns/XR9co8XpnUrVUwlnv8BzBVm/QQPk8YUPCnBJsflI7amSwT88RTK9RhVRBbSxky1zQiwPD6pnT9ZE0KwNHRLTIz+9OwiiQ6xLwe/68sL1CS5T5d+cLuKIiAjQea9KRNzAYofTEk7eIPNVrC/wJpMtZrTSntBJlnvFiWCzAFq94Laefvd/3J1PaqPuq3awu8D6CQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ec64341-fd56-4dd6-4aa3-08d7e5d92b7f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 09:48:39.8393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rnI30yKROrrE94aStMO9YO0hElcK4mozbXPXUXhKMeeNapE/KiwT1tAxdjm5VoTN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3546
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.04.20 um 10:44 schrieb 赵军奎:
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> index 9dff792c9290..5424bd921a7b 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
>>> @@ -660,13 +660,12 @@ static int reserve_bo_and_vm(struct kgd_mem *mem,
>>>    
>>>    	ret = ttm_eu_reserve_buffers(&ctx->ticket, &ctx->list,
>>>    				     false, &ctx->duplicates);
>>> -	if (!ret)
>>> -		ctx->reserved = true;
>>> -	else {
>>> -		pr_err("Failed to reserve buffers in ttm\n");
>>> +	if (ret) {
>>> +		pr_err("Failed to reserve buffers in ttm.\n");
>>>    		kfree(ctx->vm_pd);
>>>    		ctx->vm_pd = NULL;
>>> -	}
>>> +	} else
>>> +		ctx->reserved = true;
>> That is still not correct coding style. In general when one branch of an
>> if/else uses {} the other one should use it as well.
>>
>> But I agree with Felix that this change looks rather superfluous to me
>> as well.
>>
>> Regards,
>> Christian.
> About the code style, you are right, I checked the refers:
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.kernel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Ftorvalds%2Flinux.git%2Ftree%2FDocumentation%2Fprocess%2Fcoding-style.rst%3Fid%3D90280eaa88ac1a9140dc759941123530d5545bb6%23n191&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C3640a853a31e4e98f66d08d7e5d05300%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637230555230917911&amp;sdata=Ihum8tjQAw%2Bk67KTq%2B3zBBLHL1bSHBhBhSyG0jWeMcE%3D&amp;reserved=0
> The if and else should use the same style.
> But i have to say there are so many code not follow the kernel code-style in amdgpu module.
> And also the ./scripts/checkpatch.pl did not throw any warning or error.

That is unfortunately true, yes. But we try to push new code through the 
usual code review and improve things as we go.

On the other hand patches just to fix the coding style are usually seen 
as an unnecessary interruption and just a waste of time.

But in this particular case you could argue that the original code is 
not easily readable and you try to improve that.

> If this change looks rather superfluous to all of you, should i change to the V1 change?
> After all i don`t think there is any necessary to check "ret" again, merge the <else and if (ret)>
> maybe better.
> Original code:
> static int reserve_bo_and_cond_vms(struct kgd_mem *mem,.....
> 	if (!ret)
> 		ctx->reserved = true;
> 	else
> 		pr_err("Failed to reserve buffers in ttm.\n");
>
> 	if (ret) {
> 		kfree(ctx->vm_pd);
> 		ctx->vm_pd = NULL;
> 	}

In general I suggest to use the following pattern for this error 
handling and avoid the else branch altogether:

if (ret) {
     pr_err("Failed to reserve buffers in ttm.\n");
     kfree(ctx->vm_pd);
     ctx->vm_pd = NULL;
     return ret;
}

ctx->reserved = true;
return 0;

When things become more complex good practice is to insert a "goto 
error_cleanup"; instead of in place cleanup.

Regards,
Christian.

>
> BR//bernard

