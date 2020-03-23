Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A50C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C99206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 19:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727725AbgCWTTH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 15:19:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:38026 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727479AbgCWTTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 15:19:07 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5C06780307C2;
        Mon, 23 Mar 2020 19:19:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Y46FSv-2VEDP; Mon, 23 Mar 2020 22:19:04 +0300 (MSK)
Date:   Mon, 23 Mar 2020 22:18:51 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-gpio@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 6/6] MAINTAINERS: Add Segey Semin to maintainers of DW
 APB GPIO driver
Message-ID: <20200323191851.igcmajoni6iru2o5@ubsrv2.baikal.int>
References: <20200306132505.8D3B88030795@mail.baikalelectronics.ru>
 <20200323180632.14119-1-Sergey.Semin@baikalelectronics.ru>
 <20200323180632.14119-7-Sergey.Semin@baikalelectronics.ru>
 <20200323183424.GT1922688@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200323183424.GT1922688@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 23, 2020 at 08:34:24PM +0200, Andy Shevchenko wrote:
> On Mon, Mar 23, 2020 at 09:06:32PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > Add myself as a co-maintainer of the Synopsis DesignWare APB GPIO driver.
> 
> I see neither cover letter, nor first three patches. What's going on?
> 

Automatic "cc-cmd" is added you to the Cc list. You've been referenced as a patch
submitter, that's why you are in Cc to this and some another patch.

Regards,
-Sergey

> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16084,6 +16084,7 @@ F:	drivers/tty/serial/8250/8250_dw.c
> >  
> >  SYNOPSYS DESIGNWARE APB GPIO DRIVER
> >  M:	Hoan Tran <hoan@os.amperecomputing.com>
> 
> > +S:	Serge Semin <fancer.lancer@gmail.com>
> 
> Are you sure you used a correct letter?
> 
> >  L:	linux-gpio@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt
> 
> Had you chance to run parse-maintainers.pl to see if other fields are in order?
> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
