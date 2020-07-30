Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16506C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7409208A9
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 17:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730090AbgG3ROC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 13:14:02 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:57778 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726353AbgG3ROC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 13:14:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 49F018001304;
        Thu, 30 Jul 2020 17:14:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id nLP0o5s0y3oP; Thu, 30 Jul 2020 20:13:58 +0300 (MSK)
Date:   Thu, 30 Jul 2020 20:13:58 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Vinod Koul <vkoul@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Rob Herring <robh+dt@kernel.org>, <dmaengine@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] dmaengine: dw: Activate FIFO-mode for memory
 peripherals only
Message-ID: <20200730171358.7yxnqavmszahlzfr@mobilestation>
References: <20200730154545.3965-1-Sergey.Semin@baikalelectronics.ru>
 <20200730154545.3965-3-Sergey.Semin@baikalelectronics.ru>
 <20200730162428.GU3703480@smile.fi.intel.com>
 <20200730163154.qqrlas4zrybvocno@mobilestation>
 <20200730164703.GY3703480@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200730164703.GY3703480@smile.fi.intel.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 07:47:03PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 30, 2020 at 07:31:54PM +0300, Serge Semin wrote:
> > On Thu, Jul 30, 2020 at 07:24:28PM +0300, Andy Shevchenko wrote:
> > > On Thu, Jul 30, 2020 at 06:45:42PM +0300, Serge Semin wrote:
> 
> ...
> 
> > > > Thanks to the commit ???????????? ("dmaengine: dw: Initialize channel
> 
> ...
> 
> > > > Note the DMA-engine repository git.infradead.org/users/vkoul/slave-dma.git
> > > > isn't accessible. So I couldn't find out the Andy' commit hash to use it in
> > > > the log.
> > 
> > > It's dmaengine.git on git.kernel.org.
> > 
> > Ah, thanks! I've just found out that the repo address has been changed. But I've
> > also scanned the "next" branch of the repo:
> > https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/dmaengine.git
> > 
> > Your commit isn't there. Am I missing something?
> 

> It's a fix. It went to upstream branch (don't remember its name by heart in
> Vinod's repo).

Right. Found it. Thanks.

-Sergey

> 
> -- 
> With Best Regards,
> Andy Shevchenko
> 
> 
