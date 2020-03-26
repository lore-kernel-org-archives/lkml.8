Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A36C2D0E8
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5447020714
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 07:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OwLiSDxc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgCZHSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 03:18:08 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:50826 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726014AbgCZHSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 03:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585207086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uQp0K0jAaR+9l6rJiVimsB2GyRtRdq+1EsfqDIYov0g=;
        b=OwLiSDxcLmT4yEwQ/yb7pddAD6nndMIRsQG0oMpR6UHgiFvlnvnEXrO3ZlvBFMVdxmcNMP
        h86nwNxDNXiBgavT0ePqXE4TVWKMamKS2SwS5mE/TRHsTqF8xj7HmxBGiYoaAWJNgm+be3
        GNZhTj8pI4XLzwQOfedsAyvBFgF+H0E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-nTrvECvAMjioshR8xECFGw-1; Thu, 26 Mar 2020 03:18:01 -0400
X-MC-Unique: nTrvECvAMjioshR8xECFGw-1
Received: by mail-wr1-f69.google.com with SMTP id b11so2564099wru.21
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 00:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uQp0K0jAaR+9l6rJiVimsB2GyRtRdq+1EsfqDIYov0g=;
        b=ngCLmOZEtZiSNqYDvJvvoiLxKUv683CxYLYOoIZAF+2sk2J9f64F2qUNmKumYq30/0
         /RkdxqMe47xT1/naPtb/zRoiC0EOQpDtvwrWhB9oWoYhxUdDsWQiz/6kHuS/fsILU0OP
         I3MleSTh3lCM2ZnbNl6hQIdl9C1ezvleTIx7gBstsE+UNJZe1LFKmHocfooI0ObuRcwS
         MxkxOGw08hG6Cp+JAy8UzsTz7NX2XmT9oa9kixWRyb1hHcevM66ElR8/6EfYLoY0e8aL
         H2pX+dgW5GQ9HYZuBNvvRz4B9o4O66SJpsFemYGBaU2s2tSCvH5h8NEYaD7GPaje1qDu
         CZCQ==
X-Gm-Message-State: ANhLgQ2jY37fnxAYgbeqx2AH8IgK08TGuhpXOm93UotJYI65oIgdGpVa
        YK+9asoeHN0U+mLJqkJLnwRkYMM8ymLVp7gEsLq7g2TBckLqPWFMtcIZ93SrGah2uXTj6tWFvkf
        Vsu93emDlyO7m7bxOXb6q8uG+
X-Received: by 2002:a1c:5443:: with SMTP id p3mr1522459wmi.149.1585207079683;
        Thu, 26 Mar 2020 00:17:59 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vsV2ccS13lkeQxkkKN1HSUlNXfJOOUYxFAbUrNNXNsYZOEMMdTYL/3hvon4EOjuxEQsIlLk4w==
X-Received: by 2002:a1c:5443:: with SMTP id p3mr1522423wmi.149.1585207079260;
        Thu, 26 Mar 2020 00:17:59 -0700 (PDT)
Received: from redhat.com (bzq-79-182-20-254.red.bezeqint.net. [79.182.20.254])
        by smtp.gmail.com with ESMTPSA id w11sm2306538wrv.86.2020.03.26.00.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 00:17:58 -0700 (PDT)
Date:   Thu, 26 Mar 2020 03:17:55 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Hui Zhu <teawater@gmail.com>
Cc:     jasowang@redhat.com, akpm@linux-foundation.org,
        mojha@codeaurora.org, pagupta@redhat.com, aquini@redhat.com,
        namit@vmware.com, david@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        qemu-devel@nongnu.org, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH for Linux v2] virtio_balloon: Add
 VIRTIO_BALLOON_VQ_INFLATE_CONT to handle THP split issue
Message-ID: <20200326030318-mutt-send-email-mst@kernel.org>
References: <1584893097-12317-1-git-send-email-teawater@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584893097-12317-1-git-send-email-teawater@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First, either QEMU or Linux version of any interface changes
should be copied to the virtio TC.

