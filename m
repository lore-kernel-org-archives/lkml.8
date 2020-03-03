Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D33DAC3F2D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F61220CC7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 19:25:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730795AbgCCTZD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 14:25:03 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:58421 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgCCTZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 14:25:03 -0500
Received: from [192.168.1.183] ([37.4.249.171]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1M2ep5-1j5ceZ31bj-0049oz; Tue, 03 Mar 2020 20:24:44 +0100
Subject: Re: [PATCH] ARM: dts: bcm283x: Use firmware PM driver for V3D
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>
Cc:     devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wahrenst@gmx.net
References: <20200303173217.3987-1-nsaenzjulienne@suse.de>
 <736f0c59-352b-03b2-f77f-bfc22171b3fb@i2se.com>
 <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
From:   Stefan Wahren <stefan.wahren@i2se.com>
Openpgp: preference=signencrypt
Autocrypt: addr=stefan.wahren@i2se.com; keydata=
 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 AQ==
Message-ID: <d3d40174-9c08-f42f-e088-08e23c2dc029@i2se.com>
Date:   Tue, 3 Mar 2020 20:24:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <03fcb1e2bc7f3ff389b6dfbf3964e159a93ae835.camel@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
X-Provags-ID: V03:K1:IkWpsoVH98L129oQ+DC/MXNkudtqePBTdIMqu+sK/BdhR0XlYhS
 AKBNqQ2oNGdmn75EjZEc8ONgCpGMWrMk692pqbLCTyGgUvNHDoHluFTF7DKVaFvXaO4mxac
 dfvfUpZNdrdhLyXIG6X9VqIsejlDKAOVzkMBijbvkmzdX2o0zTUmv7IYEG45RAJ3V39Dk/Y
 4d0dhvCgG8s7o+AIzZZfA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XmaQDK+K2fE=:lwARB2S3NIWpOMHq9p/sDx
 YhRTEX7CACRQH5ohoMa2ovO/iUqmJcvJQP45lPEcAcOrKs1QLzMLh66QBlV6YzzebkViCoq+B
 uZQ3cKUm27WUOXJkwMXEu4272alwcb6SonrQVnaYheycqGfusoU6KK+cY659K9++/Ut0BmXtY
 gJrJ6pOjwEWqb6pJHMWKDWmgI9EhWlsr87Df8p7fvbpRcUS4LSiOemJRenuX75O9CNJltIMW/
 WMD9kGXe/JlAKEafkBvfSHNQFy8tMQ0wqnRTbsTHX6enqLk+T8CRyYn7hArBYdhQ7JPIMhP6v
 xtdfMu1M8pmLJg/VoWJEkqi14eFMqtcV6+WxICtCmtkIoVJdpI2iPriL1r0kXml1aSF+hZE0w
 lyiDA1FTEwXUxlJOhGjJJgPtxPY19p+dj/zM6mZFO1EqAXej2NeefVojh71zolVD1+KQPw5Yj
 NrrGZ44e3rQ2wySwuZtoQFV3kovp4ZDeqkCA1/aYMV6Sz0ZD5r6m0rriqFh7YQqFqhB6uEOlp
 n3g7ldiOtHvP/1OfGZJGSqnCeLNEQwD+yVzHRy/qVzHwKOgBsS4cgITKz5FGEFfFNMycXlPCY
 7EFAR3GfO5qloOtYZcB2BJQiQ1wpXza7bFRtq+xdNq3k/S4wiGZP5jgz6nTGZgxaX1l/RlJ4W
 ecFOF8effqsbPsRCQogvwAphHyIFEa7OMP6Wt6I8fxG3aevK30H8nebCAl74KBJr7cRZaUJo7
 kh8i9pI5wn+h4vDBaUiURg2WYyqKeQxSYFR0gFYt0e2mBY336ZDPUtSwPMTYlaOLDeKLJ9rls
 bXTDNEY4ZnGPXvi5WrpUF7jI7YgU0NfRl/VxqdJaC5TzLSKUjj2NUTk7aFgRwNN8wMKQPDT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.03.20 um 19:37 schrieb Nicolas Saenz Julienne:
> On Tue, 2020-03-03 at 19:17 +0100, Stefan Wahren wrote:
>> Hi Nicolas,
>>
>> Am 03.03.20 um 18:32 schrieb Nicolas Saenz Julienne:
>>> The register based driver turned out to be unstable, specially on RPi3a+
>>> but not limited to it. While a fix is being worked on, we roll back to
>>> using firmware based scheme.
>>>
>>> Fixes: e1dc2b2e1bef ("ARM: bcm283x: Switch V3D over to using the PM driver
>>> instead of firmware")
>>> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>>> ---
>>>
>>> See https://github.com/raspberrypi/linux/issues/3046 for more reference.
>>> Note: I tested this on RPi3b, RPi3a+ and RPi2b.
>> as i already wrote this prevent X to start on current Raspbian on my
>> Raspberry Pi 3A+ (multi_v7_defconfig, no u-boot). We must be careful here.
>>
>> I will take a look at the debug UART. Maybe there are more helpful
>> information.
> It seems we're seeing different things, I tested this on raspbian
> (multi_v7_defconfig) and on arm64. I'll try again from scratch tomorrow.

My modifications to the Raspbian image (from 13.2.2020) are little:

- specify devicetree to config.txt
- change console to ttyS1 and remove "silent" in cmdline.txt
- rename all original kernel7*.img
- copy dtb and kernel7.img to boot partition
- copy kernel modules to root partition

The debug UART works fine, maybe the dmesg gives us a hint:

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 5.6.0-rc2-next-20200220-00004-gaf4f0f5
(stefan@Latitude-E4310) (gcc version 7.2.1 20171011 (Linaro GCC
7.2-2017.11)) #16 SMP Tue Mar 3 19:03:36 CET 2020
[    0.000000] CPU: ARMv7 Processor [410fd034] revision 4 (ARMv7),
cr=10c5383d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] OF: fdt: Machine model: Raspberry Pi 3 Model A Plus Rev 1.0
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] Reserved memory: created CMA memory pool at 0x17800000,
size 64 MiB
[    0.000000] OF: reserved mem: initialized node linux,cma, compatible
id shared-dma-pool
[    0.000000] On node 0 totalpages: 114688
[    0.000000]   DMA zone: 896 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 114688 pages, LIFO batch:31
[    0.000000] percpu: Embedded 20 pages/cpu s49292 r8192 d24436 u81920
[    0.000000] pcpu-alloc: s49292 r8192 d24436 u81920 alloc=20*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages:
113792
[    0.000000] Kernel command line:
video=HDMI-A-1:1920x1200M@60,margin_left=0,margin_right=0,margin_top=0,margin_bottom=0
dma.dmachans=0x7f35 bcm2709.boardrev=0x9020e0 bcm2709.serial=0x48390b9c
bcm2709.uart_clock=48000000 bcm2709.disk_led_gpio=29
bcm2709.disk_led_active_low=0 smsc95xx.macaddr=B8:27:EB:39:0B:9C
vc_mem.mem_base=0x1ec00000 vc_mem.mem_size=0x20000000 
console=ttyS1,115200 console=tty1 root=PARTUUID=ea7d04d6-02
rootfstype=ext4 elevator=deadline fsck.repair=yes rootwait splash
plymouth.ignore-serial-consoles
[    0.000000] Kernel parameter elevator= does not have any effect anymore.
               Please use sysfs to set IO scheduler for individual devices.
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144
bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072
bytes, linear)
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] Memory: 364964K/458752K available (13312K kernel code,
1812K rwdata, 5368K rodata, 2048K init, 407K bss, 28252K reserved,
65536K cma-reserved, 0K highmem)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] rcu: Hierarchical RCU implementation.
[    0.000000] rcu:     RCU event tracing is enabled.
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=16 to
nr_cpu_ids=4.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay
is 10 jiffies.
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4
[    0.000000] NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
[    0.000000] [Firmware Bug]: Bootloader left irq enabled: bank 1 irq 9
[    0.000000] random: get_random_bytes called from
start_kernel+0x588/0x71c with crng_init=0
[    0.000009] sched_clock: 32 bits at 1000kHz, resolution 1000ns, wraps
every 2147483647500ns
[    0.000029] clocksource: timer: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 1911260446275 ns
[    0.000086] bcm2835: system timer (irq = 27)
[    0.002377] arch_timer: cp15 timer(s) running at 19.20MHz (phys).
[    0.002393] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
[    0.002409] sched_clock: 56 bits at 19MHz, resolution 52ns, wraps
every 4398046511078ns
[    0.002421] Switching to timer-based delay loop, resolution 52ns
[    0.002836] Console: colour dummy device 80x30
[    0.003448] printk: console [tty1] enabled
[    0.003516] Calibrating delay loop (skipped), value calculated using
timer frequency.. 38.40 BogoMIPS (lpj=192000)
[    0.003552] pid_max: default: 32768 minimum: 301
[    0.003732] Mount-cache hash table entries: 1024 (order: 0, 4096
bytes, linear)
[    0.003762] Mountpoint-cache hash table entries: 1024 (order: 0, 4096
bytes, linear)
[    0.004585] CPU: Testing write buffer coherency: ok
[    0.004991] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.005529] Setting up static identity map for 0x300000 - 0x3000ac
[    0.006338] rcu: Hierarchical SRCU implementation.
[    0.008341] EFI services will not be available.
[    0.008560] smp: Bringing up secondary CPUs ...
[    0.009292] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.010177] CPU2: thread -1, cpu 2, socket 0, mpidr 80000002
[    0.010936] CPU3: thread -1, cpu 3, socket 0, mpidr 80000003
[    0.011054] smp: Brought up 1 node, 4 CPUs
[    0.011120] SMP: Total of 4 processors activated (153.60 BogoMIPS).
[    0.011138] CPU: All CPU(s) started in HYP mode.
[    0.011153] CPU: Virtualization extensions available.
[    0.011727] devtmpfs: initialized
[    0.019108] VFP support v0.3: implementor 41 architecture 3 part 40
variant 3 rev 4
[    0.019442] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.019484] futex hash table entries: 1024 (order: 4, 65536 bytes,
linear)
[    0.022057] pinctrl core: initialized pinctrl subsystem
[    0.023686] thermal_sys: Registered thermal governor 'step_wise'
[    0.023975] DMI not present or invalid.
[    0.024461] NET: Registered protocol family 16
[    0.027847] DMA: preallocated 256 KiB pool for atomic coherent
allocations
[    0.031365] cpuidle: using governor menu
[    0.032542] No ATAGs?
[    0.032667] hw-breakpoint: found 5 (+1 reserved) breakpoint and 4
watchpoint registers.
[    0.032704] hw-breakpoint: maximum watchpoint size is 8 bytes.
[    0.035015] Serial: AMBA PL011 UART driver
[    0.067972] AT91: Could not find identification node
[    0.069885] iommu: Default domain type: Translated
[    0.070176] vgaarb: loaded
[    0.071021] SCSI subsystem initialized
[    0.071228] libata version 3.00 loaded.
[    0.071500] usbcore: registered new interface driver usbfs
[    0.071562] usbcore: registered new interface driver hub
[    0.071626] usbcore: registered new device driver usb
[    0.072750] pps_core: LinuxPPS API ver. 1 registered
[    0.072769] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.072815] PTP clock support registered
[    0.072984] EDAC MC: Ver: 3.0.0
[    0.076379] clocksource: Switched to clocksource arch_sys_counter
[    1.682452] simple-framebuffer 1e330000.framebuffer: framebuffer at
0x1e330000, 0x8ca000 bytes, mapped to 0x(ptrval)
[    1.682503] simple-framebuffer 1e330000.framebuffer: format=a8r8g8b8,
mode=1920x1200x32, linelength=7680
[    1.740046] Console: switching to colour frame buffer device 240x75
[    1.796947] simple-framebuffer 1e330000.framebuffer: fb0: simplefb
registered!
[    1.804958] NET: Registered protocol family 2
[    1.805820] tcp_listen_portaddr_hash hash table entries: 512 (order:
0, 6144 bytes, linear)
[    1.806182] TCP established hash table entries: 4096 (order: 2, 16384
bytes, linear)
[    1.806581] TCP bind hash table entries: 4096 (order: 3, 32768 bytes,
linear)
[    1.806954] TCP: Hash tables configured (established 4096 bind 4096)
[    1.807318] UDP hash table entries: 256 (order: 1, 8192 bytes, linear)
[    1.807601] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes,
linear)
[    1.808047] NET: Registered protocol family 1
[    1.808753] RPC: Registered named UNIX socket transport module.
[    1.808992] RPC: Registered udp transport module.
[    1.809180] RPC: Registered tcp transport module.
[    1.809369] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    1.809629] PCI: CLS 0 bytes, default 64
[    1.812464] Initialise system trusted keyrings
[    1.812816] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    1.821177] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    1.822224] NFS: Registering the id_resolver key type
[    1.822454] Key type id_resolver registered
[    1.822626] Key type id_legacy registered
[    1.822800] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.823098] ntfs: driver 2.1.32 [Flags: R/O].
[    1.823732] Key type asymmetric registered
[    1.823906] Asymmetric key parser 'x509' registered
[    1.824140] Block layer SCSI generic (bsg) driver version 0.4 loaded
(major 247)
[    1.824434] io scheduler mq-deadline registered
[    1.824617] io scheduler kyber registered
[    1.847075] bcm2835-dma 3f007000.dma: WARN: Device release is not
defined so it is not safe to unbind this driver while in use
[    1.902312] Serial: 8250/16550 driver, 5 ports, IRQ sharing enabled
[    1.905672] printk: console [ttyS1] disabled
[    1.905933] 3f215040.serial: ttyS1 at MMIO 0x3f215040 (irq = 53,
base_baud = 31250000) is a 16550
[    2.662737] printk: console [ttyS1] enabled
[    2.668957] SuperH (H)SCI(F) driver initialized
[    2.674563] msm_serial: driver initialized
[    2.679048] STMicroelectronics ASC driver initialized
[    2.685391] STM32 USART driver initialized
[    2.691094] bcm2835-rng 3f104000.rng: hwrng registered
[    2.709412] brd: module loaded
[    2.721290] loop: module loaded
[    2.726215] bcm2835-power bcm2835-power: Broadcom BCM2835 power
domains driver
[    2.743178] libphy: Fixed MDIO Bus: probed
[    2.748861] CAN device driver interface
[    2.753703] bgmac_bcma: Broadcom 47xx GBit MAC driver loaded
[    2.760642] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    2.766796] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    2.786603] igb: Intel(R) Gigabit Ethernet Network Driver - version
5.6.0-k
[    2.807399] igb: Copyright (c) 2007-2014 Intel Corporation.
[    2.830193] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB
Ethernet driver
[    2.851561] usbcore: registered new interface driver pegasus
[    2.871202] usbcore: registered new interface driver asix
[    2.890391] usbcore: registered new interface driver ax88179_178a
[    2.910173] usbcore: registered new interface driver cdc_ether
[    2.929649] usbcore: registered new interface driver smsc75xx
[    2.948874] usbcore: registered new interface driver smsc95xx
[    2.967876] usbcore: registered new interface driver net1080
[    2.986629] usbcore: registered new interface driver cdc_subset
[    3.005558] usbcore: registered new interface driver zaurus
[    3.024053] usbcore: registered new interface driver cdc_ncm
[    3.044556] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.063973] ehci-pci: EHCI PCI platform driver
[    3.081315] ehci-platform: EHCI generic platform driver
[    3.099569] ehci-orion: EHCI orion driver
[    3.116630] SPEAr-ehci: EHCI SPEAr driver
[    3.133657] ehci-st: EHCI STMicroelectronics driver
[    3.151594] ehci-exynos: EHCI Exynos driver
[    3.168746] ehci-atmel: EHCI Atmel driver
[    3.185575] tegra-ehci: Tegra EHCI driver
[    3.202397] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    3.221473] ohci-pci: OHCI PCI platform driver
[    3.238731] ohci-platform: OHCI generic platform driver
[    3.256812] SPEAr-ohci: OHCI SPEAr driver
[    3.273478] ohci-st: OHCI STMicroelectronics driver
[    3.290953] ohci-atmel: OHCI Atmel driver
[    3.307905] usbcore: registered new interface driver usb-storage
[    3.331014] i2c /dev entries driver
[    3.348370] i2c-bcm2835 3f805000.i2c: Could not read clock-frequency
property
[    3.377645] bcm2835-wdt bcm2835-wdt: Broadcom BCM2835 watchdog timer
[    3.399701] sdhci: Secure Digital Host Controller Interface driver
[    3.418153] sdhci: Copyright(c) Pierre Ossman
[    3.436204] Synopsys Designware Multimedia Card Interface Driver
[    3.551786] sdhost-bcm2835 3f202000.mmc: loaded - DMA enabled (>1)
[    3.570306] sdhci-pltfm: SDHCI platform and OF driver helper
[    3.621524] mmc1: SDHCI controller on 3f300000.sdhci [3f300000.sdhci]
using PIO
[    3.642980] ledtrig-cpu: registered to indicate activity on CPUs
[    3.662187] usbcore: registered new interface driver usbhid
[    3.680057] usbhid: USB HID core driver
[    3.697071] bcm2835-mbox 3f00b880.mailbox: mailbox enabled
[    3.717577] drop_monitor: Initializing network drop monitor service
[    3.737308] NET: Registered protocol family 10
[    3.755206] Segment Routing with IPv6
[    3.771314] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.790332] NET: Registered protocol family 17
[    3.807142] can: controller area network core (rev 20170425 abi 9)
[    3.825888] NET: Registered protocol family 29
[    3.842831] can: raw protocol (rev 20170425)
[    3.859515] can: broadcast manager protocol (rev 20170425 t)
[    3.877613] can: netlink gateway (rev 20190810) max_hops=1
[    3.896084] Key type dns_resolver registered
[    3.913830] Registering SWP/SWPB emulation handler
[    3.931416] Loading compiled-in X.509 certificates
[    3.939999] 3f201000.serial: ttyAMA0 at MMIO 0x3f201000 (irq = 81,
base_baud = 0) is a PL011 rev2
[    3.962680] mmc1: queuing unknown CIS tuple 0x80 (2 bytes)
[    3.970925] serial serial0: tty port ttyAMA0 registered
[    3.990335] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    4.024105] raspberrypi-firmware soc:firmware: Attached to firmware
from 2020-02-12 12:38
[    4.025835] mmc1: queuing unknown CIS tuple 0x80 (3 bytes)
[    4.064042] raspberrypi-clk raspberrypi-clk: CPU frequency range: min
600000000, max 1400000000
[    4.065631] mmc1: queuing unknown CIS tuple 0x80 (7 bytes)
[    4.111093] mmc0: host does not support reading read-only switch,
assuming write-enable
[    4.132615] mmc0: new high speed SDHC card at address e624
[    4.146821] mmcblk0: mmc0:e624 SL16G 14.8 GiB
[    4.161171] dwc2 3f980000.usb: 3f980000.usb supply vusb_d not found,
using dummy regulator
[    4.165053]  mmcblk0: p1 p2
[    4.176077] dwc2 3f980000.usb: 3f980000.usb supply vusb_a not found,
using dummy regulator
[    4.225282] random: fast init done
[    4.243026] mmc1: new high speed SDIO card at address 0001
[    4.257552] dwc2 3f980000.usb: DWC OTG Controller
[    4.268828] dwc2 3f980000.usb: new USB bus registered, assigned bus
number 1
[    4.282498] dwc2 3f980000.usb: irq 33, io mem 0x3f980000
[    4.294826] hub 1-0:1.0: USB hub found
[    4.305479] hub 1-0:1.0: 1 port detected
[    4.320665] hctosys: unable to open rtc device (rtc0)
[    4.336481] EXT4-fs (mmcblk0p2): INFO: recovery required on readonly
filesystem
[    4.350689] EXT4-fs (mmcblk0p2): write access will be enabled during
recovery
[    4.662181] EXT4-fs (mmcblk0p2): recovery complete
[    4.684707] EXT4-fs (mmcblk0p2): mounted filesystem with ordered data
mode. Opts: (null)
[    4.700021] VFS: Mounted root (ext4 filesystem) readonly on device
179:2.
[    4.717256] devtmpfs: mounted
[    4.729196] Freeing unused kernel memory: 2048K
[    4.740743] Run /sbin/init as init process
[    4.751629]   with arguments:
[    4.751631]     /sbin/init
[    4.751633]     splash
[    4.751634]   with environment:
[    4.751637]     HOME=/
[    4.751638]     TERM=linux
[    4.776391] usb 1-1: new high-speed USB device number 2 using dwc2
[    4.817354] hub 1-1:1.0: USB hub found
[    4.833504] hub 1-1:1.0: 4 ports detected
[    5.256406] usb 1-1.1: new low-speed USB device number 3 using dwc2
[    5.365324] systemd[1]: System time before build time, advancing clock.
[    5.448029] systemd[1]: systemd 241 running in system mode. (+PAM
+AUDIT +SELINUX +IMA +APPARMOR +SMACK +SYSVINIT +UTMP +LIBCRYPTSETUP
+GCRYPT +GNUTLS +ACL +XZ +LZ4 +SECCOMP +BLKID +ELFUTILS +KMOD -IDN2 +IDN
-PCRE2 default-hierarchy=hybrid)
[    5.490506] systemd[1]: Detected architecture arm.
[    5.508899] input: Logitech USB Keyboard as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1:1.0/0003:046D:C31C.0001/input/input0

