Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E5D5C10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCD6124655
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 00:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbgCJA0X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 20:26:23 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:44426 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbgCJA0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 20:26:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 68D30803087C;
        Tue, 10 Mar 2020 00:26:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5-s31Ti5uv7A; Tue, 10 Mar 2020 03:26:19 +0300 (MSK)
Date:   Tue, 10 Mar 2020 03:25:29 +0300
From:   Sergey Semin <Sergey.Semin@baikalelectronics.ru>
To:     Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>,
        Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>,
        Vadim Vlasov <V.Vlasov@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Burton <paulburton@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] hwmon: Add Baikal-T1 SoC Process, Voltage and Temp
 sensor support
References: <20200306132604.14312-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200306132604.14312-1-Sergey.Semin@baikalelectronics.ru>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Message-Id: <20200310002621.68D30803087C@mail.baikalelectronics.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 06, 2020 at 04:26:02PM +0300, Sergey.Semin@baikalelectronics.ru wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> 
> In order to keep track of Baikal-T1 SoC power consumption and make sure
> the chip heating is within the normal temperature limits, there is
> a dedicated hardware monitor sensor embedded into the SoC. It is based
> on the Analog Bits PVT sensor but equipped with a vendor-specific control
> wrapper, which ease an access to the sensors functionality. Fist of all it
> provides an accessed to the sampled Temperature, Voltage and
> Low/Standard/High Voltage thresholds. In addition the wrapper generates
> an interrupt in case if one enabled for alarm thresholds or data ready
> event. All of these functionality is implemented in the Baikal-T1 PVT
> driver submitted within this patchset. Naturally there is also a patch,
> which creates a corresponding yaml-based dt-binding file for the sensor.
> 
> This patchset is rebased and tested on the mainline Linux kernel 5.6-rc4:
> commit 98d54f81e36b ("Linux 5.6-rc4").
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> Signed-off-by: Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>
> Signed-off-by: Maxim Kaurkin <Maxim.Kaurkin@baikalelectronics.ru>
> Cc: Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>
> Cc: Ramil Zaripov <Ramil.Zaripov@baikalelectronics.ru>
> Cc: Ekaterina Skachko <Ekaterina.Skachko@baikalelectronics.ru>
> Cc: Vadim Vlasov <V.Vlasov@baikalelectronics.ru>
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: Paul Burton <paulburton@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Jean Delvare <jdelvare@suse.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: linux-hwmon@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> 
> Serge Semin (2):
>   dt-bindings: hwmon: Add Baikal-T1 PVT sensor bindings
>   hwmon: Add Baikal-T1 PVT sensor driver
> 
>  .../devicetree/bindings/hwmon/be,bt1-pvt.yaml |  100 ++
>  Documentation/hwmon/bt1-pvt.rst               |  113 ++
>  drivers/hwmon/Kconfig                         |   29 +
>  drivers/hwmon/Makefile                        |    1 +
>  drivers/hwmon/bt1-pvt.c                       | 1147 +++++++++++++++++
>  drivers/hwmon/bt1-pvt.h                       |  266 ++++
>  6 files changed, 1656 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/hwmon/be,bt1-pvt.yaml
>  create mode 100644 Documentation/hwmon/bt1-pvt.rst
>  create mode 100644 drivers/hwmon/bt1-pvt.c
>  create mode 100644 drivers/hwmon/bt1-pvt.h
> 
> -- 
> 2.25.1
> 

Folks,

It appears our corporate email server changes the Message-Id field of 
messages passing through it. Due to that the emails threading gets to be
broken. I'll resubmit the properly structured v2 patchset as soon as our
system administrator fixes the problem. Sorry for the inconvenience caused
by it.

Regards,
-Sergey
