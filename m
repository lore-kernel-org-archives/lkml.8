Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660ADC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16D3820BED
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 07:53:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="doGkqwBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730259AbgIJHxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 03:53:46 -0400
Received: from mail-dm6nam10on2073.outbound.protection.outlook.com ([40.107.93.73]:25312
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730203AbgIJHxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 03:53:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X9XnnkgMvkY6MrbafSD+l9dPY7u6FT1EoVuRYZGBwHznB3mX+kaSteinq31ee5IUJuYbJvZpMjxpKRHn67dsUZdjtwgcXXfO7wmb23axXEsl7eeCJCNYgS/oM8M1GFi4WJXCmcnXC2feWTvRwqQ16PNIHqwrXyITmfkygPzMF1Ql+B26ql2dvwlp/geiKiWzgUDTC2BZiE1ud7rUE3v/UXOIYJN8hczocBfTmIzGYUuElLg+hizgxnzQOGuQ98Lme6OScVCdtnxd09MhdkgkjM3n9LmuVZVvE0oCNfrnspzarNmcXzGwzQB5a69An3fEsfuuq3SMT1zDzquBUferwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIAnN8p/rjyfe+qFlFoTQEWWHuVbh/0CZ9lKFQmruaA=;
 b=LV6CZSNPKD7JTtavem6htTxQN8AihKnOicAik0CKZT/ndyzYxTtvQxiOI+NwZSentv4lmEeQQeFNlUONlzZuNN/OlhLHhqVCOqR6+oqDyJ7O/fWFG0ZQY04BGoe96n4KtglWjbhTqJUH8KmnaVnS4XlXUtmtzgoxauLDYF2EHcPFDIOwktan4PWr03/MTFRSZjUZYSTjKJRhQf8UD2ODKVEmiLGVLQ7HMaMxyFFBCUniFIpZVgEFMD80Wj6FchRoIlalvXMGOKa72Vav2kusWJYNWHC/K2TcbRWcuTS530Glx4+rIyR1F+Gwg5RYKgHISryE0sDkhLYuHjvUTTU4Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qIAnN8p/rjyfe+qFlFoTQEWWHuVbh/0CZ9lKFQmruaA=;
 b=doGkqwBQfYatxc3P07EwWHzoHYmlNhfTctvAL67BGIk9kjFwRKoaMl54RzvQuLSG4mkUS4fUeiUt2wKmsqTgIHKswVosufXU0iTTB1GhWU67+dkrIo9cPmaTeIaW/WGwREIOfzr5JANg+bWA1JpgXJ8OFOPMD5Z0X1C2GPqrplY=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=amd.com;
Received: from MWHPR12MB1248.namprd12.prod.outlook.com (2603:10b6:300:12::21)
 by MWHPR12MB1309.namprd12.prod.outlook.com (2603:10b6:300:10::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Thu, 10 Sep
 2020 07:53:28 +0000
Received: from MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6]) by MWHPR12MB1248.namprd12.prod.outlook.com
 ([fe80::e881:6ca2:c1d7:48e6%7]) with mapi id 15.20.3348.019; Thu, 10 Sep 2020
 07:53:28 +0000
