Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28AFC35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 04:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B39B322522
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 04:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kCQIevLR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgA1EgG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 23:36:06 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:39510 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA1EgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 23:36:05 -0500
Received: by mail-ed1-f66.google.com with SMTP id m13so13248599edb.6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 20:36:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y7WDQ8mNe+wTvHSQNys0Gz2BA37V8tfgf8BXSaFDUrw=;
        b=kCQIevLRhxAg4UVMkdBxxATDymmTLAjaMvHwJsThMEk/YBCOMHlA3IP+01gzEtYU/k
         jF2EubEsqlfuQvucRuh17bk0kMaWvLEJqjdeqpY2dqVEfE/E2R87NsToHMvY/3HAL3Nn
         sVcayrty7WiA0gu+kfHdMhrDJeV3kfSq3YOL0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y7WDQ8mNe+wTvHSQNys0Gz2BA37V8tfgf8BXSaFDUrw=;
        b=EX+IWwQLxHaiSN6xAqyHqJUpI+IYqHPbagCnw9fJ5fU5bqW9l1nsBBQvVQ3dFmsZDr
         j+WpG+JNG1ze1+/rJU+AAtP8jOMOzyr+DDWHii2Hk+QAvE75YVBvXx5VZ29O4IU1ob/z
         PdWlQlqeVaAH32EAb1u13FUcybwEVVARsXTBNmw6jm5WOcX7GEazJVzzZrUsDf+DIjcu
         kep67w+ztZYMu6BqQ9wjmhIfRlfYmKxAs77LRZ93EX7RVNhCTg66BQsqbeVxCcymZUzx
         01d8ET6lqzc4eFvJacIwjg8WCC0Z69tvoCp/jbJKebtzon2s7+6Qct06z6rEk8Onf/6d
         imVg==
X-Gm-Message-State: APjAAAX2jORSObZfDWtU5+FB90gnwuOkRW81H7PzyfABX+XAafuOpgcn
        YFM46GdnRrT58CFRt39KBRMW0R7PXAkNng==
X-Google-Smtp-Source: APXvYqyE7cxdppg/ygbB7A/pQl+QaI7XW6ltBKTrdNt0q3kCDMPEXebrNGqu3Dd8nv3KlfcqIzUa+w==
X-Received: by 2002:a17:906:560e:: with SMTP id f14mr1515893ejq.300.1580186163322;
        Mon, 27 Jan 2020 20:36:03 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id cw15sm424069edb.44.2020.01.27.20.36.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 20:36:01 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id a9so1025090wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 20:36:01 -0800 (PST)
X-Received: by 2002:a7b:c750:: with SMTP id w16mr2306669wmk.46.1580186160717;
 Mon, 27 Jan 2020 20:36:00 -0800 (PST)
MIME-Version: 1.0
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-3-senozhatsky@chromium.org> <ada2381c-2c1c-17c3-c190-48439ae1657a@xs4all.nl>
 <20200122013937.GC149602@google.com> <20200122025351.GF149602@google.com>
In-Reply-To: <20200122025351.GF149602@google.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 28 Jan 2020 13:35:49 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BHXtdmqxFwAHAiyPLQikVLKLsrHL5Ja4jBePR0x-EC9A@mail.gmail.com>
Message-ID: <CAAFQd5BHXtdmqxFwAHAiyPLQikVLKLsrHL5Ja4jBePR0x-EC9A@mail.gmail.com>
Subject: Re: [RFC][PATCH 02/15] videobuf2: handle V4L2 buffer cache flags
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Pawel Osciak <posciak@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 11:53 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (20/01/22 10:39), Sergey Senozhatsky wrote:
> > [..]
> > > >  }
> > > >
> > > > +static void set_buffer_cache_hints(struct vb2_queue *q,
> > > > +                            struct vb2_buffer *vb,
> > > > +                            struct v4l2_buffer *b)
> > > > +{
> > > > + vb->need_cache_sync_on_prepare = 1;
> > > > +
> > > > + if (q->dma_dir != DMA_TO_DEVICE)
> > >
> > > What should be done when dma_dir == DMA_BIDIRECTIONAL?
> >
>
> [..]
>
> > We probably cannot enforce any other behavior here. Am I missing
> > something?
>
> Never mind. I got your point.

DMA_BIDIRECTIONAL by default needs sync on both prepare and finish.
need_cache_sync_on_prepare is initialized to 1. Since
DMA_BIDIRECTIONAL != DMA_TO_DEVICE, need_cache_sync_on_finish would
also be set to 1. Is anything still missing?
