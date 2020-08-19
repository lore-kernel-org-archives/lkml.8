Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7F1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC384206FA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 08:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PXVzsnh8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727080AbgHSI47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 04:56:59 -0400
Received: from mail-bn8nam11on2084.outbound.protection.outlook.com ([40.107.236.84]:38912
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727030AbgHSIxf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 04:53:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m1ojHyA0f9UH/lQbu5SFWY1+Y7Nrv0gWKspUVOi33Ib894MHFqWXN1HNLOB3gsxK3NLPFlbZDwbhprIDRVQFzpUQquIz2Jdb6RgqLy7QDbvDOML3KzX1ZFrAVUaZPmb4ULrTsS4zV7P09xIeCXzQJWFVKLRTr7QSQYJClb/ieXrBuCw+uzDycE6QRiqFuZTjZETbiCmbiRh+Cu7QtvPImqw9Yq/RJ4TBqW+Z/twlPSBor4KGYxQMRrhghUPFdfEkXyS8PgfiKjAHU4f3og/3b0DyKcGej6QHpAjbibpDHQWsbEvHTLZ2pNdzNIyQfNdkQBNPaUKKoLqcA+tLiXemWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yWUwJ2QSDzT31n1fgcr/KzMGfevNyFHrTSdWUcr8sY=;
 b=dLnSpxLuoc+IfRIuL+XrM/Bn3Ep/57UXNFf7IkMkjbslwH0vwtiEEvv4A9PK9eCkdoQaEQHTBK38sNo0oHDdG41lqWpJsDJAx9OjVJeIzOYkxbiNnLuaI2DqkLoI8tNT3brehDifqet3NGVLoUP3e5MuP9BIdrqveIvLnHGVXuN3cz8fwXpBJLGoMpodsA3Ch/2Ope35hGPb4SiRJkezAClvQt6OL5PSO0VEniLMSsaV7vxJxx9nKhwvIJw10xGhvknUESGxDSMLMqcY/raHDJThIbsT3OOvrxfVm5P2+qBpmrH6iaiYnxE1kD3NAjnIXzcLk7rSUqLsBLFgIY7RsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7yWUwJ2QSDzT31n1fgcr/KzMGfevNyFHrTSdWUcr8sY=;
 b=PXVzsnh8k7uw9g1FA+66jhXXGsGil2HchBke1HbXSimPUsfvgnsc+I/yZ8CWeUdMiRNJE0MI9w4KX7yyRWu0HoJY4+DVXc14Y9DisWjG6bW+59ncw5dG7dUNSGBksPLiyaHAOd4AVXjOufZmVgpaP/m89lWd/ZgZmIXtjmv0yVs=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by BL0PR12MB2418.namprd12.prod.outlook.com (2603:10b6:207:4d::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.16; Wed, 19 Aug
 2020 08:53:30 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::a16e:8812:b4c0:918d%6]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 08:53:30 +0000
Subject: Re: [PATCH] drm/amd/display: remove unintended executable mode
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Dennis Li <Dennis.Li@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Guchun Chen <guchun.chen@amd.com>,
        Hersen Wu <hersenxs.wu@amd.com>
References: <20200819081808.26796-1-lukas.bulwahn@gmail.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <f0d3f57c-416c-6a6a-0e9e-d3dc308f2b52@amd.com>
Date:   Wed, 19 Aug 2020 10:53:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200819081808.26796-1-lukas.bulwahn@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0902CA0001.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::11) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0902CA0001.eurprd09.prod.outlook.com (2603:10a6:200:9b::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend Transport; Wed, 19 Aug 2020 08:53:27 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 74719b00-290b-426e-aa36-08d8441d57cd
X-MS-TrafficTypeDiagnostic: BL0PR12MB2418:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL0PR12MB2418C4DFDB948C6A3A18EBB4835D0@BL0PR12MB2418.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: khdSjkSe6nCAUpg+n/Zg8Vg/a5Od56e2Rwf8N2WHjrUY63mQ+uxzU75ECFmZzSSYI7U8yJ16uDxgMBt+yL7KXGHQlQe8oxdjFzYRHxQSYSh4XQsCsm7ektrYE914DvVAMW+fyQwSuJX9QY9Z4FpAujMFdEHBLTgWpVaEFPFTLntaLUSoTsyLV6U+1n/YDvhMvMoW5sXxS+oSHEQxDckMYoRZI4TlRg8sKFPyn9M9HEiEHSzt5ui7o8XE0pzXL+XP/PM/txC7GZVu44c6azoCng0qFQXrx0UwN97JWiuTWl2UwWmAUMT4EA4toAYKaCpVkPJmUThRjBtaYGqGLdjmc9V/nvIfKKScuif57r/zFWyqXixxpYtNhsuPxx9Trbx8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(366004)(396003)(376002)(346002)(2906002)(316002)(16526019)(52116002)(186003)(54906003)(8676002)(478600001)(36756003)(83380400001)(6666004)(8936002)(6486002)(86362001)(5660300002)(4326008)(110136005)(6636002)(31696002)(66476007)(66556008)(2616005)(31686004)(66946007)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 5zBfEyDOE/L1lrsYamXrkS+zcq1ilu3wtt/T0D3ohnmdoJY9x7JGSy5jJom2TQOFEWR4D3tZOb1CjLcAlBrWDIVgltH2L41dJ8UpDtA03KixK5Gue8xZfKXVvkZ+xFIwFEYrYFpq/WTAMZeVWtF+vaN+wfhi5uREK3NgSKRKQrHM6vBSLOyUT7d95/xxP1R+ifTx/UPzSgQeMp67QIcTEARuwWj0eBNL4I2INBw4NcP2pisCZQMMkVcaPv5JdvbKzEHQXllP9iZ4nz4VmLiVp8PV8tsxsdh8kQUcNREw4q6T+RooI2Q0lhWavGdMQwAnElTQ73F//XC4f6WFjaQ6pmPMduFkBJLFFPKq2bn3rNbSK3bUc1Ewo2EezKTGfV2h6L6tS3WSwM8+MYaHIDA+pKR0ahcWO8gUCC2E/NQct9SoGcath6OFlTEF1wqUVD3qQPyEg2VgtUYChGHgsYItM8C/5+rpDQ5uDHp2o6t3P1D2upbTkM/YSYZmnKqHLXYoxzG5BmJiE49oReJTfqo+UAJDwyLyiuR/CDDghPOsfZBg6LJEfmrfMTozECGpNEDJt1P3yMi09zyrYbb4Y2cpLpqmZ4BmN7/dVXlGi1xlmMPBkuu7Hxy7K+/F5YZAdGa6JUn9Ajss3gqUclZftaw8ohhvvylaPcyT08uSowIMDZTDZgkD5FYuoN16c0acF62aUNwgiv8vMfNkJLLfXtFq7A==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74719b00-290b-426e-aa36-08d8441d57cd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2020 08:53:30.5543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOnTY4LDCcpcioFYkZQ/HwtndVGwm5RJmKtve10WmLcBBIYu7ThnekwbKZJXO3c/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2418
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.08.20 um 10:18 schrieb Lukas Bulwahn:
> Besides the intended change, commit 4cc1178e166a ("drm/amdgpu: replace DRM
> prefix with PCI device info for gfx/mmhub") also set the source files
> mmhub_v1_0.c and gfx_v9_4.c to be executable, i.e., changed fromold mode
> 644 to new mode 755.
>
> Commit 241b2ec9317e ("drm/amd/display: Add dcn30 Headers (v2)") added the
> four header files {dpcs,dcn}_3_0_0_{offset,sh_mask}.h as executable, i.e.,
> mode 755.
>
> Set to the usual modes for source and headers files and clean up those
> mistakes. No functional change.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
> applies cleanly on current master and next-20200819
>
> Alex, Christian, please pick this minor non-urgent cleanup patch.

Alex is usually the one picking those up. If he misses something feel 
free to ping us once more.

Thanks,
Christian.

>
> Dennis, Jerry, please ack.
>
> Dennis, Jerry, you might want to check your development environment
> introducing those executable modes on files.
>
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c                         | 0
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c                       | 0
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h   | 0
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h  | 0
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h  | 0
>   drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h | 0
>   6 files changed, 0 insertions(+), 0 deletions(-)
>   mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
>   mode change 100755 => 100644 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
>   mode change 100755 => 100644 drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_4.c
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_offset.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dcn_3_0_0_sh_mask.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_offset.h
> old mode 100755
> new mode 100644
> diff --git a/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dcn/dpcs_3_0_0_sh_mask.h
> old mode 100755
> new mode 100644

