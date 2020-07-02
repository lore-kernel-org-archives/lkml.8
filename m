Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EC2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A2F820780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 14:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MTS+DY37"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729676AbgGBOP4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 10:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbgGBOPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 10:15:55 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97FDBC08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 07:15:55 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a21so949673otq.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 07:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9A7iY5vgoWTo7GNwa7G63eYFYvMacp50tlztFrDTtic=;
        b=MTS+DY37g24tK3D8pt2+U8KwQfmhQUXnYI74XgJj3V7kT/uYoUcT9IrsWGpHBoagcY
         qP2mCi82Yr4+2GBLslXn0mA3qDebBbuA63m8UPq5VJHYK3Q8yc9JNsMerUbq8w2R5vHy
         O0M9Xm4Ek/saTssTVrfAmwSbCKdT4MYzVS3Uo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9A7iY5vgoWTo7GNwa7G63eYFYvMacp50tlztFrDTtic=;
        b=RpYICL6mIjHLjj9Egvyoh5YJyc39LGiM4rgZfUhTn9Rrn5V5q2gll9Zqu4PJ5wi1Ty
         m1AaJYN6ehqbuOf1OI3XPu/QMcE+N607wgTkSKe5+cLE8vTkOjNEPC/m304g7zt0PVt/
         /LaFH5gtmDX5B+BGtMw+EROx79DU7kaw+DqyCYJ7jw6my70F7HcMVaHwqgxV+hvHxLqD
         c83ZybcFSFsE5Qr+JTY9fDJZnyQfI7l12o2lhoIrqdtpyWzC5M/3ZxD249ACrW0muEpc
         0iTcrHh8wHOcpK7dGydm71BRrzZeL1pJHEkquEtap9pk35hKHehSxJkhza1vtG4VaHMg
         +ntw==
X-Gm-Message-State: AOAM532gFOMNG7/DNqHswWCOUKeuMgG9TC6SMrxHEt0imJ/5lKj1fydt
        QnjFI/zmJFPreMEfga1gc7sg84OBxWANYI6qJz6eW8Lm
X-Google-Smtp-Source: ABdhPJwaoRuELQ86SMBX24OJmZreO2Szy92aZ3dQsxrJRTUi1P616DpufT08jo7MpSCeSJZoPYNU7WeJQ7wwc5qWVOE=
X-Received: by 2002:a05:6830:1d0:: with SMTP id r16mr15024239ota.188.1593699355009;
 Thu, 02 Jul 2020 07:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200702074759.32356-1-narmstrong@baylibre.com>
 <20200702074759.32356-2-narmstrong@baylibre.com> <8cBfZpkc4pHBLhihlvJMD_Hq1DEsNRcSY4Y8JaGwklMWcxiYzUMVEx7wH9f_DuCBMVUhXvOR0PcHVslILtKI2wdw79Nfih0N3VnrxfMQd08=@emersion.fr>
 <20200702131834.GZ3278063@phenom.ffwll.local> <044964ad-b927-57d7-9361-beda5c8d99a8@baylibre.com>
In-Reply-To: <044964ad-b927-57d7-9361-beda5c8d99a8@baylibre.com>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Thu, 2 Jul 2020 16:15:44 +0200
Message-ID: <CAKMK7uHa4ajC5_SA_fFUhB-Amxcbt7T9UZ+pvRhqDeUeX9Ez6A@mail.gmail.com>
Subject: Re: [PATCH v8 1/6] drm/fourcc: Add modifier definitions for
 describing Amlogic Video Framebuffer Compression
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     Simon Ser <contact@emersion.fr>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jianxin.pan@amlogic.com" <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 3:34 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> On 02/07/2020 15:18, Daniel Vetter wrote:
> > On Thu, Jul 02, 2020 at 09:23:11AM +0000, Simon Ser wrote:
> >> On Thursday, July 2, 2020 9:47 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> >>
> >>> Finally is also adds the Scatter Memory layout, meaning the header contains IOMMU
> >>> references to the compressed frames content to optimize memory access
> >>> and layout.
> >>>
> >>> In this mode, only the header memory address is needed, thus the content
> >>> memory organization is tied to the current producer execution and cannot
> >>> be saved/dumped neither transferrable between Amlogic SoCs supporting this
> >>> modifier.
> >>
> >> Still not sure how to handle this one, since this breaks fundamental
> >> assumptions about modifiers.
> >
> > I wonder whether we should require special allocations for these, and then
> > just outright reject mmap on these buffers. mmap on dma-buf isn't a
> > required feature.
>
> Yes, it's the plan to reject mmap on these buffers, but it can't be explained
> in the modifiers description and it's a requirement of the producer, not the
> consumer.

Hm I think worth to add that as a note to the modifier. Just to make
sure. And avoids questions like the one from Simon.
-Daniel

>
> >
> > That would make sure that userspace cannot look at them.
> >
> > Also I'm kinda suspecting that there's not unlimited amounts of this magic
> > invisible storage available anyway.
> > -Daniel
> >
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
