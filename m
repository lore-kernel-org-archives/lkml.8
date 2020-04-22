Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C18BC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B8DB20776
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="EKbyShed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbgDVPhZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbgDVPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:37:25 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F353C03C1A9;
        Wed, 22 Apr 2020 08:37:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bE8e5MOL8KYPuApPXnTyRh9KbE6QXDIZY+1QM+ElKfQ=; b=EKbyShed7Soh0+FQmm4kwP+mU
        /wcqne1ikWwaaeDZpmms4asFiWmjK5oXTzKv6HnsOKTEhOSoBaSMVoABFT0UwcHB1Fj6jPORAtJkH
        TV4RUQ6cxJkbNffM40eIpTT4JCRSwXX/bpu/u+R7wfDTwL/pmo3l//0GV4wz0AjVgelH4YktdO6Ph
        HrKvWYpVf8dlvd7Of5rRbU6kxrrDQsk9Ot0gdmZaa4GnXKtCWxqW/DntYFcp1ZXKN7NU7sENia9yi
        hepaljwpwq+1S3prLhNDOvIYseMjZfvu/mjfYueZCFNrTa50yES7XuPFU1O3rSUyQwZpvcIBNMOeX
        BeRkN2KwQ==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:42138)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jRHR6-0000cq-Db; Wed, 22 Apr 2020 16:37:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jRHR3-0008GP-1j; Wed, 22 Apr 2020 16:37:13 +0100
Date:   Wed, 22 Apr 2020 16:37:13 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Jakov Petrina <jakov.petrina@sartura.hr>, jason@lakedaemon.net,
        devicetree@vger.kernel.org, gregory.clement@bootlin.com,
        linux-kernel@vger.kernel.org, vladimir.vid@sartura.hr,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com
Subject: Re: [PATCH] arm: dts: uDPU: switch PHY operation mode to 2500base-x
Message-ID: <20200422153712.GQ25745@shell.armlinux.org.uk>
References: <20200422150915.3355073-1-jakov.petrina@sartura.hr>
 <20200422152439.GG974925@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200422152439.GG974925@lunn.ch>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 05:24:39PM +0200, Andrew Lunn wrote:
> On Wed, Apr 22, 2020 at 05:09:15PM +0200, Jakov Petrina wrote:
> > This resolves issues with certain SPF modules.
> 
> Hi Jakov
> 
> Please could you explain this some more. PHYLINK should be setting the
> mode appropriately, based on the capabilities of the SFP module. Is
> the real problem that the SFP module is indicating the wrong baud
> rate?

The issue is way more complex than that, and this is just a sticky
plaster over the problem, and I'm really unconvinced that the issue
has really been solved.

There are some GPON modules that support 2.5G and 1G, try to guess
the speed of the host somehow.  How that happens is not really
known, and I never got the impression that even Scott at Telus worked
it out - he just played around until he got stuff to work, and this
patch is the result.

This patch just works around the problem because it _may_ cause the
interface to be at 2.5G at boot, but it won't be at 2.5G after a
1G module has previously been plugged in, and one of these GPON
modules is subsequently inserted.

So, this is just a bodge that works in one particular situation for a
problem with modules playing their own games.

So, it has to be a NAK.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 10.2Mbps down 587kbps up
