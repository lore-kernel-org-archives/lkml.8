Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952FCC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 511D12071B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 23:12:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGNXMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 19:12:43 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:59965 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726187AbgGNXMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 19:12:41 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1jvU6E-001Nlt-QZ; Wed, 15 Jul 2020 01:12:34 +0200
Received: from p57bd93f9.dip0.t-ipconnect.de ([87.189.147.249] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1jvU6E-003vcT-Dx; Wed, 15 Jul 2020 01:12:34 +0200
Subject: Re: ioremap and dma cleanups and fixes for superh (2nd resend)
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Rich Felker <dalias@libc.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200714121856.955680-1-hch@lst.de>
 <b0745e43-0ff1-58f7-70d5-60b9c8b8d81b@physik.fu-berlin.de>
 <20200714155914.GA24404@brightrain.aerifal.cx>
 <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <011f29e6-ad71-366e-dbff-bc8471f3da60@physik.fu-berlin.de>
Date:   Wed, 15 Jul 2020 01:12:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <8cbf2963-d0e4-0ca8-4ffe-c2057694447f@physik.fu-berlin.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.147.249
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have applied Christoph's full series on top of Linus' tree and I can confirm that
the kernel boots fine on my SH-7785LCR board.

Thus, for the whole series of patches:

Tested-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

However, independent of Christoph's series, the kernels throws two backtraces during
boot which I think should require a git bisect (unless I missed a configuration option
as I trimmed down the kernel a bit to make sure it's not too big).

See the traces below and let me know what you think.

Adrian

====================================================================================

## Booting kernel from Legacy Image at 89000000 ...
   Image Name:   Linux-5.8.0-rc5-00026-g22b7a96ec
   Image Type:   SuperH Linux Kernel Image (gzip compressed)
   Data Size:    4058011 Bytes = 3.9 MiB
   Load Address: 80001000
   Entry Point:  80002000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
[    0.000000] Linux version 5.8.0-rc5-00026-g22b7a96ece82 (glaubitz@epyc) (sh4-linux-gnu-gcc (Debian 9.3.0-13) 9.3.0, GNU ld (GNU Binutils for Debian) 2.34.90.20200706) #3 PREEMPT Wed Jul 15 01:03:46 CEST 2020
[    0.000000] Boot params:
[    0.000000] ... MOUNT_ROOT_RDONLY - 00000000
[    0.000000] ... RAMDISK_FLAGS     - 00000000
[    0.000000] ... ORIG_ROOT_DEV     - 00000000
[    0.000000] ... LOADER_TYPE       - 00000000
[    0.000000] ... INITRD_START      - 00000000
[    0.000000] ... INITRD_SIZE       - 00000000
[    0.000000] Booting machvec: SH7785LCR
[    0.000000] PMB: boot mappings:
[    0.000000]        0x00080000 -> 0x00040000 [  512MB   cached ]
[    0.000000]        0x000a0000 -> 0x00040000 [   16MB uncached ]
[    0.000000] Zone ranges:
[    0.000000]   Normal   [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000040000000-0x000000005fffffff]
[    0.000000] On node 0 totalpages: 131072
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 131072 pages, LIFO batch:31
[    0.000000] Renesas Technology Corp. R0P7785LC0011RL support.
[    0.000000] pcpu-alloc: s0 r0 d32768 u32768 alloc=1*32768
[    0.000000] pcpu-alloc: [0] 0 
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: console=ttySC1,115200 root=/dev/sda1 init=/bin/bash
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes, linear)
[    0.000000] Sorting __ex_table...
[    0.000000] mem auto-init: stack:off, heap alloc:off, heap free:off
[    0.000000] PVR=10300700 CVR=71440211 PRR=00000250
[    0.000000] I-cache : n_ways=4 n_sets=256 way_incr=8192
[    0.000000] I-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
[    0.000000] D-cache : n_ways=4 n_sets=256 way_incr=8192
[    0.000000] D-cache : entry_mask=0x00001fe0 alias_mask=0x00001000 n_aliases=2
[    0.000000] Memory: 510080K/524288K available (4601K kernel code, 276K rwdata, 1660K rodata, 156K init, 2966K bss, 14204K reserved, 0K cma-reserved)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xdffd7000 - 0xdffff000   ( 160 kB)
[    0.000000]     vmalloc : 0xc0000000 - 0xdffd5000   ( 511 MB)
[    0.000000]     lowmem  : 0x80000000 - 0xa0000000   ( 512 MB) (cached)
[    0.000000]             : 0xa0000000 - 0xa1000000   (  16 MB) (uncached)
[    0.000000]       .init : 0x80666000 - 0x8068d000   ( 156 kB)
[    0.000000]       .data : 0x80480594 - 0x806658d0   (1940 kB)
[    0.000000]       .text : 0x80001000 - 0x80480594   (4605 kB)
[    0.000000] rcu: Preemptible hierarchical RCU implementation.
[    0.000000]  Trampoline variant of Tasks RCU enabled.
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.
[    0.000000] NR_IRQS: 8, nr_irqs: 8, preallocated irqs: 0
[    0.000000] intc: Registered controller 'sh7785' with 67 IRQs
[    0.000000] intc: Registered controller 'sh7785-irq4567' with 4 IRQs
[    0.000000] intc: Registered controller 'sh7785-irq0123' with 4 IRQs
[    0.000000] random: get_random_bytes called from start_kernel+0x264/0x5c2 with crng_init=0
[    0.000000] Console: colour dummy device 80x25
[    0.000000]  sh-tmu.0: ch0: used for clock events
[    0.000000]  sh-tmu.0: ch0: used for periodic clock events
[    0.000000]  sh-tmu.0: ch1: used as clock source
[    0.000000] clocksource: sh-tmu.0: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 152900847964 ns
[    0.000000]  sh-tmu.1: ch0: used for clock events
[    0.000000]  sh-tmu.1: ch1: used as clock source
[    0.000000] clocksource: sh-tmu.1: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 152900847964 ns
[    0.000000] sched_clock: 32 bits at 250 Hz, resolution 4000000ns, wraps every 8589934590000000ns
[    0.000000] Calibrating delay loop (skipped)... 599.99 BogoMIPS PRESET (lpj=1199999)
[    0.000000] pid_max: default: 32768 minimum: 301
[    0.000000] LSM: Security Framework initializing
[    0.000000] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.000000] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes, linear)
[    0.012000] CPU: SH7785
[    0.016000] Performance Events: sh4a support registered
[    0.020000] rcu: Hierarchical SRCU implementation.
[    0.024000] devtmpfs: initialized
[    0.044000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.044000] futex hash table entries: 256 (order: 0, 7168 bytes, linear)
[    0.048000] pinctrl core: initialized pinctrl subsystem
[    0.060000] NET: Registered protocol family 16
[    0.140000] DMA: preallocated 128 KiB GFP_KERNEL pool for atomic allocations
[    0.144000] audit: initializing netlink subsys (disabled)
[    0.148000] audit: type=2000 audit(0.144:1): state=initialized audit_enabled=0 res=1
[    0.168000] cpuidle: using governor ladder
[    0.168000] cpuidle: using governor menu
[    0.228000] sh-pfc pfc-sh7785: sh7785_pfc handling gpio 0 -> 110
[    0.232000] sh-pfc pfc-sh7785: sh7785_pfc handling gpio 111 -> 275
[    0.232000] sh-pfc pfc-sh7785: sh7785_pfc support registered
[    0.232000] HW Breakpoints: SH-4A UBC support registered
[    0.232000] PCI: Starting initialization.
[    0.484000] PCI: Found a Renesas SH7785 host controller, revision 1.
[    0.484000] PCI: Checking 66MHz capabilities...
[    0.484000] PCI: Running at 66MHz.
[    0.932000] HugeTLB registered 1.00 MiB page size, pre-allocated 0 pages
[    0.980000] SCSI subsystem initialized
[    0.988000] libata version 3.00 loaded.
[    1.004000] usbcore: registered new interface driver usbfs
[    1.004000] usbcore: registered new interface driver hub
[    1.008000] usbcore: registered new device driver usb
[    1.016000] sh_tmu sh-tmu.0: kept as earlytimer
[    1.020000] sh_tmu sh-tmu.1: kept as earlytimer
[    1.024000] random: fast init done
[    1.048000] DMA: Registering sh_dmac handler (12 channels).
[    1.096000] DMA: Registering DMA API.
[    1.100000] PCI host bridge to bus 0000:00
[    1.100000] pci_bus 0000:00: root bus resource [io  0x1000-0x3fffff]
[    1.100000] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfdffffff]
[    1.100000] pci_bus 0000:00: root bus resource [mem 0x10000000-0x13ffffff]
[    1.100000] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xdfffffff]
[    1.104000] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.104000] pci_bus 0000:00: scanning bus
[    1.104000] pci 0000:00:00.0: [10ec:8169] type 00 class 0x020000
[    1.104000] pci 0000:00:00.0: reg 0x10: [io  0x0000-0x00ff]
[    1.104000] pci 0000:00:00.0: reg 0x14: [mem 0x00000000-0x000000ff]
[    1.104000] pci 0000:00:00.0: reg 0x30: [mem 0x00000000-0x0001ffff pref]
[    1.104000] pci 0000:00:00.0: supports D1 D2
[    1.104000] pci 0000:00:00.0: PME# supported from D1 D2 D3hot
[    1.104000] pci 0000:00:00.0: PME# disabled
[    1.108000] pci 0000:00:01.0: [1095:3512] type 00 class 0x018000
[    1.108000] pci 0000:00:01.0: reg 0x10: [io  0x0000-0x0007]
[    1.108000] pci 0000:00:01.0: reg 0x14: [io  0x0000-0x0003]
[    1.108000] pci 0000:00:01.0: reg 0x18: [io  0x0000-0x0007]
[    1.108000] pci 0000:00:01.0: reg 0x1c: [io  0x0000-0x0003]
[    1.108000] pci 0000:00:01.0: reg 0x20: [io  0x0000-0x000f]
[    1.108000] pci 0000:00:01.0: reg 0x24: [mem 0x00000000-0x000001ff]
[    1.108000] pci 0000:00:01.0: reg 0x30: [mem 0x00000000-0x0007ffff pref]
[    1.108000] pci 0000:00:01.0: supports D1 D2
[    1.116000] pci_bus 0000:00: fixups for bus
[    1.116000] pci_bus 0000:00: bus scan returning with max=00
[    1.116000] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    1.116000] pci 0000:00:01.0: BAR 6: assigned [mem 0xfd000000-0xfd07ffff pref]
[    1.116000] pci 0000:00:00.0: BAR 6: assigned [mem 0xfd080000-0xfd09ffff pref]
[    1.116000] pci 0000:00:01.0: BAR 5: assigned [mem 0xfd0a0000-0xfd0a01ff]
[    1.116000] pci 0000:00:00.0: BAR 0: assigned [io  0x1000-0x10ff]
[    1.116000] pci 0000:00:00.0: BAR 1: assigned [mem 0xfd0a0200-0xfd0a02ff]
[    1.116000] pci 0000:00:01.0: BAR 4: assigned [io  0x1400-0x140f]
[    1.116000] pci 0000:00:01.0: BAR 0: assigned [io  0x1410-0x1417]
[    1.116000] pci 0000:00:01.0: BAR 2: assigned [io  0x1418-0x141f]
[    1.116000] pci 0000:00:01.0: BAR 1: assigned [io  0x1420-0x1423]
[    1.116000] pci 0000:00:01.0: BAR 3: assigned [io  0x1424-0x1427]
[    1.120000] clocksource: Switched to clocksource sh-tmu.0
[    1.124000] sh_tmu sh-tmu.0: ch0: used for oneshot clock events
[    1.456000] NET: Registered protocol family 2
[    1.464000] tcp_listen_portaddr_hash hash table entries: 256 (order: 0, 6144 bytes, linear)
[    1.464000] TCP established hash table entries: 4096 (order: 2, 16384 bytes, linear)
[    1.464000] TCP bind hash table entries: 4096 (order: 4, 81920 bytes, linear)
[    1.464000] TCP: Hash tables configured (established 4096 bind 4096)
[    1.464000] UDP hash table entries: 256 (order: 1, 12288 bytes, linear)
[    1.464000] UDP-Lite hash table entries: 256 (order: 1, 12288 bytes, linear)
[    1.468000] NET: Registered protocol family 1
[    1.468000] PCI: CLS 0 bytes, default 32
[    1.468000] sq: Registering store queue API.
[    1.512000] workingset: timestamp_bits=30 max_order=17 bucket_order=0
[    1.536000] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    1.536000] io scheduler mq-deadline registered
[    1.544000] SuperH (H)SCI(F) driver initialized
[    1.544000] sh-sci.0: ttySC0 at MMIO 0xffea0000 (irq = 40, base_baud = 0) is a scif
[    1.560000] sh-sci.1: ttySC1 at MMIO 0xffeb0000 (irq = 44, base_baud = 0) is a scif
[    1.560000] BUG: spinlock bad magic on CPU#0, swapper/1
[    1.560000]  lock: sci_ports+0x1d8/0xb10, .magic: 00000000, .owner: <none>/-1, .owner_cpu: 0
[    1.560000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
[    1.560000] Stack: (0x9f445ce8 to 0x9f446000)
[    1.560000] 5ce0: 
[    1.560000]          
[    1.560000]          
[    1.560000] 80260daa 
[    1.560000] 9f445cfc 
[    1.560000] 80048fd8 
[    1.560000] 8096c158 
[    1.560000] 805ab908 
[    1.560000] 8004449c 
[    1.560000] 
[    1.560000] 5d00: 
[    1.560000] 9f445d08 
[    1.560000] 00000000 
[    1.560000] ffffffff 
[    1.560000] 00000000 
[    1.560000] 8004455e 
[    1.560000] 9f445d24 
[    1.560000] 8064b2c0 
[    1.560000] 8096c158 
[    1.560000] 
[    1.560000] 5d20: 
[    1.560000] 8096c158 
[    1.560000] 8047e57c 
[    1.560000] 9f445d30 
[    1.560000] 00000000 
[    1.560000] 802b850a 
[    1.560000] 9f445d40 
[    1.560000] 8096c158 
[    1.560000] 9f66694c 
[    1.560000] 
[    1.560000] 5d40: 
[    1.560000] 9f445d70 
[    1.560000] 0000002c 
[    1.560000] 00000000 
[    1.560000] 805cc1a0 
[    1.560000] 9f4d7660 
[    1.560000] 9f666a88 
[    1.560000] 805e101c 
[    1.560000] 0000002c 
[    1.560000] 
[    1.560000] 5d60: 
[    1.560000] 9f647d80 
[    1.560000] 9f445d70 
[    1.560000] 00000000 
[    1.560000] 9f666a48 
[    1.560000] 4f494d4d 
[    1.560000] 66783020 
[    1.560000] 30626566 
[    1.560000] 00303030 
[    1.560000] 
[    1.560000] 5d80: 
[    1.560000] 9f445d9c 
[    1.560000] 00000000 
[    1.560000] 8096bf7c 
[    1.560000] 8062deb4 
[    1.560000] 8096bf80 
[    1.560000] 8096c158 
[    1.560000] 8096c158 
[    1.560000] 8096c214 
[    1.560000] 
[    1.560000] 5da0: 
[    1.560000] 9f445db0 
[    1.560000] 805cc298 
[    1.560000] 805cc29c 
[    1.560000] 00000000 
[    1.560000] b6b1ed6c 
[    1.560000] 802bc842 
[    1.560000] 9f445dd4 
[    1.560000] 00000000 
[    1.560000] 
[    1.560000] 5dc0: 
[    1.560000] 8096bf7c 
[    1.560000] 8096c158 
[    1.560000] 8096bf80 
[    1.560000] 8096c158 
[    1.560000] 00000001 
[    1.560000] 00000000 
[    1.560000] 9f4d81c8 
[    1.560000] 805e5c0c 
[    1.560000] 
[    1.560000] 5de0: 
[    1.560000] 8062dec0 
[    1.560000] 8062e050 
[    1.560000] 802c9890 
[    1.560000] 9f445e08 
[    1.560000] 00000000 
[    1.560000] 8096cd10 
[    1.560000] 8062df3c 
[    1.560000] 8096ce20 
[    1.560000] 
[    1.560000] 5e00: 
[    1.560000] 8062dec0 
[    1.560000] 8064b1b4 
[    1.560000] 802c7cdc 
[    1.560000] 9f445e18 
[    1.560000] 8062dec0 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 8064b1b4 
[    1.560000] 
[    1.560000] 5e20: 
[    1.560000] 802c7fe6 
[    1.560000] 9f445e40 
[    1.560000] 8064b1f4 
[    1.560000] 8064bb08 
[    1.560000] 8062724c 
[    1.560000] 00000000 
[    1.560000] 8064b1b4 
[    1.560000] 8062dec0 
[    1.560000] 
[    1.560000] 5e40: 
[    1.560000] 802c81ce 
[    1.560000] 9f445e54 
[    1.560000] 00000000 
[    1.560000] 8064b1b4 
[    1.560000] 8062dec0 
[    1.560000] 802c8220 
[    1.560000] 9f445e68 
[    1.560000] 802627f4 
[    1.560000] 
[    1.560000] 5e60: 
[    1.560000] 8062dec0 
[    1.560000] 8064b1b4 
[    1.560000] 802c619a 
[    1.560000] 9f445e7c 
[    1.560000] 802627f4 
[    1.560000] 802c81e0 
[    1.560000] 8064b1b4 
[    1.560000] 8047e4e0 
[    1.560000] 
[    1.560000] 5e80: 
[    1.560000] 9f40bc70 
[    1.560000] 9f40f5c0 
[    1.560000] b6b1ed6c 
[    1.560000] 802c778a 
[    1.560000] 9f445ea4 
[    1.560000] 8064bac8 
[    1.560000] 00000000 
[    1.560000] 9f664f60 
[    1.560000] 
[    1.560000] 5ea0: 
[    1.560000] 8064b1b4 
[    1.560000] 802c71d2 
[    1.560000] 9f445eac 
[    1.560000] 805a0d88 
[    1.560000] 802c87cc 
[    1.560000] 9f445ed0 
[    1.560000] 8068d000 
[    1.560000] 00000000 
[    1.560000] 
[    1.560000] 5ec0: 
[    1.560000] 8062724c 
[    1.560000] 9f445efc 
[    1.560000] 8068d008 
[    1.560000] 8064b1b4 
[    1.560000] 802c9856 
[    1.560000] 9f445ee4 
[    1.560000] 9f445efc 
[    1.560000] 8068d008 
[    1.560000] 
[    1.560000] 5ee0: 
[    1.560000] 80678800 
[    1.560000] 80678816 
[    1.560000] 9f445eec 
[    1.560000] 80002292 
[    1.560000] 9f445ef4 
[    1.560000] 9f422dd6 
[    1.560000] 00000000 
[    1.560000] 8002d300 
[    1.560000] 
[    1.560000] 5f00: 
[    1.560000] 9f445f0c 
[    1.560000] 000000b2 
[    1.560000] 9f445f0c 
[    1.560000] 00000006 
[    1.560000] 00000006 
[    1.560000] 00000000 
[    1.560000] 805dda74 
[    1.560000] 8061f9f0 
[    1.560000] 
[    1.560000] 5f20: 
[    1.560000] 80666098 
[    1.560000] 00000000 
[    1.560000] 9f422dea 
[    1.560000] 00000000 
[    1.560000] 9f422de5 
[    1.560000] 9f422dea 
[    1.560000] b6b1ed6c 
[    1.560000] 80666c92 
[    1.560000] 
[    1.560000] 5f40: 
[    1.560000] 9f445f5c 
[    1.560000] 000000b2 
[    1.560000] 80685900 
[    1.560000] 9f422dc0 
[    1.560000] 806858e0 
[    1.560000] 8068d008 
[    1.560000] 8061f9f0 
[    1.560000] 00000006 
[    1.560000] 
[    1.560000] 5f60: 
[    1.560000] 00000006 
[    1.560000] 00000000 
[    1.560000] 80666098 
[    1.560000] 8068a6d0 
[    1.560000] 00000007 
[    1.560000] 804778b4 
[    1.560000] 9f445f94 
[    1.560000] 80636160 
[    1.560000] 
[    1.560000] 5f80: 
[    1.560000] 80477788 
[    1.560000] 8063659c 
[    1.560000] 00000000 
[    1.560000] 9f442020 
[    1.560000] 80048fd8 
[    1.560000] 80007224 
[    1.560000] 9f449f28 
[    1.560000] 9f442020 
[    1.560000] 
[    1.560000] 5fa0: 
[    1.560000] 80034b98 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 804778a4 
[    1.560000] 00000000 
[    1.560000] 
[    1.560000] 5fc0: 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 
[    1.560000] 5fe0: 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 40008000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 00000000 
[    1.560000] 
[    1.560000] 
[    1.560000] Call trace:
[    1.560000]  [<(ptrval)>] dump_stack+0x1a/0x30
[    1.560000]  [<(ptrval)>] printk+0x0/0x50
[    1.560000]  [<(ptrval)>] spin_dump+0x58/0x88
[    1.560000]  [<(ptrval)>] do_raw_spin_lock+0x4a/0x94
[    1.560000]  [<(ptrval)>] _raw_spin_lock_irqsave+0x24/0x44
[    1.560000]  [<(ptrval)>] uart_add_one_port+0x32a/0x470
[    1.560000]  [<(ptrval)>] sci_probe+0x116/0x2f4
[    1.560000]  [<(ptrval)>] platform_drv_probe+0x1c/0x60
[    1.560000]  [<(ptrval)>] really_probe+0xc0/0x2c8
[    1.560000]  [<(ptrval)>] driver_probe_device+0x26/0x6c
[    1.560000]  [<(ptrval)>] device_driver_attach+0x4a/0x5c
[    1.560000]  [<(ptrval)>] __driver_attach+0x40/0xc4
[    1.560000]  [<(ptrval)>] klist_next+0x0/0xe4
[    1.560000]  [<(ptrval)>] bus_for_each_dev+0x56/0xa8
[    1.560000]  [<(ptrval)>] klist_next+0x0/0xe4
[    1.560000]  [<(ptrval)>] __driver_attach+0x0/0xc4
[    1.560000]  [<(ptrval)>] _raw_spin_lock+0x10/0x28
[    1.560000]  [<(ptrval)>] driver_attach+0x12/0x24
[    1.560000]  [<(ptrval)>] bus_add_driver+0x13a/0x1bc
[    1.560000]  [<(ptrval)>] driver_register+0x50/0xf8
[    1.560000]  [<(ptrval)>] __platform_driver_register+0x22/0x40
[    1.560000]  [<(ptrval)>] sci_init+0x0/0x34
[    1.560000]  [<(ptrval)>] sci_init+0x16/0x34
[    1.560000]  [<(ptrval)>] do_one_initcall+0x5e/0x164
[    1.560000]  [<(ptrval)>] parse_args+0xe0/0x2b8
[    1.560000]  [<(ptrval)>] ignore_unknown_bootoption+0x0/0xc
[    1.560000]  [<(ptrval)>] kernel_init_freeable+0xf6/0x1e0
[    1.560000]  [<(ptrval)>] ignore_unknown_bootoption+0x0/0xc
[    1.560000]  [<(ptrval)>] kernel_init+0x10/0x100
[    1.560000]  [<(ptrval)>] debug_smp_processor_id+0x0/0x24
[    1.560000]  [<(ptrval)>] printk+0x0/0x50
[    1.560000]  [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
[    1.560000]  [<(ptrval)>] schedule_tail+0x0/0x88
[    1.560000]  [<(ptrval)>] kernel_init+0x0/0x100
[    1.560000] 
[    3.248000] printk: console [ttySC1] enabled
[    3.264000] sh-sci.2: ttySC2 at MMIO 0xffec0000 (irq = 60, base_baud = 0) is a scif
[    3.284000] sh-sci.3: ttySC3 at MMIO 0xffed0000 (irq = 61, base_baud = 0) is a scif
[    3.304000] sh-sci.4: ttySC4 at MMIO 0xffee0000 (irq = 62, base_baud = 0) is a scif
[    3.324000] sh-sci.5: ttySC5 at MMIO 0xffef0000 (irq = 63, base_baud = 0) is a scif
[    3.628000] brd: module loaded
[    3.816000] loop: module loaded
[    3.820000] sm501 sm501: SM501 At (ptrval): Version 050100c0, 4 Mb, IRQ 10
[    3.828000] sm501 sm501: setting M1XCLK to 112000000
[    3.856000] sm501 sm501: setting MCLK to 84000000
[    3.884000] sm501-fb[0] [mem 0x13e80000-0x13e8ffff]
[    3.888000] sm501-fb[1] [mem 0x13f00000-0x13f4ffff]
[    3.892000] sm501-fb[2] [mem 0x10000000-0x103fffff]
[    3.896000] sm501-fb[3] [irq 10]
[    3.920000] sata_sil 0000:00:01.0: assign IRQ: got 66
[    3.928000] sata_sil 0000:00:01.0: version 2.4
[    3.932000] sata_sil 0000:00:01.0: enabling device (0000 -> 0003)
[    3.940000] sata_sil 0000:00:01.0: cache line size not set.  Driver may not function
[    3.948000] sata_sil 0000:00:01.0: Applying R_ERR on DMA activate FIS errata fix
[    3.956000] sata_sil 0000:00:01.0: enabling bus mastering
[    4.004000] scsi host0: sata_sil
[    4.020000] scsi host1: sata_sil
[    4.036000] ata1: SATA max UDMA/100 mmio m512@0xfd0a0000 tf 0xfd0a0080 irq 66
[    4.044000] ata2: SATA max UDMA/100 mmio m512@0xfd0a0000 tf 0xfd0a00c0 irq 66
[    4.068000] physmap-flash physmap-flash.0: physmap platform flash device: [mem 0x00000000-0x03ffffff]
[    4.076000] physmap-flash.0: Found 2 x16 devices at 0x0 in 32-bit bank. Manufacturer ID 0x000001 Chip ID 0x002201
[    4.088000] Amd/Fujitsu Extended Query Table at 0x0040
[    4.092000]   Amd/Fujitsu Extended Query version 1.3.
[    4.100000] number of CFI chips: 1
[    4.108000] Creating 4 MTD partitions on "physmap-flash.0":
[    4.116000] 0x000000000000-0x000000080000 : "loader"
[    4.176000] 0x000000080000-0x000000100000 : "bootenv"
[    4.232000] 0x000000100000-0x000000500000 : "kernel"
[    4.288000] 0x000000500000-0x000004000000 : "data"
[    4.364000] ata1: SATA link down (SStatus 0 SControl 310)
[    4.388000] r8169 0000:00:00.0: assign IRQ: got 65
[    4.396000] r8169 0000:00:00.0: enabling device (0000 -> 0003)
[    4.404000] r8169 0000:00:00.0: enabling bus mastering
[    4.444000] libphy: r8169: probed
[    4.468000] r8169 0000:00:00.0 eth0: RTL8169sc/8110sc, 74:90:50:00:02:03, XID 180, IRQ 65
[    4.476000] r8169 0000:00:00.0 eth0: jumbo features [frames: 7146 bytes, tx checksumming: ok]
[    4.504000] r8a66597_hcd r8a66597_hcd: USB Host Controller
[    4.512000] r8a66597_hcd r8a66597_hcd: new USB bus registered, assigned bus number 1
[    4.520000] r8a66597_hcd r8a66597_hcd: irq 2, io base 0x08000000
[    4.564000] hub 1-0:1.0: USB hub found
[    4.568000] hub 1-0:1.0: 2 ports detected
[    4.600000] usbcore: registered new interface driver usb-storage
[    4.612000] mousedev: PS/2 mouse device common for all mice
[    4.624000] PCA9564/PCA9665 at 0x06000000: PCA9564 detected.
[    4.632000] PCA9564/PCA9665 at 0x06000000: Choosing the clock frequency based on index is deprecated. Use the nominal frequency.
[    4.644000]  (null): No reset-pin found. Chip may get stuck!
[    4.648000] PCA9564/PCA9665 at 0x06000000: Clock frequency is 330kHz
[    4.660000] i2c-pca-platform i2c-pca-platform: registered.
[    4.672000] cpufreq: SuperH CPU frequency driver.
[    4.680000] cpufreq: cpufreq_online: ->get() failed
[    4.696000] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[    4.716000] ata2.00: ATA-9: TOSHIBA THNSNJ128GCSU, JURA0101, max UDMA/100
[    4.724000] usbcore: registered new interface driver usbhid
[    4.728000] usbhid: USB HID core driver
[    4.732000] ata2.00: 250069680 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    4.744000] NET: Registered protocol family 10
[    4.748000] ata2.00: READ LOG DMA EXT failed, trying PIO
[    4.764000] ata2.00: configured for UDMA/100
[    4.772000] Segment Routing with IPv6
[    4.776000] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    4.792000] scsi 1:0:0:0: Direct-Access     ATA      TOSHIBA THNSNJ12 0101 PQ: 0 ANSI: 5
[    4.836000] NET: Registered protocol family 17
[    4.852000] sd 1:0:0:0: [sda] 250069680 512-byte logical blocks: (128 GB/119 GiB)
[    4.860000] heartbeat: version 0.1.2 loaded
[    4.868000] sd 1:0:0:0: [sda] Write Protect is off
[    4.876000] sd 1:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.884000] sd 1:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.896000] kmemleak: Kernel memory leak detector initialized (mem pool available: 15858)
[    4.904000] kmemleak: Automatic memory scanning thread started
[    4.940000]  sda: sda1 sda2 sda3
[    4.976000] sd 1:0:0:0: [sda] Attached SCSI disk
[    4.988000] usb 1-1: new high-speed USB device number 2 using r8a66597_hcd
[    5.252000] usb-storage 1-1:1.0: USB Mass Storage device detected
[    5.272000] scsi host2: usb-storage 1-1:1.0
[    5.364000] EXT4-fs (sda1): mounted filesystem with ordered data mode. Opts: (null)
[    5.372000] VFS: Mounted root (ext4 filesystem) on device 8:1.
[    5.396000] devtmpfs: mounted
[    5.400000] Freeing unused kernel memory: 156K
[    5.404000] This architecture does not have kernel memory protection.
[    5.412000] Run /bin/bash as init process
[    5.416000]   with arguments:
[    5.420000]     /bin/bash
[    5.420000]   with environment:
[    5.424000]     HOME=/
[    5.428000]     TERM=linux
[    5.464000] ------------[ cut here ]------------
[    5.464000] WARNING: CPU: 0 PID: 1 at mm/slab.c:2589 cache_alloc_refill+0x216/0x6a0
[    5.464000] Modules linked in:
[    5.464000] 
[    5.464000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
[    5.464000] PC is at cache_alloc_refill+0x216/0x6a0
[    5.464000] PR is at kmem_cache_alloc+0xd6/0x128
[    5.464000] PC  : 800ec0d2 SP  : 9f445e68 SR  : 400080f0 
[    5.464000] TEA : c00c30d0
[    5.464000] R0  : 8062724c R1  : 8000fee8 R2  : 9f403540 R3  : 00000100
[    5.464000] R4  : 9f403500 R5  : 00000000 R6  : 8068d5b0 R7  : 007fffff
[    5.464000] R8  : 0000000c R9  : 9f403500 R10 : 8096fc0c R11 : 80044410
[    5.464000] R12 : 9f405060 R13 : 00000dc0 R14 : 9f445e68
[    5.464000] MACH: 10623bba MACL: 00000cc0 GBR : 2957bd58 PR  : 800ec80a
[    5.464000] 
[    5.464000] Call trace:
[    5.464000]  [<(ptrval)>] _raw_spin_unlock_irqrestore+0x0/0x54
[    5.464000]  [<(ptrval)>] _raw_spin_lock_irqsave+0x0/0x44
[    5.464000]  [<(ptrval)>] kmem_cache_alloc+0xd6/0x128
[    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
[    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
[    5.464000]  [<(ptrval)>] pgd_alloc+0x10/0x24
[    5.464000]  [<(ptrval)>] memset+0x0/0x8c
[    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
[    5.464000]  [<(ptrval)>] mm_init.isra.0+0x10e/0x194
[    5.464000]  [<(ptrval)>] mm_alloc+0x2a/0x4c
[    5.464000]  [<(ptrval)>] _raw_spin_unlock+0x0/0x44
[    5.464000]  [<(ptrval)>] __do_execve_file+0x2a6/0x97c
[    5.464000]  [<(ptrval)>] kmemleak_alloc+0x1e/0x30
[    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
[    5.464000]  [<(ptrval)>] getname_kernel+0x24/0xf8
[    5.464000]  [<(ptrval)>] do_execve+0x1a/0x28
[    5.464000]  [<(ptrval)>] debug_smp_processor_id+0x0/0x24
[    5.464000]  [<(ptrval)>] printk+0x0/0x50
[    5.464000]  [<(ptrval)>] run_init_process+0x5c/0x90
[    5.464000]  [<(ptrval)>] kernel_init+0x5c/0x100
[    5.464000]  [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
[    5.464000]  [<(ptrval)>] schedule_tail+0x0/0x88
[    5.464000]  [<(ptrval)>] kernel_init+0x0/0x100
[    5.464000] 
[    5.464000] Code:
[    5.464000]   800ec0cc:  
[    5.464000] mov.w     
[    5.464000] 800ec222 <cache_alloc_refill+0x366/0x6a0>
[    5.464000] , 
[    5.464000] r3
[    5.464000]   ! 00000100 <0x100>
[    5.464000] 
[    5.464000]   800ec0ce:  
[    5.464000] tst       
[    5.464000] r3
[    5.464000] , 
[    5.464000] r13
[    5.464000] 
[    5.464000]   800ec0d0:  
[    5.464000] bt        
[    5.464000] 800ec0d4
[    5.464000] 
[    5.464000] ->800ec0d2:  
[    5.464000] trapa     
[    5.464000] #62
[    5.464000] 
[    5.464000]   800ec0d4:  
[    5.464000] mov.w     
[    5.464000] 800ec224 <cache_alloc_refill+0x368/0x6a0>
[    5.464000] , 
[    5.464000] r1
[    5.464000]   ! 00000400 <0x400>
[    5.464000] 
[    5.464000]   800ec0d6:  
[    5.464000] mov       
[    5.464000] r13
[    5.464000] , 
[    5.464000] r2
[    5.464000] 
[    5.464000]   800ec0d8:  
[    5.464000] mov.l     
[    5.464000] 800ec238 <cache_alloc_refill+0x37c/0x6a0>
[    5.464000] , 
[    5.464000] r12
[    5.464000]   ! 003beee0 <0x3beee0>
[    5.464000] 
[    5.464000]   800ec0da:  
[    5.464000] and       
[    5.464000] r1
[    5.464000] , 
[    5.464000] r2
[    5.464000] 
[    5.464000]   800ec0dc:  
[    5.464000] tst       
[    5.464000] r1
[    5.464000] , 
[    5.464000] r13
[    5.464000] 
[    5.464000] 
[    5.464000] ---[ end trace 8fe2f9c439309f6b ]---
bash: cannot set terminal process group (-1): Inappropriate ioctl for device
bash: no job control in this shell
root@(none):/# [    6.340000] usb 1-1: address 2, EndpointAddress 0x02 use DMA FIFO
[    6.344000] usb 1-1: address 2, EndpointAddress 0x81 use DMA FIFO
[    6.352000] scsi 2:0:0:0: Direct-Access     Kingston DataTraveler 2.0 PMAP PQ: 0 ANSI: 0 CCS
[    6.392000] sd 2:0:0:0: [sdb] 7936000 512-byte logical blocks: (4.06 GB/3.78 GiB)
[    6.404000] sd 2:0:0:0: [sdb] Write Protect is off
[    6.408000] sd 2:0:0:0: [sdb] Mode Sense: 23 00 00 00
[    6.416000] sd 2:0:0:0: [sdb] No Caching mode page found
[    6.420000] sd 2:0:0:0: [sdb] Assuming drive cache: write through
[    6.456000]  sdb: sdb1
[    6.480000] sd 2:0:0:0: [sdb] Attached SCSI removable disk

====================================================================================

[    5.464000] ------------[ cut here ]------------
[    5.464000] WARNING: CPU: 0 PID: 1 at mm/slab.c:2589 cache_alloc_refill+0x216/0x6a0
[    5.464000] Modules linked in:
[    5.464000] 
[    5.464000] CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc5-00026-g22b7a96ece82 #3
[    5.464000] PC is at cache_alloc_refill+0x216/0x6a0
[    5.464000] PR is at kmem_cache_alloc+0xd6/0x128
[    5.464000] PC  : 800ec0d2 SP  : 9f445e68 SR  : 400080f0 
[    5.464000] TEA : c00c30d0
[    5.464000] R0  : 8062724c R1  : 8000fee8 R2  : 9f403540 R3  : 00000100
[    5.464000] R4  : 9f403500 R5  : 00000000 R6  : 8068d5b0 R7  : 007fffff
[    5.464000] R8  : 0000000c R9  : 9f403500 R10 : 8096fc0c R11 : 80044410
[    5.464000] R12 : 9f405060 R13 : 00000dc0 R14 : 9f445e68
[    5.464000] MACH: 10623bba MACL: 00000cc0 GBR : 2957bd58 PR  : 800ec80a
[    5.464000] 
[    5.464000] Call trace:
[    5.464000]  [<(ptrval)>] _raw_spin_unlock_irqrestore+0x0/0x54
[    5.464000]  [<(ptrval)>] _raw_spin_lock_irqsave+0x0/0x44
[    5.464000]  [<(ptrval)>] kmem_cache_alloc+0xd6/0x128
[    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
[    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
[    5.464000]  [<(ptrval)>] pgd_alloc+0x10/0x24
[    5.464000]  [<(ptrval)>] memset+0x0/0x8c
[    5.464000]  [<(ptrval)>] __raw_spin_lock_init+0x0/0x1c
[    5.464000]  [<(ptrval)>] mm_init.isra.0+0x10e/0x194
[    5.464000]  [<(ptrval)>] mm_alloc+0x2a/0x4c
[    5.464000]  [<(ptrval)>] _raw_spin_unlock+0x0/0x44
[    5.464000]  [<(ptrval)>] __do_execve_file+0x2a6/0x97c
[    5.464000]  [<(ptrval)>] kmemleak_alloc+0x1e/0x30
[    5.464000]  [<(ptrval)>] arch_local_irq_restore+0x0/0x2c
[    5.464000]  [<(ptrval)>] getname_kernel+0x24/0xf8
[    5.464000]  [<(ptrval)>] do_execve+0x1a/0x28
[    5.464000]  [<(ptrval)>] debug_smp_processor_id+0x0/0x24
[    5.464000]  [<(ptrval)>] printk+0x0/0x50
[    5.464000]  [<(ptrval)>] run_init_process+0x5c/0x90
[    5.464000]  [<(ptrval)>] kernel_init+0x5c/0x100
[    5.464000]  [<(ptrval)>] ret_from_kernel_thread+0xc/0x14
[    5.464000]  [<(ptrval)>] schedule_tail+0x0/0x88
[    5.464000]  [<(ptrval)>] kernel_init+0x0/0x100
[    5.464000] 
[    5.464000] Code:
[    5.464000]   800ec0cc:  
[    5.464000] mov.w     
[    5.464000] 800ec222 <cache_alloc_refill+0x366/0x6a0>
[    5.464000] , 
[    5.464000] r3
[    5.464000]   ! 00000100 <0x100>
[    5.464000] 
[    5.464000]   800ec0ce:  
[    5.464000] tst       
[    5.464000] r3
[    5.464000] , 
[    5.464000] r13
[    5.464000] 
[    5.464000]   800ec0d0:  
[    5.464000] bt        
[    5.464000] 800ec0d4
[    5.464000] 
[    5.464000] ->800ec0d2:  
[    5.464000] trapa     
[    5.464000] #62
[    5.464000] 
[    5.464000]   800ec0d4:  
[    5.464000] mov.w     
[    5.464000] 800ec224 <cache_alloc_refill+0x368/0x6a0>
[    5.464000] , 
[    5.464000] r1
[    5.464000]   ! 00000400 <0x400>
[    5.464000] 
[    5.464000]   800ec0d6:  
[    5.464000] mov       
[    5.464000] r13
[    5.464000] , 
[    5.464000] r2
[    5.464000] 
[    5.464000]   800ec0d8:  
[    5.464000] mov.l     
[    5.464000] 800ec238 <cache_alloc_refill+0x37c/0x6a0>
[    5.464000] , 
[    5.464000] r12
[    5.464000]   ! 003beee0 <0x3beee0>
[    5.464000] 
[    5.464000]   800ec0da:  
[    5.464000] and       
[    5.464000] r1
[    5.464000] , 
[    5.464000] r2
[    5.464000] 
[    5.464000]   800ec0dc:  
[    5.464000] tst       
[    5.464000] r1
[    5.464000] , 
[    5.464000] r13
[    5.464000] 
[    5.464000] 
[    5.464000] ---[ end trace 8fe2f9c439309f6b ]---

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
