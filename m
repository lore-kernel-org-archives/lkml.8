Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23BE9C5519A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF6652078E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="qv+C+vLl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgD0IDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:03:10 -0400
Received: from mail-mw2nam10on2045.outbound.protection.outlook.com ([40.107.94.45]:17638
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726003AbgD0IDJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:03:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IyJxDqDnHBWUQ4EvpTgD0hzsjXwbHx8bU5gDq0S+MXw4HIX9JBfekyZsGBYaJrS3ftJYYRBzbqyhDOZdsU7NHHz+8Zj1lWhtChORJ+AmrcltVxcRRDU5NT5iXpRRSr8Vhkc1nypAP2CXuftlaHak6yDn3r6S+spcAjtZAcROB1yMtX48hHRELn6eqS3SFqPyblRZ5PEGtEFIezyddVzKUnrtiVIgHqwNO2grgz0jXFApxw8uPhj6C7+kqLa7Yq7nGfbY20Bgh1jtEHwhtm9DXUf0Y2GVeb0dbz6M5P3YvJGQrHQR3r63psum+i1TNYiaMNOOEAyzgiK2nVA3k+oiwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUJpiCvBIjVdptoZ6PoWKXT3H34NREru1KVcUJp6mRw=;
 b=D53mZLjiAbVv6X3zwsGjuuPQgFMLtYJsH9wQ7TI+Fy1ezA3Ss78IEZSh/nYmxGB4lBvQndSw0fps/sLsVHb9TFEZpQKCXdWJ983xNwkBNReD1vtMKgpo5NQOmdjS+EHKqji2o5yxN9BFhHzmCZ9fD0MFMjDSE/tPWtxfLEdvwSY7LreXvmWXUBlrK4T5QDq4ooZoBXRtSyzamKWrrKMqGAHRm3ydyca/5q4J9K507schAq5zB5amFpoc2CS3Bg3ZP/ZHCkRortWHSUwLXUpYpWCsFpnr5L+7tFnFbfLLSiQyCAyGHx4Is7qIxds4lwr2BFQE/FhYjjdecf2qQhjaZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IUJpiCvBIjVdptoZ6PoWKXT3H34NREru1KVcUJp6mRw=;
 b=qv+C+vLl9XRIQPtWE95Jpt6JFj/2R8b+5iZ+MgLZ4wahOdzbACVv0SMIWTBFx2vtUeBlw6kbfoIx5UvvnWG7ktScCn1AwYPPK57Tb1rh5J2cZIgjJvHTgopLkWKRRNYHabG1zsX5HHfSl7jQ7sfeToFZHZuROS0svpwABud8V60=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4564.namprd12.prod.outlook.com (2603:10b6:5:2a9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13; Mon, 27 Apr
 2020 08:03:07 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Mon, 27 Apr 2020
 08:03:07 +0000
Subject: Re: [PATCH] drm/amd/display: remove conversion to bool in dcn20_mpc.c
To:     Jason Yan <yanaijie@huawei.com>, harry.wentland@amd.com,
        sunpeng.li@amd.com, alexander.deucher@amd.com, David1.Zhou@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200427063715.21255-1-yanaijie@huawei.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <ca33223e-efd8-cc26-1dec-c7975a5001ca@amd.com>
Date:   Mon, 27 Apr 2020 10:03:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200427063715.21255-1-yanaijie@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0112.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::17) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR01CA0112.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Mon, 27 Apr 2020 08:03:05 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6e868423-f432-440c-dbc3-08d7ea816b78
X-MS-TrafficTypeDiagnostic: DM6PR12MB4564:|DM6PR12MB4564:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45642AE20BB700FA363194B583AF0@DM6PR12MB4564.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2449;
X-Forefront-PRVS: 0386B406AA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(136003)(39860400002)(346002)(366004)(376002)(81156014)(6486002)(31696002)(8676002)(8936002)(2906002)(66574012)(36756003)(86362001)(316002)(6666004)(31686004)(2616005)(186003)(5660300002)(16526019)(66476007)(52116002)(478600001)(66946007)(66556008)(921003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jm/b4dOw/t0lz6iDWBL1rzDJTgRwxK4E9yKXh7pA0ICEHmhp6lFQa3XJEd2n7yjOjFye+L2RYcexlRYc6QqwARk0HYLTpWAoTmZL4LtfL1kPu+5QC2UUZjHZHJ+RAum30DPUhqegZgvu1j19bDXk4tvE0Yzk93RJTJEywOu50deq1KCWf+fgg4NLHaNy/tyaAXi7rI/0NcU1ph2Ggf5iyXnJyzynHT8ZRI2mFHviTSy12p1ilYr/pkkse91EdgEkVitvtxv1LwkSi3PgWVtFyEeqxjTZ4+NJs4KnuX5uNq3yPKb9Er+VtrryPZRW1YsTVVarQfoq8pRK6K+EgT15a5LI3T7DtVXUDuzSl3QyZH9yWRTDq6Q/ko7j1oMNuxvuxVJaVaxtz1IfMjN6S3hhzk1OXWckswc/BAs3uX4d/dSU4DII/q7R/mH+kowgHcfqerZ2UurAoRmPhbeh3z48L708ybbevPMSJ52vyo9YlUU=
X-MS-Exchange-AntiSpam-MessageData: qASlr0Ye8AqdAkoS2NIKgJQXUk/runSvDFCOv3RUn1nEREOhAwrzQonrrmvuv/KrZLtHBZqostB8ary8Wz0oTP/q5SbvkYwQhtO7/dqdXvBGC3/zqLt9jjzgBVMi9F0K9XLiSxkFnF9z/NjGwe4VSHUW5u3PWwMZELEiNYPDPGpH8at5CPA4gr6FpKmZq9xVG80+6UOiUOxwJDzek5gs6Lg/QyG14qDBYjPyCXq9PY3p5ksp/EZ8RX1BalgSfCg9EwLBgcx4NVcYBDljkvI7+METLY2JDr2yPqVjgcC0MiAUskfBkcRaucbWgCtVLFSRqmqO0KhJ6tiTsn1qVdYLakdr/qpa6PKet7GniW6T7QMNKCxQWmoCsG6K540cEqLZnw75UW30dRfiUiglDZmeCSAgq0qVglLmgbPIKiUVToJNWbYZeRFr1PYWQPq+YFeopu7hek80I99mqiV59o/rX/LIxmZhAm3fE5qHaOxN07uuQSCR+nnXiaMBZzjy6ldSJ/zSYf2AOP6l8Xr+9amPKWB142e7YyxxQp3PuGsUrYwhqSZP0mRs/sg5O1ll6mEx+uz3ioLcdUv1/9dCEJB9VU4mV/vcnxfgr/69ZqvdMrWwAaXRUiDPAQmCMCY99aM9F5beBrT2Nz2srbKgFOlsMtmEM5GZZATdjmvACJFueMC+2OurAKdT4cJQcU4ZEhjLfcvnxbFzUsOaQscPKQi2IHR12ncw6inqSRKed5XMax3KPKxflwCSb6wKeqq8dr+zlsRdZzY7O+RhHrzcevgwcnP/ZhY5UHBVhfM/2D3thh8rdw2RFhLPXEgPVUao+wnItCPyGwfFD1n71vLH9PxW/4DZ3dESnt6fLpLz2QqWpCM=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e868423-f432-440c-dbc3-08d7ea816b78
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2020 08:03:07.4363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hgOFxI3Sl4GLzLN3dM6eGISWiinah5MGh7Uw+X/Jv5GwnI19vRDOuyU7puRVBcna
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4564
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 27.04.20 um 08:37 schrieb Jason Yan:
> The '==' expression itself is bool, no need to convert it to bool again.
> This fixes the following coccicheck warning:
>
> drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c:455:70-75: WARNING:
> conversion to bool not needed here
>
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> index de9c857ab3e9..9d7432f3fb16 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
> @@ -452,7 +452,7 @@ void mpc2_set_output_gamma(
>   		next_mode = LUT_RAM_A;
>   
>   	mpc20_power_on_ogam_lut(mpc, mpcc_id, true);
> -	mpc20_configure_ogam_lut(mpc, mpcc_id, next_mode == LUT_RAM_A ? true:false);
> +	mpc20_configure_ogam_lut(mpc, mpcc_id, next_mode == LUT_RAM_A);
>   
>   	if (next_mode == LUT_RAM_A)
>   		mpc2_program_luta(mpc, mpcc_id, params);

