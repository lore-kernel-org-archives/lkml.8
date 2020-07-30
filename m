Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E83C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5249820578
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728868AbgG3OZW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:25:22 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:56782 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727769AbgG3OZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:25:20 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 29823803202F;
        Thu, 30 Jul 2020 14:25:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 10BIHUia0LCy; Thu, 30 Jul 2020 17:25:17 +0300 (MSK)
Date:   Thu, 30 Jul 2020 17:25:17 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
CC:     Hoan Tran <hoan@os.amperecomputing.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, <linux-gpio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 04/10] gpio: dwapb: Add max GPIOs macro
Message-ID: <20200730142517.6yrcx274opjdlp7q@mobilestation>
References: <20200730135536.19747-1-Sergey.Semin@baikalelectronics.ru>
 <20200730135536.19747-5-Sergey.Semin@baikalelectronics.ru>
 <20200730140526.GL3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200730140526.GL3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:05:26PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 30, 2020 at 04:55:30PM +0300, Serge Semin wrote:
> > Add a new macro DWAPB_MAX_GPIOS which defines the maximum possible number
> > of GPIO lines corresponding to the maximum DW APB GPIO controller port
> > width. Use the new macro instead of number literal 32 where it's
> > applicable.
> 

> Since it's a modified version of what I sent earlier, perhaps Suggested-by?

Oh, found it
[PATCH v1 6/6] gpio: dwapb: Define magic number for IRQ and GPIO lines

Sorry for missing your suggested-by tag. I'll add it if new revision is
required. Otherwise, Linus, could you add it when you apply the series?

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
