Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EADC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A77262076E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbgFZHUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:20:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52030 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbgFZHUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:20:43 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1joiex-0005M6-Hl; Fri, 26 Jun 2020 17:20:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jun 2020 17:20:27 +1000
Date:   Fri, 26 Jun 2020 17:20:27 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        Mahipal Challa <mahipalreddy2006@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH v3] mm/zswap: move to use crypto_acomp API for hardware
 acceleration
Message-ID: <20200626072027.GA6153@gondor.apana.org.au>
References: <20200626070903.27988-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626070903.27988-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 07:09:03PM +1200, Barry Song wrote:
>
> +	mutex_lock(&acomp_ctx->mutex);
> +
> +	src = kmap(page);
> +	dst = acomp_ctx->dstmem;
> +	sg_init_one(&input, src, PAGE_SIZE);
> +	/* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_list */
> +	sg_init_one(&output, dst, PAGE_SIZE * 2);
> +	acomp_request_set_params(acomp_ctx->req, &input, &output, PAGE_SIZE, dlen);
> +	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req), &acomp_ctx->wait);
> +	dlen = acomp_ctx->req->dlen;
> +	kunmap(page);

Waiting on an async request like this is just silly.  This defeats
the whole purpose of having a fallback.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