:


On Mon, Mar 23, 2020 at 12:04:56AM +0800, Hui Zhu wrote:
> The first version is in [1].
> According to the comments from Michael and David, I updated the patch.
> 1. Added a separate vq inflate_cont_vq to transport inflate continuous
>    pages.
> 2. Set all the pages in the continuous pages movable then they can be
>    compaction.
> 3. Added a new element pages_order to virtio_balloon_config.  It is the
>    inflate pages order that is set by the QEMU.
> 4. If the balloon cannot get any continuous pages from the system.
>    Go back to use the single page to fill the balloon.
> 5.  Use balloon_pages_alloc to allocate the single page and continuous
>     pages.  Replace __GFP_NORETRY with __GFP_RETRY_MAYFAIL when allocating
>     the continuous pages because it can increase the success rate of
>     allocating large chunks of memory.
> 
> Following is the introduction of the function.
> If the guest kernel has many fragmentation pages, use virtio_balloon
> will split THP of QEMU when it calls MADV_DONTNEED madvise to release
> the balloon pages.
> This is an example in a VM with 1G memory 1CPU:
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> 
> // After VM start, use usemem
> // (https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git)
> // punch-holes function generates 400m fragmentation pages in the guest
> // kernel.
> usemem --punch-holes -s -1 800m &
> 
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
> 
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=balloon1
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=600
> 
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    151552 kB
> 
> THP number decreased more than 800M.
> The reason is usemem with punch-holes option will free every other
> page after allocation.  Then 400M free memory inside the guest kernel
> is fragmentation pages.
> The guest kernel will use them to inflate the balloon.  When these
> fragmentation pages are freed, THP will be split.
> 
> This commit tries to handle this with add a new flag
> VIRTIO_BALLOON_VQ_INFLATE_CONT.
> When this flag is set, the balloon will try to use continuous pages
> inflate the balloon.  And the pages order is set to THP order.
> Then THP pages will be freed together in the host.
> This is an example in a VM with 1G memory 1CPU:
> // This is the THP number before VM execution in the host.
> // None use THP.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:         0 kB
> 
> // After VM start, use usemem punch-holes function generates 400M
> // fragmentation pages in the guest kernel.
> usemem --punch-holes -s -1 800m &
> 
> // This is the THP number after this command in the host.
> // Some THP is used by VM because usemem will access 800M memory
> // in the guest.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    976896 kB
> 
> // Connect to the QEMU monitor, setup balloon, and set it size to 600M.
> (qemu) device_add virtio-balloon-pci,id=balloon1,cont-pages=on
> (qemu) info balloon
> balloon: actual=1024
> (qemu) balloon 600
> (qemu) info balloon
> balloon: actual=600
> 
> // This is the THP number after inflate the balloon in the host.
> cat /proc/meminfo | grep AnonHugePages:
> AnonHugePages:    610304 kB
> 
> The THP number decreases 358M.  This shows that
> VIRTIO_BALLOON_VQ_INFLATE_CONT can help handle the THP split issue.
> 
> [1] https://lkml.org/lkml/2020/3/12/144
> 
> Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>

I'd like to repeat my original idea of doing large page allocations
unconditionally within guest.


