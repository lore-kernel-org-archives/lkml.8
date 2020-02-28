Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6554BC3F2C6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D0DF24697
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 01:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kn6ceABU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730555AbgB1Bjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 20:39:54 -0500
Received: from mail-pf1-f180.google.com ([209.85.210.180]:41610 "EHLO
        mail-pf1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730343AbgB1Bjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:39:53 -0500
Received: by mail-pf1-f180.google.com with SMTP id j9so815812pfa.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9ubhH+dy/KSupIMOx/TfbizuLMWROXg/fbsaRaNRNTQ=;
        b=kn6ceABUO1Cc9o/V8RvE+BqRYIyMsLD7pkXnml/p+HBLTYwCD+seLQyeDd0N9VMMnG
         vA0eeXqPycMIBRwi21uFYZmEimkivcLv1xtkFSCpPPlUO+uWfwgn8lBxfHCkBxDo5VkT
         Wcp/SSjpRs/pkuS4oVeGna37qWSEBUfzoNSYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9ubhH+dy/KSupIMOx/TfbizuLMWROXg/fbsaRaNRNTQ=;
        b=GeCKeRBm3RbgeTLWvUvQ9eFF7E/MSH0VBgTLxivIBiNBMe0vADuaPODkR+gmAHKcVP
         gpDNDV474BcUhGJ843rRHAVKwgMCzX+/NEkzLU6z5LEJICivR10IcXxBy+NMQ5ntCtqX
         G096/BFItN5KtskD9lcEa5/3CMU0Xt0ltJumqSbC6ZQZG8LY9KnM4zWs4W+1GZhLZvrM
         rmijOHIHdxx1wBry+kyp8Kl412CHzlFOnq/m8CuE9NK7JoOHkHOredvF1zPwSyvOqGl/
         vlIzmBN4sbCDugrtOTf++Q5Vi/haTb8dE2VFHyY5YOaKca/juJ0aq4uSE/QdqOMbu6ex
         IFCA==
X-Gm-Message-State: APjAAAX2GLW0jLN0VERyDb/Epuh0LeC66gDi5jKoV4C9fYnsDvGeHu4B
        +rR36u3NytqyylkoR+n2cM8+Ew==
X-Google-Smtp-Source: APXvYqwXJNUP/+3kTTLyhDAQADeR4ErEhnIePa8ycI/oJfpnfCEKZv9NCRbU5AulBzJli9QLESZNJg==
X-Received: by 2002:a63:fe0a:: with SMTP id p10mr2119535pgh.96.1582853991077;
        Thu, 27 Feb 2020 17:39:51 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id q17sm8385815pfg.123.2020.02.27.17.39.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 17:39:50 -0800 (PST)
Date:   Fri, 28 Feb 2020 10:39:48 +0900
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
Subject: Re: [PATCHv3 03/11] videobuf2: add V4L2_FLAG_MEMORY_NON_CONSISTENT
 flag
Message-ID: <20200228013948.GN122464@google.com>
References: <20200226111529.180197-1-senozhatsky@chromium.org>
 <20200226111529.180197-4-senozhatsky@chromium.org>
 <19422259-f9ca-8715-508a-0f650d2fa0e3@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <19422259-f9ca-8715-508a-0f650d2fa0e3@xs4all.nl>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/02/27 13:25), Hans Verkuil wrote:
[..]
> > +      - vb2 buffer is allocated either in consistent (it will be automatically
> 
> vb2 -> A
> 
> (vb2 is a kAPI term, and shouldn't be used in uAPI documentation)
> 
> > +	coherent between CPU and bus) or non-consistent memory. The latter
> 
> CPU and bus -> the CPU and the bus
> 
> > +	can provide performance gains, for instance CPU cache sync/flush
> 
> CPU -> the CPU
> 
> > +	operations can be avoided if the buffer is accessed by the corresponding
> > +	device only and CPU does not read/write to/from that buffer. However,
> 
> CPU -> the CPU
> 
> > +	this requires extra care from the driver -- it must guarantee memory
> > +	consistency by issuing cache flush/sync when consistency is needed.
> 
> cache -> a cache
> 
> > +	If this flag is set V4L2 will attempt to allocate vb2 buffer in
> 
> vb2 -> the
> 
> > +	non-consistent memory. The flag takes effect only if the buffer is
> > +	used for :ref:`memory mapping <mmap>` I/O and the queue reports
> 
> reports -> reports the

OK.

> > +++ b/Documentation/media/uapi/v4l/vidioc-reqbufs.rst
> > @@ -156,6 +156,13 @@ aborting or finishing any DMA in progress, an implicit
> >        - Only valid for stateless decoders. If set, then userspace can set the
> >          ``V4L2_BUF_FLAG_M2M_HOLD_CAPTURE_BUF`` flag to hold off on returning the
> >  	capture buffer until the OUTPUT timestamp changes.
> > +    * - ``V4L2_BUF_CAP_SUPPORTS_CACHE_HINTS``
> > +      - 0x00000040
> > +      - Set when the queue/buffer support memory consistency and cache
> 
> support -> supports

OK.

> > +++ b/drivers/media/common/videobuf2/videobuf2-v4l2.c
> > @@ -711,6 +711,8 @@ static void fill_buf_caps(struct vb2_queue *q, u32 *caps)
> >  		*caps |= V4L2_BUF_CAP_SUPPORTS_DMABUF;
> >  	if (q->subsystem_flags & VB2_V4L2_FL_SUPPORTS_M2M_HOLD_CAPTURE_BUF)
> >  		*caps |= V4L2_BUF_CAP_SUPPORTS_M2M_HOLD_CAPTURE_BUF;
> > +	if ((q->allow_cache_hints != 0) && (q->io_modes & VB2_MMAP))
> 
> Just say:
> 
> 	if (q->allow_cache_hints && (q->io_modes & VB2_MMAP))

OK.

	-ss
