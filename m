Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847A1C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3297A20714
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nic.cz header.i=@nic.cz header.b="C520icwS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727009AbgGXNMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:12:37 -0400
Received: from mail.nic.cz ([217.31.204.67]:50748 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgGXNMg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:12:36 -0400
Received: from dellmb.labs.office.nic.cz (unknown [IPv6:2001:1488:fffe:6:cac7:3539:7f1f:463])
        by mail.nic.cz (Postfix) with ESMTPSA id 00A75140801;
        Fri, 24 Jul 2020 15:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nic.cz; s=default;
        t=1595596354; bh=H1Iy2RmThtmPmY772Tk+HA8bPvycqv32qtA9Ao7DLic=;
        h=Date:From:To;
        b=C520icwSGGh2mVdekr0KQF668mpCO/eyWocrmmgCSzFMUB9w6cyLs5r4ujEtel7Js
         Fl5qrXbjsh2nt3kGllxk/4ISjE6apgQkACgZmQozBcjEn+ULCk/WG3lAbNjRqd0odr
         88ydBWYmSxH2rDzArEFB5G0EhdaI7rvyJzCvgQf4=
Date:   Fri, 24 Jul 2020 15:12:33 +0200
From:   Marek =?ISO-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     linux-leds@vger.kernel.org, jacek.anaszewski@gmail.com,
        Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?Q?Ond=C5=99ej?= Jirman <megous@megous.com>,
        netdev@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v2 0/1] Add support for LEDs on
 Marvell PHYs
Message-ID: <20200724151233.35d799e8@dellmb.labs.office.nic.cz>
In-Reply-To: <20200724102901.qp65rtkxucauglsp@duo.ucw.cz>
References: <20200723181319.15988-1-marek.behun@nic.cz>
        <20200724102901.qp65rtkxucauglsp@duo.ucw.cz>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/flYJlGJ8fDgKX5f6f0.HrAl"
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/flYJlGJ8fDgKX5f6f0.HrAl
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Fri, 24 Jul 2020 12:29:01 +0200
Pavel Machek <pavel@ucw.cz> wrote:

> In future, would you expect having software "1000/100/10/nolink"
> triggers I could activate on my scrollock LED (or on GPIO controlled
> LEDs) to indicate network activity?

Look at drivers/net/phy/phy_led_triggers.c, something like that could
be actually implemented there.

Some of the modes are useful, like the "1000/100/10/nolink". But some
of them are pretty weird, and I don't think anyone actually uses it
("1000-10/else", which is on if the device is linked at 1000mbps ar
10mbps, and else off? who would sacrifies a LED for this?).

I actually wanted to talk about the phy_led_triggers.c code. It
registers several trigger for each PHY, with the name in form:
  phy-device-name:mode
where
  phy-device-name is derived from OF
    - sometimes it is in the form
      d0032004.mdio-mii:01
    - but sometimes in the form of whole OF path followed by ":" and
      the PHY address:
      /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:08
  mode is "link", "1Gbps", "100Mbps", "10Mbps" and so on"

So I have a GPIO LED, and I can set it to sw trigger so that it is on
when a specific PHY is linked on 1Gbps.

The problem is that on Turris Mox I can connect up to three 8-port
switches, which yields in 25 network PHYs overall. So reading the
trigger file results in 4290 bytes (look at attachment cat_trigger.txt).
I think the phy_led_triggers should have gone this way of having just
one trigger (like netdev has), and specifying phy device via and mode
via another file.

Marek


--MP_/flYJlGJ8fDgKX5f6f0.HrAl
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=cat_trigger.txt

none timer oneshot heartbeat default-on [mmc0] mmc1 /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:01:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:01:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:01:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:01:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:02:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:02:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:02:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:02:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:03:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:03:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:03:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:03:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:04:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:04:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch
 1@11/mdio:04:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:04:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:05:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:05:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:05:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:05:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:06:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:06:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:06:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:06:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:07:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:07:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:07:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:07:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:08:link /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:08:1Gbps /soc/inter
 nal-regs@d0000000/mdio@32004/switch1@11/mdio:08:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch1@11/mdio:08:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:01:link /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:01:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:01:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:01:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:02:link /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:02:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:02:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:02:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:03:link /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:03:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:03:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:03:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:04:link /soc/internal-regs@d0000000/mdio@32004/
 switch0@10/mdio:04:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:04:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:04:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:05:link /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:05:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:05:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:05:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:06:link /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:06:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:06:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:06:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:07:link /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:07:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:07:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:07:10Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:08:link /soc
 /internal-regs@d0000000/mdio@32004/switch0@10/mdio:08:1Gbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:08:100Mbps /soc/internal-regs@d0000000/mdio@32004/switch0@10/mdio:08:10Mbps d0032004.mdio-mii:01:link d0032004.mdio-mii:01:1Gbps d0032004.mdio-mii:01:100Mbps d0032004.mdio-mii:01:10Mbps

--MP_/flYJlGJ8fDgKX5f6f0.HrAl--
