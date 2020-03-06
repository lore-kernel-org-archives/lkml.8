Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD5CC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA4F20848
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 11:14:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCFLOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 06:14:30 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44357 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726887AbgCFLO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 06:14:29 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1jAAvv-0007qh-Fv; Fri, 06 Mar 2020 12:14:23 +0100
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
To:     Philippe Schenker <philippe.schenker@toradex.com>,
        "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
        "andrew@lunn.ch" <andrew@lunn.ch>
Cc:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "allison@lohutok.net" <allison@lohutok.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
 <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
 <20200305165145.GA25183@lunn.ch>
 <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
 <4e48d56f184ed56d15d2ae6706fdb29e4c849132.camel@toradex.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <f47a46b9-6d6a-e257-4309-7e49852bc88e@pengutronix.de>
Date:   Fri, 6 Mar 2020 12:14:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <4e48d56f184ed56d15d2ae6706fdb29e4c849132.camel@toradex.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Philippe,

On 3/6/20 10:46 AM, Philippe Schenker wrote:
> Hi Andrew and Ahmad, thanks for your comments. I totally forgot about
> those more specific phy-modes. But just because none of our driver
> supports that. Either the i.MX6 fec-driver as well as the micrel.c PHY
> driver supports this tags.
> What do you guys suggest then how I should implement that skew stuff?

I think implementing them in the Micrel driver would make sense.
When more specific skews are supplied, these are used.
If not, the rgmii_[tx]?id applies the appropriate timings for length matched
lines. Device trees matching your use case will then only have to specify
rgmii-txid. 

> The problem is that i.MX6 has an asynchronic skew of -100 to 900ps only
> enabling the PHY-delay on TXC and RXC is not in all cases within the
> RGMII timing specs. That's why I implemented this 'weird' numbers.

I am not too well-versed with this. What's an asynchronic skew?
A non-deterministic internal delay..? So, you try to be as accurate as
possible, so the skew is within the acceptable margin?

Cheers
Ahmad


> 
> Philippe
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
