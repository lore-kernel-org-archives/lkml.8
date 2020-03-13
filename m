Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BAC5C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBE220724
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 15:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCMPKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 11:10:32 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:32982 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgCMPKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 11:10:32 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id DD6DB8030886;
        Fri, 13 Mar 2020 15:10:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id UaHhf6L2OPxZ; Fri, 13 Mar 2020 18:10:28 +0300 (MSK)
Date:   Fri, 13 Mar 2020 18:09:43 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Rob Herring <robh@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: mfd: Add Baikal-T1 Boot Controller
 bindings
Message-ID: <20200313150943.66xg5my2kwfjhqja@ubsrv2.baikal.int>
References: <20200306130528.9973-1-Sergey.Semin@baikalelectronics.ru>
 <20200306130613.7D8CE8030794@mail.baikalelectronics.ru>
 <20200309180734.A303C80307C7@mail.baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200309180734.A303C80307C7@mail.baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 01:07:28PM -0500, Rob Herring wrote:
> On Fri, 6 Mar 2020 16:05:27 +0300, <Sergey.Semin@baikalelectronics.ru> wrote:
> > From: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > >From Linux point of view Baikal-T1 Boot Controller is a multi-function
> > memory-mapped device, which provides an access to three memory-mapped
> > ROMs and to an embedded DW APB SSI-based SPI controller. It's refelected
> > in the be,bt1-boot-ctl bindings file. So the device must be added to
> > the system dts-file as an ordinary memory-mapped device node with
> > a single clocks source phandle declared and with also memory-mapped
> > spi/mtd-rom sub-devices.
> > 
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> > Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> > Cc: Paul Burton <paulburton@kernel.org>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > ---
> >  .../bindings/mfd/be,bt1-boot-ctl.yaml         | 89 +++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.example.dts:17:10: fatal error: dt-bindings/clock/bt1-ccu.h: No such file or directory
>  #include <dt-bindings/clock/bt1-ccu.h>
>           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> compilation terminated.
> scripts/Makefile.lib:311: recipe for target 'Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.example.dt.yaml' failed
> make[1]: *** [Documentation/devicetree/bindings/mfd/be,bt1-boot-ctl.example.dt.yaml] Error 1
> Makefile:1262: recipe for target 'dt_binding_check' failed
> make: *** [dt_binding_check] Error 2
> 
> See https://patchwork.ozlabs.org/patch/1250277
> Please check and re-submit.

Rob,
I'll fix this and also take into account the comments you added to the
hwmon patch. Then I'll resend this patchset. So don't bother with review
for now.

Regards,
-Sergey

