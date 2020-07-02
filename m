Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1ECAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA34E206E2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OZgTYbKu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgGBOmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:42:50 -0400
Received: from mail-co1nam11on2086.outbound.protection.outlook.com ([40.107.220.86]:42080
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728179AbgGBOmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:42:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=myPl7zHwUKoiP0jr84JF/X2VIvPjAxanhLWr3UaUG8feiwPxRsNB2DZoNbzGIfhJwDGhMOOD/ICWHp+A+jTIisCSaoYlmXWOSrfk8i/7nVe76zjPfvaqtK4NEcGIAh0IdPBd7ga2xMWuJVRyK2SgMjUTiybuxTeGbaBfuP1TqTiCKn63KWKXmWlOui80CTcu+gwxlZrBApaxN/SWb4b+khGMHjyVVyU7hmQQLy4Fca6W26yeYDCFoMOqtT8u6pHfDNa7pVA3LVZYHShuKJERznHbT/S/hnszirTwVTlHaayrkEk+2N7XRTRcX2C75NFvkYRqeQh57Qpqd/L9O5p/gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A31+P0kpH/RIG4uYaz8DliMzp4g5Ncqx7wadAnp/U=;
 b=l8Vcbdu9Xob4GHamKu32HI/Fyo0MMgWSsH/3N6T0b0dJ7AxoLd+NluJNA8WR7BLNyNxU3UW6YwlAK7y7PBFQ4BPXjELjuSGdWYtIJaB6difiB9jUaT9uLOw4HPZT2HluoR+Um3BVTdu0KT3y9gv9Ep8NISo4gkuNYkZ9JURo5Ikh+WrbQmAAMCpbkT8oytsP06B56zKBGByLQvWNt+a45JajzR8uqCjThn+utBnbwhdP+MRSqnqw1bwWhh02IUgdkp82gOlL2WyhgU1sMii3larnpt9PI13eQabrtFfHNiuCH1jY0tXdsELotTTHA48nxNNa1+K4aXYd+usCzPGYHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A2A31+P0kpH/RIG4uYaz8DliMzp4g5Ncqx7wadAnp/U=;
 b=OZgTYbKu/ZADJf5xABMVnAfb5jt8MOGkpTF2ZGKOSbkdDWuWWWj+C5jQmjUWH5goktj1WcQ5VZnn+GM+7EEU88L6A8asAQV4l70lYvTFAPSXuFyCW4MazMUcqdsTmU8x9c71sZpBhMjGaoGvQjgV4bs31mk5BNaD54YuQhnK85E=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3131.21; Thu, 2 Jul
 2020 14:42:45 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3153.021; Thu, 2 Jul 2020
 14:42:45 +0000
Subject: Re: [PATCH 1/2] moduleparams: Add hex type parameter
To:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
References: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7c31d918-c967-5ebb-970e-7f6e913237e8@amd.com>
Date:   Thu, 2 Jul 2020 16:42:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200702140102.26129-1-pmenzel@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:200:89::20) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0202CA0010.eurprd02.prod.outlook.com (2603:10a6:200:89::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.22 via Frontend Transport; Thu, 2 Jul 2020 14:42:43 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7dc3fe78-084a-4a0e-eba9-08d81e962ec6
X-MS-TrafficTypeDiagnostic: MN2PR12MB4518:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB451879E32AA64435A9E88F26836D0@MN2PR12MB4518.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yyMTpAPYa8bvk4ecoO/UpsmhPhC+nfuO+ju0SMjlkD8hI7apji/QgOSYLOXSP4RQawh3F32X0IlwZA+d2BpglLLwm9nW+63Nt5J4peE6d5WyfrR3+kaRvAwfGPpnasdvVibM/pxkcYSm5MXqmfNwnLvF4CTHKe7yigf5KZDISgJ6qDteoLhQ5T4Uj9CsrwHggmjCTWaD1WwpPdIVfwx9rLTQ+ZMsnncyVEBEHWuyyMQKSV79zo58wXU+WH5mU1e09W5MWZUZtACy5DGsNSv+1DT8I2uIcGLkLi9yLu5+SHeW6scsHff5EOKSRexcVZIMkTwto+YDx5OBCkpGOVC7YbncBM91iBIkeoSfVq1uPlriUmbjMUnevc7UaTOxo4Iv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(66476007)(36756003)(498600001)(2616005)(86362001)(16526019)(31696002)(5660300002)(110136005)(66946007)(2906002)(83380400001)(8676002)(8936002)(186003)(31686004)(66556008)(6666004)(6636002)(52116002)(6486002)(4326008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ZjWWeFP3LMm4ZraaqiN6g6EKxXTRU7Zn+mDBndEZmlvMBbX9arO7A4ZfQyWuBs1++7UT2jxFzedUxUZ2s5MxN8Y2TPaSQQyYIylHan84lvzucQeDAIMiT1T3QDYCG5cqlGKdKIX9tspy4adT1WMSI8+4v852Peb3PwV2EEYY/EZbqm9DEX8HYwIHM4yExq4s3ITNXUcXEEm+k1qdrAcRic73hJuD1Mj2mGvlqr65b0v0wb6FtonChq50hjE+yGLDQzMDRE37M25gJ5WNaS67GL/8tkMYga4kcHiqNm9TSLZMyyOj+aiaoyMXOk+m2cCkWfbAezTQZQL+AjTfbeo1OnrU3HIhzwMULaldxdyQGTYia+hMzjC/V0LmV1cx3PENDeaUfC7yqK2TiUQ32uOROuzOXOCpxybTvz83v8PRUfawZY2DJanZb4+SSnyIon89X22ZeD0BE3Y65yk0JvFK1ZCqNx9TZwPZo7YhZ2l64f2B1LhRPHNNxg7QNG3zPdB3ecYMgw1RvTigjo3jpVK2gK1NyyHp2prTPJf4wkOznu3D3gfW0ydvG9JUuHArSWa0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc3fe78-084a-4a0e-eba9-08d81e962ec6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 14:42:45.5459
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw1xgdk3eGDYiyw087ShViCSxfAy31tuvzQVvzv5KdD0pePsxZxPdxDE7gze8qK2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4518
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 02.07.20 um 16:01 schrieb Paul Menzel:
> For bitmasks printing values in hex is more convenient.
>
> Prefix with 0x (#) to make it clear, that it’s a hex value.
>
> Using the helper for `amdgpu.ppfeaturemask`, it will look like below.
>
> Before:
>
>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>      4294950911
>
> After:
>
>      $ more /sys/module/amdgpu/parameters/ppfeaturemask
>      0xffffbfff
>
> Cc: linux-kernel@vger.kernel.org
> Cc: amd-gfx@lists.freedesktop.org
> Signed-off-by: Paul Menzel <pmenzel@molgen.mpg.de>

Good idea.

I'm just not sure how well this is received upstream because it only 
covers u32

On the other hand that is probably also the most used.

Christian.

> ---
>   include/linux/moduleparam.h | 7 ++++++-
>   kernel/params.c             | 1 +
>   2 files changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/moduleparam.h b/include/linux/moduleparam.h
> index 3ef917ff0964..408978fcfe27 100644
> --- a/include/linux/moduleparam.h
> +++ b/include/linux/moduleparam.h
> @@ -118,7 +118,7 @@ struct kparam_array
>    * you can create your own by defining those variables.
>    *
>    * Standard types are:
> - *	byte, short, ushort, int, uint, long, ulong
> + *	byte, hex, short, ushort, int, uint, long, ulong
>    *	charp: a character pointer
>    *	bool: a bool, values 0/1, y/n, Y/N.
>    *	invbool: the above, only sense-reversed (N = true).
> @@ -448,6 +448,11 @@ extern int param_set_ullong(const char *val, const struct kernel_param *kp);
>   extern int param_get_ullong(char *buffer, const struct kernel_param *kp);
>   #define param_check_ullong(name, p) __param_check(name, p, unsigned long long)
>   
> +extern const struct kernel_param_ops param_ops_hex;
> +extern int param_set_hex(const char *val, const struct kernel_param *kp);
> +extern int param_get_hex(char *buffer, const struct kernel_param *kp);
> +#define param_check_hex(name, p) param_check_uint(name, p)
> +
>   extern const struct kernel_param_ops param_ops_charp;
>   extern int param_set_charp(const char *val, const struct kernel_param *kp);
>   extern int param_get_charp(char *buffer, const struct kernel_param *kp);
> diff --git a/kernel/params.c b/kernel/params.c
> index 8e56f8b12d8f..ceca8394dac5 100644
> --- a/kernel/params.c
> +++ b/kernel/params.c
> @@ -241,6 +241,7 @@ STANDARD_PARAM_DEF(uint,	unsigned int,		"%u",   kstrtouint);
>   STANDARD_PARAM_DEF(long,	long,			"%li",  kstrtol);
>   STANDARD_PARAM_DEF(ulong,	unsigned long,		"%lu",  kstrtoul);
>   STANDARD_PARAM_DEF(ullong,	unsigned long long,	"%llu", kstrtoull);
> +STANDARD_PARAM_DEF(hex,		unsigned int,		"%#x",  kstrtouint);
>   
>   int param_set_charp(const char *val, const struct kernel_param *kp)
>   {

