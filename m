Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1C80C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:05:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BDDC214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 18:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YN2TcjMe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729225AbgAOSFK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 13:05:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:38033 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728921AbgAOSFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 13:05:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id k6so16513472qki.5;
        Wed, 15 Jan 2020 10:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JFnfBYy+EUaeEFRwE0UkvfnLO805OPsK7j9dY/7rS/A=;
        b=YN2TcjMeq9s4o/QYSBiRsaXIt909I44P4LIko7DR6QqZc1Siu+R+4VgUTwXkik+1P0
         hdr1+V13zfDT6G0Do4BpXZasUOj3tM+2XKn1DorkLHog8ktIIzW7yHFxbZhSIKf6xCzp
         x9f5bVUi4keeRSzQMxVs5gkO0AgFWZKwY/NdAPXIElgw8wxMsTcJQhvbAru+99v5oBFk
         UgtAk9DG2K4TVWfRdiM3eCwB5DGiiLKiZDu7TR0uI++qAlL98bDghTIKdKXfCw0OJeDu
         9L0OJRpD8NlCExa8A72kC9zyec/Ki/fmUw8hasETL68AK1ct0ehuCEAeHZtjBlNTH/sf
         vErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JFnfBYy+EUaeEFRwE0UkvfnLO805OPsK7j9dY/7rS/A=;
        b=dXz6nJz9NeE8uqeYhIaSC4VBce6yjzeYLcoDzqHIHvzZo3PQPiljwiJymgXkTHDns3
         S8RN/TsPP0Kubc8ZtMVw2bcSd6U9TZQBp4uYDBAmHvlhT3LDMiATSW+Qb8fEW2jORIuD
         tHJJELZ6VsbXlSW7uHrBvMG9Kw7D4ky7EYoG6iOhb11+wMRCwkKoSzOo8uuxJVc0uoAM
         4V9YETW3937oSq63F+Qn6wss57fyGJlx7DR4u3vbFJE7h9paYWL0S1iPu8j0mftxj4bu
         Qa9AXMjHSxtImcc8KblDRtn7axm6276SjENlsCMYSFsnK1mkW2njNkDilgzwzj0xamiG
         hcVQ==
X-Gm-Message-State: APjAAAUU/b8U6j77pqao7MSFVGdT7CVPNQrxc4dAp3ZRE9OmF210RWNQ
        KuFjhV0Ukqwj3DmekRsR48w=
X-Google-Smtp-Source: APXvYqyDcgfa3TdsRiifDZ4jDBAX3i8gRet8d48klKFbwYUmnFcXsZLPoY/OShLpsAJNZt8m0IZbQA==
X-Received: by 2002:a37:bcc4:: with SMTP id m187mr30082956qkf.329.1579111508386;
        Wed, 15 Jan 2020 10:05:08 -0800 (PST)
Received: from [192.168.1.46] (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id l6sm8810185qkc.65.2020.01.15.10.05.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jan 2020 10:05:08 -0800 (PST)
Subject: Re: [RFC PATCH 0/2] of: unittest: add overlay gpio test to catch gpio
 hog problem
From:   Frank Rowand <frowand.list@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        pantelis.antoniou@konsulko.com,
        Pantelis Antoniou <panto@antoniou-consulting.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alan Tull <atull@kernel.org>
References: <1579070828-18221-1-git-send-email-frowand.list@gmail.com>
 <578a2d41-e146-1f26-6bf4-30509ebe6941@gmail.com>
Message-ID: <979218ea-c237-d2ff-2ec8-78db252f924c@gmail.com>
Date:   Wed, 15 Jan 2020 12:05:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <578a2d41-e146-1f26-6bf4-30509ebe6941@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/20 11:28 AM, Frank Rowand wrote:
> On 1/15/20 12:47 AM, frowand.list@gmail.com wrote:
>> From: Frank Rowand <frank.rowand@sony.com>

< snip >

> (1) boot before patches
> (2) boot after this patch series
> (3) messages from (2) processed by of_unittest_expect
> (4) messages from boot after Geert's patches on top of this patch
>     series processed by of_unittest_expect

< snip >

4) messages from boot after Geert's patches on top of this patch
   series processed by of_unittest_expect

No unittest fails, so the line flagged with '>>' in (3) is no
longer present.

============================================================

       Android Bootloader - UART_DM Initialized!!!
       [0] welcome to lk
       
       [10] platform_init()
       [10] target_init()
       [10] Display Init: Start
       [10] display_init(),target_id=10.
       [30] Config MIPI_VIDEO_PANEL.
       [30] Turn on MIPI_VIDEO_PANEL.
       [50] Video lane tested successfully
       [50] Display Init: Done
       [80] Loading keystore failed status 5 [80] ERROR: scm_protect_keystore Failed[200] USB init ept @ 0xf96b000
       [220] fastboot_init()
       [220] udc_start()
       [350] -- reset --
       [350] -- portchange --
       [460] -- reset --
       [460] -- portchange --
       [590] fastboot: processing commands
       [750] fastboot: download:00f30000
       [1250] fastboot: boot
       [1260] Found Appeneded Flattened Device tree
       [1270] cmdline: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
       [1280] Updating device tree: start
       [1290] Updating device tree: done
       [1290] booting linux @ 0x8000, ramdisk @ 0x2000000 (9533134), tags/device tree @ 0x1e00000
       [1300] Turn off MIPI_VIDEO_PANEL.
       [1300] Continuous splash enabled, keeping panel alive.
       Booting Linux on physical CPU 0x0
       Linux version 5.5.0-rc2-00002-gbc60035cbebc-dirty (frowand@xps8900) (gcc version 4.6.x-google 20120106 (prerelease) (GCC)) #25 SMP PREEMPT Wed Jan 15 00:19:58 CST 2020
       CPU: ARMv7 Processor [512f06f0] revision 0 (ARMv7), cr=10c5787d
       CPU: div instructions available: patching division code
       CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
       OF: fdt: Machine model: Qualcomm APQ8074 Dragonboard
       Memory policy: Data cache writealloc
       cma: Reserved 256 MiB at 0x70000000
       percpu: Embedded 19 pages/cpu s48192 r8192 d21440 u77824
       Built 1 zonelists, mobility grouping on.  Total pages: 490240
       Kernel command line: console=ttyMSM0,115200,n8 androidboot.hardware=qcom maxcpus=2 msm_rtb.filter=0x37 ehci-hcd.park=3 norandmaps androidboot.emmc=true androidboot.serialno=40081c41 androidboot.baseband=apq
       Dentry cache hash table entries: 131072 (order: 7, 524288 bytes, linear)
       Inode-cache hash table entries: 65536 (order: 6, 262144 bytes, linear)
       mem auto-init: stack:off, heap alloc:off, heap free:off
       Memory: 1664560K/1967104K available (8192K kernel code, 859K rwdata, 3804K rodata, 1024K init, 268K bss, 40400K reserved, 262144K cma-reserved, 1048576K highmem)
       SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
       rcu: Preemptible hierarchical RCU implementation.
       	Tasks RCU enabled.
       rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
       NR_IRQS: 16, nr_irqs: 16, preallocated irqs: 16
       random: get_random_bytes called from start_kernel+0x2fc/0x508 with crng_init=0
       arch_timer: cp15 and mmio timer(s) running at 19.20MHz (virt/virt).
       clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x46d987e47, max_idle_ns: 440795202767 ns
       sched_clock: 56 bits at 19MHz, resolution 52ns, wraps every 4398046511078ns
       Switching to timer-based delay loop, resolution 52ns
       Console: colour dummy device 80x30
       Calibrating delay loop (skipped), value calculated using timer frequency.. 38.40 BogoMIPS (lpj=192000)
       pid_max: default: 32768 minimum: 301
       Mount-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
       Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes, linear)
       CPU: Testing write buffer coherency: ok
       CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
       Setting up static identity map for 0x300000 - 0x300060
       rcu: Hierarchical SRCU implementation.
       smp: Bringing up secondary CPUs ...
       CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
       smp: Brought up 1 node, 2 CPUs
       SMP: Total of 2 processors activated (76.80 BogoMIPS).
       CPU: All CPU(s) started in SVC mode.
       devtmpfs: initialized
       VFP support v0.3: implementor 51 architecture 64 part 6f variant 2 rev 0
       clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
       futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
       pinctrl core: initialized pinctrl subsystem
       thermal_sys: Registered thermal governor 'step_wise'
       NET: Registered protocol family 16
       DMA: preallocated 256 KiB pool for atomic coherent allocations
       cpuidle: using governor menu
       hw-breakpoint: found 5 (+1 reserved) breakpoint and 4 watchpoint registers.
       hw-breakpoint: maximum watchpoint size is 8 bytes.
       iommu: Default domain type: Translated 
       vgaarb: loaded
       SCSI subsystem initialized
       usbcore: registered new interface driver usbfs
       usbcore: registered new interface driver hub
       usbcore: registered new device driver usb
       Advanced Linux Sound Architecture Driver Initialized.
       clocksource: Switched to clocksource arch_sys_counter
       NET: Registered protocol family 2
       tcp_listen_portaddr_hash hash table entries: 512 (order: 0, 6144 bytes, linear)
       TCP established hash table entries: 8192 (order: 3, 32768 bytes, linear)
       TCP bind hash table entries: 8192 (order: 4, 65536 bytes, linear)
       TCP: Hash tables configured (established 8192 bind 8192)
       UDP hash table entries: 512 (order: 2, 16384 bytes, linear)
       UDP-Lite hash table entries: 512 (order: 2, 16384 bytes, linear)
       NET: Registered protocol family 1
       RPC: Registered named UNIX socket transport module.
       RPC: Registered udp transport module.
       RPC: Registered tcp transport module.
       RPC: Registered tcp NFSv4.1 backchannel transport module.
       PCI: CLS 0 bytes, default 64
       Trying to unpack rootfs image as initramfs...
       Freeing initrd memory: 9312K
       hw perfevents: enabled with armv7_krait PMU driver, 5 counters available
       Initialise system trusted keyrings
       workingset: timestamp_bits=30 max_order=19 bucket_order=0
       NFS: Registering the id_resolver key type
       Key type id_resolver registered
       Key type id_legacy registered
       Key type cifs.idmap registered
       jffs2: version 2.2. (NAND) © 2001-2006 Red Hat, Inc.
       fuse: init (API version 7.31)
       Key type asymmetric registered
       Asymmetric key parser 'x509' registered
       bounce: pool size: 64 pages
       Block layer SCSI generic (bsg) driver version 0.4 loaded (major 250)
       io scheduler mq-deadline registered
       io scheduler kyber registered
       msm_serial f991e000.serial: msm_serial: detected port #0
       msm_serial f991e000.serial: uartclk = 7372800
       f991e000.serial: ttyMSM0 at MMIO 0xf991e000 (irq = 28, base_baud = 460800) is a MSM
       msm_serial: console setup on port #0
       printk: console [ttyMSM0] enabled
       msm_serial: driver initialized
       brd: module loaded
       loop: module loaded
       SCSI Media Changer driver v0.25 
       spmi spmi-0: PMIC arbiter version v1 (0x20000002)
       s1: supplied by regulator-dummy
       s2: supplied by regulator-dummy
       s3: supplied by regulator-dummy
       s4: Bringing 5100000uV into 5000000-5000000uV
       l1: supplied by regulator-dummy
       l2: supplied by regulator-dummy
       l3: supplied by regulator-dummy
       l4: supplied by regulator-dummy
       l5: supplied by regulator-dummy
       l6: supplied by regulator-dummy
       l7: supplied by regulator-dummy
       l8: supplied by regulator-dummy
       l9: supplied by regulator-dummy
       l10: supplied by regulator-dummy
       l11: supplied by regulator-dummy
       l12: supplied by regulator-dummy
       l13: supplied by regulator-dummy
       l14: supplied by regulator-dummy
       l15: supplied by regulator-dummy
       l16: supplied by regulator-dummy
       l17: supplied by regulator-dummy
       l18: supplied by regulator-dummy
       l19: supplied by regulator-dummy
       l20: supplied by regulator-dummy
       l21: supplied by regulator-dummy
       l22: supplied by regulator-dummy
       l23: supplied by regulator-dummy
       l24: supplied by regulator-dummy
       lvs1: supplied by regulator-dummy
       lvs2: supplied by regulator-dummy
       lvs3: supplied by regulator-dummy
       5vs1: supplied by s4
       5vs2: supplied by s4
       libphy: Fixed MDIO Bus: probed
       SLIP: version 0.8.4-NET3.019-NEWTTY (dynamic channels, max=256) (6 bit encapsulation enabled).
       CSLIP: code copyright 1989 Regents of the University of California.
       usbcore: registered new interface driver ax88179_178a
       usbcore: registered new interface driver cdc_ether
       usbcore: registered new interface driver net1080
       usbcore: registered new interface driver cdc_subset
       usbcore: registered new interface driver cdc_ncm
       ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
       ehci-pci: EHCI PCI platform driver
       usbcore: registered new interface driver cdc_acm
       cdc_acm: USB Abstract Control Model driver for USB modems and ISDN adapters
       rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: registered as rtc0
       i2c /dev entries driver
       qcom-smbb fc4cf000.spmi:pm8941@0:charger@1000: Initializing SMBB rev 3
       otg-vbus: supplied by 5vs1
       cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
       cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
       cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
       cpuidle: enable-method property 'qcom,kpss-acc-v2' found operations
       sdhci: Secure Digital Host Controller Interface driver
       sdhci: Copyright(c) Pierre Ossman
       sdhci-pltfm: SDHCI platform and OF driver helper
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       usbcore: registered new interface driver usbhid
       usbhid: USB HID core driver
       oprofile: using timer interrupt.
       NET: Registered protocol family 17
       Key type dns_resolver registered
       Registering SWP/SWPB emulation handler
       Loading compiled-in X.509 certificates
       debugfs: Directory 'fc4a9000.thermal-sensor' with parent 'tsens' already present!
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       rtc-pm8xxx fc4cf000.spmi:pm8941@0:rtc@6000: setting system clock to 1970-01-03T01:15:24 UTC (177324)
->     ### dt-test ### start of unittest - you will see error messages
       s1: supplied by regulator-dummy
