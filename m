Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58FC9C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F3C42078B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 14:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PswB8uHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgHUOlj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 10:41:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28252 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727074AbgHUOlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 10:41:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598020894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ek2EM8QqBSfsi5DIulFEdwWbNMhy96IT1jugkmNazA8=;
        b=PswB8uHzbT0wFdWJT1PPoYCc8JHIuMArsYw+cD53Ix8PwuWzBY8FUen5xlo9Nb+uHlTPTb
        AxRiv0/UHWYqq6WGFbYxC/5kb3H8pNClHZYuMayDQ4O5jvogWZCBYI6GlqrRU+4jJJlGmM
        M6Vz02vkhJ/jX0k6OqgWjMwDkxNYAPk=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-295-8pd0eNJ8PyuQanKOtWNR0Q-1; Fri, 21 Aug 2020 10:41:20 -0400
X-MC-Unique: 8pd0eNJ8PyuQanKOtWNR0Q-1
Received: by mail-qk1-f200.google.com with SMTP id d131so1562364qke.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 07:41:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ek2EM8QqBSfsi5DIulFEdwWbNMhy96IT1jugkmNazA8=;
        b=XeiGd07Kg0VnH6x68NeKkYMTJCdg5c8uSpQWpX2f5tx/Z+r19ceEpRUWTl1/oWGR2I
         vB/yl0wD6bXwoGlgW64DdJlUfACPGKx5+DcDF4WVv96zELwW+cGKLr/9fFkC3qQoIaPp
         qlR5bM6nyeleg9lZb2eSTeiabn+B0xBUyRYPlNTDM3aRKN3UZEyrhwjLJ8A1W5IYvl5l
         Ga4Bz5jVcBPRTX4T6/8wWQUczS9cvAZDB2exrwrpJcHQbptbV06hgM6h/StQX45GNsDs
         DZzDYkYhfTt8e0JrluDgcD918AeQCSJtCbAipsI4wNTIKq3UEvYY1sI4aOZO83gfPQXi
         gAEw==
X-Gm-Message-State: AOAM531LzdRpaHyLklM9b0/nBdESxoMlqX585qjSqqx8w8zGBXvylYit
        W1d5N9rSEcv91eH/iOcpkuzy5wp40Egi7gboV808nTcp1QYgfglvQAmrWYvREM5hofvzYCFEBkg
        bFRmtp15IRuiyh5btQdSInriC
X-Received: by 2002:ac8:3a65:: with SMTP id w92mr2989424qte.184.1598020879883;
        Fri, 21 Aug 2020 07:41:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFAyPXyeo7yYQEt0dGaJ1pPrIP4FaJ036/x3/oLsZwcGLDn1Dy/yWn7vRlA70fkU7U608qLg==
X-Received: by 2002:ac8:3a65:: with SMTP id w92mr2989403qte.184.1598020879642;
        Fri, 21 Aug 2020 07:41:19 -0700 (PDT)
Received: from redhat.com (bzq-109-67-40-161.red.bezeqint.net. [109.67.40.161])
        by smtp.gmail.com with ESMTPSA id b37sm2223640qtk.85.2020.08.21.07.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 07:41:19 -0700 (PDT)
