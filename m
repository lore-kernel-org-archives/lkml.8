Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A0C8C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4CE22074B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 07:14:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="TmbOSlFf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbgDUHOg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 03:14:36 -0400
Received: from mail-co1nam11on2079.outbound.protection.outlook.com ([40.107.220.79]:55264
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725992AbgDUHOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 03:14:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dtDVAJZ3Rw5UqFGWpgXgs+PFTQGQhsEPEWp6fqrLXS2F2BcexERZaFVk9JT4I91NJdSfnamBkLWDqtIH/4nHiO0MluxQX9411TUmLtE6KTn8XDh42Bp99cwCtbUuIMomC3Lps3OirZqv2YtGXS9UYrMHA6PTDeH/fD/IvyqW3GyPXVmpKf2Tj89KaIYOT1XjvVPPemYGxsw6AtetarJ+lGk7IEwx7nAvoThYlFvdlDLf0KiNXdEIFgOokpZ8GIPafCB9tqmLOieTufnFSG7DPQ6Qab8UOu405voCGfrO6EkV/m1ZECYoWYXYFM+QyIk+c7zb2CzpS44dnRdN24fp3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ltdoucZOITdQbh1fX2vCxgIh/JmWzB4cOdFlPR38zY=;
 b=esceFaTScoD5k0lCC2n9Na9RrX/u89c7r8HLy+Lt4Ql++i//D7AGvvcBrnAn9NPWQ0ajZgc7CrK+AMLMCjefYiCb78R+W31q88AvW3EJtmTEjUuKx5oet4aL+5pacwZCq9VWyWZQbQlyuWUgqhqwNkPIZG7Dfj2DzqhULNoie6dqNHyx/+Qb6UZ2fziOUik40QKtcYsCuGCHJVuog/fhCo8Uo8uaTm4nnk6tM34/lHAZMFFMsL2wgrRA6UmPRXJhnvjM3/yPtRIxUNr6+U0o6/DZWKeryzqnu7ggNJMhN7Q239AvDHEmpTnIeIWH3vMYG2JrIhUrNi+m3sRkt1Nbsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ltdoucZOITdQbh1fX2vCxgIh/JmWzB4cOdFlPR38zY=;
 b=TmbOSlFfiZ5s4ptIAnY0FbfTrUZw20fgnAJAI7kyCoFhhbqap/sbgwL5tda91OYKkfekuqc4x/zmKngdryTdfxOegU84XvxI0sumkBHvsga884fyPQjUVYAgZVc5hbh+5od0HHwkh8sgj97PUhX0wgJnR6tYSWcVizA45Ao9kiA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3851.namprd12.prod.outlook.com (2603:10b6:5:1c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 07:14:33 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Tue, 21 Apr 2020
 07:14:32 +0000
Subject: Re: [PATCH -next] drm/amdgpu: remove set but not used variable
 'priority'
To:     YueHaibing <yuehaibing@huawei.com>, alexander.deucher@amd.com,
        David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch,
        andrey.grodzovsky@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20200421024125.29992-1-yuehaibing@huawei.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <c6166e9e-46e1-5e4f-e93a-a3c170e81efb@amd.com>
Date:   Tue, 21 Apr 2020 09:14:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200421024125.29992-1-yuehaibing@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR07CA0018.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::31) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR07CA0018.eurprd07.prod.outlook.com (2603:10a6:208:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.6 via Frontend Transport; Tue, 21 Apr 2020 07:14:31 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2071363-c7e7-44c5-50c5-08d7e5c3a3d4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3851:|DM6PR12MB3851:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB385156250AEC159E52E0FB8C83D50@DM6PR12MB3851.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:49;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(366004)(136003)(39860400002)(396003)(346002)(376002)(5660300002)(66574012)(6666004)(186003)(4326008)(316002)(2616005)(16526019)(66556008)(66476007)(66946007)(2906002)(6636002)(36756003)(8936002)(8676002)(81156014)(6486002)(86362001)(31686004)(478600001)(31696002)(52116002);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zZcie0BHmMkOQvfT+2hm7jKlMLxOtK7C5XkUx2WRLnQl9Yz6ga+DFs2s0bi0igeMu6Qn2wvLy9/SahDeO9XrcEMe7OXnthgfMQ71Y4O+PkIV7/Fn0HlSFSiVLZAcgOyXNEdMYLdOAJYp+ygnB4xzI0hgvxAhyzx/mbha5MD8DucBp/8TBhx7vn3FHDrNry7cgT+XsRzCa4uof1eoXqxYmOkmH+qjLZ4HgfAO48IFcCqjB9sOhnfRG8SMevz/rRuAFNtCTYtBh3D6BCnTqQD0YC+lBw1ymu+0idQoIRUBQJrKVYxEMZIMlnnhfnhdgwP81UNinF0wW5ZmSTf15zXIlU+JVd2xn5lcp/ID8LXYHDwBHyGJwRzBEoPE9v0PAF7KEMir8hN+xeQG9rbKPqN8Cooouc/Nwsv8TGpJlrBjbuDFy8d30K+KUF4/ZKHhak7e
X-MS-Exchange-AntiSpam-MessageData: Lj7Uq8lbQ8PgP/bBM7MW9icBAftF9EqQn2pzSWLv8FZQBZ9G6amJfUqqy2lNyzyvLTMgTvfBr1UXuG0/4k/iWr0EgcFCPukey52ul/uYA4n4JeGhdmG+TBWxtsCgs9A2tWoUXh/okrGq/DgHlMZ9/qOdHjwpUsZe8CQqKJIE5woRQtwB2u4uFZLKg8qNa20+LjK2ARaC+7Q7svAYCaIlmgb3tttoBNOFpJ7fpRc0yxmfHHXporZhwjBggH/sxnBZP+Q9q90KWkfEc+3v93fI0SO8QUCbqe9Gbg++dkpxJ7y7PQCECvR9GBwVhR1qSslk1I0IBqdzMrxJEGtt5KpB935Yt25b/iLyVNhx86dpGyYXfvaxrtyA0ff3iGCMi37ujxWlHRxVh8XNtgq1Ir9EzgiVZrjh6pe5yx2UUsXmU2RVzPAFJN4sM6UTxDsNaiKPKjNkf6Egdqq5skEHaxYmYHEJZOdahweaQBUnWiw+oQz0peJHAguEWlzw7TpQJEa2w8d4NqthQ/NlNVvVAVDkRtOnbL+t+77cN1Kfmn3i81T4T5bxAMnECvNNMpXrY3y0yazFUGkGV6+W07zg0t+AwJkoPudjU4DjEIqnkw1tDgIG1s8oJjSHMkXiCRNytdq2q0IWKKwMCcaQr85fqOkrTLxpDq1Ek6pEIvH0PC9iNieOkkuPhwMaXBOgS1nQKsFmjEDSo0zQ+qeeFVDWufybZzHTbGEij4JeJoBQb7hE3ne6BZhxqbtsk+nn9TzImbTF8ezyMTkn79U5/rzzv1MgiY+kYnQrk0Ch0ltAjA13YaJ3+sOisWUY+jPkKaT4rKDQzw2686mfHIl1Js5jGQ9JuoHtgNzdan1yueE0rSX3R7w=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2071363-c7e7-44c5-50c5-08d7e5c3a3d4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 07:14:32.8508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaJ3wC+x63XLjZ+Vxuefvo196A6+X3/DGpTgILskmealbpcyi/LufiYdIkGeSUEZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3851
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 21.04.20 um 04:41 schrieb YueHaibing:
> drivers/gpu/drm/amd/amdgpu/amdgpu_job.c: In function amdgpu_job_submit:
> drivers/gpu/drm/amd/amdgpu/amdgpu_job.c:148:26: warning: variable priority set but not used [-Wunused-but-set-variable]
>
> commit 33abcb1f5a17 ("drm/amdgpu: set compute queue priority at mqd_init")
> left behind this, remove it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 35c381ec0423..47207188c569 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -145,7 +145,6 @@ void amdgpu_job_free(struct amdgpu_job *job)
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   		      void *owner, struct dma_fence **f)
>   {
> -	enum drm_sched_priority priority;
>   	int r;
>   
>   	if (!f)
> @@ -157,7 +156,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
>   
>   	*f = dma_fence_get(&job->base.s_fence->finished);
>   	amdgpu_job_free_resources(job);
> -	priority = job->base.s_priority;
>   	drm_sched_entity_push_job(&job->base, entity);
>   
>   	return 0;

