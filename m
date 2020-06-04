Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24CAC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3CAC20738
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 08:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pM0whOYm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726886AbgFDIKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 04:10:37 -0400
Received: from mail-bn8nam12on2076.outbound.protection.outlook.com ([40.107.237.76]:33600
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726047AbgFDIKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 04:10:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8FaUbN16F4hVKPV3Cs+NofAQKfr3G9JOOe+lA+dQRY/dAvT/f7siDYaJ2UheRXBACjfpDp/L79GK8EL79hJPnVXZg8YBFQppyHCbOXDVnNWAGUNdir755+FtllGMH8vW+BG8vp6ubmMwd8bIcsP6l/G3LWmLWeV8hH4LU8/ibZ/Ryeukstqdh1uC21zVHdmB9IZuEgIna4WVYMWgjIUfl0sArfBUiR+mfBcZeKrMm134515xKrw7fKbktrF22EnhqBo897S98OYvcohuvYl8Te5uov2FkPyfts/lPSE6bQ9YbEWFlTi/DCDP4aeVtofCIMt+tou6rmar2oDzfwKDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1FQBVwTIh2JL4CTF5vKMLW8CRYVQXKXzk5NabPlOiw=;
 b=iwfivsNiyZfz78Z88JZiX4hwJ0QQ3qfUrpH3K5NDQeCkA834o//HB2s/A9erXesvsaP/HPZWOCtv7yQR/p4gMY5sVjZ3dihexYsQU0uy7E4IugPV9gQt4yDaswgaRROc82ftXCqSiXF0yIG8eSVT2Wtr1rImbd0ymfI3O4ZiyCV/8IDGr7d3GPBV8K6InBpyCUXiGN/L6ZTBEUOzu+gCJX8ybkkSEWlmi3K5qGpvTsAYftqNdRgVyJpHq5AThvDZODMBo9FGh83e9UoAQzTX5yRD+1IBeWAfUy1OWT2NsJ+1dJf6a0ZRHYhywULIo6J0bThdi0saZLxTljVuK/8yFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F1FQBVwTIh2JL4CTF5vKMLW8CRYVQXKXzk5NabPlOiw=;
 b=pM0whOYmdLgP99W5nRlkHXXfrQqesGbGl9kQ4ymn8JyRj5E31VDNypX652axUY68U11WwJvCRtheTY883QP+zY3nWEL1W7mGtfnGA4Tpt1CyXPczk16fVvxZ60JWB0CS66eq6p6K+k8mhULNKVpEt7/sILWmrbZLh+OKh/koaXk=
Authentication-Results: deltatee.com; dkim=none (message not signed)
 header.d=none;deltatee.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB3611.namprd12.prod.outlook.com (2603:10b6:5:3c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Thu, 4 Jun
 2020 08:10:33 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%5]) with mapi id 15.20.3066.019; Thu, 4 Jun 2020
 08:10:33 +0000
