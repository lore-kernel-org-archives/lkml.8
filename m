Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64965C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D08B20760
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 13:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hlKDnjFX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbgGANfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 09:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730916AbgGANfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 09:35:12 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1793DC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 06:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6o0bqYA9UibQkqr/MmLZIfw1Phn9yQ8zQ1ln3u9Cm/E=; b=hlKDnjFXs/Y5WjrWNNgSQ+2Cvd
        RvsmfMbhXkV1KC+OK+5x7CGESEtA1Qk4HZeAu6Yaz/UH9zEAUbNa9FVjAhV4Duiv/yAyXRv3/1ni3
        CSmwa08RJtybgECUGXsj6t5Ikz9WU8jXnEjZhSsiO4Cce5bMLn+ryrsvUEQAfHt3Y/kj2M4b29Xj0
        2lORXLltD3a0Za4R4fVC/+lv0bptUhSUEHkFmEDfSV3phIa7QD/g3Q2Zle+t27uSL2Zcfg1ARrlES
        xPbJ0Leq9BQuYJ3vQmrkn81G/oqYWCgAUIa51MwnCk73e/oMjUpHEK7/k+Ajj3vJC3XBgczD+ReMg
        1fAQgQbQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqct6-0006Qi-2K; Wed, 01 Jul 2020 13:34:56 +0000
Date:   Wed, 1 Jul 2020 14:34:56 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>, Peng Fan <peng.fan@nxp.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        konrad.wilk@oracle.com, jasowang@redhat.com, x86@kernel.org,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org, linux-imx@nxp.com
Subject: Re: [PATCH] xen: introduce xen_vring_use_dma
Message-ID: <20200701133456.GA23888@infradead.org>
References: <20200624091732.23944-1-peng.fan@nxp.com>
 <20200624050355-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241047010.8121@sstabellini-ThinkPad-T480s>
 <20200624163940-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006241351430.8121@sstabellini-ThinkPad-T480s>
 <20200624181026-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006251014230.8121@sstabellini-ThinkPad-T480s>
 <20200626110629-mutt-send-email-mst@kernel.org>
 <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2006291621300.8121@sstabellini-ThinkPad-T480s>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 04:46:09PM -0700, Stefano Stabellini wrote:
> > I could imagine some future Xen hosts setting a flag somewhere in the
> > platform capability saying "no xen specific flag, rely on
> > "VIRTIO_F_ACCESS_PLATFORM". Then you set that accordingly in QEMU.
> > How about that?
> 
> Yes, that would be fine and there is no problem implementing something
> like that when we get virtio support in Xen. Today there are still no
> virtio interfaces provided by Xen to ARM guests (no virtio-block/net,
> etc.)
> 
> In fact, in both cases we are discussing virtio is *not* provided by
> Xen; it is a firmware interface to something entirely different:
> 
> 1) virtio is used to talk to a remote AMP processor (RPMesg)
> 2) virtio is used to talk to a secure-world firmware/OS (Trusty)
>
> VIRTIO_F_ACCESS_PLATFORM is not set by Xen in these cases but by RPMesg
> and by Trusty respectively. I don't know if Trusty should or should not
> set VIRTIO_F_ACCESS_PLATFORM, but I think Linux should still work
> without issues.
> 

Any virtio implementation that is not in control of the memory map
(aka not the hypervisor) absolutely must set VIRTIO_F_ACCESS_PLATFORM,
else it is completely broken.

> The xen_domain() check in Linux makes it so that vring_use_dma_api
> returns the opposite value on native Linux compared to Linux as Xen/ARM
> DomU by "accident". By "accident" because there is no architectural
> reason why Linux Xen/ARM DomU should behave differently compared to
> native Linux in this regard.
> 
> I hope that now it is clearer why I think the if (xen_domain()) check
> needs to be improved anyway, even if we fix generic dma_ops with virtio
> interfaces missing VIRTIO_F_ACCESS_PLATFORM.

IMHO that Xen quirk should never have been added in this form..
