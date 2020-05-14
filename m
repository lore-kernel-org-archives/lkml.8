Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D000AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:19:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A108D2065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 08:19:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bwqQu7ds"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgENITw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 04:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725886AbgENITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 04:19:52 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32884C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:19:52 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id i68so2167941qtb.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nV+pjnxNzhUaIVaL0d+Q+czgaVh94PJJNBtyQf89HuA=;
        b=bwqQu7dsz6fMq5SL+sSD61OzDG6vFt+sG+Dtmn2KHQEXyvruCjQJRVMO0rcUkWbR4U
         3sBG2XIUE/tDcJxqlcxCKRZwVtTGXiqQqrz1W1j1VCo+pamFrLGrbNEVowY6fZeWz3dF
         lP8o4i0KqfUWhOHYFoa1pol4Wf7ScVyeR1jFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nV+pjnxNzhUaIVaL0d+Q+czgaVh94PJJNBtyQf89HuA=;
        b=VaP2IaH2r0Y+A56nKnoRifU+sVUVfnrRPuAqw0KKHXdYt6EzgHB7poD/bFAcdHJceJ
         U31wftiFR3ejJXRqOu4ahRPJQc0Fv7GF1+kLg7UzdM7m+1u6SVHAmxQNK4k0QOnNUjql
         S0X+V1HTcUOtuGIYEq+YArY/W7004MVMlkIenhYCSexmwRTU4NcALizoV1eSJNZIOzHS
         CqwvOF9KMAY23e/vZ84FBnLmRYUcK50ALannaXWxgvEU7A2VMg1weWpbxnNhpTWcgUAp
         qpW6SdihO2QB/NojEXtsOPqs84P26P6GrTdUrAFpNKFVF2S+0ME8pq1Sq52Quk9frzFt
         WHrA==
X-Gm-Message-State: AOAM533yRNAQCu/3IAWvms8ZUZXo0pVqcKZnPyrvOOWRoWuqBBSITz8w
        W7+g650HBXwSnVCF9X1458nDgkPRRKOarAQKeP/NnQ==
X-Google-Smtp-Source: ABdhPJy6BMxSQgw3762kK+QUyfrMZlOFJwduKjgq+7fX+Y9LnDP2guRYrUbaIterDx66ZYtt4hHEjjuKFL7NsBC5yw0=
X-Received: by 2002:aed:24a6:: with SMTP id t35mr3208654qtc.72.1589444391477;
 Thu, 14 May 2020 01:19:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200311112004.47138-1-stevensd@chromium.org> <20200311112004.47138-2-stevensd@chromium.org>
 <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
In-Reply-To: <CAKMK7uHFgiHLe9oiFBr-VR-6rU9-hLTpBTEVNh0ezyj54u70jw@mail.gmail.com>
From:   David Stevens <stevensd@chromium.org>
Date:   Thu, 14 May 2020 17:19:40 +0900
Message-ID: <CAD=HUj6k-y1=64zY8ZFOQBZ7WSUWiQfvkiTpXXt10JB_CGqk1A@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] dma-buf: add support for virtio exported objects
To:     Daniel Vetter <daniel@ffwll.ch>
Cc:     Tomasz Figa <tfiga@chromium.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry for the duplicate reply, didn't notice this until now.

> Just storing
> the uuid should be doable (assuming this doesn't change during the
> lifetime of the buffer), so no need for a callback.

Directly storing the uuid doesn't work that well because of
synchronization issues. The uuid needs to be shared between multiple
virtio devices with independent command streams, so to prevent races
between importing and exporting, the exporting driver can't share the
uuid with other drivers until it knows that the device has finished
registering the uuid. That requires a round trip to and then back from
the device. Using a callback allows the latency from that round trip
registration to be hidden.

-David