Subject: Re: [git pull] drm for 5.8-rc1
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Dave Airlie <airlied@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <20200603201337.GA225528@ziepe.ca>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <1d1ad025-e215-da23-5282-bbaf154fa979@amd.com>
Date:   Thu, 4 Jun 2020 10:10:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200603201337.GA225528@ziepe.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM4PR07CA0005.eurprd07.prod.outlook.com
 (2603:10a6:205:1::18) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM4PR07CA0005.eurprd07.prod.outlook.com (2603:10a6:205:1::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.7 via Frontend Transport; Thu, 4 Jun 2020 08:10:31 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 9f26b887-df6b-4030-6fb6-08d8085ec117
X-MS-TrafficTypeDiagnostic: DM6PR12MB3611:
X-Microsoft-Antispam-PRVS: <DM6PR12MB361101FE504EEA10C3EC771583890@DM6PR12MB3611.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1751;
X-Forefront-PRVS: 04244E0DC5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2ra1+7c/4Mpt2cQyLUATDsjPB/qHKe8IyuE+DBOHCH4eH2QH/6D/CBz81qRYOfYl1CqtcFNgA2+ssC+5kBJftw/b8SvL+p4yAN31q8pQLL7IRBOMtuZtyH/mqYnYWPXkIK5vh5kwUyw2mIHzbyb2HWVyKYx/e2ojp85bOzWOcnU0YCVYv5XnXesZ+Gv1w1VODo5uj3W2z9BB78MZp2XoNXyzHB3hqQGOUwUrdOS1xkLoP+zKLyA4etxcOf1JVy5UkdXFNODtwPy/ijPd0tiYkHaDlkwzRja1+kqkmMpiVNvfBGtuzeyJb7nVtxx3ENbAOQYSmPndmjmLRjK+PG4RLppbh4/mGuNphjvkL0k+lGlzrujB1HzRzGaoaaft8kbyfHnBxLwq3NuJdXvxI6y2BnsUhH/xDr0je9hDAZtgEuYorm0oH5obQ0XTv1vpVEhuD2rhrAdRe5kaQJmO8l4sLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(376002)(366004)(396003)(346002)(4326008)(54906003)(110136005)(186003)(86362001)(2616005)(83380400001)(2906002)(31686004)(478600001)(45080400002)(16526019)(66946007)(8676002)(966005)(52116002)(6486002)(66476007)(8936002)(5660300002)(66556008)(31696002)(36756003)(6666004)(66574014)(316002)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: dEDPAkv7adSKLQjREIKG5SNV5R2s4VaOhT5r5J8i5G13mFdCTSYGxcGe3GHFfBM7AIQEmVUu6X0EMS0qpPFrzOfvrQoRopdLso1L2qXz3XFTh+QkojFNJMXz2IqoJRR1ug0PSEFz2vvFygwtH2FgETJffPCZJHXoYU9BY43yIPfHF5RVnag+XiVG6ZuGI0Dlw07LoowxhskYFuJR7uZevECXH6p/MXrDHtivMQAj9VEhpB/p3WH4DRLQ/OBsfeAcVsQoI0wedW8zHDFKzkOOq0VFjy9P11Ua/BnRGzdl5/AhrjFmshjZVsjFoCb01mEO7Mg+OmFLWWlQH5W6ZTNK1ERgtBN/zi2rYNT7Dx6FgABFQfyLEE+7gBSyAkxX7p7UccnEkyLSejy2b98bMb45B9JzloBvf6Pgih0gEDvR6YUHDY1PqJhyRmedU9NTI2FananPnrRihPZnJXvmVKYSsmgE8szhbZ9rFvYLAtkK1vzql2SbbTSqtlwfqvWt65LENdQTxVmh809KxDe+UaUjmjXqmqaoWkiEWWDAxaLZxha8dd9z2CCfHZh2Fw2B5a/q
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f26b887-df6b-4030-6fb6-08d8085ec117
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2020 08:10:33.4144
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qds2ufUuh39z9ka6r08LpZjfbqgFRXBQCGerjhMAiVF/liVE6TUiArTJWouJXyBR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3611
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.06.20 um 22:13 schrieb Jason Gunthorpe:
> On Tue, Jun 02, 2020 at 04:06:32PM +1000, Dave Airlie wrote:
>> Hi Linus,
>>
>> This is the main drm pull request for 5.8-rc1.
>>
>> Highlights:
>> Core DRM had a lot of refactoring around managed drm resources to make
>> drivers simpler.
>> Intel Tigerlake support is on by default
>> amdgpu now support p2p PCI buffer sharing and encrypted GPU memory
> Christoph Hellwig basically NAK'd this approach, why is it getting
> merged all of a sudden??

Dave and Daniel explicitly said they want to have this and it is ok as 
long as I open code it in the driver and keep it AMD internal.

We have that in discussion for years now and constructing/using the sg 
table is actually only the very minor piece of it. On the other hand 
there is a lot of work underway to get rid of abusing the sg tables as well.

>
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fintel-gfx%2F20200311152838.GA24280%40infradead.org%2F&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C55b238b9104d4a8d4feb08d807faa11c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637268120315706063&amp;sdata=AgVJ45%2Ft%2FVYkyIGIGgMrop69XLQReLDpF0ahL5rjEjo%3D&amp;reserved=0
>
> Are we now OK with this same approach open coded in a driver?

Intel is apparently doing this as well for years, see the i915 driver 
internals.

> This wasn't Cc'd to the usual people doing work in this PCI P2P area??

I certainly prefer a common framework for this, but when my upstream 
maintainer says he wants to take this who am I to object?

Christian.

>
> See
>
> commit f44ffd677fb3562ac0a1ff9c8ae52672be741f00
> Author: Christian König <christian.koenig@amd.com>
> Date:   Fri Mar 23 16:56:37 2018 +0100
>
>      drm/amdgpu: add support for exporting VRAM using DMA-buf v3
>      
>      We should be able to do this now after checking all the prerequisites.
>      
>      v2: fix entrie count in the sgt
>      v3: manually construct the sg
>      
>      Signed-off-by: Christian König <christian.koenig@amd.com>
>      Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>      Acked-by: Sumit Semwal <sumit.semwal@linaro.org>
>      Link: https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fpatchwork.freedesktop.org%2Fpatch%2F359295&amp;data=02%7C01%7Cchristian.koenig%40amd.com%7C55b238b9104d4a8d4feb08d807faa11c%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637268120315706063&amp;sdata=YzNvxBVOf5hcUm5KjOzzV%2FcHG5jdGEYmrI76PQN9v3U%3D&amp;reserved=0
>
> [..]
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> index 82a3299e53c042..128a667ed8fa0d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
> @@ -22,6 +22,7 @@
>    * Authors: Christian König
>    */
>   
> +#include <linux/dma-mapping.h>
>   #include "amdgpu.h"
>   #include "amdgpu_vm.h"
>   #include "amdgpu_atomfirmware.h"
> @@ -458,6 +459,104 @@ static void amdgpu_vram_mgr_del(struct ttm_mem_type_manager *man,
>   	mem->mm_node = NULL;
>   }
>   
> +/**
> + * amdgpu_vram_mgr_alloc_sgt - allocate and fill a sg table
> + *
> + * @adev: amdgpu device pointer
> + * @mem: TTM memory object
> + * @dev: the other device
> + * @dir: dma direction
> + * @sgt: resulting sg table
> + *
> + * Allocate and fill a sg table from a VRAM allocation.
> + */
> +int amdgpu_vram_mgr_alloc_sgt(struct amdgpu_device *adev,
> +			      struct ttm_mem_reg *mem,
> +			      struct device *dev,
> +			      enum dma_data_direction dir,
> +			      struct sg_table **sgt)
> +{
> +	struct drm_mm_node *node;
> +	struct scatterlist *sg;
> +	int num_entries = 0;
> +	unsigned int pages;
> +	int i, r;
> +
> +	*sgt = kmalloc(sizeof(*sg), GFP_KERNEL);
> +	if (!*sgt)
> +		return -ENOMEM;
> +
> +	for (pages = mem->num_pages, node = mem->mm_node;
> +	     pages; pages -= node->size, ++node)
> +		++num_entries;
> +
> +	r = sg_alloc_table(*sgt, num_entries, GFP_KERNEL);
> +	if (r)
> +		goto error_free;
> +
> +	for_each_sg((*sgt)->sgl, sg, num_entries, i)
> +		sg->length = 0;
> +
> +	node = mem->mm_node;
> +	for_each_sg((*sgt)->sgl, sg, num_entries, i) {
> +		phys_addr_t phys = (node->start << PAGE_SHIFT) +
> +			adev->gmc.aper_base;
> +		size_t size = node->size << PAGE_SHIFT;
> +		dma_addr_t addr;
> +
> +		++node;
> +		addr = dma_map_resource(dev, phys, size, dir,
> +					DMA_ATTR_SKIP_CPU_SYNC);
> +		r = dma_mapping_error(dev, addr);
> +		if (r)
> +			goto error_unmap;
> +
> +		sg_set_page(sg, NULL, size, 0);
> +		sg_dma_address(sg) = addr;
> +		sg_dma_len(sg) = size;
>                  ^^^^^^^^^^^^^^
>    
> Jason

