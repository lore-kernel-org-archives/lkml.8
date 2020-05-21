Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD70C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A5A2207D8
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 02:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727930AbgEUChk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 22:37:40 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:34470 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgEUChk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 22:37:40 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5C29180307CB;
        Thu, 21 May 2020 02:37:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id iiCsY7-X5QfY; Thu, 21 May 2020 05:37:36 +0300 (MSK)
Date:   Thu, 21 May 2020 05:37:35 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Jarkko Nikula <jarkko.nikula@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        <linux-mips@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <linux-kernel@vger.kernel.org>, <linux-i2c@vger.kernel.org>
Subject: Re: [PATCH v2 08/12] i2c: designware: Introduce platform drivers
 glue layer interface
Message-ID: <20200521023735.mja62ujmxebgwyef@mobilestation>
References: <20200306132001.1B875803087C@mail.baikalelectronics.ru>
 <20200510095019.20981-1-Sergey.Semin@baikalelectronics.ru>
 <20200510095019.20981-9-Sergey.Semin@baikalelectronics.ru>
 <4950bb1e-302f-947e-1924-452a8169b504@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4950bb1e-302f-947e-1924-452a8169b504@linux.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 03:46:11PM +0300, Jarkko Nikula wrote:
> Hi
> 
> On 5/10/20 12:50 PM, Serge Semin wrote:
> > Seeing the DW I2C platform driver is getting overcomplicated with a lot of
> > vendor-specific configs let's introduce a glue-layer interface so new
> > platforms which equipped with Synopsys Designware APB I2C IP-core would
> > be able to handle their peculiarities in the dedicated objects.
> > 
> Comment to this patch and patches 9/12 and 12/12:
> 
> Currently i2c-designware-platdrv.c is about 500 lines of code so I don't
> think it's too overcomplicated. But I feel we have already too many Kconfig
> options and source modules for i2c-designware and obviously would like to
> push back a little from adding more.
> 
> I don't think i2c-designware-platdrv.c becomes yet too complicated if Baikal
> related code is added there, perhaps under #ifdef CONFIG_OF like MSCC Ocelot
> code is currently.

Well, it's up to you to decide, what solution is more suitable for you to
maintain. My idea of detaching the MSCC and Baikal-T1 code to the dedicated
source files was to eventually move the whole i2c-designware-* set of files
into a dedicated directory drivers/i2c/buses/dw as it's done for some others
Synopsys DesignWare controllers: drivers/pci/controller/dwc/, drivers/usb/dwc2,
drivers/usb/dwc3, drivers/net/ethernet/synopsys/ . If you think, that it's too
early for Dw I2C code to live in a dedicated directory, fine with me. I can
merge the MSCC and Baikal-T1 code back into the i2c-designware-platdrv.c .
So what's your final word in this matter?

-Sergey

> 
> -- 
> Jarkko
