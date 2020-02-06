Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E64C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9ED4206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 07:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jtpc6fQm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727974AbgBFHkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 02:40:37 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31682 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726673AbgBFHkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 02:40:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580974834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EJdekxX4jMUtLVjxMV60S/qOhotaSm5D6JfrMI6N2T4=;
        b=Jtpc6fQmkbn5CtC6DLsApTJqnetQHP6t6mGFQe3UKXJyvdaB91yE/b3R93ZlZVEBRQIh0c
        V3ddKM44W+4R4uwxWVqHmnmXck7HGOrmE/bp9Ku8kdzNBpehZTcp4fkEGlVptOf4S2JD/k
        s/gz1xiLsTp9sdMmm+oXV2YzDrLpFcE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-fJ09ololOquY-6C6Ety8-g-1; Thu, 06 Feb 2020 02:40:30 -0500
X-MC-Unique: fJ09ololOquY-6C6Ety8-g-1
Received: by mail-qk1-f200.google.com with SMTP id p3so3028589qkd.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 23:40:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EJdekxX4jMUtLVjxMV60S/qOhotaSm5D6JfrMI6N2T4=;
        b=XBo8PwgsGuy8mDinHxp3sVWZV9GsbeKWJ6wao9E4j/GOByQBoHpUYg+hMRXA86oZJZ
         QW1/WoLyCgJ9zOMq/VQXec42YbQsa0nGnnImkdaS36hHAhDog4e8VVdgZiRNgdZpCtPa
         pDZI6X7kLoMgKx7q9QhbmISGFCO86N8WYLLrzCnjZ67agQPtehznj95IQ8JMY1qwYIOb
         8squVOehmEJaG1k1YCSSm5GNEUQWVdqMHkRZlOAtIXLuXFCS7pJ8ufcmDIrE4uiKfkFD
         ngsQAEjCH9pQCBVUrxOf93if2/bHKdXAwaa5AxdlOEYE5wIGRJw7tTdgJVCpKv+BhzaU
         A0qg==
X-Gm-Message-State: APjAAAU3FpAz+X627xB2HtSI2t6TzhaIwfDcEavgcCb2MaWbnPCOT0uB
        f0TOuZMIDgiDGed0FmLD+u9NJxCASOP5LxyPB3X3F70EAaSyKrpfld42fZ1S/rfBil3N36cZu2L
        +d41O397BGgbpjY2otxb7sReU
X-Received: by 2002:ac8:7396:: with SMTP id t22mr1466423qtp.269.1580974830033;
        Wed, 05 Feb 2020 23:40:30 -0800 (PST)
X-Google-Smtp-Source: APXvYqxZ/Fca/5UE44GyXmSpo9+/WpKcvqDXcqiFba3MynEbHGgMNwWVMKceICaPZSY+4BEmhZG9qQ==
X-Received: by 2002:ac8:7396:: with SMTP id t22mr1466401qtp.269.1580974829687;
        Wed, 05 Feb 2020 23:40:29 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id q7sm1027509qkc.43.2020.02.05.23.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 23:40:28 -0800 (PST)
