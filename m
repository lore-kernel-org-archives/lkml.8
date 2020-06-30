Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C92C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA62206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 03:09:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbgF3DJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 23:09:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60732 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbgF3DJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 23:09:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jq6eW-0007F8-FF; Tue, 30 Jun 2020 13:09:45 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 30 Jun 2020 13:09:44 +1000
Date:   Tue, 30 Jun 2020 13:09:44 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>
Cc:     Ignat Korchagin <ignat@cloudflare.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "dm-crypt@saout.de" <dm-crypt@saout.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "mpatocka@redhat.com" <mpatocka@redhat.com>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>
Subject: Re: [PATCH v2] dm crypt: add flags to optionally bypass dm-crypt
 workqueues
Message-ID: <20200630030944.GA20706@gondor.apana.org.au>
References: <20200626210302.1813-1-ignat@cloudflare.com>
 <CY4PR04MB375127DC313F70875CAAC841E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR04MB375127DC313F70875CAAC841E76F0@CY4PR04MB3751.namprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 02:51:17AM +0000, Damien Le Moal wrote:
>
> > @@ -1463,12 +1465,12 @@ static void crypt_alloc_req_skcipher(struct crypt_config *cc,
> >  	 * requests if driver request queue is full.
> >  	 */
> >  	skcipher_request_set_callback(ctx->r.req,
> > -	    CRYPTO_TFM_REQ_MAY_BACKLOG,
> > +	    nobacklog ? 0 : CRYPTO_TFM_REQ_MAY_BACKLOG,
> >  	    kcryptd_async_done, dmreq_of_req(cc, ctx->r.req));
> 
> Will not specifying CRYPTO_TFM_REQ_MAY_BACKLOG always cause the crypto API to
> return -EBUSY ? From the comment above the skcipher_request_set_callback(), it
> seems that this will be the case only if the skcipher diver queue is full. So in
> other word, keeping the kcryptd_async_done() callback and executing the skcipher
> request through crypt_convert() and crypt_convert_block_skcipher() may still end
> up being an asynchronous operation. Can you confirm this and is it what you
> intended to implement ?

The purpose of MAY_BACKLOG is to make the crypto request reliable.
It has nothing to do with whether the request will be synchronous
or not.

Without the backlog flag, if the hardware queue is full the request
will simply be dropped, which is appropriate in the network stack
with IPsec where congestion can be dealt with at the source.

Block layer on the other hand should always use the backlog flag
and stop sending more requests to the crypto API until the congestion
goes away.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
