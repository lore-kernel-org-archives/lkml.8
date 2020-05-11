Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B47AC54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:32:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17CEE206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 18:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbgEKScv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 14:32:51 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:49770 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729727AbgEKScv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 14:32:51 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 3A2FD803088B;
        Mon, 11 May 2020 18:32:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id P1N1qOkT7GET; Mon, 11 May 2020 21:32:47 +0300 (MSK)
Date:   Mon, 11 May 2020 21:32:47 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Mark Brown <broonie@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] dmaengine: dw: Print warning if multi-block is
 unsupported
Message-ID: <20200511183247.y6cfss22pe67nouf@mobilestation>
References: <20200306131048.ADBE18030797@mail.baikalelectronics.ru>
 <20200508105304.14065-1-Sergey.Semin@baikalelectronics.ru>
 <20200508105304.14065-5-Sergey.Semin@baikalelectronics.ru>
 <20200508112604.GJ185537@smile.fi.intel.com>
 <20200508115334.GE4820@sirena.org.uk>
 <20200511021016.wptcgnc3iq3kadgz@mobilestation>
 <20200511115813.GG8216@sirena.org.uk>
 <20200511134502.hjbu5evkiuh75chr@mobilestation>
 <20200511174414.GL8216@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200511174414.GL8216@sirena.org.uk>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 06:44:14PM +0100, Mark Brown wrote:
> On Mon, May 11, 2020 at 04:45:02PM +0300, Serge Semin wrote:
> > On Mon, May 11, 2020 at 12:58:13PM +0100, Mark Brown wrote:
> 
> > > That sounds like you need to also impose a limit on the maximum message
> > > size as well then, with that you should be able to handle messages up
> > > to whatever that limit is.  There's code for that bit already, so long
> > > as the limit is not too low it should be fine for most devices and
> > > client drivers can see the limit so they can be updated to work with it
> > > if needed.
> 
> > Hmm, this might work. The problem will be with imposing such limitation through
> > the DW APB SSI driver. In order to do this I need to know:
> 
> > 1) Whether multi-block LLP is supported by the DW DMA controller.
> > 2) Maximum DW DMA transfer block size.
> 
> There is a constraint enumeration interface in the DMA API which you
> should be able to extend for this if it doesn't already support what you
> need.

Yes, that's max segment size.

> 
> > Then I'll be able to use this information in the can_dma() callback to enable
> > the DMA xfers only for the safe transfers. Did you mean something like this when
> > you said "There's code for that bit already" ? If you meant the max_dma_len
> > parameter, then setting it won't work, because it just limits the SG items size
> > not the total length of a single transfer.
> 
> You can set max_transfer_size and/or max_message_size in the SPI driver
> - you should be able to do this on probe.

Thanks for the explanation. Max segment size being set to the DMA controller generic
device should work well. There is no need in setting the transfer and messages
size limitations. Besides I don't really see the
max_transfer_size/max_message_size callbacks utilized in the SPI core. These
functions are called in the spi-mem.c driver only. Do I miss something?

-Sergey

