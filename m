Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C589C2BB54
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C89B2054F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 00:09:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="z9hdFoPy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbgDHAJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 20:09:56 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:53818 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbgDHAJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 20:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=AYxIzcriYqOq9OLej1S4GUEYatAw7MytodFh1SBwJUU=; b=z9hdFoPyr9u/KkzOOwGU2qKKEW
        SU2VWAZUGcAFFkoTpwwRiIgVBG6BLDcbBefWtFyN2pVpO8ZhgmyE44bBEeh8/9SyGkaunVLowBHnN
        zsJJtMjQfkYylr26SX2Xnw9f7KV3IiqJL33GzmwYVtee9oEZHtHeHpX70g/nqjJHtdno=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.93)
        (envelope-from <andrew@lunn.ch>)
        id 1jLyHv-001XmL-3D; Wed, 08 Apr 2020 02:09:51 +0200
Date:   Wed, 8 Apr 2020 02:09:51 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Paul Spooren <mail@aparcar.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        jason@lakedaemon.net, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, daniel@makrotopia.org,
        freifunk@adrianschmutzler.de, kaloz@openwrt.org
Subject: Re: [PATCH 0/5] arm: dts: linksys: rename codename to model
Message-ID: <20200408000951.GE310042@lunn.ch>
References: <20200407210816.866084-1-mail@aparcar.org>
 <20200407224615.GA359603@lunn.ch>
 <004a2ef9c1e04f9ffbb9c3cc9907ca656a406713.camel@aparcar.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <004a2ef9c1e04f9ffbb9c3cc9907ca656a406713.camel@aparcar.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 01:38:17PM -1000, Paul Spooren wrote:
> Hi Andrew,
> 
> thank you very much for the quick response!
> Are you okay with adding the new compatible string as first element of
> the list? This would already simplify the OpenWrt build system.

That should be fine. OF will keep searching from first till last for a
match. 

> What about the changed labels? Are they considered ABI too?

You mean LED names. I would consider those ABI. People can have
scripts which configure the LEDs how they want, blinking heartbeat,
etc.

> Regarding file names, I'm new to ABI policies. Within OpenWrt this is
> all done via a single line patch, I'm not familiar with any other
> installers/bootloaders. 

Well, it would break how i boot my wrt1900ac. I tftpboot it, grabbing
both the kernel and the DB blob from my TFTP server. If the blob
changes names, i would need to modify my uboot configuration. 

I don't know if Debian has full support for any of these boards, but
if i remember correctly, flash-kernel has a database of machine names
and DTB file names. My wrt1900ac is quite happy running Debian, but i
don't have it booting the Debian way, because i use it for kernel
hacking. But maybe there are people out there that do.

	 Andrew
