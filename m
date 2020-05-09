Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6D72C38A2A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85982192A
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 02:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588989845;
	bh=lW4Von6DNZWwTFaN/A6L+lg+zzWvz95nYwHXT4Yr9Qc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=VIyTCJCn52shAuP+APtZfDDzblrgIojNc5kicmC9RbRbMdH7y+jIKJw7hiBfp1YR6
	 VHR5b1/IIAQdCZBHmi3iCW1t0imvsSe8a30B+I3QVRM6NSwZfOgDtajXGrCCEvGyFH
	 49VM2EtaU0EELwcHFIH7OOWQs4sg+rl/Kpnvnbc4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgEICEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 22:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:59228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727828AbgEICEE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 22:04:04 -0400
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (unknown [163.114.132.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 00BC3218AC;
        Sat,  9 May 2020 02:04:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588989844;
        bh=lW4Von6DNZWwTFaN/A6L+lg+zzWvz95nYwHXT4Yr9Qc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RcyysLvHtEZmwWe/PEMeFE5nx4el5G39hmmioqZ3Cpx97HXCushV+5mGooROYyDEc
         nc1Z+Cyy9RP0vXW0wKM07F8Fv0o6CFHUg6+c0CQsHjvHW5Hz8Dc27deRmgnOpyibgO
         Q/wGuz2m4C7ycXOB2C9RCM5oVNQVkR7USv+Xg/hE=
Date:   Fri, 8 May 2020 19:04:02 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net/sonic: Fix some resource leaks in error handling
 paths
Message-ID: <20200508190402.76018e90@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <alpine.LNX.2.22.394.2005091143590.8@nippy.intranet>
References: <20200508172557.218132-1-christophe.jaillet@wanadoo.fr>
        <20200508175701.4eee970d@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
        <alpine.LNX.2.22.394.2005091143590.8@nippy.intranet>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 11:57:44 +1000 (AEST) Finn Thain wrote:
> On Fri, 8 May 2020, Jakub Kicinski wrote:
> > On Fri,  8 May 2020 19:25:57 +0200 Christophe JAILLET wrote:  
> > > Only macsonic has been compile tested. I don't have the needed setup to
> > > compile xtsonic  
> > 
> > Well, we gotta do that before we apply the patch :S
> >   
> 
> I've compiled xtsonic.c with this patch.
> 
> > Does the driver actually depend on some platform stuff,  
> 
> xtsonic.c looks portable enough but it has some asm includes that I 
> haven't looked at. It is really a question for the arch maintainers.

I see.

> >  or can we do this:
> > 
> > diff --git a/drivers/net/ethernet/natsemi/Kconfig b/drivers/net/ethernet/natsemi/Kconfig
> > @@ -58,7 +58,7 @@ config NS83820
> >  
> >  config XTENSA_XT2000_SONIC
> >         tristate "Xtensa XT2000 onboard SONIC Ethernet support"
> > -       depends on XTENSA_PLATFORM_XT2000
> > +       depends on XTENSA_PLATFORM_XT2000 || COMPILE_TEST
> >         ---help---
> >           This is the driver for the onboard card of the Xtensa XT2000 board.
> >  
> > ?
> >   
> 
> That's effectively what I did to compile test xtsonic.c (I removed the 
> line to get the same effect).

Thank you, that should do!
