Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46ECC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B7F820823
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 14:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CxF+nmcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391140AbgFXOKV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 10:10:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388395AbgFXOKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 10:10:20 -0400
Received: from casper.infradead.org (unknown [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C608C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 07:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xWSo4TF1CxXuck4PIgUP0X+nO2qjx3mneKPxBCTjU4s=; b=CxF+nmcE0nAA0hoDXhyeN84AFC
        NfE69tggSN3TOYQLVfUmpk1LRlLWyvjHPmn+SvWmk8K1+WM01pBJTRC4SAexpUs4Af+qZoKE6zzQp
        XyGWMG/XFq2iTfgD6dEOsvIXzWkpSSoFcHKxVsSrkFxw3WCIo6EINWjM03+c0a/720vR54hMpBsdA
        2/FvXYNHPiJY32K1sBRFj/pRs3tUn7xGIFEYU9pcsc1V42ibXoCQEsrmQVB/I9CMU8/HyXJpt8VcR
        Ku5GkoqhZuyln9eMFmM6Ru4de8SCzpipZp5O7meVJOEcVeRRfwrIJNvgloTvMEP2azzdEjwWOFDAF
        aTCbnAtg==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jo66A-0008Pa-Ce; Wed, 24 Jun 2020 14:09:58 +0000
Date:   Wed, 24 Jun 2020 15:09:58 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Rafael Aquini <aquini@redhat.com>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Subject: Re: [PATCH] mm/page_alloc: fix documentation error and remove magic
 numbers
Message-ID: <20200624140958.GN21350@casper.infradead.org>
References: <20200624032712.23263-1-jsavitz@redhat.com>
 <20200624111255.GL21350@casper.infradead.org>
 <20200624140727.GA1987277@optiplex-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200624140727.GA1987277@optiplex-lnx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 10:07:27AM -0400, Rafael Aquini wrote:
> On Wed, Jun 24, 2020 at 12:12:55PM +0100, Matthew Wilcox wrote:
> > On Tue, Jun 23, 2020 at 11:27:12PM -0400, Joel Savitz wrote:
> > > In addition, this patch replaces the magic number bounds with symbolic
> > > constants to clarify the logic.
> > 
> > Why do people think this kind of thing makes the code easier to read?
> > It actually makes it harder.  Unless the constants are used in more
> > than one place, just leave the numbers where they are.
> > 
> > > @@ -7852,6 +7852,9 @@ void setup_per_zone_wmarks(void)
> > >   * 8192MB:	11584k
> > >   * 16384MB:	16384k
> > >   */
> > > +static const int MIN_FREE_KBYTES_LOWER_BOUND = 1 << 7;
> > > +static const int MIN_FREE_KBYTES_UPPER_BOUND = 1 << 18;
> > > +
> 
> I think these constants would look better if declared as an enum.

Why does having to look in two different places make the code clearer?

