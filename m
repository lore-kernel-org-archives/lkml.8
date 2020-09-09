Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B01C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 394D520639
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:48:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="GCp5gTQu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730376AbgIINpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:45:50 -0400
Received: from mail-bn8nam12on2063.outbound.protection.outlook.com ([40.107.237.63]:40032
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730315AbgIINVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:21:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pf1hQfwlUcHoSi7lgaSrKV7Ea1iEC7ZByGuKLCaeesqIVNY1B0h05gMHFHZ+Dcgbwp1qIaAsjXOrGErVvs4Laj1vEi3OaYl2hrHAu8le22nsJjKiL5VX1uHm3fq7YhIC+UB76pB+ztPDaH6wBkblTINoJDByASrwPZyHQaa78UXnEHCJEXnALPtvqT25coyGeuUI2qCqiSPHalxMvk7PgBvtAdd2XMCtS6I2qbYhSfNKzI7zjZ0I5RRs02f2fPoAuELkC5ZpPODRbWcKGPGvcu5pAPRgJVTGz9UbgNoRERkYLOnkE/luetCdxiCgYP1FmX0xueAl+hK21ro53qcCzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE8B12hjl+EP++ANTKTRBHHsv5+tKdZL0SuM0xwu0bE=;
 b=RilyFKVJmf2x+naoLaHV/6vMWQP3h6PHoKEOp1cfUHoZd2zrHO3tu403cDVNbIIa37VysHzZjygq4aBSlZhcjvIBzETA9QA2A6Jd6qMRmnnTxL2STOycBgdMywcoJdCg6z2EEEBM1oBBgIlRNmFWoqSYrZulhIA37brBnVFQUDf+Yl2sTQVXQUuB8n9UTYJ+fr8gbNqBvAoV5s0CoGf5soY5in0fIiz5ZjUErIo5pGLtX9sQ/XPD569U0kHXLHd4V2WCmwnA6nJhSpdgeMN07wT3b+YJZALyrVAz9Ol0JXJbcY2WlCvR0gaMckChcxeWbiLEN1YotJ6YLvM8k7IN/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE8B12hjl+EP++ANTKTRBHHsv5+tKdZL0SuM0xwu0bE=;
 b=GCp5gTQu0tg6V8vmfXYfDjy9ujWR06T2ywOqATKL/DHs6RmT6EqL4zAIHGlrq7plsSWptQnzG0/wo0iBdrQT2OL1nM5c+SF7FdiOBm4f3VMz6xdWUcTJ2EDd6z6dPEQ0Cy1s/0DKJ07jnbDfDawbErzYm5pIun7rg+YMftFigdI=
Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=amd.com;
Received: from MN2PR12MB3775.namprd12.prod.outlook.com (2603:10b6:208:159::19)
 by MN2PR12MB3680.namprd12.prod.outlook.com (2603:10b6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Wed, 9 Sep
 2020 13:21:17 +0000
Received: from MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60]) by MN2PR12MB3775.namprd12.prod.outlook.com
 ([fe80::f8f7:7403:1c92:3a60%6]) with mapi id 15.20.3348.019; Wed, 9 Sep 2020
 13:21:17 +0000
Subject: Re: [PATCH -next 0/8] drm/amd/amdgpu: fix comparison pointer to bool
 warning
To:     Zheng Bin <zhengbin13@huawei.com>, alexander.deucher@amd.com,
        airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     yi.zhang@huawei.com
