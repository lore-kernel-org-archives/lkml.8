Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5863CC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14F142087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 13:17:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729912AbgIINRe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 09:17:34 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:52316 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730271AbgIINOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 09:14:21 -0400
Received: from andrew by vps0.lunn.ch with local (Exim 4.94)
        (envelope-from <andrew@lunn.ch>)
        id 1kFzUF-00Dusi-A6; Wed, 09 Sep 2020 14:46:07 +0200
Date:   Wed, 9 Sep 2020 14:46:07 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Luka Kovacic <luka.kovacic@sartura.hr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-hwmon@vger.kernel.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>, Dan Murphy <dmurphy@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jason Cooper <jason@lakedaemon.net>,
        Gregory Clement <gregory.clement@bootlin.com>,
        luka.perkov@sartura.hr
Subject: Re: [PATCH 4/7] drivers: leds: Add the iEi WT61P803 PUZZLE LED driver
Message-ID: <20200909124607.GB3316362@lunn.ch>
References: <20200905130336.967622-1-luka.kovacic@sartura.hr>
 <20200905130336.967622-5-luka.kovacic@sartura.hr>
 <CAHp75VfwPa9zL6HCz+qqXJ1rK2JB=ewRiK1qdrgsyxixA5R5Lg@mail.gmail.com>
 <20200909103638.GB9222@amd>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200909103638.GB9222@amd>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 09, 2020 at 12:36:38PM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Add support for the iEi WT61P803 PUZZLE LED driver.
> > > Currently only the front panel power LED is supported.
> > >
> > > This driver depends on the iEi WT61P803 PUZZLE MFD driver.
> > 
> > Can we make it OF independent?
> > See below how to achieve this.
> 
> Is there reason to believe this will be found in non-OF systems?

For this specific board with 2x 10G SFP+, i doubt it will be a pure
ACPI system. It could be a mixed system, ACPI for the simple bits, and
DT for the advanced parts.

Could this MFD appear on boards which could be pure ACPI? Maybe, if
their networking is simple enough, or Linux is not in control of the
low level details. There are some Intel Puzzle devices which could
potentially use the MFD.

      Andrew