Date:   Thu, 10 Sep 2020 15:53:18 +0800
From:   Huang Rui <ray.huang@amd.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     "Kuehling, Felix" <Felix.Kuehling@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "Yong.Zhao@amd.com" <Yong.Zhao@amd.com>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 -next] drm/amdkfd: Fix -Wunused-const-variable warning
Message-ID: <20200910075318.GA2592322@hr-amd>
References: <20200910025532.19616-1-yuehaibing@huawei.com>
 <20200910075006.41484-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=gb2312
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200910075006.41484-1-yuehaibing@huawei.com>
X-ClientProxiedBy: HK2PR06CA0021.apcprd06.prod.outlook.com
 (2603:1096:202:2e::33) To MWHPR12MB1248.namprd12.prod.outlook.com
 (2603:10b6:300:12::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from hr-amd (58.247.170.245) by HK2PR06CA0021.apcprd06.prod.outlook.com (2603:1096:202:2e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Thu, 10 Sep 2020 07:53:25 +0000
X-Originating-IP: [58.247.170.245]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 763332ca-86f9-4e82-b1e7-08d8555e9a39
X-MS-TrafficTypeDiagnostic: MWHPR12MB1309:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR12MB13092289DB48D53D71D05BC9EC270@MWHPR12MB1309.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QBFswSFlQJv6HTazz3KkUdoPkyA4viM4nnUMmN8jvLJms3prVJkXT4sgUTopjEIkgUBt/jP/ocqNWMbW/ucFKniEssZ0doIQnF3Ag7sbCd2Z/KbBfb57bzZ6sNzSQKl3Vy1ka0QJKcprYI0gP9b48T2w2YAD+8CWMp4XICX5dpTnSK768vsnAlC+VEMimxh691lZ/T1SKpQHOqaS8nUtDFV8xkRRN3ubJVILtGJ8h2CK/z24XdUSoCexrw0ZJh5teEGMxP0qCRg72+Mv4JpVkt/NsLJ7iBItpoYj/dY+7ItYf8+iRkNEZAdDl5ci8RY6rXr0S2xU5/z8Baayjgt6oA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR12MB1248.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(8676002)(33656002)(52116002)(6496006)(55016002)(8936002)(2906002)(186003)(26005)(6666004)(478600001)(86362001)(33716001)(9686003)(316002)(66946007)(16526019)(66476007)(4326008)(54906003)(6916009)(66556008)(956004)(5660300002)(83380400001)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G67beNsrypf7mOVi32M47JFf6a8q7L4898PNExyUcDbR9XTI6mNcXgTYBnnFpkM8MW647hnTD7eZusj5ab2eH6omjMmyBoSDqKE8OyvmPE554bDEG6PYyHWmu3gv/hkPT+Uk6zJLW3Z1G9QSR+YnqBAvdjO2b9h98fZvmwhnPB5Gcper49/uzrFv22wYbtgp5VOFdQzKEKSubWKC37WJjWOCqkUQz50YpNPF6ITx+AynmTFWjHks+d+oe//3fs30IGaL840BdDXV0NR7eL/3tUoLp/CaI30QY8gERXylPBegTur1zKmquCfpcxPWze4j75vXJ5bXicWFo+dmL781eeBy/1avwm6b960RGgMH9mbGy1QqgqtJEphVRnqOVmlDhjo5yhmT8LmKZPHpyOdXXThk8O0b11MACWvwxN3BqyorEbGSvIiOOhK3HQ2PjIatn72O3ohpWFQQeFi/R/iATV5zfbYpoUHQjzvqzJyCAISquSO6odmZt1+MLP6QW+n37y3BinQRAZgvyGcbgKEiqfqPt6Sje4KT2c2dXJuQ9ToZtSLFd3JHLcVPNSQprDtt0YVqRvk9k5Stf8KA0ReejJkAfiLGNObgvGAvSnA4hgT58+vjgqqqxeAwEKyNRm3eLfbjQ1aqPzKCuLBsPAnbMQ==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 763332ca-86f9-4e82-b1e7-08d8555e9a39
X-MS-Exchange-CrossTenant-AuthSource: MWHPR12MB1248.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2020 07:53:27.9612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzsbWQezdUiuBLWbpRGDULjhLdAWT6377JHL4VIKxOgsbrtzOzYXu9NyDrKRvaosgSMyNasO5txgKpFJYe0r1A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1309
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 10, 2020 at 03:50:06PM +0800, YueHaibing wrote:
> If KFD_SUPPORT_IOMMU_V2 is not set, gcc warns:
> 
> drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_device.c:121:37: warning: ¡®raven_device_info¡¯ defined but not used [-Wunused-const-variable=]
>  static const struct kfd_device_info raven_device_info = {
>                                      ^~~~~~~~~~~~~~~~~
> 
> As Huang Rui suggested, Raven already has the fallback path,
> so it should be out of IOMMU v2 flag.
> 
> Suggested-by: Huang Rui <ray.huang@amd.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> index 0e71a0543f98..e3fc6ed7b79c 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> @@ -503,8 +503,8 @@ static const struct kfd_device_info *kfd_supported_devices[][2] = {
>  #ifdef KFD_SUPPORT_IOMMU_V2
>  	[CHIP_KAVERI] = {&kaveri_device_info, NULL},
>  	[CHIP_CARRIZO] = {&carrizo_device_info, NULL},
> -	[CHIP_RAVEN] = {&raven_device_info, NULL},
>  #endif
> +	[CHIP_RAVEN] = {&raven_device_info, NULL},
>  	[CHIP_HAWAII] = {&hawaii_device_info, NULL},
>  	[CHIP_TONGA] = {&tonga_device_info, NULL},
>  	[CHIP_FIJI] = {&fiji_device_info, &fiji_vf_device_info},
> -- 
> 2.17.1
> 
> 
