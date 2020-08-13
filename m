Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BFCC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A99D420829
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 22:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UolcndJs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726593AbgHMWEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 18:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgHMWEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 18:04:52 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520ADC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 15:04:52 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id x6so1530424ooe.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 15:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3xfqWmRtflhotperG6NWnIwC3g3Q247SCA9p41kwBGs=;
        b=UolcndJsDVYSOyRpQ9JTr2zGfNCUwNjMdyqIq4GBD+js16X0QMFHU5pkdTbeMN4D3J
         uwZsx83sUIAi5fU+Gbv5X5jO0+tv/noXUjIKV7uJOsz6DBylNxDXlnygKa+NedmkkH6d
         qTEw+QDw3sG5vtR/zRjLg8lz8ckaz7kKb1JsiOEOYroIvUHv+ofhMZxfUi+xgv5arPwO
         UvRKnfgaTxRKRU7o9D3LtRh/ubS9wF0j9Y88CIhCLROepZJfUBs77IHt62o8ek1hDQ8/
         mNQPIZ4ViJW7nKvDYb/zMZHPeb8DTESKlnSV27oRfA8E5Jq7vDISu7SxEKObQ/gQCYMS
         /TPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3xfqWmRtflhotperG6NWnIwC3g3Q247SCA9p41kwBGs=;
        b=bMF0XHo4DSWoS0XpG4HbMNhvbw+L+kxBfSGoBx7H5wXY4y5g5MR9V0YoLWBkD2GXAv
         H9OZ9mgG3PMB/AbbIhVGLp3+V5hwNlJLE0BrXvGkfU9pBrgEiO5b0CCh3CPZObhn8qH/
         dF0lMbTAqzdFawujvQVNTp0VFkwHldznHhgGcAk9FPIxJJ0/9VQxxbY+1ZdBDd0zdgDy
         L7OcfIXaMMNTbMwpa1zDZvjk0skQ6/whWP1RjHCp7X4mZYBt9nvzAhz79DepE8FgiM0N
         /feCB5P1gOKk6W9iFqLRfRbQyUJCKVaDAVfFFPRrukeBPjghkCgXYfZbZA25hbTpngEW
         nGHw==
X-Gm-Message-State: AOAM533TbJIlV0zN7OD4p9itlEx+0MfxrksjbwacKn2UN5BkXVwyrvXK
        NmlMgmHC7uBv4JkLIVNUL2S1yz5LIIwgTeEP+le9mA==
X-Google-Smtp-Source: ABdhPJzyc0QUIbGQc/Raud6mkyJ1G5M3ZSdPSTn1QQLc40+ET2RlCL4akGxQ7ZSYtufsf1cTHSfN70KY25WQ15RXw0c=
X-Received: by 2002:a4a:ca11:: with SMTP id w17mr6358838ooq.88.1597356291596;
 Thu, 13 Aug 2020 15:04:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200725032633.125006-1-john.stultz@linaro.org> <20200813100411.3gh2awfbmdjupbnw@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20200813100411.3gh2awfbmdjupbnw@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 13 Aug 2020 15:04:40 -0700
Message-ID: <CALAqxLVyNtnXeCU1u=kV02k2wGYtBW1iRVLrOpNetRCnBvepvQ@mail.gmail.com>
Subject: Re: [RFC][PATCH] dma-heap: Add proper kref handling on dma-buf heaps
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F . Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Laura Abbott <labbott@kernel.org>, linux-media@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 13, 2020 at 3:04 AM Brian Starkey <brian.starkey@arm.com> wrote:
> On Sat, Jul 25, 2020 at 03:26:33AM +0000, John Stultz wrote:
> > Add proper refcounting on the dma_heap structure.
> > While existing heaps are built-in, we may eventually
> > have heaps loaded from modules, and we'll need to be
> > able to properly handle the references to the heaps
>
> I'm not 100% clear on the intention here. What would take/drop a
> reference on a heap?

Yea. At the moment nothing, but I did this cleanup as part of some
other changes which would allow drivers that want to produce a dmabuf
without having to create their own exporter to find an existing heap
and allocate from that. Thus we needed to do proper reference counting
on the handles to the heap. Those changes are stuck for now waiting
for an user to be publicly submitted, but this change initially seemed
like a reasonable correctness cleanup, so I went ahead and sent it,
but as Daniel noted we can wait for real users to be submitted before
adding any extra complexity upstream.

> In the case of modules I think the bigger problem is how to prevent
> the module getting removed while there's still something using it.

That's true. Probably need something like a kref on each buffer allocated.

thanks
-john
