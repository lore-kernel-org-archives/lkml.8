Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ECE9C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:38:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 696E420663
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 13:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727048AbgASNix (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 08:38:53 -0500
Received: from ofcsgdbm.dwd.de ([141.38.3.245]:60363 "EHLO ofcsgdbm.dwd.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726778AbgASNix (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 08:38:53 -0500
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 480wqs4t4Qz11WT
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 13:38:49 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2dn3.dwd.de ([127.0.0.1])
        by localhost (ofcsg2dn3.dwd.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id bHyVGkZuEber for <linux-kernel@vger.kernel.org>;
        Sun, 19 Jan 2020 13:38:49 +0000 (UTC)
Received: from ofmailhub.dwd.de (oflxs446.dwd.de [141.38.40.78])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 480wqs1pRzz10m6;
        Sun, 19 Jan 2020 13:38:49 +0000 (UTC)
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.42.141])
        by ofmailhub.dwd.de (Postfix) with ESMTP id 23E5C318AB;
        Sun, 19 Jan 2020 13:38:48 +0000 (UTC)
Date:   Sun, 19 Jan 2020 13:38:48 +0000 (UTC)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To:     Guenter Roeck <linux@roeck-us.net>
cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Darren Salt <devspam@moreofthesa.me.uk>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        =?ISO-8859-2?Q?Ondrej_=C8erman?= <ocerman@sda1.eu>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Brad Campbell <lists2009@fnarfbargle.com>
Subject: Re: [PATCH v2 0/5] hwmon: k10temp driver improvements
In-Reply-To: <20200118172615.26329-1-linux@roeck-us.net>
Message-ID: <alpine.LRH.2.21.2001191054490.328@diagnostix.dwd.de>
References: <20200118172615.26329-1-linux@roeck-us.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="646810922-1566648493-1579431360=:328"
Content-ID: <alpine.LRH.2.21.2001191327310.2827@diagnostix.dwd.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646810922-1566648493-1579431360=:328
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LRH.2.21.2001191327311.2827@diagnostix.dwd.de>

On Sat, 18 Jan 2020, Guenter Roeck wrote:

> This patch series implements various improvements for the k10temp driver.
> 
> Patch 1/5 introduces the use of bit operations.
> 
> Patch 2/5 converts the driver to use the devm_hwmon_device_register_with_info
> API. This not only simplifies the code and reduces its size, it also
> makes the code easier to maintain and enhance. 
> 
> Patch 3/5 adds support for reporting Core Complex Die (CCD) temperatures
> on Ryzen 3 (Zen2) CPUs.
> 
> Patch 4/5 adds support for reporting core and SoC current and voltage
> information on Ryzen CPUs.
> 
> Patch 5/5 removes the maximum temperature from Tdie for Ryzen CPUs.
> It is inaccurate, misleading, and it just doesn't make sense to report
> wrong information.
> 
> With all patches in place, output on Ryzen 3900X CPUs looks as follows
> (with the system under load).
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.36 V
> Vsoc:         +1.18 V
> Tdie:         +86.8°C
> Tctl:         +86.8°C
> Tccd1:        +80.0°C
> Tccd2:        +81.8°C
> Icore:       +44.14 A
> Isoc:        +13.83 A
> 
> The voltage and current information is limited to Ryzen CPUs. Voltage
> and current reporting on Threadripper and EPYC CPUs is different, and the
> reported information is either incomplete or wrong. Exclude it for the time
> being; it can always be added if/when more information becomes available.
> 
> Tested with the following Ryzen CPUs:
>     1300X A user with this CPU in the system reported somewhat unexpected
>           values for Vcore; it isn't entirely if at all clear why that is
>           the case. Overall this does not warrant holding up the series.
>     1600
>     1800X
>     2200G
>     2400G
>     3800X
>     3900X
>     3950X
> 
> v2: Added tested-by: tags as received.
>     Don't display voltage and current information for Threadripper and EPYC.
>     Stop displaying the fixed (and wrong) maximum temperature of 70 degrees C
>     for Tdie on model 17h/18h CPUs.
> 
Just tested this on a 2400G. Here idle values:

   k10temp-pci-00c3
   Adapter: PCI adapter
   Vcore:        +0.77 V
   Vsoc:         +1.11 V
   Tdie:         +45.0°C
   Tctl:         +45.0°C
   Icore:       +10.39 A
   Isoc:         +2.89 A

   nvme-pci-0100
   Adapter: PCI adapter
   Composite:    +43.9°C  (low  = -273.1°C, high = +80.8°C)
                          (crit = +80.8°C)
   Sensor 1:     +43.9°C  (low  = -273.1°C, high = +65261.8°C)
   Sensor 2:     +48.9°C  (low  = -273.1°C, high = +65261.8°C)

   nct6793-isa-0290
   Adapter: ISA adapter
   in0:                    +0.35 V  (min =  +0.00 V, max =  +1.74 V)
   in1:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in2:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in6:                    +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in9:                    +1.83 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in10:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in12:                   +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in14:                   +0.21 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   fan1:                     0 RPM  (min =    0 RPM)
   fan2:                   323 RPM  (min =    0 RPM)
   fan3:                     0 RPM  (min =    0 RPM)
   fan4:                     0 RPM  (min =    0 RPM)
   fan5:                     0 RPM  (min =    0 RPM)
   SYSTIN:                +112.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
   CPUTIN:                 +60.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
   AUXTIN0:                +46.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
   AUXTIN1:               +106.0°C    sensor = thermistor
   AUXTIN2:               +105.0°C    sensor = thermistor
   AUXTIN3:               +102.0°C    sensor = thermistor
   SMBUSMASTER 0:          +45.0°C
   PCH_CHIP_CPU_MAX_TEMP:   +0.0°C
   PCH_CHIP_TEMP:           +0.0°C
   PCH_CPU_TEMP:            +0.0°C
   intrusion0:            OK
   intrusion1:            ALARM
   beep_enable:           disabled

   amdgpu-pci-0300
   Adapter: PCI adapter
   vddgfx:           N/A
   vddnb:            N/A
   edge:         +45.0°C  (crit = +80.0°C, hyst =  +0.0°C)

And here with some high load:

   k10temp-pci-00c3
   Adapter: PCI adapter
   Vcore:        +1.32 V
   Vsoc:         +1.11 V
   Tdie:         +77.1°C
   Tctl:         +77.1°C
   Icore:       +85.22 A
   Isoc:         +3.61 A

   nvme-pci-0100
   Adapter: PCI adapter
   Composite:    +42.9°C  (low  = -273.1°C, high = +80.8°C)
                          (crit = +80.8°C)
   Sensor 1:     +42.9°C  (low  = -273.1°C, high = +65261.8°C)
   Sensor 2:     +45.9°C  (low  = -273.1°C, high = +65261.8°C)

   nct6793-isa-0290
   Adapter: ISA adapter
   in0:                    +0.68 V  (min =  +0.00 V, max =  +1.74 V)
   in1:                    +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in2:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in6:                    +0.66 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in9:                    +1.83 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in10:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in12:                   +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   in14:                   +0.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
   fan1:                     0 RPM  (min =    0 RPM)
   fan2:                  1931 RPM  (min =    0 RPM)
   fan3:                     0 RPM  (min =    0 RPM)
   fan4:                     0 RPM  (min =    0 RPM)
   fan5:                     0 RPM  (min =    0 RPM)
   SYSTIN:                +113.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
   CPUTIN:                 +64.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
   AUXTIN0:                +45.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
   AUXTIN1:               +107.0°C    sensor = thermistor
   AUXTIN2:               +105.0°C    sensor = thermistor
   AUXTIN3:               +102.0°C    sensor = thermistor
   SMBUSMASTER 0:          +77.0°C
   PCH_CHIP_CPU_MAX_TEMP:   +0.0°C
   PCH_CHIP_TEMP:           +0.0°C
   PCH_CPU_TEMP:            +0.0°C
   intrusion0:            OK
   intrusion1:            ALARM
   beep_enable:           disabled

   amdgpu-pci-0300
   Adapter: PCI adapter
   vddgfx:           N/A
   vddnb:            N/A
   edge:         +77.0°C  (crit = +80.0°C, hyst =  +0.0°C)

Have also tried this on a EPYC 7302. Before the patch:

   k10temp-pci-00c3
   Adapter: PCI adapter
   Tdie:         +28.1°C  (high = +70.0°C)
   Tctl:         +28.1°C 

and after:

   k10temp-pci-00c3
   Adapter: PCI adapter
   Tdie:         +28.2°C  
   Tctl:         +28.2°C

No extra values shown, but I think this is expected.

Tested-by Holger Kiehl <holger.kiehl@dwd.de>

Holger
--646810922-1566648493-1579431360=:328--
