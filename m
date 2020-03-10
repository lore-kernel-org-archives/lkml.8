Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CBCC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:19:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 947D22468C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:19:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VpxfH9xC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCJLT0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:19:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:37846 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726186AbgCJLT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:19:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583839164;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qfsU9Bh+9ERXSvjXe/Jnk6fWHOirWhBhsnum3jMiYw8=;
        b=VpxfH9xCfCaBgIZpeBibodLU39T+Z9rrYfDhdSqRh2sBE4f0kh+HoG29znNzJs8zDppTgA
        7AhNLMxF5rC1QsMOcauP06cfiXzj7HmVpusZSs4dYw3yhWkxwE5akUlbB4Bc5+fXMpydXk
        DDr324GUg2Fvbx9Cx8zA1kXITn/KBU8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-iZZFG3kyPZe1avT3tnznEg-1; Tue, 10 Mar 2020 07:19:20 -0400
X-MC-Unique: iZZFG3kyPZe1avT3tnznEg-1
Received: by mail-qt1-f199.google.com with SMTP id q7so8872566qtp.16
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 04:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qfsU9Bh+9ERXSvjXe/Jnk6fWHOirWhBhsnum3jMiYw8=;
        b=M+Vozi4xKkimPOn0/YZ+bxtB01JCAGcock/Q+0ombsOM3BGcN8VsZahy9om0HsXIgM
         5LoDxKKv20BQUY2/VaYrO4aSS27HcMPcAAakHaX+11PObxfRSS4wo1BGOgiW/AyQAvQa
         /VIfsNEURTxs28emb31W8dse13S9LrAVEp26gKdHq4RU4gshUiv1EwxLleOWASm7ZBKm
         n2LKGcQdCU31ZhUh7hXBDOJcfQSQ8Kxblb6nHQ01pm557Bhr/in8ajDozYPElPR8Yalk
         6E6bj2c5OnzIFVnokiI+vwI7yZDuw6iFHojW3Cf/TCxAMXyZj7slvA4UaThCb4OjfeJg
         Xltw==
X-Gm-Message-State: ANhLgQ0MoiaYppdl4Va1wcafoQO6y/cYZsdURC/ehMbQzYbRSUeAy3Mf
        Tk7RJPTSVZK8rbZ+yJI0lu0zz6tU6oVu9xGu/FDQzjLvQ4Q9/dEFxAmLetTVtr55Ltn7NctRZRP
        I6EqTKipu4lHt4zsUqyI8426f
X-Received: by 2002:a37:4141:: with SMTP id o62mr18336382qka.282.1583839160118;
        Tue, 10 Mar 2020 04:19:20 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvFQXTyeq0C9+jsN/NWv2w1PTOeNblibyZ7JGEqrKf11uCaqcYvWES5T61GOlUp4h635fOhPA==
X-Received: by 2002:a37:4141:: with SMTP id o62mr18336356qka.282.1583839159836;
        Tue, 10 Mar 2020 04:19:19 -0700 (PDT)
Received: from redhat.com (bzq-79-178-2-19.red.bezeqint.net. [79.178.2.19])
        by smtp.gmail.com with ESMTPSA id e130sm23973211qkb.72.2020.03.10.04.19.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 04:19:18 -0700 (PDT)
Date:   Tue, 10 Mar 2020 07:19:13 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Jason Wang <jasowang@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Tyler Sanderson <tysand@google.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Nadav Amit <namit@vmware.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2] virtio-balloon: Switch back to OOM handler for
 VIRTIO_BALLOON_F_DEFLATE_ON_OOM
Message-ID: <20200310071844-mutt-send-email-mst@kernel.org>
References: <20200310103903.6014-1-david@redhat.com>
 <20200310070413-mutt-send-email-mst@kernel.org>
 <78427916-fc17-b081-6b1e-cbcb00d51752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78427916-fc17-b081-6b1e-cbcb00d51752@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 12:12:50PM +0100, David Hildenbrand wrote:
