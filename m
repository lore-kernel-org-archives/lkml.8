Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C4A7C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671A720768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 07:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728902AbgFZHzG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 03:55:06 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:57818 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728635AbgFZHzG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 03:55:06 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 4A9A0319FB231A37A57C;
        Fri, 26 Jun 2020 15:55:01 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.126]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Fri, 26 Jun 2020 15:54:50 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "Luis Claudio R . Goncalves" <lgoncalv@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "David S . Miller" <davem@davemloft.net>,
        "Mahipal Challa" <mahipalreddy2006@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        "Dan Streetman" <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Wangzhou (B)" <wangzhou1@hisilicon.com>,
        Colin Ian King <colin.king@canonical.com>
Subject: RE: [PATCH v3] mm/zswap: move to use crypto_acomp API for hardware
 acceleration
Thread-Topic: [PATCH v3] mm/zswap: move to use crypto_acomp API for hardware
 acceleration
Thread-Index: AQHWS4ju6iURsG9yIk+EgvuPOVc69qjp91mAgACMbEA=
Date:   Fri, 26 Jun 2020 07:54:49 +0000
Message-ID: <B926444035E5E2439431908E3842AFD25245A6@DGGEMI525-MBS.china.huawei.com>
References: <20200626070903.27988-1-song.bao.hua@hisilicon.com>
 <20200626072027.GA6153@gondor.apana.org.au>
In-Reply-To: <20200626072027.GA6153@gondor.apana.org.au>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.84]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Herbert Xu
> Sent: Friday, June 26, 2020 7:20 PM
> To: Song Bao Hua (Barry Song) <song.bao.hua@hisilicon.com>
> Cc: akpm@linux-foundation.org; linux-mm@kvack.org;
> linux-kernel@vger.kernel.org; Linuxarm <linuxarm@huawei.com>; Luis Claudio
> R . Goncalves <lgoncalv@redhat.com>; Sebastian Andrzej Siewior
> <bigeasy@linutronix.de>; David S . Miller <davem@davemloft.net>; Mahipal
> Challa <mahipalreddy2006@gmail.com>; Seth Jennings
> <sjenning@redhat.com>; Dan Streetman <ddstreet@ieee.org>; Vitaly Wool
> <vitaly.wool@konsulko.com>; Wangzhou (B) <wangzhou1@hisilicon.com>;
> Colin Ian King <colin.king@canonical.com>
> Subject: Re: [PATCH v3] mm/zswap: move to use crypto_acomp API for
> hardware acceleration
> 
> On Fri, Jun 26, 2020 at 07:09:03PM +1200, Barry Song wrote:
> >
> > +	mutex_lock(&acomp_ctx->mutex);
> > +
> > +	src = kmap(page);
> > +	dst = acomp_ctx->dstmem;
> > +	sg_init_one(&input, src, PAGE_SIZE);
> > +	/* zswap_dstmem is of size (PAGE_SIZE * 2). Reflect same in sg_list */
> > +	sg_init_one(&output, dst, PAGE_SIZE * 2);
> > +	acomp_request_set_params(acomp_ctx->req, &input, &output,
> PAGE_SIZE, dlen);
> > +	ret = crypto_wait_req(crypto_acomp_compress(acomp_ctx->req),
> &acomp_ctx->wait);
> > +	dlen = acomp_ctx->req->dlen;
> > +	kunmap(page);
> 
> Waiting on an async request like this is just silly.  This defeats
> the whole purpose of having a fallback.

For this zswap case and for this moment, it is probably not.
As for this case, there are no two parallel (de)compressions which can be done in parallel
in a single (de)compressor instance.
The original zswap code is doing all compression/decompression in atomic context.
Right now, to use acomp api, the patch has moved to sleep-able context.

However, compression/decompression can be done in parallel in different instances
of acomp, also different cpus.

If we want to do multiple (de)compressions simultaneously in one acomp instance
by callbacks, it will ask a large changes in zswap.c not only using the new APIs. I think
we can only achieve the ideal goal step by step.

> 
> Cheers,
> --
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-barry