Date:   Fri, 21 Aug 2020 10:41:14 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Eli Cohen <eli@mellanox.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Parav Pandit <parav@mellanox.com>
Subject: Re: drivers/vdpa/mlx5/core/mr.c:244: undefined reference to
 `vhost_iotlb_itree_first'
Message-ID: <20200821104033-mutt-send-email-mst@kernel.org>
References: <202008202313.Y8g4FgxZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008202313.Y8g4FgxZ%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 11:36:15PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7eac66d0456fe12a462e5c14c68e97c7460989da
> commit: 94abbccdf2916cb03f9626f2d36c6e9971490c12 vdpa/mlx5: Add shared memory registration code
> date:   2 weeks ago
> config: x86_64-randconfig-m001-20200820 (attached as .config)
> compiler: gcc-9 (Debian 9.3.0-15) 9.3.0
> reproduce (this is a W=1 build):
>         git checkout 94abbccdf2916cb03f9626f2d36c6e9971490c12
>         # save the attached .config to linux build tree
>         make W=1 ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    ld: drivers/vdpa/mlx5/core/mr.o: in function `map_direct_mr':
> >> drivers/vdpa/mlx5/core/mr.c:244: undefined reference to `vhost_iotlb_itree_first'
> >> ld: drivers/vdpa/mlx5/core/mr.c:245: undefined reference to `vhost_iotlb_itree_next'
> >> ld: drivers/vdpa/mlx5/core/mr.c:260: undefined reference to `vhost_iotlb_itree_first'
>    ld: drivers/vdpa/mlx5/core/mr.c:261: undefined reference to `vhost_iotlb_itree_next'
>    ld: drivers/vdpa/mlx5/core/mr.o: in function `_mlx5_vdpa_create_mr':
>    drivers/vdpa/mlx5/core/mr.c:377: undefined reference to `vhost_iotlb_itree_first'
>    ld: drivers/vdpa/mlx5/core/mr.c:378: undefined reference to `vhost_iotlb_itree_next'
>    ld: drivers/vdpa/mlx5/core/mr.o: in function `map_empty':
>    drivers/vdpa/mlx5/core/mr.c:460: undefined reference to `vhost_iotlb_itree_first'

Looks like a missing select VHOST_IOTLB, right?


> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=94abbccdf2916cb03f9626f2d36c6e9971490c12
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout 94abbccdf2916cb03f9626f2d36c6e9971490c12
> vim +244 drivers/vdpa/mlx5/core/mr.c
> 
>    225	
>    226	static int map_direct_mr(struct mlx5_vdpa_dev *mvdev, struct mlx5_vdpa_direct_mr *mr,
>    227				 struct vhost_iotlb *iotlb)
>    228	{
>    229		struct vhost_iotlb_map *map;
>    230		unsigned long lgcd = 0;
>    231		int log_entity_size;
>    232		unsigned long size;
>    233		u64 start = 0;
>    234		int err;
>    235		struct page *pg;
>    236		unsigned int nsg;
>    237		int sglen;
>    238		u64 pa;
>    239		u64 paend;
>    240		struct scatterlist *sg;
>    241		struct device *dma = mvdev->mdev->device;
>    242		int ret;
>    243	
>  > 244		for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
>  > 245		     map; map = vhost_iotlb_itree_next(map, start, mr->end - 1)) {
>    246			size = maplen(map, mr);
>    247			lgcd = gcd(lgcd, size);
>    248			start += size;
>    249		}
>    250		log_entity_size = ilog2(lgcd);
>    251	
>    252		sglen = 1 << log_entity_size;
>    253		nsg = MLX5_DIV_ROUND_UP_POW2(mr->end - mr->start, log_entity_size);
>    254	
>    255		err = sg_alloc_table(&mr->sg_head, nsg, GFP_KERNEL);
>    256		if (err)
>    257			return err;
>    258	
>    259		sg = mr->sg_head.sgl;
>  > 260		for (map = vhost_iotlb_itree_first(iotlb, mr->start, mr->end - 1);
>    261		     map; map = vhost_iotlb_itree_next(map, mr->start, mr->end - 1)) {
>    262			paend = map->addr + maplen(map, mr);
>    263			for (pa = map->addr; pa < paend; pa += sglen) {
>    264				pg = pfn_to_page(__phys_to_pfn(pa));
>    265				if (!sg) {
>    266					mlx5_vdpa_warn(mvdev, "sg null. start 0x%llx, end 0x%llx\n",
>    267						       map->start, map->last + 1);
>    268					err = -ENOMEM;
>    269					goto err_map;
>    270				}
>    271				sg_set_page(sg, pg, sglen, 0);
>    272				sg = sg_next(sg);
>    273				if (!sg)
>    274					goto done;
>    275			}
>    276		}
>    277	done:
>    278		mr->log_size = log_entity_size;
>    279		mr->nsg = nsg;
>    280		ret = dma_map_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
>    281		if (!ret)
>    282			goto err_map;
>    283	
>    284		err = create_direct_mr(mvdev, mr);
>    285		if (err)
>    286			goto err_direct;
>    287	
>    288		return 0;
>    289	
>    290	err_direct:
>    291		dma_unmap_sg_attrs(dma, mr->sg_head.sgl, mr->nsg, DMA_BIDIRECTIONAL, 0);
>    292	err_map:
>    293		sg_free_table(&mr->sg_head);
>    294		return err;
>    295	}
>    296	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


