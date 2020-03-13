Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83753C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:37:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FE420746
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 10:37:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="lzQ/lS1q";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MP0TEiCh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCMKhY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 06:37:24 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:45967 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgCMKhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 06:37:23 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 239A022337;
        Fri, 13 Mar 2020 06:37:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 13 Mar 2020 06:37:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=iQRh4eWM++JNjavkQy3NxO8uOXQ
        yom1KZ3YZTJwPkxI=; b=lzQ/lS1qe7uZPnrF5YWmsnvju776pv12bynxDRMiheA
        OzN3R99YwGEqWLpTYj0ORsxhIJgdD3YFoIxNHUSgicn+EUSNe8ECGI2GFBD1457R
        2bV7EtiLfMAgMk0Cu9nMevpX6n8ZESSX7I5CBF9ZDVXmd0q/8db6+gSwN6D8WAEM
        bP+qJtyF1OG4QmVW+vP5L87UWTIlDGDcVQd0Vbd5KlaeKXXHGCbAFYPOCa8Bwg+p
        QHIovt5LDfWthmWEmNvJc7DzwhV5uW+HpWjFhq3uESNtVC7klUdIFQlHJh7UXcyV
        f4Jf2Wg2CX7DMf6/u85hAfUAYRjt8g59bRoBej5+S3g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=iQRh4e
        WM++JNjavkQy3NxO8uOXQyom1KZ3YZTJwPkxI=; b=MP0TEiCh7GrMo2MvtbLpOV
        sOkaoxgO3Dx+ZmY5EroCz8w9BZjqAIPbQ8g8T2Ol47eURkCSAbEK3xemNC10pQQg
        yFJOMTnHxqePhTM/6dKCqcXOzPCx6Gc8yHjZ009LfOvnjcd5cDIbxr/W8Giuhx+a
        ycQscjQmokbY1O+uBQYC+5CaTn5fQKIOcpGNzglEpBeHcto0a6searLilgTb60a5
        fXm72hk5Dc71o2rd8NE+uDEOHHd/RcBNSLNJ/sS6kWOajkhdEuPGz1zxeooAZDLo
        0EJc3EuQZPy+cu2WQ/0W0N7A7TuSaIC7hw/3miZLoWLW5bRYBMlNmCD1O7BbZJTA
        ==
X-ME-Sender: <xms:YmJrXqmnV7dgTQ7NExCZLT7VR-pBRj5r_cPduE69p4nnGNolPZbVBw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddvjedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefirhgvghcu
    mffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucffohhmrghinhepkhgvrhhnvghlrd
    horhhgnecukfhppeekfedrkeeirdekledruddtjeenucevlhhushhtvghrufhiiigvpedt
    necurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomh
X-ME-Proxy: <xmx:YmJrXueEXCsnkO7KMjjjngO7hpL45J6dPVQGiDgmeGRNgsHduDPKNg>
    <xmx:YmJrXvCF4BAB6uPoYt1qsQQCZbjhatVQlDWH3e3GK77nvJNJqtofOA>
    <xmx:YmJrXoc9vF6T3jf2SCSo5Mtmzo2z4_nNp7tg6PcKThQmmD82YiMUlQ>
    <xmx:Y2JrXif5p_Bo6PedF2Avo_yRN8u1Ec4FOh6bi3_aOLM9LXhILI33IA>
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 581BF328005E;
        Fri, 13 Mar 2020 06:37:22 -0400 (EDT)
Date:   Fri, 13 Mar 2020 11:37:20 +0100
From:   Greg KH <greg@kroah.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>, "Bird, Tim" <Tim.Bird@sony.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [Ksummit-discuss] [Tech-board-discuss] Linux Foundation
 Technical Advisory Board Elections -- Change to charter
Message-ID: <20200313103720.GA2215823@kroah.com>
References: <6d6dd6fa-880f-01fe-6177-281572aed703@labbott.name>
 <20200312003436.GF1639@pendragon.ideasonboard.com>
 <MWHPR13MB0895E133EC528ECF50A22100FDFD0@MWHPR13MB0895.namprd13.prod.outlook.com>
 <20200313031947.GC225435@mit.edu>
 <87d09gljhj.fsf@intel.com>
 <20200313093548.GA2089143@kroah.com>
 <24c64c56-947b-4267-33b8-49a22f719c81@suse.cz>
 <20200313100755.GA2161605@kroah.com>
 <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVSxS1R2osYJh29aKGaqMw3NkTRgqgRWuhu4euygAAXVg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 13, 2020 at 11:16:36AM +0100, Geert Uytterhoeven wrote:
> Hi Greg,
> 
> On Fri, Mar 13, 2020 at 11:08 AM Greg KH <greg@kroah.com> wrote:
> > On Fri, Mar 13, 2020 at 10:41:57AM +0100, Vlastimil Babka wrote:
> > > On 3/13/20 10:35 AM, Greg KH wrote:
> > > >> Not that I'm saying there's an easy solution, but obviously kernel.org
> > > >> account is not as problem free as you might think.
> > > >
> > > > We are not saying it is "problem free", but what really is the problem
> > > > with it?
> > >
> > > IIUC there is no problem for its current use, but it would be rather restrictive
> > > if it was used as the only criterion for being able to vote for TAB remotely.
> >
> > Given that before now, there has not be any way to vote for the TAB
> > remotely, it's less restrictive :)
> 
> But people without kernel.org accounts could still vote in person before,
> right?

Yes, and they still can today, this is expanding the pool, not
restricting it.

thanks,

greg k-h
