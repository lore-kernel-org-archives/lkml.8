Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C98BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12117207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dXqlPyJ7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgE2ObF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726849AbgE2ObE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:31:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0195C03E969;
        Fri, 29 May 2020 07:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=XTnvGZJIVjNvDrfvXclleyvv4O+Zxe+kI/ZFLnMJ4Vo=; b=dXqlPyJ7K0M2v+EOauabZoPh23
        tVWzkxbadbvc5sxfKgq9dNP2PkVlctAGVdCbNFm4YIdv1Ypuidk5y+VjrB0xuSt9OL2Xitg1tkkBM
        lQOBYL7UVzL0ZRmJ7aLdV7RLJjfpZt9P+o5HF6GdkTeQ+AJADAMdQV36vcFjW48RtrlihEdkhJlxn
        8tMiIp8zn4Yn56rGB8WKlp/C1dEO2C9zWLa3WLlR0eI7xtnfwl0rZz5MnEuCwyXrv3MkpLeyBjH81
        G11c3mUPafZt+Erm1mdigcKcIcW6QviYYJUD7ck9yCRFHb+yO3EZgfUgcMySzehbJG4tJkOdCU43r
        2I0de/pg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeg2G-0000jR-00; Fri, 29 May 2020 14:31:00 +0000
Date:   Fri, 29 May 2020 07:30:59 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200529143059.GA25475@infradead.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528161416.GY1079@brightrain.aerifal.cx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 12:14:16PM -0400, Rich Felker wrote:
> It is in active use. Please do not act on such a request. I would be
> much quicker to ack things that actually need ack if I weren't CC'd on
> hundreds of random non-arch-specific changes that don't need it, but I
> understand that's how the kernel process works. If there are things
> that need ack please feel free to ping.
> 
> Note that I specifically acked and requested the sh5 removal.

But you did not actually pick it up - because of that it still isn't
in linux-next and thus most likely will miss Linux 5.8.
