Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD757C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9279E2071A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 22:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgGWWxw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 18:53:52 -0400
Received: from lists.nic.cz ([217.31.204.67]:52042 "EHLO mail.nic.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726390AbgGWWxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 18:53:51 -0400
Received: from localhost (unknown [IPv6:2a0e:b107:ae1:0:3e97:eff:fe61:c680])
        by mail.nic.cz (Postfix) with ESMTPSA id A35D51409A4;
        Fri, 24 Jul 2020 00:53:49 +0200 (CEST)
Date:   Fri, 24 Jul 2020 00:53:49 +0200
From:   Marek Behun <marek.behun@nic.cz>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     linux-leds@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        jacek.anaszewski@gmail.com, Dan Murphy <dmurphy@ti.com>,
        =?UTF-8?B?T25k?= =?UTF-8?B?xZllag==?= Jirman 
        <megous@megous.com>, netdev@vger.kernel.org,
        Russell King <linux@armlinux.org.uk>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC leds + net-next v2 1/1] net: phy: marvell: add
 support for PHY LEDs via LED class
Message-ID: <20200724005349.2e90a247@nic.cz>
In-Reply-To: <20200723213531.GK1553578@lunn.ch>
References: <20200723181319.15988-1-marek.behun@nic.cz>
        <20200723181319.15988-2-marek.behun@nic.cz>
        <20200723213531.GK1553578@lunn.ch>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.102.2 at mail
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 23:35:31 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> Hi Marek
> 
> I expect some of this should be moved into the phylib core. We don't
> want each PHY inventing its own way to do this. The core should
> provide a framework and the PHY driver fills in the gaps.
> 
> Take a look at for example mscc_main.c and its LED information. It has
> pretty similar hardware to the Marvell. And microchip.c also has LED
> handling, etc.

OK, this makes sense. I will have to think about this a little.

My main issue though is whether one "hw-control" trigger should be
registered via LED API and the specific mode should be chosen via
another sysfs file as in this RFC, or whether each HW control mode
should have its own trigger. The second solution would either result in
a lot of registered triggers or complicate LED API, though...

Marek
