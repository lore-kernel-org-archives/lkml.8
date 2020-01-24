Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F55C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C66B020709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 07:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XNlEkrtB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730390AbgAXHcy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 02:32:54 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:42848 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbgAXHcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 02:32:53 -0500
Received: by mail-pg1-f194.google.com with SMTP id s64so567355pgb.9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 23:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XMan5I+mKArqobbqFNZ+gUF18xHrDU9k/d4NqHI6zu4=;
        b=XNlEkrtB5WyC+6KEfcv9h47Qsg6EErvwdpfmokrUteEgzL60mkvaZxTq6BbI6ETlBX
         XdjnC0mX6AeVz20ETbOKynfAkVrQyiIFqpPZoCPcSunnwy6rizJ0b6eKupQONUPo1Rkr
         9Yi3IZ+BzIJwT7Bb5XadFn5dcRZGLuSB5NixY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XMan5I+mKArqobbqFNZ+gUF18xHrDU9k/d4NqHI6zu4=;
        b=kSNo2lncjGnduSl5nWjTqm7uTYkmYpIqzi4/JKuNbJd6ZGUUVt8IUn0TT+9LZnhyd1
         Wr8HZrUDmK2dgFpkC5vVMG635za5L03qyw/eLa0HO/SQUqGRacX8OePBzBH+Y47qGM2r
         LfO4FHQJFwxEMi8jceaNYxf57akp4FDObV+BrBQzJCPcRcdQpuZaBlgwFdLwAI282F36
         XB7IRRtPpA5Wy6LOaJ41utGnt5a72A/cxLYFlk5OVa58hwbagm8zk5hOwyqNMLjbYuiA
         acyf7akLpjB51qZoUh5nHBrWicUYMfZz86qHabdr1yiA/bLwxklP1ihJyxyGY6kJe8Ta
         Y2Kw==
X-Gm-Message-State: APjAAAVNhrBLxZ8t54MUzKKv9UiKK65OSfpqn2Zkh+RNp5x05X5L4Vqf
        sc2HWwg6FOtfb6g4zrfkA+4eEw==
X-Google-Smtp-Source: APXvYqxiUqWwFe+UJfx8sjkXD/VqNusZI+TARTuJH/GXSLaBL6MI+VbKjEv23KOYn+XOWzCHtYk1Pw==
X-Received: by 2002:a63:b64a:: with SMTP id v10mr2701819pgt.145.1579851172840;
        Thu, 23 Jan 2020 23:32:52 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id p5sm5517224pga.69.2020.01.23.23.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 23:32:52 -0800 (PST)
Date:   Fri, 24 Jan 2020 16:32:50 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Hans Verkuil <hans.verkuil@cisco.com>,
        Tomasz Figa <tfiga@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [RFC][PATCH 13/15] videobuf2: do not sync buffers for DMABUF
 queues
Message-ID: <20200124073250.GA100275@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-14-senozhatsky@chromium.org>
 <2d0e1a9b-6c5e-ff70-9862-32c8b8aaf65f@xs4all.nl>
 <20200122050515.GB49953@google.com>
 <57f711a0-6183-74f6-ab24-ebe414cb6881@xs4all.nl>
 <20200124022544.GD158382@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124022544.GD158382@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/24 11:25), Sergey Senozhatsky wrote:
[..]
>
> > Then, if q->allow_cache_hint is set, then default to a cache sync (cache clean)
> > in the prepare for OUTPUT buffers and a cache sync (cache invalidate) in the
> > finish for CAPTURE buffers.
>
> We alter default cache sync behaviour based both on queue ->memory
> type and queue ->dma_dir. Shall both of those cases depend on
> ->allow_cache_hints, or q->memory can be independent?
>
> static void set_buffer_cache_hints(struct vb2_queue *q,
> 				   struct vb2_buffer *vb,
> 				   struct v4l2_buffer *b)
> {
> 	if (!q->allow_cache_hints)
> 		return;
>
> 	/*
> 	 * DMA exporter should take care of cache syncs, so we can avoid
> 	 * explicit ->prepare()/->finish() syncs. For other ->memory types
> 	 * we always need ->prepare() or/and ->finish() cache sync.
> 	 */
> 	if (q->memory == VB2_MEMORY_DMABUF) {
> 		vb->need_cache_sync_on_finish = 0;
> 		vb->need_cache_sync_on_prepare = 0;
> 		return;
> 	}

I personally would prefer this to be above ->allow_cache_hints check,
IOW to be independent. Because we need to skip flush/invalidation for
DMABUF anyway, that's what allocators do in ->prepare() and ->finish()
currently.

	-ss
