Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF9CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:20:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F1420729
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgGTGU1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:20:27 -0400
Received: from verein.lst.de ([213.95.11.211]:45494 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbgGTGU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:20:27 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 324A068BFE; Mon, 20 Jul 2020 08:20:24 +0200 (CEST)
Date:   Mon, 20 Jul 2020 08:20:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/5] dma-mapping: make support for dma ops optional
Message-ID: <20200720062024.GA10878@lst.de>
References: <20200708152449.316476-1-hch@lst.de> <20200708152449.316476-4-hch@lst.de> <20200718171714.GA237687@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200718171714.GA237687@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 10:17:14AM -0700, Guenter Roeck wrote:
> On Wed, Jul 08, 2020 at 05:24:47PM +0200, Christoph Hellwig wrote:
> > Avoid the overhead of the dma ops support for tiny builds that only
> > use the direct mapping.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> For ppc:pmac32_defconfig and other configurations, this patch results in:

Fixed and force pushed.
