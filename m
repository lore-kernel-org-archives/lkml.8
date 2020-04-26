Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6BDC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1BAEF206DD
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 13:18:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="usbEZ432"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgDZNSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 09:18:15 -0400
Received: from mail-dm6nam11on2066.outbound.protection.outlook.com ([40.107.223.66]:6135
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725876AbgDZNSO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 09:18:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RBkBHiP2BjWONxqU+dFg5nz+xnDU8TEDLa8dfSbdJrg2OkO39PF7USfNLrGSOgFcMU902ie8I8FMzI/kAdoktj6+Q3QCzqeVI7f0/iNHgy/mPFs+0G88AE2tz8vAY65EfYupwHuWFkhL4uV1ruWEsIhisC9o9I3KMsPWtGIJ//gBcq5NVpggYDYXIePApxaGhX+wzN/oLqyjxJXaCjRcFLXbXXYZNh9gkmRNqq0gdhfRnYi7mL1yLv/nJ8NqaF24/wI23etvMwheYwr1hNCbvQGAkukwSKQ/7IyRgzLdS79nAhMLdYkDU2wuEVa7iefuFAlnAsYJJHP5c5lJlFK4dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO6e4ZtodShY2HEZNI7EXf+JL1LgjNf7dDpoh/5teKs=;
 b=Un/KyI8wscDAxOt9lzpLfIFlqzKeUdXnpQm3YzzBSzfepOPHRKYwMhMtJeyEg8Eu+Y+xH+LFrQ1KSeBlJcFXCD5A56vi0iIxSi0UZ68Zf4Jt6iBAVQlcTw5z4Po0cy+/vQy8tocYVfI06W37BQBE30rm+wGQw7EpxxcclWSnX2qpGtZp38myBF49G9I2V2S82Dq2Z6gCXbFYGcR28GXTDoDbipvadi/plfTSmBo8xvQomDDTszpLB3IvUpHgendGtDz9bbbpFXgLV9mWzgG9GkCqqG0QDkCWDHWwqvMKShns1D1j3hBbHRz9X+ncloGPc87eNYfUNZQ8PbiQb7tcjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vO6e4ZtodShY2HEZNI7EXf+JL1LgjNf7dDpoh/5teKs=;
 b=usbEZ432eR3FJGnW/vKzN8X4T93x386InHy+tIRTeNuSMH3w2qjk8DPi/nV6/+bvxUzYJrKms+JxhvtfrziFf0EB6xCYHcZbHwg9BuQ7WXQytcpkFzwW2Ik59xoM9V9teH1ALmk5kQYoVuJ5DJUYApux81lJK+nPKthAcbT8BWo=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3644.namprd12.prod.outlook.com (2603:10b6:5:118::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Sun, 26 Apr
 2020 13:18:10 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.023; Sun, 26 Apr 2020
 13:18:10 +0000
Subject: Re: [PATCH] drm/radeon: cleanup coding style a bit
To:     Bernard Zhao <bernard@vivo.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        "David (ChunMing) Zhou" <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20200426131244.22293-1-bernard@vivo.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <2c67e29b-df17-6ae3-cb55-af950acc022c@amd.com>
Date:   Sun, 26 Apr 2020 15:18:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200426131244.22293-1-bernard@vivo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR0501CA0050.eurprd05.prod.outlook.com
 (2603:10a6:200:68::18) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR0501CA0050.eurprd05.prod.outlook.com (2603:10a6:200:68::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Sun, 26 Apr 2020 13:18:07 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: a005e825-5218-4a79-5cf2-08d7e9e44441
X-MS-TrafficTypeDiagnostic: DM6PR12MB3644:|DM6PR12MB3644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB36449C9B670C62FB058390E283AE0@DM6PR12MB3644.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-Forefront-PRVS: 03853D523D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(376002)(39860400002)(136003)(396003)(346002)(16526019)(186003)(86362001)(66556008)(6486002)(66574012)(4326008)(66946007)(2616005)(5660300002)(66476007)(6666004)(36756003)(52116002)(316002)(81156014)(4744005)(8676002)(478600001)(8936002)(2906002)(31686004)(110136005)(31696002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QWw2PpYyuciuVk3cGIEgeY7xzoiNe9Vi9N1N8X9t+5rv9sSiXByyl4DiuhvDsWMcnGGpHi35CLuNPR70Hi3LqTMHj4zerm3sRjHVvxyjESEXeRDuCm7pCqsnC2vsizI+i9cUhYB5vHd0Mz4BqCz7WW9F6/645Gr/EfvJA0tPrloCyWviEtwXGC0Pkhrqv/ulJiSWyidTtM6OUVVK+n030ceX+2zocSXmDbo6a1jxTEbAdQ8/UQ9jDI7t/CK7cbNtOa/9SyvVnZCfvmt1EeDFSsBtd1aLe/JYA8CyARzBRaV1Hy/kG6lpLMRneXfdIEYt2zNApOSQJox++WBhDjNr1r5w7dEnUIKPuiKjnxZRMpBS9JeYgpspD3l15h1OEV6hCYoeWFseOimOleWGz/gU4v93/zEJBV5pLBKuFTgBQvpCnM75hGz21pJrmx9Emutx
X-MS-Exchange-AntiSpam-MessageData: aH2PeJNgiH2RMtQwUxU5tljGVHFpxDNAELO3yhrX9rqDLY12dSax1FTaw/tyBhstFc5zqDj1TGU97XBBIH3X6SxRfIA1efdbDi8PBUwY6VK05VHlo52/gqtbKVZU661FYq1j4qPTRW9Q4GyVAJGx3ZyJEtu0Q/Lq3WNDuyKDWmrGEHUGMkEw8TF1osjO8g2wkt01wkBlIIr2UrEK7retSwPtfmS5fAU8HtwCIURxeDR4brEOrQiV4oekAnoo5bjJUWVi3NbzaZzHP6pxlr4amVH/t/cqZtqQWnz59kPKA9dT4TbnEBYmS1qQ2aXSBWnr583EhHx3SGwhbMokXNorA667pEx6txcDdyZiLf3VL6ihsUSqQCtfPczrmlGSKclJ1OZyWHOX6Lx6yVLFsz+bgCWH8pfenR4ZXNCdljVDXOO5KwUJyWaBOLwwg7MB2oqrgW1Nwjy7hAs6nYr9pKV7iZgp5TgDNGEN/1rrkDpadxqp2j6WSpdS5akt91/0pclTuzjJAtlaOkswDpppEt3e42cBhk3kfc0yUjLIC8VTJpL0koaFdGYCv/KQ6lJt9xS5LfWklJEziZgWWk49d3FVF+UWtMxMVtCzIqTCQ6IYcjrmNU5RQdgnElQNPyZIIwg/QE9IrQUJrAhOPwCu0qkOOBzZMaxIbKf3lvx+aWozB/OflzM6DivZbq1Wr5y7fQWxp5hp0+z8JsuNf0U9xG5gvd7tCaH+uxyT9OG4xZyOvOjp4kzSFelxMEVGYhFOydxPW2MBkN+gdKA03/QlcLwqxHyD/yFBvPlFa9eVZEPLpgOi8qb9tPfJrcAbZmtHsQuz9AxB9+AQ+krRn4j53etfUuTKdmnYR6NA6Lgu7hD1fMQ=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a005e825-5218-4a79-5cf2-08d7e9e44441
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2020 13:18:10.5354
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5uc8ooFOhbLcM10khesAyCZrltVlneJM4MpuialKSKyo4dUQ28rE4A8Fow3qtMrc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 26.04.20 um 15:12 schrieb Bernard Zhao:
> Maybe no need to check ws before kmalloc, kmalloc will check
> itself, kmalloc`s logic is if ptr is NULL, kmalloc will just
> return
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

I'm wondering why the automated scripts haven't found that one before.

> ---
>   drivers/gpu/drm/radeon/atom.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/atom.c b/drivers/gpu/drm/radeon/atom.c
> index 2c27627b6659..f15b20da5315 100644
> --- a/drivers/gpu/drm/radeon/atom.c
> +++ b/drivers/gpu/drm/radeon/atom.c
> @@ -1211,8 +1211,7 @@ static int atom_execute_table_locked(struct atom_context *ctx, int index, uint32
>   	SDEBUG("<<\n");
>   
>   free:
> -	if (ws)
> -		kfree(ectx.ws);
> +	kfree(ectx.ws);
>   	return ret;
>   }
>   

