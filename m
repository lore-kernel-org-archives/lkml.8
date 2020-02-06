Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75052C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4794B214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:36:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A9iA0IHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgBFIgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:36:49 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23155 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727947AbgBFIgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:36:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580978207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UeqMGJ0PCFB3EIVnqhK1jSaquiglkcj5+WjsBZdqSko=;
        b=A9iA0IHoTxy95rgTdYlpYIZZCLTCWt6+74bZ+hLN+nqgBcaA+9Qep/jgCitIovTLz34XTq
        uPIfzWVQKs22gYXWQ1Xn2BATemb47lnfwpJC9yhd8QlUqlVNokkCh2J7cQyVoiUXWFzy5Q
        XLgenvi461mWHVwXdFRAT/rvnShRgYQ=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-222-1ep5lFy2ML26Qsctnq0i5w-1; Thu, 06 Feb 2020 03:36:46 -0500
X-MC-Unique: 1ep5lFy2ML26Qsctnq0i5w-1
Received: by mail-qt1-f199.google.com with SMTP id k27so3333448qtu.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:36:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UeqMGJ0PCFB3EIVnqhK1jSaquiglkcj5+WjsBZdqSko=;
        b=dzEkW+z1E+ArM8EvQoSFTIdLAhdFTgBN6fO8/2CIsPlCpHkqSpZf/E6wkVcIS9Y7Cg
         yLsgauXgD8YFU3SND1ciJlSiowiQCrqFU74VdBQjkrlUbgM/bYx+rUalGocNIlHUe+uB
         25/pwvM0Sfhtlu7e5qyXESEGypdqFv1K4X+tkAcbWnM87xSItBSozqXE5Ilcbl3U4tvQ
         oFqGe0Dofw+j9wB0yD91i+p48vyWBSGEJ1vAENNxMP+TfP3C2n0vFKrc+7zqt0wQep2b
         ig53ZjKar4pTRU5cdM77+almHFY3NoHt5w31q9AVAOnnTQL9You3hEzV1fwLALE+rNfC
         I0CA==
X-Gm-Message-State: APjAAAWqIWOBauwfTI9lS0FSSNBjVXQCvF87iQgvmTR/1EozIZIk3zeE
        c0LAu25o/tBVM/iICzE2Lfop+AaPZnF+K5eO1mISTkHybGn0HhFt/4HJ0+WHOO4kwQ9XVMO9cSA
        SgmG7rlWz3qLj8WGnkloTrcQ6
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr1537142qkj.50.1580978205752;
        Thu, 06 Feb 2020 00:36:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyCKYXTQb5/Fvn9PbpxsKDUKXGEA9EWCZqxmPKBdJhbBBol0FsQni5dbhdPQ8ikBYhqnUwfBQ==
X-Received: by 2002:a05:620a:133a:: with SMTP id p26mr1537132qkj.50.1580978205547;
        Thu, 06 Feb 2020 00:36:45 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id h3sm1085355qkk.104.2020.02.06.00.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 00:36:44 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:36:40 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Liang Li <liang.z.li@intel.com>
Subject: Re: [PATCH v1 2/3] virtio_balloon: Fix memory leaks on errors in
 virtballoon_probe()
Message-ID: <20200206033633-mutt-send-email-mst@kernel.org>
References: <20200205163402.42627-1-david@redhat.com>
 <20200205163402.42627-3-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205163402.42627-3-david@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 05:34:01PM +0100, David Hildenbrand wrote:
> We forget to put the inode and unmount the kernfs used for compaction.
> 
> Fixes: 71994620bb25 ("virtio_balloon: replace oom notifier with shrinker")
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Wei Wang <wei.w.wang@intel.com>
> Cc: Liang Li <liang.z.li@intel.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Applied, thanks!

> ---
>  drivers/virtio/virtio_balloon.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index abef2306c899..7e5d84caeb94 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -901,8 +901,7 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  	vb->vb_dev_info.inode = alloc_anon_inode(balloon_mnt->mnt_sb);
>  	if (IS_ERR(vb->vb_dev_info.inode)) {
>  		err = PTR_ERR(vb->vb_dev_info.inode);
> -		kern_unmount(balloon_mnt);
> -		goto out_del_vqs;
> +		goto out_kern_unmount;
>  	}
>  	vb->vb_dev_info.inode->i_mapping->a_ops = &balloon_aops;
>  #endif
> @@ -913,13 +912,13 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  		 */
>  		if (virtqueue_get_vring_size(vb->free_page_vq) < 2) {
>  			err = -ENOSPC;
> -			goto out_del_vqs;
> +			goto out_iput;
>  		}
>  		vb->balloon_wq = alloc_workqueue("balloon-wq",
>  					WQ_FREEZABLE | WQ_CPU_INTENSIVE, 0);
>  		if (!vb->balloon_wq) {
>  			err = -ENOMEM;
> -			goto out_del_vqs;
> +			goto out_iput;
>  		}
>  		INIT_WORK(&vb->report_free_page_work, report_free_page_func);
>  		vb->cmd_id_received_cache = VIRTIO_BALLOON_CMD_ID_STOP;
> @@ -953,6 +952,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
>  out_del_balloon_wq:
>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
>  		destroy_workqueue(vb->balloon_wq);
> +out_iput:
> +#ifdef CONFIG_BALLOON_COMPACTION
> +	iput(vb->vb_dev_info.inode);
> +out_kern_unmount:
> +	kern_unmount(balloon_mnt);
> +#endif
>  out_del_vqs:
>  	vdev->config->del_vqs(vdev);
>  out_free_vb:
> -- 
> 2.24.1

