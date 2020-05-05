Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132B5C47259
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD65020661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="K6xB6fUq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729240AbgEEOHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:07:13 -0400
Received: from mail-bn8nam12on2051.outbound.protection.outlook.com ([40.107.237.51]:6097
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727857AbgEEOHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:07:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hES0BXgAQqFN1eqOtXSy8R/OlHeJq/vMccWBZZ/RlemR9lasKov2caLAeDFhv1yMCkWtbn4kU+LrUIuN5/01+hmwGpWIrPHtf2L0n5EWxWPvNL2izbDAvtQu9/pBNGx6/BNra+Z7HjBu8oXcdYTeL4A0+t9a59BBLEv+yl306mWiT3c8iHmj67DYi3x/YKmWmYbm2l6L4k/hNEMRZVLLd6yZU5W6AYPMLKX4s0DlgaXQDsufYkjyznZf1NVNzDugk6NdPZM3UmJ2+WI7NWQBLi/nuYgnL/9Gw/HQIMyWSRsW+2/14Z5ILK25rjufJfz/uVcLCbNkJYl5RwuzppTvoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQcF/r3gTa/ltYgixgR3j/1xXcBt4gFUfbfutVwujws=;
 b=bRfGT6urieosTQ66lU0G6cwI479rdOxI5ajlqS/2BFf3udsE7jAXZmy66aEr4ebUY5lbjLLpypAtg1osSithpItuf6NbI9BM8nbNorSs54dExyyUm9atMnbMvEXniODqZETSClJq7QcX/XPADiIJzUz83kVaxf105KYmemPivZdfSrfnSjl/zr3e5zP0S1qe+jykQ6aNh7NgrQXGEfxivnIHbWJSSFgWEUrB+CT7BL1TYBsAVvT7ftwYEGYNusSTtVJrSO3K/l8n2rglskRv3OYoNqCi4fqjmHgvRkJKrrvFulojB0PdeTYFFoUPklSzT+NVPy3acw1PTu7DkHy7DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQcF/r3gTa/ltYgixgR3j/1xXcBt4gFUfbfutVwujws=;
 b=K6xB6fUq+6o087HCyw5m7sNB2NolaIMsqEYMreLvTrgJathdYEhQE3XFc1HeMWPqIsVLUshxNCvOUKcDLKT9dUo1FUltcb+5Lec/p5Tx4duQqD76+Q2CORh0G2bgB3c3r5DTmyRd8/3Rp03WeSWnnGh7f2WfpYKjwVNnVcdnhxQ=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3051.namprd12.prod.outlook.com (2603:10b6:5:119::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Tue, 5 May
 2020 14:07:09 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2979.027; Tue, 5 May 2020
 14:07:09 +0000
Subject: Re: [PATCH] drm/amdgpu: allocate large structures dynamically
To:     Arnd Bergmann <arnd@arndb.de>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        John Clements <john.clements@amd.com>
Cc:     Tao Zhou <tao.zhou1@amd.com>, Guchun Chen <guchun.chen@amd.com>,
        Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200505140208.284473-1-arnd@arndb.de>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <6bbd0f78-6f42-968e-2269-0a6279753267@amd.com>
Date:   Tue, 5 May 2020 16:07:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200505140208.284473-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::37) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend Transport; Tue, 5 May 2020 14:07:06 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 23acd443-0029-42c5-aeda-08d7f0fd9971
X-MS-TrafficTypeDiagnostic: DM6PR12MB3051:|DM6PR12MB3051:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB30518DB9BA275836BA6DD6F483A70@DM6PR12MB3051.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-Forefront-PRVS: 0394259C80
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vPGS5HDO72NDu0xdMIrSXLVwDfTnXucEySZ3nhunIkVXKjF1HdT812nqLgEUQhpP8dry4HYApJ+sDdWP6PCN8rLncJdiwlZt5n9MQhCxsgz4y4uggq0mjh8k22cYn55v15u0a3OpFiTFnRv6WqIU86ZWviA7BD8ed5OzJSB0jbwH2P9n6tldHvwNSkeYYDjmjb6jTdGsfoO+okhEasuO6YzoSSwflkTS7wiQQ4bg7Ao8JvP1TmDman8ZEdPn/pXECIPPx7Hsoi4baDXCJIe3W0NkoEWDiO84RoUapfR/wtZiyoUr/fmGpysK1krlGLFiTESXE87D1f/vKXLEjLFR4mRg3OcW9HWJgjXvYEsGjfQGbPgR6VWlJmru40wyzGnjlh4NA5ndC83Aiw7n7p2lIhlGnbxJfuIjpySpotZdw/vKrqAqVZ1XrjSY+8rua2tG6+7O2f1dwiE7efMGsCXLJYKlDwHsCQKw5lftQjXNZU+N1oRsW/6Sn57qXU5JCXxzrjjPEzPLvp8QkSLNofVFCrI1VOGw0gGkj1DFvS//DY6Jb/TPVa7XLUF8fNW2cb4b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(33430700001)(66476007)(66556008)(31686004)(6636002)(110136005)(316002)(54906003)(4326008)(8676002)(6486002)(33440700001)(8936002)(2616005)(186003)(86362001)(16526019)(66574012)(478600001)(2906002)(36756003)(52116002)(5660300002)(66946007)(6666004)(31696002)(309714004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 4HctXg65QQrkCq0xCEttt+NFeOpFp+QCTgFBLh44EHHaGbjWHR0LpG9TAlM8bUpIjvowC+Uc8hHxbf6EXDqHhtVE2dVrAPLidg8D0/pwe1pPh7Jk+Z5YFSQU1VEeoaxmdxTG1DfPCrv37RP1qwvTJ69+JySclWjpGnf6pHTaOGO/8Lri04Sdymf9Ed2ZiSKUsoHS1oCFu1cefiwPtDEbdsV9Bo92E1cr98cGE1xenfEKml8+CBGzGjxx3o3DKCJ86XokQbu2dNuYKMkwO8zkuxH6+WssyS1DF60IraDJNUQ0T3HSfnlgM6JSYlpck9IW9oCHpCN+iwVsUxrIGLWkYGQVyY4MIg/KfQ8ARC9aCUs/vos2feCLMibMs0o183NhuhweHP9WBoCcuhtnO0haBSW/TLsKNc1CDtlDDQMfa6rFv7OoHqxCo3b3Qsx6uo7p5ksWouuE4o+DEC4bMknT/IhRKG0JgV+E5MDeSShXXcPmNEVSxv/xoxcFE/io/GB8lbJzySSUJ5xgn7pGeiJwQPQdaqc/73Q/uUuJxg7haI5PEuEaELe2BivMlHGBW0lKdcnnMVFt44TaspuF1vuvsFJJ3xpdcHEVACF/KyaUfs0KTjhJvq9oIw5vCsa9+hJ+FtfrHd382sGJBJMWh0QfIyb04GI2AXIAtdzB6UsnXeCI9k69ytVytnHvqN/Iw1MN7L5OawvWajyJhs7MDuKOtboROpGCbs3ySBDmNTlhDnrlk+aHgT3XHSBbIOVglYw1LBBtftSGkAGNA+VFpFOTXe5eNO+7F9xLXzT7ZPNvqv0vW14JR1qUp0vCY1XC4Y7ozBfcwLjEN9hqRTDS7RM2fBEIyaADCPs7rMhkp87gz44=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23acd443-0029-42c5-aeda-08d7f0fd9971
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2020 14:07:09.0121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8rrjmOou45SVn4jET3Tfs3gagJrijAKJsuXb3eMVynxuUi7bAbOvbHSAVLsTT4DP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3051
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 05.05.20 um 16:01 schrieb Arnd Bergmann:
> After the structure was padded to 1024 bytes, it is no longer
> suitable for being a local variable, as the function surpasses
> the warning limit for 32-bit architectures:
>
> drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c:587:5: error: stack frame size of 1072 bytes in function 'amdgpu_ras_feature_enable' [-Werror,-Wframe-larger-than=]
> int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>      ^
>
> Use kzalloc() instead to get it from the heap.
>
> Fixes: a0d254820f43 ("drm/amdgpu: update RAS TA to Host interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Christian König <christian.koenig@amd.com>

We have a bunch of those warnings in the DAL code as well.

Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 31 +++++++++++++++++--------
>   1 file changed, 21 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> index 538895cfd862..7348619253c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
> @@ -588,19 +588,23 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>   		struct ras_common_if *head, bool enable)
>   {
>   	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
> -	union ta_ras_cmd_input info;
> +	union ta_ras_cmd_input *info;
>   	int ret;
>   
>   	if (!con)
>   		return -EINVAL;
>   
> +        info = kzalloc(sizeof(union ta_ras_cmd_input), GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
>   	if (!enable) {
> -		info.disable_features = (struct ta_ras_disable_features_input) {
> +		info->disable_features = (struct ta_ras_disable_features_input) {
>   			.block_id =  amdgpu_ras_block_to_ta(head->block),
>   			.error_type = amdgpu_ras_error_to_ta(head->type),
>   		};
>   	} else {
> -		info.enable_features = (struct ta_ras_enable_features_input) {
> +		info->enable_features = (struct ta_ras_enable_features_input) {
>   			.block_id =  amdgpu_ras_block_to_ta(head->block),
>   			.error_type = amdgpu_ras_error_to_ta(head->type),
>   		};
> @@ -609,26 +613,33 @@ int amdgpu_ras_feature_enable(struct amdgpu_device *adev,
>   	/* Do not enable if it is not allowed. */
>   	WARN_ON(enable && !amdgpu_ras_is_feature_allowed(adev, head));
>   	/* Are we alerady in that state we are going to set? */
> -	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head)))
> -		return 0;
> +	if (!(!!enable ^ !!amdgpu_ras_is_feature_enabled(adev, head))) {
> +		ret = 0;
> +		goto out;
> +	}
>   
>   	if (!amdgpu_ras_intr_triggered()) {
> -		ret = psp_ras_enable_features(&adev->psp, &info, enable);
> +		ret = psp_ras_enable_features(&adev->psp, info, enable);
>   		if (ret) {
>   			amdgpu_ras_parse_status_code(adev,
>   						     enable ? "enable":"disable",
>   						     ras_block_str(head->block),
>   						    (enum ta_ras_status)ret);
>   			if (ret == TA_RAS_STATUS__RESET_NEEDED)
> -				return -EAGAIN;
> -			return -EINVAL;
> +				ret = -EAGAIN;
> +			else
> +				ret = -EINVAL;
> +
> +			goto out;
>   		}
>   	}
>   
>   	/* setup the obj */
>   	__amdgpu_ras_feature_enable(adev, head, enable);
> -
> -	return 0;
> +	ret = 0;
> +out:
> +	kfree(info);
> +	return ret;
>   }
>   
>   /* Only used in device probe stage and called only once. */

