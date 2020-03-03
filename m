Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B8FC3F2D2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 678192465E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 03:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=vanguardiasur-com-ar.20150623.gappssmtp.com header.i=@vanguardiasur-com-ar.20150623.gappssmtp.com header.b="GLB9O7C5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728049AbgCCDBu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 22:01:50 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:38343 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbgCCDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 22:01:48 -0500
Received: by mail-vs1-f66.google.com with SMTP id r18so1437617vso.5
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 19:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nSRU5sACea5+ppbDemV9Uic2wN/d3iE9zq0J+9WMWgc=;
        b=GLB9O7C5VahYJhDYzkBxf2lKSD9pLzKz5Byom6tbN2F00apEFOoMKygPFRUL/Uj/9p
         trrMj2G7knR6XcyNzJnegV3oqZFYXjOzksRSaS7EYqXLtBm73hjZhvPgh/oHzwaPaxK3
         76NkpiHJoXM8Dn8fmYWtlTbgNorgHL9tKxZJyFtPTMNtqUHk0NviVgwyZkLagj68k+m2
         eR3sQl4yLprO0JVwr10qiSju6vKn8TwNCARfi1ZmCrQ3QXiaMKxoMnt4pglC66DeYQJA
         FO+hfumTHCsVe8b6U78fKr/EUZSkshYD2KuyX+9VNS+l4U99BqrSloNqlDPhi1J3nwwL
         lNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nSRU5sACea5+ppbDemV9Uic2wN/d3iE9zq0J+9WMWgc=;
        b=ZofCyeMBgWo1yG0o8k+8h0/2zZZ9NOBuuUX8S15BCdDiRFoLDyLvAZb5nfdjGTrnzm
         K1svhUP1ADDLZHNgRr4kXNn+ioQPovbmxVUCDtnG9uINh2eej/RzSRYHRFwCSGhdglPI
         MGWq9oC6SKajOniq7PuhQ5V4lIZyNTxFenZCegRYiRIXQG8GPUZSll5v9z/IfQPXVJj9
         1CtMwlpWxYGgXKPk9xdZkjR2bzYwwHksENbO9k2TfChbrjXj0PCZ/SoiUKD57YDZ32Br
         qkkULom93IUwAVscMA2sgDKl2cvfUBFW86qCsV+MxhRSYf44S27y65O610gUdYcnvxIP
         3iUw==
X-Gm-Message-State: ANhLgQ0+TDn71NrcoJz1ts/TpCdb8FJkdnD4WEFhG7Z07BB3UcXhTTEC
        z70zgi0PZZQq6uftHgn4XoT6fKenRHFMGl+pT3fXiA==
X-Google-Smtp-Source: ADFU+vuC8mp7isBQqKtElWb2H5X02yPVK/KkJEjfK1X7c0jaRsY9KoO483bHWVY/z9yfC29IZdAch/0rT3wM1qaKiP0=
X-Received: by 2002:a67:1601:: with SMTP id 1mr1197519vsw.176.1583204506731;
 Mon, 02 Mar 2020 19:01:46 -0800 (PST)
MIME-Version: 1.0
References: <20200228164126.17517-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAOMZO5AP65Upj8v=KaPLzS10DNdwrz20gJGbwbcJfCDqZBx71Q@mail.gmail.com>
 <CA+V-a8s_d3Atp9J5KM=x4z2z_iAY8+9vcSHFUTyQ3XZ9HCCS3g@mail.gmail.com> <CAOMZO5DP3BMmmL3eM5dmhy0YdMGvD9UW1mUXb1tYds9eVbE6LA@mail.gmail.com>
In-Reply-To: <CAOMZO5DP3BMmmL3eM5dmhy0YdMGvD9UW1mUXb1tYds9eVbE6LA@mail.gmail.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Tue, 3 Mar 2020 00:01:34 -0300
Message-ID: <CAAEAJfBmvGhMWCCh80Y+qG26OKg5Af5U+Zdtgrbt27cS9YgQug@mail.gmail.com>
Subject: Re: [PATCH] media: i2c: ov5645: Add virtual_channel module parameter
To:     Fabio Estevam <festevam@gmail.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        linux-media <linux-media@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Niklas and Jacopo,

On Mon, Mar 2, 2020, 12:33 PM Fabio Estevam <festevam@gmail.com> wrote:
>
> Hi Prabhakar,
>
> On Mon, Mar 2, 2020 at 4:19 AM Lad, Prabhakar
> <prabhakar.csengg@gmail.com> wrote:
>
> > > Should this be a device tree property instead?
> > I did give a thought about it, but making this as DT property would
> > make it more stiff.
>
> In case a system has two OV5645 and we want to operate each OV5645
> with a different virtual channel, it will not be possible with the
> module_param approach.
>
> Using a device tree property would make it possible though, so I think
> it makes more sense to use a device tree property for this.
>

As often happens, driver parameter is probably the easiest and less
invasive way to customize a driver, so I can imagine myself carrying
something like this downstream if needed. Haven't we all?

It's definitely not suitable upstream, as Fabio points out, but
I don't think a devicetree approach is either.

It seems Niklas and Jacopo have been working on adding
proper support to route this, via some new ioctls.

https://patchwork.linuxtv.org/patch/55300/

Not sure what's the status of it.

Hope it helps,
Ezequiel
