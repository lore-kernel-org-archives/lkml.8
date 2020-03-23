Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23568C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:38:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A2B82072D
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 18:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgCWSim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 14:38:42 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:55556 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727586AbgCWSih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 14:38:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8EAF5837F253;
        Mon, 23 Mar 2020 18:38:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: beef27_67eacf456a42a
X-Filterd-Recvd-Size: 2819
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Mar 2020 18:38:33 +0000 (UTC)
Message-ID: <de4ee117f047874788ea64c4625c96d40ec0a35e.camel@perches.com>
Subject: Re: [PATCH v2 6/6] MAINTAINERS: Add Segey Semin to maintainers of
 DW APB GPIO driver
From:   Joe Perches <joe@perches.com>
To:     Sergey.Semin@baikalelectronics.ru
Cc:     Serge Semin <fancer.lancer@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hoan Tran <hoan@os.amperecomputing.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-gpio@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Date:   Mon, 23 Mar 2020 11:36:45 -0700
In-Reply-To: <20200323180632.14119-7-Sergey.Semin@baikalelectronics.ru>
References: <20200306132505.8D3B88030795@mail.baikalelectronics.ru>
         <20200323180632.14119-1-Sergey.Semin@baikalelectronics.ru>
         <20200323180632.14119-7-Sergey.Semin@baikalelectronics.ru>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-23 at 21:06 +0300, Sergey.Semin@baikalelectronics.ru
wrote:
> From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> 
> Add myself as a co-maintainer of the Synopsis DesignWare APB GPIO driver.
[]
> diff --git a/MAINTAINERS b/MAINTAINERS
[]
> @@ -16084,6 +16084,7 @@ F:	drivers/tty/serial/8250/8250_dw.c
>  
>  SYNOPSYS DESIGNWARE APB GPIO DRIVER
>  M:	Hoan Tran <hoan@os.amperecomputing.com>
> +S:	Serge Semin <fancer.lancer@gmail.com>

nack - S: is not the right line type prefix

You need to use an M: type line not an S:.

The S: line is for subsystem status which should be one of:

	S: *Status*, one of the following:
	   Supported:	Someone is actually paid to look after this.
	   Maintained:	Someone actually looks after it.
	   Odd Fixes:	It has a maintainer but they don't have time to do
			much other than throw the odd patch in. See below..
	   Orphan:	No current maintainer [but maybe you could take the
			role as you write your new code].
	   Obsolete:	Old code. Something tagged obsolete generally means
			it has been replaced by a better system and you
			should be using that.

>  L:	linux-gpio@vger.kernel.org
>  S:	Maintained

like this...

>  F:	Documentation/devicetree/bindings/gpio/snps-dwapb-gpio.txt



