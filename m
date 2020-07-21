Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29CEC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A951020720
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 20:27:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q1goVVRy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgGUU1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 16:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729928AbgGUU1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 16:27:00 -0400
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 659B9C061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:27:00 -0700 (PDT)
Received: by mail-vk1-xa41.google.com with SMTP id t187so45848vke.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KLCByWF4yLz2SmZ5rErGQplCKH4CPMVPAEbJkDh8hXg=;
        b=Q1goVVRy0qIKIyOTfwTHQM8HUc5zxIwUwDM+oHWmOwuqPRrbRupgAs25ujIwSPdoz5
         1M6Zj7yl2+wNwXwZqkRzsITMucTg+XuAkgiInPP/IjjvqA8bHsxKyojhuHc+3CbEYWsS
         nkc34p1lczVQ3GD1B7C3Ty7SgYCP5T9b0dvGU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KLCByWF4yLz2SmZ5rErGQplCKH4CPMVPAEbJkDh8hXg=;
        b=IJPr4VOP7//hGv+zwGv4prHsDHbX7t1H9dCoc8T7+6dQUSUe7aLNdMSU/63btyO/9K
         pq4ftb8e4izHXUmYTnu4lpl8yO5OK37BIq4eT6902DeGk0fRxfu3KniOfTRctgnDlrP3
         fOqsQQ7fp/HJqP23yoPRaC/l3B496BhOkNZJi2ctHbAMf9n2BXd8m/iq+w5PL49vfYf3
         x42e2NidsxTWN1oWYT1zvkLYHNo3pSbSbNLIpucA/eUmBla39cjhmWI/KkHC/dVvGPfQ
         guaD2g0kjb/TZu9ELNdpd9cie2til2TxtjkJ+P50YhGNwFtperHD/jHhsUXeWhpBV4n6
         ga4w==
X-Gm-Message-State: AOAM530crc509H8QFCkg3F2tj2Jar0DOXkn18gATfoVap59heFYTLj9s
        9DOjrL0fu6zV1aPpHYmwFdUdycBz8tI=
X-Google-Smtp-Source: ABdhPJxlwWPe8gLz0F+op4ytKRQC6LC64ZcOBbuI1fE5zGwNAXfYfgbDptXjrLB3cccxrPV0LAGdqQ==
X-Received: by 2002:a1f:f4cb:: with SMTP id s194mr21313774vkh.48.1595363218825;
        Tue, 21 Jul 2020 13:26:58 -0700 (PDT)
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com. [209.85.222.50])
        by smtp.gmail.com with ESMTPSA id a203sm3344432vka.44.2020.07.21.13.26.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 13:26:58 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id n4so6657989uae.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 13:26:57 -0700 (PDT)
X-Received: by 2002:a9f:3dc6:: with SMTP id e6mr22533941uaj.104.1595363217358;
 Tue, 21 Jul 2020 13:26:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200720172448.1.I7efdf6efaa6edadbb690196cd4fbe3392a582c89@changeid>
 <159531115483.3847286.18280088484118119899@swboyd.mtv.corp.google.com>
 <159531527579.3847286.1254956818647049462@swboyd.mtv.corp.google.com>
 <CAD=FV=X=NDym3V31dQ8c341UwQm9pDybUCR8jFF1JR99XeVKVw@mail.gmail.com> <159535775253.3847286.5195740102798837524@swboyd.mtv.corp.google.com>
In-Reply-To: <159535775253.3847286.5195740102798837524@swboyd.mtv.corp.google.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 21 Jul 2020 13:26:44 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WhsPkaB_cLNzGuuBrAEHiyrM9TGGvhUY4+0C=SzWwsHA@mail.gmail.com>
Message-ID: <CAD=FV=WhsPkaB_cLNzGuuBrAEHiyrM9TGGvhUY4+0C=SzWwsHA@mail.gmail.com>
Subject: Re: [PATCH] i2c: i2c-qcom-geni: Fix DMA transfer race
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Akash Asthana <akashast@codeaurora.org>,
        Alok Chauhan <alokc@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Wolfram Sang <wsa@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jul 21, 2020 at 11:55 AM Stephen Boyd <swboyd@chromium.org> wrote:
>
> Quoting Doug Anderson (2020-07-21 09:18:35)
> > On Tue, Jul 21, 2020 at 12:08 AM Stephen Boyd <swboyd@chromium.org> wrote:
> > >
> > > Quoting Stephen Boyd (2020-07-20 22:59:14)
> > > >
> > > > I worry that we also need a dmb() here to make sure the dma buffer is
> > > > properly mapped before this write to the device is attempted. But it may
> > > > only matter to be before the I2C_READ.
> > > >
> > >
> > > I'm suggesting this patch instead where we make geni_se_setup_m_cmd()
> > > use a writel() so that it has the proper barrier semantics to wait for
> > > the other memory writes that happened in program order before this point
> > > to complete before the device is kicked to do a read or a write.
> >
> > Are you saying that dma_map_single() isn't guaranteed to have a
> > barrier or something?  I tried to do some searching and found a thread
> > [1] where someone tried to add a barrierless variant of them.  To me
> > that means that the current APIs have barriers.
> >
> > ...or is there something else you're worried about?
>
> I'm not really thinking about dma_map_single() having a barrier or not.
> The patch you mention is from 2010. Many things have changed in the last
> decade. Does it have barrier semantics? The presence of a patch on the
> mailing list doesn't mean much.

Yes, it's pretty old, but if you follow the thread and look at the
patch I'm fairly certain it's still relevant.  Specifically, following
one thread of dma_map_single() on arm64:

dma_map_single()
-> dma_map_single_attrs()
--> dma_map_page_attrs()
---> dma_direct_map_page()
----> arch_sync_dma_for_device()
-----> __dma_map_area()
------> __dma_inv_area() which has a "dsb"

I'm sure there are lots of other possible paths, but one thing pointed
out by following that path is 'DMA_ATTR_SKIP_CPU_SYNC'.  The
documentation of that option talks about the normal flow.  It says
that in the normal flow that dma_map_{single,page,sg} will
synchronize.  We are in the normal flow here.

As far as I understand, the whole point of dma_map_single() is to take
a given buffer and get it all ready so that if a device does DMA on it
right after the function exits that it's all set.


> Specifically I'm looking at "KERNEL I/O BARRIER EFFECTS" of
> Documentation/memory-barriers.txt and noticing that this driver is using
> relaxed IO accessors meaning that the reads and writes aren't ordered
> with respect to other memory accesses. They're only ordered to
> themselves within the same device. I'm concerned that the CPU will issue
> the IO access to start the write DMA operation before the buffer is
> copied over due to out of order execution.

I'm not an expert either, but it really looks like dma_map_single()
does all that we need it to.


> I'm not an expert in this area, but this is why we ask driver authors to
> use the non-relaxed accessors because they have the appropriate
> semantics built in to make them easy to reason about. They do what they
> say when they say to do it.

I'm all for avoiding using the relaxed variants too except if it's
been shown to be a performance problem.  The one hesitation I have,
though, is that I've spent time poking a bunch at the geni SPI driver.
We do _a lot_ of very small SPI transfers on our system.  For each of
these it's gotta setup a lot of commands.  When I was poking I
definitely noticed the difference between writel() and
writel_relaxed().  If we can save a few microseconds on each one of
these transfers it's probably worth it since it's effectively in the
inner loop of some transfers.

One option I thought of was to track the mode (DMA vs. FIFO) and only
do writel() for DMA mode.  If you're not convinced by my arguments
about dma_map_single(), would you be good with just doing the
non-relaxed version if we're in DMA mode?

-Doug
