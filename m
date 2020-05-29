Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCD0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 808532074B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 09:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgE2Jtd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 05:49:33 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:46914 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgE2Jta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 05:49:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 55F648030839;
        Fri, 29 May 2020 09:49:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZtAkASHM4lIf; Fri, 29 May 2020 12:49:20 +0300 (MSK)
Date:   Fri, 29 May 2020 12:49:19 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>, Feng Tang <feng.tang@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 01/16] spi: dw: Set xfer effective_speed_hz
Message-ID: <20200529094919.uw3fodztc3vvnj6a@mobilestation>
References: <20200529035915.20790-1-Sergey.Semin@baikalelectronics.ru>
 <20200529035915.20790-2-Sergey.Semin@baikalelectronics.ru>
 <afdf414a-df95-b130-85e8-cda5bf4e9405@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <afdf414a-df95-b130-85e8-cda5bf4e9405@cogentembedded.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 11:49:12AM +0300, Sergei Shtylyov wrote:
> Hello!
> 
> On 29.05.2020 6:58, Serge Semin wrote:
> 
> > Seeing DW APB SSI controller doesn't support setting the exactly
> > requested SPI bus frequency, but only a rounded frequency determined
> > by means of the odd-numbered half-worded reference clock divider,
> > it would be good tune the SPI core up and initialize the current
>                   ^ to?

Thanks! I'll fix it in the next patchset version.

-Sergey

> 
> > transfer effective_speed_hz. By doing so the core will be able to
> > execute the xfer-related delays with better accuracy.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Cc: Georgy Vlasov <Georgy.Vlasov@baikalelectronics.ru>
> > Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> > Cc: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Feng Tang <feng.tang@intel.com>
> > Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Cc: Rob Herring <robh+dt@kernel.org>
> > Cc: linux-mips@vger.kernel.org
> > Cc: devicetree@vger.kernel.org
> [...]
> 
> MBR, Sergei
