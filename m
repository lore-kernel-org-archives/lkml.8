Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3516AC47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D9E120675
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:17:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="NkZP1v5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730306AbgEEORV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:17:21 -0400
Received: from mail-bn8nam11on2083.outbound.protection.outlook.com ([40.107.236.83]:6194
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729524AbgEEORI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:17:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTwMMdSXk86f9sU25Er2ZrmP+IAXOtBmRH6lV6K/C9uEYotthNLSpeixGHFQp/sBN/+Ux4vQzNr/RXkDiRwIZf26EPk5/PMBWt0c/HNLVuE0+BCmdJTHwVPjPy9XhJW2szIoKb5sJd93FEcR6xU6yRQjx0hsoMOY/FjFxN6trgf2Gc+aVfOrAidH+lPgX01q3PZU8Bi4gI8AWA6fcMC3mW+2uGZGlQ/mgz8R5neSNdnhttZlyAuPNJbHYgpWLFswT4JIfXdJ9E1jgTd26IqGggNhhM/54WBjTLAybCHCiqfNIwAscRIsWgKspUoC5Edm0Ys2HOvJ9MtO1fpfHIWssg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSX4ilqrJ63bGDLmAyA/63T2YgBZrcYZjNEIh/Oqjg8=;
 b=b1TPWpzqEzEr47DJZdyvorA6ChnxXlaKGKZq3ukAf6g5zNU5qCwMF+IbBF2lRW+3FCNHMVlt3OU09M9kdAvzAMUg++0w2TjRyT6vSby08Ck+Dy8yHVto4T/uqkLzy72ZenBK/JgY6hu3MiCXbZh7WoiH4hkNowsedkfyWEc65Ig9okjAWWjWREWdDLmbCensMci/4j+wmmSwGhdCIASTOra3tNGEnYUDf7FqCVoooJQX6moEyxjLiK4vTIgezccAN9hHY85ApXwta6KLKmL9vT5/b9rnV6lVQ7BRsCu3DHUcgPiPb73zo+N3XtSnB15616zX7hifI7Q4jJamRadE7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSX4ilqrJ63bGDLmAyA/63T2YgBZrcYZjNEIh/Oqjg8=;
 b=NkZP1v5S6GCWMrPk/71nwTcH1wugAOb0nJVrK7u8dl5rYczOP1SIOHtR2SCt86GvXhl9DfbndSxq3T/GajvOI5iypADJQVzj1Wxkx0FHmHsaEXx8Zx67fDUYBOX3Ikq17TIdl8e10XAevn1EcqOxt6ka4JKVkKv79ExztzbCEZs=
Authentication-Results: googlegroups.com; dkim=none (message not signed)
 header.d=none;googlegroups.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3596.namprd12.prod.outlook.com (2603:10b6:5:3e::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.29; Tue, 5 May
 2020 14:17:06 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.027; Tue, 5 May 2020
 14:17:06 +0000
Subject: Re: [PATCH] amdgpu: fix integer overflow on 32-bit architectures
To:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>
Cc:     Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Monk Liu <Monk.Liu@amd.com>,
        Kent Russell <kent.russell@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
References: <20200505141606.837164-1-arnd@arndb.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <e4a852b2-807b-bc73-7328-bcc399341085@amd.com>
Date:   Tue, 5 May 2020 16:16:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200505141606.837164-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0116.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::21) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0116.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.26 via Frontend Transport; Tue, 5 May 2020 14:17:02 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 26815344-3fc2-4d2e-e3db-08d7f0fefd64
X-MS-TrafficTypeDiagnostic: DM6PR12MB3596:|DM6PR12MB3596:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB3596F390893E330D97A4F0B183A70@DM6PR12MB3596.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KaQgGPXlPqwW268N5DGaLZ9UqH2nezz7ZC1jnmahY4OSqUjpJiDYV4F9xq2xE3FFdqGUmD1d16jK887A1MIKz/6OEMWOSFfn0IKqIEg0nT3qhTOUghIwqEdDnAqJjrBcpubl9pKgE2KzdjaSFJPeQM0AJt4eoYVPsVNJtwT+R/theJsGCQHJXaAUGyh6QTRrZJb87eNRmhrAlcc2ycECyMAKUWc776kykoL+DX3d7Y9oJffDMzO4HGI5lxWmA2HAcShxZ8F6crzcS2d6Rymm2B4h2yQWVERSyQdqWY/4TL+nsa6xgfddugFs2HuLr3FdY7xq/QlZ7YsnA8snPi+eBZuQ66iuAvuXrKY1AYwmKmIiMw4qIcfRKL2mz5zffX+ZzyOiQZng2kBI6yAj+ONhp2AHMMiBWVnYQrA/hNc9AXio89iw+sxE2cjj/yoeUmYcYh+GMqkmBodhhcJdcTFH6ufxuZzQhZ+4q22DPIJjAfCz+OS0ClRisE0ZVUK+d7S3PCVwi/PsLVVxHNJwc4GvXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(33430700001)(478600001)(31686004)(4326008)(6636002)(6486002)(31696002)(33440700001)(16526019)(186003)(86362001)(6666004)(36756003)(54906003)(2616005)(110136005)(66574012)(66476007)(66946007)(2906002)(52116002)(8676002)(5660300002)(66556008)(8936002)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 1vNBnmUD2Ca9zDw1mF4DDeu80iMi3ZbEwYIHARuvVgXRNBu0WT48imymAY2XK5DjQGRjfMKUBugkT75R7aVEXltQADdbvk+sVvOAvEn9+f0NEf0OvEIP+BYa8xQJFQuIO6N9aKl2UYO6RmBjUsJ/jLfINQ9/reALOPr2W7g0+L2Y0LBLJW7IRbMNOiLD/EIQMI+sR0zog3UBqSeBQOpb9xxOxyerByU9Udj4Go4/ndkBmzp8QJmdXAmAQJcY2lEW0OIUV9R+Z8olroB9JCJrIZp9pIy9xUf3TfB/0hzxYsRNJ9z9uRvs8CWEpxNf04e58cimG9t0B5SulAlwgTkAUX5v5Cv9RQ5g8xk0gi4tSItxeCDXYC86z+vFo71pIlDHHKpge5ADYAxPuBkrtrtQIZ5sFIKgRvHG2RG4A9iZg83Kz8ApcpcrkYZ3e6tFtjVb8NF/wYClyD+Cdf9wN5lMK1ybzO3kqUn2lYzTTLqee4BCoiaAfw3jPTM/Ngc0dN7OjwqJ1Mktf42ToutUz/8dgDZk1adLuqwJGO1bV/NM20x9NpzMqAzt9NigybVFtig1EY3CAXnxDF0WtuUtkT1hTHkv/2Y8anf4qv4lNP8fz/3yJRzK2f70755lCVVeXlMZ+pq1owVQKueWdYJOJjQDnwTiYaShcOrzUyKrUZVymsqFM3T16UNXyTBDlTb6qR7ju4gmUlBKiNBzS5ddq3f0mrVuhzPwWsV5eRKLahpdD2x+rTDbclFWmxXQ6FcpvOyrp2Z28oFnk8j48GpoXgI6CxZwATp2NlyqYCtxLyIeftxajHZ5vrLAK0ys6LPH1bKLP4A81W8/7XIkz3UnBXjT4AKmSf96AjGheyoaLk12GP0=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26815344-3fc2-4d2e-e3db-08d7f0fefd64
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 14:17:06.2987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IAKBi0sO6PGJCWXmaXaixuWoyWAe6aijK6n5Fp3zqDjNtPz03EK1eWmX04FXsG+M
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3596
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.05.20 um 16:15 schrieb Arnd Bergmann:
> Multiplying 1000000000 by four overruns a 'long' variable, as clang
> points out:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:4160:53: error: overflow in expression; result is -294967296 with type 'long' [-Werror,-Winteger-overflow]
>                  expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
>                                                                    ^
> Make this a 'long long' constant instead.
>
> Fixes: 3f12acc8d6d4 ("drm/amdgpu: put the audio codec into suspend state before gpu reset V3")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> I'm not sure the ktime_get_mono_fast_ns() call is necessary here
> either. Is it intentional because ktime_get_ns() doesn't work
> during a driver suspend, or just a mistake?
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6f93af972b0a..2e07e3e6b036 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4157,7 +4157,7 @@ static int amdgpu_device_suspend_display_audio(struct amdgpu_device *adev)
>   		 * the audio controller default autosuspend delay setting.
>   		 * 4S used here is guaranteed to cover that.
>   		 */
> -		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4L;
> +		expires = ktime_get_mono_fast_ns() + NSEC_PER_SEC * 4LL;
>   
>   	while (!pm_runtime_status_suspended(&(p->dev))) {
>   		if (!pm_runtime_suspend(&(p->dev)))

