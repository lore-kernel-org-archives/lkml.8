Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7833DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:58:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 435C6207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 05:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596002334;
	bh=SsccXEHP+atsCWtcbJJRudQJxd4BjTwjJ2PiKLZBTpk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lQ6Ym5IG2Dw1es66Mn2rSw/UzygLblfTlvpveJPYqlLM13yMQ13mdYgZRqSMOzGs2
	 eAHg00XINkt9Pbh5cMum2/UYJ79N9HxohvyEJeRKMr+0/Sk7712Fwmbrl5fhmzKY3y
	 M+dR953ixDG3yWDz9E0sY6T6P1SkTljts/N5zJQw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgG2F6x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 01:58:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:59014 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgG2F6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 01:58:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CC34C20809;
        Wed, 29 Jul 2020 05:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596002331;
        bh=SsccXEHP+atsCWtcbJJRudQJxd4BjTwjJ2PiKLZBTpk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CnhtG6HhCDDWPsXyb43BNmoh0xWhUnqX3fiUL+lJms0WGNQR/bc6mpHIqC/Kj5Nhb
         Cn0+plcbYM4yDMBVPFBAbDgNa5cIksOtwk5QFT/lumZ40w7ACjr2Pl4+QY9a6kHF6g
         FFgmr/WETQkpTqLC2lR3MNl9kEzUMZMle5uPKraw=
Date:   Wed, 29 Jul 2020 07:58:04 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org, Oded Gabbay <oded.gabbay@gmail.com>,
        Omer Shpigelman <oshpigelman@habana.ai>,
        Tomer Tayar <ttayar@habana.ai>,
        Moti Haimovski <mhaimovski@habana.ai>,
        Ofir Bitton <obitton@habana.ai>,
        Ben Segal <bpsegal20@gmail.com>,
        Christine Gharzuzi <cgharzuzi@habana.ai>,
        Pawel Piskorski <ppiskorski@habana.ai>
Subject: Re: [PATCH] habanalabs: fix up absolute include instructions
Message-ID: <20200729055804.GA438924@kroah.com>
References: <20200728171851.55842-1-gregkh@linuxfoundation.org>
 <20200729080938.29fc5ef8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729080938.29fc5ef8@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 29, 2020 at 08:09:38AM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Tue, 28 Jul 2020 19:18:51 +0200 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >
> > diff --git a/drivers/misc/habanalabs/common/Makefile b/drivers/misc/habanalabs/common/Makefile
> > index 97d03b5c8683..b984bfa4face 100644
> > --- a/drivers/misc/habanalabs/common/Makefile
> > +++ b/drivers/misc/habanalabs/common/Makefile
> > @@ -1,6 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0-only
> > -subdir-ccflags-y += -I$(src)/common
> 
> I've seen oter places use
> 
> subdir-ccflags-y += -I$(srcdir)/$(src)/common
> 
> which would probably work as well.  i.e. just change this in the
> Makefiles rather than every source file.

I hate seeing odd ccflags stuff in Makefiles as it can catch you "by
surprise" as to what exactly is happening when looking at .c code.

But yes, your change would also work.

thanks,

greg k-h
