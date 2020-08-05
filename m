Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F04C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CD6622CAE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 23:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726695AbgHEXHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 19:07:21 -0400
Received: from smtprelay0164.hostedemail.com ([216.40.44.164]:33822 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726542AbgHEXHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 19:07:10 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 8FA8418224D8E;
        Wed,  5 Aug 2020 23:07:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: guide34_2308aad26fb2
X-Filterd-Recvd-Size: 3797
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Wed,  5 Aug 2020 23:07:05 +0000 (UTC)
Message-ID: <8a091297aef4ebb44a65ab1c683caae006acf76a.camel@perches.com>
Subject: Re: [PATCH] MAINTAINERS: update phylink/sfp keyword matching
From:   Joe Perches <joe@perches.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Date:   Wed, 05 Aug 2020 16:07:04 -0700
In-Reply-To: <20200805220917.GZ1551@shell.armlinux.org.uk>
References: <E1k3KUx-0000da-In@rmk-PC.armlinux.org.uk>
         <CAHk-=whbLwN9GEVVt=7eYhPYk0t0Wh1xeuNEDD+xmQxBFjAQJA@mail.gmail.com>
         <20200805182250.GX1551@shell.armlinux.org.uk>
         <957f48692a2f0bc4df2d83068073c4822da30eef.camel@perches.com>
         <20200805220917.GZ1551@shell.armlinux.org.uk>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-08-05 at 23:09 +0100, Russell King - ARM Linux admin wrote:
> On Wed, Aug 05, 2020 at 11:47:38AM -0700, Joe Perches wrote:
> > On Wed, 2020-08-05 at 19:22 +0100, Russell King - ARM Linux admin wrote:
> > > On Wed, Aug 05, 2020 at 11:11:28AM -0700, Linus Torvalds wrote:
> > > > On Wed, Aug 5, 2020 at 7:34 AM Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > > > > Is this something you're willing to merge directly please?
> > > > 
> > > > Done.
> > > > 
> > > > That said:
> > > > 
> > > > > -K:     phylink
> > > > > +K:     phylink\.h|struct\s+phylink|\.phylink|>phylink_|phylink_(autoneg|clear|connect|create|destroy|disconnect|ethtool|helper|mac|mii|of|set|start|stop|test|validate)
> > > > 
> > > > That's a very awkward pattern. I wonder if there could be better ways
> > > > to express this (ie "only apply this pattern to these files" kind of
> > > > thing)
> > > 
> > > Yes, it's extremely awkward - I spent much of the morning with perl
> > > testing it out on the drivers/ subtree.
> > 
> > There are a lot of phylink_<foo> in the kernel.
> > Are those really the only uses you want to watch?
> 
> It is sufficient; as I said, I've spent a morning running this:

Cool for you, I was just asking.

How you determine what functions you're interested in
is up to you.

Another mechanism might have been something like:

$ git grep -Poh '(?:static\s+inline|EXPORT_SYMBOL).*phylink_[a-z]+' | \ 
  grep -Poh 'phylink_[a-z]+' | sort | uniq

Maybe something that could be made generic in get_maintainer
for people maintaining specific EXPORT_SYMBOL(foo) blocks.

Maybe another letter/look could be added to MAINTAINERS like:

E:	symbol_regex

as another similar mechanism for keywords but just for data
or functions marked as exported symbols.

For example, that E: might help minimize xdp matches as xdp
is used by many other bits of code that aren't express data
path uses.

MAINTAINERS-XDP (eXpress Data Path)
MAINTAINERS-M:  Alexei Starovoitov <ast@kernel.org>
MAINTAINERS-M:  Daniel Borkmann <daniel@iogearbox.net>
MAINTAINERS-M:  David S. Miller <davem@davemloft.net>
MAINTAINERS-M:  Jakub Kicinski <kuba@kernel.org>
MAINTAINERS-M:  Jesper Dangaard Brouer <hawk@kernel.org>
MAINTAINERS-M:  John Fastabend <john.fastabend@gmail.com>
MAINTAINERS-L:  netdev@vger.kernel.org
MAINTAINERS-L:  bpf@vger.kernel.org
MAINTAINERS-S:  Supported
MAINTAINERS-F:  include/net/xdp.h
MAINTAINERS-F:  include/trace/events/xdp.h
MAINTAINERS-F:  kernel/bpf/cpumap.c
MAINTAINERS-F:  kernel/bpf/devmap.c
MAINTAINERS-F:  net/core/xdp.c
MAINTAINERS-N:  xdp
MAINTAINERS:K:  xdp


