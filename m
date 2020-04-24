Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 613D8C2BA1A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:41:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3778A20724
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 07:41:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="jl/tEYGX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDXHk7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 03:40:59 -0400
Received: from mail-bn8nam12on2078.outbound.protection.outlook.com ([40.107.237.78]:34229
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726175AbgDXHk6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 03:40:58 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxJgePilDbbGiU9lOZK5BXqcCtM2wnR1TOfFf41pefp6+tAu42M56Ljn6rEuJ0VzhcN54G8ZFGRXLD02VcfZDAc/llkIacTdKIEHtaB2+nVawrIB15jAE/xQU6WUIRgj0jA4xWYURgBDbSF0TVvHjh7WN8DeQHp9nFodUqOz9XTP5dagwgWB2VtjeDqDu8GspnDON9RSGc31u4qsudb8/PzEye/geW917dmuvZNP4hEfHsMKn9F7egJetxFIzY5wPE8nagOl/XQFs4c6eYWKGqPz2jLIYqkQdsQfMe0HM+ffh/q62cW55F9MhOnj2yEyJWhFPxDkxx8i2tIJLmvR+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15XqzlOhE5an5Dlc0atc2MLSDkCeQtL+wTPY8FvR+tg=;
 b=UaMEYvILWASo1+PiqkJehkbzfHR7XVtWbPyX8BR1qEiwEkZ7KzJXa6o72JYd5CtnLCpxy94N3K9rM2+1Xzz6/zxLm683WELpmTkpdfbjnp630rz3h2TY52dIouUrUknew9kXxy9d5OndH8gRnZSlutztNDvO8lEC3Jc9PPPZoi1/VxZeinZIUVcYOv2QZxy7zJSVCiN3ajGR97ovu+kPs2V9kjJPTO+3dbHTbC2rJkjDAw8ntn8E4S21omsrDLw73nVQp0kvthaXU9xCv+eC5/JpDkTs/PaQSKcHagQYZRL+l4yPwo5lMCh0tCDu+Hty54YxMq3wpnBCKRJQxpAeCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=15XqzlOhE5an5Dlc0atc2MLSDkCeQtL+wTPY8FvR+tg=;
 b=jl/tEYGX0XuEF3nWBBR+cYuojT2mMM+zOMmvXzUartJJiFuVcQ/KT9HPfkwoJxNoFC2BcsiXQ5is+KL5cLwxM6PSYpDqeMuxdFII37GLY+krqlTbgCLvu3g9fGDmlEJ3HWB4mfPo10X08sFHj+pHyp9neeSke5mtsnPCBCpPO0g=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Fri, 24 Apr
 2020 07:40:56 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.020; Fri, 24 Apr 2020
 07:40:56 +0000
Subject: Re: [PATCH] drm: amdgpu: Move static inline keyword to the front of
 declarations
To:     ChenTao <chentao107@huawei.com>, David1.Zhou@amd.com,
        airlied@linux.ie, daniel@ffwll.ch
Cc:     Hawking.Zhang@amd.com, evan.quan@amd.com,
        andrey.grodzovsky@amd.com, Monk.Liu@amd.com, kent.russell@amd.com,
        linux-kernel@vger.kernel.org
References: <20200424031316.61662-1-chentao107@huawei.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7d50f774-ebd0-e700-9713-209ccb8010f0@amd.com>
Date:   Fri, 24 Apr 2020 09:40:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200424031316.61662-1-chentao107@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0092.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::33) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0092.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Fri, 24 Apr 2020 07:40:54 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 79f95a3d-1a54-4d3e-9f84-08d7e822d2e2
X-MS-TrafficTypeDiagnostic: DM6PR12MB4404:|DM6PR12MB4404:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB440437F7BBB0A02EB712BA9883D00@DM6PR12MB4404.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:105;
X-Forefront-PRVS: 03838E948C
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(39860400002)(376002)(396003)(346002)(5660300002)(66476007)(66556008)(66946007)(6666004)(31686004)(66574012)(316002)(81156014)(8936002)(31696002)(86362001)(186003)(16526019)(4326008)(2616005)(8676002)(2906002)(6486002)(52116002)(478600001)(36756003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yv7ta53FIj3BiLu3k9Th0VJOXX1Jd6us6P7arlzDgD8Skgab93MuQnTUBw18SN6xq1MM30zFDRoinJbyfGi8y/9HKlyEhQObYMG+3Az2ubSEIrXLdAecL8HA0slS1zQpp//nwtF34yWum7Wk482DDsnn9h1pr7rSd2BouGwhT8YriJk/FbM2auxKAurk8EVlReYqsYfENNkGZ7wS5tv0/RC9rHZaurNfCUv4qqB9Qs8LOX1X1dAGqfEC+djZw7cQn5ltLfictBJSX2crJVTQlYxEZjzad8UQLtBqNbnCKSbySSVLhCp+pCRv95Yn2LAg/ZzfMQZK6P9wtW1r1/yjP4ArEqbuK1HJHCh154Xw99Yvx3CW00+xnYRlAPIpnescT5OcPtPhLI5xx2auarVQomI4It1Nwr4cdA6jtJzjvXLqLwErEuhH9n7GRCVcT2qT
X-MS-Exchange-AntiSpam-MessageData: ZQm2YdqrTVTNTQL/IV0EXArANAozfp/cz2zZY/S91rqLR5OKnO7rQ7jwQdggrNXxlQMT6OcfLFZwe3KqpBqV+ZDgH8Zh7fV0nYm9ZbeF5VRYdtJarNJH9iEAFhtIlIaU0EXfMCIEWL6F4YLW9dmu4yKfOPKsFL2yB6DVz4yATUp2Ns/FQcG8Wg9J8RjrdE3bAstuEVv1q8KaK9YI4XTlaQrYceyvqKdXg0zXSXLB9k/3FRFzuQrcEeDeZ3vKKcc2BcuHwIEXT3eNEJgKD8ubwRhsFNU4CFhpuFv4fyNJ0KesxH/8FVm+j9C+NH28Tjq5cKcfOMNrFwQaElAFDSG3wL4dBQjK6z0tgGU3TCUus9qTdbz1S/iwcomE/V00boUsKbULel3Y+t8p6nE9d7MNugUxBu+B+qxMekIxABqIdaH8V8F0v7sznOcvyxntAprbnT1yowS0g6q3ig8taeoxvn7kyBsUGoEem0N9BSVEs+rQ30NKb3gqqHTDQ2vpl+n2CUZrs+o83lAudQ1dz5lWWqXtqyGxPzH5HmGAshsY1zL21iA+VniXcLo3HwJE9G0RRtHiIia76tWyWdtdHDF+MKwfoggj+ZoZwvGgCz7+eGasp4nyY/jQaLiGngH7K35WaCHk5WfUuYJiGay/vt1XTpA10/4IGweXSblg92VM7mshj63mDA+CASsC94Dq7/MtBa7d1BgUWig/340z4PiW9waDcNiF2yX1NBiq2YN79zS7E4+6zl52MVtvcqhpOVAbOboJYj5HuDq/VDRg7m1MpkdIKqy9vn5hpyv5RpPxT8H3zCwWVTKUFqpMLmv85gzHmKjeqZ3a6ouslHUXTbMrRIuaV03KhLOxKF5iuZGO36Q=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79f95a3d-1a54-4d3e-9f84-08d7e822d2e2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2020 07:40:56.3163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mwLs6Lc8Xk1aQlM0fDTnl3z+Jnn1BV/YfSsd0p6MlRdT56Pu7a/bxnQyl/W1bju
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 24.04.20 um 05:13 schrieb ChenTao:
> Fix the following warning:
>
> Move the static inline keyword to the front of declarations
> amdgpu_device_wreg_no_kiq, and resolve the following
> compiler warnings that can be seen when building
> with warnings enabled (W=1):
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:344:1:warning:
> ‘static’ is not at beginning of declaration
> drivers/gpu/drm/amd/amdgpu/amdgpu_device.c:344:1:warning:
> ‘inline’ is not at beginning of declaration
>
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: ChenTao <chentao107@huawei.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index ad1c66763dc1..d53a5e3f464b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -341,7 +341,7 @@ void amdgpu_mm_wreg8(struct amdgpu_device *adev, uint32_t offset, uint8_t value)
>   		BUG();
>   }
>   
> -void static inline amdgpu_device_wreg_no_kiq(struct amdgpu_device *adev, uint32_t reg,
> +static inline void amdgpu_device_wreg_no_kiq(struct amdgpu_device *adev, uint32_t reg,
>   					     uint32_t v, uint32_t acc_flags)
>   {
>   	trace_amdgpu_device_wreg(adev->pdev->device, reg, v);

