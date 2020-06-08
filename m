Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52AD5C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 219F72072F
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 09:41:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiD4htHE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729284AbgFHJl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 05:41:56 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25610 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729181AbgFHJlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 05:41:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591609314;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eH4Nj/mEDxjXnJZydIL7THbb14TLlM743flISB4xVNo=;
        b=GiD4htHERYI/NaEO5+aSa3ilgO38YjEf6O5XNDQNt4uwrcSVyF4TF+jMTLpHCJxFCVsQPG
        Kb6F/9LOiPg8EeB3Y3NTXo+m8F3NF9WYw/QDvx9fgyrDEnyIANZ3mm4bz9IYuZ37rpuLwi
        vUTnmQvhXuhJoCuAp34gOURH8TVmIWA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-4uRmv8fyOdykV-NTT0j6kw-1; Mon, 08 Jun 2020 05:41:51 -0400
X-MC-Unique: 4uRmv8fyOdykV-NTT0j6kw-1
Received: by mail-wm1-f72.google.com with SMTP id k185so3730658wme.8
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 02:41:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eH4Nj/mEDxjXnJZydIL7THbb14TLlM743flISB4xVNo=;
        b=YMF84i1CMQ62U4hJZpSOXojvQrpHdH1yrw3Tml87gfbg+2KC6qoZ/MYBSSP8sEWYgG
         0G7QM2abzIXvE2vqCq41Am4jBR1XEUK4AKXy72Va2hvnipbDcaQY/Rp3YY3oYJyYxbp8
         t2PPr3jfm4PiUxOvukBIew60Pe//v8tkle/xk4HD6NVIfpTYMudsQxFPOVgOo2euuVbt
         lm3676ViKbo5yvHmVL117LEEZOY81bDv34w32ORQKp1G/w4fI/x9pPdtNFq+xJ7nKt/X
         DdFXSaVJKPx3/3iQJkoeUwtw7Z724y7JLAHO+w73pPjecF1aR16uF0YzhfNS21BNXDbG
         vgPA==
X-Gm-Message-State: AOAM533wbq3ES/lODgq8exXScuah0seO/E52cuo3yVAJ66JnXhrOY2Wh
        nLHUVNBbPfThCoew9+ImiAn9lFOlO+0z4mSnRZOgIGo6tK4PG+cLq1n7LlzJiZKckjpoUik8l7p
        9vFipwDpTlTTB0NphJECUSQV6
X-Received: by 2002:a5d:6550:: with SMTP id z16mr24245126wrv.392.1591609310076;
        Mon, 08 Jun 2020 02:41:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYIMMXmu8GESaNXodyPnwn38PxVgpU501X6dYPU1Y3LfCjdYX5cV5ZynextIUdAL24kIrlKg==
X-Received: by 2002:a5d:6550:: with SMTP id z16mr24245102wrv.392.1591609309872;
        Mon, 08 Jun 2020 02:41:49 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id w17sm23341647wra.71.2020.06.08.02.41.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2020 02:41:48 -0700 (PDT)
Date:   Mon, 8 Jun 2020 05:41:46 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        virtualization@lists.linux-foundation.org,
        teawater <teawaterz@linux.alibaba.com>
Subject: Re: [PATCH] virtio_mem: prevent overflow with subblock size
Message-ID: <20200608053807-mutt-send-email-mst@kernel.org>
References: <20200608061406.709211-1-mst@redhat.com>
 <0930c9d0-0708-c079-29bd-b80d4e3ce446@redhat.com>
 <20200608030423-mutt-send-email-mst@kernel.org>
 <d10e9515-8408-037c-385a-d69259ce70ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d10e9515-8408-037c-385a-d69259ce70ee@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:17:45AM +0200, David Hildenbrand wrote:
> On 08.06.20 09:08, Michael S. Tsirkin wrote:
> > On Mon, Jun 08, 2020 at 08:58:31AM +0200, David Hildenbrand wrote:
> >> On 08.06.20 08:14, Michael S. Tsirkin wrote:
> >>> If subblock size is large (e.g. 1G) 32 bit math involving it
> >>> can overflow. Rather than try to catch all instances of that,
> >>> let's tweak block size to 64 bit.
> >>
> >> I fail to see where we could actually trigger an overflow. The reported
> >> warning looked like a false positive to me.
> > 
> > 
> > So
> > 
> >     const uint64_t size = count * vm->subblock_size;
> > 
> > is it unreasonable for count to be 4K with subblock_size being 1M?
> 
> virtio_mem_mb_plug_sb() and friends are only called on subblocks
> residing within a single Linux memory block. (currently, 128MB .. 2G on
> x86-64). A subblock on x86-64 is currently at least 4MB.
> 
> So "count * vm->subblock_size" can currently not exceed the Linux memory
> block size (in practice, it is max 128MB).
> 
> > 
> >>>
> >>> It ripples through UAPI which is an ABI change, but it's not too late to
> >>> make it, and it will allow supporting >4Gbyte blocks while might
> >>> become necessary down the road.
> >>>
> >>
> >> This might break cloud-hypervisor, who's already implementing this
> >> protocol upstream (ccing Hui).
> >> https://github.com/cloud-hypervisor/cloud-hypervisor/blob/master/vm-virtio/src/mem.rs
> >>
> >> (blocks in the gigabyte range were never the original intention of
> >> virtio-mem, but I am not completely opposed to that)
> > 
> > 
> > So in that case, can you code up validation in the probe function?
> 
> If we would currently have a "block_size" > Linux memory block size, we
> bail out.
> 
> virtio_mem_init():
> 
> if (vm->device_block_size > memory_block_size_bytes()) {
> 	dev_err(&vm->vdev->dev,
> 		"The block size is not supported (too big).\n");
> 	return -EINVAL;
> }

Sounds good.

> So what's reported can currently not happen. Having that said, changing
> "subblock_size" to be an uint64_t is a good cleanup, especially for the
> future.

OK, no need to argue about it then. I tweaked the subject as you
suggested and queued it then.

> 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb

