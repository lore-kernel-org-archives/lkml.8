Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1394AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:54:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D26B8206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbgHKVyj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:54:39 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:39923 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725987AbgHKVyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:54:38 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1k5cDx-000W4f-8n; Tue, 11 Aug 2020 23:54:25 +0200
Received: from p57bd93c4.dip0.t-ipconnect.de ([87.189.147.196] helo=[192.168.178.139])
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtpsa (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1k5cDw-003Tph-R5; Tue, 11 Aug 2020 23:54:25 +0200
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jrtc27@jrtc27.com, Anatoly Pugachev <matorola@gmail.com>,
        Sergei Trofimovich <slyfox@gentoo.org>,
        Frank Scheiner <frank.scheiner@web.de>
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: "mm/vmalloc: Add flag for freeing of special permsissions" broke udev
 on ia64
Autocrypt: addr=glaubitz@physik.fu-berlin.de; keydata=
 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
 scOkTAZQGVpD/8AaLH4v1w==
Message-ID: <460f2393-8603-cbda-9bab-4bd24d0c41ed@physik.fu-berlin.de>
Date:   Tue, 11 Aug 2020 23:54:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.147.196
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rick!

I have been bisecting some regressions on ia64 and one problem I ran into is that
udev is causing the kernel to crash after the following change from 2019:

commit 868b104d7379e28013e9d48bdd2db25e0bdcf751
Author: Rick Edgecombe <rick.p.edgecombe@intel.com>
Date:   Thu Apr 25 17:11:36 2019 -0700

    mm/vmalloc: Add flag for freeing of special permsissions

With your patch applied, udev crashes on ia64 when trying to load modules, I'm pasting
the whole boot message sequence below.

Any idea what could cause this problem on ia64?

Thanks,
Adrian

[    0.000000] Linux version 5.1.0-rc7+ (glaubitz@epyc) (gcc version 10.1.0 (GCC)) #26 SMP Tue Aug 11 23:43:36 CEST 2020
[    0.000000] EFI v2.00 by HP:
[    0.000000] efi:  SALsystab=0x3ee7a000  ACPI 2.0=0x3fde4000  SMBIOS=0x3ee7c000  HCDP=0x3fde2000 
[    0.000000] booting generic kernel on platform hpzx1
[    0.000000] PCDP: v3 at 0x3fde2000
[    0.000000] earlycon: uart8250 at MMIO 0x0000000088033000 (options '115200n8')
[    0.000000] printk: bootconsole [uart8250] enabled
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x000000003FDE4000 000028 (v02 HP    )
[    0.000000] ACPI: XSDT 0x000000003FDE402C 0000A4 (v01 HP     rx2660   00000000 HP   00000000)
[    0.000000] ACPI: FACP 0x000000003FDF6A08 0000F4 (v03 HP     rx2660   00000000 HP   00000000)
[    0.000000] ACPI: DSDT 0x000000003FDE41C8 00E566 (v01 HP     rx2660   00000007 INTL 20050309)
[    0.000000] ACPI: FACS 0x000000003FDF6B00 000040
[    0.000000] ACPI: SPCR 0x000000003FDF6B40 000050 (v01 HP              00000000 HP   00000000)
[    0.000000] ACPI: DBGP 0x000000003FDF6B90 000034 (v01 HP     rx2660   00000000 HP   00000000)
[    0.000000] ACPI: APIC 0x000000003FDF6FB0 0000C8 (v01 HP     rx2660   00000000 HP   00000000)
[    0.000000] ACPI: SPMI 0x000000003FDF6BC8 000050 (v04 HP     rx2660   00000000 HP   00000000)
[    0.000000] ACPI: CPEP 0x000000003FDF6E80 000034 (v01 HP     rx2660   00000000 HP   00000000)
[    0.000000] ACPI: SSDT 0x000000003FDF2738 0004B3 (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF2BF8 000456 (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF3058 000EB8 (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF3F18 000EB8 (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF4DD8 000866 (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF5648 000EB8 (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF6508 000138 (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF6648 00013C (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF6788 00013C (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: SSDT 0x000000003FDF68C8 00013C (v01 HP     rx2660   00000006 INTL 20050309)
[    0.000000] ACPI: Local APIC address (____ptrval____)
[    0.000000] 4 CPUs available, 4 CPUs total                                                                                                                 
[    0.000000] SMP: Allowing 4 CPUs, 0 hotplug CPUs                                                                                                           
[    0.000000] Initial ramdisk at: 0xe00000002d88e000 (21193389 bytes)                                                                                        
[    0.000000] SAL 3.20: HP version 4.4                                                                                                                       
[    0.000000] SAL Platform features:                                                                                                                         
[    0.000000]  None                                                                                                                                          
[    0.000000] SAL: AP wakeup using external interrupt vector 0xff                                                                                            
[    0.000000] MCA related initialization done                                                                                                                
[    0.000000] Virtual mem_map starts at 0x(____ptrval____)                                                                                                   
[    0.000000] Zone ranges:                                                                                                                                   
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]                                                                                         
[    0.000000]   Normal   [mem 0x0000000100000000-0x000001007fffffff]                                                                                         
[    0.000000] Movable zone start for each node                                                                                                               
[    0.000000] Early memory node ranges                                                                                                                       
[    0.000000]   node   0: [mem 0x0000000001000000-0x000000003e67ffff]                                                                                        
[    0.000000]   node   0: [mem 0x000000003eaec000-0x000000003ee77fff]                                                                                        
[    0.000000]   node   0: [mem 0x000000003fc00000-0x000000003fd77fff]                                                                                        
[    0.000000]   node   0: [mem 0x000000003fddc000-0x000000003fddffff]                                                                                        
[    0.000000]   node   0: [mem 0x0000010040000000-0x000001007f1fbfff]                                                                                        
[    0.000000]   node   0: [mem 0x000001007f200000-0x000001007fffffff]                                                                                        
[    0.000000] Initmem setup node 0 [mem 0x0000000001000000-0x000001007fffffff]                                                                               
[    0.000000]   Normal zone: 261632 pages exceeds freesize 65535                                                                                             
[    0.000000] Built 1 zonelists, mobility grouping on.  Total pages: 127717                                                                                  
[    0.000000] Policy zone: Normal                                                                                                                            
[    0.000000] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.1.0-rc7+ root=UUID=0c24a3da-2673-4901-b95b-d5adf2643b67 ro module_                             blacklist=radeon nomodeset hardened_usercopy=off nosmp                                                                                                        
[    0.000000] You have booted with nomodeset. This means your GPU drivers are DISABLED                                                                       
[    0.000000] Any video related functionality will be severely degraded, and you may not even be able to suspend the system prop                             erly                                                                                                                                                          
[    0.000000] Unless you actually understand what nomodeset does, you should reboot without enabling it                                                      
[    0.000000] Sorting __ex_table...                                                                                                                          
[    0.000000] Memory: 2000336K/2059792K available (15217K kernel code, 967K rwdata, 1760K rodata, 944K init, 753K bss, 59456K re                             served, 0K cma-reserved)                                                                                                                                      
[    0.000000] random: get_random_u64 called from __kmem_cache_create+0x60/0x1160 with crng_init=0                                                            
[    0.000000] SLUB: HWalign=128, Order=0-3, MinObjects=0, CPUs=4, Nodes=256                                                                                  
[    0.000000] rcu: Hierarchical RCU implementation.                                                                                                          
[    0.000000] rcu:     RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.                                                                                 
[    0.000000] rcu: RCU calculated value of scheduler-enlistment delay is 25 jiffies.                                                                         
[    0.000000] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=4                                                                                   
[    0.000000] NR_IRQS: 1024                                                                                                                                  
[    0.000000] ACPI: Local APIC address (____ptrval____)                                                                                                      
[    0.000000] GSI 25 (level, low) -> CPU 0 (0x0000) vector 49                                                                                                
[    0.000000] +/-150ppm                                                                                                                                      
[    0.000000] clocksource: itc: mask: 0xffffffffffffffff max_cycles: 0x5c0f47ad51, max_idle_ns: 440795205098 ns                                              
[    0.004000] Console: colour VGA+ 80x25                                                                                                                     
[    0.004000] ACPI: Core revision 20190215                                                                                                                   
[    0.004000] Calibrating delay loop... 3182.59 BogoMIPS (lpj=6365184)                                                                                       
[    0.020000] pid_max: default: 32768 minimum: 301                                                                                                           
[    0.020000] LSM: Security Framework initializing                                                                                                           
[    0.020000] Yama: becoming mindful.                                                                                                                        
[    0.020000] AppArmor: AppArmor initialized                                                                                                                 
[    0.020000] TOMOYO Linux initialized                                                                                                                       
[    0.020000] Dentry cache hash table entries: 262144 (order: 7, 2097152 bytes)                                                                              
[    0.024000] Inode-cache hash table entries: 131072 (order: 6, 1048576 bytes)                                                                               
[    0.024000] Mount-cache hash table entries: 4096 (order: 1, 32768 bytes)                                                                                   
[    0.024000] Mountpoint-cache hash table entries: 4096 (order: 1, 32768 bytes)                                                                              
[    0.028000] Boot processor id 0x0/0x0                                                                                                                      
[    0.028000] SMP mode deactivated.                                                                                                                          
[    0.028000] rcu: Hierarchical SRCU implementation.                                                                                                         
[    0.028000] smp: Bringing up secondary CPUs ...                                                                                                            
[    0.028000] smp: Brought up 1 node, 1 CPU                                                                                                                  
[    0.028000] Total of 1 processors activated (3182.59 BogoMIPS).                                                                                            
[    0.032000] devtmpfs: initialized                                                                                                                          
[    0.032000] SMBIOS 2.4 present.                                                                                                                            
[    0.032000] DMI: hp server rx2660                   , BIOS 04.04                                                            07                             /15/2008                                                                                                                                                      
[    0.036000] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns                                                
[    0.036000] futex hash table entries: 256 (order: 1, 32768 bytes)                                                                                          
[    0.040000] NET: Registered protocol family 16                                                                                                             
[    0.040000] audit: initializing netlink subsys (disabled)                                                                                                  
[    0.040000] ACPI: bus type PCI registered                                                                                                                  
[    0.044000] audit: type=2000 audit(1597182378.040:1): state=initialized audit_enabled=0 res=1                                                              
[    0.044000] HugeTLB registered 256 MiB page size, pre-allocated 0 pages                                                                                    
[    0.044000] ACPI: Added _OSI(Module Device)                                                                                                                
[    0.044000] ACPI: Added _OSI(Processor Device)                                                                                                             
[    0.044000] ACPI: Added _OSI(3.0 _SCP Extensions)                                                                                                          
[    0.044000] ACPI: Added _OSI(Processor Aggregator Device)                                                                                                  
[    0.048000] ACPI: Added _OSI(Linux-Dell-Video)                                                                                                             
[    0.048000] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)                                                                                                   
[    0.048000] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)                                                                                                    
[    0.052000] ACPI: 11 ACPI AML tables successfully acquired and loaded                                                                                      
[    0.052000] ACPI Debug:  "_INI"                                                                                                                            
[    0.052000] ACPI Debug:  "Initializing the SCRAM data struct access"                                                                                       
[    0.056000] ACPI Debug:  "Init of scratch RAM complete!"                                                                                                   
[    0.104000] ACPI: Interpreter enabled                                                                                                                      
[    0.104000] ACPI: (supports S0 S5)                                                                                                                         
[    0.104000] ACPI: Using IOSAPIC for interrupt routing                                                                                                      
[    0.128000] ACPI: Enabled 2 GPEs in block 10 to 1F                                                                                                         
[    0.400000] ACPI: PCI Root Bridge [L000] (domain 0000 [bus 00])                                                                                            
[    0.400000] acpi HWP0002:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                  
[    0.432000] PCI host bridge to bus 0000:00                                                                                                                 
[    0.432000] pci_bus 0000:00: root bus resource [io  0x1000000-0x100ffff window] (bus address [0x0000-0xffff])                                              
[    0.432000] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000fffff window]                                                                          
[    0.432000] pci_bus 0000:00: root bus resource [mem 0x80000000-0x8fffffff window]                                                                          
[    0.432000] pci_bus 0000:00: root bus resource [mem 0x80004000000-0x800ffffffff window]                                                                    
[    0.436000] pci_bus 0000:00: root bus resource [bus 00]                                                                                                    
[    0.484000] ACPI: PCI Root Bridge [L002] (domain 0000 [bus 01])                                                                                            
[    0.484000] acpi HWP0002:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                  
[    0.508000] PCI host bridge to bus 0000:01                                                                                                                 
[    0.508000] pci_bus 0000:01: root bus resource [io  0x2000000-0x200ffff window] (bus address [0x0000-0xffff])                                              
[    0.508000] pci_bus 0000:01: root bus resource [mem 0xa0000000-0xafffffff window]                                                                          
[    0.508000] pci_bus 0000:01: root bus resource [mem 0x80204000000-0x802ffffffff window]                                                                    
[    0.512000] pci_bus 0000:01: root bus resource [bus 01]                                                                                                    
[    0.552000] ACPI: PCI Root Bridge [L003] (domain 0000 [bus 02-03])                                                                                         
[    0.552000] acpi HPQ0002:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                  
[    0.560000] acpi HPQ0002:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]                                                                
[    0.580000] PCI host bridge to bus 0000:02                                                                                                                 
[    0.580000] pci_bus 0000:02: root bus resource [io  0x3000000-0x300ffff window] (bus address [0x0000-0xffff])                                              
[    0.580000] pci_bus 0000:02: root bus resource [mem 0xb0000000-0xbfffffff window]                                                                          
[    0.580000] pci_bus 0000:02: root bus resource [mem 0x80304000000-0x803ffffffff window]                                                                    
[    0.580000] pci_bus 0000:02: root bus resource [bus 02-03]                                                                                                 
[    0.612000] pci 0000:02:00.0: PCI bridge to [bus 03]                                                                                                       
[    0.644000] ACPI: PCI Root Bridge [L004] (domain 0000 [bus 04-05])                                                                                         
[    0.644000] acpi HPQ0002:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                  
[    0.652000] acpi HPQ0002:01: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]                                                                
[    0.672000] PCI host bridge to bus 0000:04                                                                                                                 
[    0.672000] pci_bus 0000:04: root bus resource [io  0x4000000-0x400ffff window] (bus address [0x0000-0xffff])                                              
[    0.672000] pci_bus 0000:04: root bus resource [mem 0xc0000000-0xdfffffff window]                                                                          
[    0.672000] pci_bus 0000:04: root bus resource [mem 0x80404000000-0x804ffffffff window]                                                                    
[    0.676000] pci_bus 0000:04: root bus resource [bus 04-05]                                                                                                 
[    0.780000] pci 0000:04:00.0: PCI bridge to [bus 05]                                                                                                       
[    0.816000] ACPI: PCI Root Bridge [L006] (domain 0000 [bus 06])                                                                                            
[    0.816000] acpi HWP0002:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                  
[    0.852000] PCI host bridge to bus 0000:06                                                                                                                 
[    0.852000] pci_bus 0000:06: root bus resource [io  0x5000000-0x500ffff window] (bus address [0x0000-0xffff])                                              
[    0.852000] pci_bus 0000:06: root bus resource [mem 0xe0000000-0xefffffff window]                                                                          
[    0.852000] pci_bus 0000:06: root bus resource [mem 0x80604000000-0x806ffffffff window]                                                                    
[    0.856000] pci_bus 0000:06: root bus resource [bus 06]                                                                                                    
[    0.892000] ACPI: PCI Root Bridge [L007] (domain 0000 [bus 07-08])                                                                                         
[    0.892000] acpi HPQ0002:02: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]                                                                  
[    0.900000] acpi HPQ0002:02: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability LTR]                                                                
[    0.920000] PCI host bridge to bus 0000:07                                                                                                                 
[    0.920000] pci_bus 0000:07: root bus resource [io  0x6000000-0x600ffff window] (bus address [0x0000-0xffff])                                              
[    0.920000] pci_bus 0000:07: root bus resource [mem 0xf0000000-0xfdffffff window]                                                                          
[    0.920000] pci_bus 0000:07: root bus resource [mem 0x80704000000-0x807ffffffff window]                                                                    
[    0.920000] pci_bus 0000:07: root bus resource [bus 07-08]                                                                                                 
[    0.956000] pci 0000:07:00.0: PCI bridge to [bus 08]                                                                                                       
[    0.972000] pci 0000:00:03.0: vgaarb: setting as boot VGA device                                                                                           
[    0.972000] pci 0000:00:03.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none                                                              
[    0.972000] pci 0000:00:03.0: vgaarb: bridge control possible                                                                                              
[    0.972000] vgaarb: loaded                                                                                                                                 
[    0.976000] pps_core: LinuxPPS API ver. 1 registered                                                                                                       
[    0.976000] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>                                                       
[    0.976000] PTP clock support registered                                                                                                                   
[    0.976000] Registered efivars operations                                                                                                                  
[    0.992000] IOC: zx2 2.0 HPA 0xfed01000 IOVA space 1024Mb at 0x40000000                                                                                    
[    1.024000] random: fast init done                                                                                                                         
[    1.056000] clocksource: Switched to clocksource itc                                                                                                       
[    1.056000] VFS: Disk quotas dquot_6.6.0                                                                                                                   
[    1.056000] VFS: Dquot-cache hash table entries: 2048 (order 0, 16384 bytes)                                                                               
[    1.056000] AppArmor: AppArmor Filesystem Enabled                                                                                                          
[    1.062187] pnp: PnP ACPI init                                                                                                                             
[    1.066114] GSI 24 (level, low) -> CPU 0 (0x0000) vector 50                                                                                                
[    1.126113] pnp: PnP ACPI: found 1 devices                                                                                                                 
[    1.130114] NET: Registered protocol family 2                                                                                                              
[    1.130114] tcp_listen_portaddr_hash hash table entries: 1024 (order: 0, 16384 bytes)                                                                      
[    1.130114] TCP established hash table entries: 16384 (order: 3, 131072 bytes)                                                                             
[    1.130114] TCP bind hash table entries: 16384 (order: 4, 262144 bytes)                                                                                    
[    1.130114] TCP: Hash tables configured (established 16384 bind 16384)                                                                                     
[    1.135193] UDP hash table entries: 1024 (order: 1, 32768 bytes)                                                                                           
[    1.135193] UDP-Lite hash table entries: 1024 (order: 1, 32768 bytes)                                                                                      
[    1.135193] NET: Registered protocol family 1                                                                                                              
[    1.139587] NET: Registered protocol family 44                                                                                                             
[    1.142114] GSI 17 (level, low) -> CPU 0 (0x0000) vector 51                                                                                                
[    1.142114] GSI 17 (level, low) -> CPU 0 (0x0000) vector 51 unregistered                                                                                   
[    1.146217] GSI 18 (level, low) -> CPU 0 (0x0000) vector 51                                                                                                
[    1.150114] GSI 18 (level, low) -> CPU 0 (0x0000) vector 51 unregistered                                                                                   
[    1.154114] GSI 19 (level, low) -> CPU 0 (0x0000) vector 51                                                                                                
[    1.158114] GSI 19 (level, low) -> CPU 0 (0x0000) vector 51 unregistered                                                                                   
[    1.158114] pci 0000:00:03.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]                                                                
[    1.158114] Unpacking initramfs...                                                                                                                         
[    1.758114] Freeing initrd memory: 20688kB freed                                                                                                           
[    1.758114] Initialise system trusted keyrings                                                                                                             
[    1.758114] Key type blacklist registered                                                                                                                  
[    1.758114] workingset: timestamp_bits=38 max_order=17 bucket_order=0                                                                                      
[    1.762115] zbud: loaded                                                                                                                                   
[    3.238114] alg: No test for lzo-rle (lzo-rle-generic)                                                                                                     
[    3.238114] alg: No test for lzo-rle (lzo-rle-scomp)                                                                                                       
[    3.242114] Key type asymmetric registered                                                                                                                 
[    3.242114] Asymmetric key parser 'x509' registered                                                                                                        
[    3.242114] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)                                                                           
[    3.242114] io scheduler mq-deadline registered                                                                                                            
[    3.246114] GSI 38 (level, low) -> CPU 0 (0x0000) vector 51                                                                                                
[    3.246114] pcieport 0000:02:00.0: Signaling PME with IRQ 55                                                                                               
[    3.250129] aer 0000:02:00.0:pcie002: AER enabled with IRQ 55                                                                                              
[    3.254129] GSI 45 (level, low) -> CPU 0 (0x0000) vector 53                                                                                                
[    3.258134] pcieport 0000:04:00.0: Signaling PME with IRQ 57                                                                                               
[    3.262191] aer 0000:04:00.0:pcie002: AER enabled with IRQ 57                                                                                              
[    3.266113] GSI 63 (level, low) -> CPU 0 (0x0000) vector 55                                                                                                
[    3.270134] pcieport 0000:07:00.0: Signaling PME with IRQ 59                                                                                               
[    3.274192] aer 0000:07:00.0:pcie002: AER enabled with IRQ 59                                                                                              
[    3.278113] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input0                                                                           
[    3.278113] ACPI: Power Button [PWRF]                                                                                                                      
[    3.278113] input: Sleep Button as /devices/LNXSYSTM:00/LNXSLPBN:00/input/input1                                                                           
[    3.278113] ACPI: Sleep Button [SLPF]                                                                                                                      
[    3.278113] thermal LNXTHERM:00: registered as thermal_zone0                                                                                               
[    3.278113] ACPI: Thermal Zone [THM0] (27 C)                                                                                                               
[    3.278113] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled                                                                                        
[    3.303347] 00:00: ttyS0 at MMIO 0xff5e2000 (irq = 50, base_baud = 115200) is a 16550A                                                                     
[    3.306113] GSI 16 (level, low) -> CPU 0 (0x0000) vector 57                                                                                                
    3.328169] 0000:00:01.2: ttyS1 at MMIO 0x88033000 (irq = 60, base_baud = 115200) is a 16550A                                                               
[    3.328169] printk: console [ttyS1] enabled                                                                                                                
[    3.328169] printk: console [ttyS1] enabled                                                                                                                
[    3.328169] printk: bootconsole [uart8250] disabled                                                                                                        
[    3.328169] printk: bootconsole [uart8250] disabled                                                                                                        
[    3.328169] Linux agpgart interface v0.103                                                                                                                 
[    3.378113] mousedev: PS/2 mouse device common for all mice                                                                                                
[    3.378113] rtc-efi rtc-efi: registered as rtc0                                                                                                            
[    3.378113] ledtrig-cpu: registered to indicate activity on CPUs                                                                                           
[    3.378113] EFI Variables Facility v0.08 2004-May-17                                                                                                       
[    3.382114] NET: Registered protocol family 10                                                                                                             
[    3.390114] Segment Routing with IPv6                                                                                                                      
[    3.390114] mip6: Mobile IPv6                                                                                                                              
[    3.390114] NET: Registered protocol family 17                                                                                                             
[    3.390114] mpls_gso: MPLS GSO support                                                                                                                     
[    3.390114] registered taskstats version 1                                                                                                                 
[    3.390114] Loading compiled-in X.509 certificates                                                                                                         
[    3.395571] zswap: loaded using pool lzo/zbud                                                                                                              
[    3.395571] AppArmor: AppArmor sha1 policy hashing enabled                                                                                                 
[    3.398113] rtc-efi rtc-efi: setting system clock to 2020-08-11T21:46:21 UTC (1597182381)                                                                  
[    3.398113] Freeing unused kernel memory: 944K                                                                                                             
[    3.398113] This architecture does not have kernel memory protection.                                                                                      
[    3.402668] Run /init as init process                                                                                                                      
Loading, please wait...                                                                                                                                       
Starting version 245.7-1                                                                                                                                      
[    3.610114] tg3.c:v3.137 (May 11, 2014)                                                                                                                    
[    3.614115] GSI 29 (level, low) -> CPU 0 (0x0000) vector 58                                                                                                
[    3.622115] SCSI subsystem initialized                                                                                                                     
[    3.634116] HP HPSA Driver (v 3.4.20-125)                                                                                                                  
[    3.634116] hpsa 0000:05:00.0: legacy board ID: 0x3234103c                                                                                                 
[    3.634116] hpsa 0000:05:00.0: legacy board ID: 0x3234103c                                                                                                 
[    3.634116] hpsa 0000:05:00.0: can't disable ASPM; OS doesn't have ASPM control                                                                            
[    3.658116] Fusion MPT base driver 3.04.20                                                                                                                 
[    3.658116] Copyright (c) 1999-2008 LSI Corporation                                                                                                        
[    3.670115] ACPI: bus type USB registered                                                                                                                  
[    3.670115] usbcore: registered new interface driver usbfs                                                                                                 
[    3.670115] usbcore: registered new interface driver hub                                                                                                   
[    3.674119] Fusion MPT SAS Host driver 3.04.20                                                                                                             
[    3.686611] GSI 27 (level, low) -> CPU 0 (0x0000) vector 59                                                                                                
[    3.686611] usbcore: registered new device driver usb                                                                                                      
[    3.694116] mptbase: ioc0: Initiating bringup                                                                                                              
[    3.694116] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver                                                                                     
[    3.694116] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver                                                                                         
[    3.694116] ehci-pci: EHCI PCI platform driver                                                                                                             
[    3.702122] GSI 19 (level, low) -> CPU 0 (0x0000) vector 61                                                                                                
[    3.702122] ehci-pci 0000:00:02.2: EHCI Host Controller                                                                                                    
[    3.702122] ehci-pci 0000:00:02.2: new USB bus registered, assigned bus number 1                                                                           
[    3.710531] ehci-pci 0000:00:02.2: irq 53, io mem 0x88030000                                                                                               
[    3.710531] hpsa 0000:05:00.0: Logical aborts not supported                                                                                                
[    3.710531] hpsa 0000:05:00.0: HP SSD Smart Path aborts not supported                                                                                      
[    3.726120] ehci-pci 0000:00:02.2: USB 2.0 started, EHCI 1.00                                                                                              
[    3.726120] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.01                                                                 
[    3.726120] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1                                                                             
[    3.726120] usb usb1: Product: EHCI Host Controller                                                                                                        
[    3.726120] usb usb1: Manufacturer: Linux 5.1.0-rc7+ ehci_hcd                                                                                              
[    3.730304] usb usb1: SerialNumber: 0000:00:02.2                                                                                                           
[    3.730304] hub 1-0:1.0: USB hub found                                                                                                                     
[    3.730304] hub 1-0:1.0: 5 ports detected                                                                                                                  
[    3.730304] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.734197] kernel BUG at arch/ia64/kernel/module.c:564!                                                                                                   
[    3.734197] systemd-udevd[112]: bugcheck! 0 [1]                                                                                                            
[    3.734197] Modules linked in: hR(PF) ehci_pci ohci_hcd ehci_hcd mptsas(+) usbcore mptscsih mptbase hpsa(+) scsi_transport_sas                              scsi_mod tg3(+) libphy                                                                                                                                       
[    3.734197]                                                                                                                                                
[    3.734197] CPU: 0 PID: 112 Comm: systemd-udevd Not tainted 5.1.0-rc7+ #26                                                                                 
[    3.734197] Hardware name: hp server rx2660                   , BIOS 04.04                                                                                         07/15/2008                                                                                                                                            
[    3.734197] psr : 0000101008026010 ifs : 800000000000050d ip  : [<a00000010004be90>]    Not tainted (5.1.0-rc7+)                                           
[    3.734197] ip is at get_plt.part.0+0x190/0x360                                                                                                            
[    3.734197] unat: 0000000000000000 pfs : 000000000000050d rsc : 0000000000000003                                                                           
[    3.734197] rnat: 0000000000000000 bsps: 0000000000000000 pr  : 00000001a5695659                                                                           
[    3.734197] ldrs: 0000000000000000 ccv : 00000000de9356bd fpsr: 0009804c0270033f                                                                           
[    3.734197] csd : 0000000000000000 ssd : 0000000000000000                                                                                                  
[    3.734197] b0  : a00000010004be90 b6  : a000000100ec4320 b7  : a00000010099af40                                                                           
[    3.734197] f6  : 000000000000000000000 f7  : 1003e0044b82fa09b5a53                                                                                        
[    3.734197] f8  : 1003e0000000000001ddf f9  : 1003e0000000005785f17                                                                                        
[    3.734197] f10 : 1003e20c49ba5e353f7cf f11 : 1003e0000000000b33f5f                                                                                        
[    3.734197] r1  : a000000101629320 r2  : a0000001013ca498 r3  : a0000001013ca4a0                                                                           
[    3.734197] r8  : 000000000000002c r9  : 0000000000000001 r10 : 0000000000000000                                                                           
[    3.734197] r11 : a0000001014cecec r12 : e000010045167d10 r13 : e000010045160000                                                                           
[    3.734197] r14 : ffffffffffda1178 r15 : a0000001013ca4a0 r16 : e000000001140000                                                                           
[    3.734197] r17 : 0000000000004000 r18 : 000000000000047c r19 : 000000000000047c                                                                           
[    3.734197] r20 : 000000000000047e r21 : 000000000000047e r22 : 000000000000047e                                                                           
[    3.734197] r23 : 000000000000015d r24 : 0000000000000afc r25 : 000000000000015e                                                                           
[    3.734197] r26 : 0000000000000afe r27 : 0000000000000afe r28 : 0000000000000b00                                                                           
[    3.734197] r29 : 0000000000000b00 r30 : 0000000000000b00 r31 : 0000000000000000                                                                           
[    3.734197]                                                                                                                                                
[    3.734197] Call Trace:                                                                                                                                    
[    3.734197]  [<a000000100014bf0>] show_stack+0x90/0xc0                                                                                                     
[    3.734197]                                 sp=e000010045167950 bsp=e000010045161658                                                                       
[    3.734197]  [<a0000001000152d0>] show_regs+0x6b0/0xa20                                                                                                    
[    3.734197]                                 sp=e000010045167b20 bsp=e0000100451615e0                                                                       
[    3.734197]  [<a000000100029330>] die+0x1b0/0x480                                                                                                          
[    3.734197]                                 sp=e000010045167b40 bsp=e0000100451615a0                                                                       
[    3.734197]  [<a000000100ed7430>] ia64_bad_break+0x750/0x780                                                                                               
[    3.734197]                                 sp=e000010045167b40 bsp=e000010045161570                                                                       
[    3.734197]  [<a00000010000ca20>] ia64_leave_kernel+0x0/0x270                                                                                              
[    3.734197]                                 sp=e000010045167b40 bsp=e000010045161570                                                                       
[    3.734197]  [<a00000010004be90>] get_plt.part.0+0x190/0x360                                                                                               
[    3.734197]                                 sp=e000010045167d10 bsp=e000010045161508                                                                       
[    3.734197]  [<a00000010004e350>] apply_relocate_add+0xef0/0x1400                                                                                          
[    3.734197]                                 sp=e000010045167d10 bsp=e0000100451613b0                                                                       
[    3.734197]  [<a0000001001bba10>] load_module+0x3b90/0x6aa0                                                                                                
[    3.734197]                                 sp=e000010045167d20 bsp=e0000100451611d0                                                                       
[    3.734197]  [<a0000001001bee30>] sys_finit_module+0x190/0x220                                                                                             
[    3.734197]                                 sp=e000010045167da0 bsp=e000010045161160                                                                       
[    3.734197]  [<a00000010000c8a0>] ia64_ret_from_syscall+0x0/0x20                                                                                           
[    3.734197]                                 sp=e000010045167e30 bsp=e000010045161158                                                                       
[    3.734197] Disabling lock debugging due to kernel taint                                                                                                   
[    3.798946] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.798946] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.798946] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.802733] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.802733] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.802733] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.802733] hR: Unknown symbol �� (err -2)                                                                                                                 
[    3.802733] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.806775] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.806775] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.806775] hR: Unknown symbol , (err -2)                                                                                                                  
[    3.806775] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.806775] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.810787] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.810787] hR: Unknown symbol , (err -2)                                                                                                                  
[    3.810787] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.810787] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.810787] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.814779] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.814779] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.814779] hR: Unknown symbol �� (err -2)                                                                                                                 
[    3.814779] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.814779] hR: Unknown symbol �� (err -2)                                                                                                                 
[    3.818840] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.818840] hR: Unknown symbol ' (err -2)                                                                                                                  
[    3.818840] hR: Unknown symbol  (err -2)                                                                                                                   
[    3.818840] systemd-udevd[111]: NaT consumption 17179869216 [2]                                                                                            
[    3.818840] Modules linked in: ehci_pci ohci_hcd ehci_hcd mptsas(+) usbcore mptscsih mptbase hpsa(+) scsi_transport_sas scsi_m                             od tg3(+) libphy                                                                                                                                              
[    3.818840]                                                                                                                                                
[    3.818840] CPU: 0 PID: 111 Comm: systemd-udevd Tainted: G      D           5.1.0-rc7+ #26                                                                 
[    3.818840] Hardware name: hp server rx2660                   , BIOS 04.04                                                                                         07/15/2008                                                                                                                                            
[    3.818840] psr : 0000101008022010 ifs : 8000000000000309 ip  : [<a000000100307ef0>]    Tainted: G      D           (5.1.0-rc7                             +)                                                                                                                                                            
[    3.818840] ip is at free_percpu+0x3f0/0x480                                                                                                               
[    3.818840] unat: 0000000000000000 pfs : 0000000000000309 rsc : 0000000000000003                                                                           
[    3.818840] rnat: 0000000000000000 bsps: 0000000000000000 pr  : 00000001a569a659                                                                           
[    3.818840] ldrs: 0000000000000000 ccv : 0000000000000000 fpsr: 0009804c8a70033f                                                                           
[    3.818840] csd : 0000000000000000 ssd : 0000000000000000                                                                                                  
[    3.818840] b0  : a000000100307ee0 b6  : a0000001000ef500 b7  : a00000010000c240                                                                           
[    3.818840] f6  : 1003e0000000001f762e9 f7  : 1003e00000000eb9dde2f                                                                                        
[    3.818840] f8  : 1003e00000000000008f1 f9  : 1003e00000000ee86b62f                                                                                        
[    3.818840] f10 : 1003e00000000000002b4 f11 : 1003e000000000000ba36                                                                                        
[    3.818840] r1  : a000000101629320 r2  : a000000101407268 r3  : 0000010040004000
[    3.818840] r8  : 0000000000000000 r9  : 0000000000002288 r10 : e000010040006288
[    3.818840] r11 : 0000000000000000 r12 : e00001004511fd20 r13 : e000010045118000
[    3.818840] r14 : 0000000000000000 r15 : a000000101429ed0 r16 : 7ffc000000000000
[    3.818840] r17 : 8000000000000001 r18 : 0000000000000000 r19 : a000000101432150
[    3.818840] r20 : e00001007ff2ca80 r21 : 0000000000000000 r22 : 0000000000000000
[    3.818840] r23 : e000010040000000 r24 : 0000000000000020 r25 : 0000000000000007
[    3.818840] r26 : e000010040000000 r27 : 0000000000000000 r28 : e000000001140000
[    3.818840] r29 : e000000001104000 r30 : a00000010114d1b8 r31 : e00001007ff2c8d8
[    3.818840] 
[    3.818840] Call Trace:
[    3.818840]  [<a000000100014bf0>] show_stack+0x90/0xc0
[    3.818840]                                 sp=e00001004511f8e0 bsp=e000010045119500
[    3.818840]  [<a0000001000152d0>] show_regs+0x6b0/0xa20
[    3.818840]                                 sp=e00001004511fab0 bsp=e000010045119490
[    3.818840]  [<a000000100029330>] die+0x1b0/0x480
[    3.818840]                                 sp=e00001004511fad0 bsp=e000010045119450
[    3.818840]  [<a000000100ed76f0>] ia64_fault+0x290/0xe80
[    3.818840]                                 sp=e00001004511fad0 bsp=e000010045119400
[    3.818840]  [<a00000010000ca20>] ia64_leave_kernel+0x0/0x270
[    3.818840]                                 sp=e00001004511fb50 bsp=e000010045119400
[    3.818840]  [<a000000100307ef0>] free_percpu+0x3f0/0x480
[    3.818840]                                 sp=e00001004511fd20 bsp=e0000100451193b0
[    3.818840]  [<a0000001001bb060>] load_module+0x31e0/0x6aa0
[    3.818840]                                 sp=e00001004511fd20 bsp=e0000100451191d0
[    3.818840]  [<a0000001001bee30>] sys_finit_module+0x190/0x220
[    3.818840]                                 sp=e00001004511fda0 bsp=e000010045119160
[    3.818840]  [<a00000010000c8a0>] ia64_ret_from_syscall+0x0/0x20
[    3.818840]                                 sp=e00001004511fe30 bsp=e000010045119158
[    3.880033] scsi host0: hpsa

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer - glaubitz@debian.org
`. `'   Freie Universitaet Berlin - glaubitz@physik.fu-berlin.de
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
