Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2A7C54FCC
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:42:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47B172080C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 08:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2K4NEw3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgDTImY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 04:42:24 -0400
Received: from mail-dm6nam11on2054.outbound.protection.outlook.com ([40.107.223.54]:53994
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725773AbgDTImX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 04:42:23 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wp2arRIEIq0PINB5d2XUS/5m9sDFI7If5aHTp3RZ2mVM1ImP/2TekTvPpNH5jtW8Bq8t0sMllieZ0J6sj1wFsNUbnqwYRysPzD3+stBmSEE/Yfo5gmYFjSP1vt9JQAqExyzhKwQyk+bcfDAWaqqk1MxSBr0ne/nIU0gTkNvqmd5mWrN7RvX1HfeEbmsMCDBinY+ka0Fx9lnCdH2B8mqr7ulqWRgu34XKctss750gG+K9uYTbTol3AXSuEz6vHVdyirFgNKyp9gsLdJb1p018zKBKl1ptvRlKje1d/PAoLAdlcpT+BYocVG0pxpqS7QMQUCj2U6IxAwemJxfGiy7B4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLjunkOMTujSsQJr/f8gk5IQLC5TKKCawDBQAt4Wo8k=;
 b=odtRPbjDcQ38J20t+1FR8UrzbUr+Ms8GDCuPrjZT7syIpArDMIRY30TSVfu2SXZKlb4f3ADy9hqFP5jFl5l4BFGI9DQzAKQtWQwp6XRXUYBldvywIo1uZ6AA9jAF8L1zgcaWXFonOZl2XY7McJwYJ8MFSzyVUkWEA8QCETkfQqIWjgMH3yRutN2gbyYX3IzkC2haGovOV1RqDgp2NssyM/AW8ykroaL72yjHu+5uEqcoj5catvZW5/veErHCKBgNo9wJNpPA1KWahIFi5ge4V73C6v+hEYZ7+Djdn+a161l8UXeqsH45Tw3EI2nnZrZrmpPIqBERsXABPX6I9SvQrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLjunkOMTujSsQJr/f8gk5IQLC5TKKCawDBQAt4Wo8k=;
 b=2K4NEw3C2ccRpPr2EraG/OYqDTOPeUxzql3jPhGKhSbExMe46hfUfvUwkGq0ovLkMlBeKEap2NnwAUT6VjEUs6ijqAOUjhtAGbWen9vGBoQrmioKEoTJH/dNN1VanbiVyTFOr9/qKXbgWAkrmV8rpktl5vcFSa1MBFEugtSNqU0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB2986.namprd12.prod.outlook.com (2603:10b6:5:39::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.29; Mon, 20 Apr
 2020 08:42:20 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2921.030; Mon, 20 Apr 2020
 08:42:20 +0000
Subject: Re: [PATCH 02/10] drm/ttm: separate PageHighMem() and
 PageHighMemZone() use case
To:     js1304@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Laura Abbott <labbott@redhat.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Minchan Kim <minchan@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Huang Rui <ray.huang@amd.com>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
References: <1587369582-3882-1-git-send-email-iamjoonsoo.kim@lge.com>
 <1587369582-3882-3-git-send-email-iamjoonsoo.kim@lge.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <412ea2bd-1719-c086-b3e7-64eec6e2bdc4@amd.com>
Date:   Mon, 20 Apr 2020 10:42:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1587369582-3882-3-git-send-email-iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a::22) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by FR2P281CA0012.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:a::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27 via Frontend Transport; Mon, 20 Apr 2020 08:42:16 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3b69fc7d-3552-4bdf-e478-08d7e506bcf6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2986:|DM6PR12MB2986:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB2986BB630A10B5E8EBD1F7EF83D40@DM6PR12MB2986.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 03793408BA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10009020)(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(316002)(478600001)(31696002)(86362001)(2616005)(5660300002)(8676002)(4326008)(31686004)(81156014)(8936002)(2906002)(66476007)(6486002)(7416002)(66556008)(66946007)(186003)(36756003)(6666004)(16526019)(52116002)(6916009)(54906003);DIR:OUT;SFP:1101;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vh3wa98Vj9ha5Phk51yJRug1CIKrX9NgXP5/+qxBnhRf/a7L2mJjbx4opWk5MvF7Tj9L897SwrvivUVa9rsR1KG0K41OBwZL64QlGR2AC1/loB/wX1epdeRXnygfWlZBs/AUBkhSk9T+BE/gabiY2usVNjwGNjKOx8wiPQbFrJZ+/F0YO49jSv+bIGVw5SxDFjbN9P6xU4MBh4d1l3pn/pP89v6rXGajUI7oZcpk5eOJrAeMarNBs7oc1sAxhwQKm/1zWWR73rTRnFH3xg3E9MpqmpUxpIzevohjWdRHyJNqDdlLWYFSucSuV4+kd6UfdZcaAEFH8qM7Kqi3DcVwxRpZgyTVowGvvkN3muVw/tTpwVS6ciT0W456JO96BC7xHIluEI4OIerlfmpKEXarQxrMH1N82YWVU9kuxMc9Kc2CWSLbZtm8k4w80UMovlIm
X-MS-Exchange-AntiSpam-MessageData: ER6FbkZcFJB1JRsECEdwvm/t9ijo13NwCdGycv1lp0O6R9ZZSQi0CXMbPTqEt08NqvR5ZRHPT5VeFPfrYGyHJJSbqNew1Mc+toIiQgKXSHz4dFKCtE+BwnCtkrHezv0BV0Xc25oTni+2sZVW05Ko3Ei9VKiw6d96XH9F0yNElMM5HwPVYZyqPKrPR9BySRrLvZdMp2cKYzcNdItao3R3fCHAHpqO0UbQk3o4r1ErGlvf4LrISOjYLh789soLhA4gBH5eYkUlvXAJNDCYhsMNEC/jxErPjrlnURPxSc9QCjdotRf9iLLZ/KjXoE1XPd4gdnQbvTBGvfLL6XHbODELOnNhEQxD2HQzT8++uGb1imyGKDvY9YkYuqzCH/69rAGXK7skU3ptHYBU/hueQDVnh4gb3kI+Z0aGTLzwlZPCKRAA4OMI5QFB/P1m6KzvLzKKhihKQ5vYgvtc6xKM5JA2UepWetoyQEpDxA98YnroPNBGjoi3zuVKTRqxZUt74Sj3+5MtKvFug7CyWLYNa+rJBoSSzSwmHIcAF0B5KfR9+lAEjvXKicbqOESRpfef5dWZ6klmyxQ4ByuAomeD10xpQOOgud6CY2HiEsAt1Rlt05E0lb2qQXZZENKKozOqmYY0+782a0mMo6j2hPkiExz1a4y//P7Pw0Ux5syP0GNQ4rf7zNu9QRbdz6o1/h5TQvhW8535DM7Codn50WeLh6GST8OpIUGlKolHa7khsCOaXCc0Bj5gBMq0egFrnZW31poHtAoYjnAq52Zy/Ea7mfHCtnKCdqcbPo2/9lsmG4XqPhANmUL0zsqFxdGCBZsOKcVw/wJR96oR5xw9Rgu6pwpDR4oeADry15ob5o7gXLEzqKo=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b69fc7d-3552-4bdf-e478-08d7e506bcf6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2020 08:42:20.2152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nzB7US6Z+bTj64iR1l0M7fq9VlIoMNULa78R1oQ2pf9/ttWuoN9rO46D0HkWrmxb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2986
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 20.04.20 um 09:59 schrieb js1304@gmail.com:
> From: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>
> Until now, PageHighMem() is used for two different cases. One is to check
> if there is a direct mapping for this page or not. The other is to check
> the zone of this page, that is, weather it is the highmem type zone or not.
>
> Now, we have separate functions, PageHighMem() and PageHighMemZone() for
> each cases. Use appropriate one.
>
> Note that there are some rules to determine the proper macro.
>
> 1. If PageHighMem() is called for checking if the direct mapping exists
> or not, use PageHighMem().
> 2. If PageHighMem() is used to predict the previous gfp_flags for
> this page, use PageHighMemZone(). The zone of the page is related to
> the gfp_flags.
> 3. If purpose of calling PageHighMem() is to count highmem page and
> to interact with the system by using this count, use PageHighMemZone().
> This counter is usually used to calculate the available memory for an
> kernel allocation and pages on the highmem zone cannot be available
> for an kernel allocation.
> 4. Otherwise, use PageHighMemZone(). It's safe since it's implementation
> is just copy of the previous PageHighMem() implementation and won't
> be changed.
>
> I apply the rule #4 for this patch.
>
> Signed-off-by: Joonsoo Kim <iamjoonsoo.kim@lge.com>

Reviewed-by: Christian König <christian.koenig@amd.com> for the TTM 
changes, but I can't judge if the general approach makes sense or not.

Regards,
Christian.

> ---
>   drivers/gpu/drm/ttm/ttm_memory.c         | 4 ++--
>   drivers/gpu/drm/ttm/ttm_page_alloc.c     | 2 +-
>   drivers/gpu/drm/ttm/ttm_page_alloc_dma.c | 2 +-
>   drivers/gpu/drm/ttm/ttm_tt.c             | 2 +-
>   4 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_memory.c b/drivers/gpu/drm/ttm/ttm_memory.c
> index acd63b7..d071b71 100644
> --- a/drivers/gpu/drm/ttm/ttm_memory.c
> +++ b/drivers/gpu/drm/ttm/ttm_memory.c
> @@ -641,7 +641,7 @@ int ttm_mem_global_alloc_page(struct ttm_mem_global *glob,
>   	 */
>   
>   #ifdef CONFIG_HIGHMEM
> -	if (PageHighMem(page) && glob->zone_highmem != NULL)
> +	if (PageHighMemZone(page) && glob->zone_highmem != NULL)
>   		zone = glob->zone_highmem;
>   #else
>   	if (glob->zone_dma32 && page_to_pfn(page) > 0x00100000UL)
> @@ -656,7 +656,7 @@ void ttm_mem_global_free_page(struct ttm_mem_global *glob, struct page *page,
>   	struct ttm_mem_zone *zone = NULL;
>   
>   #ifdef CONFIG_HIGHMEM
> -	if (PageHighMem(page) && glob->zone_highmem != NULL)
> +	if (PageHighMemZone(page) && glob->zone_highmem != NULL)
>   		zone = glob->zone_highmem;
>   #else
>   	if (glob->zone_dma32 && page_to_pfn(page) > 0x00100000UL)
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc.c b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> index b40a467..847fabe 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc.c
> @@ -530,7 +530,7 @@ static int ttm_alloc_new_pages(struct list_head *pages, gfp_t gfp_flags,
>   		/* gfp flags of highmem page should never be dma32 so we
>   		 * we should be fine in such case
>   		 */
> -		if (PageHighMem(p))
> +		if (PageHighMemZone(p))
>   			continue;
>   
>   #endif
> diff --git a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> index faefaae..338b2a2 100644
> --- a/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> +++ b/drivers/gpu/drm/ttm/ttm_page_alloc_dma.c
> @@ -747,7 +747,7 @@ static int ttm_dma_pool_alloc_new_pages(struct dma_pool *pool,
>   		/* gfp flags of highmem page should never be dma32 so we
>   		 * we should be fine in such case
>   		 */
> -		if (PageHighMem(p))
> +		if (PageHighMemZone(p))
>   			continue;
>   #endif
>   
> diff --git a/drivers/gpu/drm/ttm/ttm_tt.c b/drivers/gpu/drm/ttm/ttm_tt.c
> index 2ec448e..6e094dd 100644
> --- a/drivers/gpu/drm/ttm/ttm_tt.c
> +++ b/drivers/gpu/drm/ttm/ttm_tt.c
> @@ -119,7 +119,7 @@ static int ttm_tt_set_page_caching(struct page *p,
>   {
>   	int ret = 0;
>   
> -	if (PageHighMem(p))
> +	if (PageHighMemZone(p))
>   		return 0;
>   
>   	if (c_old != tt_cached) {