> >>  static void virtio_balloon_unregister_shrinker(struct virtio_balloon *vb)
> >> @@ -971,7 +950,22 @@ static int virtballoon_probe(struct virtio_device *vdev)
> >>  						  VIRTIO_BALLOON_CMD_ID_STOP);
> >>  		spin_lock_init(&vb->free_page_list_lock);
> >>  		INIT_LIST_HEAD(&vb->free_page_list);
> >> +		/*
> >> +		 * We're allowed to reuse any free pages, even if they are
> >> +		 * still to be processed by the host.
> >> +		 */
> >> +		err = virtio_balloon_register_shrinker(vb);
> >> +		if (err)
> >> +			goto out_del_balloon_wq;
> >>  	}
> >> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> >> +		vb->oom_nb.notifier_call = virtio_balloon_oom_notify;
> >> +		vb->oom_nb.priority = VIRTIO_BALLOON_OOM_NOTIFY_PRIORITY;
> >> +		err = register_oom_notifier(&vb->oom_nb);
> >> +		if (err < 0)
> >> +			goto out_unregister_shrinker;
> >> +	}
> >> +
> > 
> > 
> > Let's decide whether we want an empty line after }, or not, and stick to
> > it. I prefer an empty line but no biggie as long as we are consistent.
> 
> Can add one.
> 
> > 
> >>  	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON)) {
> >>  		/* Start with poison val of 0 representing general init */
> >>  		__u32 poison_val = 0;
> >> @@ -986,15 +980,6 @@ static int virtballoon_probe(struct virtio_device *vdev)
> >>  		virtio_cwrite(vb->vdev, struct virtio_balloon_config,
> >>  			      poison_val, &poison_val);
> >>  	}
> >> -	/*
> >> -	 * We continue to use VIRTIO_BALLOON_F_DEFLATE_ON_OOM to decide if a
> >> -	 * shrinker needs to be registered to relieve memory pressure.
> >> -	 */
> >> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM)) {
> >> -		err = virtio_balloon_register_shrinker(vb);
> >> -		if (err)
> >> -			goto out_del_balloon_wq;
> >> -	}
> >>  
> >>  	vb->pr_dev_info.report = virtballoon_free_page_report;
> >>  	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
> >> @@ -1003,12 +988,12 @@ static int virtballoon_probe(struct virtio_device *vdev)
> >>  		capacity = virtqueue_get_vring_size(vb->reporting_vq);
> >>  		if (capacity < PAGE_REPORTING_CAPACITY) {
> >>  			err = -ENOSPC;
> >> -			goto out_unregister_shrinker;
> >> +			goto out_unregister_oom;
> >>  		}
> >>  
> >>  		err = page_reporting_register(&vb->pr_dev_info);
> >>  		if (err)
> >> -			goto out_unregister_shrinker;
> >> +			goto out_unregister_oom;
> >>  	}
> >>  
> >>  	virtio_device_ready(vdev);
> >> @@ -1017,8 +1002,11 @@ static int virtballoon_probe(struct virtio_device *vdev)
> >>  		virtballoon_changed(vdev);
> >>  	return 0;
> >>  
> >> +out_unregister_oom:
> >> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> >> +		unregister_oom_notifier(&vb->oom_nb);
> >>  out_unregister_shrinker:
> >> -	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_DEFLATE_ON_OOM))
> >> +	if (virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
> >>  		virtio_balloon_unregister_shrinker(vb);
> > 
> > 
> > What's with vdev versus vb->vdev here?
> > I suggest we keep using vb->vdev to make the patch minimal if we can.
> > Same elsewhere.
> 
> As we touch this line either way, does it really make a difference? No
> strong opinion. Can just do a vb->vdev and clean this up globally later.
> 

Let's just be consistent. I guess that means keep using vb->vdev
everywhere.

> -- 
> Thanks,
> 
> David / dhildenb

