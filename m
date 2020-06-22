Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35A22C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03F31206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 13:27:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="taZqGJIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgFVN1x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 09:27:53 -0400
Received: from mail-eopbgr750087.outbound.protection.outlook.com ([40.107.75.87]:20226
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728187AbgFVN1w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 09:27:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RDEEC50pPC6iLJGCZZjRBGhq44xviGVSiKBtu4DTt3FjVFtmI2S5wKcG0G73yipzIX6oDU7KZoUbdip3yQiAfhDDwLy7vSD1dw3Basszfmuf9hnoHd6GYQvzrZuRCdvKsN6OwcjPRbTiTF0+Ry+hrXHnlSTyL6wRmdpNbPa+VGBfygso8BxXoUVRQq9L7QuJ2KUgP04NwLwR58lfOhbvjBugPEFppL7owoOCrWpReuY3EtLot63/iOZC7L84IJc9CvcYKNN7W/R86mnkjiOevreFyTCB5rKuVvzATMflehFxiJW7Xs4OJUOuLkZ8FZ7Qc4WBMobSN2kutIvDhaWfEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRYQoZ5H1TPJjWCVT8S5DZS5cjDSG05Tkg8JhBfpSaI=;
 b=LJhDT5KdhFxIBHNmqEVJI67KljrCWUGm4YRBGC40sgbeXR6zm4x/iVvHbi3cxZuOZyIjslhC74rJo9KC8Rud2Ks8vvoAZWyAd35gLJHiaTWXoX220NKBZDIEGfej1Z+PiImoREvDUNjGq7Q/WT4xOzvptk6qaSM5Vur8WCjzgpnKBjKy1f7ueoA2is7Oh0idSkCV/EUrv67JaBR65VUHLTFCBCe9ua1UTFkAlrTVdt5lCRyolCbRBkut0nmJwEReM8hT69OJKPLEfoyFtlOUqXZQPa1HljT8/2hKAHXXuxBx4jEUDn7Qhu2fUDG5mdmmtIeoPsCSB7GonUjCguimEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRYQoZ5H1TPJjWCVT8S5DZS5cjDSG05Tkg8JhBfpSaI=;
 b=taZqGJIhg5TuCs+QwikL85oeuajB+bNzvl3lfLC08pYXkYtjzdv6Uhfslq8EiXx82g1mCsooHctlQD0pyENGf8DnxDpGwyduMB0EDfVnB4JP5w28OqGcPQ7eX5uoDBvLGL56ae40YPOZvVfilNyYNjR19u+G0CMYcSBYm9NYmEE=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4577.namprd12.prod.outlook.com (2603:10b6:5:2aa::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21; Mon, 22 Jun
 2020 13:27:48 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::a045:f8c0:8edb:1ef1%9]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 13:27:48 +0000
Subject: Re: [PATCH v7 04/36] drm: amdgpu: fix common struct sg_table related
 issues
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alex Deucher <alexander.deucher@amd.com>,
        amd-gfx@lists.freedesktop.org
References: <20200619103636.11974-1-m.szyprowski@samsung.com>
 <CGME20200619103655eucas1p28ea4bf59428550217c8962666d6f077b@eucas1p2.samsung.com>
 <20200619103636.11974-5-m.szyprowski@samsung.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <bfbdf1ee-c970-d862-cc81-4712c34b7685@amd.com>
Date:   Mon, 22 Jun 2020 15:27:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200619103636.11974-5-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR06CA0132.eurprd06.prod.outlook.com
 (2603:10a6:208:ab::37) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR06CA0132.eurprd06.prod.outlook.com (2603:10a6:208:ab::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.21 via Frontend Transport; Mon, 22 Jun 2020 13:27:46 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7fcc1676-6187-43cc-1b50-08d816b00e42
X-MS-TrafficTypeDiagnostic: DM6PR12MB4577:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB45777D224B535FCBC3BEB6C683970@DM6PR12MB4577.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-Forefront-PRVS: 0442E569BC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KNl3O9rzf6HMUcZUHlQaBbBLbE3tAfhoinQ2lEp/pYx4nGlAgMhsbZ0diWyE6FkWjbIaeDoNpRsnP/hsdVmsoNkpyseBQ4df79mEYmKfG+oze03JUo7KwidpoOYv5AwUbic/+4ciHUQgObM417ZKLmnFA6QgBF9CzhW98gHOOHVlx2w3w/iHOfJd1FdMzP5shkPnKNOto1xUEaaLXFEmRK6k7yNyaoo9K1miidKaoTrOvIBWPTYR83RjKx74lrc2q/pE9kZ/Au+3bHjF19vfCmPi/LWSDDP1lvPEDZUkveowJe8iacys1aSdlzSm8FXRE5/Ujxb9IYFzOCYwxt3VlaKAKGDFrtq9eBkGze87QJf+zZsGmfLimysttst2SK8s
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(136003)(376002)(396003)(346002)(54906003)(52116002)(478600001)(6486002)(36756003)(16526019)(186003)(7416002)(316002)(2616005)(2906002)(31696002)(86362001)(6666004)(31686004)(66476007)(4326008)(83380400001)(66946007)(8936002)(8676002)(5660300002)(66556008)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: i7pPeDmDKemDS0xqLiBqG4KEj5Hf/UubSHYecnB4kTaelcDXJKeup58XOrbWLf2zQAqgJG4U23FTLHTqqPAT6HvpKAS31yJ+BLlosIWwI9NeLL5Hk0IZQbt3QPnCF/mqhK5gBWm3AaAmdxCcCQ81qKmxKh33IWwzMMEk2118apwp09ZaTnhC2z+ifQsnT7FjIayQSzS2chsTZknLVL5l9AWRBaLsqeYzW7aesaFtkJbtp8Ws8FY2WzW0/l+BYtE1yYG3cEoD3c7Hn+DOxHkgVvnCdCb8g5a1YSowvLjvOzt+rWPIU+vOl1OIoybrWyzBbM2HjzkuXs9gcLirNjN0eB8/RPQojBJIg5d/3GMqrWuPoIOaR4DyzgGHLJIpf7ZGxuCfka7BlCgDADe0xaCWlJI/1Sqbi+mEEJpccygwwngaZXGdhevH6Wp5JRVdWohb8RXC6hrUZpx5ZJw3EQ9ITx3ubG1BBsbVjFCkkTLzGvFfw2XW5CPKb4FVcVmtepMB1FP659YR94ZCrGVuRhg/8DWs/Un7sh5S67t34OB3tfCxCHACYMFdHnsW5PSg6kyk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fcc1676-6187-43cc-1b50-08d816b00e42
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2020 13:27:48.4065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r9fpi1OOFRn6KwrPuzeWvO1lvcJajrPO5QgZWjoG/Y/b2k1Dhe2BoA8mZM6Lm5SA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4577
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 19.06.20 um 12:36 schrieb Marek Szyprowski:
> The Documentation/DMA-API-HOWTO.txt states that the dma_map_sg() function
> returns the number of the created entries in the DMA address space.
> However the subsequent calls to the dma_sync_sg_for_{device,cpu}() and
> dma_unmap_sg must be called with the original number of the entries
> passed to the dma_map_sg().
>
> struct sg_table is a common structure used for describing a non-contiguous
> memory buffer, used commonly in the DRM and graphics subsystems. It
> consists of a scatterlist with memory pages and DMA addresses (sgl entry),
> as well as the number of scatterlist entries: CPU pages (orig_nents entry)
> and DMA mapped pages (nents entry).
>
> It turned out that it was a common mistake to misuse nents and orig_nents
> entries, calling DMA-mapping functions with a wrong number of entries or
> ignoring the number of mapped entries returned by the dma_map_sg()
> function.
>
> To avoid such issues, lets use a common dma-mapping wrappers operating
> directly on the struct sg_table objects and use scatterlist page
> iterators where possible. This, almost always, hides references to the
> nents and orig_nents entries, making the code robust, easier to follow
> and copy/paste safe.
>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>

Any objection that we pick this one and the radeon up into our branches 
for upstreaming?

That should about clashes with other driver changes.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c  | 6 +++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 9 +++------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 8 ++++----
>   3 files changed, 10 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> index 43d8ed7dbd00..519ce4427fce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> @@ -307,8 +307,8 @@ static struct sg_table *amdgpu_dma_buf_map(struct dma_buf_attachment *attach,
>   		if (IS_ERR(sgt))
>   			return sgt;
>   
> -		if (!dma_map_sg_attrs(attach->dev, sgt->sgl, sgt->nents, dir,
> -				      DMA_ATTR_SKIP_CPU_SYNC))
> +		if (dma_map_sgtable(attach->dev, sgt, dir,
> +				    DMA_ATTR_SKIP_CPU_SYNC))
>   			goto error_free;
>   		break;
>   
> @@ -349,7 +349,7 @@ static void amdgpu_dma_buf_unmap(struct dma_buf_attachment *attach,
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   
>   	if (sgt->sgl->page_link) {
> -		dma_unmap_sg(attach->dev, sgt->sgl, sgt->nents, dir);
> +		dma_unmap_sgtable(attach->dev, sgt, dir, 0);
>   		sg_free_table(sgt);
>   		kfree(sgt);
>   	} else {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 5129a996e941..97fb73e5a6ae 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -1025,7 +1025,6 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   {
>   	struct amdgpu_device *adev = amdgpu_ttm_adev(ttm->bdev);
>   	struct amdgpu_ttm_tt *gtt = (void *)ttm;
> -	unsigned nents;
>   	int r;
>   
>   	int write = !(gtt->userflags & AMDGPU_GEM_USERPTR_READONLY);
> @@ -1040,9 +1039,8 @@ static int amdgpu_ttm_tt_pin_userptr(struct ttm_tt *ttm)
>   		goto release_sg;
>   
>   	/* Map SG to device */
> -	r = -ENOMEM;
> -	nents = dma_map_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
> -	if (nents == 0)
> +	r = dma_map_sgtable(adev->dev, ttm->sg, direction, 0);
> +	if (r)
>   		goto release_sg;
>   
>   	/* convert SG to linear array of pages and dma addresses */
> @@ -1073,8 +1071,7 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_tt *ttm)
>   		return;
>   
>   	/* unmap the pages mapped to the device */
> -	dma_unmap_sg(adev->dev, ttm->sg->sgl, ttm->sg->nents, direction);
> -
> +	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
>   	sg_free_table(ttm->sg);
>   
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index d399e5893170..c281aa13f5ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -477,11 +477,11 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	if (r)
>   		goto error_free;
>   
> -	for_each_sg((*sgt)->sgl, sg, num_entries, i)
> +	for_each_sgtable_sg((*sgt), sg, i)
>   		sg->length = 0;
>   
>   	node = mem->mm_node;
> -	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
> +	for_each_sgtable_sg((*sgt), sg, i) {
>   		phys_addr_t phys = (node->start << PAGE_SHIFT) +
>   			adev->gmc.aper_base;
>   		size_t size = node->size << PAGE_SHIFT;
> @@ -501,7 +501,7 @@ int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
>   	return 0;
>   
>   error_unmap:
> -	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
> +	for_each_sgtable_sg((*sgt), sg, i) {
>   		if (!sg->length)
>   			continue;
>   
> @@ -532,7 +532,7 @@ void amdgpu_vram_mgr_free_sgt(struct amdgpu_device *adev,
>   	struct scatterlist *sg;
>   	int i;
>   
> -	for_each_sg(sgt->sgl, sg, sgt->nents, i)
> +	for_each_sgtable_sg(sgt, sg, i)
>   		dma_unmap_resource(dev, sg->dma_address,
>   				   sg->length, dir,
>   				   DMA_ATTR_SKIP_CPU_SYNC);

