Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87C4AC55182
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63D492071C
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P6R6j28S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbgDULVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728519AbgDULVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:21:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D09DC061A10
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:21:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id n4so10690646ejs.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s/ZKt1QsY+s5TFtb7WFmhUkcWp4v5hTkDaDBAF3oOQM=;
        b=P6R6j28SYh+z+pH4O0HBcIa7GGF3sMHeYZK2cJ9Pbx/XlxHbSvDCTL2CCa1pwbYTDw
         1iogg6Bquq1DtRNbEK57f6NFECXcr7flECD+TrC4vok7oaKH/qwaIJ5ZUnuDqogV+8AG
         hxUr2NlPWQbw6fI57Dqfh2dbw7FeyFGTdkCec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s/ZKt1QsY+s5TFtb7WFmhUkcWp4v5hTkDaDBAF3oOQM=;
        b=nQ3zyCQAel6PJKHlyX0LDgKHPeudElKJaw1VCtbvvUx1wXD3dVXt8CkJNpi15ymDpR
         jrBADDx51/Pfuy4pnRGZm3tYxjjHJ3Qfz4q6b3UcI9cYRFLmjCmXPcsqe3OEt9QVU+ct
         DUZCF9h6CEQYgYOkNbWheBgdRxlZvpnI2WRUNi00aB/9IVC5M0DsR9qv1LfadxSpyKY9
         9iJTX8xOHNIK4QVlY2yfvaXa2/thlR6RGH7NtjheHajfFd4im5faeJvAanGy0CHnGHIf
         nCFrIsA/pbcTc1xDSE8pq4H6uVagJfcq3Cxb7/axSzRQWjbrUUVra3DCBRNj2AIgBYxP
         lZJg==
X-Gm-Message-State: AGi0PuYwWaxlVucnf4Z0/6UTwGozAvwBPUyo/He08PF+/9TtT7pXu7fU
        C/OerMJn6HS0KgyFhDikIS+pkIL5+mVLmw==
X-Google-Smtp-Source: APiQypJ3thm/r06rzi6qEzIYiIeK3YymsQnxGsbNxLBWQ+NXtlBp1Py8WUvDmM+4cEPlaYeRPfHQHg==
X-Received: by 2002:a17:906:54cd:: with SMTP id c13mr19850532ejp.307.1587468088356;
        Tue, 21 Apr 2020 04:21:28 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id m6sm444855ejj.22.2020.04.21.04.21.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 04:21:27 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id x4so3139420wmj.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:21:26 -0700 (PDT)
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr4271980wmn.46.1587468086147;
 Tue, 21 Apr 2020 04:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20190802131226.123800-1-shik@chromium.org> <CANMq1KD3Pth7LNnVqxSesx3kSFte0eR5JqEBETv45s_9_YKWHw@mail.gmail.com>
 <20190930082310.GA1750@infradead.org> <20191001063744.GA10402@infradead.org> <CAAFQd5BN63Y-zufQo9_b6kKVX7-1Qf1LwCOKQpMKkQ5KTOf2hw@mail.gmail.com>
In-Reply-To: <CAAFQd5BN63Y-zufQo9_b6kKVX7-1Qf1LwCOKQpMKkQ5KTOf2hw@mail.gmail.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 21 Apr 2020 13:21:15 +0200
X-Gmail-Original-Message-ID: <CAAFQd5A3iazOo+MordCqKk4+5nfSOT-rFu1ypGXF+geRec0aow@mail.gmail.com>
Message-ID: <CAAFQd5A3iazOo+MordCqKk4+5nfSOT-rFu1ypGXF+geRec0aow@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Use streaming DMA APIs to transfer buffers
To:     Christoph Hellwig <hch@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        Shik Chen <shik@chromium.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        notify@kernel.org, Keiichi Watanabe <keiichiw@chromium.org>,
        Ricky Liang <jcliang@chromium.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        lkml <linux-kernel@vger.kernel.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 7:28 AM Tomasz Figa <tfiga@chromium.org> wrote:
>
> +Sergey Senozhatsky who's going to be looking into this.
>
> Hi Christoph,
>
> On Tue, Oct 1, 2019 at 3:37 PM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Sep 30, 2019 at 01:23:10AM -0700, Christoph Hellwig wrote:
> > > And drivers really have no business looking at the dma mask.  I have
> > > a plan for dma_alloc_pages API that could replace that cruft, but
> > > until then please use GFP_KERNEL and let the dma subsystem bounce
> > > buffer if needed.
> >
> > Can you try this series:
> >
> > http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/dma_alloc_pages
> >
> > and see if it does whay you need for usb?
>
> Reviving this thread. Sorry for no updates for a long time.
>
> dma_alloc_pages() still wouldn't be an equivalent replacement of the
> existing dma_alloc_coherent() (used behind the scenes by
> usb_alloc_coherent()). That's because the latter can allocate
> non-contiguous memory if the DMA device can handle it (i.e. is behind
> an IOMMU), but the former can only allocate a contiguous range of
> pages.
>
> That said, I noticed that you also put a lot of effort into making the
> NONCONSISTENT attribute more usable. Perhaps that's the way to go here
> then? Of course we would need to make sure that the attribute is
> handled properly on ARM and ARM64, which are the most affected
> platforms. Right now neither handles them. The former doesn't use the
> generic DMA mapping ops, while the latter does, but doesn't enable a
> Kconfig option needed to allow generic inconsistent allocations.
>
> Any hints would be appreciated.

Hi Christoph, would you have some time to check the above?

Hi Catalin, Will, do you know why CONFIG_DMA_NONCOHERENT_CACHE_SYNC is
not enabled on arm64?

Thanks in advance. :)

Best regards,
Tomasz
