Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48705C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29E0B20899
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 05:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389080AbgFXF4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 01:56:36 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:44528 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388854AbgFXF4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 01:56:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id EF110837F24A;
        Wed, 24 Jun 2020 05:56:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cap36_5b0ffc026e41
X-Filterd-Recvd-Size: 2586
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 24 Jun 2020 05:56:33 +0000 (UTC)
Message-ID: <fa304f0ef1dba4fcf5e495f3c2feb4d3816f20ac.camel@perches.com>
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
From:   Joe Perches <joe@perches.com>
To:     Vinod Koul <vkoul@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Dan Williams <dan.j.williams@intel.com>, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date:   Tue, 23 Jun 2020 22:56:32 -0700
In-Reply-To: <20200624055535.GX2324254@vkoul-mobl>
References: <20200619224334.GA7857@embeddedor>
         <20200624055535.GX2324254@vkoul-mobl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-06-24 at 11:25 +0530, Vinod Koul wrote:
> On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes.
> > 
> > This code was detected with the help of Coccinelle and, audited and
> > fixed manually.
> > 
> > Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83

Is this odd tag really useful?

> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/dma/ti/k3-udma.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> > index 0d5fb154b8e2..411c54b86ba8 100644
> > --- a/drivers/dma/ti/k3-udma.c
> > +++ b/drivers/dma/ti/k3-udma.c
> > @@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
> >  	u32 ring_id;
> >  	unsigned int i;
> >  
> > -	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> > +	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
> 
> struct_size() is a * b + c but here we need, a + b * c.. the trailing
> struct is N times here..
> 
> 
> >  	if (!d)
> >  		return NULL;
> >  
> > @@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
> >  	if (period_len >= SZ_4M)
> >  		return NULL;
> >  
> > -	d = kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> > +	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
> >  	if (!d)
> >  		return NULL;
> >  
> > -- 
> > 2.27.0

