Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8D2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93BC62080C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 15:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="dJQTrYaU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728190AbgH0PTq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 11:19:46 -0400
Received: from mail-dm6nam10on2063.outbound.protection.outlook.com ([40.107.93.63]:6497
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728001AbgH0Le5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:34:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jERHr2oMoVMBFcB0t9AwWwLDlGvGHnoYNTgF4squ8bBiX1nQdDoOvDk7uX4yCe71Suy4b/fDNRIp0Qrt7yxi3P9f1f+hOpFhlYQmem6kjOjay+/F1XcMP1hDBXAQ0QFDfad6DsSBp6v5L55z6vgiOgbR/2UZhKbYEY7izCHZFeYrhzyCLKcgSCGndF6H/Q4FxEk02up3U03fVsl+ihRR42q4s3UyPouh31MenTXzmFIn0zza5Jwfp/QgtDsnr61EophU3erJzugh1FpeA2WTfwhAq1uj2k2ocULuryDhFkOwgE1eMnXymj17RWLrezqqCkMaeRiHsOoWkUw4FfQYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wWCfkOgUE+ohYTzwTmGd0xf2a4388Q1FM0IPwadNO8=;
 b=heRvxGgZbMg46pNHcjrBbmfeaQdSRukdKPhxbvwByDQYKq4kstrWG2wZ8LuO+DhwvnTZsA5H3DRH/JpdLjZq1wJ9i0EwrQYvtD2OpeOTh/aL1L5RHrMbA9rDvEPqwFCzRHEghi4nrFgqSeJxyMY/UEP48/m2tKENM7R5uLXBKvN7rLzJ+OxkoW4JxFW1fr/5MfaneHwwIsnoJN0g7B9ScYmMWRQGNTHVhJPl7GMAGleC/PVMvOwu7ABnBuLta56QG0kjU7URPLtoYR4q6FCYaHT8Ofi32lIaCf1I8wKnwshZTWYgl+FkGAgFyAkxerATneWlHw1PlgVkGBEs3Mp/Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wWCfkOgUE+ohYTzwTmGd0xf2a4388Q1FM0IPwadNO8=;
 b=dJQTrYaU7PO+TYXrb9cSB993wp+a8x3E0xJWtVfZDeXYxMV86pfcJpNevZwEXZRfj+Fw4uq/Q8xuzqduC5Psl4m0iU+syNrxsNdPpJujvb+0o1MbiABGkVWIKLP7a0sHftvSLslyzHdWp0Yo4ou2Kd/Er9slpwfDb1fmAnfxiFo=
Authentication-Results: ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2451.namprd12.prod.outlook.com (2603:10b6:207:4e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 11:18:38 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.030; Thu, 27 Aug 2020
 11:18:38 +0000
Subject: Re: [PATCH] drm/radeon: Prefer lower feedback dividers
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        alexander.deucher@amd.com
Cc:     David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        "open list:RADEON and AMDGPU DRM DRIVERS" 
        <amd-gfx@lists.freedesktop.org>, Daniel Vetter <daniel@ffwll.ch>
References: <20200825173349.24580-1-kai.heng.feng@canonical.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <36ccb6ad-d005-4c39-fc32-7ecf4e71331f@amd.com>
Date:   Thu, 27 Aug 2020 13:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200825173349.24580-1-kai.heng.feng@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0302CA0030.eurprd03.prod.outlook.com
 (2603:10a6:205:2::43) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0302CA0030.eurprd03.prod.outlook.com (2603:10a6:205:2::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 11:18:36 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ded730c3-5bbf-487e-4266-08d84a7af1f0
X-MS-TrafficTypeDiagnostic: BL0PR12MB2451:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB24514EF5EAB5D27A5E27FF2783550@BL0PR12MB2451.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0GoVZEQ76I63j7ynoI9+36PY8G/T1ChcfRILiSjV+BWWGz6pdz5wJJ4MFdoxEii6Pn4SRMu3wBPvNze5aEy/MYXuDXqyMLYhiYneZKSHIVdW87bLKInkPu9IuQPLTtcWsF7wU+lSHprq3+Mvj+y7ZTM4LNVXciRpEbqRB3GXNO+4X++qdOL6SaqUsSh/0arvdMFLVtvY8MMfc73KQcLBOxJL43noslBCuS+TA92VMQAs2VzmNyWI9J5U6nlz5qulUlcTMu+eVkp0aF3Hjc7VcNUozBjAMWM/6gDSRIYm/rNo2Uy6QWb5EEYBfsOeVt4ZM3ZElKUo1s9i3j1qsJOaujeSSGFACRHxWyt0kvow+tbEiPHv7JZ+j4myv2WQLcFT6YdNwHPwjRXy5Lu1xHBav7r+t0e7/Xwna9WyopeiVktAGLzk4dL5zxVLs15+jC+DUpOlz/woi4ylC3c4nwlxx+0DgKS1d13fqw6UdrhMdf4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(366004)(396003)(136003)(39860400002)(376002)(86362001)(4326008)(66574015)(54906003)(478600001)(31686004)(966005)(16526019)(186003)(83380400001)(5660300002)(6636002)(66946007)(316002)(66556008)(6486002)(31696002)(66476007)(8936002)(2906002)(2616005)(8676002)(36756003)(52116002)(6666004)(154273002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: ADhSXVIanPcFQck4TDEe6+mrEx9VoNAX6n38zjoRefNFgZI1wXL9Vu9Z9zLaj08ewP99r6mp1+Bv9HOhsfn98eKZBB8u8kJ9Cfcqa8Dq0cleBQkdLZrmvK1esiT5gK0pUfEPGWkleAi/h2CddJzIf7i7JCvd80C6bvTYJOCo67FxlqFXhc8f2W9ssc9tu9vCSQKmKTKBVLVpjuWVHYfrFT1EgUf7XysEcgjneawQCVxe6RGE/kbXlyA5uh3mOqJgj51QMj4jdC7Kr3huQCunAgRfP0EJecVxjpenzHP/VZAm4Tn0W+MqByoAsZShuyc+41aTVNC5TTPlNQN3ZNWMO+TlOULEW2x4PSypztmpsGEWwyWH1baSE9Md32jtIK5I4jmsZ6FjFElkKjYLn3EKiVX9vp/e9L1z2WL54ASb2IbWwjtmTCJA+9Y0I2oQf7oNzNyksROzB+A/2ZQfWn6oWJaWUzS1yoKf/6E7Vi73s2/m13z5SEXBEPbt+jvyXn97lLKLerECjFq02X3am7NU5WmgdhAXMYwXWXH5neSB5ldTtpYzNZjvtdvyxYxzg0AeXwaX8Gdcu200ux+dShuI73ly75VbxBYx9/OcmVmYTgvd2FVeQoqI8S2iJAgbP78mO3bO9VWdk/9WaPIO6qfkUBvXfOntOQmj7lIu29ojvk5uoDR1R71CZH/VM6ea56JeCF6/6JHbS/qn7gesADZzsg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ded730c3-5bbf-487e-4266-08d84a7af1f0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 11:18:38.0694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 21CiNRTvULizoEIWA3WhP3C9+9DQUpIFDaqidSiyYNyXMHUUqBihKNPdX9K9kkK0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2451
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 25.08.20 um 19:33 schrieb Kai-Heng Feng:
> Commit 2e26ccb119bd ("drm/radeon: prefer lower reference dividers")
> fixed screen flicker for HP Compaq nx9420 but breaks other laptops like
> Asus X50SL.
>
> Turns out we also need to favor lower feedback dividers.

Mhm, let's hope that this works out for all others as well :)

>
> Users confirmed this change fixes the regression and doesn't regress the
> original fix.
>
> Fixes: 2e26ccb119bd ("drm/radeon: prefer lower reference dividers")
> BugLink: https://bugs.launchpad.net/bugs/1791312
> BugLink: https://bugs.launchpad.net/bugs/1861554
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/radeon/radeon_display.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
> index e0ae911ef427..7b69d6dfe44a 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -933,7 +933,7 @@ static void avivo_get_fb_ref_div(unsigned nom, unsigned den, unsigned post_div,
>   
>   	/* get matching reference and feedback divider */
>   	*ref_div = min(max(den/post_div, 1u), ref_div_max);
> -	*fb_div = DIV_ROUND_CLOSEST(nom * *ref_div * post_div, den);
> +	*fb_div = max(nom * *ref_div * post_div / den, 1u);
>   
>   	/* limit fb divider to its maximum */
>   	if (*fb_div > fb_div_max) {

