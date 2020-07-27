Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5581DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E13E2083B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbgG0Oto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:49:44 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:57899 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbgG0Otn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:49:43 -0400
X-Originating-IP: 90.66.108.79
Received: from localhost (lfbn-lyo-1-1932-79.w90-66.abo.wanadoo.fr [90.66.108.79])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 50C81E0019;
        Mon, 27 Jul 2020 14:49:38 +0000 (UTC)
Date:   Mon, 27 Jul 2020 16:49:38 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc:     Rob Herring <robh@kernel.org>, miguelborgesdefreitas@gmail.com,
        a.zummo@towertech.it, baruch@tkos.co.il, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: rtc: pcf8523: add DSM pm option for
 battery switch-over
Message-ID: <20200727144938.GC239143@piout.net>
References: <20200719145028.3370-3-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-1-miguelborgesdefreitas@gmail.com>
 <20200720112401.4620-2-miguelborgesdefreitas@gmail.com>
 <20200723174905.GA596242@bogus>
 <20200723195755.GV3428@piout.net>
 <20200727094553.GH1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727094553.GH1551@shell.armlinux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2020 10:45:53+0100, Russell King - ARM Linux admin wrote:
> > This is but this shouldn't be a DT property as it has to be changed
> > dynamically. I'm working on an ioctl interface to change this
> > configuration.
> 
> Why does it need to be changed dynamically?  If the hardware components
> are not fitted to allow the RTC to be safely used without DSM, then
> why should userspace be able to disable DSM?

For RTCs with a standby mode, you want to be able to return to standby
mode.

That would happen for example after factory flashing in that common use
case:
 - the board is manufactured
 - Vbackup is installed, the RTC switches to standby mode
 - the board is then booted to flash a system, Vprimary is now present,
   the RTC switches to DSM.

At this point, if the board is simply shut down, the RTC will start
draining Vbackup before leaving the factory. Instead, we want to be able
to return to standby mode until the final user switches the product on
for the first time.

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
