Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CA04C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A37A20C09
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 00:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388183AbgFXAXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 20:23:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:47128 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388058AbgFXAXS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 20:23:18 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jntBt-0007UK-4q; Wed, 24 Jun 2020 10:23:02 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 24 Jun 2020 10:23:01 +1000
Date:   Wed, 24 Jun 2020 10:23:01 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Mike Snitzer <snitzer@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        "David S. Miller" <davem@davemloft.net>, agk@redhat.com,
        dm-devel@redhat.com, dm-crypt@saout.de,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@cloudflare.com>
Subject: Re: [RFC PATCH 0/1] dm-crypt excessive overhead
Message-ID: <20200624002301.GB12716@gondor.apana.org.au>
References: <20200619164132.1648-1-ignat@cloudflare.com>
 <20200619165548.GA24779@redhat.com>
 <alpine.LRH.2.02.2006191429060.23991@file01.intranet.prod.int.rdu2.redhat.com>
 <20200620012332.GA25340@gondor.apana.org.au>
 <20200623153352.GA19783@redhat.com>
 <CALrw=nEjCdg8BuTFT81+tCDtuxgwy05FKZAdvk3oq+pauW0nDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALrw=nEjCdg8BuTFT81+tCDtuxgwy05FKZAdvk3oq+pauW0nDA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 05:24:39PM +0100, Ignat Korchagin wrote:
> 
> I may be misunderstanding the terminology, but tasklets execute in
> soft IRQ, don't they? What we care about is to execute the decryption
> as fast as possible, but we can't do it in a hard IRQ context (that
> is, the interrupt context where other interrupts are disabled). As far
> as I understand, tasklets are executed right after the hard IRQ
> context, but with interrupts enabled - which is the first safe-ish
> place to do more lengthy processing without the risk of missing an
> interrupt.

Yes you are absolutely right.  In general high-performance work
should be carried out in softirq context.  That's how the networking
stack works for example.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