ok     Duplicate name in testcase-data, renamed to "duplicate-name#1"
       s1: Bringing 0uV into 675000-675000uV
       s2: supplied by regulator-dummy
ok     OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
       s2: Bringing 0uV into 500000-500000uV
ok     OF: /testcase-data/phandle-tests/consumer-a: could not get #phandle-cells-missing for /testcase-data/phandle-tests/provider1
       s3: supplied by regulator-dummy
ok     OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
       s3: Bringing 0uV into 500000-500000uV
ok     OF: /testcase-data/phandle-tests/consumer-a: could not find phandle
       s4: supplied by regulator-dummy
ok     OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
       s4: Bringing 0uV into 500000-500000uV
       s5: supplied by regulator-dummy
ok     OF: /testcase-data/phandle-tests/consumer-a: #phandle-cells = 3 found -1
       s6: supplied by regulator-dummy
ok     OF: /testcase-data/phandle-tests/consumer-b: could not get #phandle-missing-cells for /testcase-data/phandle-tests/provider1
       s7: supplied by regulator-dummy
ok     OF: /testcase-data/phandle-tests/consumer-b: could not find phandle
       s8: supplied by regulator-dummy
       s1: supplied by regulator-dummy
ok     OF: /testcase-data/phandle-tests/consumer-b: #phandle-cells = 2 found -1
       s1: Bringing 0uV into 1300000-1300000uV
