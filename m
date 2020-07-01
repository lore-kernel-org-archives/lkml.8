Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C02C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:18:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A491320809
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 15:18:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbgGAPSz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 11:18:55 -0400
Received: from gentwo.org ([3.19.106.255]:55976 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731765AbgGAPSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 11:18:54 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id ACE303F059; Wed,  1 Jul 2020 15:18:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id AAD543F057;
        Wed,  1 Jul 2020 15:18:53 +0000 (UTC)
Date:   Wed, 1 Jul 2020 15:18:53 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Matthew Wilcox <willy@infradead.org>
cc:     Long Li <lonuxli.64@gmail.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] mm:free unused pages in kmalloc_order
In-Reply-To: <20200629145259.GD25523@casper.infradead.org>
Message-ID: <alpine.DEB.2.22.394.2007011516540.54754@www.lameter.com>
References: <20200627045507.GA57675@lilong> <alpine.DEB.2.22.394.2006291446560.27163@www.lameter.com> <20200629145259.GD25523@casper.infradead.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020, Matthew Wilcox wrote:

> Sounds like we need a test somewhere that checks this behaviour.
>
> > In order to make such allocations possible one would have to create yet
> > another kmalloc array for high memory.
>
> Not for this case because it goes straight to kmalloc_order().  What does
> make this particular case impossible is that we can't kmap() a compound
> page.  We could vmap it, but why are we bothering?

Well yes it will work if the slab allocator falls back to the page
allocator.  Higher order allocation through kmalloc ;-). How much fun
and uselessness ....

Why not call the page allocator directly and play with all the bits you
want? Any regular small object allocation with GFP_HIGH will lead to
strange effects if the bit is not checked.

