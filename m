Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65064C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7174D2073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 09:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="Jt5xtb2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgBLJfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 04:35:03 -0500
Received: from scoopta.email ([198.58.106.30]:35250 "EHLO scoopta.email"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728626AbgBLJfC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 04:35:02 -0500
DKIM-Signature: a=rsa-sha256; b=Jt5xtb2o8MzknWh7lQJl3mRgNFgWjptTNG5PgvT0EjFwp08XiK/n27hysQem0EOPgQcORULnGlEc/v9yVNid1dML8QEiV0Fv07iLHUpzy6HQH+SeuCEuxF8a23GdLn5YM2FNplCs38bHAtTGiYxJ6pn9h6cYXp0IkHLxA7ZW1XYjyVnvneZdmD+vVwAOOba/fIoXCeHjCfOibfc/99z8HSHOyVrzkGJdb0o/njbNZuWOvVM7gDa3asa7k1OiZbWMWxfeUEWLaRIRaLXzSwSJjn550T5XWFv8MpxAKQ8LPK7NvbhgorlfAz1JvtA9/8vzU4Z70V+Z59+g7P1Bh72CXtk/OdvFTYfk6/rh71rvEqxfs8JOFkhlFhhC0GkyFW7AWTePh5VDgb2pyfbi49d5P+UoqPCzBDubqs4vgKyZO7ZANDbyX7gC6sA6z+tarxlEkfmGwLnYS7r/KT1K+DDtwigGA/7YYaNFnMM3dg2dRYE3enYPj8cJ3A0QHhP7bXbmkwm4BE7EYVAxrO+dUDUJt0Hhe4ajJR9Rk7g0XrH1uocLoSnB3iT+tSRvh9nWnU+eYykbGq3L5exfke06ic594686jw4CU8vaHbsz26tuB2OK0nj14z8w3saAYo01TGQHtymx2YQ9r4tyTIA8/uHsOIRTVA2vsHbKWviDMs97cfW5u0t4kXv+HehUuTqZeVm51nUGKF3ZOLqJu8FnMUwjVzPK4X3JPAKPdl72oj/CGUmuC1UvDLEsY5zbdnPuQJoN+b/dckLnRX1S1YBBiMMgJjkxHGikevfIXd2kxAVxJcjKIgNyf1QD3T4KWciT6y1W/G44wAUoz2+3nnU7j3z3bfHgyaToKdsyrW1wwThp1FL4CLEC/bjSxPuR/dwC5L3bAN4+g4JyVtsL3O0G7rKir3+2yofp4Uwye/JeC3Ho3pV6kqiz6OOdka1htkKJRrws3B/aS6
 yTgljZ3+jFZCK0aHin2eAOkXjBQfzTQATZJrNN/mTzgIF5un6IvJuE8g6fQGlpJBWKvlMQVNleqazCQQg/DyYaboe2cHgPAnmlL4VVLLWn0gNjI6YywJac3EOxrJlzrMlyeQVyVLbo01lUBqQdGBHceG6KiPivcO0bLSCVgMrI+GAs5dtLrxCSISr19ffp23dMNRPp4i3Gg5CDYRJ8ygPsKtXCghTEbakruM81jNCtP9fbt2zclToiw+74RYP/PcPBJWD5Rra0smWcOdVfoa05tIsHtnGRqjs3lt8uhxevRNUN7Yo1PIt/m1q2zCjy+nxpfeHO6OJVGic+wPhH1pVqyK24rWLn0OJC8TO351cR8gs44OZ5Atn1hRLOyCfl+ma2tzQbRSu65QT67A==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=q85Abpdh0gDj2o7vmaVQN8vOgz4goipRJMB+cajPFG8=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 2600:1700:4810:f9ef:0:0:f0c5:cafe (EHLO [IPv6:2600:1700:4810:f9ef::f0c5:cafe]) ([2600:1700:4810:f9ef:0:0:f0c5:cafe])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID 965073264
          for <linux-kernel@vger.kernel.org>;
          Wed, 12 Feb 2020 01:34:56 -0800 (PST)
Subject: Re: RX 5700 XT Issues
From:   Scoopta <mlist@scoopta.email>
To:     linux-kernel@vger.kernel.org
References: <8e09f86e-b241-971a-ea8c-8948b9e06d20@scoopta.email>
 <3b2eff03-35b0-36f4-21a7-6a117733d4ad@scoopta.email>
Message-ID: <2f5a756d-64d3-800c-499c-8531a6571e3a@scoopta.email>
Date:   Wed, 12 Feb 2020 01:34:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <3b2eff03-35b0-36f4-21a7-6a117733d4ad@scoopta.email>
Content-Type: multipart/mixed;
 boundary="------------4AD4ADC6047E5DD0B183146A"
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------4AD4ADC6047E5DD0B183146A
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit

I've attached the dmesg output after the error happens.

On 2/11/20 9:45 PM, Scoopta wrote:
> My previous statement doesn't appear to be correct syslog just wasn't
> being flushed despite doing an REISUB. I'm getting a powerplay error.
> Specifically it seems related to
> https://gitlab.freedesktop.org/drm/amd/issues/900
>
> On 2/11/20 7:13 PM, Scoopta wrote:
>> When playing demanding games my RX 5700 XT will sometimes just stop. All
>> my displays turn off but the system stays responsive. Audio keeps
>> working and I can REISUB no problem, the card just stops. Fans turn off
>> lm-sensors reports N/A as all information on the sensors and my monitors
>> go into power save. syslog is also completely quiet. amdgpu doesn't seem
>> to error or anything so I have no idea how to troubleshoot if this is a
>> hardware issue or if it's a driver issue. I couldn't find a drm or GPU
>> specific list so I'm sending it here. I want to be sure it's not a
>> driver issue or other kernel issue before doing an RMA.
>>

--------------4AD4ADC6047E5DD0B183146A
Content-Type: text/x-log; charset=UTF-8;
 name="amdgpu.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
 filename="amdgpu.log"

[    1.472393] ata1.00: ATA-8: ADATA SX910, 5.0.7b, max UDMA/133
[    1.472394] ata1.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 32), AA
[    1.482353] ata1.00: configured for UDMA/133
[    1.482799] scsi 0:0:0:0: Direct-Access     ATA      ADATA SX910      7b   PQ: 0 ANSI: 5
[    1.500400] usb 3-1: new full-speed USB device number 2 using xhci_hcd
[    1.582909] usb 5-1: New USB device found, idVendor=0451, idProduct=8044, bcdDevice= 1.00
[    1.582910] usb 5-1: New USB device strings: Mfr=0, Product=0, SerialNumber=1
[    1.582911] usb 5-1: SerialNumber: 770700792B4C
[    1.639966] hub 5-1:1.0: USB hub found
[    1.640290] hub 5-1:1.0: 4 ports detected
[    1.708431] usb 6-1: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.730426] usb 6-1: New USB device found, idVendor=0451, idProduct=8046, bcdDevice= 1.00
[    1.730428] usb 6-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.751731] hub 6-1:1.0: USB hub found
[    1.752051] hub 6-1:1.0: 4 ports detected
[    1.768397] usb 1-1: New USB device found, idVendor=046d, idProduct=0a5d, bcdDevice= 1.01
[    1.768399] usb 1-1: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[    1.768400] usb 1-1: Product: Logitech Gaming Headset Battery Charger
[    1.768400] usb 1-1: Manufacturer: Logitech
[    1.781654] hidraw: raw HID events driver (C) Jiri Kosina
[    1.796592] usbcore: registered new interface driver usbhid
[    1.796593] usbhid: USB HID core driver
[    1.797624] hid-generic 0003:046D:0A5D.0001: hiddev0,hidraw0: USB HID v1.11 Device [Logitech Logitech Gaming Headset Battery Charger] on usb-0000:02:00.0-1/input0
[    1.799649] ata2: SATA link down (SStatus 0 SControl 300)
[    1.856370] usb 5-2: new full-speed USB device number 3 using xhci_hcd
[    1.869880] usb 2-7: new SuperSpeed Gen 1 USB device number 2 using xhci_hcd
[    1.880369] tsc: Refined TSC clocksource calibration: 3600.080 MHz
[    1.880382] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x33e49f3eb52, max_idle_ns: 440795343829 ns
[    1.880447] clocksource: Switched to clocksource tsc
[    1.890701] usb 3-1: New USB device found, idVendor=0a12, idProduct=0001, bcdDevice=19.15
[    1.890702] usb 3-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    1.892833] usb 2-7: New USB device found, idVendor=0424, idProduct=5734, bcdDevice= 1.30
[    1.892834] usb 2-7: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[    1.892835] usb 2-7: Product: USB5734
[    1.892836] usb 2-7: Manufacturer: Microchip Tech
[    1.897093] hub 2-7:1.0: USB hub found
[    1.897573] hub 2-7:1.0: 5 ports detected
[    2.027473] usb 5-2: New USB device found, idVendor=046d, idProduct=c32b, bcdDevice=92.03
[    2.027475] usb 5-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.027476] usb 5-2: Product: Gaming Keyboard G910
[    2.027476] usb 5-2: Manufacturer: Logitech
[    2.027477] usb 5-2: SerialNumber: 107F34703336
[    2.050053] input: Logitech Gaming Keyboard G910 as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-2/5-2:1.0/0003:046D:C32B.0002/input/input0
[    2.084020] usb 1-2: new full-speed USB device number 3 using xhci_hcd
[    2.108734] hid-generic 0003:046D:C32B.0002: input,hidraw1: USB HID v1.11 Keyboard [Logitech Gaming Keyboard G910] on usb-0000:0b:00.3-2/input0
[    2.115728] input: Logitech Gaming Keyboard G910 Keyboard as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-2/5-2:1.1/0003:046D:C32B.0003/input/input1
[    2.172414] input: Logitech Gaming Keyboard G910 Consumer Control as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-2/5-2:1.1/0003:046D:C32B.0003/input/input2
[    2.172749] hid-generic 0003:046D:C32B.0003: input,hiddev1,hidraw2: USB HID v1.11 Keyboard [Logitech Gaming Keyboard G910] on usb-0000:0b:00.3-2/input1
[    2.276386] ata3: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[    2.279161] ata3.00: ATAPI: TSSTcorp CDDVDW SH-224DB, SB01, max UDMA/100
[    2.281787] ata3.00: configured for UDMA/100
[    2.283147] scsi 2:0:0:0: CD-ROM            TSSTcorp CDDVDW SH-224DB  SB01 PQ: 0 ANSI: 5
[    2.300379] usb 5-3: new full-speed USB device number 4 using xhci_hcd
[    2.496589] usb 1-2: New USB device found, idVendor=046d, idProduct=c07c, bcdDevice=85.00
[    2.496591] usb 1-2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    2.496592] usb 1-2: Product: G700s Rechargeable Gaming Mouse
[    2.496593] usb 1-2: Manufacturer: Logitech
[    2.496594] usb 1-2: SerialNumber: 0D67E3D70007
[    2.515971] usb 5-3: New USB device found, idVendor=046d, idProduct=0a5b, bcdDevice= 1.01
[    2.515974] usb 5-3: New USB device strings: Mfr=3, Product=4, SerialNumber=0
[    2.515975] usb 5-3: Product: Logitech G933 Gaming Wireless Headset
[    2.515976] usb 5-3: Manufacturer: Logitech
[    2.520567] input: Logitech G700s Rechargeable Gaming Mouse as /devices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-2/1-2:1.0/0003:046D:C07C.0004/input/input5
[    2.520666] hid-generic 0003:046D:C07C.0004: input,hidraw3: USB HID v1.11 Mouse [Logitech G700s Rechargeable Gaming Mouse] on usb-0000:02:00.0-2/input0
[    2.534607] input: Logitech G700s Rechargeable Gaming Mouse Keyboard as /devices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-2/1-2:1.1/0003:046D:C07C.0005/input/input6
[    2.592428] input: Logitech G700s Rechargeable Gaming Mouse Consumer Control as /devices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-2/1-2:1.1/0003:046D:C07C.0005/input/input7
[    2.592755] hid-generic 0003:046D:C07C.0005: input,hiddev2,hidraw4: USB HID v1.11 Keyboard [Logitech G700s Rechargeable Gaming Mouse] on usb-0000:02:00.0-2/input1
[    2.607900] input: Logitech Logitech G933 Gaming Wireless Headset Consumer Control as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-3/5-3:1.3/0003:046D:0A5B.0006/input/input10
[    2.620322] ata4: SATA link down (SStatus 0 SControl 300)
[    2.664577] input: Logitech Logitech G933 Gaming Wireless Headset as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-3/5-3:1.3/0003:046D:0A5B.0006/input/input11
[    2.664600] input: Logitech Logitech G933 Gaming Wireless Headset as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-3/5-3:1.3/0003:046D:0A5B.0006/input/input13
[    2.664826] hid-generic 0003:046D:0A5B.0006: input,hiddev3,hidraw5: USB HID v1.11 Device [Logitech Logitech G933 Gaming Wireless Headset] on usb-0000:0b:00.3-3/input3
[    2.788388] usb 1-7: new high-speed USB device number 4 using xhci_hcd
[    2.790953] random: fast init done
[    2.792018] usb 5-4: new full-speed USB device number 5 using xhci_hcd
[    2.935745] ata5: SATA link down (SStatus 0 SControl 300)
[    2.962492] usb 5-4: New USB device found, idVendor=28de, idProduct=1142, bcdDevice= 0.01
[    2.962494] usb 5-4: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    2.962495] usb 5-4: Product: Steam Controller
[    2.962496] usb 5-4: Manufacturer: Valve Software
[    2.995132] input: Valve Software Steam Controller Keyboard as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-4/5-4:1.0/0003:28DE:1142.0007/input/input14
[    3.027624] usb 1-7: New USB device found, idVendor=0424, idProduct=2734, bcdDevice= 1.30
[    3.027625] usb 1-7: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.027627] usb 1-7: Product: USB2734
[    3.027627] usb 1-7: Manufacturer: Microchip Tech
[    3.034029] hub 1-7:1.0: USB hub found
[    3.036723] hub 1-7:1.0: 5 ports detected
[    3.052593] input: Valve Software Steam Controller Mouse as /devices/pci0000:00/0000:00:07.1/0000:0b:00.3/usb5/5-4/5-4:1.0/0003:28DE:1142.0007/input/input15
[    3.052754] hid-generic 0003:28DE:1142.0007: input,hidraw6: USB HID v1.11 Keyboard [Valve Software Steam Controller] on usb-0000:0b:00.3-4/input0
[    3.056964] hid-generic 0003:28DE:1142.0008: hiddev4,hidraw7: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:0b:00.3-4/input1
[    3.062234] hid-generic 0003:28DE:1142.0009: hiddev5,hidraw8: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:0b:00.3-4/input2
[    3.067244] hid-generic 0003:28DE:1142.000A: hiddev6,hidraw9: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:0b:00.3-4/input3
[    3.072226] hid-generic 0003:28DE:1142.000B: hiddev7,hidraw10: USB HID v1.11 Device [Valve Software Steam Controller] on usb-0000:0b:00.3-4/input4
[    3.252122] usb 1-8: new full-speed USB device number 5 using xhci_hcd
[    3.252124] ata6: SATA link down (SStatus 0 SControl 300)
[    3.567582] ata7: SATA link down (SStatus 0 SControl 300)
[    3.662391] usb 1-8: New USB device found, idVendor=046d, idProduct=c531, bcdDevice=21.00
[    3.662393] usb 1-8: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.662394] usb 1-8: Product: USB Receiver
[    3.662394] usb 1-8: Manufacturer: Logitech
[    3.688745] input: Logitech USB Receiver as /devices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-8/1-8:1.0/0003:046D:C531.000C/input/input16
[    3.688845] hid-generic 0003:046D:C531.000C: input,hidraw11: USB HID v1.11 Mouse [Logitech USB Receiver] on usb-0000:02:00.0-8/input0
[    3.711868] input: Logitech USB Receiver Keyboard as /devices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-8/1-8:1.1/0003:046D:C531.000D/input/input17
[    3.768441] input: Logitech USB Receiver Consumer Control as /devices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-8/1-8:1.1/0003:046D:C531.000D/input/input18
[    3.768462] input: Logitech USB Receiver System Control as /devices/pci0000:00/0000:00:01.3/0000:02:00.0/usb1/1-8/1-8:1.1/0003:046D:C531.000D/input/input19
[    3.768702] hid-generic 0003:046D:C531.000D: input,hiddev8,hidraw12: USB HID v1.11 Keyboard [Logitech USB Receiver] on usb-0000:02:00.0-8/input1
[    3.784394] usb 1-7.5: new high-speed USB device number 6 using xhci_hcd
[    3.883879] ata8: SATA link down (SStatus 0 SControl 300)
[    3.886071] sd 0:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    3.886080] sd 0:0:0:0: [sda] Write Protect is off
[    3.886082] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    3.886094] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    3.888771]  sda: sda1 sda2
[    3.889124] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.915614] usb 1-7.5: New USB device found, idVendor=0424, idProduct=274c, bcdDevice= 2.00
[    3.915616] usb 1-7.5: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    3.915617] usb 1-7.5: Product: Hub Controller
[    3.915618] usb 1-7.5: Manufacturer: Microchip Tech
[    3.932236] hid-generic 0003:0424:274C.000E: hiddev9,hidraw13: USB HID v1.10 Device [Microchip Tech Hub Controller] on usb-0000:02:00.0-7.5/input0
[    3.936084] sr 2:0:0:0: [sr0] scsi3-mmc drive: 48x/48x writer dvd-ram cd/rw xa/form2 cdda tray
[    3.936087] cdrom: Uniform CD-ROM driver Revision: 3.20
[    3.936419] sr 2:0:0:0: Attached scsi CD-ROM sr0
[    4.192079] device-mapper: uevent: version 1.0.3
[    4.192143] device-mapper: ioctl: 4.40.0-ioctl (2019-01-18) initialised: dm-devel@redhat.com
[    4.213991] random: cryptsetup: uninitialized urandom read (4 bytes read)
[    8.714326] random: cryptsetup: uninitialized urandom read (2 bytes read)
[    8.804149] raid6: avx2x4   gen() 26306 MB/s
[    8.872016] raid6: avx2x4   xor() 15064 MB/s
[    8.940151] raid6: avx2x2   gen() 24849 MB/s
[    9.008016] raid6: avx2x2   xor() 15789 MB/s
[    9.076150] raid6: avx2x1   gen() 18883 MB/s
[    9.144017] raid6: avx2x1   xor() 14798 MB/s
[    9.212149] raid6: sse2x4   gen() 18203 MB/s
[    9.280016] raid6: sse2x4   xor() 10555 MB/s
[    9.348150] raid6: sse2x2   gen() 16034 MB/s
[    9.416017] raid6: sse2x2   xor() 11357 MB/s
[    9.484018] raid6: sse2x1   gen()  8350 MB/s
[    9.552015] raid6: sse2x1   xor()  8217 MB/s
[    9.552015] raid6: using algorithm avx2x4 gen() 26306 MB/s
[    9.552015] raid6: .... xor() 15064 MB/s, rmw enabled
[    9.552016] raid6: using avx2x2 recovery algorithm
[    9.554208] xor: automatically using best checksumming function   avx       
[    9.574247] Btrfs loaded, crc32c=crc32c-intel
[    9.706352] BTRFS: device fsid b3062f54-4d0e-46d1-a81f-02c9b97d65e7 devid 1 transid 203331 /dev/mapper/root
[    9.719897] BTRFS info (device dm-0): disk space caching is enabled
[    9.719898] BTRFS info (device dm-0): has skinny extents
[    9.732938] BTRFS info (device dm-0): enabling ssd optimizations
[    9.753253] Not activating Mandatory Access Control as /sbin/tomoyo-init does not exist.
[    9.875387] systemd[1]: Inserted module 'autofs4'
[    9.924196] systemd[1]: systemd 244.2-1 running in system mode. (+PAM +AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP +GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD +IDN2 -IDN +PCRE2 default-hierarchy=hybrid)
[    9.944666] systemd[1]: Detected architecture x86-64.
[    9.947813] systemd[1]: Set hostname to <desktop>.
[   10.030886] systemd[1]: /lib/systemd/system/dbus.socket:5: ListenStream= references a path below legacy directory /var/run/, updating /var/run/dbus/system_bus_socket → /run/dbus/system_bus_socket; please update the unit file accordingly.
[   10.040660] systemd[1]: /lib/systemd/system/libvirtd-admin.socket:8: ListenStream= references a path below legacy directory /var/run/, updating /var/run/libvirt/libvirt-admin-sock → /run/libvirt/libvirt-admin-sock; please update the unit file accordingly.
[   10.040845] systemd[1]: /lib/systemd/system/libvirtd-ro.socket:8: ListenStream= references a path below legacy directory /var/run/, updating /var/run/libvirt/libvirt-sock-ro → /run/libvirt/libvirt-sock-ro; please update the unit file accordingly.
[   10.041009] systemd[1]: /lib/systemd/system/libvirtd.socket:6: ListenStream= references a path below legacy directory /var/run/, updating /var/run/libvirt/libvirt-sock → /run/libvirt/libvirt-sock; please update the unit file accordingly.
[   10.041122] systemd[1]: /lib/systemd/system/virtlockd.socket:6: ListenStream= references a path below legacy directory /var/run/, updating /var/run/libvirt/virtlockd-sock → /run/libvirt/virtlockd-sock; please update the unit file accordingly.
[   10.041361] systemd[1]: /lib/systemd/system/virtlockd-admin.socket:8: ListenStream= references a path below legacy directory /var/run/, updating /var/run/libvirt/virtlockd-admin-sock → /run/libvirt/virtlockd-admin-sock; please update the unit file accordingly.
[   10.041527] systemd[1]: /lib/systemd/system/virtlogd.socket:6: ListenStream= references a path below legacy directory /var/run/, updating /var/run/libvirt/virtlogd-sock → /run/libvirt/virtlogd-sock; please update the unit file accordingly.
[   10.041781] systemd[1]: /lib/systemd/system/virtlogd-admin.socket:8: ListenStream= references a path below legacy directory /var/run/, updating /var/run/libvirt/virtlogd-admin-sock → /run/libvirt/virtlogd-admin-sock; please update the unit file accordingly.
[   10.049067] systemd[1]: Created slice Virtual Machine and Container Slice.
[   10.049319] systemd[1]: Created slice system-getty.slice.
[   10.049476] systemd[1]: Created slice system-systemd\x2dcryptsetup.slice.
[   10.049632] systemd[1]: Created slice system-systemd\x2dfsck.slice.
[   10.049756] systemd[1]: Created slice User and Session Slice.
[   10.049789] systemd[1]: Started Dispatch Password Requests to Console Directory Watch.
[   10.049814] systemd[1]: Started Forward Password Requests to Wall Directory Watch.
[   10.049835] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[   10.049861] systemd[1]: Reached target Paths.
[   10.049869] systemd[1]: Reached target Remote File Systems.
[   10.049875] systemd[1]: Reached target Slices.
[   10.049883] systemd[1]: Reached target Swap.
[   10.049892] systemd[1]: Reached target Libvirt guests shutdown.
[   10.050289] systemd[1]: Listening on Syslog Socket.
[   10.050629] systemd[1]: Listening on fsck to fsckd communication Socket.
[   10.050661] systemd[1]: Listening on initctl Compatibility Named Pipe.
[   10.050748] systemd[1]: Listening on Journal Audit Socket.
[   10.050793] systemd[1]: Listening on Journal Socket (/dev/log).
[   10.050848] systemd[1]: Listening on Journal Socket.
[   10.050903] systemd[1]: Listening on udev Control Socket.
[   10.050940] systemd[1]: Listening on udev Kernel Socket.
[   10.051437] systemd[1]: Mounting Huge Pages File System...
[   10.052014] systemd[1]: Mounting POSIX Message Queue File System...
[   10.052607] systemd[1]: Mounting Kernel Debug File System...
[   10.053161] systemd[1]: Mounting Temporary Directory (/tmp)...
[   10.054130] systemd[1]: Starting Set the console keyboard layout...
[   10.054697] systemd[1]: Starting Create list of static device nodes for the current kernel...
[   10.054785] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[   10.055712] systemd[1]: Starting Journal Service...
[   10.056309] systemd[1]: Starting Load Kernel Modules...
[   10.056810] systemd[1]: Starting Remount Root and Kernel File Systems...
[   10.057363] systemd[1]: Starting udev Coldplug all Devices...
[   10.058059] systemd[1]: Mounted Huge Pages File System.
[   10.058132] systemd[1]: Mounted POSIX Message Queue File System.
[   10.058193] systemd[1]: Mounted Kernel Debug File System.
[   10.058264] systemd[1]: Mounted Temporary Directory (/tmp).
[   10.058531] systemd[1]: Started Set the console keyboard layout.
[   10.058834] systemd[1]: Started Create list of static device nodes for the current kernel.
[   10.064781] systemd[1]: Started Load Kernel Modules.
[   10.064898] systemd[1]: Condition check resulted in FUSE Control File System being skipped.
[   10.064936] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
[   10.065905] systemd[1]: Starting Apply Kernel Variables...
[   10.066552] BTRFS info (device dm-0): disk space caching is enabled
[   10.067993] systemd[1]: Started Remount Root and Kernel File Systems.
[   10.068728] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[   10.069239] systemd[1]: Starting Load/Save Random Seed...
[   10.069735] systemd[1]: Starting Create System Users...
[   10.075786] systemd[1]: Started Apply Kernel Variables.
[   10.080651] systemd[1]: Started Create System Users.
[   10.081249] systemd[1]: Starting Create Static Device Nodes in /dev...
[   10.089782] systemd[1]: Started Create Static Device Nodes in /dev.
[   10.089852] systemd[1]: Reached target Local File Systems (Pre).
[   10.089878] systemd[1]: Condition check resulted in Virtual Machine and Container Storage (Compatibility) being skipped.
[   10.089887] systemd[1]: Reached target Containers.
[   10.090528] systemd[1]: Starting udev Kernel Device Manager...
[   10.126827] systemd[1]: Started udev Coldplug all Devices.
[   10.127468] systemd[1]: Starting Helper to synchronize boot up for ifupdown...
[   10.130967] systemd[1]: Started Helper to synchronize boot up for ifupdown.
[   10.152780] systemd[1]: Started udev Kernel Device Manager.
[   10.180910] acpi_cpufreq: overriding BIOS provided _PSD data
[   10.181995] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input22
[   10.182006] ACPI: Power Button [PWRB]
[   10.182089] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input23
[   10.182105] ACPI: Power Button [PWRF]
[   10.182695] wmi_bus wmi_bus-PNP0C14:01: WQAA data block query control method not found
[   10.183015] acpi PNP0C14:03: duplicate WMI GUID 05901221-D566-11D1-B2F0-00A0C9062910 (first instance was on PNP0C14:02)
[   10.200469] sd 0:0:0:0: Attached scsi generic sg0 type 0
[   10.200520] sr 2:0:0:0: Attached scsi generic sg1 type 5
[   10.208309] systemd[1]: Found device XPG GAMMIX S11 Pro 1.
[   10.210159] systemd[1]: Starting Cryptography Setup for Storage0...
[   10.223889] systemd[1]: Found device XPG GAMMIX S5 1.
[   10.225409] systemd[1]: Starting Cryptography Setup for Storage1...
[   10.227084] random: systemd-cryptse: uninitialized urandom read (4 bytes read)
[   10.238468] random: systemd-cryptse: uninitialized urandom read (4 bytes read)
[   10.244213] ccp 0000:0b:00.2: enabling device (0000 -> 0002)
[   10.245320] ccp 0000:0b:00.2: ccp enabled
[   10.258984] systemd[1]: Found device ADATA_SX910 2.
[   10.259807] systemd[1]: Starting Cryptography Setup for root...
[   10.272364] systemd[1]: Started Cryptography Setup for root.
[   10.277771] sp5100_tco: SP5100/SB800 TCO WatchDog Timer Driver
[   10.277837] sp5100-tco sp5100-tco: Using 0xfeb00000 for watchdog MMIO address
[   10.278180] sp5100-tco sp5100-tco: initialized. heartbeat=60 sec (nowayout=0)
[   10.278613] EFI Variables Facility v0.08 2004-May-17
[   10.324500] pstore: Using crash dump compression: deflate
[   10.324519] pstore: Registered efi as persistent store backend
[   10.355056] systemd[1]: Found device ADATA_SX910 1.
[   10.356196] systemd[1]: Starting File System Check on /dev/sda1...
[   10.372894] systemd[1]: Started File System Check Daemon to report status.
[   10.382525] BTRFS info (device dm-0): device fsid b3062f54-4d0e-46d1-a81f-02c9b97d65e7 devid 1 moved old:/dev/mapper/root new:/dev/dm-0
[   10.383423] BTRFS info (device dm-0): device fsid b3062f54-4d0e-46d1-a81f-02c9b97d65e7 devid 1 moved old:/dev/dm-0 new:/dev/mapper/root
[   10.386027] snd_hda_intel 0000:0a:00.1: enabling device (0000 -> 0002)
[   10.386266] snd_hda_intel 0000:0c:00.3: enabling device (0000 -> 0002)
[   10.396361] systemd[1]: Found device /dev/mapper/root.
[   10.397145] systemd[1]: Mounting /mnt/root...
[   10.402086] systemd[1]: Mounted /mnt/root.
[   10.410184] kvm: Nested Virtualization enabled
[   10.410193] kvm: Nested Paging enabled
[   10.410193] SVM: Virtual VMLOAD VMSAVE supported
[   10.410193] SVM: Virtual GIF supported
[   10.428564] input: HD-Audio Generic HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:03.1/0000:08:00.0/0000:09:00.0/0000:0a:00.1/sound/card0/input24
[   10.428637] input: HD-Audio Generic HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:03.1/0000:08:00.0/0000:09:00.0/0000:0a:00.1/sound/card0/input25
[   10.428696] input: HD-Audio Generic HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:03.1/0000:08:00.0/0000:09:00.0/0000:0a:00.1/sound/card0/input26
[   10.428752] input: HD-Audio Generic HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:03.1/0000:08:00.0/0000:09:00.0/0000:0a:00.1/sound/card0/input27
[   10.428804] input: HD-Audio Generic HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:03.1/0000:08:00.0/0000:09:00.0/0000:0a:00.1/sound/card0/input28
[   10.428861] input: HD-Audio Generic HDMI/DP,pcm=11 as /devices/pci0000:00/0000:00:03.1/0000:08:00.0/0000:09:00.0/0000:0a:00.1/sound/card0/input29
[   10.431607] systemd[1]: Reached target Sound Card.
[   10.440909] Bluetooth: Core ver 2.22
[   10.440927] NET: Registered protocol family 31
[   10.440928] Bluetooth: HCI device and connection manager initialized
[   10.440933] Bluetooth: HCI socket layer initialized
[   10.440935] Bluetooth: L2CAP socket layer initialized
[   10.440939] Bluetooth: SCO socket layer initialized
[   10.451522] random: crng init done
[   10.451623] snd_hda_codec_realtek hdaudioC1D0: autoconfig for ALC1220: line_outs=3 (0x14/0x15/0x16/0x0/0x0) type:line
[   10.451625] snd_hda_codec_realtek hdaudioC1D0:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.451626] snd_hda_codec_realtek hdaudioC1D0:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.451627] snd_hda_codec_realtek hdaudioC1D0:    mono: mono_out=0x0
[   10.451627] snd_hda_codec_realtek hdaudioC1D0:    dig-out=0x1e/0x0
[   10.451628] snd_hda_codec_realtek hdaudioC1D0:    inputs:
[   10.451629] snd_hda_codec_realtek hdaudioC1D0:      Rear Mic=0x18
[   10.451630] snd_hda_codec_realtek hdaudioC1D0:      Line=0x1a
[   10.457564] systemd[1]: Started Load/Save Random Seed.
[   10.459633] systemd[1]: Started File System Check on /dev/sda1.
[   10.460929] systemd[1]: Mounting /boot...
[   10.462084] snd_hda_codec_realtek hdaudioC1D1: autoconfig for ALC1220: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:hp
[   10.462086] snd_hda_codec_realtek hdaudioC1D1:    speaker_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.462088] snd_hda_codec_realtek hdaudioC1D1:    hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
[   10.462089] snd_hda_codec_realtek hdaudioC1D1:    mono: mono_out=0x0
[   10.462090] snd_hda_codec_realtek hdaudioC1D1:    inputs:
[   10.462091] snd_hda_codec_realtek hdaudioC1D1:      Front Mic=0x1a
[   10.465697] usbcore: registered new interface driver btusb
[   10.468786] input: HD-Audio Generic Rear Mic as /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/sound/card1/input30
[   10.468903] input: HD-Audio Generic Line as /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/sound/card1/input31
[   10.468979] input: HD-Audio Generic Line Out Front as /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/sound/card1/input32
[   10.469077] input: HD-Audio Generic Line Out Surround as /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/sound/card1/input33
[   10.469149] input: HD-Audio Generic Line Out CLFE as /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/sound/card1/input34
[   10.469214] input: HD-Audio Generic Front Mic as /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/sound/card1/input35
[   10.469273] input: HD-Audio Generic Front Headphone as /devices/pci0000:00/0000:00:08.1/0000:0c:00.3/sound/card1/input36
[   10.474355] systemd[1]: Condition check resulted in Arbitrary Executable File Formats File System Automount Point being skipped.
[   10.474537] systemd[1]: Condition check resulted in FUSE Control File System being skipped.
[   10.474606] systemd[1]: Condition check resulted in Kernel Configuration File System being skipped.
[   10.474709] systemd[1]: Condition check resulted in Set Up Additional Binary Formats being skipped.
[   10.474752] systemd[1]: Condition check resulted in Rebuild Hardware Database being skipped.
[   10.559248] systemd[1]: Started Journal Service.
[   10.586034] systemd-journald[592]: Received client request to flush runtime journal.
[   10.594733] usbcore: registered new interface driver snd-usb-audio
[   10.890931] [drm] amdgpu kernel modesetting enabled.
[   10.890972] amdgpu 0000:0a:00.0: remove_conflicting_pci_framebuffers: bar 0: 0xe0000000 -> 0xefffffff
[   10.890974] amdgpu 0000:0a:00.0: remove_conflicting_pci_framebuffers: bar 2: 0xf0000000 -> 0xf01fffff
[   10.890975] amdgpu 0000:0a:00.0: remove_conflicting_pci_framebuffers: bar 5: 0xfcc00000 -> 0xfcc7ffff
[   10.890977] checking generic (e0000000 300000) vs hw (e0000000 10000000)
[   10.890978] fb0: switching to amdgpudrmfb from EFI VGA
[   10.891199] Console: switching to colour dummy device 80x25
[   10.891276] amdgpu 0000:0a:00.0: enabling device (0006 -> 0007)
[   10.891466] [drm] initializing kernel modesetting (NAVI10 0x1002:0x731F 0x1DA2:0xE409 0xC1).
[   10.891485] [drm] register mmio base: 0xFCC00000
[   10.891486] [drm] register mmio size: 524288
[   10.912061] [drm] set register base offset for ATHUB
[   10.912062] [drm] set register base offset for CLKA
[   10.912063] [drm] set register base offset for CLKA
[   10.912063] [drm] set register base offset for CLKA
[   10.912063] [drm] set register base offset for CLKA
[   10.912063] [drm] set register base offset for CLKA
[   10.912064] [drm] set register base offset for DF
[   10.912064] [drm] set register base offset for DMU
[   10.912065] [drm] set register base offset for GC
[   10.912065] [drm] set register base offset for HDP
[   10.912065] [drm] set register base offset for MMHUB
[   10.912065] [drm] set register base offset for MP0
[   10.912066] [drm] set register base offset for MP1
[   10.912066] [drm] set register base offset for NBIF
[   10.912067] [drm] set register base offset for NBIF
[   10.912067] [drm] set register base offset for OSSSYS
[   10.912067] [drm] set register base offset for SDMA0
[   10.912067] [drm] set register base offset for SDMA1
[   10.912068] [drm] set register base offset for SMUIO
[   10.912068] [drm] set register base offset for THM
[   10.912069] [drm] set register base offset for UVD
[   10.912070] [drm] add ip block number 0 <nv_common>
[   10.912071] [drm] add ip block number 1 <gmc_v10_0>
[   10.912071] [drm] add ip block number 2 <navi10_ih>
[   10.912072] [drm] add ip block number 3 <psp>
[   10.912073] [drm] add ip block number 4 <smu>
[   10.912073] [drm] add ip block number 5 <dm>
[   10.912074] [drm] add ip block number 6 <gfx_v10_0>
[   10.912075] [drm] add ip block number 7 <sdma_v5_0>
[   10.912075] [drm] add ip block number 8 <vcn_v2_0>
[   10.913868] ATOM BIOS: 113-D1990103-O09
[   10.913880] [drm] VCN decode is enabled in VM mode
[   10.913881] [drm] VCN encode is enabled in VM mode
[   10.913881] [drm] VCN jpeg decode is enabled in VM mode
[   10.913921] [drm] vm size is 262144 GB, 4 levels, block size is 9-bit, fragment size is 9-bit
[   10.913928] amdgpu 0000:0a:00.0: VRAM: 8176M 0x0000008000000000 - 0x00000081FEFFFFFF (8176M used)
[   10.913929] amdgpu 0000:0a:00.0: GART: 512M 0x0000000000000000 - 0x000000001FFFFFFF
[   10.913936] [drm] Detected VRAM RAM=8176M, BAR=256M
[   10.913936] [drm] RAM width 256bits GDDR6
[   10.914020] [TTM] Zone  kernel: Available graphics memory: 16452700 KiB
[   10.914020] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[   10.914021] [TTM] Initializing pool allocator
[   10.914024] [TTM] Initializing DMA pool allocator
[   10.914600] [drm] amdgpu: 8176M of VRAM memory ready
[   10.914602] [drm] amdgpu: 8176M of GTT memory ready.
[   10.914610] [drm] GART: num cpu pages 131072, num gpu pages 131072
[   10.914717] [drm] PCIE GART of 512M enabled (table at 0x0000008000300000).
[   10.934169] [drm] ppt_offset_bytes: 3
[   10.934171] [drm] ppt_size_bytes: 262912
[   10.968499] [drm] use_doorbell being set to: [true]
[   10.968626] [drm] use_doorbell being set to: [true]
[   10.972635] [drm] Found VCN firmware Version ENC: 1.7 DEC: 4 VEP: 0 Revision: 13
[   10.972657] [drm] PSP loading VCN firmware
[   11.648086] [drm] reserve 0xa00000 from 0x8000800000 for PSP TMR
[   11.840177] amdgpu: [powerplay] smu driver if version = 0x00000033, smu fw if version = 0x00000035, smu fw version = 0x002a2f84 (42.47.132)
[   11.840178] amdgpu: [powerplay] SMU driver if version not matched
[   11.853409] amdgpu: [powerplay] SMU is initialized successfully!
[   11.884342] [drm] Display Core initialized with v3.2.35!
[   11.913094] [drm] DM_MST: Differing MST start on aconnector: 00000000673cb9ea [id: 78]
[   11.913294] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[   11.913294] [drm] Driver supports precise vblank timestamp query.
[   11.913848] [drm] kiq ring mec 2 pipe 1 q 0
[   11.913941] [drm] ring test on 10 succeeded in 40 usecs
[   11.913986] [drm] ring test on 10 succeeded in 10 usecs
[   11.914049] [drm] gfx 0 ring me 0 pipe 0 q 0
[   11.914072] [drm] ring test on 0 succeeded in 9 usecs
[   11.914072] [drm] gfx 1 ring me 0 pipe 1 q 0
[   11.914077] [drm] ring test on 1 succeeded in 1 usecs
[   11.914078] [drm] compute ring 0 mec 1 pipe 0 q 0
[   11.914089] [drm] ring test on 2 succeeded in 3 usecs
[   11.914090] [drm] compute ring 1 mec 1 pipe 1 q 0
[   11.914103] [drm] ring test on 3 succeeded in 2 usecs
[   11.914103] [drm] compute ring 2 mec 1 pipe 2 q 0
[   11.914116] [drm] ring test on 4 succeeded in 2 usecs
[   11.914116] [drm] compute ring 3 mec 1 pipe 3 q 0
[   11.914129] [drm] ring test on 5 succeeded in 2 usecs
[   11.914129] [drm] compute ring 4 mec 1 pipe 0 q 1
[   11.914141] [drm] ring test on 6 succeeded in 2 usecs
[   11.914142] [drm] compute ring 5 mec 1 pipe 1 q 1
[   11.914155] [drm] ring test on 7 succeeded in 2 usecs
[   11.914155] [drm] compute ring 6 mec 1 pipe 2 q 1
[   11.914168] [drm] ring test on 8 succeeded in 2 usecs
[   11.914169] [drm] compute ring 7 mec 1 pipe 3 q 1
[   11.914187] [drm] ring test on 9 succeeded in 5 usecs
[   11.914266] [drm] ring test on 11 succeeded in 14 usecs
[   11.914304] [drm] ring test on 12 succeeded in 16 usecs
[   11.924726] [drm] VCN decode and encode initialized successfully(under DPG Mode).
[   11.925607] [drm] Cannot find any crtc or sizes
[   11.925798] amdgpu 0000:0a:00.0: ring 0(gfx_0.0.0) uses VM inv eng 4 on hub 0
[   11.925800] amdgpu 0000:0a:00.0: ring 1(gfx_0.1.0) uses VM inv eng 5 on hub 0
[   11.925801] amdgpu 0000:0a:00.0: ring 2(comp_1.0.0) uses VM inv eng 6 on hub 0
[   11.925802] amdgpu 0000:0a:00.0: ring 3(comp_1.1.0) uses VM inv eng 7 on hub 0
[   11.925803] amdgpu 0000:0a:00.0: ring 4(comp_1.2.0) uses VM inv eng 8 on hub 0
[   11.925804] amdgpu 0000:0a:00.0: ring 5(comp_1.3.0) uses VM inv eng 9 on hub 0
[   11.925805] amdgpu 0000:0a:00.0: ring 6(comp_1.0.1) uses VM inv eng 10 on hub 0
[   11.925806] amdgpu 0000:0a:00.0: ring 7(comp_1.1.1) uses VM inv eng 11 on hub 0
[   11.925807] amdgpu 0000:0a:00.0: ring 8(comp_1.2.1) uses VM inv eng 12 on hub 0
[   11.925808] amdgpu 0000:0a:00.0: ring 9(comp_1.3.1) uses VM inv eng 13 on hub 0
[   11.925810] amdgpu 0000:0a:00.0: ring 10(kiq_2.1.0) uses VM inv eng 14 on hub 0
[   11.925811] amdgpu 0000:0a:00.0: ring 11(sdma0) uses VM inv eng 15 on hub 0
[   11.925812] amdgpu 0000:0a:00.0: ring 12(sdma1) uses VM inv eng 16 on hub 0
[   11.925813] amdgpu 0000:0a:00.0: ring 13(vcn_dec) uses VM inv eng 4 on hub 1
[   11.925814] amdgpu 0000:0a:00.0: ring 14(vcn_enc0) uses VM inv eng 5 on hub 1
[   11.925815] amdgpu 0000:0a:00.0: ring 15(vcn_enc1) uses VM inv eng 6 on hub 1
[   11.925816] amdgpu 0000:0a:00.0: ring 16(vcn_jpeg) uses VM inv eng 7 on hub 1
[   11.932842] [drm] Initialized amdgpu 3.33.0 20150101 for 0000:0a:00.0 on minor 0
[   12.002941] [drm] DM_MST: added connector: 000000005e1ecbf5 [id: 89] [master: 00000000673cb9ea]
[   12.151551] [drm] DM_MST: added connector: 00000000667d4541 [id: 94] [master: 00000000673cb9ea]
[   12.385530] [drm] DM_MST: added connector: 000000003833e81a [id: 99] [master: 00000000673cb9ea]
[   12.726791] [drm] DM_MST: added connector: 00000000eb5de799 [id: 104] [master: 00000000673cb9ea]
[   13.403290] [drm] fb mappable at 0xE1200000
[   13.403292] [drm] vram apper at 0xE0000000
[   13.403292] [drm] size 8294400
[   13.403293] [drm] fb depth is 24
[   13.403293] [drm]    pitch is 7680
[   13.944168] [drm] ib test on ring 0 succeeded
[   13.944198] [drm] ib test on ring 1 succeeded
[   13.944331] [drm] ib test on ring 2 succeeded
[   13.944365] [drm] ib test on ring 3 succeeded
[   13.944462] [drm] ib test on ring 4 succeeded
[   13.944557] [drm] ib test on ring 5 succeeded
[   13.944594] [drm] ib test on ring 6 succeeded
[   13.944621] [drm] ib test on ring 7 succeeded
[   13.944713] [drm] ib test on ring 8 succeeded
[   13.944808] [drm] ib test on ring 9 succeeded
[   13.944845] [drm] ib test on ring 10 succeeded
[   13.944876] [drm] ib test on ring 11 succeeded
[   13.944904] [drm] ib test on ring 12 succeeded
[   14.920838] Console: switching to colour frame buffer device 240x67
[   14.940801] amdgpu 0000:0a:00.0: fb0: amdgpudrmfb frame buffer device
[   14.968327] [drm] DM_MST: added connector: 0000000065e3d0c5 [id: 116] [master: 00000000673cb9ea]
[   14.985101] [drm] DM_MST: added connector: 00000000ae971f72 [id: 111] [master: 00000000673cb9ea]
[   16.453168] BTRFS: device fsid c48f6ab8-f94c-4e5e-8110-1aebceef4345 devid 1 transid 193381 /dev/dm-1
[   18.400489] BTRFS: device fsid c48f6ab8-f94c-4e5e-8110-1aebceef4345 devid 2 transid 193381 /dev/dm-2
[   18.430164] BTRFS info (device dm-1): disk space caching is enabled
[   18.430165] BTRFS info (device dm-1): has skinny extents
[   18.520368] BTRFS info (device dm-1): enabling ssd optimizations
[   19.209656] alx 0000:06:00.0 enp6s0: NIC Up: 1 Gbps Full
[   19.209874] IPv6: ADDRCONF(NETDEV_CHANGE): enp6s0: link becomes ready
[   19.250265] bridge: filtering via arp/ip/ip6tables is no longer available by default. Update your scripts to load br_netfilter if you need this.
[   19.262496] bridge0: port 1(enp6s0) entered blocking state
[   19.262497] bridge0: port 1(enp6s0) entered disabled state
[   19.262634] device enp6s0 entered promiscuous mode
[   19.262747] bridge0: port 1(enp6s0) entered blocking state
[   19.262748] bridge0: port 1(enp6s0) entered listening state
[   34.488325] bridge0: port 1(enp6s0) entered learning state
[   49.592315] bridge0: port 1(enp6s0) entered forwarding state
[   49.592332] bridge0: topology change detected, propagating
[  134.696026] usb 1-1: USB disconnect, device number 2
[  135.037327] usb 1-1: new full-speed USB device number 7 using xhci_hcd
[  135.366172] usb 1-1: New USB device found, idVendor=046d, idProduct=0a5d, bcdDevice= 1.01
[  135.366174] usb 1-1: New USB device strings: Mfr=2, Product=3, SerialNumber=0
[  135.366176] usb 1-1: Product: Logitech Gaming Headset Battery Charger
[  135.366177] usb 1-1: Manufacturer: Logitech
[  135.392711] hid-generic 0003:046D:0A5D.000F: hiddev0,hidraw0: USB HID v1.11 Device [Logitech Logitech Gaming Headset Battery Charger] on usb-0000:02:00.0-1/input0
[  137.998241] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  137.998249] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  137.998251] amdgpu: [powerplay] Failed to export SMU metrics table!
[  137.998276] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  137.998283] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  137.998284] amdgpu: [powerplay] Failed to export SMU metrics table!
[  137.998341] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  137.998348] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  137.998349] amdgpu: [powerplay] Failed to export SMU metrics table!
[  137.998397] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  137.998404] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  137.998405] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.185391] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.185399] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.185401] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.185414] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.185421] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.185421] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.185469] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.185476] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.185476] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.185524] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.185530] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.185531] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.385317] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.385325] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.385327] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.385340] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.385346] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.385347] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.385394] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.385400] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.385401] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.385448] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.385454] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.385455] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.585243] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.585251] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.585252] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.585266] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.585272] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.585273] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.585320] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.585327] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.585328] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.585375] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.585381] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.585382] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.785276] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.785285] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.785286] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.785299] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.785306] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.785306] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.785353] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.785360] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.785361] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.785407] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.785414] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.785415] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.985541] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.985549] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.985550] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.985563] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.985570] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.985571] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.985617] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.985624] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.985625] amdgpu: [powerplay] Failed to export SMU metrics table!
[  138.985672] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  138.985679] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  138.985679] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.184559] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.184567] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.184568] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.184581] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.184588] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.184589] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.184635] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.184641] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.184642] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.184688] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.184695] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.184696] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.385557] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.385565] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.385567] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.385580] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.385586] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.385587] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.385634] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.385640] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.385641] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.385688] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.385694] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.385695] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.585424] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.585432] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.585434] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.585446] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.585453] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.585454] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.585500] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.585507] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.585508] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.585554] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.585561] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.585562] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.785460] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.785468] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.785469] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.785482] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.785488] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.785489] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.785538] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.785544] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.785545] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.785592] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.785598] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.785599] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.985780] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.985789] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.985790] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.985802] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.985809] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.985810] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.985856] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.985863] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.985864] amdgpu: [powerplay] Failed to export SMU metrics table!
[  139.985912] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  139.985918] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  139.985919] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.184418] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.184427] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.184428] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.184440] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.184447] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.184448] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.184494] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.184501] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.184501] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.184548] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.184555] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.184556] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.385402] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.385411] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.385412] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.385425] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.385431] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.385432] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.385479] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.385485] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.385486] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.385533] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.385539] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.385540] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.585315] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.585323] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.585324] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.585337] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.585343] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.585344] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.585390] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.585397] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.585398] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.585445] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.585451] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.585452] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.785228] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.785237] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.785238] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.785251] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.785257] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.785258] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.785307] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.785314] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.785314] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.785362] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.785368] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.785369] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.985584] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.985593] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.985594] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.985606] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.985612] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.985613] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.985661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.985667] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.985668] amdgpu: [powerplay] Failed to export SMU metrics table!
[  140.985715] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  140.985722] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  140.985723] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.184489] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.184497] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.184499] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.184511] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.184517] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.184518] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.184565] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.184572] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.184573] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.184620] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.184626] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.184627] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.385535] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.385544] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.385545] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.385557] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.385564] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.385564] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.385610] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.385617] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.385618] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.385664] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.385671] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.385672] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.585468] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.585477] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.585478] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.585490] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.585497] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.585498] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.585545] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.585551] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.585552] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.585600] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.585606] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.585607] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.785486] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.785495] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.785496] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.785508] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.785515] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.785515] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.785563] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.785569] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.785570] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.785617] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.785624] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.785625] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.985742] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.985750] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.985751] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.985765] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.985772] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.985773] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.985819] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.985825] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.985826] amdgpu: [powerplay] Failed to export SMU metrics table!
[  141.985874] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  141.985880] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  141.985881] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.184734] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.184743] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.184744] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.184756] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.184762] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.184763] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.184810] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.184817] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.184818] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.184865] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.184871] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.184872] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.384670] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.384678] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.384679] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.384691] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.384697] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.384698] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.384745] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.384751] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.384752] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.384799] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.384806] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.384807] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.584546] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.584555] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.584556] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.584570] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.584576] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.584577] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.584631] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.584638] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.584639] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.584694] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.584700] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.584701] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.785578] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.785586] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.785588] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.785600] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.785606] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.785607] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.785654] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.785661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.785662] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.785709] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.785716] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.785716] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.985819] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.985828] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.985829] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.985841] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.985847] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.985848] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.985895] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.985902] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.985902] amdgpu: [powerplay] Failed to export SMU metrics table!
[  142.985950] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  142.985956] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  142.985957] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.184693] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.184701] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.184702] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.184715] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.184721] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.184722] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.184769] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.184775] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.184776] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.184824] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.184830] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.184831] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.384604] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.384612] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.384614] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.384626] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.384632] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.384633] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.384679] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.384686] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.384687] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.384734] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.384740] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.384741] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.585729] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.585738] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.585739] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.585751] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.585758] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.585758] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.585805] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.585812] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.585813] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.585860] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.585866] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.585867] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.784711] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.784719] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.784720] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.784732] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.784739] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.784740] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.784786] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.784792] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.784793] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.784840] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.784846] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.784847] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.985115] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.985124] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.985125] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.985137] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.985144] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.985145] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.985196] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.985203] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.985204] amdgpu: [powerplay] Failed to export SMU metrics table!
[  143.985252] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  143.985274] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  143.985275] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.184772] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.184781] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.184782] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.184794] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.184801] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.184802] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.184853] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.184860] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.184861] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.184907] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.184914] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.184914] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.384701] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.384709] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.384711] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.384723] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.384729] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.384730] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.384777] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.384783] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.384784] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.384831] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.384837] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.384838] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.584747] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.584756] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.584757] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.584773] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.584779] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.584780] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.584828] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.584835] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.584836] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.584882] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.584889] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.584889] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.784724] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.784733] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.784734] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.784746] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.784753] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.784754] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.784805] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.784812] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.784812] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.784860] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.784866] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.784867] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.985094] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.985102] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.985104] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.985116] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.985123] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.985123] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.985174] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.985181] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.985181] amdgpu: [powerplay] Failed to export SMU metrics table!
[  144.985229] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  144.985235] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  144.985236] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.185273] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.185289] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.185291] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.185303] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.185310] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.185311] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.185359] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.185365] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.185366] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.185414] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.185420] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.185421] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.385267] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.385275] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.385277] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.385310] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.385316] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.385317] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.385367] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.385374] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.385374] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.385422] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.385429] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.385429] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.585216] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.585224] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.585226] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.585238] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.585244] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.585245] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.585313] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.585320] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.585321] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.585371] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.585377] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.585378] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.785271] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.785280] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.785281] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.785316] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.785324] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.785325] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.785376] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.785382] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.785383] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.785431] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.785437] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.785438] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.985596] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.985605] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.985606] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.985618] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.985625] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.985626] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.985673] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.985680] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.985680] amdgpu: [powerplay] Failed to export SMU metrics table!
[  145.985727] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  145.985734] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  145.985735] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.185251] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.185259] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.185260] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.185272] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.185279] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.185280] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.185346] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.185355] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.185356] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.185404] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.185410] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.185411] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.385244] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.385252] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.385254] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.385266] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.385273] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.385273] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.385338] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.385345] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.385346] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.385394] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.385401] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.385402] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.585158] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.585167] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.585168] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.585180] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.585187] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.585187] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.585234] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.585241] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.585242] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.585288] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.585295] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.585312] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.784947] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.784956] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.784957] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.784969] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.784976] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.784976] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.785023] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.785030] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.785031] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.785078] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.785085] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.785085] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.985381] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.985389] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.985390] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.985403] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.985409] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.985410] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.985456] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.985463] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.985464] amdgpu: [powerplay] Failed to export SMU metrics table!
[  146.985511] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  146.985517] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  146.985518] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.185416] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.185425] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.185426] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.185438] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.185445] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.185446] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.185493] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.185499] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.185500] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.185547] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.185554] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.185554] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.385352] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.385360] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.385361] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.385374] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.385380] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.385381] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.385428] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.385434] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.385435] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.385483] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.385489] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.385490] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.585264] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.585273] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.585274] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.585287] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.585293] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.585294] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.585362] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.585369] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.585370] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.585418] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.585424] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.585425] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.785171] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.785179] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.785181] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.785193] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.785199] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.785200] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.785247] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.785254] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.785255] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.785302] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.785308] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.785309] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.985611] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.985619] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.985621] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.985633] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.985640] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.985641] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.985687] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.985694] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.985694] amdgpu: [powerplay] Failed to export SMU metrics table!
[  147.985742] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  147.985748] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  147.985749] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.169425] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring gfx_0.0.0 timeout, signaled seq=2862, emitted seq=2864
[  148.169492] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma1 timeout, signaled seq=365, emitted seq=367
[  148.169562] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* ring sdma0 timeout, signaled seq=7276, emitted seq=7278
[  148.169627] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process  pid 0 thread  pid 0
[  148.169690] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process superposition pid 1731 thread superposit:cs0 pid 1769
[  148.169692] [drm] GPU recovery disabled.
[  148.169694] [drm] GPU recovery disabled.
[  148.169759] [drm:amdgpu_job_timedout [amdgpu]] *ERROR* Process information: process superposition pid 1731 thread superposit:cs0 pid 1769
[  148.169761] [drm] GPU recovery disabled.
[  148.184433] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.184441] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.184442] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.184455] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.184461] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.184462] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.184509] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.184515] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.184516] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.184563] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.184569] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.184570] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.385298] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.385307] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.385308] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.385320] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.385340] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.385344] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.385397] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.385403] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.385404] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.385452] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.385459] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.385460] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.585308] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.585317] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.585318] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.585346] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.585356] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.585357] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.585407] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.585414] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.585415] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.585463] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.585469] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.585470] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.785289] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.785297] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.785298] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.785310] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.785317] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.785318] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.785392] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.785399] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.785400] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.785449] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.785455] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.785456] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.985758] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.985767] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.985768] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.985781] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.985787] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.985788] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.985835] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.985842] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.985842] amdgpu: [powerplay] Failed to export SMU metrics table!
[  148.985890] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  148.985896] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  148.985897] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.184928] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.184936] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.184937] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.184950] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.184956] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.184957] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.185004] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.185011] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.185012] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.185058] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.185065] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.185066] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.384950] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.384958] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.384959] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.384971] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.384978] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.384979] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.385026] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.385032] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.385033] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.385081] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.385087] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.385088] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.584808] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.584817] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.584818] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.584830] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.584837] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.584838] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.584883] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.584890] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.584891] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.584937] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.584944] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.584945] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.784533] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.784540] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.784541] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.784552] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.784558] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.784559] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.784604] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.784610] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.784611] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.784657] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.784663] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.784664] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.985696] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.985704] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.985706] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.985718] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.985724] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.985725] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.985772] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.985779] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.985780] amdgpu: [powerplay] Failed to export SMU metrics table!
[  149.985827] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  149.985833] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  149.985834] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.184632] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.184641] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.184642] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.184655] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.184661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.184662] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.184708] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.184715] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.184716] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.184763] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.184769] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.184770] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.385569] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.385578] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.385579] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.385591] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.385598] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.385599] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.385646] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.385653] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.385654] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.385701] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.385707] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.385708] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.585654] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.585662] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.585663] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.585676] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.585682] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.585683] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.585730] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.585736] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.585737] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.585785] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.585791] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.585792] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.785571] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.785580] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.785581] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.785593] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.785600] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.785601] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.785648] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.785655] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.785656] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.785704] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.785711] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.785711] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.985823] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.985831] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.985832] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.985845] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.985851] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.985852] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.985899] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.985905] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.985906] amdgpu: [powerplay] Failed to export SMU metrics table!
[  150.985953] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  150.985960] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  150.985960] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.184903] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.184911] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.184912] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.184924] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.184931] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.184932] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.184979] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.184986] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.184987] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.185033] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.185040] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.185041] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.384919] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.384927] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.384928] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.384941] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.384947] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.384948] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.384994] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.385001] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.385001] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.385060] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.385067] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.385067] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.584958] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.584967] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.584968] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.584980] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.584986] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.584987] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.585034] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.585040] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.585041] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.585089] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.585095] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.585096] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.785026] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.785035] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.785036] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.785049] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.785055] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.785056] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.785103] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.785110] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.785111] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.785157] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.785164] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.785165] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.985416] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.985424] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.985425] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.985438] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.985444] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.985445] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.985491] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.985498] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.985499] amdgpu: [powerplay] Failed to export SMU metrics table!
[  151.985546] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  151.985553] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  151.985554] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.185217] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.185226] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.185227] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.185240] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.185246] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.185247] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.185293] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.185300] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.185300] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.185348] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.185354] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.185355] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.385177] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.385185] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.385187] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.385200] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.385206] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.385207] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.385254] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.385261] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.385261] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.385309] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.385315] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.385316] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.585174] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.585183] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.585184] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.585196] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.585203] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.585204] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.585250] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.585257] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.585258] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.585305] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.585311] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.585312] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.785150] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.785158] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.785159] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.785172] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.785178] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.785179] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.785225] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.785232] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.785233] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.785279] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.785286] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.785287] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.985439] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.985447] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.985448] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.985460] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.985467] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.985468] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.985514] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.985520] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.985521] amdgpu: [powerplay] Failed to export SMU metrics table!
[  152.985568] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  152.985575] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  152.985576] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.185198] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.185206] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.185207] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.185220] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.185226] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.185227] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.185275] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.185281] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.185282] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.185329] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.185336] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.185336] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.385313] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.385321] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.385322] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.385335] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.385341] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.385342] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.385404] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.385413] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.385416] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.385465] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.385471] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.385472] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.585261] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.585270] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.585271] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.585283] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.585290] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.585291] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.585337] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.585343] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.585344] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.585412] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.585420] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.585423] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.785306] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.785314] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.785315] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.785328] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.785334] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.785335] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.785400] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.785407] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.785408] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.785466] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.785474] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.785477] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.985633] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.985641] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.985642] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.985654] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.985661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.985662] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.985709] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.985715] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.985716] amdgpu: [powerplay] Failed to export SMU metrics table!
[  153.985763] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  153.985770] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  153.985771] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.185416] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.185424] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.185426] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.185439] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.185445] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.185446] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.185493] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.185500] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.185501] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.185548] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.185555] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.185555] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.385336] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.385344] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.385346] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.385358] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.385364] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.385365] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.385431] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.385438] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.385439] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.385487] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.385493] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.385494] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.585322] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.585331] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.585332] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.585344] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.585351] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.585352] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.585418] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.585428] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.585429] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.585481] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.585487] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.585488] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.785330] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.785338] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.785339] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.785352] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.785358] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.785359] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.785440] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.785447] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.785450] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.785500] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.785507] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.785508] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.985644] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.985653] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.985654] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.985666] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.985673] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.985673] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.985719] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.985726] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.985727] amdgpu: [powerplay] Failed to export SMU metrics table!
[  154.985773] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  154.985780] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  154.985780] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.185418] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.185428] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.185429] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.185442] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.185448] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.185449] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.185500] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.185506] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.185507] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.185554] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.185561] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.185562] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.385416] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.385425] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.385427] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.385440] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.385446] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.385447] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.385499] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.385506] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.385507] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.385554] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.385561] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.385562] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.585314] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.585322] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.585324] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.585336] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.585343] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.585343] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.585391] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.585414] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.585415] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.585469] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.585476] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.585477] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.785309] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.785318] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.785319] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.785332] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.785338] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.785339] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.785386] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.785393] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.785393] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.785480] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.785487] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.785488] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.985697] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.985705] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.985706] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.985718] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.985725] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.985726] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.985773] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.985780] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.985780] amdgpu: [powerplay] Failed to export SMU metrics table!
[  155.985827] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  155.985834] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  155.985835] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.185661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.185670] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.185671] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.185684] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.185690] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.185691] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.185738] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.185744] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.185745] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.185792] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.185799] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.185800] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.385787] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.385795] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.385797] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.385809] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.385815] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.385816] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.385863] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.385869] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.385870] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.385918] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.385924] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.385925] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.585649] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.585657] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.585658] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.585670] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.585677] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.585677] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.585724] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.585730] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.585731] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.585779] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.585785] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.585786] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.785727] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.785736] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.785737] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.785749] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.785756] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.785757] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.785803] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.785810] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.785811] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.785858] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.785865] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.785866] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.986040] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.986049] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.986050] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.986062] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.986069] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.986069] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.986116] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.986123] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.986123] amdgpu: [powerplay] Failed to export SMU metrics table!
[  156.986171] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  156.986177] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  156.986178] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.184748] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.184756] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.184757] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.184770] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.184776] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.184777] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.184823] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.184830] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.184831] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.184878] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.184884] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.184885] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.385666] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.385674] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.385675] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.385688] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.385694] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.385695] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.385742] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.385748] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.385749] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.385796] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.385802] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.385803] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.585578] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.585586] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.585588] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.585600] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.585606] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.585607] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.585654] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.585661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.585662] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.585709] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.585715] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.585716] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.785532] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.785541] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.785542] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.785555] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.785561] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.785562] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.785609] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.785616] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.785616] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.785664] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.785670] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.785671] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.985803] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.985812] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.985813] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.985825] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.985832] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.985832] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.985879] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.985886] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.985887] amdgpu: [powerplay] Failed to export SMU metrics table!
[  157.985934] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  157.985940] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  157.985941] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.184604] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.184612] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.184614] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.184626] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.184632] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.184633] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.184683] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.184690] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.184691] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.184739] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.184745] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.184746] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.385553] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.385561] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.385562] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.385575] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.385581] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.385582] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.385629] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.385636] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.385636] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.385684] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.385690] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.385691] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.585585] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.585593] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.585595] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.585607] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.585613] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.585614] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.585660] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.585667] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.585668] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.585716] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.585722] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.585723] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.785560] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.785568] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.785570] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.785582] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.785589] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.785590] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.785637] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.785644] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.785644] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.785692] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.785699] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.785700] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.985937] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.985946] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.985947] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.985959] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.985966] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.985967] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.986014] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.986021] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.986021] amdgpu: [powerplay] Failed to export SMU metrics table!
[  158.986069] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  158.986075] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  158.986076] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.184790] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.184798] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.184800] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.184812] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.184818] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.184819] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.184866] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.184873] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.184874] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.184921] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.184927] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.184928] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.385779] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.385787] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.385788] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.385800] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.385807] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.385808] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.385854] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.385861] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.385862] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.385909] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.385915] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.385916] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.585703] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.585711] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.585712] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.585725] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.585731] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.585732] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.585779] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.585785] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.585786] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.585833] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.585840] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.585841] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.785676] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.785684] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.785686] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.785698] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.785704] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.785705] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.785752] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.785758] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.785759] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.785807] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.785813] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.785814] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.986085] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.986094] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.986095] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.986107] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.986114] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.986115] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.986161] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.986168] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.986169] amdgpu: [powerplay] Failed to export SMU metrics table!
[  159.986216] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  159.986223] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  159.986224] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.184967] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.184976] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.184977] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.184990] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.184996] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.184997] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.185044] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.185050] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.185051] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.185098] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.185105] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.185105] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.385009] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.385018] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.385019] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.385031] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.385038] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.385039] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.385085] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.385091] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.385092] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.385140] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.385146] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.385147] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.584957] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.584965] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.584967] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.584979] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.584985] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.584986] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.585032] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.585039] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.585039] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.585087] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.585093] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.585094] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.784858] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.784866] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.784868] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.784880] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.784886] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.784887] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.784934] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.784940] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.784941] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.784989] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.784995] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.784996] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.986264] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.986273] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.986274] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.986286] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.986292] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.986293] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.986340] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.986347] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.986348] amdgpu: [powerplay] Failed to export SMU metrics table!
[  160.986395] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  160.986402] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  160.986403] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.185056] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.185064] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.185065] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.185077] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.185084] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.185085] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.185131] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.185138] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.185139] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.185186] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.185193] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.185194] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.384904] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.384912] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.384913] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.384926] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.384932] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.384933] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.384979] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.384986] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.384987] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.385034] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.385040] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.385041] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.584946] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.584954] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.584955] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.584967] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.584974] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.584975] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.585023] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.585030] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.585031] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.585078] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.585084] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.585085] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.784955] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.784964] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.784965] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.784977] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.784983] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.784984] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.785031] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.785037] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.785038] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.785085] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.785092] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.785093] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.985276] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.985285] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.985286] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.985298] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.985304] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.985305] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.985352] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.985359] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.985360] amdgpu: [powerplay] Failed to export SMU metrics table!
[  161.985407] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  161.985413] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  161.985414] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.184767] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.184775] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.184777] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.184789] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.184795] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.184796] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.184843] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.184849] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.184850] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.184898] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.184905] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.184906] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.385681] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.385690] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.385691] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.385706] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.385712] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.385713] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.385761] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.385767] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.385768] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.385815] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.385822] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.385823] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.585613] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.585622] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.585623] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.585635] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.585642] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.585643] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.585690] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.585696] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.585697] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.585745] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.585751] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.585752] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.785632] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.785641] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.785642] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.785654] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.785661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.785661] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.785708] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.785714] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.785715] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.785763] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.785770] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.785770] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.985867] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.985876] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.985877] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.985889] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.985896] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.985897] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.985943] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.985950] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.985951] amdgpu: [powerplay] Failed to export SMU metrics table!
[  162.985998] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  162.986004] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  162.986005] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.184803] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.184811] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.184813] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.184825] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.184832] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.184832] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.184879] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.184886] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.184887] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.184934] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.184941] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.184941] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.385814] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.385822] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.385823] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.385836] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.385842] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.385843] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.385890] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.385897] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.385898] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.385945] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.385951] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.385952] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.585704] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.585713] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.585714] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.585727] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.585733] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.585734] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.585781] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.585788] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.585788] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.585837] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.585843] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.585844] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.785695] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.785704] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.785705] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.785718] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.785724] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.785725] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.785771] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.785778] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.785779] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.785826] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.785832] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.785833] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.986013] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.986022] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.986023] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.986035] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.986041] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.986042] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.986091] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.986098] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.986098] amdgpu: [powerplay] Failed to export SMU metrics table!
[  163.986149] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  163.986155] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  163.986156] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.185033] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.185041] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.185043] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.185055] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.185061] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.185062] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.185108] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.185115] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.185116] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.185163] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.185169] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.185170] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.385096] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.385105] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.385106] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.385119] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.385125] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.385126] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.385173] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.385180] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.385180] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.385227] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.385234] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.385235] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.585129] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.585138] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.585139] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.585152] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.585158] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.585159] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.585205] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.585212] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.585213] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.585260] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.585266] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.585267] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.785049] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.785057] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.785058] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.785070] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.785076] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.785077] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.785125] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.785132] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.785133] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.785181] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.785188] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.785188] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.985353] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.985362] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.985363] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.985376] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.985382] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.985383] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.985430] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.985437] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.985438] amdgpu: [powerplay] Failed to export SMU metrics table!
[  164.985524] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  164.985531] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  164.985532] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.185100] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.185108] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.185110] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.185122] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.185128] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.185129] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.185176] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.185183] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.185184] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.185232] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.185239] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.185240] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.385086] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.385095] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.385096] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.385109] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.385115] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.385116] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.385163] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.385170] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.385171] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.385219] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.385225] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.385226] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.585189] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.585197] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.585198] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.585211] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.585217] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.585218] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.585266] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.585272] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.585273] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.585322] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.585329] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.585330] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.785237] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.785245] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.785247] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.785259] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.785265] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.785266] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.785314] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.785320] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.785321] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.785371] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.785377] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.785378] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.985537] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.985546] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.985547] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.985559] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.985566] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.985566] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.985614] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.985620] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.985621] amdgpu: [powerplay] Failed to export SMU metrics table!
[  165.985669] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  165.985676] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  165.985677] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.184939] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.184948] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.184949] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.184961] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.184968] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.184969] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.185016] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.185022] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.185023] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.185070] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.185076] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.185077] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.384872] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.384881] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.384882] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.384895] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.384901] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.384902] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.384948] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.384955] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.384956] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.385003] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.385009] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.385010] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.585859] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.585867] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.585868] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.585881] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.585887] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.585888] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.585935] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.585941] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.585942] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.585991] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.585997] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.585998] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.785948] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.785956] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.785958] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.785970] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.785976] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.785977] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.786024] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.786030] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.786031] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.786079] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.786085] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.786086] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.985253] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.985262] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.985263] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.985275] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.985281] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.985282] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.985329] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.985336] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.985337] amdgpu: [powerplay] Failed to export SMU metrics table!
[  166.985386] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  166.985392] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  166.985393] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.185122] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.185130] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.185131] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.185144] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.185150] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.185151] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.185197] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.185203] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.185204] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.185251] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.185258] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.185259] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.385209] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.385218] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.385219] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.385231] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.385238] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.385238] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.385285] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.385292] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.385293] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.385340] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.385346] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.385347] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.585228] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.585236] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.585237] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.585250] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.585256] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.585257] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.585304] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.585310] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.585311] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.585358] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.585364] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.585365] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.785263] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.785271] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.785272] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.785285] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.785291] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.785292] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.785338] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.785345] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.785346] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.785394] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.785400] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.785401] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.985669] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.985678] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.985679] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.985691] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.985698] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.985699] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.985745] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.985752] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.985753] amdgpu: [powerplay] Failed to export SMU metrics table!
[  167.985800] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  167.985806] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  167.985807] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.184996] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.185005] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.185006] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.185018] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.185025] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.185026] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.185072] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.185079] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.185079] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.185126] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.185133] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.185134] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.384803] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.384812] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.384813] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.384825] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.384832] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.384833] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.384880] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.384887] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.384888] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.384936] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.384942] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.384943] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.585774] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.585782] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.585783] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.585796] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.585802] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.585803] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.585850] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.585857] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.585858] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.585904] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.585911] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.585912] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.785715] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.785724] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.785725] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.785738] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.785744] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.785745] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.785791] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.785798] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.785799] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.785847] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.785853] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.785854] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.986081] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.986090] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.986091] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.986103] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.986110] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.986111] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.986161] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.986168] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.986169] amdgpu: [powerplay] Failed to export SMU metrics table!
[  168.986216] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  168.986222] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  168.986223] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.184877] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.184885] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.184887] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.184899] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.184906] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.184907] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.184953] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.184959] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.184960] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.185008] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.185015] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.185016] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.385858] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.385866] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.385867] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.385880] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.385886] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.385887] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.385934] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.385940] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.385941] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.385989] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.385995] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.385996] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.585867] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.585876] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.585877] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.585889] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.585896] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.585896] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.585944] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.585950] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.585951] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.585999] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.586005] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.586006] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.785890] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.785898] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.785900] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.785912] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.785918] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.785919] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.785966] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.785973] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.785974] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.786021] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.786027] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.786028] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.986368] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.986377] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.986378] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.986391] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.986397] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.986398] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.986447] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.986453] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.986454] amdgpu: [powerplay] Failed to export SMU metrics table!
[  169.986501] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  169.986508] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  169.986508] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.185206] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.185214] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.185215] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.185228] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.185234] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.185235] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.185282] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.185289] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.185289] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.185339] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.185346] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.185347] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.385170] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.385179] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.385181] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.385193] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.385199] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.385200] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.385246] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.385253] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.385254] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.385302] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.385308] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.385309] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.585105] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.585114] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.585115] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.585127] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.585134] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.585134] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.585181] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.585188] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.585188] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.585236] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.585242] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.585243] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.785176] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.785184] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.785185] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.785197] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.785204] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.785205] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.785252] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.785258] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.785259] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.785306] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.785313] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.785314] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.985587] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.985596] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.985597] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.985609] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.985616] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.985617] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.985663] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.985670] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.985670] amdgpu: [powerplay] Failed to export SMU metrics table!
[  170.985718] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  170.985724] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  170.985725] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.185381] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.185390] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.185391] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.185404] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.185410] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.185411] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.185458] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.185464] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.185465] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.185533] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.185543] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.185544] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.385387] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.385395] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.385396] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.385409] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.385415] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.385416] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.385463] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.385469] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.385470] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.385542] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.385549] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.385551] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.585477] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.585496] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.585497] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.585510] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.585517] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.585517] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.585567] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.585574] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.585574] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.585622] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.585629] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.585629] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.785645] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.785653] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.785655] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.785667] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.785673] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.785674] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.785721] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.785728] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.785729] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.785776] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.785783] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.785784] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.986000] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.986009] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.986010] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.986023] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.986029] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.986030] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.986077] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.986084] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.986085] amdgpu: [powerplay] Failed to export SMU metrics table!
[  171.986133] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  171.986139] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  171.986140] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.184828] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.184836] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.184837] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.184850] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.184856] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.184857] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.184904] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.184910] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.184911] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.184958] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.184965] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.184966] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.385762] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.385770] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.385771] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.385784] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.385790] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.385791] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.385837] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.385844] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.385845] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.385893] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.385899] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.385900] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.585699] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.585707] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.585709] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.585721] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.585727] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.585728] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.585774] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.585781] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.585782] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.585829] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.585835] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.585836] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.785675] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.785684] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.785685] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.785697] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.785704] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.785705] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.785752] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.785758] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.785759] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.785807] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.785813] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.785814] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.985857] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.985865] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.985867] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.985879] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.985885] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.985886] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.985933] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.985939] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.985940] amdgpu: [powerplay] Failed to export SMU metrics table!
[  172.985987] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  172.985994] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  172.985995] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.184911] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.184919] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.184921] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.184933] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.184939] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.184940] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.184986] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.184993] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.184994] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.185042] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.185048] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.185049] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.385883] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.385891] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.385893] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.385905] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.385912] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.385913] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.385959] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.385966] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.385967] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.386015] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.386022] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.386023] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.585798] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.585806] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.585808] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.585820] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.585827] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.585828] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.585875] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.585882] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.585883] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.585931] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.585937] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.585938] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.785833] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.785841] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.785843] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.785856] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.785862] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.785863] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.785910] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.785916] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.785917] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.785965] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.785971] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.785972] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.986179] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.986187] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.986189] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.986201] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.986208] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.986209] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.986256] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.986262] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.986263] amdgpu: [powerplay] Failed to export SMU metrics table!
[  173.986313] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  173.986319] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  173.986320] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.184955] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.184963] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.184964] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.184977] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.184983] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.184984] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.185030] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.185037] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.185038] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.185085] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.185092] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.185093] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.384751] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.384760] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.384761] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.384774] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.384780] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.384781] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.384827] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.384834] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.384835] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.384883] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.384889] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.384890] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.585701] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.585709] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.585710] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.585723] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.585729] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.585730] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.585777] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.585783] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.585784] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.585832] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.585839] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.585840] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.785758] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.785766] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.785767] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.785780] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.785787] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.785787] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.785835] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.785841] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.785842] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.785890] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.785896] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.785897] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.986092] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.986100] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.986101] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.986113] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.986120] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.986121] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.986170] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.986177] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.986178] amdgpu: [powerplay] Failed to export SMU metrics table!
[  174.986227] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  174.986233] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  174.986234] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.184212] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.184219] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.184220] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.184230] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.184237] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.184238] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.184273] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.184280] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.184281] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.184318] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.184324] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.184325] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.384241] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.384249] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.384250] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.384260] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.384266] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.384267] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.384301] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.384307] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.384308] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.384343] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.384349] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.384350] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.584202] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.584209] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.584210] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.584220] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.584226] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.584227] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.584261] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.584267] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.584268] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.584303] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.584309] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.584310] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.784079] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.784086] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.784087] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.784097] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.784104] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.784104] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.784138] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.784144] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.784145] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.784179] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.784186] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.784186] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.985388] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.985395] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.985396] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.985406] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.985413] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.985413] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.985447] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.985453] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.985454] amdgpu: [powerplay] Failed to export SMU metrics table!
[  175.985489] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  175.985508] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  175.985510] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.184904] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.184912] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.184914] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.184926] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.184932] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.184933] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.184980] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.184987] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.184987] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.185035] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.185042] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.185043] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.385861] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.385869] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.385870] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.385883] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.385889] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.385890] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.385937] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.385944] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.385945] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.385992] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.385999] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.385999] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.585749] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.585758] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.585759] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.585772] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.585778] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.585779] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.585826] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.585832] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.585833] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.585880] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.585887] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.585888] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.785727] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.785735] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.785737] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.785749] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.785755] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.785756] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.785803] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.785810] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.785811] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.785858] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.785864] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.785865] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.986082] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.986091] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.986092] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.986104] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.986110] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.986111] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.986166] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.986172] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.986173] amdgpu: [powerplay] Failed to export SMU metrics table!
[  176.986222] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  176.986229] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  176.986230] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.184911] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.184919] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.184921] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.184933] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.184939] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.184940] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.184986] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.184993] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.184994] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.185041] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.185048] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.185049] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.384831] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.384839] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.384840] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.384853] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.384859] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.384860] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.384907] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.384914] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.384915] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.384971] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.384977] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.384978] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.585868] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.585876] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.585877] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.585889] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.585896] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.585897] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.585949] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.585956] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.585957] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.586007] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.586014] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.586015] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.784777] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.784785] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.784786] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.784799] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.784805] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.784806] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.784852] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.784859] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.784860] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.784909] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.784916] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.784917] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.986154] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.986162] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.986163] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.986176] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.986182] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.986183] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.986229] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.986236] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.986237] amdgpu: [powerplay] Failed to export SMU metrics table!
[  177.986285] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  177.986291] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  177.986292] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.184880] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.184889] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.184890] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.184904] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.184910] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.184911] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.184961] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.184968] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.184968] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.185017] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.185023] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.185024] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.384695] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.384703] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.384704] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.384717] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.384723] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.384724] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.384773] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.384780] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.384781] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.384829] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.384835] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.384836] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.585704] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.585712] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.585714] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.585726] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.585732] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.585733] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.585780] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.585786] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.585787] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.585835] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.585841] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.585842] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.785668] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.785677] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.785678] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.785690] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.785697] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.785698] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.785745] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.785752] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.785753] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.785800] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.785807] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.785808] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.985051] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.985060] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.985061] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.985073] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.985080] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.985081] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.985128] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.985134] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.985135] amdgpu: [powerplay] Failed to export SMU metrics table!
[  178.985183] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  178.985190] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  178.985191] amdgpu: [powerplay] Failed to export SMU metrics table!
[  179.184661] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  179.184669] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  179.184670] amdgpu: [powerplay] Failed to export SMU metrics table!
[  179.184683] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  179.184689] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  179.184690] amdgpu: [powerplay] Failed to export SMU metrics table!
[  179.184736] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  179.184743] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  179.184743] amdgpu: [powerplay] Failed to export SMU metrics table!
[  179.184791] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb, param 0x80
[  179.184798] amdgpu: [powerplay] Failed to send message 0xe, response 0xfffffffb param 0x80
[  179.184798] amdgpu: [powerplay] Failed to export SMU metrics table!

--------------4AD4ADC6047E5DD0B183146A--
