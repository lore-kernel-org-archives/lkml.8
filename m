Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC90C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8C6E206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KXHXB9gF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729692AbgGHObC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:31:02 -0400
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:6249
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729486AbgGHObC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:31:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n3rm1KARj6BwSDZb98b1xN5lTXxGK0GvEAe3Hzksu/i/AcBNyrbltOk9grNU3SjGYALsOsLyaBIsPVCCTZme99i1mmQucpGCX7ZyRCRl9uiglK14419KhpNtE8Pi5HHGAeGJp5JMqL4iDQJw825woYgCCRt74Q2CsBQzxMqvPjwj+vvGkYTmTMkpY2M2culLrf1uRq+CIfmc5LQ5S52reYdYjLlQrGWE9Ys61WIG+8trm3zAS9WHKFg94rKVnq1XXwVRP51rAshVx9MPpt6ifaZl3Zc8fqLYsofaxI47V3FAwImmeOlfsgkLElov+MsxkJ3+yTqzyuPxwl02Zk/xEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lHt9gHWev91MLJwMuSJWepZ7CXUlQvfwzw/h/ZWk/M=;
 b=RINcIIOh6VEBKuPJKiCIdlStL0/tCxe7vZCbpq7V23cD/VCFrRhCh1pJI3hOs0wobGfHjDrgBXHAP54PuNEnZERZRLp8Ql45TwMiGL18uLV5E/wIfM+Lk3nU3LiGa5NZX1MnBo35DHo1dObExHudqIkHywV8CYoWoIYSLgNa4Mn7QLogdpm4lQwppy8EHv8S48bEoOfBMIkgeY4LBELge/eGS2lGtLeMiJV1XTSx6Wb81WASvr+vQQF4vQvmAToyfK8p3Bj4Q3w9o0oazZb4UpFbwgjJC4s1YgfQrAX5TTMZAfvlz4RGeqHWHdBrIWSbHYIzpYxRWQ7FhBzuMXTyuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5lHt9gHWev91MLJwMuSJWepZ7CXUlQvfwzw/h/ZWk/M=;
 b=KXHXB9gFuKcX0y2vRPltmSoDsRVx/2SqFUaU/VNCYiPi3Vkhk7/etZDbGXKRW9Sw8+/FxltfZhTU7/9GclNk5UHo71nzxSZQbaR7t/X00laIr7D7HS9VQ6X+fe21FxFx0yh/etXgRDMII073IZkoc0abuxthkWxrEUahq2mngRM=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3560.namprd12.prod.outlook.com (2603:10b6:a03:ae::10)
 by BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Wed, 8 Jul
 2020 14:30:57 +0000
Received: from BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6]) by BYAPR12MB3560.namprd12.prod.outlook.com
 ([fe80::110f:a75f:beb8:96c6%7]) with mapi id 15.20.3153.030; Wed, 8 Jul 2020
 14:30:57 +0000
Subject: Re: [PATCH] drm/amd/display: add dmcub check on RENOIR
To:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        Aaron Ma <aaron.ma@canonical.com>,
        "Wentland, Harry" <Harry.Wentland@amd.com>,
        "Li, Sun peng (Leo)" <Sunpeng.Li@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mapengyu@gmail.com" <mapengyu@gmail.com>
References: <20200708081622.3109902-1-aaron.ma@canonical.com>
 <MN2PR12MB448842FC1EBC1B8662C3624BF7670@MN2PR12MB4488.namprd12.prod.outlook.com>
From:   "Kazlauskas, Nicholas" <nicholas.kazlauskas@amd.com>
Message-ID: <349fe037-2daf-f73a-5e28-725d3953e1a5@amd.com>
Date:   Wed, 8 Jul 2020 10:30:52 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MN2PR12MB448842FC1EBC1B8662C3624BF7670@MN2PR12MB4488.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR01CA0080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:3::16) To BYAPR12MB3560.namprd12.prod.outlook.com
 (2603:10b6:a03:ae::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.180] (24.212.165.133) by YQBPR01CA0080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:3::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Wed, 8 Jul 2020 14:30:55 +0000
