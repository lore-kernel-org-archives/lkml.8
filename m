Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08643C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C2E20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 21:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q0UxC/il"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732717AbgCPVmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 17:42:37 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40761 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732636AbgCPVmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 17:42:37 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so10480459pgj.7
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 14:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NTkxtOwEANxkO9zEv+WbaFrh5P4NFs877G9IZYZa6G0=;
        b=Q0UxC/ilm5Yj72nspacCKCzqcCybkn/S8Z/zziaong8tJWs8hQv1AnAErdiLR9KjmT
         +mqroxXJRFyQX7S7wEPfzcT+gxUgHEO5P35Mfzk1f9GM3zzm/gJ5T9JO6W64llpAUVJV
         MYA2LsC+8bj4b87eoIUpcRuQuV/Ki7ItpQNZUFul1Rm88P1nc7atiBOEl7F1VswNHKZ+
         5fRlnKCGKuSiE+OHVLAacCegQeGkRn7CMtBYXPqhlRqbbxlDUi+slRZj4kysAMyu5rZG
         DC/artMWW5ayfJjX9IkupdJa3V97nseM04tBJpqLFWepqxpT2J6TYfHw4yDbWVOyATyo
         6noA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NTkxtOwEANxkO9zEv+WbaFrh5P4NFs877G9IZYZa6G0=;
        b=k3hiyQnoAYf37jo7oaluoSHSKBC5DQMUPkdt6lPjUr/h69W30cwL7YfY2GNwszbkf2
         Of/fgs9nsqHMFKu/XtK+8ynPT7631HesnxPkeHeg5w+pzzFRIBUZWYigM1uWurnFln/6
         l9kxzMYfyxAdTUtOgyDiX4JNTfXZYSS15O9naXwOFNkvnZh3e1WgnAgsb5X/h3nqE4Hs
         dl4hHAx4l1k4tiL6e+TKt150tkLHsvb1hhFq+6Dh08XxBD50dG8buwCVgciLPRdATeOS
         9iR3YUhFlfeiAtxK9S5SPNgSgSNiTfD4eWpbPC2Q+ABm8SIfMZ2WuI4EHQrYJEnI3Aa0
         BmPw==
X-Gm-Message-State: ANhLgQ0MLhAY6O2pp4qSD8KcTK83N9TR+ZVkKC3vnm4gSy/A70bKehfe
        JzFcBSIOBhPqWZwQm8tyBzQ=
X-Google-Smtp-Source: ADFU+vvqlRAbJQxbmTBBkq7PgloaRj2Q0vuZBILQe1emzMAH4EPmwx6ce20pYelVryACwes3YG9X4w==
X-Received: by 2002:a63:5f41:: with SMTP id t62mr1797570pgb.114.1584394954060;
        Mon, 16 Mar 2020 14:42:34 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id d7sm830750pfa.106.2020.03.16.14.42.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Mar 2020 14:42:33 -0700 (PDT)
Date:   Mon, 16 Mar 2020 14:42:49 -0700
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>, m.szyprowski@samsung.com,
        linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: [RFC][PATCH] dma-mapping: align default segment_boundary_mask
 with dma_mask
Message-ID: <20200316214248.GB18970@Asurada-Nvidia.nvidia.com>
References: <20200314000007.13778-1-nicoleotsuka@gmail.com>
 <f36ac67e-0eca-46df-78ec-c8b1c4fbe951@arm.com>
 <20200316124652.GA17386@lst.de>
 <09b61b1d-800a-ff18-71f6-57a5f569ea3c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09b61b1d-800a-ff18-71f6-57a5f569ea3c@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 01:16:16PM +0000, Robin Murphy wrote:
> On 2020-03-16 12:46 pm, Christoph Hellwig wrote:
> > On Mon, Mar 16, 2020 at 12:12:08PM +0000, Robin Murphy wrote:
> > > On 2020-03-14 12:00 am, Nicolin Chen wrote:
> > > > More and more drivers set dma_masks above DMA_BIT_MAKS(32) while
> > > > only a handful of drivers call dma_set_seg_boundary(). This means
> > > > that most drivers have a 4GB segmention boundary because DMA API
> > > > returns DMA_BIT_MAKS(32) as a default value, though they might be
> > > > able to handle things above 32-bit.
> > > 
> > > Don't assume the boundary mask and the DMA mask are related. There do exist
> > > devices which can DMA to a 64-bit address space in general, but due to
> > > descriptor formats/hardware design/whatever still require any single
> > > transfer not to cross some smaller boundary. XHCI is 64-bit yet requires
> > > most things not to cross a 64KB boundary. EHCI's 64-bit mode is an example
> > > of the 4GB boundary (not the best example, admittedly, but it undeniably
> > > exists).
> > 
> > Yes, which is what the boundary is for.  But why would we default to
> > something restrictive by default even if the driver didn't ask for it?
> 
> I've always assumed it was for the same reason as the 64KB segment length,
> i.e. it was sufficiently common as an actual restriction, but still "good
> enough" for everyone else. I remember digging up all the history to
> understand what these were about back when I implemented the map_sg stuff,
> and from that I'd imagine the actual values are somewhat biased towards SCSI
> HBAs, since they originated in the block and SCSI layers.

Yea, I did the same:

commit d22a6966b8029913fac37d078ab2403898d94c63
Author: FUJITA Tomonori <tomof@acm.org>
Date:   Mon Feb 4 22:28:13 2008 -0800

    iommu sg merging: add accessors for segment_boundary_mask in device_dma_parameters()

    This adds new accessors for segment_boundary_mask in device_dma_parameters
    structure in the same way I did for max_segment_size.  So we can easily change
    where to place struct device_dma_parameters in the future.

    dma_get_segment boundary returns 0xffffffff if dma_parms in struct device
    isn't set up properly.  0xffffffff is the default value used in the block
    layer and the scsi mid layer.

    Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
    Cc: James Bottomley <James.Bottomley@steeleye.com>
    Cc: Jens Axboe <jens.axboe@oracle.com>
    Cc: Greg KH <greg@kroah.com>
    Cc: Jeff Garzik <jeff@garzik.org>
    Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
