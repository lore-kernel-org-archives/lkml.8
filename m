Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3928DC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06C1320708
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:30:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xGbq/nBk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729909AbgEFQa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727984AbgEFQa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:30:28 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E060C061A10
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 09:30:28 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id c12so1283265oic.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 09:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EvHPxE7L1Cb6oif98tDAWFYOvy9QzwI+EVnlaf1jpTo=;
        b=xGbq/nBkeNTeQkh8TeQ07h15oTGAYHX6j5LFfR/RI3sHIvBIymNOSSXRcu+wHZ1aVW
         Bi9WC0jgv9B5Kp+7cwBmKtfn1QjRyVdEkInImfKuIlVtWGUJmKfhJrI1QWyRGwCX0yJD
         ZWlgp81bR5ws/479qoQiUXdTQKezTywlxfTMxQqtDA8i2bG+9sntoecsCgJ9HLEPbqvg
         G34LbxJQDBp7Gtl0+VsmxjLGveZyAEy3fCO4pbX5afZwwEcYRPCDhYIDmwlFwhGzmFcG
         Lqdq+jCKkXA8vZnRXREVS+dR1h3wiY7f35aHnymxitA672W5CrNu0RAOCSEsoG6c/aHS
         oveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EvHPxE7L1Cb6oif98tDAWFYOvy9QzwI+EVnlaf1jpTo=;
        b=VISBvQ1SdsvjtVXOo/Gi2sjou6kifAM+08726iiNhF2pRwTPCyqjq8aq3sDB/c63sz
         KGvgnEVoYUqjPawo8Y0WpL0/uvQUvr795W88nrJeHFU+ew4UzlkzSpo57wynxjKln1sY
         fKwpjYZhbBOhe31SJzJ/GKHh2qG/6mlH8DwXSHNEbYEpVRmNcPJdL+PCl4w3Ic1cArxf
         lrgeXcNj9o8XnSDCv+icRwthPYizU8z2aeVhxpv2CO/1Uor6OH0kSjIfJYFVp0kmUynB
         TtibMqIhx8z5GiJRPv/KTCbv8nUkCblybReGt68mCfaGQV87AJxUCOXbH2LyNt2KJWMh
         k6+Q==
X-Gm-Message-State: AGi0PubS1h8KyizS/Pl+Cq4qrjCxu8PRupJBP+QGNNSof1WvHlJYqoj2
        SLlQpsv6P5/2mNYvIHViI+A62OFWZEn7ohq1X0JmVg==
X-Google-Smtp-Source: APiQypJOjwli0ENiyI3cl299qwfEK7rVXtgNZRAGsYZ2j/Qgmpsi7m4V2zQHdFeurrc2zQ1jwMe1nfOg2GrAWKcKGNo=
X-Received: by 2002:aca:cf83:: with SMTP id f125mr3336594oig.97.1588782627545;
 Wed, 06 May 2020 09:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200501073949.120396-1-john.stultz@linaro.org>
 <20200501073949.120396-2-john.stultz@linaro.org> <20200501104216.4f226c2a7bzval5o@DESKTOP-E1NTVVP.localdomain>
 <CALAqxLVScV1j-zxw=cwpE0+eDoaubchXx6SJgu=1Zvh8HnE-Tg@mail.gmail.com>
 <20200504085007.5yrjhknkg6ugbqwk@DESKTOP-E1NTVVP.localdomain> <1bddb721-d4d9-f113-bacc-0a0ca2d57753@ti.com>
In-Reply-To: <1bddb721-d4d9-f113-bacc-0a0ca2d57753@ti.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 6 May 2020 09:30:16 -0700
Message-ID: <CALAqxLWnEj-c3CYGC6p23cwMqce-MV6pJOzGbp+ptWFB0NQoog@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/4] devicetree: bindings: Add linux,cma-heap tag for
 reserved memory
To:     "Andrew F. Davis" <afd@ti.com>
Cc:     Brian Starkey <brian.starkey@arm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
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

On Wed, May 6, 2020 at 9:04 AM Andrew F. Davis <afd@ti.com> wrote:
> On 5/4/20 4:50 AM, Brian Starkey wrote:
> > On Fri, May 01, 2020 at 11:40:16AM -0700, John Stultz wrote:
> >> So the name we expose is the CMA name itself. So with dt it will be
> >> the name of the reserved memory node that the flag property is added
> >> to.
> >>
> >
> > Yeah I'm just wondering if that's "stable" so we can say "the heap
> > will use the node name", or if saying that would cause us a headache
> > in the future.
>
>
> The issue is going to be this causes the node name in DT to become a
> kind of ABI. Right now until we have some userspace lib that enumerates
> the heaps in a stable way programs will hard-code the full heap name,
> which right now would look like:
>
> char *heap = "/dev/dma_heap/dma_heap_mem@89000000";
>

If that's what the device chose to export.

> Yuk.. we might want to look into exporting heap properties to make them
> searchable based on something other than name here soon. Or this will be
> a mess to cleanup in the future.

Eh. I don't see this as such an issue. On different systems we have
different device nodes. Some boards have more or fewer NICs, or
various partitions, etc. There has to be some device specific userland
config that determines which partitions are mounted where (this is my
"gralloc is fstab" thesis :)

I think with the heaps, qualities other than name are going to be
poorly specified or unenumerable, so any generic query interface is
going to fall down there (and be awful to use).

thanks
-john