Date:   Thu, 6 Feb 2020 02:40:24 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>, Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH v1 3/3] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200206013724-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-4-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205163402.42627-4-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:34:02PM +0100, David Hildenbrand wrote:
> Commit 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> changed the behavior when deflation happens automatically. Instead of
> deflating when called by the OOM handler, the shrinker is used.
> 
> However, the balloon is not simply some slab cache that should be
> shrunk when under memory pressure. The shrinker does not have a concept of
> priorities, so this behavior cannot be configured.
> 
> There was a report that this results in undesired side effects when
> inflating the balloon to shrink the page cache. [1]
> 	"When inflating the balloon against page cache (i.e. no free memory
> 	 remains) vmscan.c will both shrink page cache, but also invoke the
> 	 shrinkers -- including the balloon's shrinker. So the balloon
> 	 driver allocates memory which requires reclaim, vmscan gets this
> 	 memory by shrinking the balloon, and then the driver adds the
> 	 memory back to the balloon. Basically a busy no-op."
> 
> The name "deflate on OOM" makes it pretty clear when deflation should
> happen - after other approaches to reclaim memory failed, not while
> reclaiming. This allows to minimize the footprint of a guest - memory
> will only be taken out of the balloon when really needed.
> 
> Especially, a drop_slab() will result in the whole balloon getting
> deflated - undesired. While handling it via the OOM handler might not be
> perfect, it keeps existing behavior. If we want a different behavior, then
> we need a new feature bit and document it properly (although, there should
> be a clear use case and the intended effects should be well described).
> 
> Keep using the shrinker for VIRTIO_BALLOON_F_FREE_PAGE_HINT, because
> this has no such side effects. Always register the shrinker with
> VIRTIO_BALLOON_F_FREE_PAGE_HINT now. We are always allowed to reuse free
> pages that are still to be processed by the guest. The hypervisor takes
> care of identifying and resolving possible races between processing a
> hinting request and the guest reusing a page.
> 
> In contrast to pre commit 71994620bb25 ("virtio_balloon: replace oom
> notifier with shrinker"), don't add a moodule parameter to configure the
> number of pages to deflate on OOM. Can be re-added if really needed.

I agree. And to make this case even stronger:

The oom_pages module parameter was known to be broken: whatever its
value, we return at most VIRTIO_BALLOON_ARRAY_PFNS_MAX.  So module
parameter values > 256 never worked, and it seems highly unlikely that
freeing 1Mbyte on OOM is too aggressive.
There was a patch
 virtio-balloon: deflate up to oom_pages on OOM
by Wei Wang to try to fix it:
https://lore.kernel.org/r/1508500466-21165-3-git-send-email-wei.w.wang@intel.com
but this was dropped.

> Also, pay attention that leak_balloon() returns the number of 4k pages -
> convert it properly in virtio_balloon_oom_notify().

Oh. So it was returning a wrong value originally (before 71994620bb25).
However what really matters for notifiers is whether the value is 0 -
whether we made progress. So it's cosmetic.

> Note1: using the OOM handler is frowned upon, but it really is what we
>        need for this feature.

Quite. However, I went back researching why we dropped the OOM notifier,
and found this:

https://lore.kernel.org/r/1508500466-21165-2-git-send-email-wei.w.wang@intel.com

To quote from there:

The balloon_lock was used to synchronize the access demand to elements
of struct virtio_balloon and its queue operations (please see commit
e22504296d). This prevents the concurrent run of the leak_balloon and
fill_balloon functions, thereby resulting in a deadlock issue on OOM:

fill_balloon: take balloon_lock and wait for OOM to get some memory;
oom_notify: release some inflated memory via leak_balloon();
leak_balloon: wait for balloon_lock to be released by fill_balloon.





> Note2: without VIRTIO_BALLOON_F_MUST_TELL_HOST (iow, always with QEMU) we
>        could actually skip sending deflation requests to our hypervisor,
>        making the OOM path *very* simple. Besically freeing pages and
>        updating the balloon.

Well not exactly. !VIRTIO_BALLOON_F_MUST_TELL_HOST does not actually
mean "never tell host". It means "host will not discard pages in the
balloon, you can defer host notification until after use".

This was the original implementation:

+       if (vb->tell_host_first) {
+               tell_host(vb, vb->deflate_vq);
+               release_pages_by_pfn(vb->pfns, vb->num_pfns);
+       } else {
+               release_pages_by_pfn(vb->pfns, vb->num_pfns);
+               tell_host(vb, vb->deflate_vq);
+       }
+}

I don't know whether completely skipping host notifications
when !VIRTIO_BALLOON_F_MUST_TELL_HOST will break any hosts.