ok     platform testcase-data:testcase-device2: IRQ index 0 not found
       s2: supplied by regulator-dummy
       s2: Bringing 0uV into 2150000-2150000uV
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest0/status
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       s3: supplied by regulator-dummy
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest1/status
       s3: Bringing 0uV into 1800000-1800000uV
       l1: supplied by s1
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest2/status
       l1: Bringing 0uV into 1225000-1225000uV
       l2: supplied by s3
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest3/status
       l2: Bringing 0uV into 1200000-1200000uV
       l3: supplied by s1
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest5/status
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       l3: Bringing 0uV into 1225000-1225000uV
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest6/status
       l4: supplied by s1
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest7/status
       l4: Bringing 0uV into 1225000-1225000uV
       l5: supplied by s2
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/status
       l5: Bringing 0uV into 1800000-1800000uV
       l6: supplied by s2
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/test-unittest8/property-foo
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       l6: Bringing 0uV into 1800000-1800000uV
ok     OF: overlay: node_overlaps_later_cs: #6 overlaps with #7 @/testcase-data/overlay-node/test-bus/test-unittest8
ok     OF: overlay: overlay #6 is not topmost
       l7: supplied by s2
ok     i2c i2c-1: Added multiplexed i2c bus 2
       l7: Bringing 0uV into 1800000-1800000uV
       sdhci_msm f98a4900.sdhci: Got CD GPIO
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest12/status
       l8: supplied by regulator-dummy
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data/overlay-node/test-bus/i2c-test-bus/test-unittest13/status
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       l8: Bringing 0uV into 1800000-1800000uV
ok     i2c i2c-1: Added multiplexed i2c bus 3
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       l9: supplied by regulator-dummy
       l9: Bringing 0uV into 1800000-1800000uV
       GPIO line 315 (line-B-input) hogged as input
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       GPIO line 309 (line-A-input) hogged as input
       sdhci_msm f98a4900.sdhci: Got CD GPIO
**     (of_unittest_expect WARNING - not found ---> ) GPIO line <<int>> (line-A-input) hogged as input
       l10: supplied by regulator-dummy
**     (of_unittest_expect WARNING - not found ---> ) GPIO line <<int>> (line-B-input) hogged as input
       l10: Bringing 0uV into 1800000-1800000uV
       GPIO line 307 (line-D-input) hogged as input
       sdhci_msm f98a4900.sdhci: Got CD GPIO
