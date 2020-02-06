Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DBAC2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39CB220838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 08:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V53GVGtE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgBFIwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 03:52:04 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34197 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbgBFIwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 03:52:04 -0500
Received: by mail-ed1-f68.google.com with SMTP id r18so5099382edl.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=We7DoVh7zLbEobTGikMeJVx0fJF9wa4d1jWsJYX+VpE=;
        b=V53GVGtE+FiWi1Ic1qjEMrk3/vEvAhXyW5H0b0fxm+6774kxmE8OyeaawuPxs1gH4b
         c+0FT6j2HTkSaJT6uEthX7ZOUXERC0g8efQ01yJ78SbJsqPTMPOADs6e2eP5V0D4MgrQ
         5mxhqpf+6HI1BZDpX71QwLwNyugqDu8duGIlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=We7DoVh7zLbEobTGikMeJVx0fJF9wa4d1jWsJYX+VpE=;
        b=I4liVZHlrK4KlXghwW3FPz/NYZ6TzNX9k/AopkLewuHTpnEi1td/QET/JT8Dk0LLkr
         FMwJ4Fl+npUrRu62AE6DY3M+y/e1fXaBVbY5eM+OXsO2RvE2RcstsunBhi8k9flgyYDE
         b3r2lTZ45P9zGbjM/6rey8Ay14f1NSJsH0wyPTfwtPf+fPTig5pEp3GEZEMAIbFgKDoN
         mSf9MAOZtepGZDuPjygT55Vnz3iCe0QyOxwmTtYZ7gSise8jl/7pk2krvtQ6So2JOLI3
         FVYqMABSTq3xablRRKaEfBYigHWRkLYGOayc/FrXY/y+8bgsVAEllF40CJq7K3yf6GqY
         MNqg==
X-Gm-Message-State: APjAAAVdNpIphTkf9WjBg/IzsfRX2jyeiSQZ9Eeely11sNS0fFyRRjGA
        ot0ZGRFz5tkmkxA48jTriFq0j3XKg+1F0A==
X-Google-Smtp-Source: APXvYqxJrgCJQbdZbj7H5tLW7y847YzvWyjdBhKHMe6I2Ue+gH5v7TTaQFASdp8WkxF9kTJUSPxjmg==
X-Received: by 2002:a05:6402:6cc:: with SMTP id n12mr2096523edy.344.1580979122353;
        Thu, 06 Feb 2020 00:52:02 -0800 (PST)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com. [209.85.221.52])
        by smtp.gmail.com with ESMTPSA id n11sm215998edv.66.2020.02.06.00.52.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Feb 2020 00:52:01 -0800 (PST)
Received: by mail-wr1-f52.google.com with SMTP id m16so6071549wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 00:52:00 -0800 (PST)
X-Received: by 2002:adf:f58a:: with SMTP id f10mr2727400wro.105.1580979119629;
 Thu, 06 Feb 2020 00:51:59 -0800 (PST)
MIME-Version: 1.0
References: <20191217032034.54897-1-senozhatsky@chromium.org>
 <20191217032034.54897-13-senozhatsky@chromium.org> <1c5198dc-db4e-47d6-0d8b-259fbbb6372f@xs4all.nl>
 <CAAFQd5DN0FSJ=pXG3J32AXocnbkR+AB8yKKDk0tZS4s7K04Z9Q@mail.gmail.com>
 <560ba621-5396-1ea9-625e-a9f83622e052@xs4all.nl> <CAAFQd5D27xaKhxg8UuPH6XXdzgBBsCeDL8wYw37r6AK+6sWcbg@mail.gmail.com>
 <c23618a9-4bf8-1d9a-6e52-d616c79ff289@xs4all.nl> <CAAFQd5BGA-mnirgwQJP_UHkNzpVvf19xeRu-n7GLQci8nYGB2A@mail.gmail.com>
 <20200204025021.GF41358@google.com>
In-Reply-To: <20200204025021.GF41358@google.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 6 Feb 2020 17:51:46 +0900
X-Gmail-Original-Message-ID: <CAAFQd5B1cDCHexRR7UaqhHuxOgbAZDFHrZEVA1E2bcH14Ve5_A@mail.gmail.com>
Message-ID: <CAAFQd5B1cDCHexRR7UaqhHuxOgbAZDFHrZEVA1E2bcH14Ve5_A@mail.gmail.com>
Subject: Re: [RFC][PATCH 12/15] videobuf2: add begin/end cpu_access callbacks
 to dma-sg
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

On Tue, Feb 4, 2020 at 11:50 AM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (20/02/03 19:04), Tomasz Figa wrote:
> [..]
> > > I very much agree with that. But this should be very clearly documented.
> > > Should V4L2_CAP_MEMORY_NON_CONSISTENT always be set in this case?
> > >
> >
> > Yes, IMHO that would make sense. My understanding is that currently
> > the consistency of allocated memory is unspecified, so it can be
> > either. With V4L2_FLAG_MEMORY_NON_CONSISTENT, the userspace can
> > explicitly ask for inconsistent memory.
> >
> > Moreover, I'd vote for setting V4L2_CAP_MEMORY_NON_CONSISTENT when
> > V4L2_FLAG_MEMORY_NON_CONSISTENT is guaranteed to return inconsistent
> > memory to avoid "optional" features or "hints" without guaranteed
> > behavior.
>
> Documentation/DMA-attributes.txt says the following
>
>   DMA_ATTR_NON_CONSISTENT
>   -----------------------
>
>   DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
>   consistent or non-consistent memory as it sees fit.  By using this API,
>   you are guaranteeing to the platform that you have all the correct and
>   necessary sync points for this memory in the driver.

Good point. And I also realized that some platforms just have no way
to make the memory inconsistent, because they may have hardware
coherency.

Then we need to keep it a hint only.

Best regards,
Tomasz