[    5.559836] systemd[1]: Set hostname to <raspberrypi>.
[    5.596959] hid-generic 0003:046D:C31C.0001: input: USB HID v1.10
Keyboard [Logitech USB Keyboard] on usb-3f980000.usb-1.1/input0
[    5.630041] input: Logitech USB Keyboard Consumer Control as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1:1.1/0003:046D:C31C.0002/input/input1

[    5.716627] input: Logitech USB Keyboard System Control as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.1/1-1.1:1.1/0003:046D:C31C.0002/input/input2

[    5.738426] hid-generic 0003:046D:C31C.0002: input: USB HID v1.10
Device [Logitech USB Keyboard] on usb-3f980000.usb-1.1/input1
[    5.856540] systemd[1]: File
/lib/systemd/system/systemd-journald.service:12 configures an IP
firewall (IPAddressDeny=any), but the local system does not support
BPF/cgroup based firewalling.
[    5.885933] systemd[1]: Proceeding WITHOUT firewalling in effect!
(This warning is only shown for the first loaded unit using IP
firewalling.)
[    5.956406] usb 1-1.3: new low-speed USB device number 4 using dwc2
[    6.214508] input: Logitech USB Optical Mouse as
/devices/platform/soc/3f980000.usb/usb1/1-1/1-1.3/1-1.3:1.0/0003:046D:C077.0003/input/input3

