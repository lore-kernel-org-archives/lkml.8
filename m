Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6AAC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BA7921775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 09:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eNFIuJzL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgBFJEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 04:04:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53024 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726452AbgBFJEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 04:04:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580979874;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=u+qkwfnp/KTTLaMdjyM+vV6SHYAbouc0gSH5Oc/Hljw=;
        b=eNFIuJzLK3A/lIQzdVnuPeoFAEUZ00JXEJi6Ak08x0HqYjNm86fFLWJw+g4I3s+wK90B8u
        9uCyRYmUDht4R75CclbdoTcjoeZ5lJNF0t0b5DG4n15zHpK0mcDfFy1aMkNA95ii75gHJs
        1uIEkDN3hjtVId/Ae4d/uBqZwwabCBY=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-vYf2zWDRPGSea9LTtOnbiA-1; Thu, 06 Feb 2020 04:04:27 -0500
X-MC-Unique: vYf2zWDRPGSea9LTtOnbiA-1
Received: by mail-qv1-f69.google.com with SMTP id k2so3244738qvu.22
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 01:04:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u+qkwfnp/KTTLaMdjyM+vV6SHYAbouc0gSH5Oc/Hljw=;
        b=eMFQF1wXD/+orKmB0tZX//vbhhPhxxac+6CXowIJ3xvMi+BVRBeP6tJ5AIbPYh5PxE
         /fjRA+tEIFJ/gTIMG4bOs6ZGzNvshozgjqMyqa+CAwuQhY9Ou08pO9gmge4DJ/+sEvXg
         0mdmZ4fwQb0Ze1yqzuAVBTe0w/DORttD4942q1ISUKPgXd1bd1WW9kILM0CLBhfTHcdB
         x6rK8/i1kxxgbBdKkkCLYQU9rJTW5lcGj3kZf+p2D3LlKtQvOQiPJN/qsZn0dDeF0bNj
         dwZvdJVRA6CO8CMzZco789ckry2PV1MoHHg1uj5U8qGowj9guuKAw4s4OFMZTLdoRvzF
         fpmw==
X-Gm-Message-State: APjAAAVDIuOxRGmjpoUWUA8DMsJWphOqGWXGCiARjBXpvYNYihjgbqC0
        lOkewY0PVfkj1KaoK3nZMX2nYyww5htpDUO96uwzQSS+hFcLpQtnBn8jsB0YMd9/iOxqozYB8/7
        o82fMnQfuQ9JQJ7kvRBpPBWfG
X-Received: by 2002:a05:6214:1267:: with SMTP id r7mr1480791qvv.160.1580979867105;
        Thu, 06 Feb 2020 01:04:27 -0800 (PST)
X-Google-Smtp-Source: APXvYqySvSBmE5xPypmInGDp+iFwB4kmBupJhzPCzwonGKaDhbeI2Tsll81uaJmjg40xH+Jpub/H7Q==
X-Received: by 2002:a05:6214:1267:: with SMTP id r7mr1480773qvv.160.1580979866830;
        Thu, 06 Feb 2020 01:04:26 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id 205sm1121279qkd.61.2020.02.06.01.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 01:04:25 -0800 (PST)
Date:   Thu, 6 Feb 2020 04:04:21 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Wei Wang <wei.w.wang@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, tysand@google.com,
        david@redhat.com, alexander.h.duyck@linux.intel.com,
        rientjes@google.com, mhocko@kernel.org, namit@vmware.com,
        penguin-kernel@i-love.sakura.ne.jp
Subject: Re: [PATCH RFC] virtio_balloon: conservative balloon page shrinking
Message-ID: <20200206035749-mutt-send-email-mst@kernel.org>
References: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580976107-16013-1-git-send-email-wei.w.wang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 04:01:47PM +0800, Wei Wang wrote:
> There are cases that users want to shrink balloon pages after the
> pagecache depleted. The conservative_shrinker lets the shrinker
> shrink balloon pages when all the pagecache has been reclaimed.
> 
> Signed-off-by: Wei Wang <wei.w.wang@intel.com>

I'd rather avoid module parameters, but otherwise looks 
like a reasonable idea.
Tyler, what do you think?


> ---
>  drivers/virtio/virtio_balloon.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index 93f995f6cf36..b4c5bb13a867 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -42,6 +42,10 @@
>  static struct vfsmount *balloon_mnt;
>  #endif
>  
> +static bool conservative_shrinker = true;
> +module_param(conservative_shrinker, bool, 0644);
> +MODULE_PARM_DESC(conservative_shrinker, "conservatively shrink balloon pages");
> +
>  enum virtio_balloon_vq {
>  	VIRTIO_BALLOON_VQ_INFLATE,
>  	VIRTIO_BALLOON_VQ_DEFLATE,
> @@ -796,6 +800,10 @@ static unsigned long shrink_balloon_pages(struct virtio_balloon *vb,
>  {
>  	unsigned long pages_freed = 0;
>  
> +	/* Balloon pages only gets shrunk when the pagecache depleted */
> +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))
> +		return 0;
> +
>  	/*
>  	 * One invocation of leak_balloon can deflate at most
>  	 * VIRTIO_BALLOON_ARRAY_PFNS_MAX balloon pages, so we call it
> @@ -837,7 +845,11 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
>  					struct virtio_balloon, shrinker);
>  	unsigned long count;
>  
> -	count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> +	if (conservative_shrinker && global_node_page_state(NR_FILE_PAGES))

I'd rather have an API for that in mm/. In particular, do we want other
shrinkers to run, not just pagecache? To pick an example I'm familiar
with, kvm mmu cache for nested virt?

> +		count = 0;
> +	else
> +		count = vb->num_pages / VIRTIO_BALLOON_PAGES_PER_PAGE;
> +
>  	count += vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
>  
>  	return count;
> -- 
> 2.17.1

