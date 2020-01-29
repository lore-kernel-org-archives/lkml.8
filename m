Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC9B2C35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FDF20716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580303726;
	bh=oUDmtxiN41VdcoNQ6eSO7UKsE16s05WPMjsBCDCEb+A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y7QWjJuDhVf4fUI4LevmwNHNcmpl8fruiaAkniYbV2+xtyfBxDnY2CLNZD0o8Gs/f
	 Qib4mXfluqbSN1CA6ptMX2iODAoILKT/GIzNOGXeRCqkpbJp64WEm5zGReJ2gg0/Lk
	 O8Eqq7BLIfCTx61pgzgGsyPVxPQMHQQu1pNx3BAk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbgA2NPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 08:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:60270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgA2NPZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 08:15:25 -0500
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 11B5520678;
        Wed, 29 Jan 2020 13:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580303724;
        bh=oUDmtxiN41VdcoNQ6eSO7UKsE16s05WPMjsBCDCEb+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GZnnsUEW0A0w6MrbLPgKEx4obNfVoCWr0lIzKLoOtOtFb0MHecDoEgMGYrDV+A9z8
         l+d0Y91PCdTzDQ185BFTCZaIT1DheYHBiGfgyOEOH3AWZoRMqBwYc52t9TJRvXoIEM
         ZOqcs3zU1ZNbOB7TsbMIXjv9xG2WtwRGgcIwNfrk=
Date:   Wed, 29 Jan 2020 13:15:20 +0000
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] m68k,mm: Extend table allocator for multiple sizes
Message-ID: <20200129131520.GA31774@willie-the-truck>
References: <20200129103941.304769381@infradead.org>
 <20200129104345.491163937@infradead.org>
 <20200129121752.GB31582@willie-the-truck>
 <20200129124352.GP14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129124352.GP14879@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 01:43:52PM +0100, Peter Zijlstra wrote:
> On Wed, Jan 29, 2020 at 12:17:53PM +0000, Will Deacon wrote:
> > On Wed, Jan 29, 2020 at 11:39:45AM +0100, Peter Zijlstra wrote:
> 
> > > +extern void *get_pointer_table(int type);
> > 
> > Could be prettier/obfuscated with an enum type?
> 
> Definitely, but then we get to bike-shed on names :-)

At least we don't need an emulator for *that*!

> enum m68k_table_type {
> 	TABLE_BIG = 0,
> 	TABLE_SMALL,
> };
> 
> Is not exactly _that_ much better, and while TABLE_PTE works,
> TABLE_PGD_PMD is a bit crap.

Some alternatives:

TABLE_PXD / TABLE_PTE
TABLE_BRANCH / TABLE_LEAF
TABLE_DIR / TABLE_PTE
TABLE_TI_AB / TABLE_TI_C

Will
