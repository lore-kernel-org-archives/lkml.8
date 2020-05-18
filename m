Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A32CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99D9207F5
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IboKzie5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgERLRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726590AbgERLRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:17:14 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A119CC05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:17:14 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id h7so711126otr.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 04:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g503Ck8Hmnwm3Mle9RPu3pG4Ds3hYRoRksfGfnX5Wtc=;
        b=IboKzie54ObNPp3JiHhtIQ8kPbLLNHmAcRRYDKnk1oArIjZ+GMd10k4aYMJSRPb9zG
         17F0resl74uiihv4gxGIutzAXhic+K18i7W3hyGwgMfTt8nCdTFLiRiH/3M90+eJtdp8
         NOtY1+r+bXRxOoYA/CFBWd3Y29PGDF37HlePI4bTyWF2JDP4nX+bpXNsXdtCMybiKvJk
         3xL5+CrFHGwbOdHy5qb3FBbTBNIDGk7CJwhLUp4tig7HJTZMNmUt4I/ZmlrsqxCOu96c
         odlDwjvWGdMjf7bSEZvSr2V+hOQ8gJPE9TtlDbNnG+73EW9FbfvLzrsTUZwGJeNQoI66
         xWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g503Ck8Hmnwm3Mle9RPu3pG4Ds3hYRoRksfGfnX5Wtc=;
        b=GaZf+W81Yek3qlGgnKCInhLIYlMKQTqQmPR0QJU9BpFfUjgkigPFIIhtq2sEypZgcZ
         5yHMb1X7tN1lyLSEf2MFKc5BRHzbTAzMgvDeBIy/PV2zGf2HZgmlmudPgiZvkOPjMx58
         rukZcy07NQLUeOlRq+77vUe2avv+uXJhKQf2BGeCwnduN3E06tHam2AvRcnd6i+uyee/
         NdLRkSrH9xWlbJrY0WEv3FsE4XdJUZYtfQUOkFN3sk5Y0eAPh3ssYOX7PAAlR3N9WNCY
         T2ArLThZOO2iVwxaNYh4LHSAuIsl2b54ktVVpPl0K6TCyvZiLfeey32HOqhEuvDD28tE
         cClQ==
X-Gm-Message-State: AOAM531ta1miex1GP2+Qb8gQRdNTG7hd1aWES3q8/0UCG6qM8eEanBc/
        7wP/HMH2tYS19FXiRhJEHhqcGjluLVShe9kH24yqJg==
X-Google-Smtp-Source: ABdhPJwl5rqs5VWO5Jkao2XeEWkRX+lCx01ip7F50tguMxrw+WswGeYLG9OGd+5XHn6jnx/Q1aQbMIwBn56Y/9LJcLA=
X-Received: by 2002:a9d:ec7:: with SMTP id 65mr11530376otj.164.1589800633898;
 Mon, 18 May 2020 04:17:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
 <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com>
 <20200514123007.GP206103@phenom.ffwll.local> <CAD=HUj7452eFfn9i=JWm54Mke3Lew-7AWYeoKZLAjCSg7eLO6A@mail.gmail.com>
 <20200515140306.GF206103@phenom.ffwll.local>
In-Reply-To: <20200515140306.GF206103@phenom.ffwll.local>
From:   Sumit Semwal <sumit.semwal@linaro.org>
Date:   Mon, 18 May 2020 16:47:02 +0530
Message-ID: <CAO_48GG85PhyoZ1yzXuwv8tT12V4dkDsXc8_RaMd--oinkpN2g@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
To:     David Stevens <stevensd@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        "open list:VIRTIO CORE, NET..." 
        <virtualization@lists.linux-foundation.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" 
        <linux-media@vger.kernel.org>,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" 
        <linaro-mm-sig@lists.linaro.org>, virtio-dev@lists.oasis-open.org
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello David,

On Fri, 15 May 2020 at 19:33, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Fri, May 15, 2020 at 02:07:06PM +0900, David Stevens wrote:
> > On Thu, May 14, 2020 at 9:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> > > On Thu, May 14, 2020 at 05:19:40PM +0900, David Stevens wrote:
> > > > Sorry for the duplicate reply, didn't notice this until now.
> > > >
> > > > > Just storing
> > > > > the uuid should be doable (assuming this doesn't change during the
> > > > > lifetime of the buffer), so no need for a callback.
> > > >
> > > > Directly storing the uuid doesn't work that well because of
> > > > synchronization issues. The uuid needs to be shared between multiple
> > > > virtio devices with independent command streams, so to prevent races
> > > > between importing and exporting, the exporting driver can't share the
> > > > uuid with other drivers until it knows that the device has finished
> > > > registering the uuid. That requires a round trip to and then back from
> > > > the device. Using a callback allows the latency from that round trip
> > > > registration to be hidden.
> > >
> > > Uh, that means you actually do something and there's locking involved.
> > > Makes stuff more complicated, invariant attributes are a lot easier
> > > generally. Registering that uuid just always doesn't work, and blocking
> > > when you're exporting?
> >
> > Registering the id at creation and blocking in gem export is feasible,
> > but it doesn't work well for systems with a centralized buffer
> > allocator that doesn't support batch allocations (e.g. gralloc). In
> > such a system, the round trip latency would almost certainly be
> > included in the buffer allocation time. At least on the system I'm
> > working on, I suspect that would add 10s of milliseconds of startup
> > latency to video pipelines (although I haven't benchmarked the
> > difference). Doing the blocking as late as possible means most or all
> > of the latency can be hidden behind other pipeline setup work.
> >
> > In terms of complexity, I think the synchronization would be basically
> > the same in either approach, just in different locations. All it would
> > do is alleviate the need for a callback to fetch the UUID.
>
I think I agree with Daniel there - this seems best suited for code
within virtio.

> Hm ok. I guess if we go with the older patch, where this all is a lot more
> just code in virtio, doing an extra function to allocate the uuid sounds
> fine. Then synchronization is entirely up to the virtio subsystem and not
> a dma-buf problem (and hence not mine). You can use dma_resv_lock or so,
> but no need to. But with callbacks potentially going both ways things
> always get a bit interesting wrt locking - this is what makes peer2peer
> dma-buf so painful right now. Hence I'd like to avoid that if needed, at
> least at the dma-buf level. virtio code I don't mind what you do there :-)
>
> Cheers, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch

Best,
Sumit.
