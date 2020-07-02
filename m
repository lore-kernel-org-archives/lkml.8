Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78B55C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:03:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E33C20870
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 18:03:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="SDEAl+v4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgGBSDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 14:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726349AbgGBSDl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 14:03:41 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86C2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 11:03:40 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f7so26557151wrw.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=UpAJNr8vpfTKtPQlj/e/glrJ9ulcMqPbKalh3VG00pM=;
        b=SDEAl+v4mwYH2FWXjETOOYOvRfmikj7NShBSNRHJW2UZNJ4YUd+TJJryD9LzQ9QhpA
         eN1lwTgoQwINeLc3RXJ4cU+Y5hdSlkBU1BmgJDNVMOiGHcpYH6pcgDLK52aLrzVZmv6r
         PFnkOFxN+vObKR9N+rJ+7S6/i/cxfEcUkp7XI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=UpAJNr8vpfTKtPQlj/e/glrJ9ulcMqPbKalh3VG00pM=;
        b=gtpx6ujZN34640/APzfJvr/4mj4kLml1U7rSmDJdF64iSMAbfB7k9JjH/GFs3YDtjP
         ciqUOwtD/e4VzG/bn6lGnhsaZpJJsFw5aF0abirkBe278JkjDVK8T3DyeZZWu+gB8Mrx
         gi7ypBbcSaOtZc5M40ph5X9Jz4BPN6UpQGFt9v7pJ1sh/uhpxgBTeYPfPpSEyQ1huEiN
         Wc4tiW0tOgNjLPeQMwx/beO3DsNh4ScuHvwqw9i+MlK+5bsHq83K5TKq2ZhN873hXQPW
         j9+/hgXh7XrpDYEHoN4dIWYH284rR3CJ5Ujrs6Ipjr9Pv8wORevEX8vlO10y/r4357Em
         NlFQ==
X-Gm-Message-State: AOAM53257Cp8wRtdw02226+Xgq6T2Ovg6kpao951wqeYtgjbhU9U8lUp
        S4ByRiamlmN8blHmy4BKnLdwIQ==
X-Google-Smtp-Source: ABdhPJwUPiRqviJX4p/wQ4ZlfWVQDt88ex2g1XXDueh/V48dmaVm3xrRzZwLDYoIIaTkFo3VMCW82w==
X-Received: by 2002:adf:f104:: with SMTP id r4mr34105603wro.90.1593713019519;
        Thu, 02 Jul 2020 11:03:39 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id n16sm11595673wra.19.2020.07.02.11.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 11:03:38 -0700 (PDT)
Date:   Thu, 2 Jul 2020 20:03:36 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>, Simon Ser <contact@emersion.fr>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jianxin.pan@amlogic.com" <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v8 1/6] drm/fourcc: Add modifier definitions for
 describing Amlogic Video Framebuffer Compression
Message-ID: <20200702180336.GB3278063@phenom.ffwll.local>
Mail-Followup-To: Neil Armstrong <narmstrong@baylibre.com>,
        Simon Ser <contact@emersion.fr>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jianxin.pan@amlogic.com" <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20200702074759.32356-1-narmstrong@baylibre.com>
 <20200702074759.32356-2-narmstrong@baylibre.com>
 <8cBfZpkc4pHBLhihlvJMD_Hq1DEsNRcSY4Y8JaGwklMWcxiYzUMVEx7wH9f_DuCBMVUhXvOR0PcHVslILtKI2wdw79Nfih0N3VnrxfMQd08=@emersion.fr>
 <20200702131834.GZ3278063@phenom.ffwll.local>
 <044964ad-b927-57d7-9361-beda5c8d99a8@baylibre.com>
 <CAKMK7uHa4ajC5_SA_fFUhB-Amxcbt7T9UZ+pvRhqDeUeX9Ez6A@mail.gmail.com>
 <190ac909-c78b-81e0-35a1-353cd24e9f44@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <190ac909-c78b-81e0-35a1-353cd24e9f44@baylibre.com>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 05:11:25PM +0200, Neil Armstrong wrote:
> Hi,
> 
> On 02/07/2020 16:15, Daniel Vetter wrote:
> > On Thu, Jul 2, 2020 at 3:34 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >> On 02/07/2020 15:18, Daniel Vetter wrote:
> >>> On Thu, Jul 02, 2020 at 09:23:11AM +0000, Simon Ser wrote:
> >>>> On Thursday, July 2, 2020 9:47 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>>>
> >>>>> Finally is also adds the Scatter Memory layout, meaning the header contains IOMMU
> >>>>> references to the compressed frames content to optimize memory access
> >>>>> and layout.
> >>>>>
> >>>>> In this mode, only the header memory address is needed, thus the content
> >>>>> memory organization is tied to the current producer execution and cannot
> >>>>> be saved/dumped neither transferrable between Amlogic SoCs supporting this
> >>>>> modifier.
> >>>>
> >>>> Still not sure how to handle this one, since this breaks fundamental
> >>>> assumptions about modifiers.
> >>>
> >>> I wonder whether we should require special allocations for these, and then
> >>> just outright reject mmap on these buffers. mmap on dma-buf isn't a
> >>> required feature.
> >>
> >> Yes, it's the plan to reject mmap on these buffers, but it can't be explained
> >> in the modifiers description and it's a requirement of the producer, not the
> >> consumer.
> > 
> > Hm I think worth to add that as a note to the modifier. Just to make
> > sure. And avoids questions like the one from Simon.
> 
> Something like:
> 
>  /*
>   * Amlogic FBC Scatter Memory layout
>   *
>   * Indicates the header contains IOMMU references to the compressed
>   * frames content to optimize memory access and layout.
>   *
>   * In this mode, only the header memory address is needed, thus the
>   * content memory organization is tied to the current producer
>   * execution and cannot be saved/dumped neither transferrable between
>   * Amlogic SoCs supporting this modifier.
> + *
> + * Due to the nature of the layout, these buffers are not expected to
> + * be accessible by the user-space clients but only accessible by the
> + * hardware producers and consumers.
> + *
> + * The user-space clients should expect a failure while trying to mmap
> + * the DMA-BUF handle returned by the producer.
>   */

lgtm, Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> Thanks,
> Neil
> 
> > -Daniel
> > 
> >>
> >>>
> >>> That would make sure that userspace cannot look at them.
> >>>
> >>> Also I'm kinda suspecting that there's not unlimited amounts of this magic
> >>> invisible storage available anyway.
> >>> -Daniel
> >>>
> >>
> >> _______________________________________________
> >> dri-devel mailing list
> >> dri-devel@lists.freedesktop.org
> >> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> > 
> > 
> > 
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
