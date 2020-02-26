Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF222C4BA0D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B460021927
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 04:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FIZTPvRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgBZEGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 23:06:18 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:52042 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgBZEGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 23:06:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Qu2aPURbegdzfjSgtAkPb+TbG3uomn1JGpoqTQmr/0g=; b=FIZTPvRn3595XVQory0Jhecsta
        7XjC4muiAu+9tLTT/ALg6Wttpv6fpY+HJQLq4Y7fPKXszStHmceKhxiLlF1bAsyYbTkoxvhVa2khJ
        9fjlkcmhi2t2MCy94H98F65UBVbwCWVYf771eZCuA6YrXgSl6j4GB5amo8hdAFdl1BBwd1gHUb+yY
        u2uQJm3Rx3cxA5GHwL120ApkFqoadtRq0F6StjPiuJNO6aHI5WyUtnsP+xpSPRGBIzXbEKsHHj3Ss
        8KFa64/bKLds0lA1SsVnuQb2afuoHhuDBWIBtIBf4c5G7gGkMxWRQ1rhktcynjjdGFkqFFY5MS1Ro
        sLtvsvsA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j6nxc-0007Kc-S7; Wed, 26 Feb 2020 04:06:12 +0000
Date:   Tue, 25 Feb 2020 20:06:12 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     akpm@linux-foundation.org, elver@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/vmscan: fix data races at kswapd_classzone_idx
Message-ID: <20200226040612.GW24185@bombadil.infradead.org>
References: <20200226035827.1285-1-cai@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200226035827.1285-1-cai@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 25, 2020 at 10:58:27PM -0500, Qian Cai wrote:
> pgdat->kswapd_classzone_idx could be accessed concurrently in
> wakeup_kswapd(). Plain writes and reads without any lock protection
> result in data races. Fix them by adding a pair of READ|WRITE_ONCE() as
> well as saving a branch (compilers might well optimize the original code
> in an unintentional way anyway). While at it, also take care of
> pgdat->kswapd_order and non-kswapd threads in allow_direct_reclaim().

I don't understand why the usages of kswapd_classzone_idx in kswapd() and
kswapd_try_to_sleep() don't need changing too?  kswapd_classzone_idx()
looks safe to me, but I'm prone to missing stupid things that compilers
are allowed to do.
