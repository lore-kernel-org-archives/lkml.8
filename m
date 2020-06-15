Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A34EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB2020644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730406AbgFOORA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:17:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730064AbgFOOQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:16:59 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEFDC061A0E;
        Mon, 15 Jun 2020 07:16:59 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jkpup-009O2v-Rs; Mon, 15 Jun 2020 14:16:48 +0000
Date:   Mon, 15 Jun 2020 15:16:47 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Sagi Grimberg <sagi@lightbitslabs.com>,
        Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org
Subject: Re: [v3 PATCH] iov_iter: Move unnecessary inclusion of crypto/hash.h
Message-ID: <20200615141647.GK23230@ZenIV.linux.org.uk>
References: <20200611074332.GA12274@gondor.apana.org.au>
 <20200611114911.GA17594@gondor.apana.org.au>
 <20200612065737.GA17176@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200612065737.GA17176@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 04:57:37PM +1000, Herbert Xu wrote:
> The header file linux/uio.h includes crypto/hash.h which pulls in
> most of the Crypto API.  Since linux/uio.h is used throughout the
> kernel this means that every tiny bit of change to the Crypto API
> causes the entire kernel to get rebuilt.
> 
> This patch fixes this by moving it into lib/iov_iter.c instead
> where it is actually used.
> 
> This patch also fixes the ifdef to use CRYPTO_HASH instead of just
> CRYPTO which does not guarantee the existence of ahash.
> 
> Unfortunately a number of drivers were relying on linux/uio.h to
> provide access to linux/slab.h.  This patch adds inclusions of
> linux/slab.h as detected by build failures.
> 
> Also skbuff.h was relying on this to provide a declaration for
> ahash_request.  This patch adds a forward declaration instead.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

Applied; let it sit in -next for a while to get better build coverage...