>	 If the communication with the host ever
>        becomes a problem on this call path.
> 
> [1] https://www.spinics.net/lists/linux-virtualization/msg40863.html
> 
> Reported-by: Tyler Sanderson <tysand@google.com>
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Cc: David Rientjes <rientjes@google.com>
> Cc: Nadav Amit <namit@vmware.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  drivers/virtio/virtio_balloon.c | 107 +++++++++++++-------------------
>  1 file changed, 44 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 7e5d84caeb94..e7b18f556c5e 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -14,6 +14,7 @@
>  #include <linux/slab.h>
>  #include <linux/module.h>
>  #include <linux/balloon_compaction.h>
> +#include <linux/oom.h>
>  #include <linux/wait.h>
>  #include <linux/mm.h>
>  #include <linux/mount.h>
> @@ -27,7 +28,9 @@
>   */
>  #define VIRTIO_BALLOON_PAGES_PER_PAGE (unsigned)(PAGE_SIZE >> VIRTIO_BALLOON_PFN_SHIFT)
>  #define VIRTIO_BALLOON_ARRAY_PFNS_MAX 256
> -#define VIRTBALLOON_OOM_NOTIFY_PRIORITY 80
> +/* Maximum number of (4k) pages to deflate on OOM notifications. */
> +#define VIRTIO_BALLOON_OOM_NR_PAGES 256
> +#define VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY 80
>  
>  #define VIRTIO_BALLOON_FREE_PAGE_ALLOC_FLAG (__GFP_NORETRY | __GFP_NOWARN | \
>  					     __GFP_NOMEMALLOC)
> @@ -112,8 +115,11 @@ struct virtio_balloon {
>  	/* Memory statistics */
>  	struct virtio_balloon_stat stats[VIRTIO_BALLOON_S_NR];
>  
> -	/* To register a shrinker to shrink memory upon memory pressure */
> +	/* Shrinker to return free pages - VIRTIO_BALLOON_F_FREE_PAGE_HINT */
>  	struct shrinker shrinker;
> +
> +	/* OOM notifier to deflate on OOM - VIRTIO_BALLOON_F_DEFLATE_ON_OOM */
> +	struct notifier_block oom_nb;
>  };
>  
>  static struct virtio_device_id id_table[] = {
> @@ -786,50 +792,13 @@ static unsigned long shrink_free_pages(struct virtio_balloon *vb,
>  	return blocks_freed * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>  }
>  
> -static unsigned long leak_balloon_pages(struct virtio_balloon *vb,
> -                                          unsigned long pages_to_free)
> -{
> -	return leak_balloon(vb, pages_to_free * VIRTIO_BALLOON_PAGES_PER_PAGE) /
> -		VIRTIO_BALLOON_PAGES_PER_PAGE;
> -}
> -
> -static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
> -					  unsigned long pages_to_free)
> -{
> -	unsigned long pages_freed = 0;
> -
> -	/*
> -	 * One invocation of leak_balloon can deflate at most
> -	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> -	 * multiple times to deflate pages till reaching pages_to_free.
> -	 */
> -	while (vb->num_pages && pages_freed < pages_to_free)
> -		pages_freed += leak_balloon_pages(vb,
> -						  pages_to_free - pages_freed);
> -
> -	update_balloon_size(vb);
> -
> -	return pages_freed;
> -}
> -
>  static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
>  						  struct shrink_control *sc)
>  {
> -	unsigned long pages_to_free, pages_freed = 0;
>  	struct virtio_balloon *vb = container_of(shrinker,
>  					struct virtio_balloon, shrinker);
>  
> -	pages_to_free = sc->nr_to_scan;
> -
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> -		pages_freed = shrink_free_pages(vb, pages_to_free);
> -
> -	if (pages_freed >= pages_to_free)
> -		return pages_freed;
> -
> -	pages_freed += shrink_balloon_pages(vb, pages_to_free - pages_freed);
> -
> -	return pages_freed;
> +	return shrink_free_pages(vb, sc->nr_to_scan);
>  }
>  
>  static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
> @@ -837,26 +806,22 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>  {
>  	struct virtio_balloon *vb = container_of(shrinker,
>  					struct virtio_balloon, shrinker);
> -	unsigned long count;
> -
> -	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> -	count += vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>  
> -	return count;
> +	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>  }
>  
> -static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)
> +static int virtio_balloon_oom_notify(struct notifier_block *nb,
> +				     unsigned long dummy, void *parm)
>  {
> -	unregister_shrinker(&vb->shrinker);
> -}
> +	struct virtio_balloon *vb = container_of(nb,
> +						 struct virtio_balloon, oom_nb);
> +	unsigned long *freed = parm;
>  
> -static int virtio_balloon_register_shrinker(struct virtio_balloon *vb)
> -{
> -	vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
> -	vb->shrinker.count_objects = virtio_balloon_shrinker_count;
> -	vb->shrinker.seeks = DEFAULT_SEEKS;
> +	*freed += leak_balloon(vb, VIRTIO_BALLOON_OOM_NR_PAGES) /
> +		  VIRTIO_BALLOON_PAGES_PER_PAGE;
> +	update_balloon_size(vb);
>  
> -	return register_shrinker(&vb->shrinker);
> +	return NOTIFY_OK;
>  }
>  
>  static int virtballoon_probe(struct virtio_device *vdev)
> @@ -933,22 +898,35 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  			virtio_cwrite(vb->vdev, struct virtio_balloon_config,
>  				      poison_val, &poison_val);
>  		}
> -	}
> -	/*
> -	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
> -	 * shrinker needs to be registered to relieve memory pressure.
> -	 */
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> -		err = virtio_balloon_register_shrinker(vb);
> +
> +		/*
> +		 * We're allowed to reuse any free pages, even if they are
> +		 * still to be processed by the host.
> +		 */
> +		vb->shrinker.scan_objects = virtio_balloon_shrinker_scan;
> +		vb->shrinker.count_objects = virtio_balloon_shrinker_count;
> +		vb->shrinker.seeks = DEFAULT_SEEKS;
> +		err = register_shrinker(&vb->shrinker);
>  		if (err)
>  			goto out_del_balloon_wq;
>  	}
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> +		vb->oom_nb.notifier_call = virtio_balloon_oom_notify;
> +		vb->oom_nb.priority = VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY;
> +		err = register_oom_notifier(&vb->oom_nb);
> +		if (err < 0)
> +			goto out_unregister_shrinker;
> +	}
> +
>  	virtio_device_ready(vdev);
>  
>  	if (towards_target(vb))
>  		virtballoon_changed(vdev);
>  	return 0;
>  
> +out_unregister_shrinker:
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		unregister_shrinker(&vb->shrinker);
>  out_del_balloon_wq:
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		destroy_workqueue(vb->balloon_wq);
> @@ -987,8 +965,11 @@ static void virtballoon_remove(struct virtio_device *vdev)
>  {
>  	struct virtio_balloon *vb = vdev->priv;
>  
> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> -		virtio_balloon_unregister_shrinker(vb);
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> +		unregister_oom_notifier(&vb->oom_nb);
> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> +		unregister_shrinker(&vb->shrinker);
> +
>  	spin_lock_irq(&vb->stop_update_lock);
>  	vb->stop_update = true;
>  	spin_unlock_irq(&vb->stop_update_lock);
> -- 
> 2.24.1