**     (of_unittest_expect WARNING - not found ---> ) GPIO line <<int>> (line-D-input) hogged as input
       l11: supplied by s1
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       GPIO line 301 (line-C-input) hogged as input
       l11: Bringing 0uV into 1300000-1300000uV
**     (of_unittest_expect WARNING - not found ---> ) GPIO line <<int>> (line-C-input) hogged as input
       l12: supplied by s2
       l12: Bringing 0uV into 1800000-1800000uV
       l13: supplied by regulator-dummy
       l13: Bringing 0uV into 1800000-1800000uV
       l14: supplied by s2
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/status
       l14: Bringing 0uV into 1800000-1800000uV
       sdhci_msm f98a4900.sdhci: Got CD GPIO
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/status
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@30/incline-up
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/fairway-1/ride@100/track@40/incline-up
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/status
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/color
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/lights@40000/rate
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/hvac_2
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_left
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /__symbols__/ride_200_right
       l15: supplied by s2
       l15: Bringing 0uV into 2050000-2050000uV
       l16: supplied by regulator-dummy
       l16: Bringing 0uV into 2700000-2700000uV
       l17: supplied by regulator-dummy
       l17: Bringing 0uV into 2700000-2700000uV
       l18: supplied by regulator-dummy
ok     OF: overlay: ERROR: multiple fragments add and/or delete node /testcase-data-2/substation@100/motor-1/controller
       l18: Bringing 0uV into 2850000-2850000uV
ok     OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/controller/name
       l19: supplied by regulator-dummy
       l19: Bringing 0uV into 3300000-3300000uV
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
ok     OF: overlay: WARNING: memory leak will occur if overlay removed, property: /testcase-data-2/substation@100/motor-1/rpm_avail
ok     OF: overlay: ERROR: multiple fragments add, update, and/or delete property /testcase-data-2/substation@100/motor-1/rpm_avail
       l20: supplied by regulator-dummy
->     ### dt-test ### end of unittest - 259 passed, 0 failed
       l20: Bringing 0uV into 2950000-2950000uV
       ALSA device list:
       l21: supplied by regulator-dummy
         No soundcard�[    4.252703] l22: supplied by regulator-dummy
       l22: Bringing 0uV into 3000000-3000000uV
       Freeing unused kernel memory: 1024K
       l23: supplied by regulator-dummy
       Run /init as init process
       l23: Bringing 0uV into 3000000-3000000uV
       l24: supplied by regulator-dummy
       l24: Bringing 0uV into 3075000-3075000uV
       lvs1: supplied by s3
       mkdir: can't create directory '/bin': File exists
       lvs2: supplied by s3
       lvs3: supplied by s3
       5vs1: supplied by s4
       mkdir: can't create directory '/dev': File exists
       5vs2: supplied by s4
       /init: line 25: can't create /proc/sys/kernel/hotplug: nonexistent directory
       mmc0: SDHCI controller on f9824900.sdhci [f9824900.sdhci] using ADMA
       sdhci_msm f98a4900.sdhci: Got CD GPIO
       mdev: unknown user/group 'root:uucp' on line 34
       mmc1: SDHCI controller on f98a4900.sdhci [f98a4900.sdhci] using ADMA
       mmc0: new HS200 MMC card at address 0001
       mmcblk0: mmc0:0001 SEM16G 14.7 GiB 
       mmcblk0boot0: mmc0:0001 SEM16G partition 1 4.00 MiB
       mmcblk0boot1: mmc0:0001 SEM16G partition 2 4.00 MiB
       mmcblk0rpmb: mmc0:0001 SEM16G partition 3 4.00 MiB, chardev (247:0)
       mmc1: new ultra high speed DDR50 SDHC card at address aaaa
        mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14 p15 p16 p17 p18 p19 p20
       mmcblk1: mmc1:aaaa SU16G 14.8 GiB 
        mmcblk1: p1
       Attempt to mount partitions: /usr/system /usr/data
       Mounting partitions from: /dev/mmcblk0
       EXT4-fs (mmcblk0p12): mounted filesystem with ordered data mode. Opts: (null)
       random: fast init done
       EXT4-fs (mmcblk0p13): recovery complete
       EXT4-fs (mmcblk0p13): mounted filesystem with ordered data mode. Opts: (null)
       / # 
       / # 
       / # cat /proc/version
       Linux version 5.5.0-rc2-00002-gbc60035cbebc-dirty (frowand@xps8900) (gcc version 4.6.x-google 20120106 (prerelease) (GCC)) #25 SMP PREEMPT Wed Jan 15 00:19:58 CST 2020
       / # 
