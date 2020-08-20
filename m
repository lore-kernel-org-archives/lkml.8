Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F2F1C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4548022B43
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 17:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cAZtzVYP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbgHTRl4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 13:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727084AbgHTRlU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 13:41:20 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6D7C061387
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:41:20 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id o18so3490640eje.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TdWdmS9KmpqRDKTTx4ZFKlZV0sk8Q5cLOhIOkZ1gD+w=;
        b=cAZtzVYP2n3YvXgVkbJ7dbST+g3SP0UPbXQ9iKKyhX4VXr8jHpSYHqZMaG5ucNVipI
         bzzpnQCIz78GKzn14VpRAj8Y6mpMr87iyH7UMbPsjr5O6z0niDquexdhhjTmn1y5QjQv
         l8iJOpqbyOslL4LKhF6zS+g3cTQ+z78POnoVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TdWdmS9KmpqRDKTTx4ZFKlZV0sk8Q5cLOhIOkZ1gD+w=;
        b=RuLXf2kFkoio1iXrCYgfRSon8Nbk4Shaj9W/PTL5GiJ0mfCdn6O/gkFThFc6HcfAHI
         mGJGNeuxEpn4jF9IKlcB6dQkr+bR6mVKm3UfNHTKXF4eLEJGLjIFjrSaS6cktTHEz9Hu
         lcJ9Tggu34sP+3Leprt1ysgGg6BVghU3nSuGcOVbzNU0diEpXnymuKIdXF5MNr1Nf2nv
         NNvJDhkov/O4VMt8jdnDeOnuD8Pgwua78/V+gP+90Rqd4AePxobjkwiKmkp2e/3hwdmy
         n4NbWNjsFarE92TqpgdDe+Vc1ce2ah+FGxQ8+HpYxHnSr/M/OMSinS7aw5oZY19fHVWt
         ysog==
X-Gm-Message-State: AOAM532ofhf5/A3F8M4p2Q+jA6/fPg/Ss7zAxFoQBkGbRioxewUWdlLO
        yj0Ca4sjYBA+PxP4MSRRaaZ0xRZJt4torA==
X-Google-Smtp-Source: ABdhPJy+vhNhxV3Bi8auAWLP8v6fVuWQzowF144kevUbG8rxye4GAYU+JhqsRs5Uvy4yKKWlxDT8HQ==
X-Received: by 2002:a17:906:b248:: with SMTP id ce8mr4223939ejb.85.1597945278458;
        Thu, 20 Aug 2020 10:41:18 -0700 (PDT)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id n25sm1670566edy.79.2020.08.20.10.41.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 10:41:17 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id o21so2420328wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 10:41:16 -0700 (PDT)
X-Received: by 2002:a1c:4d12:: with SMTP id o18mr4512279wmh.55.1597945276327;
 Thu, 20 Aug 2020 10:41:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200819065555.1802761-1-hch@lst.de> <20200819065555.1802761-6-hch@lst.de>
 <CAAFQd5COLxjydDYrfx47ht8tj-aNPiaVnC+WyQA7nvpW4gs=ww@mail.gmail.com>
 <62e4f4fc-c8a5-3ee8-c576-fe7178cb4356@arm.com> <CAAFQd5AcCTDguB2C9KyDiutXWoEvBL8tL7+a==Uo8vj_8CLOJw@mail.gmail.com>
 <2b32f1d8-16f7-3352-40a5-420993d52fb5@arm.com> <20200820050214.GA4815@lst.de>
 <CAAFQd5AknYpP5BamC=wJkEJyO-q47V6Gc+HT65h6B+HyT+-xjQ@mail.gmail.com> <20200820165213.GC12693@lst.de>
In-Reply-To: <20200820165213.GC12693@lst.de>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 20 Aug 2020 19:41:03 +0200
X-Gmail-Original-Message-ID: <CAAFQd5BcH-_S=WDvqYvSPxMvQuN5atO8q=xktbMaPS-DOCAYbw@mail.gmail.com>
Message-ID: <CAAFQd5BcH-_S=WDvqYvSPxMvQuN5atO8q=xktbMaPS-DOCAYbw@mail.gmail.com>
Subject: Re: [PATCH 05/28] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, alsa-devel@alsa-project.org,
        linux-ia64@vger.kernel.org,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        nouveau@lists.freedesktop.org, linux-nvme@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        linux-mm@kvack.org, Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Joonyoung Shim <jy0922.shim@samsung.com>,
        linux-scsi@vger.kernel.org,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Matt Porter <mporter@kernel.crashing.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Pawel Osciak <pawel@osciak.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        Joerg Roedel <joro@8bytes.org>,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <linux-arm-kernel@lists.infradead.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-parisc@vger.kernel.org, netdev@vger.kernel.org,
        Seung-Woo Kim <sw0312.kim@samsung.com>,
        linux-mips@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:52 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Thu, Aug 20, 2020 at 12:24:31PM +0200, Tomasz Figa wrote:
> > > Of course this still uses the scatterlist structure with its annoying
> > > mix of input and output parametes, so I'd rather not expose it as
> > > an official API at the DMA layer.
> >
> > The problem with the above open coded approach is that it requires
> > explicit handling of the non-IOMMU and IOMMU cases and this is exactly
> > what we don't want to have in vb2 and what was actually the job of the
> > DMA API to hide. Is the plan to actually move the IOMMU handling out
> > of the DMA API?
> >
> > Do you think we could instead turn it into a dma_alloc_noncoherent()
> > helper, which has similar semantics as dma_alloc_attrs() and handles
> > the various corner cases (e.g. invalidate_kernel_vmap_range and
> > flush_kernel_vmap_range) to achieve the desired functionality without
> > delegating the "hell", as you called it, to the users?
>
> Yes, I guess I could do something in that direction.  At least for
> dma-iommu, which thanks to Robin should be all you'll need in the
> foreseeable future.

That would be really great. Let me know if we can help by testing with
V4L2/vb2 or in any other way.

Best regards,
Tomasz
