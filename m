Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 353F4C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B44206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 09:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732210AbgFWJpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 05:45:51 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:25955
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732023AbgFWJpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 05:45:50 -0400
X-IronPort-AV: E=Sophos;i="5.75,270,1589234400"; 
   d="scan'208";a="352454737"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 11:45:48 +0200
Date:   Tue, 23 Jun 2020 11:45:48 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Joe Perches <joe@perches.com>, trivial@kernel.org,
        kernel-janitors@vger.kernel.org, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] trivial: fix kerneldoc comments
In-Reply-To: <20200623093228.GI4151@kadam>
Message-ID: <alpine.DEB.2.22.394.2006231145350.2367@hadrien>
References: <1592854669-20606-1-git-send-email-Julia.Lawall@inria.fr> <6b0649c53e853fd2a35e9996f13e702daa0d7e2f.camel@perches.com> <alpine.DEB.2.22.394.2006230954560.2367@hadrien> <20200623093228.GI4151@kadam>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 23 Jun 2020, Dan Carpenter wrote:

> On Tue, Jun 23, 2020 at 09:59:57AM +0200, Julia Lawall wrote:
> > > > diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
> > > []
> > > > @@ -519,7 +519,7 @@ u32 spum_assoc_resp_len(enum spu_cipher_mode cipher_mode,
> > > >   * spu_aead_ivlen() - Calculate the length of the AEAD IV to be included
> > > >   * in a SPU request after the AAD and before the payload.
> > > >   * @cipher_mode:  cipher mode
> > > > - * @iv_ctr_len:   initialization vector length in bytes
> > > > + * @iv_len:   initialization vector length in bytes
> > > >   *
> > > >   * In Linux ~4.2 and later, the assoc_data sg includes the IV. So no need
> > > >   * to include the IV as a separate field in the SPU request msg.
> > > > @@ -917,7 +917,7 @@ u16 spum_cipher_req_init(u8 *spu_hdr, struct spu_cipher_parms *cipher_parms)
> > > >   * setkey() time in spu_cipher_req_init().
> > > >   * @spu_hdr:         Start of the request message header (MH field)
> > > >   * @spu_req_hdr_len: Length in bytes of the SPU request header
> > > > - * @isInbound:       0 encrypt, 1 decrypt
> > > > + * @is_inbound:       0 encrypt, 1 decrypt
> > >
> > > odd alignments
> >
> > Sorry to have missed these.
> >
> > > etc...
> >
> > Are there a lot of other such problems?  I did look through the whole
> > patch several times by hand, but perhaps it is just too big to see
> > everything.
>
> Probably the comments for spum_assoc_resp_len() could be tweaked.
>
> I had written an email about this one that Joe mentioned and
> spum_assoc_resp_len() but then I decided that it wasn't enough to worry
> about so I deleted the email instead of sending it.

OK, thanks.

julia