> ---
>  drivers/virtio/virtio_balloon.c     | 78 ++++++++++++++++++++++++++++++-------
>  include/linux/balloon_compaction.h  |  9 ++++-
>  include/uapi/linux/virtio_balloon.h |  3 ++
>  mm/balloon_compaction.c             | 40 +++++++++++++++----
>  4 files changed, 109 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 341458f..fbd2b02f 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -47,6 +47,7 @@ enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_DEFLATE,
>  	VIRTIO_BALLOON_VQ_STATS,
>  	VIRTIO_BALLOON_VQ_FREE_PAGE,
> +	VIRTIO_BALLOON_VQ_INFLATE_CONT,
>  	VIRTIO_BALLOON_VQ_MAX
>  };
>  
> @@ -56,7 +57,8 @@ enum virtio_balloon_config_read {
>  
>  struct virtio_balloon {
>  	struct virtio_device *vdev;
> -	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq;
> +	struct virtqueue *inflate_vq, *deflate_vq, *stats_vq, *free_page_vq,
> +			 *inflate_cont_vq;
>  
>  	/* Balloon's own wq for cpu-intensive work items */
>  	struct workqueue_struct *balloon_wq;
> @@ -114,6 +116,12 @@ struct virtio_balloon {
>  
>  	/* To register a shrinker to shrink memory upon memory pressure */
>  	struct shrinker shrinker;
> +
> +	/* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set.
> +	 * if VIRTIO_BALLOON_F_CONT_PAGES is not set,
> +	 * pages_order will be set to 0.
> +	 */
> +	__u32 pages_order;
>  };
>  
>  static struct virtio_device_id id_table[] = {
> @@ -169,10 +177,11 @@ static void set_page_pfns(struct virtio_balloon *vb,
>  					  page_to_balloon_pfn(page) + i);
>  }
>  
> -static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
> +static unsigned int fill_balloon_order(struct virtio_balloon *vb, size_t num,
> +				       unsigned int order)
>  {
> -	unsigned num_allocated_pages;
> -	unsigned num_pfns;
> +	unsigned int num_allocated_pages;
> +	unsigned int num_pfns;
>  	struct page *page;
>  	LIST_HEAD(pages);
>  
> @@ -181,12 +190,12 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  
>  	for (num_pfns = 0; num_pfns < num;
>  	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
> -		struct page *page = balloon_page_alloc();
> +		struct page *page = balloon_pages_alloc(order);
>  
>  		if (!page) {
>  			dev_info_ratelimited(&vb->vdev->dev,
> -					     "Out of puff! Can't get %u pages\n",
> -					     VIRTIO_BALLOON_PAGES_PER_PAGE);
> +				"Out of puff! Can't get %u pages\n",
> +				VIRTIO_BALLOON_PAGES_PER_PAGE << order);
>  			/* Sleep for at least 1/5 of a second before retry. */
>  			msleep(200);
>  			break;
> @@ -200,25 +209,48 @@ static unsigned fill_balloon(struct virtio_balloon *vb, size_t num)
>  	vb->num_pfns = 0;
>  
>  	while ((page = balloon_page_pop(&pages))) {
> -		balloon_page_enqueue(&vb->vb_dev_info, page);
> +		balloon_pages_enqueue(&vb->vb_dev_info, page, order);
>  
>  		set_page_pfns(vb, vb->pfns + vb->num_pfns, page);
> -		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE;
> +		vb->num_pages += VIRTIO_BALLOON_PAGES_PER_PAGE << order;
>  		if (!virtio_has_feature(vb->vdev,
>  					VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -			adjust_managed_page_count(page, -1);
> +			adjust_managed_page_count(page, -(1 << order));
>  		vb->num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE;
>  	}
>  
> -	num_allocated_pages = vb->num_pfns;
> +	num_allocated_pages = vb->num_pfns << order;
>  	/* Did we get any? */
> -	if (vb->num_pfns != 0)
> -		tell_host(vb, vb->inflate_vq);
> +	if (vb->num_pfns != 0) {
> +		if (order)
> +			tell_host(vb, vb->inflate_cont_vq);
> +		else
> +			tell_host(vb, vb->inflate_vq);
> +	}
>  	mutex_unlock(&vb->balloon_lock);
>  
>  	return num_allocated_pages;
>  }
>  
> +static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
> +{
> +	unsigned int num_allocated_pages = 0;
> +
> +	if (vb->pages_order) {
> +		num_allocated_pages = fill_balloon_order(vb, num,
> +							 vb->pages_order);
> +		if (!num_allocated_pages)
> +			dev_info_ratelimited(&vb->vdev->dev,
> +				"Fail get any continuous pages in order %u\n",
> +				vb->pages_order);
> +	}
> +
> +	if (!num_allocated_pages)
> +		num_allocated_pages = fill_balloon_order(vb, num, 0);
> +
> +	return num_allocated_pages;
> +}
> +
>  static void release_pages_balloon(struct virtio_balloon *vb,
>  				 struct list_head *pages)
>  {


Hmm no this is not what was previously suggested. David Hildenbrand proposed
starting with highest order and iterating until we reach 0.
And I proposed a new API to allocate some memory between min and max
orders.


> @@ -481,6 +513,8 @@ static int init_vqs(struct virtio_balloon *vb)
>  	names[VIRTIO_BALLOON_VQ_STATS] = NULL;
>  	callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>  	names[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
> +	callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
> +	names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = NULL;
>  
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_STATS_VQ)) {
>  		names[VIRTIO_BALLOON_VQ_STATS] = "stats";
> @@ -492,6 +526,11 @@ static int init_vqs(struct virtio_balloon *vb)
>  		callbacks[VIRTIO_BALLOON_VQ_FREE_PAGE] = NULL;
>  	}
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
> +		names[VIRTIO_BALLOON_VQ_INFLATE_CONT] = "inflate_cont";
> +		callbacks[VIRTIO_BALLOON_VQ_INFLATE_CONT] = balloon_ack;
> +	}
> +
>  	err = vb->vdev->config->find_vqs(vb->vdev, VIRTIO_BALLOON_VQ_MAX,
>  					 vqs, callbacks, names, NULL, NULL);
>  	if (err)
> @@ -524,6 +563,10 @@ static int init_vqs(struct virtio_balloon *vb)
>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		vb->free_page_vq = vqs[VIRTIO_BALLOON_VQ_FREE_PAGE];
>  
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES))
> +		vb->inflate_cont_vq
> +			= vqs[VIRTIO_BALLOON_VQ_INFLATE_CONT];
> +
>  	return 0;
>  }
>  
> @@ -945,6 +988,14 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		if (err)
>  			goto out_del_balloon_wq;
>  	}
> +	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_CONT_PAGES)) {
> +		virtio_cread(vb->vdev, struct virtio_balloon_config,
> +			     pages_order, &vb->pages_order);
> +		if (!virtio_has_feature(vb->vdev, VIRTIO_F_VERSION_1))
> +			vb->pages_order
> +				= le32_to_cpu((__force __le32)vb->pages_order);
> +	} else
> +		vb->pages_order = 0;
>  	virtio_device_ready(vdev);
>  
>  	if (towards_target(vb))
> @@ -1058,6 +1109,7 @@ static unsigned int features[] = {
>  	VIRTIO_BALLOON_F_DEFLATE_ON_OOM,
>  	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
>  	VIRTIO_BALLOON_F_PAGE_POISON,
> +	VIRTIO_BALLOON_F_CONT_PAGES,
>  };
>  
>  static struct virtio_driver virtio_balloon_driver = {
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 338aa27..8180bbf 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -60,15 +60,22 @@ struct balloon_dev_info {
>  	struct inode *inode;
>  };
>  
> -extern struct page *balloon_page_alloc(void);
> +extern struct page *balloon_pages_alloc(unsigned int order);
>  extern void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  				 struct page *page);
> +extern void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
> +				  struct page *page, unsigned int order);
>  extern struct page *balloon_page_dequeue(struct balloon_dev_info *b_dev_info);
>  extern size_t balloon_page_list_enqueue(struct balloon_dev_info *b_dev_info,
>  				      struct list_head *pages);
>  extern size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  				     struct list_head *pages, size_t n_req_pages);
>  
> +static inline struct page *balloon_page_alloc(void)
> +{
> +	return balloon_pages_alloc(0);
> +}
> +
>  static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>  {
>  	balloon->isolated_pages = 0;
> diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
> index a1966cd7..e21b0aa 100644
> --- a/include/uapi/linux/virtio_balloon.h
> +++ b/include/uapi/linux/virtio_balloon.h
> @@ -36,6 +36,7 @@
>  #define VIRTIO_BALLOON_F_DEFLATE_ON_OOM	2 /* Deflate balloon on OOM */
>  #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
>  #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
> +#define VIRTIO_BALLOON_F_CONT_PAGES	5 /* VQ to report continuous pages */
>  
>  /* Size of a PFN in the balloon interface. */
>  #define VIRTIO_BALLOON_PFN_SHIFT 12
> @@ -51,6 +52,8 @@ struct virtio_balloon_config {
>  	__u32 free_page_report_cmd_id;
>  	/* Stores PAGE_POISON if page poisoning is in use */
>  	__u32 poison_val;
> +	/* Pages order if VIRTIO_BALLOON_F_CONT_PAGES is set */
> +	__u32 pages_order;
>  };
>  
>  #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 26de020..87df4b2 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -112,8 +112,8 @@ size_t balloon_page_list_dequeue(struct balloon_dev_info *b_dev_info,
>  EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>  
>  /*
> - * balloon_page_alloc - allocates a new page for insertion into the balloon
> - *			page list.
> + * balloon_pages_alloc - allocates a new page for insertion into the balloon
> + *			 page list.
>   *
>   * Driver must call this function to properly allocate a new balloon page.
>   * Driver must call balloon_page_enqueue before definitively removing the page
> @@ -121,14 +121,21 @@ EXPORT_SYMBOL_GPL(balloon_page_list_dequeue);
>   *
>   * Return: struct page for the allocated page or NULL on allocation failure.
>   */
> -struct page *balloon_page_alloc(void)
> +struct page *balloon_pages_alloc(unsigned int order)
>  {
> -	struct page *page = alloc_page(balloon_mapping_gfp_mask() |
> -				       __GFP_NOMEMALLOC | __GFP_NORETRY |
> -				       __GFP_NOWARN);
> +	gfp_t gfp_mask;
> +
> +	if (order > 1)
> +		gfp_mask = __GFP_RETRY_MAYFAIL;
> +	else
> +		gfp_mask = __GFP_NORETRY;
> +
> +	struct page *page = alloc_pages(balloon_mapping_gfp_mask() |
> +					gfp_mask | __GFP_NOMEMALLOC |
> +					__GFP_NOWARN, order);
>  	return page;
>  }
> -EXPORT_SYMBOL_GPL(balloon_page_alloc);
> +EXPORT_SYMBOL_GPL(balloon_pages_alloc);
>  
>  /*
>   * balloon_page_enqueue - inserts a new page into the balloon page list.
> @@ -155,6 +162,25 @@ void balloon_page_enqueue(struct balloon_dev_info *b_dev_info,
>  EXPORT_SYMBOL_GPL(balloon_page_enqueue);
>  
>  /*
> + * balloon_pages_enqueue - inserts continuous pages into the balloon page list.
> + */
> +void balloon_pages_enqueue(struct balloon_dev_info *b_dev_info,
> +			   struct page *page, unsigned int order)
> +{
> +	unsigned long flags;
> +	unsigned long pfn = page_to_pfn(page);
> +	unsigned long last_pfn = pfn + (1 << order) - 1;
> +
> +	spin_lock_irqsave(&b_dev_info->pages_lock, flags);
> +	for (; pfn <= last_pfn; pfn++) {
> +		page = pfn_to_page(pfn);
> +		balloon_page_enqueue_one(b_dev_info, page);
> +	}
> +	spin_unlock_irqrestore(&b_dev_info->pages_lock, flags);
> +}
> +EXPORT_SYMBOL_GPL(balloon_pages_enqueue);
> +
> +/*
>   * balloon_page_dequeue - removes a page from balloon's page list and returns
>   *			  its address to allow the driver to release the page.
>   * @b_dev_info: balloon device decriptor where we will grab a page from.
> -- 
> 2.7.4

