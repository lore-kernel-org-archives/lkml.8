Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F98C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 552F120772
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="eGu8Bzdj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbgGBNSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:18:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726560AbgGBNSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:18:39 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF409C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:18:38 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so26731711wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=Cuvm4PH9ymZejClh9/IRJruxX3XybrluMfPe5pcP0ik=;
        b=eGu8Bzdjv2Xqb78qCTzwgtJgVA38HsDO3DGT9ZmJH3Q+H8c4RcNNutL98+WSuTQbu9
         KEsOqEyXvy5AJTLhH7zsr6WVXJ/2xkTTcxjU/AKDadOCUJ+MfKid0+RVbgqG9/2wBZ0l
         4Cy9lOPEBPLmQ33W40GnOmEgKAZ8Mt8Y5cXII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=Cuvm4PH9ymZejClh9/IRJruxX3XybrluMfPe5pcP0ik=;
        b=UyBmSgqgkZLiQhnZCkJQzVZJu08POKH3iyQ3vy5NJTPJaTjHpoMti67azMniKnla+I
         Ue3YJaRq4iNJftNtErlxtPqgh3s8jcSzcQzKMBvgtSTPPFKGpTbB6j/Lekb/BST769Mm
         /n2PUWtYahJz16rx9l7i4cIiDr0qG+enCIANivNaBgQk2sKlxqaExRasn3k/xezEdmQs
         GfhEDx9MuRIHfxum+PSlPimktSz/Xk2TI07iAIF6pbzrlsumQzVO8FVVFbwS3C+dWQ56
         Yvy9LbMFfhYmAUtvPdKlfa0I4JIekewEP01FXmBh2atUX11xrgcrJ1wOfBSo2ulrTxM2
         vYFg==
X-Gm-Message-State: AOAM530gMmkL0lfxnuizJ2ukEt6aCWK55MyT4DajLhFno8bAelzke7xq
        fbMczwDxleXWqUb7Mk/3zWrIOQ==
X-Google-Smtp-Source: ABdhPJws7m0llQgCQ3WJpZXwOAgYwXtJKDNub/jxlHaBemJ1pVcESAzqOIr1Y2qhVoHzQpn8e5986g==
X-Received: by 2002:a1c:2183:: with SMTP id h125mr33648435wmh.83.1593695917752;
        Thu, 02 Jul 2020 06:18:37 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id v5sm10646766wre.87.2020.07.02.06.18.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 06:18:36 -0700 (PDT)
Date:   Thu, 2 Jul 2020 15:18:34 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Simon Ser <contact@emersion.fr>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
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
Message-ID: <20200702131834.GZ3278063@phenom.ffwll.local>
Mail-Followup-To: Simon Ser <contact@emersion.fr>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "jianxin.pan@amlogic.com" <jianxin.pan@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <20200702074759.32356-1-narmstrong@baylibre.com>
 <20200702074759.32356-2-narmstrong@baylibre.com>
 <8cBfZpkc4pHBLhihlvJMD_Hq1DEsNRcSY4Y8JaGwklMWcxiYzUMVEx7wH9f_DuCBMVUhXvOR0PcHVslILtKI2wdw79Nfih0N3VnrxfMQd08=@emersion.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8cBfZpkc4pHBLhihlvJMD_Hq1DEsNRcSY4Y8JaGwklMWcxiYzUMVEx7wH9f_DuCBMVUhXvOR0PcHVslILtKI2wdw79Nfih0N3VnrxfMQd08=@emersion.fr>
X-Operating-System: Linux phenom 5.6.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 09:23:11AM +0000, Simon Ser wrote:
> On Thursday, July 2, 2020 9:47 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> 
> > Finally is also adds the Scatter Memory layout, meaning the header contains IOMMU
> > references to the compressed frames content to optimize memory access
> > and layout.
> >
> > In this mode, only the header memory address is needed, thus the content
> > memory organization is tied to the current producer execution and cannot
> > be saved/dumped neither transferrable between Amlogic SoCs supporting this
> > modifier.
> 
> Still not sure how to handle this one, since this breaks fundamental
> assumptions about modifiers.

I wonder whether we should require special allocations for these, and then
just outright reject mmap on these buffers. mmap on dma-buf isn't a
required feature.

That would make sure that userspace cannot look at them.

Also I'm kinda suspecting that there's not unlimited amounts of this magic
invisible storage available anyway.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
