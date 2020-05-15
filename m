Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81E8C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4C1E20671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:07:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AUvyL4Tr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgEOFHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726000AbgEOFHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:07:22 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D791C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:07:20 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id b6so1328926qkh.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:07:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfF55UVZjZM13JJTcnu7JHGlCcIWGQ0KC6+T1Qa4Oq4=;
        b=AUvyL4TrY/k0uZRpPONkWX0+DRa3JypYhUj9VUTVReBzRNCwB1qGlwB9+xMr/5qKUx
         662uoI0vmPYDQnkLnnoPeZk/8z5J82Bqaw2vZ2igGOXzasFB4XeQNy5SnPAM3aL8d+dm
         HgPH9ubkVbJpPFnpDTFwU2IAAxWbjm6erdork=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfF55UVZjZM13JJTcnu7JHGlCcIWGQ0KC6+T1Qa4Oq4=;
        b=NB8E0ztdFACjR+IfCTJvHqLpuvY5j3bxlAYkwpwwi6u8TtjfhmT+BpejtoEAYcayvp
         b6v0bMn+XhzzLUXDDCh/cJ+XvzyYa0CxZUl80Tdix1wYUdEfkREJINne3LSTK9O7a7U7
         E4p38GmVzlf6n+IMDYFlldB+KFzNGCnZZrMmtQJ01JC7giJpeedg9LYqL3FxVkr+LxHf
         xA7NR2goZf76MtUvqTmQy72jTRFL1XA4JmkfWb8zL00SbebbrlKrkXUAGUUDQ2mNiUih
         csj7McjiG/2ACHTbABvaY07Xy1Byfz5pJuqt/noWwDldQniFJr6GsSZDqzu+WQIvrs06
         l9qw==
X-Gm-Message-State: AOAM530tOeASfBOti4W+htkd2/RV/4TQdwcWGk6LidVG7hr3DNx/QLuk
        5HZj7HzTeQAstiSS21l9V8aYekWT+IaHBwruUDcTHg==
X-Google-Smtp-Source: ABdhPJyqOHTg5AoTGt1Wmzq0ZYIgGB8E4GOtO/n0hCoWBO8WJJlXQqAIbxufbFlLVFtiOfb9I3n6izakdsqzpPkbIcE=
X-Received: by 2002:a37:a3d6:: with SMTP id m205mr1607571qke.241.1589519239498;
 Thu, 14 May 2020 22:07:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
 <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com> <20200514123007.GP206103@phenom.ffwll.local>
In-Reply-To: <20200514123007.GP206103@phenom.ffwll.local>
From:   David Stevens <stevensd@chromium.org>
Date:   Fri, 15 May 2020 14:07:06 +0900
Message-ID: <CAD=HUj7452eFfn9i=JWm54Mke3Lew-7AWYeoKZLAjCSg7eLO6A@mail.gmail.com>
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

On Thu, May 14, 2020 at 9:30 PM Daniel Vetter <daniel@ffwll.ch> wrote:
> On Thu, May 14, 2020 at 05:19:40PM +0900, David Stevens wrote:
> > Sorry for the duplicate reply, didn't notice this until now.
> >
> > > Just storing
> > > the uuid should be doable (assuming this doesn't change during the
> > > lifetime of the buffer), so no need for a callback.
> >
> > Directly storing the uuid doesn't work that well because of
> > synchronization issues. The uuid needs to be shared between multiple
> > virtio devices with independent command streams, so to prevent races
> > between importing and exporting, the exporting driver can't share the
> > uuid with other drivers until it knows that the device has finished
> > registering the uuid. That requires a round trip to and then back from
> > the device. Using a callback allows the latency from that round trip
> > registration to be hidden.
>
> Uh, that means you actually do something and there's locking involved.
> Makes stuff more complicated, invariant attributes are a lot easier
> generally. Registering that uuid just always doesn't work, and blocking
> when you're exporting?

Registering the id at creation and blocking in gem export is feasible,
but it doesn't work well for systems with a centralized buffer
allocator that doesn't support batch allocations (e.g. gralloc). In
such a system, the round trip latency would almost certainly be
included in the buffer allocation time. At least on the system I'm
working on, I suspect that would add 10s of milliseconds of startup
latency to video pipelines (although I haven't benchmarked the
difference). Doing the blocking as late as possible means most or all
of the latency can be hidden behind other pipeline setup work.

In terms of complexity, I think the synchronization would be basically
the same in either approach, just in different locations. All it would
do is alleviate the need for a callback to fetch the UUID.

-David
