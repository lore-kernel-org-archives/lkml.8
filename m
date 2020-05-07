Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB7AC38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:11:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 153AF2075E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 09:11:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVxUpNAU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgEGJLB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 05:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgEGJLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 05:11:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE05C061A10;
        Thu,  7 May 2020 02:11:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id u10so1830978pls.8;
        Thu, 07 May 2020 02:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JBT6KrKPDV5CjqbR8NDCy7mpTcDdeEp7C5NBrNvcrDY=;
        b=kVxUpNAU2X5gF8L0wi+DyBySR80rdREgOTCndFcxAxZ5o1/ZAGVfUqtsWKwLF0Pa/u
         5VlziewE/8fe6NnCkGc3Ph2U6L2/oSl/f8uR72qd3yHNwaqdpv2dvNMAW1V6ZK6GmZpF
         XufJCfMyHxhC43y07FPPo6k6b4e6UWM1L9UIseHpeJakHL2EDV8nuqNy1lOlb7/Lvovx
         +Qr8DuTQ62XSzBiO9K+0Sy9zPbrwHFV3jEPKUwqIHxZfJQ6mIwmROmv/B8yYWXUa1+Hd
         afZ9rgolKYC6b4dwrtUFVeaOonYWK/bbkkYwAxSkHn4eQ5RuvJlmrbmxTSe3vpUhlwXO
         i/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JBT6KrKPDV5CjqbR8NDCy7mpTcDdeEp7C5NBrNvcrDY=;
        b=mKk58xCj7IrgyFPzlX4HP0/1UQ6jAl4gS3mGosze9G5sR1uZeD1PUBQnBF2WwnQEqO
         ohTdy693f95D52qms3rIreJhdaml6/nLBabmw7IbHCGJyYV8CI1RFCLllXRnMOfp6q5s
         9XBIHF31rQxYMCypBjcxUJlAT5QUmTRG6CKCSxfXD2HJi50kgHR/3sDr81dsc3rO96YM
         Qi9cAodITc1BqfNmcWElFvgAHzlV/NT0PSgaJZEwLNi4UsEqAmQVNiHZ+MGqpH/yQwUU
         5AEArHZJ9QPll3uy7mfhIhAxT8mHMU4y5VwY3CjkYZodgDnXbEnC5741KUeFcxPLyf8g
         jr4g==
X-Gm-Message-State: AGi0Pubt88k8/P26Bs2QGLaij4qRkB0W5jV4afOfG+rn+dI0oiShJZN4
        6HdH2pYkC/06F0iaZWrFOPCScPBZe6cEkGdT88g=
X-Google-Smtp-Source: APiQypLSmUDlB8+hESCKFexeV6yOLtQ3+jQd1hZaeXg3Qh7fHvakmbggZLIgn4AzvrXWYYT9Q3xQHb/UA6E5FX3UzOE=
X-Received: by 2002:a17:90a:340c:: with SMTP id o12mr13739254pjb.22.1588842660053;
 Thu, 07 May 2020 02:11:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200505132905.10276-1-calvin.johnson@oss.nxp.com>
 <20200505132905.10276-6-calvin.johnson@oss.nxp.com> <CAHp75VfOcQiACsOcfWyJSP1dzdYpaCa-_KKf==4YCkaM_Wk3Tg@mail.gmail.com>
 <20200507074435.GA10296@lsv03152.swis.in-blr01.nxp.com>
In-Reply-To: <20200507074435.GA10296@lsv03152.swis.in-blr01.nxp.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 7 May 2020 12:10:48 +0300
Message-ID: <CAHp75VeFCzJ97c7AZD8ksA-r3C-XyM24Rt30+Obw6tCaR4xprA@mail.gmail.com>
Subject: Re: [net-next PATCH v3 5/5] net: mdiobus: Introduce fwnode_mdiobus_register_phy()
To:     Calvin Johnson <calvin.johnson@oss.nxp.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux.cj@gmail.com, Jeremy Linton <jeremy.linton@arm.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Cristi Sovaiala <cristian.sovaiala@nxp.com>,
        Florin Laurentiu Chiculita <florinlaurentiu.chiculita@nxp.com>,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        Madalin Bucur <madalin.bucur@oss.nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        "Rajesh V . Bikkina" <rajesh.bikkina@nxp.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>,
        netdev <netdev@vger.kernel.org>, Marcin Wojtas <mw@semihalf.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Pankaj Bansal <pankaj.bansal@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Heiner Kallweit <hkallweit1@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 10:44 AM Calvin Johnson
<calvin.johnson@oss.nxp.com> wrote:
>
> On Tue, May 05, 2020 at 05:22:00PM +0300, Andy Shevchenko wrote:
> > On Tue, May 5, 2020 at 4:30 PM Calvin Johnson
> > <calvin.johnson@oss.nxp.com> wrote:

...

> > > +       bool is_c45 = false;
> >
> > Redundant assignment, see below.
> >
> > > +       const char *cp;
> > > +       u32 phy_id;
> > > +       int rc;

> > > +       fwnode_property_read_string(child, "compatible", &cp);
> >
> > Consider rc = ...; otherwise you will have UB below.
> >
> > > +       if (!strcmp(cp, "ethernet-phy-ieee802.3-c45"))
> >
> > UB!
>
> Thanks for the comments! I've considered all of them.
> What is UB, by the way? :)-

Undefined Behaviour.

-- 
With Best Regards,
Andy Shevchenko
