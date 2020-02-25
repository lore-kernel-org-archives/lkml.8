Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 081FDC35DF9
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF0B21744
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nOYYA/Ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729606AbgBYHpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:45:17 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:32787 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbgBYHpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:45:16 -0500
Received: by mail-pj1-f66.google.com with SMTP id m7so783087pjs.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 23:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y3Ufh0kd/NDODhpeTidFsO93dE8ZQpNceOjFTvbhgb0=;
        b=nOYYA/Ac6VFG5NfRwmfAEJ4IfTRDbeldgM5X2zcA5j8Z7IlkgVRdAzrr9kqhw+RXl9
         PZ39EN+SDpiIdCNOXZvzsevW2JA/Feb/cDugzP93qv5XtrRr4gbks1lXmyHSo2urpH4x
         OuzrRkfTrfKDKf27hmfoyzc8mTl5Bw1EANs1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y3Ufh0kd/NDODhpeTidFsO93dE8ZQpNceOjFTvbhgb0=;
        b=DJCJypcnJYiHprrInRhQckm/UeOXWC2hdk41gp56DbBfDe3Zi5qvOjE9aTtCn5cdj9
         +8dtAkuO7f8fvyxPfu/GXPNY9kZqIfEzDe/5CpWGBdXof9JYUHinMLVb5VrhGd4dolTd
         YfxK4DKyeA+neKw4LWjbkoXk1RwJZG3HX1Nvz96ZYrQwHn1X9ibeddtS9gzW1XDQVKgK
         SO1UeiR/0J6ZPAWSnBS0HvJ1kYsGvWs4WVmkpRXJDWhN5mgEAZ77PPf4vgwcldBwf3Jg
         BZzjFzcieVF04siTvG06582nnwq1LRvFKSDZk3F3FJvgl3Hc/U4jwd0SuzZ0KXGAfmWU
         eWrA==
X-Gm-Message-State: APjAAAVEIXFIujthjstUJiVrhbC0+IhsGu9JYlxVuAU2E9ytTrCVLgSK
        C/+kZVFYgSyRZq2Zk29DKvuAu/MHT7M=
X-Google-Smtp-Source: APXvYqw+OtdPhv71cEVpj1CHeSNUV34jLiWZgbpas0TvOZlGuIXh21hYDCPdDfILJBF0LqX0Sjr+kQ==
X-Received: by 2002:a17:90b:f06:: with SMTP id br6mr3598849pjb.125.1582616715978;
        Mon, 24 Feb 2020 23:45:15 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id 3sm1952581pjg.27.2020.02.24.23.45.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 23:45:15 -0800 (PST)
Date:   Tue, 25 Feb 2020 16:45:12 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCHv2 03/12] videobuf2: add
 V4L2_FLAG_MEMORY_NON_CONSISTENT flag
Message-ID: <20200225074512.GG122464@google.com>
References: <20200204025641.218376-1-senozhatsky@chromium.org>
 <20200204025641.218376-4-senozhatsky@chromium.org>
 <17e99adc-d86d-ebd3-ab52-d6c8e3ac14f3@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17e99adc-d86d-ebd3-ab52-d6c8e3ac14f3@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/19 09:56), Hans Verkuil wrote:
> > +Memory Consistency Flags
> > +========================
> > +
> > +.. tabularcolumns:: |p{7.0cm}|p{2.2cm}|p{8.3cm}|
> > +
> > +.. cssclass:: longtable
> > +
> > +.. flat-table::
> > +    :header-rows:  0
> > +    :stub-columns: 0
> > +    :widths:       3 1 4
> > +
> > +    * .. _`V4L2_FLAG_MEMORY_NON_CONSISTENT`:
> > +
> > +      - ``V4L2_FLAG_MEMORY_NON_CONSISTENT``
> > +      - 0x00000001
> > +      - vb2 buffer is allocated either in consistent (it will be automatically
> > +	coherent between CPU and bus) or non-consistent memory. The latter
> > +	can provide performance gains, for instance CPU cache sync/flush
> > +	operations can be avoided if the buffer is accesed by the corresponding
> > +	device only and CPU does not read/write to/from that buffer. However,
> > +	this requires extra care from the driver -- it must guarantee memory
> > +	consistency by issuing cache flush/sync when consistency is needed.
> > +	If this flag is set V4L2 will attempt to allocate vb2 buffer in
> > +	non-consistent memory. This flag is ignored if queue does not report
> > +        :ret:`V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS` capability.
> 
> This flag only makes sense for the MMAP memory model, right? That should be
> documented and checked in the code.

Not all buffer allocators respect DMA attrs (V4L2_FLAG_MEMORY_NON_CONSISTENT
is a DMA attribute) even if we use MMAP memory model. Right? E.g. dma-cont
does, dma-sg - does not.

So the list is:

  a) buffer allocated for MMAP I/O
  b) buffer allocator which does not allocate pages from kernel page
     allocator
  c) queue that supports user space cache hints

If the driver does not set vb2_dma_contig_memops as q->mem_ops then
that queue should not have ->allow_cache_hints set. But even if it does,
the flag is ignored by the allocator.

So maybe the text can be:

+       ................... The flag takes effect only if the buffer is
+       used for :ref:`memory mapping <mmap>` I/O and the queue reports
+       :ref:`V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS` capability.

	-ss
