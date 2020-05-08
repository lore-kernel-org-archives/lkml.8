Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D9EC38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:18:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA04420CC7
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 19:18:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgEHTSy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 15:18:54 -0400
Received: from foss.arm.com ([217.140.110.172]:52060 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHTSx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 15:18:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E877AD6E;
        Fri,  8 May 2020 12:18:52 -0700 (PDT)
Received: from [192.168.122.166] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A4C353F305;
        Fri,  8 May 2020 12:18:51 -0700 (PDT)
Subject: Re: [net-next PATCH v3 4/5] net: phy: Introduce fwnode_get_phy_id()
To:     Andrew Lunn <andrew@lunn.ch>,
        Calvin Johnson <calvin.johnson@oss.nxp.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        linux.cj@gmail.com, Florian Fainelli <f.fainelli@gmail.com>,
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
References: <20200505132905.10276-1-calvin.johnson@oss.nxp.com>
 <20200505132905.10276-5-calvin.johnson@oss.nxp.com>
 <67e263cf-5cd7-98d1-56ff-ebd9ac2265b6@arm.com>
 <CAHp75Vew8Fh6HEoOACk+J9KCpw+AE2t2+oFnXteK1eShopfYAA@mail.gmail.com>
 <83ab4ca4-9c34-4cdd-4413-3b4cdf96727d@arm.com>
 <20200508160755.GB10296@lsv03152.swis.in-blr01.nxp.com>
 <20200508181301.GF298574@lunn.ch>
From:   Jeremy Linton <jeremy.linton@arm.com>
Message-ID: <1e33605e-42fd-baf8-7584-e8fcd5ca6fd3@arm.com>
Date:   Fri, 8 May 2020 14:18:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508181301.GF298574@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/8/20 1:13 PM, Andrew Lunn wrote:
>>> It does have a numeric version defined for EISA types. OTOH I suspect that
>>> your right. If there were a "PHY\VEN_IDvvvv&ID_DDDD" definition, it may not
>>> be ideal to parse it. Instead the normal ACPI model of exactly matching the
>>> complete string in the phy driver might be more appropriate.
>>
>> IMO, it should be fine to parse the string to extract the phy_id. Is there any
>> reason why we cannot do this?
> 
> Some background here, about what the PHY core does.
> 
> PHYs have two ID registers. This contains vendor, device, and often
> revision of the PHY. Only the vendor part is standardised, vendors can
> decide how to use the device part, but it is common for the lowest
> nibble to be revision. The core will read these ID registers, and then
> go through all the PHY drivers registered and ask them if they support
> this ID. The drivers provide a table of IDs and masks. The mask is
> applied, and then if the ID matches, the driver is used. The mask
> allows the revision to be ignored, etc.
> 
> There is a very small number of devices where the vendor messed up,
> and did not put valid contents in the ID registers. In such cases, we
> can read the IDs from device tree. These are then used in exactly the
> same way as if they were read from the device.
>

Is that the case here?

Also, how much of this was caused by uboot being deficient, and failing 
to do vendor specific setup? AKA like what has been happening with the 
mac addresses, where it turns out the difference between a chip being 
used on x86 vs arm has frequently been that no one bothered to port all 
the option rom functionality to uboot (and in some cases edk2).

> If you want the ACPI model to be used, an exact match on the string,
> you are going to have to modify the core and the drivers. They
> currently don't have any string, and have no idea about different
> revisions which are out in the wild.

Right, not pretty. But _DSD should never be used to provide functionally 
provided elsewhere in the spec, and with ACPI the attempt is to make the 
firmware less linux focused, and more generic.

> 
>>> Similarly to how I suspect the next patch's use of "compatible" isn't ideal
>>> either, because whether a device is c45 or not, should tend to be fixed to a
>>> particular vendor/device implementation and not a firmware provided
>>> property.
> 
> Not exactly true. It is the combination of can the bus master do C45
> and can the device do C45. Unfortunately, we have no knowledge of the
> bus masters capabilities, if it can do C45. And many MDIO drivers will
> do a C22 transaction when asked to perform a C45 transaction. All new
> submissions for MDIO drivers i ask for EOPNOTSUPP to be returned if
> C45 is not supported. But we cannot rely on that. Too much history >
>>
>> I tend to agree with you on this. Even for DT, ideal case, IMO should be:
>>
>> 1) mdiobus_scan scans the mdiobus for c22 devices by reading phy id from
>> registers 2 and 3
>> 2) if not found scan for c45 devices <= looks like this is missing in Linux
>> 3) look for phy_id from compatible string.
> 
> It is somewhat more complex, in that there are a small number of
> devices which will respond to both C22 and C45. Generally, you want to
> use C45 if supported. So you would want to do the C45 scan first. But
> then the earlier problem comes to play, you have no idea if the bus
> master actually correctly supports C45.

But this shouldn't this be implied by the mdio vendor/model? AKA, you 
wouldn't have a part with a given _HID() where the capabilities would 
change.You would only have a situation where the phy's capabilities 
change, but they must in the end support whatever is provided by the master.

> 
> Given the issues, we assume all bus masters and PHY devices are C22
> unless DT says the bus master and PHY combination is compatible with
> C45.

How much of this can be simplified for ACPI buy ignoring the legacy and 
putting some guides around the ACPI/platform requirements?


Thanks,
