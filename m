Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 779DBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5085C251EB
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 15:33:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HhWGRd9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730362AbgFUPdL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 11:33:11 -0400
Received: from mail-dm6nam10on2064.outbound.protection.outlook.com ([40.107.93.64]:6049
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729536AbgFUPdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 11:33:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luIQrljqIJp1J3QUBzFTH4J4TNhVrCTOFMblVqcXmrxuIH0SqeNQ3laA76sC2LY47t5eMCF9IgorBn3Z3XMblGp1zscJfCO4UZUeSy7J2AQbvmPoEDS8fGyoRis0ypZIN4Y7BOGgVZkzOyfNg7d44v9En64nl+HY2rhcU7JFW2yhx3vaGXYMtNYt+gIHVWhYbk7+1uZUhHPMBJM1UrOK2s3TS4eYnyOqCPCuMnoRgxOONVb4pFRKVsiK+sf+w88NJ08bdTX1RqC453Qp/rigSgUZwGdYqNv1O9tdwikxajC0wvVU7WUn5DXftvkMjiZx4QBbNoXE/F6IYYNUd8uexw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Are0p1caBUBUlxBQrGrfy+u4IiwxS09U2BZrsACPTbM=;
 b=Rvah2a+rKjDWfZQzy775O3z0kDCHaBSRXeyYYrd+0THErxqgnFKKuxp8yYuuFco1qwwPF9Hhnl8K9R7Iy0gi6GbWYmXKvSq9m5eIMUS1Sv1SchBOc9rv0wlmChTDYwCEE4/eQeVv87kfYejiCnverR3U+QJ/Xc8c17LJVUyP7kVjUh5Gt/p7X+kSGV/gYncnmnbSAwtsJZX29kJK14PBgQSDfTX+5eVmoe3RMmsoRMMAV7TKW6T+rlrdbpNxCkP8UGnoG0zeWb4YsuoVWvt5vPyP+T+mMtqJiexO4FP8CSaTp2bYyTW5NcUMHNdikIzRpkHEvLU/a0A2Rv34HxiGNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Are0p1caBUBUlxBQrGrfy+u4IiwxS09U2BZrsACPTbM=;
 b=HhWGRd9q57mrtEA0Phe88AQx3DUHlwNR0bsH308I9bObNKxbU/6MXkew/aQzT+gEX1QDey259Ps5fieKgBNGvQwNmWS9HN1a0cvsF2H9ujuT7xQS8L0KdyQFwaPCV2FC4S7tj+40/BTcWweekjJTlOCyGNbZJcCLbRe+lXqXIZA=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2636.namprd12.prod.outlook.com (2603:10b6:5:4a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Sun, 21 Jun
 2020 15:33:07 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3109.023; Sun, 21 Jun 2020
 15:33:07 +0000
Subject: Re: [PATCH][next] drm/mm/selftests: fix unsigned comparison with less
 than zero
To:     Colin King <colin.king@canonical.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200617155959.231740-1-colin.king@canonical.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <feb9dc72-c6e8-b745-ca90-b4ff7021d7bd@amd.com>
Date:   Sun, 21 Jun 2020 17:33:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200617155959.231740-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0039.eurprd04.prod.outlook.com
 (2603:10a6:208:1::16) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0039.eurprd04.prod.outlook.com (2603:10a6:208:1::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Sun, 21 Jun 2020 15:33:06 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 231c3103-6f5b-42ce-572a-08d815f86583
X-MS-TrafficTypeDiagnostic: DM6PR12MB2636:
X-Microsoft-Antispam-PRVS: <DM6PR12MB26362070163314522C9656EC83960@DM6PR12MB2636.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 04410E544A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UtsQSZzkXTL7rpW61lR26yC4igpMykH9F1v0wPpVWCLGqSsvNelVa9GcEl3dnK1IFuWI9dxo71kMrSu+IxdUMdcRWAkZD3E+J/SubHnVRhtnfa4izm7dJy1lJqsUObH9Hhfd+aGqQJNDkTwYGP0zAX7tp2go0hRLA0d28iMgxLLa3GoxJGcHNoCdBow0uCgzSfXM0dhm7RjVReTPFj6h7QhmC9LuRYJVA4wkeInMUL/hfTswbKpejuO8HOMLvuNeFlsM0fYXs64WTREg/zS2ArVw7weO+vOELwbSLcSXGCrSeYO3ni/1aaAVtu/BLV0mefK/Dt/S4EeGojGOrEHG0ci2IEHTcrDiQqSsmCLka+T8gPN5MTo7TReM8Vg4N1E4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(6666004)(5660300002)(31686004)(66476007)(16526019)(86362001)(83380400001)(31696002)(8676002)(110136005)(66946007)(66556008)(478600001)(4326008)(2616005)(316002)(52116002)(36756003)(2906002)(186003)(6486002)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: b+Yt8FQsPD4KHLkzqbG96soN5ml7cdsIn66kpeVe7lLppTvpie8mq/oOMbx09SwZlib1JlogYEJbNfeULEdQ3tdmUJcMYuFdve2sLXuBd158pHYSF7JPlyfIL0vwe8MKdyaHESqrZeo3b2KrHlHV+olfyhbb1t6isGAGUUhHnZ8CUoypQ77LSOthilVrhaLxSqEnqrMc3g38yibOUgKAYsv6IsLz+65Ge4LhoCugrOWYMWeGntHr1b4eb3kDpodoHXYtMIgSaYN7pL02pPW2Q4jOo3augXVxT/I2+NMhRQb6BSupo5OWuTr75ALRRYChYkEp5o/17U3/KO6y1r8CEiGq9B9n1N8vO3NzNNTd2bSI2nltxijlcVUxmKmdoDGJt0r/DsCiSPnxMAtGgX5QM1Ctcd42hH4dfjVMuyD/hZxFchLyBwNNmG02F9o5WTRuP0yT/6QziWZSa+VQ52txla1MiviA1rJ72+dcxUKiHFF3Go9cmL4eZRwTmH4UKf+hGmeL1p1oNPlWHshzcHOlQtF6ng940OGIjNLS+YYMpcE=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 231c3103-6f5b-42ce-572a-08d815f86583
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2020 15:33:07.3806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgURX4q9ieFkDS5aqDyx5hMe6cCzxNTIAjqGWcJAU7mCG9VE5aFYNQwMY5bWoE7u
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2636
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.06.20 um 17:59 schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
>
> Function get_insert_time can return error values that are cast
> to a u64. The checks of insert_time1 and insert_time2 check for
> the errors but because they are u64 variables the check for less
> than zero can never be true. Fix this by casting the value to s64
> to allow of the negative error check to succeed.
>
> Addresses-Coverity: ("Unsigned compared against 0, no effect")
> Fixes: 6e60d5ded06b ("drm/mm: add ig_frag selftest")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

Going to pick that up for drm-misc-fixes tomorrow.

> ---
>   drivers/gpu/drm/selftests/test-drm_mm.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/selftests/test-drm_mm.c b/drivers/gpu/drm/selftests/test-drm_mm.c
> index 3846b0f5bae3..671a152a6df2 100644
> --- a/drivers/gpu/drm/selftests/test-drm_mm.c
> +++ b/drivers/gpu/drm/selftests/test-drm_mm.c
> @@ -1124,12 +1124,12 @@ static int igt_frag(void *ignored)
>   
>   		insert_time1 = get_insert_time(&mm, insert_size,
>   					       nodes + insert_size, mode);
> -		if (insert_time1 < 0)
> +		if ((s64)insert_time1 < 0)
>   			goto err;
>   
>   		insert_time2 = get_insert_time(&mm, (insert_size * 2),
>   					       nodes + insert_size * 2, mode);
> -		if (insert_time2 < 0)
> +		if ((s64)insert_time2 < 0)
>   			goto err;
>   
>   		pr_info("%s fragmented insert of %u and %u insertions took %llu and %llu nsecs\n",

