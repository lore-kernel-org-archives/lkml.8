Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43E7C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 991D421734
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 01:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W333QISV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgAVBjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 20:39:41 -0500
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38096 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbgAVBjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 20:39:41 -0500
Received: by mail-pj1-f68.google.com with SMTP id l35so2565579pje.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 17:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GR5h1tt2wJy5kG2UEKPuOm//LxmTSWIE80O9BC6vjqA=;
        b=W333QISVONGD08j00/Y3QQwYv0ParIpCj6sdrKhnnuuTcSuDqKiL420+3RE+GuwwGs
         hnjJKbHvMWu8cZ1a4c2TBFaiQ994byvcG5nIQSz4JYvaVaVEnAeEaMGIUxblvg7naCbm
         aO+dVJLE9HoeG0xzjx6R0naDuqgvOiTEYRPbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GR5h1tt2wJy5kG2UEKPuOm//LxmTSWIE80O9BC6vjqA=;
        b=nqam0ylmKvtrvtSBNsPaNi4n1u9HcYllRzMfRBb8KbKKFwLiQ2BnOd8JSdm8bZodwv
         GumUstUdsfnuSYgJ19J3Zxxv4cWdqzWZKURkkgVOo/b2s+QQYNIHByzjA7CU6WRdc3KF
         fP3bmjJVoDIDtGxUW21ZjolpK2eWBT5zbcxMcC4/J1a9xyShrRBgfm/hGnVJ/nuxd2bT
         dAOMbm53TNXrbcZMOhb3wCaJ+QHwj8aI5SA6t2w6PgdG7cuKTH44j90RbUFGRytC2Jpi
         zXVXXpFTS7XVlF2aSOv4AkPdoV7ReH2HQdCCdgpif60P6XIjx2VPzIelEO8lQ2OJEW0q
         m10A==
X-Gm-Message-State: APjAAAUM9g9WuE7Pzm6Aiv+dAKk1vK3CJDKfmaJXnZkkJs67eUKSXSH3
        rXD8ACmltazGUg+r+m48BV6LTA==
X-Google-Smtp-Source: APXvYqz3f5+DfmqCYbZN/U5SqXNvv9ofxo48LEFi5s7hXjc+PcN/p7YpBg1Nbu6vnuOWYfKMlALv+g==
X-Received: by 2002:a17:902:6b4b:: with SMTP id g11mr8223389plt.26.1579657180827;
        Tue, 21 Jan 2020 17:39:40 -0800 (PST)
Received: from localhost ([2401:fa00:8f:203:5bbb:c872:f2b1:f53b])
        by smtp.gmail.com with ESMTPSA id w4sm666460pjt.23.2020.01.21.17.39.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 17:39:40 -0800 (PST)
Date:   Wed, 22 Jan 2020 10:39:37 +0900
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
Subject: Re: [RFC][PATCH 02/15] videobuf2: handle V4L2 buffer cache flags
Message-ID: <20200122013937.GC149602@google.com>
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-3-senozhatsky@chromium.org>
 <ada2381c-2c1c-17c3-c190-48439ae1657a@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada2381c-2c1c-17c3-c190-48439ae1657a@xs4all.nl>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Sorry for the delayed.

On (20/01/10 11:24), Hans Verkuil wrote:
> On 12/17/19 4:20 AM, Sergey Senozhatsky wrote:
> > Set video buffer cache management flags corresponding to V4L2 cache
> > flags.
> > 
> > Both ->prepare() and ->finish() cache management hints should be
> > passed during this stage (buffer preparation), because there is no
> > other way for user-space to skip ->finish() cache flush.
> > 
> > There are two possible alternative approaches:
> > - The first one is to move cache sync from ->finish() to dqbuf().
> >   But this breaks some drivers, that need to fix-up buffers before
> >   dequeueing them.
> > 
> > - The second one is to move ->finish() call from ->done() to dqbuf.
> 
> Please combine this patch with patch 13/15!

OK.

[..]
> >  }
> >  
> > +static void set_buffer_cache_hints(struct vb2_queue *q,
> > +				   struct vb2_buffer *vb,
> > +				   struct v4l2_buffer *b)
> > +{
> > +	vb->need_cache_sync_on_prepare = 1;
> > +
> > +	if (q->dma_dir != DMA_TO_DEVICE)
> 
> What should be done when dma_dir == DMA_BIDIRECTIONAL?

Well, ->need_cache_sync_on_prepare/->need_cache_sync_on_finish are set,
by default. If the queue supports user-space cache hints (driver has
set ->allow_cache_hints), then user-space can override cache behavior.
We probably cannot enforce any other behavior here. Am I missing
something?

> > +		vb->need_cache_sync_on_finish = 1;
> > +	else
> > +		vb->need_cache_sync_on_finish = 0;
> > +
> > +	if (!q->allow_cache_hints)
> > +		return;
> > +
> > +	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_INVALIDATE)
> > +		vb->need_cache_sync_on_finish = 0;
> > +
> > +	if (b->flags & V4L2_BUF_FLAG_NO_CACHE_CLEAN)
> > +		vb->need_cache_sync_on_prepare = 0;
> > +}

	-ss
