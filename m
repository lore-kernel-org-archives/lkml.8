Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773C5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AFE12074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 18:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KE1++9js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727803AbgE2SWX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 14:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgE2SWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 14:22:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25ED4C03E969;
        Fri, 29 May 2020 11:22:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=j3NOsvrWwgJPkw8Rv2MNHAvv37lCnsGUDsPfCkBL3Is=; b=KE1++9jsGhMrk7yZ789AqqEqmK
        2HZ/zWCHtvAyg5VByvKl9MgCZCElydm1euCzUJC2T2K8n1fnqLL37vssuEAIfNIQ/r2Me3gmh+Vyw
        +uyzf/8OzGVBeCBwdKZjqshSnADl7pQ9hzRbIJqSfgjDoyI/8bFgg/L0GfMf9gA3snxwhbPSE44+/
        Yw08gDWYOX4xirp6mSL5U19hjTc1FPubtZ8RX4AxDd7+FfcIK1pMv7sAA8weYbv+cAh1sqi34NCi+
        KJ/aeB8yfye0daTam0tYZdFJfOB9dd33DaD2fAPNG8XPNa33apmCruekaEiXs0SrOIGm+GDiUxXZj
        7hwHnFuQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jeje5-0003Gs-LB; Fri, 29 May 2020 18:22:17 +0000
Date:   Fri, 29 May 2020 11:22:17 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200529182217.GA11203@infradead.org>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200529143059.GA25475@infradead.org>
 <20200529175335.GK1079@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529175335.GK1079@brightrain.aerifal.cx>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 01:53:38PM -0400, Rich Felker wrote:
> Frustratingly, I _still_ don't have an official tree on kernel.org for
> the purpose of being the canonical place for linux-next to pull from,
> due to policies around pgp keys and nobody following up on signing
> mine. This is all really silly since there are ridiculously many
> independent channels I could cryptographically validate identity
> through with vanishing probability that they're all compromised. For
> the time being I'll reactivate my repo on git.musl-libc.org.

You don't need a kernel.org tree.  None of the trees I maintain are
hosted on kernel.org.  Just make sure you sign your tags.
