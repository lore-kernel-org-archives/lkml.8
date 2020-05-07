Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E33CC54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08AEC2078C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="i8I0tydL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725964AbgEGJWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:22:22 -0400
Received: from mail-eopbgr770044.outbound.protection.outlook.com ([40.107.77.44]:13283
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725834AbgEGJWW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:22:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HRwjQP6bLUPTKrujTWdTscIyHhBQCO+Pj8xuf4r252YN53+hyo0c9Ro0pnct5jfaJR23UyOyQRO3AhciQdhDrbCua+iWmjoqHwJLdqGOfnf82BqKKrgyXaYlLswHD2QrwiJOREkzYFQITjAYcgwstswkTZ4N+eyWY4vMDrzmzTGZfCjr1aQ1XFmkFx5dr3wKSS3Jgs3HmtZIGO3NrA83OqTOhLEujKVOtkT6eshA6BIpskYel64StJh9EFgCSHXYtMiNN6oag7SdWEhSo4/0Dt1pAYNIM2k4uOgCdj0P81ebC/55i3Gjm51Wu0ufKsQGoiR0fNxt/M6XivM2rO+Vzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCCPTFIUHgWP50dB2ZBZ4ttO3vm4uOwLl7RB5aZRZ2A=;
 b=bf+eIKWCrRnhkJfdGMZektNlyiq8sEKBbNhkqSu0yxYgTsgoAGiwqo0eHKggwnxwxv3DZFiCRfPPQON+rB8w7wk6YVmfbUGLSwQs1+lbAWwdNefgF11XNpEwTvnN7DYMcF5QXoVMJ+wUzo7T3/kW55kXtv+JP6a0AsxC82xdyrRxgJUKAwhGxJRXdibUdkrypJUYJla/UsLSqgyhtDtNpnHQebOu2xLWDYn4IoFlYf0+txp37RyD63BX1t5j06oP2c1c202dWw9GXOzzJDz7bmAhwQ3w07Q87e/ijDJZS0IIIwbPbXEG6HKBAntpqNekAg1aJIJgSZIj/aDYeONhyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCCPTFIUHgWP50dB2ZBZ4ttO3vm4uOwLl7RB5aZRZ2A=;
 b=i8I0tydL7GMPTzNA7r6t25PhN9lEHRGfjaFJFkNdcKcAW73KHm0JEJCuja+qYvX5QYXkNiGhAhB1zzNi6NDKneEjcbCCvhvz0Xfx+kOZHlzkmNdaHK+rGjm9O0E/ZMz6FxP0oUsWgjOSARD94qFvjcHRnq+huAnUuAxJof/WuQI=
Authentication-Results: vivo.com; dkim=none (message not signed)
 header.d=none;vivo.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2620.namprd12.prod.outlook.com (2603:10b6:5:42::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Thu, 7 May
 2020 09:22:17 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.027; Thu, 7 May 2020
 09:22:17 +0000
Subject: Re: [PATCH v2] drm/amd/amdgpu: cleanup coding style a bit
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tom St Denis <tom.stdenis@amd.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Ori Messinger <Ori.Messinger@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200507091311.10898-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <462b6a26-2c25-f83a-887e-6d3a30072e71@amd.com>
Date:   Thu, 7 May 2020 11:22:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200507091311.10898-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0074.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::15) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0074.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27 via Frontend Transport; Thu, 7 May 2020 09:22:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a0b449f4-3ce2-4ca2-0340-08d7f26822f3
X-MS-TrafficTypeDiagnostic: DM6PR12MB2620:|DM6PR12MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2620A6D8686BC313A3DA999E83A50@DM6PR12MB2620.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-Forefront-PRVS: 03965EFC76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EfR0D+JZRYPD515G25K4vZ7IO0ierZLxk8T6OD3XBU1wHE3Ktzq5q26Cb2fYdkuBTl96yeRqyf2XtGgIxz66tTUXgMj8lCUWF/Lyg28+tgmyAZ4TkRR24xg/s1IfcZ5MyoAGov5XnEzzYY89ZSEJlLUYWaZ7iB9QU4JTqGgdfSdpxQgDYikRw00gqqhMBl8+I3yAmUUNrP5H2d6EHUhSSqWJhoQQ61zP5m0/n1rsRjutQ+oNKxRwMLBGb2MaOMjTvbkXJat9NsUqzs3IyH2lbxQWEWiK3M2cqwabII1uEc8mYb66NhKPCx52b/nhQOvsfYudVVWhnQYAI51WLA+y+dJYXyld3PAa9xuvd2YXoHPi24hJbEijGy1JmlQS6OTUDzWMh8ZiVpOaHxiqDdwakXLGeAR7yFxUKZBNwG+9VliLxdALTMJ8SZWQeAJPTD0Pp+ZNARDBPHU4jvgHos+3JcFLz97V6X2RZE1eqcKStD44Go2izfgUd997LNe0qIX5UaU6WUJMxEDaSysKgCrNCUG6JVl91IggQnLRHdZr+AwechYXlPoZmLoE+rwav7z9TKRrLYrz3LNjk6HhLzTeXSJX/dcUfpVM8SVX0A4B0WHs/3fkeLeDnD/kWyRVQ2YOD3WKOcH9lBYpQ5QvmqQL5wGAUIzgHqxoJptYuuKDNhE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(33430700001)(66476007)(45080400002)(8936002)(86362001)(6666004)(478600001)(36756003)(2616005)(66574014)(66556008)(5660300002)(83310400001)(4326008)(8676002)(83300400001)(83290400001)(83280400001)(83320400001)(6486002)(33440700001)(110136005)(16526019)(186003)(52116002)(31696002)(316002)(2906002)(31686004)(66946007)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5F8fWlYvCQKKBsymzzPJvmYzY48jyp88dJHUoSvOasclpDrY7J7pqKm14wUVD+W0CaffikJAjc1ljYAcnaOp/quWcHYbrtk/z9psQLJ6CKzQg+RVcLA5Vy/5mk6PNY/wPmOL2jflZ4zf5Fx65y3oV4M6IL3Cech9BCj57FJG2fdzf63l3su/naJUzB9mAOxbGiE8LjU3HxTp1VGiFwPDkF8XFNMC84Q83Muc9Cz6wFFX7TvtZ/F8sqvRAida+eY7mlVoRrXuByYeKd+VOYmy7ejOLlfIMF4OSogd1DIP/NezKsc8UL8m9iZW01myJGdgDT1o3V5hsRWgD+dYN74/hdql7RFEGBDmWIB9L/lG7fU7gIBAfsDYWFzfmy/KHL2Jqp1UWC+ytRAmeNtGAmHW56SaNX7V+V5Wb0D2AAccGkKrjw1uAjhWVzSz++07Zcq+Cptwrkc+yuoPA7eKIGdo85WWmJSPmxaDKuI6tao0Ry26snClOeINRh1VxNNMuFwpBDaiHlbs7nE2XhLDn2MPnVuJe50edTw8wC1/Hpw8wr21GzKMPi5xtYjwv5lIOeVmiYxa1VbKoyxVgsOHH9kMLPKG1aBcgPZkHntWNqQDzy/IPC6/6xTF5UqxZ5bfmEDPMhRPN04RycUBWWcP5c6xmv4esyK25xbNPspZmEGf8Y3bU9/APkHVbi26Lvgla8SiW1zTXkXxbv7xdT6WDg5pkWunWwlzks9zbfwXoQjPQvgYInheUeU+2g5Jx9ilNbKoVcKf7RsWIsvM01uxdD60sfeS/4Fcr5qOzk0dEuqei8FEjuuBD0jS2KOZwEK8dp+6UniggsjB3wq0RNofZNpZcoBmtIEvKECPfKfX0WA+SX8=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b449f4-3ce2-4ca2-0340-08d7f26822f3
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2020 09:22:17.4121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwKVN9id8KyVStT0CsZo7RlI5TdFiNsXAJvF2p72/n5ZBcQqmsAPXrzDRIB4SC5I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2620
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 07.05.20 um 11:13 schrieb Bernard Zhao:
> There is DEVICE_ATTR mechanism in separate attribute define.
> So this change is to use attr array, also use
> sysfs_create_files in init function & sysfs_remove_files in
> fini function.
> This maybe make the code a bit readable.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

>
> Changes since V1:
> *Use DEVICE_ATTR mechanism
>
> Link for V1:
> *https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fpatchwork%2Fpatch%2F1228076%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C073b9043be5346b3c90c08d7f266e6fb%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637244396096735223&amp;sdata=PjFsYvmw2pvVisZ6TzMqOyoSr0m3DsFN%2F0q%2B%2FfBxACg%3D&amp;reserved=0
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 43 ++++++--------------
>   1 file changed, 13 insertions(+), 30 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 82a3299e53c0..57bbc70662ff 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -148,6 +148,15 @@ static DEVICE_ATTR(mem_info_vis_vram_used, S_IRUGO,
>   static DEVICE_ATTR(mem_info_vram_vendor, S_IRUGO,
>   		   amdgpu_mem_info_vram_vendor, NULL);
>   
> +static struct attribute *amdgpu_vram_mgr_attributes[] = {
> +	&dev_attr_mem_info_vram_total.attr,
> +	&dev_attr_mem_info_vis_vram_total.attr,
> +	&dev_attr_mem_info_vram_used.attr,
> +	&dev_attr_mem_info_vis_vram_used.attr,
> +	&dev_attr_mem_info_vram_vendor.attr,
> +	NULL
> +};
> +
>   /**
>    * amdgpu_vram_mgr_init - init VRAM manager and DRM MM
>    *
> @@ -172,31 +181,9 @@ static int amdgpu_vram_mgr_init(struct ttm_mem_type_manager *man,
>   	man->priv = mgr;
>   
>   	/* Add the two VRAM-related sysfs files */
> -	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_total);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file mem_info_vram_total\n");
> -		return ret;
> -	}
> -	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file mem_info_vis_vram_total\n");
> -		return ret;
> -	}
> -	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_used);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file mem_info_vram_used\n");
> -		return ret;
> -	}
> -	ret = device_create_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file mem_info_vis_vram_used\n");
> -		return ret;
> -	}
> -	ret = device_create_file(adev->dev, &dev_attr_mem_info_vram_vendor);
> -	if (ret) {
> -		DRM_ERROR("Failed to create device file mem_info_vram_vendor\n");
> -		return ret;
> -	}
> +	ret = sysfs_create_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
> +	if (ret)
> +		DRM_ERROR("Failed to register sysfs\n");
>   
>   	return 0;
>   }
> @@ -219,11 +206,7 @@ static int amdgpu_vram_mgr_fini(struct ttm_mem_type_manager *man)
>   	spin_unlock(&mgr->lock);
>   	kfree(mgr);
>   	man->priv = NULL;
> -	device_remove_file(adev->dev, &dev_attr_mem_info_vram_total);
> -	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_total);
> -	device_remove_file(adev->dev, &dev_attr_mem_info_vram_used);
> -	device_remove_file(adev->dev, &dev_attr_mem_info_vis_vram_used);
> -	device_remove_file(adev->dev, &dev_attr_mem_info_vram_vendor);
> +	sysfs_remove_files(&adev->dev->kobj, amdgpu_vram_mgr_attributes);
>   	return 0;
>   }
>   

