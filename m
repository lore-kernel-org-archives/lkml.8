Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 120B6C3F2CD
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6022051A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 14:04:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TypOLA+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgB1OD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 09:03:59 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:38578 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725892AbgB1OD7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 09:03:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AeFlf8/3IN4nWVCE6JFON5V71Wzrs06d1BBOTko8Y5w=; b=TypOLA+sR/rR8DuzM3pJzSZvCA
        vkjJIR1hicy4VHaIr6mi2182gwb76Ojs5OPaz2Nbef+EwvGihVSymrvKwrll12sTDhGFKdKctwHfy
        hEW90GuiNYRHqfgP5m09vksHoA2FWQBEn9o7r3UZjyScMMgN1r3zm1S83tkhwgikyW+s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1j7gF9-0004Fl-1E; Fri, 28 Feb 2020 15:03:55 +0100
Date:   Fri, 28 Feb 2020 15:03:55 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     Vadym Kochan <vadym.kochan@plvision.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
        Taras Chornyi <taras.chornyi@plvision.eu>,
        Serhiy Boiko <serhiy.boiko@plvision.eu>,
        Andrii Savka <andrii.savka@plvision.eu>,
        Volodymyr Mytnyk <volodymyr.mytnyk@plvision.eu>,
        Serhiy Pshyk <serhiy.pshyk@plvision.eu>
Subject: Re: [RFC net-next 1/3] net: marvell: prestera: Add Switchdev driver
 for Prestera family ASIC device 98DX325x (AC3x)
Message-ID: <20200228140355.GF19662@lunn.ch>
References: <20200225163025.9430-1-vadym.kochan@plvision.eu>
 <20200225163025.9430-2-vadym.kochan@plvision.eu>
 <20200226155423.GC26061@nanopsycho>
 <20200227213150.GA9372@plvision.eu>
 <20200227214357.GB29979@lunn.ch>
 <20200227235048.GA21304@plvision.eu>
 <20200228063623.GI26061@nanopsycho>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228063623.GI26061@nanopsycho>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 07:36:23AM +0100, Jiri Pirko wrote:
> Fri, Feb 28, 2020 at 12:50:58AM CET, vadym.kochan@plvision.eu wrote:
> >On Thu, Feb 27, 2020 at 10:43:57PM +0100, Andrew Lunn wrote:
> >> > > Please be consistent. Make your prefixes, name, filenames the same.
> >> > > For example:
> >> > > prestera_driver_kind[] = "prestera";
> >> > > 
> >> > > Applied to the whole code.
> >> > > 
> >> > So you suggested to use prestera_ as a prefix, I dont see a problem
> >> > with that, but why not mvsw_pr_ ? So it has the vendor, device name parts
> >> > together as a key. Also it is necessary to apply prefix for the static
> >> > names ?
> >> 
> >> Although static names don't cause linker issues, you do still see them
> >> in opps stack traces, etc. It just helps track down where the symbols
> >> come from, if they all have a prefix.
> >> 
> >>      Andrew
> >
> >Sure, thanks, makes sense. But is it necessary that prefix should match
> >filenames too ? Would it be OK to use just 'mvpr_' instead of 'prestera_'
> 
> I would vote for "prestera_". It is clean, consistent, obvious.

Yes, prestera_ is better. It also avoids the vendor name, which often
changes as companies are bought, sold, split, etc.

	Andrew
