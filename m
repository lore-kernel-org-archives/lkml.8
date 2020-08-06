Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EF3C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:46:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A815206B2
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:46:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730372AbgHFRqA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:46:00 -0400
Received: from verein.lst.de ([213.95.11.211]:50250 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729027AbgHFQic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:38:32 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA0EC68D0D; Thu,  6 Aug 2020 15:55:25 +0200 (CEST)
Date:   Thu, 6 Aug 2020 15:55:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Cc:     Christoph Hellwig <hch@lst.de>, amit.pundir@linaro.org,
        linux-kernel@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, rientjes@google.com,
        jeremy.linton@arm.com, linux-rpi-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH v2 2/2] dma-pool: Only allocate from CMA when in same
 memory zone
Message-ID: <20200806135525.GA4380@lst.de>
References: <20200803160956.19235-1-nsaenzjulienne@suse.de> <20200803160956.19235-3-nsaenzjulienne@suse.de> <20200804060633.GA7368@lst.de> <e0b2a00c8cf86cb1a91804942d35c9d4b98e9f9f.camel@suse.de> <20200806051814.GA10143@lst.de> <3a530804ad5aa96d2502da8ee3e8650b0b477c0f.camel@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a530804ad5aa96d2502da8ee3e8650b0b477c0f.camel@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:50:29PM +0200, Nicolas Saenz Julienne wrote:
> > The latter is pretty much what I expect, as we only support the default and
> > per-device DMA CMAs.
> 
> Fair enough, should I send a v3 with everything cleaned-up/rebased, or you'd
> rather pick it up from your version?

Please just resend the whole thing. 
