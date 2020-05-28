Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E16C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2991A206F1
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 22:37:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437215AbgE1Wh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 18:37:28 -0400
Received: from brightrain.aerifal.cx ([216.12.86.13]:35786 "EHLO
        brightrain.aerifal.cx" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436945AbgE1WhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 18:37:25 -0400
Date:   Thu, 28 May 2020 18:37:23 -0400
From:   Rich Felker <dalias@libc.org>
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org,
        ysato@users.sourceforge.jp, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, Rob Landley <rob@landley.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] sh: remove sh5 support
Message-ID: <20200528223723.GJ1079@brightrain.aerifal.cx>
References: <20200424221948.1120587-1-arnd@arndb.de>
 <20200507143552.GA28683@infradead.org>
 <20200528054600.GA29717@infradead.org>
 <20200528161416.GY1079@brightrain.aerifal.cx>
 <20200528221450.GF1079@brightrain.aerifal.cx>
 <a2fd7d94-2610-476a-a06a-5a058956db56@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2fd7d94-2610-476a-a06a-5a058956db56@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:32:07AM +0200, John Paul Adrian Glaubitz wrote:
> Hello Rich!
> 
> On 5/29/20 12:14 AM, Rich Felker wrote:
> > To follow up, I see that there was a patch series of yours (3/24) I
> > missed ack'ing fairly recently. At first glance it looks good. It
> > happened to arrive while I was getting over being horribly sick with
> > what I thought was covid19. If there's further action needed on it
> > I'll address it asap now that I'm aware of it.
> 
> Glad to hear from you again! I hope you have fully recovered!

Yes, but it took a good while to get fully better, and according to
tests it wasn't even covid19. Certainly shaped my view on taking the
pandemic seriously at an appropriate time, though!

> > In general, most of the patches I see are things that the linux-sh
> > list and myself end up cc'd on that are only tangentially related to
> > arch/sh or even not related at all. In that case I normally trust
> > other maintainers familiar with the cross-arch changes being made that
> > the small arch/sh part of the change is ok if the broader change is
> > abstractly ok.
> > 
> > Part of why I really disliked the "just kill it all" response to this
> > thread is that the sh5 removal is specifically for the sake of making
> > the arch more maintainable. That, along with forward-porting Sato's
> > SH4 device tree patches (I've tried this but ran into problems, and
> > need some help with it), has long been on my agenda for the arch, to
> > reduce (and ultimately eliminate) the amount of legacy "only on
> > arch/sh" stuff left so that it's not a burden on other maintainers and
> > contributors. Seeing sentiment along the lines of "why don't you just
> > remove it all while you're at it?" as a response is disheartening and
> > also dismissive of Arnd's work making the sh5 removal happen.
> 
> I agree. I have also poured endless hours into Debian's sh4 port fixing
> dozens of bugs myself and reporting them upstream whenever I couldn't
> fix them myself.
> 
> I would also like to add that getting device tree support into SH would
> be a huge leap forward and I would be happy to help with the efforts. I
> still have some LANDISK and NextVoD devices available if anyone needs
> hardware for testing and development, FWIW.

And I still have the NextVoD and LANDISK. The NextVoD is ST-based, so
not supported at all by upstream kernel, only the abandoned stlinux.
I've long wanted to pull support for ST hardware back into mainline,
and I think DT makes this viable rather than just a huge new mess on
top of undermaintained code, but it'll need help to make it happen.

> Would be great to also hear back from Sato-san, he is still active
> on his other Linux trees [1].

Yes.

> > Aside from that, the open source & open hardware J-core models are
> > still active and in development, with the latest release having been
> > made this month, and the J32 with MMU nearly complete and pending
> > release, contingent mostly on integration and testing with Linux.
> 
> And I'm still very much looking forward to these. I will certainly
> buy a bunch of J32 to use them as buildds for Debian's sh4 port!

Great!

Rich
