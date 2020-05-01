Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4622C47257
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2A5E21835
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:42:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sqk3ZNvO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730241AbgEASml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729721AbgEASmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:42:40 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72EB6C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:42:40 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id j4so3262958otr.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yq7Ibs47iQ7Lo5VGMp7gRZ6yUxyqVA2i9kts0jwiLrg=;
        b=Sqk3ZNvO90q24WbyfeYjeqHXxER0SZRc5xSI5RM5Nuv9B3ZrYEi33jQuT1hGlipWhW
         hvfe10Z7MjuWVqIgFIGCh1vX61lDdIWshuPxlhpxYvSGgIykaDH4wYq9CcG9PYvJCxnG
         Qod+n3wh9PZsgmkcNsHVm4KLG8FyyBIFO8o+o+M0pbZrNFM0eWtfAF6okflgipvcQ1k0
         ZpKOab+w3go1VnlFI2C/NWHJFgBePuy+8oTNmaHzdoaXKkj+5vcaptuIxg4ethg4nCCg
         oe12HiqThde5msD1xr4IG5FgmGjSqY+lbxjSPwdLZoqN9ONczywqxt+3yssPl4cyaexa
         9RFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yq7Ibs47iQ7Lo5VGMp7gRZ6yUxyqVA2i9kts0jwiLrg=;
        b=XwwGRxoTHHcybDLBMQw7XOVfNL0nLugyw5gs0pXLaBCbMItDumvAT28Bz+QuKId1dL
         aj95dky268ZzZXj2i6s6Z+tFA+5ciN+OCOPWZtkJ47K8+iN/XWJg/2iBCkS4IVy9JG+v
         hWNN0E1U/nJ0v9bE3QwssMjyxs31KMBqVY4sVbGX4eMFvbtL6eLu5QKOD64W7WrUXk5S
         7hQNQGZPUJAKQlAuF6UrrYlIgzkk84ansgNuEkVR0nx4DXnbzl5UKyfJkzMRKgejdBGE
         xLA/thaaSHKBd+T0qXLVCb8EwnhpHJixOJxf9mIfydk5dwdIrapL8xel3WAAP2JGVnOe
         zYpg==
X-Gm-Message-State: AGi0Puafv906Os215Be+nD2ukCD2+fiORGBS7w7f69cc3V3cFh7dpgDT
        WZcndkn6OxETy0UtW8aWOYMh3Nwyef45ttIrrbacbg==
X-Google-Smtp-Source: APiQypL+VkyGnMilOhi+kaL79AKLY56zEToU7HIKl+3eFaVpJsUVoYecvtEHrqDQsSqZiNr1DTrBBFivrPw2tyNZtok=
X-Received: by 2002:a05:6830:1589:: with SMTP id i9mr4948265otr.102.1588358559590;
 Fri, 01 May 2020 11:42:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-3-john.stultz@linaro.org> <20200501104810.v6oa2yhawr4iki67@DESKTOP-E1NTVVP.localdomain>
In-Reply-To: <20200501104810.v6oa2yhawr4iki67@DESKTOP-E1NTVVP.localdomain>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 1 May 2020 11:42:28 -0700
Message-ID: <CALAqxLVt0HJH5_2BvO7fRGZ_Vp9kKzj+j2=BZu_cbw=75dNoYQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 2/4] mm: cma: Add dma_heap flag to cma structure
To:     Brian Starkey <brian.starkey@arm.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        "Andrew F. Davis" <afd@ti.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        Liam Mark <lmark@codeaurora.org>,
        Pratik Patel <pratikp@codeaurora.org>,
        Laura Abbott <labbott@redhat.com>,
        Chenbo Feng <fengc@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-mm <linux-mm@kvack.org>, nd <nd@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 1, 2020 at 3:48 AM Brian Starkey <brian.starkey@arm.com> wrote:
> On Fri, May 01, 2020 at 07:39:47AM +0000, John Stultz wrote:
> > +bool cma_dma_heap_enabled(struct cma *cma)
> > +{
> > +     return !!cma->dma_heap;
>
> Stylistic thing, but I don't think the !! is really necessary. It's
> already a bool anyway.

Yea, I was using a bit field earlier and then moved to a bool for
simplicity and left this. I saw it as soon as I sent the patch, so
it's already fixed up.

> > @@ -157,6 +167,7 @@ static int __init cma_init_reserved_areas(void)
> >  }
> >  core_initcall(cma_init_reserved_areas);
> >
> > +
>
> nit: spurious newline

Yep. Same. The things you only see once the mail is sent. :)

Thanks so much for the review though!
-john
