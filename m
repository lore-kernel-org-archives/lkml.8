Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FAF9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:07:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24434208D5
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 19:07:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730267AbgFPTHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:07:12 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:50650 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729841AbgFPTHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 15:07:12 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AD5668030879;
        Tue, 16 Jun 2020 19:07:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3Lnds3tUV9R1; Tue, 16 Jun 2020 22:07:04 +0300 (MSK)
Date:   Tue, 16 Jun 2020 22:07:02 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Serge Semin <fancer.lancer@gmail.com>,
        Viresh Kumar <vireshk@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Alexey Kolotnikov <Alexey.Kolotnikov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>, <linux-mips@vger.kernel.org>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 00/11] dmaengine: dw: Take Baikal-T1 SoC DW DMAC
 peculiarities into account
Message-ID: <20200616190702.lf3wq4izevup26q7@mobilestation>
References: <20200529144054.4251-1-Sergey.Semin@baikalelectronics.ru>
 <20200602092734.6oekfmilbpx54y64@mobilestation>
 <20200616163242.GO2324254@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200616163242.GO2324254@vkoul-mobl>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 10:02:42PM +0530, Vinod Koul wrote:
> Hi Serge,
> 
> On 02-06-20, 12:27, Serge Semin wrote:
> > Vinod, Viresh
> > 
> > Andy's finished his review. So all the patches of the series (except one rather
> > decorative, which we have different opinion of) are tagged by him. Since merge
> > window is about to be opened please consider to merge the series in. I'll really
> > need it to be in the kernel to provide the noLLP-problem fix for the Dw APB SSI
> > in 5.8.
> 
> Sorry it was too late for 5.8.. merge window is closed now, i will
> review it shortly

Yeah, alas It's too late now. On the other hand this is probably for better since
I've discovered that the noLLP-related problem is more complicated than I thought
in the first place. Yes, the interrupt handling latency will cause the problem
with Rx FIFO overflow, but the overflow might still happen due to several other
reasons (mostly due to our APB bus being too slow, but it can still be partly
fixed, and I am looking for a convenient solution at the moment). So could you
please merge the series in without the next patches:
[PATCH v5 04/11] dmaengine: Introduce max SG list entries capability
[PATCH v5 11/11] dmaengine: dw: Initialize max_sg_nents capability 
If I manage to fix the problem in general then I'll send another series with
those two patches being part of it. Otherwise they won't be much useful for my
platform. Sorry for inconvenience and thanks for understanding.

-Sergey

> 
> -- 
> ~Vinod