X-Originating-IP: [24.212.165.133]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9833d430-22c9-4335-c5ce-08d8234b870a
X-MS-TrafficTypeDiagnostic: BYAPR12MB3191:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB31917555F4DFB02C2C861B02EC670@BYAPR12MB3191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dREkkg+eyLS41MsxBTNB+BFBhfJoxrb/DZcxH9GTOUO67w0On2BsZjZD9pUtS8EYDtHvmWvAmnhRZakhRLsPRm0ajU8vds7f0+oT/sRiFodsYGUv1Zq8I4SDpfb+GMjN9HL+EU+QDj376NewO79HXlUnHibVA+wPy9HkWeXc/60dXHtsUlDnuaKZTdv+4sm3y7jN4Fym/jE5hUdb+BbR+0JfquLO3OurOWBeAOdhAHP/lDVTKh/MZtlRE/4vDtLhr+8rgHyot4GwFHDB/h9ZiX9o3htqN6s9r7bithyXUCUzN+e5gDzUg5qpUr+vzFigMMJfCwDfODRRUl7N6K8FS9NJOYQ7VksEP98N/bqGnIlGsGWxtZKljd82yzHqcD5dAsDKkhv4QydX1Gq1isWdY68b4pAK68v0Q2LA/7J9+Rv90+hOYchwKWvMOzctmaX26rDS0RPbm1CkiprfPSMVAnmXVZCxkACZrCl9T6RD3BM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3560.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(136003)(376002)(39860400002)(396003)(346002)(66946007)(16526019)(186003)(66476007)(66556008)(8936002)(966005)(26005)(36756003)(316002)(110136005)(16576012)(31696002)(2906002)(83380400001)(86362001)(31686004)(5660300002)(53546011)(6486002)(52116002)(956004)(2616005)(478600001)(8676002)(6666004)(921003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: yD15UbnMrAYfSKNXggMnFfwj5vXkRaiP9l4zYgR/KtBPWMoPpXO24OJHp8yAHOSeSiDGaCwbJ7UXZLBGC5NE3lBcLQMdXW+8t5+AsfZsr08xPsY6p1i+GbcCu4l+NhNY5asQzBJwPNjdXjZ8R3wZc/FIFGacT2bEK4jwpop/qS1yfFwX2zslrfCItIVhm2hwtwTtwGNgSlJxeG8zEZNlaGdDdGOXwzhCI5puNt54Hf0mCb1WmPGfXnnQvfGu+sNovYyoxhrHf90BA0iy7YNzM1+FexUjq1mbbLe9Y7XXgS3tKs16eWDOGKCuVMnpH6vjOP7xfNBqP2XhUrNNe6uXNLmpvkF5EFVJgDxC2Fvj91NkH+hlgBj8ysv+tGWYT303l6VHs+v/sq7/luyroqk4k13VVUBWPBJ4GN6kDjnsHuKEyc2dJvBvVsFSyA7Lx8u72mmkS+D2IblHfxao+aV86nBEwJLuzlv564rdXzD8ZOijor7BNgPcP2CWvcNKgTtT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9833d430-22c9-4335-c5ce-08d8234b870a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3560.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 14:30:57.2452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSgrypL1x3/5X5PI3h011TCVEtYUEOC7IBuK1WSlT0g6kGmiHZ4ZfYgsPtf0TIOb/B+UtcuigYUz07jTdzSm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good to me.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>

Regards,
Nicholas Kazlauskas

On 2020-07-08 10:15 a.m., Deucher, Alexander wrote:
> [AMD Public Use]
> 
> 
> [AMD Public Use]
> 
> 
> Acked-by: Alex Deucher <alexander.deucher@amd.com>
> ------------------------------------------------------------------------
> *From:* Aaron Ma <aaron.ma@canonical.com>
> *Sent:* Wednesday, July 8, 2020 4:16 AM
> *To:* Wentland, Harry <Harry.Wentland@amd.com>; Li, Sun peng (Leo) 
> <Sunpeng.Li@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>; 
> Koenig, Christian <Christian.Koenig@amd.com>; airlied@linux.ie 
> <airlied@linux.ie>; daniel@ffwll.ch <daniel@ffwll.ch>; 
> amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> dri-devel@lists.freedesktop.org <dri-devel@lists.freedesktop.org>; 
> linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>; 
> mapengyu@gmail.com <mapengyu@gmail.com>; aaron.ma@canonical.com 
> <aaron.ma@canonical.com>
> *Subject:* [PATCH] drm/amd/display: add dmcub check on RENOIR
> RENOIR loads dmub fw not dmcu, check dmcu only will prevent loading iram,
> it breaks backlight control.
> 
> Bug: 
> https://bugzilla.kernel.org/show_bug.cgi?id=208277 
> <https://bugzilla.kernel.org/show_bug.cgi?id=208277>
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 10ac8076d4f2..db5e0bb0d935 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1358,7 +1358,7 @@ static int dm_late_init(void *handle)
>           struct dmcu *dmcu = NULL;
>           bool ret;
> 
> -       if (!adev->dm.fw_dmcu)
> +       if (!adev->dm.fw_dmcu && !adev->dm.dmub_fw)
>                   return detect_mst_link_for_all_connectors(adev->ddev);
> 
>           dmcu = adev->dm.dc->res_pool->dmcu;
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 

