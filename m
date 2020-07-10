Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 159BCC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6AD02075D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 18:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594405179;
	bh=jyHA0gIMMF6FTPrsLIO6MkWeFwzHovi1nfENOm+wlVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JsRGvAwGzQTOPMESuLbxd9z/sGk7pEkYPijQUMDlxjV4U7eQEbWhscURLWf9CjJeQ
	 zMMOOeNm8Gk4TjXP1Z1l6LA7jK4GfgZGfXtLrEiyiuKYfRok4tUNzIusQ2ihnRbxpy
	 7ngvsSVENC7T5Dahsqsp1nbxpfBFSxUvbaWNxeOw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgGJSTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 14:19:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:49620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbgGJSTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 14:19:38 -0400
Received: from embeddedor (unknown [200.39.25.189])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ADB6B20720;
        Fri, 10 Jul 2020 18:19:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594405177;
        bh=jyHA0gIMMF6FTPrsLIO6MkWeFwzHovi1nfENOm+wlVY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XYUi+JotslbQqHG2PJyCY2sH6+hkQlDsII0AkZNAr0/sk2wq04BdpdtXWmXHJoRDl
         H3VZptzQtEXlVIGIQaKCYE+/LUHBIeRUkOwNSDUV2hhZofmiZAWxz8tCiGeOEBoCUd
         A0YA6BImvzf2l3t6DxsokJZI7vLZHRpEE4HMPo8g=
Date:   Fri, 10 Jul 2020 13:25:12 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] dmaengine: ti: k3-udma: Use struct_size() in
 kzalloc()
Message-ID: <20200710182512.GB21202@embeddedor>
References: <20200619224334.GA7857@embeddedor>
 <20200624055535.GX2324254@vkoul-mobl>
 <3a5514c9-d966-c332-84ba-f418c26fa74c@embeddedor.com>
 <98426221-8bff-25df-a062-9ec1ca4e8f26@ti.com>
 <20200626132944.GA26003@embeddedor>
 <04a5fb89-37eb-2cf7-d085-aaa4c9ed284d@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04a5fb89-37eb-2cf7-d085-aaa4c9ed284d@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Friendly ping: who can take this, please?

Thanks
--
Gustavo

On Mon, Jun 29, 2020 at 09:43:26AM +0300, Peter Ujfalusi wrote:
> 
> 
> On 26/06/2020 16.29, Gustavo A. R. Silva wrote:
> > Hi Peter,
> > 
> > Please, see my comments below...
> > 
> > On Fri, Jun 26, 2020 at 10:30:37AM +0300, Peter Ujfalusi wrote:
> >>
> >>
> >> On 24/06/2020 20.12, Gustavo A. R. Silva wrote:
> >>> Hi Vinod,
> >>>
> >>> On 6/24/20 00:55, Vinod Koul wrote:
> >>>> On 19-06-20, 17:43, Gustavo A. R. Silva wrote:
> >>>>> Make use of the struct_size() helper instead of an open-coded version
> >>>>> in order to avoid any potential type mistakes.
> >>>>>
> >>>>> This code was detected with the help of Coccinelle and, audited and
> >>>>> fixed manually.
> >>>>>
> >>>>> Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> >>>>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> >>>>> ---
> >>>>>  drivers/dma/ti/k3-udma.c | 4 ++--
> >>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/dma/ti/k3-udma.c b/drivers/dma/ti/k3-udma.c
> >>>>> index 0d5fb154b8e2..411c54b86ba8 100644
> >>>>> --- a/drivers/dma/ti/k3-udma.c
> >>>>> +++ b/drivers/dma/ti/k3-udma.c
> >>>>> @@ -2209,7 +2209,7 @@ udma_prep_slave_sg_pkt(struct udma_chan *uc, struct scatterlist *sgl,
> >>>>>  	u32 ring_id;
> >>>>>  	unsigned int i;
> >>>>>  
> >>>>> -	d = kzalloc(sizeof(*d) + sglen * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> >>>>> +	d = kzalloc(struct_size(d, hwdesc, sglen), GFP_NOWAIT);
> >>>>
> >>>> struct_size() is a * b + c but here we need, a + b * c.. the trailing
> >>>> struct is N times here..
> >>>>
> >>>
> >>> struct_size() works exactly as expected in this case. :)
> >>> Please, see:
> >>>
> >>> include/linux/overflow.h:314:
> >>> 314 #define struct_size(p, member, count)                                   \
> >>> 315         __ab_c_size(count,                                              \
> >>> 316                     sizeof(*(p)->member) + __must_be_array((p)->member),\
> >>> 317                     sizeof(*(p)))
> >>
> >> True, struct_size is for this sort of things.
> >>
> >> Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> >>
> >> While looking it up in include/linux/overflow.h I have noticed your
> >> commit in linux-next, which adds flex_array_size()
> >>
> >> The example in the commit message contradicts with what the helper
> > 
> > There is no contradiction here.
> > 
> >> does imho. To be correct it should have been:
> >>
> >> struct something {
> >> 	size_t count;
> >> 	struct foo items[];
> >> };
> >>
> >> - struct something *instance;
> >> + struct something instance;
> >>
> >> - instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
> >> + instance.items = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
> >> instance->count = count;
> >> memcpy(instance->items, src, flex_array_size(instance, items, instance->count));
> >>
> > 
> > This is all wrong. Please, double check how struct_size() works.
> 
> Yes, I got it mixed up, I know how struct_size works... For some reason
> I just overlooked it's use in the kmalloc().
> 
> > 
> > Thanks
> > --
> > Gustavo
> > 
> >>>>>  	if (!d)
> >>>>>  		return NULL;
> >>>>>  
> >>>>> @@ -2525,7 +2525,7 @@ udma_prep_dma_cyclic_pkt(struct udma_chan *uc, dma_addr_t buf_addr,
> >>>>>  	if (period_len >= SZ_4M)
> >>>>>  		return NULL;
> >>>>>  
> >>>>> -	d = kzalloc(sizeof(*d) + periods * sizeof(d->hwdesc[0]), GFP_NOWAIT);
> >>>>> +	d = kzalloc(struct_size(d, hwdesc, periods), GFP_NOWAIT);
> >>>>>  	if (!d)
> >>>>>  		return NULL;
> >>>>>  
> >>>>> -- 
> >>>>> 2.27.0
> >>>>
> >>
> >> - Péter
> >>
> >> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> >>
> 
> - Péter
> 
> Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
> Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
> 
