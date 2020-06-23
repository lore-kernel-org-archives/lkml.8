Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B928C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31AAE20786
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 08:00:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731578AbgFWIAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 04:00:05 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:40347 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731296AbgFWIAE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 04:00:04 -0400
X-IronPort-AV: E=Sophos;i="5.75,270,1589234400"; 
   d="scan'208";a="456171988"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 09:59:58 +0200
Date:   Tue, 23 Jun 2020 09:59:57 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Joe Perches <joe@perches.com>
cc:     trivial@kernel.org, kernel-janitors@vger.kernel.org,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial: fix kerneldoc comments
In-Reply-To: <6b0649c53e853fd2a35e9996f13e702daa0d7e2f.camel@perches.com>
Message-ID: <alpine.DEB.2.22.394.2006230954560.2367@hadrien>
References: <1592854669-20606-1-git-send-email-Julia.Lawall@inria.fr> <6b0649c53e853fd2a35e9996f13e702daa0d7e2f.camel@perches.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 22 Jun 2020, Joe Perches wrote:

> On Mon, 2020-06-22 at 21:37 +0200, Julia Lawall wrote:
> > Fix the parameter names in the comment to correspond to those in the
> > function header.
> >
> > Drop comments about return values when there is no return value.
>
> Done by hand or script?

Found by script but done by hand.  Unfortuntely, I can't figure even a
hackish way to get Coccinelle to modify comments.  I guess I could have
used Coccinelle to print out a patch and then run that, but since the
result has to be checked anyway, I just made the changes by hand.

>
> []
> > diff --git a/arch/mips/cavium-octeon/executive/cvmx-spi.c b/arch/mips/cavium-octeon/executive/cvmx-spi.c
> []
> > @@ -69,9 +69,7 @@ static cvmx_spi_callbacks_t cvmx_spi_callbacks = {
> >  /**
> >   * Get current SPI4 initialization callbacks
> >   *
> > - * @callbacks:	Pointer to the callbacks structure.to fill
> > - *
> > - * Returns Pointer to cvmx_spi_callbacks_t structure.
> > + * @callbacks:	Pointer to the callbacks structure, to fill.
>
> If scripted, odd comma after structure

Hmm, maybe I interpreted the words slightly differently.  t looks like it
would be fine without the comma.

>
> > diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
> []
> > @@ -519,7 +519,7 @@ u32 spum_assoc_resp_len(enum spu_cipher_mode cipher_mode,
> >   * spu_aead_ivlen() - Calculate the length of the AEAD IV to be included
> >   * in a SPU request after the AAD and before the payload.
> >   * @cipher_mode:  cipher mode
> > - * @iv_ctr_len:   initialization vector length in bytes
> > + * @iv_len:   initialization vector length in bytes
> >   *
> >   * In Linux ~4.2 and later, the assoc_data sg includes the IV. So no need
> >   * to include the IV as a separate field in the SPU request msg.
> > @@ -917,7 +917,7 @@ u16 spum_cipher_req_init(u8 *spu_hdr, struct spu_cipher_parms *cipher_parms)
> >   * setkey() time in spu_cipher_req_init().
> >   * @spu_hdr:         Start of the request message header (MH field)
> >   * @spu_req_hdr_len: Length in bytes of the SPU request header
> > - * @isInbound:       0 encrypt, 1 decrypt
> > + * @is_inbound:       0 encrypt, 1 decrypt
>
> odd alignments

Sorry to have missed these.

> etc...

Are there a lot of other such problems?  I did look through the whole
patch several times by hand, but perhaps it is just too big to see
everything.

julia
