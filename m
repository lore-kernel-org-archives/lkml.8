Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF8EA20890
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 10:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="kB+9tCEz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgGDKBU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 06:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbgGDKBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 06:01:19 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E760C061794;
        Sat,  4 Jul 2020 03:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1dt5GpWobPCWxADEO0CCn+J6WsbVv3IjpAPTzTvLYEY=; b=kB+9tCEzCM3n0z7SVN280nAhW
        EETrCJxjW1UJeb/mz1L93LQEBrd4JXv0kpEDG4e0yGMTK9soaNXghV0DptH0M/IBGlGmSCQTuaWL5
        WYXc1FS5ZBcAeTSzmsrjd9zRBdvB/fBpLZorkQQGUIU4qtwy8R4Z7XkucAzZ6IRrdKyC/In3yE5tr
        +Kgixwhb8iIg2iUfk1VDwzyDTEdeSyAfvpASyCw+atVLM3ZD6aTaeg/bP5iVOK9R3nuv6GMD+XTTo
        wfhuuT0uvISJ4fzEQcVS78rM105qBEOU+YL+7zyOdvl85LG5pp2d+rnelNeDCzjLujtN3bg7zwUzR
        3VPretJFw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35158)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jreyn-0004Yk-Nm; Sat, 04 Jul 2020 11:01:05 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jreyg-0003mR-WA; Sat, 04 Jul 2020 11:00:59 +0100
Date:   Sat, 4 Jul 2020 11:00:58 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Michael Walle <michael@walle.cc>, netdev <netdev@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: Re: [PATCH RESEND net-next v3 0/3] net: enetc: remove bootloader
 dependency
Message-ID: <20200704100058.GQ1551@shell.armlinux.org.uk>
References: <20200701213433.9217-1-michael@walle.cc>
 <20200701215310.GL1551@shell.armlinux.org.uk>
 <CA+h21hotHbN1xpZcnTMftXesgz7T6sEGCCPzFKdtG1NfMxguLg@mail.gmail.com>
 <20200702084128.GM1551@shell.armlinux.org.uk>
 <CA+h21hoD0HTtpeGtEFyALg-5b7Gs0qJycukgzhQOGy+xHra23A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+h21hoD0HTtpeGtEFyALg-5b7Gs0qJycukgzhQOGy+xHra23A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 02, 2020 at 12:41:39PM +0300, Vladimir Oltean wrote:
> On Thu, 2 Jul 2020 at 11:41, Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Thu, Jul 02, 2020 at 01:04:02AM +0300, Vladimir Oltean wrote:
> > > On Thu, 2 Jul 2020 at 00:53, Russell King - ARM Linux admin
> > > <linux@armlinux.org.uk> wrote:
> > > >
> > > > fixing up almost every driver the best I can with the exception of two -
> > > > felix DSA and Mediatek.
> > > >
> > > > I'm not going to wait for Felix or Mediatek.  As I say, I've given
> > > > plenty of warning, and it's only a _suspicion_ of breakage on my
> > > > side.
> > > >
> > >
> > > What do you mean "I'm not going to wait for Felix"?
> > > https://patchwork.ozlabs.org/project/netdev/patch/20200625152331.3784018-5-olteanv@gmail.com/
> > > We left it at:
> > >
> > > > I'm not going to review patch 7
> > > > tonight because of this fiasco.  To pissed off to do a decent job, so
> > > > you're just going to have to wait.
> > >
> > > So, I was actively waiting for you to review it ever since, just like
> > > you said, so I could send a v2. Were you waiting for anything?
> >
> > I stopped being interested in your series with the patch 5 commit
> > description issue; what happened there is really demotivating.
> >
> > --
> > RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
> > FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
> 
> Yes, but I mean, the fact that reviewing felix is "demotivating" can
> only have 2 courses of action as far as I can see:

Sigh. I give up with you.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
