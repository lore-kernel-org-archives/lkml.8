Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3040EC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06B3E22522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P9e0Kdar"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgA1HfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:35:00 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:39841 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgA1He6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:34:58 -0500
Received: by mail-pj1-f65.google.com with SMTP id e9so625046pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CQgtos6gVXtQDMK7WmwCsXfSvCY2uCU1KZAKWAc3CIg=;
        b=P9e0Kdarb9HU/R4jyBXu0ELCXOnKWoyCdO28ibit/UvII7D1Ejvp2NlWrmR3ugjbSB
         MEqZUiWmVgVEX1cArwhO7c78ZBDpnds+coC29Tcc2lhbo6r0q8xxzizOqRDJFmL3U0LA
         pTekCxsV4OBncs/dt7P5surmwuS1ts7K14+oY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CQgtos6gVXtQDMK7WmwCsXfSvCY2uCU1KZAKWAc3CIg=;
        b=uCioHnkOsPxFPCaUUMvdcJLQ62Kdc5cYglHY/6q43dIT0SSWFgZRBnmaOMv88WH2LI
         P8Z4NlgSGJZGI9z0sw5KjS/9B5/tpzxL5wxg9sNxwTB2AsIGHJhaRjTYSl02CF9nzZaH
         3M3gh6FVC/CUUwmT1366xsrRnXdNZocGgbkofMGQHzZOlTvEbigSz4nWx08n/jOeRbfB
         m3of5jlWMTW+J2ZQtgZiTbtcta9pC4za0gvpSYbG1+cXL+oJplqu93891RvTAyLDc36A
         aRFEYmJnXXxKMU12pKrwTF+9eCVQgBwgHgiWIEJawB+Wh/lA4E1Zjar9LYnSR7KQLuOy
         utTA==
X-Gm-Message-State: APjAAAUZKM7aoRAwwtwtZ2ms8QLblwm8vv1RzL6O+TeC3R04V7xxkzuu
        IqwLp33yGJQhR/DwXPBkx6ZSnQ==
X-Google-Smtp-Source: APXvYqwnDA0iYOKIIQNgt8FJolaV0NtoS6CQPFynT/FuSlzm3IpYMTk1lgQWV99sBsjSkoBRQ5j/bw==
X-Received: by 2002:a17:90a:31cf:: with SMTP id j15mr3239618pjf.120.1580196897974;
        Mon, 27 Jan 2020 23:34:57 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id i4sm18626553pgc.51.2020.01.27.23.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 23:34:57 -0800 (PST)
Date:   Tue, 28 Jan 2020 16:34:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Tomasz Figa <tfiga@chromium.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH 13/15] videobuf2: do not sync buffers for DMABUF
 queues
Message-ID: <20200128073455.GC115889@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-14-senozhatsky@chromium.org>
 <2d0e1a9b-6c5e-ff70-9862-32c8b8aaf65f@xs4all.nl>
 <20200122050515.GB49953@google.com>
 <57f711a0-6183-74f6-ab24-ebe414cb6881@xs4all.nl>
 <20200124022544.GD158382@google.com>
 <20200124073250.GA100275@google.com>
 <CAAFQd5Dx50nt=yOCj-ufDDey=Zur_F5yE34a9OQP630A1opBSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAFQd5Dx50nt=yOCj-ufDDey=Zur_F5yE34a9OQP630A1opBSQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/01/28 16:22), Tomasz Figa wrote:
[..]
> > > > Then, if q->allow_cache_hint is set, then default to a cache sync (cache clean)
> > > > in the prepare for OUTPUT buffers and a cache sync (cache invalidate) in the
> > > > finish for CAPTURE buffers.
> > >
> > > We alter default cache sync behaviour based both on queue ->memory
> > > type and queue ->dma_dir. Shall both of those cases depend on
> > > ->allow_cache_hints, or q->memory can be independent?
> > >
> > > static void set_buffer_cache_hints(struct vb2_queue *q,
> > >                                  struct vb2_buffer *vb,
> > >                                  struct v4l2_buffer *b)
> > > {
> > >       if (!q->allow_cache_hints)
> > >               return;
> > >
> > >       /*
> > >        * DMA exporter should take care of cache syncs, so we can avoid
> > >        * explicit ->prepare()/->finish() syncs. For other ->memory types
> > >        * we always need ->prepare() or/and ->finish() cache sync.
> > >        */
> > >       if (q->memory == VB2_MEMORY_DMABUF) {
> > >               vb->need_cache_sync_on_finish = 0;
> > >               vb->need_cache_sync_on_prepare = 0;
> > >               return;
> > >       }
> >
> > I personally would prefer this to be above ->allow_cache_hints check,
> > IOW to be independent. Because we need to skip flush/invalidation for
> > DMABUF anyway, that's what allocators do in ->prepare() and ->finish()
> > currently.
>
> I think it's even more than personal preference. We shouldn't even
> attempt to sync imported DMA-bufs, so the code above may result in
> incorrect behavior.

Sure. Allocators test buf->db_attach in prepare()/finish(). This patchset
removes that logic, because we move it to the core code. But if the
conclusion will be to clear ->need_cache_sync_on_finish/prepare only
when ->allow_cache_hints was set, then buf->db_attach bail out must stay
in allocators. And this is where I have preferences :)

	-ss
