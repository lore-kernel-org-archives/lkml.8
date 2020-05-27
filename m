Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E17EFC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11F6207CB
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 13:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388342AbgE0NeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 09:34:10 -0400
Received: from elvis.franken.de ([193.175.24.41]:41218 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387901AbgE0NeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 09:34:10 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1jdwC8-0001yv-00; Wed, 27 May 2020 15:34:08 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 88D52C059B; Wed, 27 May 2020 15:33:56 +0200 (CEST)
Date:   Wed, 27 May 2020 15:33:56 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Fangrui Song <maskray@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] MIPS: Move kernel head into a standalone section
Message-ID: <20200527133356.GA16622@alpha.franken.de>
References: <20200527063438.391949-1-jiaxun.yang@flygoat.com>
 <20200527063438.391949-3-jiaxun.yang@flygoat.com>
 <20200527115354.GC13965@alpha.franken.de>
 <20200527200522.23c4e86f@halation.net.flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527200522.23c4e86f@halation.net.flygoat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 27, 2020 at 08:05:22PM +0800, Jiaxun Yang wrote:
> On Wed, 27 May 2020 13:53:54 +0200
> Thomas Bogendoerfer <tsbogend@alpha.franken.de> wrote:
> 
> > On Wed, May 27, 2020 at 02:34:33PM +0800, Jiaxun Yang wrote:
> > > That's what already done by Arm64 and other architectures.
> > > That would allow us put more things like PE headers safely into
> > > the header.
> > > 
> > > Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> > > ---
> > >  arch/mips/kernel/head.S        | 4 ++--
> > >  arch/mips/kernel/vmlinux.lds.S | 8 ++++++--
> > >  2 files changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
> > > index c7c2795837e7..8081a905a71c 100644
> > > --- a/arch/mips/kernel/head.S
> > > +++ b/arch/mips/kernel/head.S
> > > @@ -59,6 +59,8 @@
> > >  #endif
> > >  	.endm
> > >  
> > > +	__HEAD
> > > +_head:
> > >  #ifndef CONFIG_NO_EXCEPT_FILL
> > >  	/*
> > >  	 * Reserved space for exception handlers.  
> > 
> > I'm adding the missing piece, why this change ist broken:
> > 
> >          * Necessary for machines which link their kernels at KSEG0.
> > 
> > by putting something in front of that will probably break platforms
> > making use of "feature". If we can make sure, we don't need it
> > anymore, we should first remove this and then add __HEAD part.
> 
> __HEAD is just marking the section of code.
> It will not add anything to the binary.

oops, should have looked it up first. You mentioned PE headers and
I thought it will be added this way.

> Btw: I just noticed this patch may break relocatable kernel. I'll delay
> it for next merge window.

ok.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