[    6.215790] random: crng init done
[    6.237381] hid-generic 0003:046D:C077.0003: input: USB HID v1.11
Mouse [Logitech USB Optical Mouse] on usb-3f980000.usb-1.3/input0
[    6.288006] systemd[1]: Listening on Journal Socket (/dev/log).
[    6.314818] systemd[1]: Listening on udev Kernel Socket.
[    6.339003] systemd[1]: Listening on Journal Socket.
[    6.364011] systemd[1]: Mounting Kernel Debug File System...
[    6.393160] systemd[1]: Starting Restore / save the current clock...
[    7.193819] EXT4-fs (mmcblk0p2): re-mounted. Opts: (null)
[    7.278860] systemd-journald[132]: Received request to flush runtime
journal from PID 1
[    8.077816] usb_phy_generic phy: phy supply vcc not found, using
dummy regulator
[    8.180532] Bluetooth: Core ver 2.22
[    8.180588] NET: Registered protocol family 31
[    8.180591] Bluetooth: HCI device and connection manager initialized
[    8.180608] Bluetooth: HCI socket layer initialized
[    8.180617] Bluetooth: L2CAP socket layer initialized
[    8.180630] Bluetooth: SCO socket layer initialized
[    8.235425] Bluetooth: HCI UART driver ver 2.3
[    8.235437] Bluetooth: HCI UART protocol H4 registered
[    8.235806] Bluetooth: HCI UART protocol Broadcom registered
[    8.235954] hci_uart_bcm serial0-0: serial0-0 supply vbat not found,
using dummy regulator
[    8.236013] hci_uart_bcm serial0-0: serial0-0 supply vddio not found,
using dummy regulator
[    8.236061] hci_uart_bcm serial0-0: No reset resource, using default
baud rate
[    8.346843] uart-pl011 3f201000.serial: no DMA platform data
[    8.390845] cfg80211: Loading compiled-in X.509 certificates for
regulatory database
[    8.450496] debugfs: Directory '3f902000.hdmi' with parent 'vc4-hdmi'
already present!
[    8.451520] vc4_hdmi 3f902000.hdmi: vc4-hdmi-hifi <-> 3f902000.hdmi
mapping ok
[    8.451541] vc4_hdmi 3f902000.hdmi: ASoC: no DMI vendor name!
[    8.465617] vc4-drm soc:gpu: bound 3f902000.hdmi (ops vc4_hdmi_ops
[vc4])
[    8.466033] vc4-drm soc:gpu: bound 3f806000.vec (ops vc4_vec_ops [vc4])
[    8.466159] vc4-drm soc:gpu: bound 3f004000.txp (ops vc4_txp_ops [vc4])
[    8.466292] vc4-drm soc:gpu: bound 3f400000.hvs (ops vc4_hvs_ops [vc4])
[    8.466649] vc4-drm soc:gpu: bound 3f206000.pixelvalve (ops
vc4_crtc_ops [vc4])
[    8.466889] vc4-drm soc:gpu: bound 3f207000.pixelvalve (ops
vc4_crtc_ops [vc4])
[    8.467154] vc4-drm soc:gpu: bound 3f807000.pixelvalve (ops
vc4_crtc_ops [vc4])
[    8.467262] vc4-drm soc:gpu: bound 3fc00000.v3d (ops vc4_v3d_ops [vc4])
[    8.467272] checking generic (1e330000 8ca000) vs hw (0 ffffffff)
[    8.467278] fb0: switching to vc4drmfb from simple
[    8.473639] Console: switching to colour dummy device 80x30
[    8.473714] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    8.473718] [drm] Driver supports precise vblank timestamp query.
[    8.476777] [drm] Initialized vc4 0.0.0 20140616 for soc:gpu on minor 0
[    8.534359] Console: switching to colour frame buffer device 90x30
[    8.550245] vc4-drm soc:gpu: fb0: vc4drmfb frame buffer device
[    8.601137] Bluetooth: hci0: BCM: chip id 107
[    8.603287] Bluetooth: hci0: BCM: features 0x2f
[    8.634065] Bluetooth: hci0: BCM4345C0
[    8.634081] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0000
[    8.786208] cfg80211: Loaded X.509 cert 'sforshee: 00b28ddf47aef9cea7'
[    8.847887] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    8.877556] brcmfmac mmc1:0001:1: Direct firmware load for
brcm/brcmfmac43455-sdio.raspberrypi,3-model-a-plus.txt failed with error -2
[    9.021080] brcmfmac: brcmf_fw_alloc_request: using
brcm/brcmfmac43455-sdio for chip BCM4345/6
[    9.046953] brcmfmac: brcmf_c_preinit_dcmds: Firmware: BCM4345/6 wl0:
Feb 27 2018 03:15:32 version 7.45.154 (r684107 CY) FWID 01-4fbe0b04
[   12.541155] Adding 102396k swap on /var/swap.  Priority:-2 extents:1
across:102396k SS
[   14.418586] Bluetooth: hci0: BCM4345C0 (003.001.025) build 0290
[   18.463530] IPv6: ADDRCONF(NETDEV_CHANGE): wlan0: link becomes ready


