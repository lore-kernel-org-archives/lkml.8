Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38C0C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A67AF20738
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598303795;
	bh=bMwSIUJxidH1jwKdmC7QlpS4TW0Anq7UGTDHM8k3fHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0cuLLEIpYvaZ+8Um1uo+/E8KPiSsZFA0yfOD4iFTCvjAzNuBT1Kujg9P78NDWGi8L
	 YZASizyqRD1C/wglBa5Pl6tdi7h2GtLMjH9GNU9v2cU9xvEDBx/hNYyhWnjqg7V2Tq
	 KvY5id+wa1A7/diC2xtb/IQujxDxbiYYCyyRGe6w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgHXVQe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:46058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgHXVQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:16:33 -0400
Received: from dhcp-10-100-145-180.wdl.wdc.com (unknown [199.255.45.60])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0CE320656;
        Mon, 24 Aug 2020 21:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598303793;
        bh=bMwSIUJxidH1jwKdmC7QlpS4TW0Anq7UGTDHM8k3fHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SpOTfHk2CXMDsfLK6lm7CL7onktig8FvN0P57wGCPWdjM5lkMPs8hNmcFPoGurfZ4
         RDxterLnBGp+mIwgInC2vqBiCWoyxaQfbtD3XVbdUii1lM0WWqBEMpQC1/Dl28qIKK
         msXMqz8bWtJI9k78c9TdXEOJ/UnR8x6JOeOCVpEA=
Date:   Mon, 24 Aug 2020 14:16:30 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        james.smart@broadcom.com, hch@lst.de, chaitanya.kulkarni@wdc.com,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock in
 'nvmet_fc_fod_op_done()'
Message-ID: <20200824211630.GA1490518@dhcp-10-100-145-180.wdl.wdc.com>
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
 <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <823cd0d7-1688-7d11-1e9b-2de29b6065a6@grimberg.me>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 24, 2020 at 01:00:11PM -0700, Sagi Grimberg wrote:
> > The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> > in this function.
> > 
> > Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> > interruptions are disabled at that point, according to surrounding code.
> > 
> > Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> > ---
> > Not tested, only based on what looks logical to me according to
> > surrounding code
> > ---
> >   drivers/nvme/target/fc.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
> > index 55bafd56166a..e6861cc10e7d 100644
> > --- a/drivers/nvme/target/fc.c
> > +++ b/drivers/nvme/target/fc.c
> > @@ -2342,9 +2342,9 @@ nvmet_fc_fod_op_done(struct nvmet_fc_fcp_iod *fod)
> >   			return;
> >   		if (fcpreq->fcp_error ||
> >   		    fcpreq->transferred_length != fcpreq->transfer_length) {
> > -			spin_lock(&fod->flock);
> > +			spin_lock_irqsave(&fod->flock, flags);
> >   			fod->abort = true;
> > -			spin_unlock(&fod->flock);
> > +			spin_unlock_irqrestore(&fod->flock, flags);
> >   			nvmet_req_complete(&fod->req, NVME_SC_INTERNAL);
> >   			return;
> > 
> 
> James, can I get a reviewed-by from you on this?

afaics, the lock just serializes single writes, in which
WRITE/READ_ONCE() can handle that without a lock, right?
