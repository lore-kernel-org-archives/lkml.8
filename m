Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A65C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D29E820709
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 03:20:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgGUDUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 23:20:21 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:34588 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbgGUDUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 23:20:21 -0400
Date:   Mon, 20 Jul 2020 23:20:20 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
Message-ID: <20200721032019.GP14669@brightrain.aerifal.cx>
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
 <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
 <20200720133800.GA3084@lst.de>
 <661f7d56-bffc-f688-54e3-291cd5e7e18d@physik.fu-berlin.de>
 <20200720145325.GK14669@brightrain.aerifal.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200720145325.GK14669@brightrain.aerifal.cx>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 10:53:26AM -0400, Rich Felker wrote:
> On Mon, Jul 20, 2020 at 03:42:38PM +0200, John Paul Adrian Glaubitz wrote:
> > Hi Christoph!
> > 
> > On 7/20/20 3:38 PM, Christoph Hellwig wrote:
> > > On Wed, Jul 15, 2020 at 01:12:33AM +0200, John Paul Adrian Glaubitz wrote:
> > >> Hello!
> > >>
> > >> I have applied Christoph's full series on top of Linus' tree and I can confirm that
> > >> the kernel boots fine on my SH-7785LCR board.
> > >>
> > >> Thus, for the whole series of patches:
> > >>
> > >> Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> > > 
> > > Any chance we get the patches queue up while you're all sorting out
> > > totally independent issues?
> > 
> > I would love to buy only Rich can do that. I'm fine with your patches
> > and would much appreciate if Rich could queue them up.
> > 
> > I'm also still waiting for my patch to be queued as well.
> 
> I saw it looked like this is solved and I'm going to look at it later
> today. Thanks!

I read and replied to this from my phone this morning so I was
mistaken about the context in the above reply, but I've now queued
(push still pending after some cleanup of sequence and testing)
everything I can take from this series for linux-next. Some of the
patches seem to depend on work in other maintainers' domains that need
clarification.

Rich
