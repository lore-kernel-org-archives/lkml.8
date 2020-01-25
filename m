Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 662BEC2D0DB
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E60C2071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 17:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727215AbgAYRkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 12:40:33 -0500
Received: from ofcsgdbm.dwd.de ([141.38.3.245]:56869 "EHLO ofcsgdbm.dwd.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726448AbgAYRkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 12:40:32 -0500
Received: from localhost (localhost [127.0.0.1])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 484jvt0WdTz11bP
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 17:40:26 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at csg.dwd.de
Received: from ofcsg2dn3.dwd.de ([127.0.0.1])
        by localhost (ofcsg2dn3.dwd.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 9ZzvRtyMCdLW for <linux-kernel@vger.kernel.org>;
        Sat, 25 Jan 2020 17:40:25 +0000 (UTC)
Received: from ofmailhub.dwd.de (oflxs446.dwd.de [141.38.40.78])
        by ofcsg2dn3.dwd.de (Postfix) with ESMTP id 484jvs4Hdsz11Y9;
        Sat, 25 Jan 2020 17:40:25 +0000 (UTC)
Received: from diagnostix.dwd.de (diagnostix.dwd.de [141.38.42.141])
        by ofmailhub.dwd.de (Postfix) with ESMTP id 136DC1A160;
        Sat, 25 Jan 2020 17:40:24 +0000 (UTC)
Date:   Sat, 25 Jan 2020 17:40:24 +0000 (UTC)
From:   Holger Kiehl <Holger.Kiehl@dwd.de>
X-X-Sender: kiehl@diagnostix.dwd.de
To:     Guenter Roeck <linux@roeck-us.net>
cc:     linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Clemens Ladisch <clemens@ladisch.de>,
        Jean Delvare <jdelvare@suse.com>,
        Brad Campbell <lists2009@fnarfbargle.com>,
        =?ISO-8859-2?Q?Ondrej_=C8erman?= <ocerman@sda1.eu>,
        Bernhard Gebetsberger <bernhard.gebetsberger@gmx.at>,
        Michael Larabel <michael@phoronix.com>,
        Jonathan McDowell <noodles@earth.li>,
        Ken Moffat <zarniwhoop73@googlemail.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Darren Salt <devspam@moreofthesa.me.uk>
Subject: Re: [PATCH v4 0/6] hwmon: k10temp driver improvements
In-Reply-To: <20200122160800.12560-1-linux@roeck-us.net>
Message-ID: <alpine.LRH.2.21.2001251735570.13252@diagnostix.dwd.de>
References: <20200122160800.12560-1-linux@roeck-us.net>
User-Agent: Alpine 2.21 (LRH 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="646810922-1630687333-1579974025=:13252"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--646810922-1630687333-1579974025=:13252
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 22 Jan 2020, Guenter Roeck wrote:

> This patch series implements various improvements for the k10temp driver.
> 
> Patch 1/6 introduces the use of bit operations.
> 
> Patch 2/6 converts the driver to use the devm_hwmon_device_register_with_info
> API. This not only simplifies the code and reduces its size, it also
> makes the code easier to maintain and enhance. 
> 
> Patch 3/6 adds support for reporting Core Complex Die (CCD) temperatures
> on Zen2 (Ryzen and Threadripper) CPUs (note that reporting is incomplete
> for Threadripper CPUs - it is known that additional temperature sensors
> exist, but the register locations are unknown).
> 
> Patch 4/6 adds support for reporting core and SoC current and voltage
> information on Ryzen CPUs (note: voltage and current measurements for
> Threadripper and EPYC CPUs are known to exist, but register locations
> are unknown, and values are therefore not reported at this time).
> 
> Patch 5/6 removes the maximum temperature from Tdie for Ryzen CPUs.
> It is inaccurate, misleading, and it just doesn't make sense to report
> wrong information.
> 
> Patch 6/6 adds debugfs files to provide raw thermal and SVI register
> dumps. This may help in the future to identify additional sensors and/or
> to fix problems.
> 
> With all patches in place, output on Ryzen 3900X CPUs looks as follows
> (with the system under load).
> 
> k10temp-pci-00c3
> Adapter: PCI adapter
> Vcore:        +1.39 V
> Vsoc:         +1.18 V
> Tdie:         +79.9°C
> Tctl:         +79.9°C
> Tccd1:        +61.8°C
> Tccd2:        +76.5°C
> Icore:       +46.00 A
> Isoc:        +12.00 A
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
>     2700
>     2700X
>     2950X
>     3600X
>     3800X
>     3900X
>     3950X
>     3970X
>     EPYC 7302
>     EPYC 7742
> 
Below some more testing on two Deskmini A300. One with a 2400G and
the other 3400G. Both have the same bios and board.

Regards,
Holger


Deskmini A300 Ryzen 5 2400G

Idle:
=====
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/thm
0x059800: 2c800fef 00ff1001 00002921 000f4240 
0x059810: 800000f9 00000000 00000000 00000000 
0x059820: 00000000 00000000 00000000 0fff0078 
0x059830: 00000000 002ead28 002ead28 002e6d26 
0x059840: 002e8d27 002ded23 002e8d27 002f0d2b 
0x059850: 002d6d1f 002dcd22 002dcd22 002ecd29 
0x059860: 002d6d1f 002e8d27 002ded23 002e4d25 
0x059870: 002e6d26 002e4d25 002e4d25 002ead28 
0x059880: 002e0d24 002ead28 002d4d1e 002d8d20 
0x059890: 002dcd22 002e6d26 002e6d26 002d8d20 
0x0598a0: 002dcd22 002dcd22 002ded23 002d4d1e 
0x0598b0: 002e4d25 00000000 00002100 ffffffff 
0x0598c0: 00000000 00000000 00000000 00000000 
0x0598d0: 00000000 00000000 00000000 00000000 
0x0598e0: 00000000 00000000 00000000 00000000 
0x0598f0: 00000000 00000000 00000000 00000000 
0x059900: 00000000 00000000 00000000 00000000 
0x059910: 00000000 00000000 00000000 00000000 
0x059920: 00000000 00000000 00000000 00000000 
0x059930: 00000000 00000000 00000000 00000000 
0x059940: 00000000 00000000 00000000 00000000 
0x059950: 00000000 00000000 00000000 00000000 
0x059960: 00000000 08400001 0000582c 0000004e 
0x059970: c0800005 30c8680e 00024068 00000000 
0x059980: 00000000 00000000 00000000 00000000 
0x059990: 00000000 00000000 00000000 00000000 
0x0599a0: 00000000 00000000 00000000 00000000 
0x0599b0: 00000000 00000000 00000000 00000000 
0x0599c0: 00000060 000002f0 00000006 000002d4 
0x0599d0: 00000015 00000000 00000000 000002f0 
0x0599e0: 00000006 00000000 00000000 00000001 
0x0599f0: 00000000 00010003 00000000 00000000 
0x059a00: 00000000 00000000 00000000 00000000 
0x059a10: 0000000e 00000000 00000003 00000000 
0x059a20: 001f001a 00050003 00000000 00000000 
0x059a30: 00df0010 00000000 00000000 00000000 
0x059a40: 00000000 00000000 00000007 000000fe 
0x059a50: 00000000 00000000 00000000 00000000 
0x059a60: 00000000 00130082 0000063f 12110201 
0x059a70: 0003005a 00001303 00000000 028a4f5c 
0x059a80: 08036927 0021e548 00000000 7fffffff 
0x059a90: 00000000 00000043 c00001c0 000000f9 
0x059aa0: 00000000 00000000 00000000 00000000 
0x059ab0: 00000000 00000000 00000000 00000000 
0x059ac0: 00000000 00000000 00000000 00000000 
0x059ad0: 00000000 00000000 00000000 00000000 
0x059ae0: 00000000 00000000 00000000 00000000 
0x059af0: 00000000 00000000 00000000 00000000 
0x059b00: 00000000 00000000 00000000 00000000 
0x059b10: 00000000 00000000 00000000 00000000 
0x059b20: 00000000 00000000 00000000 00000000 
0x059b30: 00000000 00000000 00000000 00000000 
0x059b40: 00000000 00000000 00000000 00000000 
0x059b50: 00000000 00000000 00000000 00000000 
0x059b60: 00000000 00000000 00000000 00000000 
0x059b70: 00000000 00000000 00000000 00000000 
0x059b80: 00000000 00000000 00000000 00000000 
0x059b90: 00000000 00000000 00000000 00000000 
0x059ba0: 00000000 00000000 00000000 00000000 
0x059bb0: 00000000 00000000 00000000 00000000 
0x059bc0: 00000000 00000000 00000000 00000000 
0x059bd0: 00000000 00000000 00000000 00000000 
0x059be0: 00000000 00000000 00000000 00000000 
0x059bf0: 00000000 00000000 00000000 00000000
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/svi 
0x05a000: 0000000e 0000002e 00000002 017d0013 
0x05a010: 01490011 00000000 0000000e 00000000 
0x05a020: 00000000 80000000 00000000 007a0000 
0x05a030: 00000000 00000000 00000021 00000000 
0x05a040: 00000000 00000000 00000000 7a000000 
0x05a050: 68000000 48000000 00000000 0000030a 
0x05a060: 00000007 00000000 80000002 80000002 
0x05a070: 80000041 00000001 00000008 00000000

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +0.77 V  
Vsoc:         +1.09 V  
Tdie:         +44.5°C  
Tctl:         +44.5°C  
Icore:       +21.00 A  
Isoc:         +4.00 A  

nvme-pci-0100
Adapter: PCI adapter
Composite:    +41.9°C  (low  = -273.1°C, high = +80.8°C)
                       (crit = +80.8°C)
Sensor 1:     +41.9°C  (low  = -273.1°C, high = +65261.8°C)
Sensor 2:     +44.9°C  (low  = -273.1°C, high = +65261.8°C)

nct6793-isa-0290
Adapter: ISA adapter
in0:                    +0.42 V  (min =  +0.00 V, max =  +1.74 V)
in1:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                    +0.67 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                    +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                   +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                   +0.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:                     0 RPM  (min =    0 RPM)
fan2:                   320 RPM  (min =    0 RPM)
fan3:                     0 RPM  (min =    0 RPM)
fan4:                     0 RPM  (min =    0 RPM)
fan5:                     0 RPM  (min =    0 RPM)
SYSTIN:                +113.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
CPUTIN:                 +59.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN0:                +45.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
AUXTIN1:               +106.0°C    sensor = thermistor
AUXTIN2:               +105.0°C    sensor = thermistor
AUXTIN3:               +102.0°C    sensor = thermistor
SMBUSMASTER 0:          +44.5°C  
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
edge:         +44.0°C  (crit = +80.0°C, hyst =  +0.0°C)


Load:
=====
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/thm
0x059800: 4b400fef 00ff1001 00002921 000f4240 
0x059810: 800000f9 00000000 00000000 00000000 
0x059820: 00000000 00000000 00000000 0fff0078 
0x059830: 00000000 0034ad58 00308d37 0031ed42 
0x059840: 0035ed62 00350d5b 00344d55 00378d6f 
0x059850: 00308d37 0030cd39 00328d47 0031cd41 
0x059860: 0030ad38 00318d3f 002fcd31 0030cd39 
0x059870: 00312d3c 00322d44 00376d6e 00376d6e 
0x059880: 00322d44 00378d6f 00324d45 00342d54 
0x059890: 0037ad70 00336d4e 00350d5b 003dcda1 
0x0598a0: 003dcda1 003acd89 003e2da4 00366d66 
0x0598b0: 0035cd61 00000000 00002100 ffffffff 
0x0598c0: 00000000 00000000 00000000 00000000 
0x0598d0: 00000000 00000000 00000000 00000000 
0x0598e0: 00000000 00000000 00000000 00000000 
0x0598f0: 00000000 00000000 00000000 00000000 
0x059900: 00000000 00000000 00000000 00000000 
0x059910: 00000000 00000000 00000000 00000000 
0x059920: 00000000 00000000 00000000 00000000 
0x059930: 00000000 00000000 00000000 00000000 
0x059940: 00000000 00000000 00000000 00000000 
0x059950: 00000000 00000000 00000000 00000000 
0x059960: 00000000 08400001 0000944a 0000004f 
0x059970: c0800005 30c8680e 00024068 00000000 
0x059980: 00000000 00000000 00000000 00000000 
0x059990: 00000000 00000000 00000000 00000000 
0x0599a0: 00000000 00000000 00000000 00000000 
0x0599b0: 00000000 00000000 00000000 00000000 
0x0599c0: 00000060 000003e2 0000001d 000002fc 
0x0599d0: 0000000d 00000000 00000000 000003e2 
0x0599e0: 0000001d 00000000 00000000 00000001 
0x0599f0: 00000000 00010003 00000000 00000000 
0x059a00: 00000000 00000000 00000000 00000000 
0x059a10: 0000000e 00000000 00000003 00000000 
0x059a20: 001f001a 00050003 00000000 00000000 
0x059a30: 00df0001 00000000 00000000 00000000 
0x059a40: 00000000 00000000 00000007 000000fe 
0x059a50: 00000000 00000000 00000000 00000000 
0x059a60: 00000000 00130082 0000063f 12110201 
0x059a70: 0003005a 00001303 00000000 028a4f5c 
0x059a80: 08036927 0021e548 00000000 7fffffff 
0x059a90: 00000000 00000043 c00001c0 000000f9 
0x059aa0: 00000000 00000000 00000000 00000000 
0x059ab0: 00000000 00000000 00000000 00000000 
0x059ac0: 00000000 00000000 00000000 00000000 
0x059ad0: 00000000 00000000 00000000 00000000 
0x059ae0: 00000000 00000000 00000000 00000000 
0x059af0: 00000000 00000000 00000000 00000000 
0x059b00: 00000000 00000000 00000000 00000000 
0x059b10: 00000000 00000000 00000000 00000000 
0x059b20: 00000000 00000000 00000000 00000000 
0x059b30: 00000000 00000000 00000000 00000000 
0x059b40: 00000000 00000000 00000000 00000000 
0x059b50: 00000000 00000000 00000000 00000000 
0x059b60: 00000000 00000000 00000000 00000000 
0x059b70: 00000000 00000000 00000000 00000000 
0x059b80: 00000000 00000000 00000000 00000000 
0x059b90: 00000000 00000000 00000000 00000000 
0x059ba0: 00000000 00000000 00000000 00000000 
0x059bb0: 00000000 00000000 00000000 00000000 
0x059bc0: 00000000 00000000 00000000 00000000 
0x059bd0: 00000000 00000000 00000000 00000000 
0x059be0: 00000000 00000000 00000000 00000000 
0x059bf0: 00000000 00000000 00000000 00000000
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/svi
0x05a000: 0000000e 0000002e 00000002 01220067 
0x05a010: 01490013 00000000 0000000e 00000000 
0x05a020: 00000000 00000000 00000000 00150000 
0x05a030: 00000000 00000000 00000021 00000000 
0x05a040: 00000000 00000000 00000000 15000000 
0x05a050: 68000000 48000000 00000000 0000030a 
0x05a060: 00000007 00000000 80000002 80000002 
0x05a070: 80000041 00000001 00000008 00000000

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.32 V  
Vsoc:         +1.10 V  
Tdie:         +74.8°C  
Tctl:         +74.8°C  
Icore:       +99.00 A  
Isoc:         +5.00 A  

nvme-pci-0100
Adapter: PCI adapter
Composite:    +41.9°C  (low  = -273.1°C, high = +80.8°C)
                       (crit = +80.8°C)
Sensor 1:     +41.9°C  (low  = -273.1°C, high = +65261.8°C)
Sensor 2:     +44.9°C  (low  = -273.1°C, high = +65261.8°C)

nct6793-isa-0290
Adapter: ISA adapter
in0:                    +0.68 V  (min =  +0.00 V, max =  +1.74 V)
in1:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                    +0.67 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                    +1.84 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                   +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                   +0.20 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:                     0 RPM  (min =    0 RPM)
fan2:                  1934 RPM  (min =    0 RPM)
fan3:                     0 RPM  (min =    0 RPM)
fan4:                     0 RPM  (min =    0 RPM)
fan5:                     0 RPM  (min =    0 RPM)
SYSTIN:                +113.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
CPUTIN:                 +63.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN0:                +45.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
AUXTIN1:               +106.0°C    sensor = thermistor
AUXTIN2:               +105.0°C    sensor = thermistor
AUXTIN3:               +103.0°C    sensor = thermistor
SMBUSMASTER 0:          +74.5°C  
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
edge:         +74.0°C  (crit = +80.0°C, hyst =  +0.0°C)

-------------------------------------------------------------------------------
Deskmini A300 Ryzen 5 3400G

Idle:
=====
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/thm
0x059800: 25800fef 00ff1001 00002921 000f4240 
0x059810: 800000f9 00000000 00000000 00000000 
0x059820: 00000000 00000000 00000000 0fff0078 
0x059830: 00000000 002aed0d 002aad0b 002a4d08 
0x059840: 002a6d09 002acd0c 002a6d09 002aad0b 
0x059850: 002a6d09 002a6d09 002a6d09 002a8d0a 
0x059860: 002aad0b 002a8d0a 002a4d08 002a2d07 
0x059870: 002a8d0a 002a6d09 002ac000 002b2000 
0x059880: 002ac000 002a6000 002ac000 002ac000 
0x059890: 002b0000 002aa000 002ac000 002aa000 
0x0598a0: 002a8000 002a6000 002a2000 002a6000 
0x0598b0: 002a4000 00000000 00002100 ffffffff 
0x0598c0: 00000000 00000000 00000000 00000000 
0x0598d0: 00000000 00000000 00000000 00000000 
0x0598e0: 00000000 00000000 00000000 00000000 
0x0598f0: 00000000 00000000 00000000 00000000 
0x059900: 00000000 00000000 00000000 00000000 
0x059910: 00000000 00000000 00000000 00000000 
0x059920: 00000000 00000000 00000000 00000000 
0x059930: 00000000 00000000 00000000 00000000 
0x059940: 00000000 00000000 00000000 00000000 
0x059950: 00000000 00000000 00000000 00000000 
0x059960: 00000000 08400001 00004a25 00000047 
0x059970: c0800005 30c8680e 00024068 00000000 
0x059980: 00000000 00000000 00000000 00000000 
0x059990: 00000000 00000000 00000000 00000000 
0x0599a0: 00000000 00000000 00000000 00000000 
0x0599b0: 00000000 00000000 00000000 00000000 
0x0599c0: 00000060 000002b4 00000012 0000029c 
0x0599d0: 00000007 00000000 00000000 000002b4 
0x0599e0: 00000012 00000000 00000000 00000001 
0x0599f0: 00000000 00010003 00000000 00000000 
0x059a00: 00000000 00000000 00000000 00000000 
0x059a10: 0000000e 00000000 00000003 00000000 
0x059a20: 001f001a 00050003 00000000 00000000 
0x059a30: 000b0010 00000000 00000000 00000000 
0x059a40: 00000000 00000000 00000007 000000fe 
0x059a50: 00000000 00000000 00000000 00000000 
0x059a60: 00000000 00130082 0000063f 12110201 
0x059a70: 0003005a 00001303 00000000 028a4f5c 
0x059a80: 08036927 0021e548 00000000 7fffffff 
0x059a90: 00000000 00000043 c00001c0 800000f9 
0x059aa0: 00000000 00000000 00000000 00000000 
0x059ab0: 00000000 00000000 00000000 00000000 
0x059ac0: 00000000 00000000 00000000 00000000 
0x059ad0: 00000000 00000000 00000000 00000000 
0x059ae0: 00000000 00000000 00000000 00000000 
0x059af0: 00000000 00000000 00000000 00000000 
0x059b00: 00000000 00000000 00000000 00000000 
0x059b10: 00000000 00000000 00000000 00000000 
0x059b20: 00000000 00000000 00000000 00000000 
0x059b30: 00000000 00000000 00000000 00000000 
0x059b40: 00000000 00000000 00000000 00000000 
0x059b50: 00000000 00000000 00000000 00000000 
0x059b60: 00000000 00000000 00000000 00000000 
0x059b70: 00000000 00000000 00000000 00000000 
0x059b80: 00000000 00000000 00000000 00000000 
0x059b90: 00000000 00000000 00000000 00000000 
0x059ba0: 00000000 00000000 00000000 00000000 
0x059bb0: 00000000 00000000 00000000 00000000 
0x059bc0: 00000000 00000000 00000000 00000000 
0x059bd0: 00000000 00000000 00000000 00000000 
0x059be0: 00000000 00000000 00000000 00000000 
0x059bf0: 00000000 00000000 00000000 00000000
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/svi 
0x05a000: 0000000e 0000002e 00000002 018b0013 
0x05a010: 017d000e 00000000 0000000e 00000000 
0x05a020: 00000000 80000000 00000000 00890000 
0x05a030: 00000000 00000000 00000021 00000000 
0x05a040: 00000000 00000000 00000000 89000000 
0x05a050: 68000000 7c000000 00000000 0000030a 
0x05a060: 00000007 00000000 80000002 80000002 
0x05a070: 80000041 00000001 00000008 00000000

nct6793-isa-0290
Adapter: ISA adapter
in0:                    +2.04 V  (min =  +0.00 V, max =  +1.74 V)  ALARM
in1:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                    +0.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                    +0.75 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                   +0.18 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                   +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                   +1.71 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:                     0 RPM  (min =    0 RPM)
fan2:                   316 RPM  (min =    0 RPM)
fan3:                     0 RPM  (min =    0 RPM)
fan4:                     0 RPM  (min =    0 RPM)
fan5:                     0 RPM  (min =    0 RPM)
SYSTIN:                +115.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
CPUTIN:                 +46.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN0:                +40.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
AUXTIN1:               +108.0°C    sensor = thermistor
AUXTIN2:               +107.0°C    sensor = thermistor
AUXTIN3:               +106.0°C    sensor = thermistor
SMBUSMASTER 0:          +42.5°C  
PCH_CHIP_CPU_MAX_TEMP:   +0.0°C  
PCH_CHIP_TEMP:           +0.0°C  
PCH_CPU_TEMP:            +0.0°C  
intrusion0:            OK
intrusion1:            ALARM
beep_enable:           disabled

amdgpu-pci-0400
Adapter: PCI adapter
vddgfx:           N/A  
vddnb:            N/A  
edge:         +42.0°C  (crit = +80.0°C, hyst =  +0.0°C)

nvme-pci-0200
Adapter: PCI adapter
Composite:    +35.9°C  (low  = -273.1°C, high = +80.8°C)
                       (crit = +80.8°C)
Sensor 1:     +35.9°C  (low  = -273.1°C, high = +65261.8°C)
Sensor 2:     +37.9°C  (low  = -273.1°C, high = +65261.8°C)

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +0.69 V  
Vsoc:         +0.78 V  
Tdie:         +42.1°C  
Tctl:         +42.1°C  
Icore:       +24.00 A  
Isoc:         +4.00 A  

nvme-pci-0100
Adapter: PCI adapter
Composite:    +36.9°C  (low  = -273.1°C, high = +80.8°C)
                       (crit = +80.8°C)
Sensor 1:     +36.9°C  (low  = -273.1°C, high = +65261.8°C)
Sensor 2:     +39.9°C  (low  = -273.1°C, high = +65261.8°C)


Load:
=====
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/thm
0x059800: 46e00fef 00ff1001 00002921 000f4240 
0x059810: 800000f9 00000000 00000000 00000000 
0x059820: 00000000 00000000 00000000 0fff0078 
0x059830: 00000000 0033ad52 0030cd3b 00312d3e 
0x059840: 00350d5d 00346d58 0033ad52 0035cd63 
0x059850: 002f6d30 00300d35 00322d46 0030ed3c 
0x059860: 00300d35 0031ed44 002f8d31 00302d36 
0x059870: 00300d35 0031cd43 0035cd63 00366d68 
0x059880: 00320d45 00360d65 00320d45 00336d50 
0x059890: 00364d67 00328d49 00342d56 003b2d8e 
0x0598a0: 003c0d95 003aad8a 003aed8c 0035ad62 
0x0598b0: 00350d5d 00000000 00002100 ffffffff 
0x0598c0: 00000000 00000000 00000000 00000000 
0x0598d0: 00000000 00000000 00000000 00000000 
0x0598e0: 00000000 00000000 00000000 00000000 
0x0598f0: 00000000 00000000 00000000 00000000 
0x059900: 00000000 00000000 00000000 00000000 
0x059910: 00000000 00000000 00000000 00000000 
0x059920: 00000000 00000000 00000000 00000000 
0x059930: 00000000 00000000 00000000 00000000 
0x059940: 00000000 00000000 00000000 00000000 
0x059950: 00000000 00000000 00000000 00000000 
0x059960: 00000000 08400001 00008e47 00000049 
0x059970: c0800005 30c8680e 00024068 00000000 
0x059980: 00000000 00000000 00000000 00000000 
0x059990: 00000000 00000000 00000000 00000000 
0x0599a0: 00000000 00000000 00000000 00000000 
0x0599b0: 00000000 00000000 00000000 00000000 
0x0599c0: 00000060 000003c0 0000001b 000002f6 
0x0599d0: 00000007 00000000 00000000 000003c0 
0x0599e0: 0000001b 00000000 00000000 00000001 
0x0599f0: 00000000 00010003 00000000 00000000 
0x059a00: 00000000 00000000 00000000 00000000 
0x059a10: 0000000e 00000000 00000003 00000000 
0x059a20: 001f001a 00050003 00000000 00000000 
0x059a30: 000b0010 00000000 00000000 00000000 
0x059a40: 00000000 00000000 00000007 000000fe 
0x059a50: 00000000 00000000 00000000 00000000 
0x059a60: 00000000 00130082 0000063f 12110201 
0x059a70: 0003005a 00001303 00000000 028a4f5c 
0x059a80: 08036927 0021e548 00000000 7fffffff 
0x059a90: 00000000 00000043 c00001c0 000000f9 
0x059aa0: 00000000 00000000 00000000 00000000 
0x059ab0: 00000000 00000000 00000000 00000000 
0x059ac0: 00000000 00000000 00000000 00000000 
0x059ad0: 00000000 00000000 00000000 00000000 
0x059ae0: 00000000 00000000 00000000 00000000 
0x059af0: 00000000 00000000 00000000 00000000 
0x059b00: 00000000 00000000 00000000 00000000 
0x059b10: 00000000 00000000 00000000 00000000 
0x059b20: 00000000 00000000 00000000 00000000 
0x059b30: 00000000 00000000 00000000 00000000 
0x059b40: 00000000 00000000 00000000 00000000 
0x059b50: 00000000 00000000 00000000 00000000 
0x059b60: 00000000 00000000 00000000 00000000 
0x059b70: 00000000 00000000 00000000 00000000 
0x059b80: 00000000 00000000 00000000 00000000 
0x059b90: 00000000 00000000 00000000 00000000 
0x059ba0: 00000000 00000000 00000000 00000000 
0x059bb0: 00000000 00000000 00000000 00000000 
0x059bc0: 00000000 00000000 00000000 00000000 
0x059bd0: 00000000 00000000 00000000 00000000 
0x059be0: 00000000 00000000 00000000 00000000 
0x059bf0: 00000000 00000000 00000000 00000000
cat /sys/kernel/debug/k10temp-0000\:00\:18.3/svi
0x05a000: 0000000e 0000002e 00000002 012e0078 
0x05a010: 01490019 00000000 0000000e 00000000 
0x05a020: 00000000 00000000 00000000 00210000 
0x05a030: 00000000 00000000 00000021 00000000 
0x05a040: 00000000 00000000 00000000 21000000 
0x05a050: 68000000 48000000 00000000 0000030a 
0x05a060: 00000007 00000000 00000002 80000002 
0x05a070: 80000041 00000001 00000008 00000000

nct6793-isa-0290
Adapter: ISA adapter
in0:                    +0.66 V  (min =  +0.00 V, max =  +1.74 V)
in1:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in2:                    +3.41 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in3:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in4:                    +0.25 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in5:                    +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in6:                    +0.75 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in7:                    +3.39 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in8:                    +3.26 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in9:                    +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in10:                   +0.18 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in11:                   +0.14 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in12:                   +1.85 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in13:                   +1.72 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
in14:                   +0.19 V  (min =  +0.00 V, max =  +0.00 V)  ALARM
fan1:                     0 RPM  (min =    0 RPM)
fan2:                  1797 RPM  (min =    0 RPM)
fan3:                     0 RPM  (min =    0 RPM)
fan4:                     0 RPM  (min =    0 RPM)
fan5:                     0 RPM  (min =    0 RPM)
SYSTIN:                +115.0°C  (high =  +0.0°C, hyst =  +0.0°C)  sensor = thermistor
CPUTIN:                 +57.0°C  (high = +80.0°C, hyst = +75.0°C)  sensor = thermistor
AUXTIN0:                +39.0°C  (high =  +0.0°C, hyst =  +0.0°C)  ALARM  sensor = thermistor
AUXTIN1:               +108.0°C    sensor = thermistor
AUXTIN2:               +107.0°C    sensor = thermistor
AUXTIN3:               +106.0°C    sensor = thermistor
SMBUSMASTER 0:          +71.0°C  
PCH_CHIP_CPU_MAX_TEMP:   +0.0°C  
PCH_CHIP_TEMP:           +0.0°C  
PCH_CPU_TEMP:            +0.0°C  
intrusion0:            OK
intrusion1:            ALARM
beep_enable:           disabled

amdgpu-pci-0400
Adapter: PCI adapter
vddgfx:           N/A  
vddnb:            N/A  
edge:         +71.0°C  (crit = +80.0°C, hyst =  +0.0°C)

nvme-pci-0200
Adapter: PCI adapter
Composite:    +35.9°C  (low  = -273.1°C, high = +80.8°C)
                       (crit = +80.8°C)
Sensor 1:     +35.9°C  (low  = -273.1°C, high = +65261.8°C)
Sensor 2:     +37.9°C  (low  = -273.1°C, high = +65261.8°C)

k10temp-pci-00c3
Adapter: PCI adapter
Vcore:        +1.26 V  
Vsoc:         +1.09 V  
Tdie:         +71.0°C  
Tctl:         +71.0°C  
Icore:       +119.00 A  
Isoc:         +6.50 A  

nvme-pci-0100
Adapter: PCI adapter
Composite:    +36.9°C  (low  = -273.1°C, high = +80.8°C)
                       (crit = +80.8°C)
Sensor 1:     +36.9°C  (low  = -273.1°C, high = +65261.8°C)
Sensor 2:     +39.9°C  (low  = -273.1°C, high = +65261.8°C)
--646810922-1630687333-1579974025=:13252--
