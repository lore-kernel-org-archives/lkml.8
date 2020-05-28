Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C648C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E1F32177B
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 16:14:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404890AbgE1QOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 12:14:19 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:35674 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404861AbgE1QOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 12:14:18 -0400
Date:   Thu, 28 May 2020 12:14:16 -0400
From:   Rich Felker <dalias@libc.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200528161416.GY1079@brightrain.aerifal.cx>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528054600.GA29717@infradead.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 10:46:00PM -0700, Christoph Hellwig wrote:
> [adding Linus]
> 
> On Thu, May 07, 2020 at 07:35:52AM -0700, Christoph Hellwig wrote:
> > Any progress on this?  I plan to resend the sh dma-mapping I've been
> > trying to get upstream for a year again, and they would conflict,
> > so I could look into rebasing them first.
> 
> So for years now it has been close to and in the end impossible to
> provoke sh maintainer action.  At the same point hardware is pretty much
> long gone for the real commercial variants, and never took off for the
> open hardware nommu variant.
> 
> Linus, would you ok with a 5.8 pull request to just kill off arch/sh/?

It is in active use. Please do not act on such a request. I would be
much quicker to ack things that actually need ack if I weren't CC'd on
hundreds of random non-arch-specific changes that don't need it, but I
understand that's how the kernel process works. If there are things
that need ack please feel free to ping.

Note that I specifically acked and requested the sh5 removal.

Rich