References: <20200909130720.105234-1-zhengbin13@huawei.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1fce0f2a-3777-e6d8-5a09-30261f843cfd@amd.com>
Date:   Wed, 9 Sep 2020 15:21:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200909130720.105234-1-zhengbin13@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0111.eurprd04.prod.outlook.com
 (2603:10a6:208:55::16) To MN2PR12MB3775.namprd12.prod.outlook.com
 (2603:10b6:208:159::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR04CA0111.eurprd04.prod.outlook.com (2603:10a6:208:55::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16 via Frontend Transport; Wed, 9 Sep 2020 13:21:15 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d9925a6c-91c3-4284-8a8b-08d854c33ba8
X-MS-TrafficTypeDiagnostic: MN2PR12MB3680:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR12MB3680CA3D50231FD2E90A83A383260@MN2PR12MB3680.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:157;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TGjK7B6cNMRNliSB0TNEr/zNl41SKhz+ClYs8YFRHbFfiThEtg/Se04fj0w8hH1RZrB5mfjIhFK7w49dQS5OmUov5pLloNYqEUWKDLMZ7HF3sg3Sx22DO3ZvD9JjgHGhX9DE0FujSpGeErCkZ6A5IrRCtbX4L8G+y48qnAJ0sh2EWYoRcHp6gOQ4Qun0FBenmx7M3TDDcBVM/hMQjE9PYWckgu/0SSKdENoy5bHMRvnhW7TUSyf7s7BoaqZ63Q45fZB37YVHuuuE8KELUH4ztnehnjBnBwB/vyXygcLNXus0A95HJO/UkmKveQH+EmrBPQZUoC23ItayKH0DhngXVsnrJKxAvNNRDoQfxAk1DMSOby2jJdY8d0P0dYMzZoTA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3775.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(39860400002)(136003)(376002)(346002)(66556008)(66946007)(66476007)(8936002)(83380400001)(5660300002)(52116002)(2616005)(31686004)(66574015)(186003)(16526019)(316002)(86362001)(2906002)(36756003)(31696002)(6666004)(6486002)(4326008)(8676002)(478600001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: vsWInmPmX5SdnqUVXP0qCkdcbiGymky08AuduoFdr43D/biDFf/EH6wZ68lh7k6o4xjeG2LqFG6JdIWRGfj+En+Ri5jCs7/1AGxQcQLD2AWhRHH8WKzolcgfUmAMHbkBkY/nNqnB/C+fF07pNPIbDpBrxiFGDvvFqRuL6fTrTM+nwGv6/1j6kCSj8qdnF5QGkp6wclaknChNh372Ijlw7j9N2tg5BVA5iqNRxvSIPaya9a1+pGIhS8yaDVZMBGoO3LEbPsxfWJPoEtTh8eKllYJRy3+dyMdy363albhEgLb0IKp0/CZywCTNGqzm24N2ogNDhVgQLRltlue+eMfEYrQJRHQybWEtMwHMF6VoGtUTXMxDK3pM+doC1E+aVkYJasaKEMgax0D1Q/c1wrDTmeFCJXhUP5Pi0DDVURoxI9ihYkqG/aZcBjdp0ZJKEZ0WSxFif4YScxZWK1xO4QJ25NQspO8/ofIMD5xZYD3fnzxw3WM4Q+KdqJqVQdnq+A7CQn6eAaBaW90qt22NmiLrR8TCFwcI92lj1/XLR2qz7geKSAmm/7JQfVCFKSl51fydcQ+i1e38ZUMkn5EZKiXODpAvFlFC6SriD9t6wSLEwUeJkgcBcStr472OUaPvZKqbI90bP/FmbaBvtzONIsqei6cb5tqg74IlFEvjkxHEHev3OINB3oc8BOYR/AccMPAK6Aeugt7EYzOSUc6gbN/EjA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9925a6c-91c3-4284-8a8b-08d854c33ba8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3775.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2020 13:21:17.1870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHcwXG6izNJaiwMfbgLynBOxcjfbW8GnECRlWjw3Tb+MfCqkXxXs51W5g5un7UIY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3680
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Christian König <christian.koenig@amd.com> for the series.

Am 09.09.20 um 15:07 schrieb Zheng Bin:
> Zheng Bin (8):
>    drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v9_0.c
>    drm/amd/amdgpu: fix comparison pointer to bool warning in gfx_v10_0.c
>    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_0.c
>    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v5_2.c
>    drm/amd/amdgpu: fix comparison pointer to bool warning in si.c
>    drm/amd/amdgpu: fix comparison pointer to bool warning in uvd_v6_0.c
>    drm/amd/amdgpu: fix comparison pointer to bool warning in
>      amdgpu_atpx_handler.c
>    drm/amd/amdgpu: fix comparison pointer to bool warning in sdma_v4_0.c
>
>   drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c           | 2 +-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c            | 2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c           | 4 ++--
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c           | 2 +-
>   drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c           | 2 +-
>   drivers/gpu/drm/amd/amdgpu/si.c                  | 2 +-
>   drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c            | 4 ++--
>   8 files changed, 11 insertions(+), 11 deletions(-)
>
> --
> 2.26.0.106.g9fadedd
>

