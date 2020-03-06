Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CFEC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:43:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D64217F4
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 07:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726026AbgCFHnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 02:43:01 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:55591 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725853AbgCFHnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 02:43:01 -0500
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1jA7dC-0000a2-UJ; Fri, 06 Mar 2020 08:42:50 +0100
Subject: Re: [PATCH] ARM: mach-imx6q: add ksz9131rn_phy_fixup
To:     Andrew Lunn <andrew@lunn.ch>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Kate Stewart <kstewart@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Allison Randal <allison@lohutok.net>,
        linux-arm-kernel@lists.infradead.org
References: <20200305134928.19775-1-philippe.schenker@toradex.com>
 <20200305143805.dk7fndblnqjnwxu6@pengutronix.de>
 <20200305165145.GA25183@lunn.ch>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <7191ffe6-642a-477c-ec37-e37dc9be4bf8@pengutronix.de>
Date:   Fri, 6 Mar 2020 08:42:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305165145.GA25183@lunn.ch>
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

Hello Andrew,

On 3/5/20 5:51 PM, Andrew Lunn wrote:
> On Thu, Mar 05, 2020 at 03:38:05PM +0100, Oleksij Rempel wrote:
>> Hi Philippe,
>>
>> On Thu, Mar 05, 2020 at 02:49:28PM +0100, Philippe Schenker wrote:
>>> The MAC of the i.MX6 SoC is compliant with RGMII v1.3. The KSZ9131 PHY
>>> is like KSZ9031 adhering to RGMII v2.0 specification. This means the
>>> MAC should provide a delay to the TXC line. Because the i.MX6 MAC does
>>> not provide this delay this has to be done in the PHY.
>>>
>>> This patch adds by default ~1.6ns delay to the TXC line. This should
>>> be good for all boards that have the RGMII signals routed with the
>>> same length.
>>>
>>> The KSZ9131 has relatively high tolerances on skew registers from
>>> MMD 2.4 to MMD 2.8. Therefore the new DLL-based delay of 2ns is used
>>> and then as little as possibly subtracted from that so we get more
>>> accurate delay. This is actually needed because the i.MX6 SoC has
>>> an asynchron skew on TXC from -100ps to 900ps, to get all RGMII
>>> values within spec.
>>
>> This configuration has nothing to do in mach-imx/* It belongs to the
>> board devicetree. Please see DT binding documentation for needed
>> properties:
>> Documentation/devicetree/bindings/net/micrel-ksz90x1.txt
> 
> It probably does not even need that. Just
> 
> phy-mode = <rgmii-txid>

Looks to me like this isn't supported by the Micrel PHY driver or am
I missing something?

Cheers
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
