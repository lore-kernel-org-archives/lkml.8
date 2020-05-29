Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C417C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A15B92072D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590796362;
	bh=GoE0sCkwvWY1HVWiWJud470k9tQkCqnBWnElHWVyrZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Ztp16JhW4KRh41NFCPhjByMegtCjf7gP//r3MdIxH1d9gkHMdgfhT0tn1DbCXtzSo
	 XX/K7bA1HrUFIM7Fp1KdY3jhnT+dNk0JBNJhP2U94448TarSGkDHuZK17Hu1h16wUq
	 pfP3nJhtyRHN3EWBL6PJ6rKpdA2lXxAAx7xYmnhE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728571AbgE2Xwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE2Xwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:52:35 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4135C03E969;
        Fri, 29 May 2020 16:52:35 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d3so1846186pln.1;
        Fri, 29 May 2020 16:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DoeqQ61KEp23dMsKDljNhuJ51KAPxS33QZn3cbr8KZI=;
        b=bKlELAnP+ovXjs6w0yzQnpFKQ5LFx25dXmnLDUb/BXP3NnP7i1eMdvuv4jE9I95Nmr
         3a0dHII3HM3CiIDycIrENI3wUfMFnEjTevvxx5LPVf6WS6IQE4+uWUvvA9fPhhDDc/XE
         s9Uma/F3BUn5tELdQ2D6QAJUZ5rAPmHxmtIeaamIZIMdOSqL+eIThPxxYgRu5Dj1AJnr
         AGmxzFlKhQx2dNkhqcdiBgA1WHOxH5BayOOPZvL/FGiXliSR3An3btMlP53mVLDDsGDi
         Qz0HIZBnp0T/0U6BuizI3BU1tn5mbP/HvS5xUue2aWcGgNTrvFUNvLMdq5upYaqX8rmn
         /zAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DoeqQ61KEp23dMsKDljNhuJ51KAPxS33QZn3cbr8KZI=;
        b=ZbwQeEro+4vWfVAHc33QaPVX0TTUWCvEXBEXc8++Hq4T4r+xmZ+ZG8W88nF08cJdYT
         DQyi6MOYblT4MIddOExgsJVdQLHoyUp9D3ctA9lWiUW7flSKHyeE5+JeyZZ246bddW4P
         apebm2Skx4ZTMS+MenwPZvY79oyJgHdNEQmfxuq9WAEhldF9Pj4P8KWUJjWViOMqbUgY
         GIUMcBSzYhtd2y7kPr2i5yUWXZ6pMLhnEcsdWRcnXquJnhKArJQ9gQr99GDYLrQBKOwY
         uWAqPyhO33UqQWzS8tAG1K6QQEJc9ijKflZl1QBuqPOQ9Az71J7h7BCPIF8pj6faFI58
         kBbg==
X-Gm-Message-State: AOAM532SARexkfymgO81fdQO4QjHLky+VhRg2lxoS7XxT0U/6CcBxhdA
        CtTHs2hzTcs3834ZtJvgFWw=
X-Google-Smtp-Source: ABdhPJx4mgPTW/wImVE9Z1vz9EuQJEr3RpaKe5UAW/2Rq/Z+2/Iia5lRTJeW76Lmi8crWZKZA8PzVQ==
X-Received: by 2002:a17:90b:8d8:: with SMTP id ds24mr12413163pjb.55.1590796353828;
        Fri, 29 May 2020 16:52:33 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id y186sm7877161pfy.66.2020.05.29.16.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 16:52:31 -0700 (PDT)
Date:   Fri, 29 May 2020 16:52:29 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Logan Perkins <logan@lkml.lp-programming.com>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Cc:     ngupta@vflare.org, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: zram with writeback fails writing to backing_dev
Message-ID: <20200529235229.GE86436@google.com>
References: <a4a81aa4-4570-08c2-14c1-2ca0a0a8fcd0@lp-programming.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4a81aa4-4570-08c2-14c1-2ca0a0a8fcd0@lp-programming.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Logan,

It's the regression of [1] since v5.0. We reverted the automatic
incompress page writeback because wanted VM to handle it
automatically if user configures two swaps in the system(one for
zram, the other one is disk based swap)
Still, we could support incompressire writeback manually at zram
but I don't think that's what you want.
Your reports makes me increase of the priority of the feature.
Hopefully, I will grab some time to support it in VM layer.

[1] a939888ec38b, zram: support idle/huge page writeback

On Thu, May 21, 2020 at 08:43:42PM -0700, Logan Perkins wrote:
> 
> [1.] zram with writeback fails writing to backing_dev
> [2.] When I set up /dev/zram0 with a backing device, and then feed it
> sufficient
> incompressible data that it has to push some to the backing device, I start
> getting Buffer I/O errors showing up in dmesg. If there is a filesystem on
> /dev/zram0, it usually gets remounted ro within a couple seconds, and
> whatever
> data was written to it gets garbled. This happens either with a loop device
> or
> a sata disk partition used as the backing device.
> [3.] ZRAM, ZRAM_WRITEBACK
> [4.] Kernel information
> [4.1.] First encountered: Linux version 5.6.14-gentoo-lp-debiancfg2020.5
> (root@gentoo-server) (gcc version 9.2.0 (Gentoo 9.2.0-r2 p3)) #1 SMP PREEMPT
> Thu May 21 01:23:37 PDT 2020
> Subsequent Testing: Linux version 5.7.0-rc6-x86_64 (root@BIT-testing) (gcc
> version 9.2.0 (Gentoo Hardened 9.2.0-r2 p3), GNU ld (Gentoo 2.33.1 p2)
> 2.33.1) #3 SMP Thu May 21 15:29:23 PDT 2020
> [4.2.] Kernel .config file: See Attached (from 5.7.0-rc6)
> [5.] 5.0? Maybe 5.1, last used successfully about a year ago.
> [6.] Not getting an oops, just the filesystem and block write errors, dmesg
> output attached.
> [7.] (as root)
> #!/bin/bash
> modprobe zram
> cd /tmp
> dd if=/dev/zero of=loop0.img bs=1M count=1024
> losetup /dev/loop0 /tmp/loop0.img
> cd /sys/block/zram0
> echo /dev/loop0 > backing_dev
> echo $((1024*1024*256)) > mem_limit
> echo $((1024*1024*1024*10)) > disksize
> dd if=/dev/urandom of=/dev/zram0 bs=1M count=1024 &
> dmesg -wH
> # note that mkfs.ext4 /dev/zram0, followed by mounting it and putting a
> large
> # file on it also demonstrates the issue, as does using it as swap and
> consuming
> # lots of memory.
> 
> [8.] Environment
> [8.1.] Software (add the output of the ver_linux script here)
> Linux BIT-testing 5.7.0-rc6-x86_64 #3 SMP Thu May 21 15:29:23 PDT 2020
> x86_64 Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz GenuineIntel GNU/Linux
> 
> GNU C 9.2.0
> GNU Make 4.2.1
> Binutils 2.33.1
> Util-linux 2.33.2
> Mount 2.33.2
> Module-init-tools 26
> E2fsprogs 1.45.5
> PPP 2.4.8
> Bison 3.1
> Flex 2.6.4
> Linux C++ Library 6.0.27
> Linux C Library 2.29
> Dynamic linker (ldd) 2.29
> Procps 3.3.15
> Net-tools 2.10
> Kbd 2.0.4
> Console-tools 2.0.4
> Sh-utils 8.31
> Udev 243
> Modules Loaded 3w_9xxx 3w_xxxx aacraid ahci aic79xx aic7xxx aic94xx arcmsr
> async_memcpy async_pq async_raid6_recov async_tx async_xor ata_piix atp870u
> binfmt_misc btrfs BusLogic coretemp crypto_engine dax dc395x dm_bufio
> dm_crypt dm_log dm_log_writes dm_mirror dm_mod dm_region_hash dm_snapshot
> dmx3191d dm_zero gdth grace i2c_i801 initio input_leds joydev led_class
> libahci libsas linear lockd lpfc lzo lzo_compress megaraid megaraid_mbox
> megaraid_mm megaraid_sas mptbase mptfc mptsas mptscsih mptspi multipath nfs
> nvme nvme_core nvme_fabrics nvme_fc nvme_loop nvmet nvmet_fc pata_ali
> pata_amd pata_artop pata_atiixp pata_cmd64x pata_efar pata_hpt366
> pata_hpt37x pata_hpt3x2n pata_hpt3x3 pata_it8213 pata_it821x pata_jmicron
> pata_marvell pata_mpiix pata_netcell pata_ns87410 pata_ns87415 pata_opti
> pata_optidma pata_pdc2027x pata_pdc202xx_old pata_radisys pata_rz1000
> pata_serverworks pata_sil680 pata_sis pata_sl82c105 pata_triflex pata_via
> pdc_adma qla1280 qla2xxx raid0 raid10 raid1 raid456 raid6_pq rtc_cmos
> sata_inic162x sata_mv sata_nv sata_promise sata_qstor sata_sil sata_sil24
> sata_sis sata_svw sata_sx4 sata_uli sata_via sata_vsc scsi_transport_fc
> scsi_transport_sas scsi_transport_spi sg sl811_hcd sunrpc sym53c8xx uas
> usbhid virtio_crypto virtio_input x86_pkg_temp_thermal xhci_plat_hcd xor
> xxhash zram zsmalloc zstd_compress zstd_decompress
> 
> [8.2.] Processor information (from /proc/cpuinfo): 8 cores of
> processor : 7
> vendor_id : GenuineIntel
> cpu family : 6
> model : 94
> model name : Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz
> stepping : 3
> microcode : 0xc2
> cpu MHz : 3824.280
> cache size : 8192 KB
> physical id : 0
> siblings : 8
> core id : 3
> cpu cores : 4
> apicid : 7
> initial apicid : 7
> fpu : yes
> fpu_exception : yes
> cpuid level : 22
> wp : yes
> flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
> pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
> rdtscp lm constant_tsc art arch_perfmon pebs bts rep_good nopl xtopology
> nonstop_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est
> tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
> tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch
> cpuid_fault invpcid_single pti ibrs ibpb stibp tpr_shadow vnmi flexpriority
> ept vpid ept_ad fsgsbase tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm
> mpx rdseed adx smap clflushopt intel_pt xsaveopt xsavec xgetbv1 xsaves
> dtherm ida arat pln pts hwp hwp_notify hwp_act_window hwp_epp
> vmx flags : vnmi preemption_timer invvpid ept_x_only ept_ad ept_1gb
> flexpriority tsc_offset vtpr mtf vapic ept vpid unrestricted_guest ple
> shadow_vmcs pml
> bugs : cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs
> taa itlb_multihit
> bogomips : 6802.13
> clflush size : 64
> cache_alignment : 64
> address sizes : 39 bits physical, 48 bits virtual
> power management:
> 
> [8.3.] Module information (from /proc/modules):
> lzo 16384 8 - Live 0xffffffffc09ba000
> zram 32768 1 - Live 0xffffffffc09ac000
> zsmalloc 24576 1 zram, Live 0xffffffffc099d000
> binfmt_misc 20480 1 - Live 0xffffffffc093a000
> x86_pkg_temp_thermal 16384 0 - Live 0xffffffffc09a7000
> coretemp 16384 0 - Live 0xffffffffc0935000
> joydev 24576 0 - Live 0xffffffffc092e000
> input_leds 16384 0 - Live 0xffffffffc0929000
> led_class 16384 1 input_leds, Live 0xffffffffc0924000
> rtc_cmos 24576 1 - Live 0xffffffffc091d000
> i2c_i801 28672 0 - Live 0xffffffffc0910000
> nfs 290816 0 - Live 0xffffffffc09ea000
> lockd 94208 1 nfs, Live 0xffffffffc09c9000
> grace 16384 1 lockd, Live 0xffffffffc09c4000
> sunrpc 376832 2 nfs,lockd, Live 0xffffffffc0940000
> btrfs 1376256 1 - Live 0xffffffffc07bf000
> zstd_decompress 81920 1 btrfs, Live 0xffffffffc07a5000
> zstd_compress 184320 1 btrfs, Live 0xffffffffc0772000
> xxhash 16384 2 zstd_decompress,zstd_compress, Live 0xffffffffc074d000
> lzo_compress 16384 2 lzo,btrfs, Live 0xffffffffc0498000
> multipath 16384 0 - Live 0xffffffffc076d000
> linear 16384 0 - Live 0xffffffffc0768000
> raid10 57344 0 - Live 0xffffffffc0754000
> raid456 143360 0 - Live 0xffffffffc0729000
> async_raid6_recov 16384 1 raid456, Live 0xffffffffc0724000
> async_memcpy 16384 1 raid456, Live 0xffffffffc071f000
> async_pq 16384 1 raid456, Live 0xffffffffc06f5000
> async_xor 16384 2 raid456,async_pq, Live 0xffffffffc05ee000
> async_tx 16384 5 raid456,async_raid6_recov,async_memcpy,async_pq,async_xor,
> Live 0xffffffffc05b3000
> xor 24576 2 btrfs,async_xor, Live 0xffffffffc05cf000
> raid6_pq 118784 4 btrfs,raid456,async_raid6_recov,async_pq, Live
> 0xffffffffc0701000
> raid1 45056 0 - Live 0xffffffffc05a7000
> raid0 20480 0 - Live 0xffffffffc06fb000
> dm_zero 16384 0 - Live 0xffffffffc0181000
> dm_snapshot 53248 0 - Live 0xffffffffc06e7000
> dm_mirror 28672 0 - Live 0xffffffffc06df000
> dm_region_hash 20480 1 dm_mirror, Live 0xffffffffc06d9000
> dm_log_writes 20480 0 - Live 0xffffffffc06d3000
> dm_log 20480 2 dm_mirror,dm_region_hash, Live 0xffffffffc06cd000
> dm_crypt 45056 0 - Live 0xffffffffc06c1000
> dm_bufio 28672 1 dm_snapshot, Live 0xffffffffc06b9000
> dm_mod 135168 7
> dm_zero,dm_snapshot,dm_mirror,dm_log_writes,dm_log,dm_crypt,dm_bufio, Live
> 0xffffffffc0697000
> dax 28672 1 dm_mod, Live 0xffffffffc059f000
> sl811_hcd 28672 0 - Live 0xffffffffc0597000
> usbhid 40960 0 - Live 0xffffffffc048d000
> uas 28672 0 - Live 0xffffffffc0485000
> xhci_plat_hcd 16384 0 - Live 0xffffffffc011d000
> pata_sl82c105 16384 0 - Live 0xffffffffc0692000
> pata_via 20480 0 - Live 0xffffffffc068c000
> pata_jmicron 16384 0 - Live 0xffffffffc0687000
> pata_marvell 16384 0 - Live 0xffffffffc039e000
> pata_netcell 16384 0 - Live 0xffffffffc0352000
> pata_pdc202xx_old 16384 0 - Live 0xffffffffc0205000
> pata_triflex 16384 0 - Live 0xffffffffc01a8000
> pata_atiixp 16384 0 - Live 0xffffffffc067e000
> pata_opti 16384 0 - Live 0xffffffffc0676000
> pata_amd 24576 0 - Live 0xffffffffc066b000
> pata_ali 20480 0 - Live 0xffffffffc0661000
> pata_it8213 16384 0 - Live 0xffffffffc0659000
> pata_ns87415 16384 0 - Live 0xffffffffc0651000
> pata_ns87410 16384 0 - Live 0xffffffffc0649000
> pata_serverworks 16384 0 - Live 0xffffffffc0640000
> pata_artop 16384 0 - Live 0xffffffffc063b000
> pata_it821x 16384 0 - Live 0xffffffffc0632000
> pata_optidma 16384 0 - Live 0xffffffffc062d000
> pata_hpt3x2n 16384 0 - Live 0xffffffffc0628000
> pata_hpt3x3 16384 0 - Live 0xffffffffc0623000
> pata_hpt37x 24576 0 - Live 0xffffffffc061c000
> pata_hpt366 16384 0 - Live 0xffffffffc0617000
> pata_cmd64x 16384 0 - Live 0xffffffffc0612000
> pata_efar 16384 0 - Live 0xffffffffc060d000
> pata_rz1000 16384 0 - Live 0xffffffffc0608000
> pata_sil680 16384 0 - Live 0xffffffffc0603000
> pata_radisys 16384 0 - Live 0xffffffffc05fe000
> pata_pdc2027x 16384 0 - Live 0xffffffffc05f9000
> pata_mpiix 16384 0 - Live 0xffffffffc05f4000
> aic94xx 90112 0 - Live 0xffffffffc05d7000
> libsas 86016 1 aic94xx, Live 0xffffffffc05b9000
> lpfc 974848 0 - Live 0xffffffffc04a8000
> nvmet_fc 32768 1 lpfc, Live 0xffffffffc049f000
> qla2xxx 860160 0 - Live 0xffffffffc03b2000
> megaraid_mbox 40960 0 - Live 0xffffffffc03a7000
> megaraid_mm 20480 1 megaraid_mbox, Live 0xffffffffc02ff000
> aacraid 135168 0 - Live 0xffffffffc037c000
> 3w_9xxx 49152 0 - Live 0xffffffffc036f000
> 3w_xxxx 32768 0 - Live 0xffffffffc0366000
> mptsas 49152 0 - Live 0xffffffffc0359000
> scsi_transport_sas 40960 3 aic94xx,libsas,mptsas, Live 0xffffffffc0347000
> mptfc 20480 0 - Live 0xffffffffc02df000
> atp870u 28672 0 - Live 0xffffffffc02b2000
> dc395x 45056 0 - Live 0xffffffffc033b000
> qla1280 32768 0 - Live 0xffffffffc0263000
> dmx3191d 24576 0 - Live 0xffffffffc021d000
> sym53c8xx 90112 0 - Live 0xffffffffc0324000
> gdth 90112 0 - Live 0xffffffffc030d000
> initio 28672 0 - Live 0xffffffffc0305000
> BusLogic 32768 0 - Live 0xffffffffc02f6000
> arcmsr 53248 0 - Live 0xffffffffc02e8000
> aic7xxx 143360 0 - Live 0xffffffffc02bb000
> aic79xx 147456 0 - Live 0xffffffffc028d000
> sg 36864 0 - Live 0xffffffffc027e000
> megaraid 45056 0 - Live 0xffffffffc026d000
> megaraid_sas 159744 0 - Live 0xffffffffc023b000
> mptspi 24576 0 - Live 0xffffffffc0230000
> mptscsih 28672 3 mptsas,mptfc,mptspi, Live 0xffffffffc0224000
> mptbase 69632 4 mptsas,mptfc,mptspi,mptscsih, Live 0xffffffffc020b000
> scsi_transport_spi 28672 5 dmx3191d,sym53c8xx,aic7xxx,aic79xx,mptspi, Live
> 0xffffffffc01fd000
> pdc_adma 16384 0 - Live 0xffffffffc01f4000
> sata_inic162x 16384 0 - Live 0xffffffffc01eb000
> sata_mv 36864 0 - Live 0xffffffffc01dc000
> sata_qstor 16384 0 - Live 0xffffffffc01d3000
> sata_vsc 16384 0 - Live 0xffffffffc01cb000
> sata_uli 16384 0 - Live 0xffffffffc01c6000
> sata_sis 16384 0 - Live 0xffffffffc01c1000
> pata_sis 20480 1 sata_sis, Live 0xffffffffc01b7000
> sata_sx4 20480 0 - Live 0xffffffffc01ad000
> sata_nv 32768 0 - Live 0xffffffffc019f000
> sata_via 20480 0 - Live 0xffffffffc0195000
> sata_svw 16384 0 - Live 0xffffffffc0190000
> sata_sil24 24576 0 - Live 0xffffffffc0189000
> sata_sil 16384 0 - Live 0xffffffffc0171000
> sata_promise 20480 0 - Live 0xffffffffc0144000
> ata_piix 36864 0 - Live 0xffffffffc0107000
> ahci 40960 0 - Live 0xffffffffc0176000
> libahci 36864 1 ahci, Live 0xffffffffc0167000
> nvme_fc 40960 2 lpfc,qla2xxx, Live 0xffffffffc0157000
> nvme_loop 20480 0 - Live 0xffffffffc014d000
> nvmet 86016 2 nvmet_fc,nvme_loop, Live 0xffffffffc012e000
> nvme_fabrics 24576 2 nvme_fc,nvme_loop, Live 0xffffffffc0123000
> nvme 40960 0 - Live 0xffffffffc0112000
> nvme_core 94208 4 nvme_fc,nvme_loop,nvme_fabrics,nvme, Live
> 0xffffffffc00ef000
> scsi_transport_fc 61440 3 lpfc,qla2xxx,mptfc, Live 0xffffffffc00df000
> virtio_crypto 24576 0 - Live 0xffffffffc00d4000
> crypto_engine 16384 1 virtio_crypto, Live 0xffffffffc00cc000
> virtio_input 16384 0 - Live 0xffffffffc00c4000
> 
> [8.7.] Tested on two different desktop machines, AMD and Intel, and a
> raspberry pi,
> bug present on all. Desktops are one stable desktop machine, and one minimal
> install
> specifically for testing. Raspberry pi is a pi 4, running rasbian, with zram
> built
> from latest

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86 5.7.0-rc6 Kernel Configuration
> #
> 
> #
> # Compiler: gcc (Gentoo Hardened 9.2.0-r2 p3) 9.2.0
> #
> CONFIG_CC_IS_GCC=y
> CONFIG_GCC_VERSION=90200
> CONFIG_LD_VERSION=233010000
> CONFIG_CLANG_VERSION=0
> CONFIG_CC_CAN_LINK=y
> CONFIG_CC_HAS_ASM_GOTO=y
> CONFIG_CC_HAS_ASM_INLINE=y
> CONFIG_IRQ_WORK=y
> CONFIG_BUILDTIME_TABLE_SORT=y
> CONFIG_THREAD_INFO_IN_TASK=y
> 
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=32
> # CONFIG_COMPILE_TEST is not set
> CONFIG_LOCALVERSION="-x86_64"
> # CONFIG_LOCALVERSION_AUTO is not set
> CONFIG_BUILD_SALT=""
> CONFIG_HAVE_KERNEL_GZIP=y
> CONFIG_HAVE_KERNEL_BZIP2=y
> CONFIG_HAVE_KERNEL_LZMA=y
> CONFIG_HAVE_KERNEL_XZ=y
> CONFIG_HAVE_KERNEL_LZO=y
> CONFIG_HAVE_KERNEL_LZ4=y
> # CONFIG_KERNEL_GZIP is not set
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> CONFIG_KERNEL_XZ=y
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> CONFIG_DEFAULT_HOSTNAME="(none)"
> CONFIG_SWAP=y
> CONFIG_SYSVIPC=y
> CONFIG_SYSVIPC_SYSCTL=y
> CONFIG_POSIX_MQUEUE=y
> CONFIG_POSIX_MQUEUE_SYSCTL=y
> CONFIG_CROSS_MEMORY_ATTACH=y
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=y
> CONFIG_HAVE_ARCH_AUDITSYSCALL=y
> CONFIG_AUDITSYSCALL=y
> 
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=y
> CONFIG_GENERIC_IRQ_SHOW=y
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=y
> CONFIG_GENERIC_PENDING_IRQ=y
> CONFIG_GENERIC_IRQ_MIGRATION=y
> CONFIG_HARDIRQS_SW_RESEND=y
> CONFIG_IRQ_DOMAIN=y
> CONFIG_IRQ_DOMAIN_HIERARCHY=y
> CONFIG_GENERIC_MSI_IRQ=y
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=y
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=y
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=y
> CONFIG_IRQ_FORCED_THREADING=y
> CONFIG_SPARSE_IRQ=y
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
> 
> CONFIG_CLOCKSOURCE_WATCHDOG=y
> CONFIG_ARCH_CLOCKSOURCE_INIT=y
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=y
> CONFIG_GENERIC_TIME_VSYSCALL=y
> CONFIG_GENERIC_CLOCKEVENTS=y
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=y
> CONFIG_GENERIC_CMOS_UPDATE=y
> 
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> CONFIG_NO_HZ_IDLE=y
> # CONFIG_NO_HZ_FULL is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem
> 
> CONFIG_PREEMPT_NONE=y
> # CONFIG_PREEMPT_VOLUNTARY is not set
> # CONFIG_PREEMPT is not set
> 
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_TICK_CPU_ACCOUNTING=y
> # CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
> # CONFIG_IRQ_TIME_ACCOUNTING is not set
> # CONFIG_SCHED_THERMAL_PRESSURE is not set
> CONFIG_BSD_PROCESS_ACCT=y
> CONFIG_BSD_PROCESS_ACCT_V3=y
> CONFIG_TASKSTATS=y
> CONFIG_TASK_DELAY_ACCT=y
> CONFIG_TASK_XACCT=y
> CONFIG_TASK_IO_ACCOUNTING=y
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
> 
> CONFIG_CPU_ISOLATION=y
> 
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=y
> CONFIG_TREE_SRCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> # end of RCU Subsystem
> 
> CONFIG_IKCONFIG=y
> CONFIG_IKCONFIG_PROC=y
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=15
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=17
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=13
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=y
> 
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
> 
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=y
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=y
> CONFIG_CC_HAS_INT128=y
> CONFIG_ARCH_SUPPORTS_INT128=y
> CONFIG_CGROUPS=y
> CONFIG_PAGE_COUNTER=y
> CONFIG_MEMCG=y
> # CONFIG_MEMCG_SWAP is not set
> CONFIG_MEMCG_KMEM=y
> # CONFIG_BLK_CGROUP is not set
> # CONFIG_CGROUP_SCHED is not set
> CONFIG_CGROUP_PIDS=y
> # CONFIG_CGROUP_RDMA is not set
> # CONFIG_CGROUP_FREEZER is not set
> # CONFIG_CGROUP_HUGETLB is not set
> CONFIG_CPUSETS=y
> CONFIG_PROC_PID_CPUSET=y
> # CONFIG_CGROUP_DEVICE is not set
> CONFIG_CGROUP_CPUACCT=y
> # CONFIG_CGROUP_PERF is not set
> CONFIG_CGROUP_BPF=y
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=y
> CONFIG_NAMESPACES=y
> CONFIG_UTS_NS=y
> CONFIG_TIME_NS=y
> CONFIG_IPC_NS=y
> # CONFIG_USER_NS is not set
> CONFIG_PID_NS=y
> CONFIG_NET_NS=y
> CONFIG_CHECKPOINT_RESTORE=y
> # CONFIG_SCHED_AUTOGROUP is not set
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=y
> CONFIG_BLK_DEV_INITRD=y
> CONFIG_INITRAMFS_SOURCE=""
> CONFIG_RD_GZIP=y
> CONFIG_RD_BZIP2=y
> CONFIG_RD_LZMA=y
> CONFIG_RD_XZ=y
> CONFIG_RD_LZO=y
> CONFIG_RD_LZ4=y
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=y
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_SYSCTL=y
> CONFIG_HAVE_UID16=y
> CONFIG_SYSCTL_EXCEPTION_TRACE=y
> CONFIG_HAVE_PCSPKR_PLATFORM=y
> CONFIG_BPF=y
> CONFIG_EXPERT=y
> CONFIG_UID16=y
> CONFIG_MULTIUSER=y
> # CONFIG_SGETMASK_SYSCALL is not set
> CONFIG_SYSFS_SYSCALL=y
> CONFIG_FHANDLE=y
> CONFIG_POSIX_TIMERS=y
> CONFIG_PRINTK=y
> CONFIG_PRINTK_NMI=y
> CONFIG_BUG=y
> CONFIG_ELF_CORE=y
> CONFIG_PCSPKR_PLATFORM=y
> CONFIG_BASE_FULL=y
> CONFIG_FUTEX=y
> CONFIG_FUTEX_PI=y
> CONFIG_EPOLL=y
> CONFIG_SIGNALFD=y
> CONFIG_TIMERFD=y
> CONFIG_EVENTFD=y
> CONFIG_SHMEM=y
> CONFIG_AIO=y
> CONFIG_IO_URING=y
> CONFIG_ADVISE_SYSCALLS=y
> CONFIG_MEMBARRIER=y
> CONFIG_KALLSYMS=y
> # CONFIG_KALLSYMS_ALL is not set
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=y
> CONFIG_KALLSYMS_BASE_RELATIVE=y
> CONFIG_BPF_SYSCALL=y
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=y
> # CONFIG_USERFAULTFD is not set
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=y
> CONFIG_RSEQ=y
> # CONFIG_DEBUG_RSEQ is not set
> CONFIG_EMBEDDED=y
> CONFIG_HAVE_PERF_EVENTS=y
> # CONFIG_PC104 is not set
> 
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=y
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
> 
> CONFIG_VM_EVENT_COUNTERS=y
> CONFIG_COMPAT_BRK=y
> CONFIG_SLAB=y
> # CONFIG_SLUB is not set
> # CONFIG_SLOB is not set
> CONFIG_SLAB_MERGE_DEFAULT=y
> # CONFIG_SLAB_FREELIST_RANDOM is not set
> # CONFIG_SHUFFLE_PAGE_ALLOCATOR is not set
> # CONFIG_PROFILING is not set
> CONFIG_TRACEPOINTS=y
> # end of General setup
> 
> CONFIG_64BIT=y
> CONFIG_X86_64=y
> CONFIG_X86=y
> CONFIG_INSTRUCTION_DECODER=y
> CONFIG_OUTPUT_FORMAT="elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=y
> CONFIG_STACKTRACE_SUPPORT=y
> CONFIG_MMU=y
> CONFIG_ARCH_MMAP_RND_BITS_MIN=28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=16
> CONFIG_GENERIC_ISA_DMA=y
> CONFIG_GENERIC_BUG=y
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=y
> CONFIG_ARCH_MAY_HAVE_PC_FDC=y
> CONFIG_GENERIC_CALIBRATE_DELAY=y
> CONFIG_ARCH_HAS_CPU_RELAX=y
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=y
> CONFIG_ARCH_HAS_FILTER_PGPROT=y
> CONFIG_HAVE_SETUP_PER_CPU_AREA=y
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=y
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=y
> CONFIG_ARCH_HIBERNATION_POSSIBLE=y
> CONFIG_ARCH_SUSPEND_POSSIBLE=y
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
> CONFIG_ZONE_DMA32=y
> CONFIG_AUDIT_ARCH=y
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=y
> CONFIG_X86_64_SMP=y
> CONFIG_ARCH_SUPPORTS_UPROBES=y
> CONFIG_FIX_EARLYCON_MEM=y
> CONFIG_PGTABLE_LEVELS=4
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
> 
> #
> # Processor type and features
> #
> CONFIG_ZONE_DMA=y
> CONFIG_SMP=y
> CONFIG_X86_FEATURE_NAMES=y
> # CONFIG_X86_X2APIC is not set
> CONFIG_X86_MPPARSE=y
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=y
> # CONFIG_X86_CPU_RESCTRL is not set
> CONFIG_X86_EXTENDED_PLATFORM=y
> # CONFIG_X86_VSMP is not set
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_LPSS is not set
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=y
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=y
> CONFIG_SCHED_OMIT_FRAME_POINTER=y
> CONFIG_HYPERVISOR_GUEST=y
> CONFIG_PARAVIRT=y
> CONFIG_PARAVIRT_XXL=y
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=y
> CONFIG_X86_HV_CALLBACK_VECTOR=y
> CONFIG_XEN=y
> CONFIG_XEN_PV=y
> CONFIG_XEN_PV_SMP=y
> CONFIG_XEN_DOM0=y
> CONFIG_XEN_PVHVM=y
> CONFIG_XEN_PVHVM_SMP=y
> # CONFIG_XEN_512GB is not set
> CONFIG_XEN_SAVE_RESTORE=y
> # CONFIG_XEN_DEBUG_FS is not set
> CONFIG_XEN_PVH=y
> CONFIG_KVM_GUEST=y
> CONFIG_ARCH_CPUIDLE_HALTPOLL=y
> CONFIG_PVH=y
> # CONFIG_KVM_DEBUG_FS is not set
> # CONFIG_PARAVIRT_TIME_ACCOUNTING is not set
> CONFIG_PARAVIRT_CLOCK=y
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=y
> CONFIG_X86_INTERNODE_CACHE_SHIFT=6
> CONFIG_X86_L1_CACHE_SHIFT=6
> CONFIG_X86_TSC=y
> CONFIG_X86_CMPXCHG64=y
> CONFIG_X86_CMOV=y
> CONFIG_X86_MINIMUM_CPU_FAMILY=64
> CONFIG_X86_DEBUGCTLMSR=y
> CONFIG_IA32_FEAT_CTL=y
> CONFIG_X86_VMX_FEATURE_NAMES=y
> CONFIG_PROCESSOR_SELECT=y
> CONFIG_CPU_SUP_INTEL=y
> CONFIG_CPU_SUP_AMD=y
> CONFIG_CPU_SUP_HYGON=y
> CONFIG_CPU_SUP_CENTAUR=y
> CONFIG_CPU_SUP_ZHAOXIN=y
> CONFIG_HPET_TIMER=y
> CONFIG_HPET_EMULATE_RTC=y
> CONFIG_DMI=y
> CONFIG_GART_IOMMU=y
> # CONFIG_MAXSMP is not set
> CONFIG_NR_CPUS_RANGE_BEGIN=2
> CONFIG_NR_CPUS_RANGE_END=512
> CONFIG_NR_CPUS_DEFAULT=64
> CONFIG_NR_CPUS=32
> CONFIG_SCHED_SMT=y
> CONFIG_SCHED_MC=y
> CONFIG_SCHED_MC_PRIO=y
> CONFIG_X86_LOCAL_APIC=y
> CONFIG_X86_IO_APIC=y
> # CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS is not set
> CONFIG_X86_MCE=y
> # CONFIG_X86_MCELOG_LEGACY is not set
> CONFIG_X86_MCE_INTEL=y
> # CONFIG_X86_MCE_AMD is not set
> CONFIG_X86_MCE_THRESHOLD=y
> # CONFIG_X86_MCE_INJECT is not set
> CONFIG_X86_THERMAL_VECTOR=y
> 
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=y
> CONFIG_PERF_EVENTS_INTEL_RAPL=y
> CONFIG_PERF_EVENTS_INTEL_CSTATE=y
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> # end of Performance monitoring
> 
> CONFIG_X86_VSYSCALL_EMULATION=y
> CONFIG_X86_IOPL_IOPERM=y
> # CONFIG_I8K is not set
> CONFIG_MICROCODE=y
> CONFIG_MICROCODE_INTEL=y
> CONFIG_MICROCODE_AMD=y
> CONFIG_MICROCODE_OLD_INTERFACE=y
> CONFIG_X86_MSR=m
> CONFIG_X86_CPUID=y
> # CONFIG_X86_5LEVEL is not set
> CONFIG_X86_DIRECT_GBPAGES=y
> # CONFIG_X86_CPA_STATISTICS is not set
> # CONFIG_AMD_MEM_ENCRYPT is not set
> # CONFIG_NUMA is not set
> CONFIG_ARCH_SPARSEMEM_ENABLE=y
> CONFIG_ARCH_SPARSEMEM_DEFAULT=y
> CONFIG_ARCH_SELECT_MEMORY_MODEL=y
> CONFIG_ARCH_PROC_KCORE_TEXT=y
> CONFIG_ILLEGAL_POINTER_VALUE=0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=y
> CONFIG_X86_PMEM_LEGACY=y
> # CONFIG_X86_CHECK_BIOS_CORRUPTION is not set
> CONFIG_X86_RESERVE_LOW=64
> CONFIG_MTRR=y
> CONFIG_MTRR_SANITIZER=y
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=0
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=1
> CONFIG_X86_PAT=y
> CONFIG_ARCH_USES_PG_UNCACHED=y
> CONFIG_ARCH_RANDOM=y
> CONFIG_X86_SMAP=y
> CONFIG_X86_UMIP=y
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=y
> CONFIG_X86_INTEL_TSX_MODE_OFF=y
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> CONFIG_EFI=y
> CONFIG_EFI_STUB=y
> CONFIG_EFI_MIXED=y
> CONFIG_SECCOMP=y
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> CONFIG_HZ_300=y
> # CONFIG_HZ_1000 is not set
> CONFIG_HZ=300
> CONFIG_SCHED_HRTICK=y
> CONFIG_KEXEC=y
> # CONFIG_KEXEC_FILE is not set
> CONFIG_CRASH_DUMP=y
> CONFIG_PHYSICAL_START=0x200000
> CONFIG_RELOCATABLE=y
> CONFIG_RANDOMIZE_BASE=y
> CONFIG_X86_NEED_RELOCS=y
> CONFIG_PHYSICAL_ALIGN=0x1000000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=y
> CONFIG_RANDOMIZE_MEMORY=y
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=0x0
> CONFIG_HOTPLUG_CPU=y
> # CONFIG_BOOTPARAM_HOTPLUG_CPU0 is not set
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> CONFIG_LEGACY_VSYSCALL_EMULATE=y
> # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> # CONFIG_MODIFY_LDT_SYSCALL is not set
> CONFIG_HAVE_LIVEPATCH=y
> # end of Processor type and features
> 
> CONFIG_ARCH_HAS_ADD_PAGES=y
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=y
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=y
> CONFIG_ARCH_ENABLE_THP_MIGRATION=y
> 
> #
> # Power management and ACPI options
> #
> # CONFIG_SUSPEND is not set
> CONFIG_HIBERNATE_CALLBACKS=y
> # CONFIG_HIBERNATION is not set
> CONFIG_PM_SLEEP=y
> CONFIG_PM_SLEEP_SMP=y
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=y
> # CONFIG_PM_DEBUG is not set
> CONFIG_PM_CLK=y
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=y
> CONFIG_ACPI=y
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=y
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=y
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=y
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=y
> CONFIG_ACPI_LPIT=y
> # CONFIG_ACPI_PROCFS_POWER is not set
> # CONFIG_ACPI_REV_OVERRIDE_POSSIBLE is not set
> # CONFIG_ACPI_EC_DEBUGFS is not set
> # CONFIG_ACPI_AC is not set
> # CONFIG_ACPI_BATTERY is not set
> CONFIG_ACPI_BUTTON=y
> CONFIG_ACPI_VIDEO=y
> CONFIG_ACPI_FAN=y
> # CONFIG_ACPI_TAD is not set
> # CONFIG_ACPI_DOCK is not set
> CONFIG_ACPI_CPU_FREQ_PSS=y
> CONFIG_ACPI_PROCESSOR_CSTATE=y
> CONFIG_ACPI_PROCESSOR_IDLE=y
> CONFIG_ACPI_CPPC_LIB=y
> CONFIG_ACPI_PROCESSOR=y
> CONFIG_ACPI_HOTPLUG_CPU=y
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=y
> CONFIG_ACPI_THERMAL=y
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=y
> CONFIG_ACPI_TABLE_UPGRADE=y
> # CONFIG_ACPI_DEBUG is not set
> # CONFIG_ACPI_PCI_SLOT is not set
> CONFIG_ACPI_CONTAINER=y
> CONFIG_ACPI_HOTPLUG_IOAPIC=y
> CONFIG_ACPI_SBS=y
> # CONFIG_ACPI_HED is not set
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> # CONFIG_ACPI_BGRT is not set
> # CONFIG_ACPI_REDUCED_HARDWARE_ONLY is not set
> # CONFIG_ACPI_NFIT is not set
> CONFIG_HAVE_ACPI_APEI=y
> CONFIG_HAVE_ACPI_APEI_NMI=y
> # CONFIG_ACPI_APEI is not set
> # CONFIG_DPTF_POWER is not set
> # CONFIG_PMIC_OPREGION is not set
> # CONFIG_ACPI_CONFIGFS is not set
> CONFIG_X86_PM_TIMER=y
> # CONFIG_SFI is not set
> 
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=y
> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
> CONFIG_CPU_FREQ_GOV_COMMON=y
> CONFIG_CPU_FREQ_STAT=y
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
> CONFIG_CPU_FREQ_GOV_POWERSAVE=m
> CONFIG_CPU_FREQ_GOV_USERSPACE=m
> CONFIG_CPU_FREQ_GOV_ONDEMAND=m
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=m
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
> 
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=y
> CONFIG_X86_PCC_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ=y
> CONFIG_X86_ACPI_CPUFREQ_CPB=y
> # CONFIG_X86_POWERNOW_K8 is not set
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
> 
> #
> # shared options
> #
> # end of CPU Frequency scaling
> 
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=y
> CONFIG_CPU_IDLE_GOV_LADDER=y
> CONFIG_CPU_IDLE_GOV_MENU=y
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=y
> # end of CPU Idle
> 
> CONFIG_INTEL_IDLE=y
> # end of Power management and ACPI options
> 
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=y
> CONFIG_PCI_MMCONFIG=y
> CONFIG_PCI_XEN=y
> CONFIG_MMCONF_FAM10H=y
> # CONFIG_PCI_CNB20LE_QUIRK is not set
> # CONFIG_ISA_BUS is not set
> CONFIG_ISA_DMA_API=y
> CONFIG_AMD_NB=y
> CONFIG_X86_SYSFB=y
> # end of Bus options (PCI etc.)
> 
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=y
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=y
> CONFIG_COMPAT=y
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=y
> CONFIG_SYSVIPC_COMPAT=y
> # end of Binary Emulations
> 
> #
> # Firmware Drivers
> #
> # CONFIG_EDD is not set
> CONFIG_FIRMWARE_MEMMAP=y
> CONFIG_DMIID=y
> # CONFIG_DMI_SYSFS is not set
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=y
> # CONFIG_ISCSI_IBFT is not set
> # CONFIG_FW_CFG_SYSFS is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
> 
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=y
> CONFIG_EFI_ESRT=y
> CONFIG_EFI_RUNTIME_MAP=y
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_WRAPPERS=y
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> # CONFIG_APPLE_PROPERTIES is not set
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
> 
> CONFIG_EFI_EARLYCON=y
> 
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
> 
> CONFIG_HAVE_KVM=y
> # CONFIG_VIRTUALIZATION is not set
> CONFIG_AS_AVX512=y
> CONFIG_AS_SHA1_NI=y
> CONFIG_AS_SHA256_NI=y
> 
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_HOTPLUG_SMT=y
> CONFIG_HAVE_OPROFILE=y
> CONFIG_OPROFILE_NMI_TIMER=y
> # CONFIG_KPROBES is not set
> # CONFIG_JUMP_LABEL is not set
> CONFIG_UPROBES=y
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
> CONFIG_ARCH_USE_BUILTIN_BSWAP=y
> CONFIG_HAVE_IOREMAP_PROT=y
> CONFIG_HAVE_KPROBES=y
> CONFIG_HAVE_KRETPROBES=y
> CONFIG_HAVE_OPTPROBES=y
> CONFIG_HAVE_KPROBES_ON_FTRACE=y
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=y
> CONFIG_HAVE_NMI=y
> CONFIG_HAVE_ARCH_TRACEHOOK=y
> CONFIG_HAVE_DMA_CONTIGUOUS=y
> CONFIG_GENERIC_SMP_IDLE_THREAD=y
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=y
> CONFIG_ARCH_HAS_SET_MEMORY=y
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=y
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=y
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=y
> CONFIG_HAVE_ASM_MODVERSIONS=y
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
> CONFIG_HAVE_RSEQ=y
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=y
> CONFIG_HAVE_CLK=y
> CONFIG_HAVE_HW_BREAKPOINT=y
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=y
> CONFIG_HAVE_USER_RETURN_NOTIFIER=y
> CONFIG_HAVE_PERF_EVENTS_NMI=y
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=y
> CONFIG_HAVE_PERF_REGS=y
> CONFIG_HAVE_PERF_USER_STACK_DUMP=y
> CONFIG_HAVE_ARCH_JUMP_LABEL=y
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=y
> CONFIG_MMU_GATHER_TABLE_FREE=y
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=y
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=y
> CONFIG_HAVE_CMPXCHG_LOCAL=y
> CONFIG_HAVE_CMPXCHG_DOUBLE=y
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=y
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=y
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
> CONFIG_SECCOMP_FILTER=y
> CONFIG_HAVE_ARCH_STACKLEAK=y
> CONFIG_HAVE_STACKPROTECTOR=y
> CONFIG_CC_HAS_STACKPROTECTOR_NONE=y
> CONFIG_STACKPROTECTOR=y
> CONFIG_STACKPROTECTOR_STRONG=y
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=y
> CONFIG_HAVE_CONTEXT_TRACKING=y
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
> CONFIG_HAVE_MOVE_PMD=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=y
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=y
> CONFIG_HAVE_ARCH_HUGE_VMAP=y
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=y
> CONFIG_HAVE_ARCH_SOFT_DIRTY=y
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
> CONFIG_MODULES_USE_ELF_RELA=y
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=y
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=y
> CONFIG_HAVE_EXIT_THREAD=y
> CONFIG_ARCH_MMAP_RND_BITS=28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=y
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=y
> CONFIG_HAVE_COPY_THREAD_TLS=y
> CONFIG_HAVE_STACK_VALIDATION=y
> CONFIG_HAVE_RELIABLE_STACKTRACE=y
> CONFIG_OLD_SIGSUSPEND3=y
> CONFIG_COMPAT_OLD_SIGACTION=y
> CONFIG_COMPAT_32BIT_TIME=y
> CONFIG_HAVE_ARCH_VMAP_STACK=y
> CONFIG_VMAP_STACK=y
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=y
> CONFIG_STRICT_KERNEL_RWX=y
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=y
> CONFIG_STRICT_MODULE_RWX=y
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=y
> CONFIG_ARCH_USE_MEMREMAP_PROT=y
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=y
> 
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
> # end of GCOV-based kernel profiling
> 
> CONFIG_HAVE_GCC_PLUGINS=y
> CONFIG_GCC_PLUGINS=y
> # CONFIG_GCC_PLUGIN_CYC_COMPLEXITY is not set
> # CONFIG_GCC_PLUGIN_LATENT_ENTROPY is not set
> # CONFIG_GCC_PLUGIN_RANDSTRUCT is not set
> # end of General architecture-dependent options
> 
> CONFIG_RT_MUTEXES=y
> CONFIG_BASE_SMALL=0
> CONFIG_MODULES=y
> # CONFIG_MODULE_FORCE_LOAD is not set
> CONFIG_MODULE_UNLOAD=y
> CONFIG_MODULE_FORCE_UNLOAD=y
> CONFIG_MODVERSIONS=y
> CONFIG_ASM_MODVERSIONS=y
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> # CONFIG_MODULE_SIG is not set
> # CONFIG_MODULE_COMPRESS is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_UNUSED_SYMBOLS=y
> CONFIG_MODULES_TREE_LOOKUP=y
> CONFIG_BLOCK=y
> CONFIG_BLK_SCSI_REQUEST=y
> CONFIG_BLK_DEV_BSG=y
> CONFIG_BLK_DEV_BSGLIB=y
> CONFIG_BLK_DEV_INTEGRITY=y
> CONFIG_BLK_DEV_INTEGRITY_T10=y
> # CONFIG_BLK_DEV_ZONED is not set
> # CONFIG_BLK_CMDLINE_PARSER is not set
> # CONFIG_BLK_WBT is not set
> CONFIG_BLK_DEBUG_FS=y
> # CONFIG_BLK_SED_OPAL is not set
> 
> #
> # Partition Types
> #
> CONFIG_PARTITION_ADVANCED=y
> # CONFIG_ACORN_PARTITION is not set
> # CONFIG_AIX_PARTITION is not set
> # CONFIG_OSF_PARTITION is not set
> # CONFIG_AMIGA_PARTITION is not set
> # CONFIG_ATARI_PARTITION is not set
> # CONFIG_MAC_PARTITION is not set
> CONFIG_MSDOS_PARTITION=y
> CONFIG_BSD_DISKLABEL=y
> CONFIG_MINIX_SUBPARTITION=y
> CONFIG_SOLARIS_X86_PARTITION=y
> CONFIG_UNIXWARE_DISKLABEL=y
> CONFIG_LDM_PARTITION=y
> # CONFIG_LDM_DEBUG is not set
> # CONFIG_SGI_PARTITION is not set
> # CONFIG_ULTRIX_PARTITION is not set
> # CONFIG_SUN_PARTITION is not set
> # CONFIG_KARMA_PARTITION is not set
> CONFIG_EFI_PARTITION=y
> # CONFIG_SYSV68_PARTITION is not set
> # CONFIG_CMDLINE_PARTITION is not set
> # end of Partition Types
> 
> CONFIG_BLOCK_COMPAT=y
> CONFIG_BLK_MQ_PCI=y
> CONFIG_BLK_MQ_VIRTIO=y
> CONFIG_BLK_PM=y
> 
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=y
> CONFIG_MQ_IOSCHED_KYBER=y
> # CONFIG_IOSCHED_BFQ is not set
> # end of IO Schedulers
> 
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
> CONFIG_INLINE_READ_UNLOCK=y
> CONFIG_INLINE_READ_UNLOCK_IRQ=y
> CONFIG_INLINE_WRITE_UNLOCK=y
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
> CONFIG_MUTEX_SPIN_ON_OWNER=y
> CONFIG_RWSEM_SPIN_ON_OWNER=y
> CONFIG_LOCK_SPIN_ON_OWNER=y
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=y
> CONFIG_QUEUED_SPINLOCKS=y
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=y
> CONFIG_QUEUED_RWLOCKS=y
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=y
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=y
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=y
> CONFIG_FREEZER=y
> 
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=y
> CONFIG_COMPAT_BINFMT_ELF=y
> CONFIG_ELFCORE=y
> # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> CONFIG_BINFMT_SCRIPT=y
> CONFIG_BINFMT_MISC=m
> CONFIG_COREDUMP=y
> # end of Executable file formats
> 
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=y
> CONFIG_SPARSEMEM_MANUAL=y
> CONFIG_SPARSEMEM=y
> CONFIG_HAVE_MEMORY_PRESENT=y
> CONFIG_SPARSEMEM_EXTREME=y
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=y
> CONFIG_SPARSEMEM_VMEMMAP=y
> CONFIG_HAVE_MEMBLOCK_NODE_MAP=y
> CONFIG_HAVE_FAST_GUP=y
> CONFIG_MEMORY_ISOLATION=y
> # CONFIG_MEMORY_HOTPLUG is not set
> CONFIG_SPLIT_PTLOCK_CPUS=4
> CONFIG_MEMORY_BALLOON=y
> CONFIG_BALLOON_COMPACTION=y
> CONFIG_COMPACTION=y
> CONFIG_PAGE_REPORTING=y
> CONFIG_MIGRATION=y
> CONFIG_CONTIG_ALLOC=y
> CONFIG_PHYS_ADDR_T_64BIT=y
> CONFIG_BOUNCE=y
> CONFIG_VIRT_TO_BUS=y
> CONFIG_MMU_NOTIFIER=y
> # CONFIG_KSM is not set
> CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=y
> # CONFIG_MEMORY_FAILURE is not set
> CONFIG_TRANSPARENT_HUGEPAGE=y
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=y
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_ARCH_WANTS_THP_SWAP=y
> CONFIG_THP_SWAP=y
> # CONFIG_CLEANCACHE is not set
> # CONFIG_FRONTSWAP is not set
> CONFIG_CMA=y
> # CONFIG_CMA_DEBUG is not set
> # CONFIG_CMA_DEBUGFS is not set
> CONFIG_CMA_AREAS=7
> # CONFIG_MEM_SOFT_DIRTY is not set
> # CONFIG_ZPOOL is not set
> # CONFIG_ZBUD is not set
> CONFIG_ZSMALLOC=m
> # CONFIG_PGTABLE_MAPPING is not set
> # CONFIG_ZSMALLOC_STAT is not set
> CONFIG_GENERIC_EARLY_IOREMAP=y
> # CONFIG_DEFERRED_STRUCT_PAGE_INIT is not set
> # CONFIG_IDLE_PAGE_TRACKING is not set
> CONFIG_ARCH_HAS_PTE_DEVMAP=y
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=y
> CONFIG_ARCH_HAS_PKEYS=y
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_BENCHMARK is not set
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=y
> CONFIG_MAPPING_DIRTY_HELPERS=y
> # end of Memory Management options
> 
> CONFIG_NET=y
> CONFIG_NET_INGRESS=y
> CONFIG_NET_EGRESS=y
> CONFIG_SKB_EXTENSIONS=y
> 
> #
> # Networking options
> #
> CONFIG_PACKET=y
> # CONFIG_PACKET_DIAG is not set
> CONFIG_UNIX=y
> CONFIG_UNIX_SCM=y
> # CONFIG_UNIX_DIAG is not set
> # CONFIG_TLS is not set
> CONFIG_XFRM=y
> CONFIG_XFRM_ALGO=y
> CONFIG_XFRM_USER=m
> # CONFIG_XFRM_INTERFACE is not set
> # CONFIG_XFRM_SUB_POLICY is not set
> # CONFIG_XFRM_MIGRATE is not set
> # CONFIG_XFRM_STATISTICS is not set
> CONFIG_XFRM_IPCOMP=m
> CONFIG_NET_KEY=y
> # CONFIG_NET_KEY_MIGRATE is not set
> # CONFIG_XDP_SOCKETS is not set
> CONFIG_INET=y
> CONFIG_IP_MULTICAST=y
> CONFIG_IP_ADVANCED_ROUTER=y
> # CONFIG_IP_FIB_TRIE_STATS is not set
> CONFIG_IP_MULTIPLE_TABLES=y
> CONFIG_IP_ROUTE_MULTIPATH=y
> # CONFIG_IP_ROUTE_VERBOSE is not set
> CONFIG_IP_ROUTE_CLASSID=y
> CONFIG_IP_PNP=y
> CONFIG_IP_PNP_DHCP=y
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=m
> # CONFIG_NET_IPGRE_DEMUX is not set
> CONFIG_NET_IP_TUNNEL=y
> CONFIG_IP_MROUTE_COMMON=y
> CONFIG_IP_MROUTE=y
> # CONFIG_IP_MROUTE_MULTIPLE_TABLES is not set
> CONFIG_IP_PIMSM_V1=y
> CONFIG_IP_PIMSM_V2=y
> CONFIG_SYN_COOKIES=y
> # CONFIG_NET_IPVTI is not set
> CONFIG_NET_UDP_TUNNEL=y
> CONFIG_NET_FOU=y
> CONFIG_NET_FOU_IP_TUNNELS=y
> CONFIG_INET_AH=m
> CONFIG_INET_ESP=m
> # CONFIG_INET_ESP_OFFLOAD is not set
> # CONFIG_INET_ESPINTCP is not set
> CONFIG_INET_IPCOMP=m
> CONFIG_INET_XFRM_TUNNEL=m
> CONFIG_INET_TUNNEL=m
> CONFIG_INET_DIAG=y
> CONFIG_INET_TCP_DIAG=y
> # CONFIG_INET_UDP_DIAG is not set
> # CONFIG_INET_RAW_DIAG is not set
> # CONFIG_INET_DIAG_DESTROY is not set
> # CONFIG_TCP_CONG_ADVANCED is not set
> CONFIG_TCP_CONG_CUBIC=y
> CONFIG_DEFAULT_TCP_CONG="cubic"
> # CONFIG_TCP_MD5SIG is not set
> CONFIG_IPV6=y
> CONFIG_IPV6_ROUTER_PREF=y
> # CONFIG_IPV6_ROUTE_INFO is not set
> # CONFIG_IPV6_OPTIMISTIC_DAD is not set
> CONFIG_INET6_AH=m
> CONFIG_INET6_ESP=m
> # CONFIG_INET6_ESP_OFFLOAD is not set
> CONFIG_INET6_IPCOMP=m
> # CONFIG_IPV6_MIP6 is not set
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=m
> CONFIG_INET6_TUNNEL=y
> # CONFIG_IPV6_VTI is not set
> CONFIG_IPV6_SIT=m
> # CONFIG_IPV6_SIT_6RD is not set
> CONFIG_IPV6_NDISC_NODETYPE=y
> CONFIG_IPV6_TUNNEL=y
> CONFIG_IPV6_FOU=y
> CONFIG_IPV6_FOU_TUNNEL=y
> # CONFIG_IPV6_MULTIPLE_TABLES is not set
> # CONFIG_IPV6_MROUTE is not set
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_MPTCP is not set
> CONFIG_NETWORK_SECMARK=y
> CONFIG_NET_PTP_CLASSIFY=y
> # CONFIG_NETWORK_PHY_TIMESTAMPING is not set
> CONFIG_NETFILTER=y
> CONFIG_NETFILTER_ADVANCED=y
> 
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=y
> CONFIG_NETFILTER_NETLINK=y
> CONFIG_NETFILTER_FAMILY_ARP=y
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=m
> CONFIG_NETFILTER_NETLINK_LOG=m
> # CONFIG_NETFILTER_NETLINK_OSF is not set
> CONFIG_NF_CONNTRACK=y
> # CONFIG_NF_LOG_NETDEV is not set
> CONFIG_NETFILTER_CONNCOUNT=m
> CONFIG_NF_CONNTRACK_MARK=y
> CONFIG_NF_CONNTRACK_SECMARK=y
> # CONFIG_NF_CONNTRACK_ZONES is not set
> CONFIG_NF_CONNTRACK_PROCFS=y
> CONFIG_NF_CONNTRACK_EVENTS=y
> # CONFIG_NF_CONNTRACK_TIMEOUT is not set
> # CONFIG_NF_CONNTRACK_TIMESTAMP is not set
> # CONFIG_NF_CONNTRACK_LABELS is not set
> # CONFIG_NF_CT_PROTO_DCCP is not set
> CONFIG_NF_CT_PROTO_GRE=y
> CONFIG_NF_CT_PROTO_SCTP=y
> CONFIG_NF_CT_PROTO_UDPLITE=y
> CONFIG_NF_CONNTRACK_AMANDA=m
> CONFIG_NF_CONNTRACK_FTP=m
> CONFIG_NF_CONNTRACK_H323=m
> CONFIG_NF_CONNTRACK_IRC=m
> CONFIG_NF_CONNTRACK_BROADCAST=m
> CONFIG_NF_CONNTRACK_NETBIOS_NS=m
> # CONFIG_NF_CONNTRACK_SNMP is not set
> CONFIG_NF_CONNTRACK_PPTP=m
> CONFIG_NF_CONNTRACK_SANE=m
> CONFIG_NF_CONNTRACK_SIP=m
> CONFIG_NF_CONNTRACK_TFTP=m
> CONFIG_NF_CT_NETLINK=m
> # CONFIG_NETFILTER_NETLINK_GLUE_CT is not set
> CONFIG_NF_NAT=y
> CONFIG_NF_NAT_AMANDA=m
> CONFIG_NF_NAT_FTP=m
> CONFIG_NF_NAT_IRC=m
> CONFIG_NF_NAT_SIP=m
> CONFIG_NF_NAT_TFTP=m
> CONFIG_NF_NAT_REDIRECT=y
> CONFIG_NF_NAT_MASQUERADE=y
> # CONFIG_NF_TABLES is not set
> CONFIG_NETFILTER_XTABLES=y
> 
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=m
> CONFIG_NETFILTER_XT_CONNMARK=m
> # CONFIG_NETFILTER_XT_SET is not set
> 
> #
> # Xtables targets
> #
> # CONFIG_NETFILTER_XT_TARGET_AUDIT is not set
> # CONFIG_NETFILTER_XT_TARGET_CHECKSUM is not set
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=m
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
> CONFIG_NETFILTER_XT_TARGET_CT=m
> CONFIG_NETFILTER_XT_TARGET_DSCP=m
> CONFIG_NETFILTER_XT_TARGET_HL=m
> # CONFIG_NETFILTER_XT_TARGET_HMARK is not set
> # CONFIG_NETFILTER_XT_TARGET_IDLETIMER is not set
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> # CONFIG_NETFILTER_XT_TARGET_LOG is not set
> CONFIG_NETFILTER_XT_TARGET_MARK=m
> CONFIG_NETFILTER_XT_NAT=y
> CONFIG_NETFILTER_XT_TARGET_NETMAP=y
> CONFIG_NETFILTER_XT_TARGET_NFLOG=m
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=m
> # CONFIG_NETFILTER_XT_TARGET_RATEEST is not set
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=y
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=y
> # CONFIG_NETFILTER_XT_TARGET_TEE is not set
> # CONFIG_NETFILTER_XT_TARGET_TPROXY is not set
> CONFIG_NETFILTER_XT_TARGET_TRACE=m
> CONFIG_NETFILTER_XT_TARGET_SECMARK=m
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
> # CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP is not set
> 
> #
> # Xtables matches
> #
> # CONFIG_NETFILTER_XT_MATCH_ADDRTYPE is not set
> # CONFIG_NETFILTER_XT_MATCH_BPF is not set
> # CONFIG_NETFILTER_XT_MATCH_CGROUP is not set
> # CONFIG_NETFILTER_XT_MATCH_CLUSTER is not set
> CONFIG_NETFILTER_XT_MATCH_COMMENT=m
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
> # CONFIG_NETFILTER_XT_MATCH_CONNLABEL is not set
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
> # CONFIG_NETFILTER_XT_MATCH_CPU is not set
> CONFIG_NETFILTER_XT_MATCH_DCCP=m
> # CONFIG_NETFILTER_XT_MATCH_DEVGROUP is not set
> CONFIG_NETFILTER_XT_MATCH_DSCP=m
> CONFIG_NETFILTER_XT_MATCH_ECN=y
> CONFIG_NETFILTER_XT_MATCH_ESP=m
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
> CONFIG_NETFILTER_XT_MATCH_HELPER=m
> CONFIG_NETFILTER_XT_MATCH_HL=y
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> # CONFIG_NETFILTER_XT_MATCH_IPRANGE is not set
> # CONFIG_NETFILTER_XT_MATCH_IPVS is not set
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> CONFIG_NETFILTER_XT_MATCH_LENGTH=m
> CONFIG_NETFILTER_XT_MATCH_LIMIT=m
> CONFIG_NETFILTER_XT_MATCH_MAC=m
> CONFIG_NETFILTER_XT_MATCH_MARK=m
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> # CONFIG_NETFILTER_XT_MATCH_OSF is not set
> # CONFIG_NETFILTER_XT_MATCH_OWNER is not set
> CONFIG_NETFILTER_XT_MATCH_POLICY=m
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
> CONFIG_NETFILTER_XT_MATCH_QUOTA=m
> # CONFIG_NETFILTER_XT_MATCH_RATEEST is not set
> CONFIG_NETFILTER_XT_MATCH_REALM=m
> # CONFIG_NETFILTER_XT_MATCH_RECENT is not set
> CONFIG_NETFILTER_XT_MATCH_SCTP=m
> # CONFIG_NETFILTER_XT_MATCH_SOCKET is not set
> CONFIG_NETFILTER_XT_MATCH_STATE=m
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
> CONFIG_NETFILTER_XT_MATCH_STRING=m
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
> CONFIG_NETFILTER_XT_MATCH_TIME=m
> CONFIG_NETFILTER_XT_MATCH_U32=m
> # end of Core Netfilter Configuration
> 
> CONFIG_IP_SET=y
> CONFIG_IP_SET_MAX=256
> # CONFIG_IP_SET_BITMAP_IP is not set
> # CONFIG_IP_SET_BITMAP_IPMAC is not set
> # CONFIG_IP_SET_BITMAP_PORT is not set
> # CONFIG_IP_SET_HASH_IP is not set
> # CONFIG_IP_SET_HASH_IPMARK is not set
> # CONFIG_IP_SET_HASH_IPPORT is not set
> # CONFIG_IP_SET_HASH_IPPORTIP is not set
> # CONFIG_IP_SET_HASH_IPPORTNET is not set
> # CONFIG_IP_SET_HASH_IPMAC is not set
> # CONFIG_IP_SET_HASH_MAC is not set
> # CONFIG_IP_SET_HASH_NETPORTNET is not set
> # CONFIG_IP_SET_HASH_NET is not set
> # CONFIG_IP_SET_HASH_NETNET is not set
> # CONFIG_IP_SET_HASH_NETPORT is not set
> # CONFIG_IP_SET_HASH_NETIFACE is not set
> # CONFIG_IP_SET_LIST_SET is not set
> CONFIG_IP_VS=y
> # CONFIG_IP_VS_IPV6 is not set
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=12
> 
> #
> # IPVS transport protocol load balancing support
> #
> # CONFIG_IP_VS_PROTO_TCP is not set
> # CONFIG_IP_VS_PROTO_UDP is not set
> # CONFIG_IP_VS_PROTO_ESP is not set
> # CONFIG_IP_VS_PROTO_AH is not set
> # CONFIG_IP_VS_PROTO_SCTP is not set
> 
> #
> # IPVS scheduler
> #
> # CONFIG_IP_VS_RR is not set
> # CONFIG_IP_VS_WRR is not set
> # CONFIG_IP_VS_LC is not set
> # CONFIG_IP_VS_WLC is not set
> # CONFIG_IP_VS_FO is not set
> # CONFIG_IP_VS_OVF is not set
> # CONFIG_IP_VS_LBLC is not set
> # CONFIG_IP_VS_LBLCR is not set
> # CONFIG_IP_VS_DH is not set
> # CONFIG_IP_VS_SH is not set
> # CONFIG_IP_VS_MH is not set
> # CONFIG_IP_VS_SED is not set
> # CONFIG_IP_VS_NQ is not set
> 
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=8
> 
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=12
> 
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_NFCT=y
> 
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=y
> # CONFIG_NF_SOCKET_IPV4 is not set
> # CONFIG_NF_TPROXY_IPV4 is not set
> # CONFIG_NF_DUP_IPV4 is not set
> # CONFIG_NF_LOG_ARP is not set
> # CONFIG_NF_LOG_IPV4 is not set
> CONFIG_NF_REJECT_IPV4=m
> CONFIG_NF_NAT_PPTP=m
> CONFIG_NF_NAT_H323=m
> CONFIG_IP_NF_IPTABLES=y
> CONFIG_IP_NF_MATCH_AH=y
> CONFIG_IP_NF_MATCH_ECN=y
> # CONFIG_IP_NF_MATCH_RPFILTER is not set
> CONFIG_IP_NF_MATCH_TTL=y
> CONFIG_IP_NF_FILTER=y
> CONFIG_IP_NF_TARGET_REJECT=m
> # CONFIG_IP_NF_TARGET_SYNPROXY is not set
> CONFIG_IP_NF_NAT=y
> CONFIG_IP_NF_TARGET_MASQUERADE=y
> CONFIG_IP_NF_TARGET_NETMAP=y
> CONFIG_IP_NF_TARGET_REDIRECT=y
> CONFIG_IP_NF_MANGLE=m
> CONFIG_IP_NF_TARGET_CLUSTERIP=m
> CONFIG_IP_NF_TARGET_ECN=m
> CONFIG_IP_NF_TARGET_TTL=m
> CONFIG_IP_NF_RAW=m
> CONFIG_IP_NF_ARPTABLES=y
> CONFIG_IP_NF_ARPFILTER=m
> CONFIG_IP_NF_ARP_MANGLE=m
> # end of IP: Netfilter Configuration
> 
> #
> # IPv6: Netfilter Configuration
> #
> # CONFIG_NF_SOCKET_IPV6 is not set
> # CONFIG_NF_TPROXY_IPV6 is not set
> # CONFIG_NF_DUP_IPV6 is not set
> CONFIG_NF_REJECT_IPV6=m
> # CONFIG_NF_LOG_IPV6 is not set
> CONFIG_IP6_NF_IPTABLES=y
> CONFIG_IP6_NF_MATCH_AH=m
> CONFIG_IP6_NF_MATCH_EUI64=m
> CONFIG_IP6_NF_MATCH_FRAG=m
> CONFIG_IP6_NF_MATCH_OPTS=m
> CONFIG_IP6_NF_MATCH_HL=m
> CONFIG_IP6_NF_MATCH_IPV6HEADER=m
> CONFIG_IP6_NF_MATCH_MH=m
> # CONFIG_IP6_NF_MATCH_RPFILTER is not set
> CONFIG_IP6_NF_MATCH_RT=m
> # CONFIG_IP6_NF_MATCH_SRH is not set
> CONFIG_IP6_NF_TARGET_HL=m
> CONFIG_IP6_NF_FILTER=m
> CONFIG_IP6_NF_TARGET_REJECT=m
> # CONFIG_IP6_NF_TARGET_SYNPROXY is not set
> CONFIG_IP6_NF_MANGLE=m
> CONFIG_IP6_NF_RAW=m
> # CONFIG_IP6_NF_NAT is not set
> # end of IPv6: Netfilter Configuration
> 
> CONFIG_NF_DEFRAG_IPV6=y
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> CONFIG_IP_SCTP=y
> # CONFIG_SCTP_DBG_OBJCNT is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5=y
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1 is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=y
> # CONFIG_SCTP_COOKIE_HMAC_SHA1 is not set
> CONFIG_INET_SCTP_DIAG=y
> # CONFIG_RDS is not set
> # CONFIG_TIPC is not set
> # CONFIG_ATM is not set
> # CONFIG_L2TP is not set
> # CONFIG_BRIDGE is not set
> CONFIG_HAVE_NET_DSA=y
> # CONFIG_NET_DSA is not set
> # CONFIG_VLAN_8021Q is not set
> # CONFIG_DECNET is not set
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> # CONFIG_6LOWPAN is not set
> # CONFIG_IEEE802154 is not set
> CONFIG_NET_SCHED=y
> 
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=m
> CONFIG_NET_SCH_HTB=m
> CONFIG_NET_SCH_HFSC=m
> CONFIG_NET_SCH_PRIO=m
> # CONFIG_NET_SCH_MULTIQ is not set
> CONFIG_NET_SCH_RED=m
> # CONFIG_NET_SCH_SFB is not set
> CONFIG_NET_SCH_SFQ=m
> CONFIG_NET_SCH_TEQL=m
> CONFIG_NET_SCH_TBF=m
> CONFIG_NET_SCH_CBS=m
> CONFIG_NET_SCH_ETF=m
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=m
> CONFIG_NET_SCH_DSMARK=m
> # CONFIG_NET_SCH_NETEM is not set
> # CONFIG_NET_SCH_DRR is not set
> # CONFIG_NET_SCH_MQPRIO is not set
> # CONFIG_NET_SCH_SKBPRIO is not set
> # CONFIG_NET_SCH_CHOKE is not set
> # CONFIG_NET_SCH_QFQ is not set
> # CONFIG_NET_SCH_CODEL is not set
> # CONFIG_NET_SCH_FQ_CODEL is not set
> CONFIG_NET_SCH_CAKE=m
> # CONFIG_NET_SCH_FQ is not set
> # CONFIG_NET_SCH_HHF is not set
> # CONFIG_NET_SCH_PIE is not set
> CONFIG_NET_SCH_INGRESS=m
> # CONFIG_NET_SCH_PLUG is not set
> # CONFIG_NET_SCH_ETS is not set
> # CONFIG_NET_SCH_DEFAULT is not set
> 
> #
> # Classification
> #
> CONFIG_NET_CLS=y
> CONFIG_NET_CLS_BASIC=m
> CONFIG_NET_CLS_TCINDEX=m
> CONFIG_NET_CLS_ROUTE4=m
> CONFIG_NET_CLS_FW=m
> CONFIG_NET_CLS_U32=m
> CONFIG_CLS_U32_PERF=y
> CONFIG_CLS_U32_MARK=y
> CONFIG_NET_CLS_RSVP=m
> CONFIG_NET_CLS_RSVP6=m
> # CONFIG_NET_CLS_FLOW is not set
> # CONFIG_NET_CLS_CGROUP is not set
> # CONFIG_NET_CLS_BPF is not set
> # CONFIG_NET_CLS_FLOWER is not set
> # CONFIG_NET_CLS_MATCHALL is not set
> CONFIG_NET_EMATCH=y
> CONFIG_NET_EMATCH_STACK=32
> CONFIG_NET_EMATCH_CMP=m
> CONFIG_NET_EMATCH_NBYTE=m
> CONFIG_NET_EMATCH_U32=m
> CONFIG_NET_EMATCH_META=m
> CONFIG_NET_EMATCH_TEXT=m
> # CONFIG_NET_EMATCH_IPSET is not set
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=y
> CONFIG_NET_ACT_POLICE=m
> CONFIG_NET_ACT_GACT=m
> CONFIG_GACT_PROB=y
> CONFIG_NET_ACT_MIRRED=m
> # CONFIG_NET_ACT_SAMPLE is not set
> CONFIG_NET_ACT_IPT=m
> CONFIG_NET_ACT_NAT=m
> CONFIG_NET_ACT_PEDIT=m
> # CONFIG_NET_ACT_SIMP is not set
> # CONFIG_NET_ACT_SKBEDIT is not set
> # CONFIG_NET_ACT_CSUM is not set
> # CONFIG_NET_ACT_MPLS is not set
> # CONFIG_NET_ACT_VLAN is not set
> # CONFIG_NET_ACT_BPF is not set
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_CTINFO is not set
> # CONFIG_NET_ACT_SKBMOD is not set
> # CONFIG_NET_ACT_IFE is not set
> # CONFIG_NET_ACT_TUNNEL_KEY is not set
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=y
> # CONFIG_DCB is not set
> CONFIG_DNS_RESOLVER=y
> # CONFIG_BATMAN_ADV is not set
> # CONFIG_OPENVSWITCH is not set
> # CONFIG_VSOCKETS is not set
> # CONFIG_NETLINK_DIAG is not set
> # CONFIG_MPLS is not set
> # CONFIG_NET_NSH is not set
> # CONFIG_HSR is not set
> # CONFIG_NET_SWITCHDEV is not set
> CONFIG_NET_L3_MASTER_DEV=y
> # CONFIG_NET_NCSI is not set
> CONFIG_RPS=y
> CONFIG_RFS_ACCEL=y
> CONFIG_XPS=y
> # CONFIG_CGROUP_NET_PRIO is not set
> # CONFIG_CGROUP_NET_CLASSID is not set
> CONFIG_NET_RX_BUSY_POLL=y
> CONFIG_BQL=y
> # CONFIG_BPF_JIT is not set
> # CONFIG_BPF_STREAM_PARSER is not set
> CONFIG_NET_FLOW_LIMIT=y
> 
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=m
> # CONFIG_NET_DROP_MONITOR is not set
> # end of Network testing
> # end of Networking options
> 
> # CONFIG_HAMRADIO is not set
> # CONFIG_CAN is not set
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_FIB_RULES=y
> # CONFIG_WIRELESS is not set
> # CONFIG_WIMAX is not set
> # CONFIG_RFKILL is not set
> # CONFIG_NET_9P is not set
> # CONFIG_CAIF is not set
> # CONFIG_CEPH_LIB is not set
> # CONFIG_NFC is not set
> # CONFIG_PSAMPLE is not set
> # CONFIG_NET_IFE is not set
> # CONFIG_LWTUNNEL is not set
> CONFIG_DST_CACHE=y
> CONFIG_GRO_CELLS=y
> CONFIG_NET_DEVLINK=y
> CONFIG_FAILOVER=y
> CONFIG_ETHTOOL_NETLINK=y
> CONFIG_HAVE_EBPF_JIT=y
> 
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=y
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=y
> CONFIG_PCI=y
> CONFIG_PCI_DOMAINS=y
> CONFIG_PCIEPORTBUS=y
> CONFIG_PCIEAER=y
> # CONFIG_PCIEAER_INJECT is not set
> # CONFIG_PCIE_ECRC is not set
> CONFIG_PCIEASPM=y
> CONFIG_PCIEASPM_DEFAULT=y
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=y
> # CONFIG_PCIE_DPC is not set
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCIE_BW is not set
> CONFIG_PCI_MSI=y
> CONFIG_PCI_MSI_IRQ_DOMAIN=y
> CONFIG_PCI_QUIRKS=y
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_STUB is not set
> # CONFIG_XEN_PCIDEV_FRONTEND is not set
> CONFIG_PCI_LOCKLESS_CONFIG=y
> # CONFIG_PCI_IOV is not set
> # CONFIG_PCI_PRI is not set
> # CONFIG_PCI_PASID is not set
> CONFIG_PCI_LABEL=y
> # CONFIG_PCI_HYPERV is not set
> # CONFIG_HOTPLUG_PCI is not set
> 
> #
> # PCI controller drivers
> #
> # CONFIG_VMD is not set
> # CONFIG_PCI_HYPERV_INTERFACE is not set
> 
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
> 
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
> 
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
> 
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
> 
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
> 
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
> 
> #
> # Generic Driver Options
> #
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=y
> # CONFIG_DEVTMPFS_MOUNT is not set
> CONFIG_STANDALONE=y
> CONFIG_PREVENT_FIRMWARE_BUILD=y
> 
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=y
> CONFIG_EXTRA_FIRMWARE=""
> # CONFIG_FW_LOADER_USER_HELPER is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=y
> # end of Firmware loader
> 
> CONFIG_ALLOW_DEV_COREDUMP=y
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_SYS_HYPERVISOR=y
> CONFIG_GENERIC_CPU_AUTOPROBE=y
> CONFIG_GENERIC_CPU_VULNERABILITIES=y
> CONFIG_REGMAP=y
> CONFIG_REGMAP_I2C=y
> CONFIG_REGMAP_IRQ=y
> CONFIG_DMA_SHARED_BUFFER=y
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
> 
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
> 
> CONFIG_CONNECTOR=y
> CONFIG_PROC_EVENTS=y
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
> # CONFIG_PARPORT is not set
> CONFIG_PNP=y
> CONFIG_PNP_DEBUG_MESSAGES=y
> 
> #
> # Protocols
> #
> CONFIG_PNPACPI=y
> CONFIG_BLK_DEV=y
> # CONFIG_BLK_DEV_NULL_BLK is not set
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=y
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> CONFIG_ZRAM=m
> CONFIG_ZRAM_WRITEBACK=y
> CONFIG_ZRAM_MEMORY_TRACKING=y
> # CONFIG_BLK_DEV_UMEM is not set
> CONFIG_BLK_DEV_LOOP=y
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
> # CONFIG_BLK_DEV_CRYPTOLOOP is not set
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=y
> # CONFIG_BLK_DEV_SKD is not set
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=y
> CONFIG_BLK_DEV_RAM_COUNT=16
> CONFIG_BLK_DEV_RAM_SIZE=8192
> # CONFIG_CDROM_PKTCDVD is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_XEN_BLKDEV_FRONTEND=y
> # CONFIG_XEN_BLKDEV_BACKEND is not set
> CONFIG_VIRTIO_BLK=y
> # CONFIG_BLK_DEV_RBD is not set
> # CONFIG_BLK_DEV_RSXX is not set
> 
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=m
> CONFIG_BLK_DEV_NVME=m
> CONFIG_NVME_MULTIPATH=y
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=m
> CONFIG_NVME_FC=m
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_TARGET=m
> CONFIG_NVME_TARGET_LOOP=m
> CONFIG_NVME_TARGET_FC=m
> CONFIG_NVME_TARGET_FCLOOP=m
> # CONFIG_NVME_TARGET_TCP is not set
> # end of NVME Support
> 
> #
> # Misc devices
> #
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> CONFIG_TIFM_CORE=m
> CONFIG_TIFM_7XX1=m
> # CONFIG_ICS932S401 is not set
> # CONFIG_ENCLOSURE_SERVICES is not set
> # CONFIG_HP_ILO is not set
> # CONFIG_APDS9802ALS is not set
> # CONFIG_ISL29003 is not set
> # CONFIG_ISL29020 is not set
> # CONFIG_SENSORS_TSL2550 is not set
> # CONFIG_SENSORS_BH1770 is not set
> # CONFIG_SENSORS_APDS990X is not set
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> CONFIG_VMWARE_BALLOON=y
> # CONFIG_SRAM is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> # CONFIG_PVPANIC is not set
> # CONFIG_C2PORT is not set
> 
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_LEGACY is not set
> # CONFIG_EEPROM_MAX6875 is not set
> CONFIG_EEPROM_93CX6=m
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
> 
> CONFIG_CB710_CORE=m
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=y
> 
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
> 
> # CONFIG_SENSORS_LIS3_I2C is not set
> # CONFIG_ALTERA_STAPL is not set
> # CONFIG_INTEL_MEI is not set
> # CONFIG_INTEL_MEI_ME is not set
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_INTEL_MEI_HDCP is not set
> CONFIG_VMWARE_VMCI=y
> 
> #
> # Intel MIC & related support
> #
> # CONFIG_INTEL_MIC_BUS is not set
> CONFIG_SCIF_BUS=m
> # CONFIG_VOP_BUS is not set
> CONFIG_SCIF=m
> CONFIG_MIC_COSM=m
> # end of Intel MIC & related support
> 
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> # CONFIG_MISC_RTSX_PCI is not set
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_UACCE is not set
> # end of Misc devices
> 
> CONFIG_HAVE_IDE=y
> # CONFIG_IDE is not set
> 
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=y
> CONFIG_RAID_ATTRS=m
> CONFIG_SCSI=y
> CONFIG_SCSI_DMA=y
> CONFIG_SCSI_NETLINK=y
> CONFIG_SCSI_PROC_FS=y
> 
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=y
> CONFIG_CHR_DEV_ST=m
> CONFIG_BLK_DEV_SR=y
> CONFIG_CHR_DEV_SG=m
> CONFIG_CHR_DEV_SCH=m
> # CONFIG_SCSI_CONSTANTS is not set
> # CONFIG_SCSI_LOGGING is not set
> CONFIG_SCSI_SCAN_ASYNC=y
> 
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=m
> CONFIG_SCSI_FC_ATTRS=m
> CONFIG_SCSI_ISCSI_ATTRS=y
> CONFIG_SCSI_SAS_ATTRS=m
> CONFIG_SCSI_SAS_LIBSAS=m
> CONFIG_SCSI_SAS_ATA=y
> CONFIG_SCSI_SAS_HOST_SMP=y
> CONFIG_SCSI_SRP_ATTRS=m
> # end of SCSI Transports
> 
> CONFIG_SCSI_LOWLEVEL=y
> CONFIG_ISCSI_TCP=y
> CONFIG_ISCSI_BOOT_SYSFS=m
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> CONFIG_BLK_DEV_3W_XXXX_RAID=m
> # CONFIG_SCSI_HPSA is not set
> CONFIG_SCSI_3W_9XXX=m
> # CONFIG_SCSI_3W_SAS is not set
> CONFIG_SCSI_ACARD=m
> CONFIG_SCSI_AACRAID=m
> CONFIG_SCSI_AIC7XXX=m
> CONFIG_AIC7XXX_CMDS_PER_DEVICE=32
> CONFIG_AIC7XXX_RESET_DELAY_MS=5000
> # CONFIG_AIC7XXX_DEBUG_ENABLE is not set
> CONFIG_AIC7XXX_DEBUG_MASK=0
> CONFIG_AIC7XXX_REG_PRETTY_PRINT=y
> CONFIG_SCSI_AIC79XX=m
> CONFIG_AIC79XX_CMDS_PER_DEVICE=32
> CONFIG_AIC79XX_RESET_DELAY_MS=5000
> # CONFIG_AIC79XX_DEBUG_ENABLE is not set
> CONFIG_AIC79XX_DEBUG_MASK=0
> # CONFIG_AIC79XX_REG_PRETTY_PRINT is not set
> CONFIG_SCSI_AIC94XX=m
> # CONFIG_AIC94XX_DEBUG is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_DPT_I2O is not set
> CONFIG_SCSI_ADVANSYS=m
> CONFIG_SCSI_ARCMSR=m
> # CONFIG_SCSI_ESAS2R is not set
> CONFIG_MEGARAID_NEWGEN=y
> CONFIG_MEGARAID_MM=m
> CONFIG_MEGARAID_MAILBOX=m
> CONFIG_MEGARAID_LEGACY=m
> CONFIG_MEGARAID_SAS=m
> # CONFIG_SCSI_MPT3SAS is not set
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> CONFIG_SCSI_HPTIOP=m
> CONFIG_SCSI_BUSLOGIC=m
> # CONFIG_SCSI_FLASHPOINT is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> CONFIG_VMWARE_PVSCSI=y
> CONFIG_XEN_SCSI_FRONTEND=y
> CONFIG_HYPERV_STORAGE=m
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> CONFIG_SCSI_DMX3191D=m
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> CONFIG_SCSI_GDTH=m
> # CONFIG_SCSI_ISCI is not set
> CONFIG_SCSI_IPS=m
> CONFIG_SCSI_INITIO=m
> CONFIG_SCSI_INIA100=m
> CONFIG_SCSI_STEX=m
> CONFIG_SCSI_SYM53C8XX_2=m
> CONFIG_SCSI_SYM53C8XX_DMA_ADDRESSING_MODE=1
> CONFIG_SCSI_SYM53C8XX_DEFAULT_TAGS=16
> CONFIG_SCSI_SYM53C8XX_MAX_TAGS=64
> CONFIG_SCSI_SYM53C8XX_MMIO=y
> # CONFIG_SCSI_IPR is not set
> CONFIG_SCSI_QLOGIC_1280=m
> CONFIG_SCSI_QLA_FC=m
> CONFIG_SCSI_QLA_ISCSI=m
> CONFIG_SCSI_LPFC=m
> # CONFIG_SCSI_LPFC_DEBUG_FS is not set
> CONFIG_SCSI_DC395x=m
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> # CONFIG_SCSI_DEBUG is not set
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> CONFIG_SCSI_VIRTIO=y
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> # CONFIG_SCSI_DH is not set
> # end of SCSI device support
> 
> CONFIG_ATA=y
> CONFIG_SATA_HOST=y
> CONFIG_PATA_TIMINGS=y
> CONFIG_ATA_VERBOSE_ERROR=y
> CONFIG_ATA_FORCE=y
> CONFIG_ATA_ACPI=y
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=y
> 
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=m
> CONFIG_SATA_MOBILE_LPM_POLICY=1
> # CONFIG_SATA_AHCI_PLATFORM is not set
> CONFIG_SATA_INIC162X=m
> # CONFIG_SATA_ACARD_AHCI is not set
> CONFIG_SATA_SIL24=m
> CONFIG_ATA_SFF=y
> 
> #
> # SFF controllers with custom DMA interface
> #
> CONFIG_PDC_ADMA=m
> CONFIG_SATA_QSTOR=m
> CONFIG_SATA_SX4=m
> CONFIG_ATA_BMDMA=y
> 
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=m
> # CONFIG_SATA_DWC is not set
> CONFIG_SATA_MV=m
> CONFIG_SATA_NV=m
> CONFIG_SATA_PROMISE=m
> CONFIG_SATA_SIL=m
> CONFIG_SATA_SIS=m
> CONFIG_SATA_SVW=m
> CONFIG_SATA_ULI=m
> CONFIG_SATA_VIA=m
> CONFIG_SATA_VITESSE=m
> 
> #
> # PATA SFF controllers with BMDMA
> #
> CONFIG_PATA_ALI=m
> CONFIG_PATA_AMD=m
> CONFIG_PATA_ARTOP=m
> CONFIG_PATA_ATIIXP=m
> # CONFIG_PATA_ATP867X is not set
> CONFIG_PATA_CMD64X=m
> # CONFIG_PATA_CYPRESS is not set
> CONFIG_PATA_EFAR=m
> CONFIG_PATA_HPT366=m
> CONFIG_PATA_HPT37X=m
> CONFIG_PATA_HPT3X2N=m
> CONFIG_PATA_HPT3X3=m
> # CONFIG_PATA_HPT3X3_DMA is not set
> CONFIG_PATA_IT8213=m
> CONFIG_PATA_IT821X=m
> CONFIG_PATA_JMICRON=m
> CONFIG_PATA_MARVELL=m
> CONFIG_PATA_NETCELL=m
> # CONFIG_PATA_NINJA32 is not set
> CONFIG_PATA_NS87415=m
> # CONFIG_PATA_OLDPIIX is not set
> CONFIG_PATA_OPTIDMA=m
> CONFIG_PATA_PDC2027X=m
> CONFIG_PATA_PDC_OLD=m
> CONFIG_PATA_RADISYS=m
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> CONFIG_PATA_SERVERWORKS=m
> CONFIG_PATA_SIL680=m
> CONFIG_PATA_SIS=m
> # CONFIG_PATA_TOSHIBA is not set
> CONFIG_PATA_TRIFLEX=m
> CONFIG_PATA_VIA=m
> CONFIG_PATA_WINBOND=m
> 
> #
> # PIO-only SFF controllers
> #
> CONFIG_PATA_CMD640_PCI=m
> CONFIG_PATA_MPIIX=m
> CONFIG_PATA_NS87410=m
> CONFIG_PATA_OPTI=m
> # CONFIG_PATA_PLATFORM is not set
> CONFIG_PATA_RZ1000=m
> 
> #
> # Generic fallback / legacy drivers
> #
> CONFIG_PATA_ACPI=m
> # CONFIG_ATA_GENERIC is not set
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=y
> CONFIG_BLK_DEV_MD=y
> CONFIG_MD_AUTODETECT=y
> CONFIG_MD_LINEAR=m
> CONFIG_MD_RAID0=m
> CONFIG_MD_RAID1=m
> CONFIG_MD_RAID10=m
> CONFIG_MD_RAID456=m
> CONFIG_MD_MULTIPATH=m
> CONFIG_MD_FAULTY=m
> # CONFIG_MD_CLUSTER is not set
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=y
> CONFIG_BLK_DEV_DM=m
> # CONFIG_DM_DEBUG is not set
> CONFIG_DM_BUFIO=m
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_UNSTRIPED=m
> CONFIG_DM_CRYPT=m
> CONFIG_DM_SNAPSHOT=m
> # CONFIG_DM_THIN_PROVISIONING is not set
> # CONFIG_DM_CACHE is not set
> CONFIG_DM_WRITECACHE=m
> # CONFIG_DM_ERA is not set
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=m
> # CONFIG_DM_LOG_USERSPACE is not set
> # CONFIG_DM_RAID is not set
> CONFIG_DM_ZERO=m
> CONFIG_DM_MULTIPATH=m
> # CONFIG_DM_MULTIPATH_QL is not set
> # CONFIG_DM_MULTIPATH_ST is not set
> # CONFIG_DM_DELAY is not set
> # CONFIG_DM_DUST is not set
> CONFIG_DM_UEVENT=y
> # CONFIG_DM_FLAKEY is not set
> # CONFIG_DM_VERITY is not set
> # CONFIG_DM_SWITCH is not set
> CONFIG_DM_LOG_WRITES=m
> # CONFIG_DM_INTEGRITY is not set
> # CONFIG_TARGET_CORE is not set
> CONFIG_FUSION=y
> CONFIG_FUSION_SPI=m
> CONFIG_FUSION_FC=m
> CONFIG_FUSION_SAS=m
> CONFIG_FUSION_MAX_SGE=128
> CONFIG_FUSION_CTL=m
> # CONFIG_FUSION_LOGGING is not set
> 
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=y
> CONFIG_FIREWIRE_OHCI=y
> CONFIG_FIREWIRE_SBP2=y
> # CONFIG_FIREWIRE_NET is not set
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
> 
> # CONFIG_MACINTOSH_DRIVERS is not set
> CONFIG_NETDEVICES=y
> CONFIG_MII=y
> CONFIG_NET_CORE=y
> # CONFIG_BONDING is not set
> # CONFIG_DUMMY is not set
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_IFB is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> CONFIG_IPVLAN_L3S=y
> CONFIG_IPVLAN=m
> CONFIG_IPVTAP=m
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_MACSEC is not set
> # CONFIG_NETCONSOLE is not set
> CONFIG_TUN=m
> CONFIG_TAP=m
> # CONFIG_TUN_VNET_CROSS_LE is not set
> # CONFIG_VETH is not set
> CONFIG_VIRTIO_NET=y
> # CONFIG_NLMON is not set
> # CONFIG_ARCNET is not set
> 
> #
> # Distributed Switch Architecture drivers
> #
> # end of Distributed Switch Architecture drivers
> 
> CONFIG_ETHERNET=y
> CONFIG_MDIO=y
> # CONFIG_NET_VENDOR_3COM is not set
> CONFIG_NET_VENDOR_ADAPTEC=y
> CONFIG_ADAPTEC_STARFIRE=y
> # CONFIG_NET_VENDOR_AGERE is not set
> CONFIG_NET_VENDOR_ALACRITECH=y
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=y
> CONFIG_ACENIC=y
> # CONFIG_ACENIC_OMIT_TIGON_I is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=y
> # CONFIG_ENA_ETHERNET is not set
> CONFIG_NET_VENDOR_AMD=y
> CONFIG_AMD8111_ETH=y
> # CONFIG_PCNET32 is not set
> # CONFIG_AMD_XGBE is not set
> CONFIG_NET_VENDOR_AQUANTIA=y
> # CONFIG_AQTION is not set
> # CONFIG_NET_VENDOR_ARC is not set
> CONFIG_NET_VENDOR_ATHEROS=y
> CONFIG_ATL2=y
> CONFIG_ATL1=y
> CONFIG_ATL1E=y
> CONFIG_ATL1C=y
> CONFIG_ALX=y
> # CONFIG_NET_VENDOR_AURORA is not set
> CONFIG_NET_VENDOR_BROADCOM=y
> CONFIG_B44=y
> CONFIG_B44_PCI_AUTOSELECT=y
> CONFIG_B44_PCICORE_AUTOSELECT=y
> CONFIG_B44_PCI=y
> # CONFIG_BCMGENET is not set
> CONFIG_BNX2=y
> CONFIG_CNIC=y
> CONFIG_TIGON3=y
> CONFIG_TIGON3_HWMON=y
> CONFIG_BNX2X=y
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> # CONFIG_NET_VENDOR_BROCADE is not set
> # CONFIG_NET_VENDOR_CADENCE is not set
> CONFIG_NET_VENDOR_CAVIUM=y
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> # CONFIG_CAVIUM_PTP is not set
> # CONFIG_LIQUIDIO is not set
> # CONFIG_LIQUIDIO_VF is not set
> # CONFIG_NET_VENDOR_CHELSIO is not set
> CONFIG_NET_VENDOR_CISCO=y
> CONFIG_ENIC=y
> # CONFIG_NET_VENDOR_CORTINA is not set
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> # CONFIG_NET_VENDOR_DEC is not set
> CONFIG_NET_VENDOR_DLINK=y
> CONFIG_DL2K=y
> # CONFIG_SUNDANCE is not set
> # CONFIG_NET_VENDOR_EMULEX is not set
> CONFIG_NET_VENDOR_EZCHIP=y
> CONFIG_NET_VENDOR_GOOGLE=y
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=y
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=y
> CONFIG_NET_VENDOR_INTEL=y
> CONFIG_E100=y
> CONFIG_E1000=y
> CONFIG_E1000E=y
> CONFIG_E1000E_HWTS=y
> CONFIG_IGB=y
> CONFIG_IGB_HWMON=y
> CONFIG_IGBVF=y
> CONFIG_IXGB=y
> CONFIG_IXGBE=y
> CONFIG_IXGBE_HWMON=y
> CONFIG_IXGBEVF=y
> CONFIG_I40E=y
> CONFIG_IAVF=y
> CONFIG_I40EVF=y
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> # CONFIG_IGC is not set
> CONFIG_JME=y
> CONFIG_NET_VENDOR_MARVELL=y
> # CONFIG_MVMDIO is not set
> CONFIG_SKGE=y
> # CONFIG_SKGE_DEBUG is not set
> # CONFIG_SKGE_GENESIS is not set
> CONFIG_SKY2=y
> # CONFIG_SKY2_DEBUG is not set
> CONFIG_NET_VENDOR_MELLANOX=y
> CONFIG_MLX4_EN=y
> CONFIG_MLX4_CORE=y
> # CONFIG_MLX4_DEBUG is not set
> # CONFIG_MLX4_CORE_GEN2 is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=y
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851_MLL is not set
> CONFIG_KSZ884X_PCI=y
> CONFIG_NET_VENDOR_MICROCHIP=y
> # CONFIG_LAN743X is not set
> # CONFIG_NET_VENDOR_MICROSEMI is not set
> CONFIG_NET_VENDOR_MYRI=y
> CONFIG_MYRI10GE=y
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=y
> CONFIG_NATSEMI=y
> CONFIG_NS83820=y
> # CONFIG_NET_VENDOR_NETERION is not set
> CONFIG_NET_VENDOR_NETRONOME=y
> # CONFIG_NFP is not set
> # CONFIG_NET_VENDOR_NI is not set
> CONFIG_NET_VENDOR_8390=y
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=y
> CONFIG_FORCEDETH=y
> # CONFIG_NET_VENDOR_OKI is not set
> # CONFIG_ETHOC is not set
> # CONFIG_NET_VENDOR_PACKET_ENGINES is not set
> CONFIG_NET_VENDOR_PENSANDO=y
> # CONFIG_IONIC is not set
> # CONFIG_NET_VENDOR_QLOGIC is not set
> # CONFIG_NET_VENDOR_QUALCOMM is not set
> # CONFIG_NET_VENDOR_RDC is not set
> CONFIG_NET_VENDOR_REALTEK=y
> CONFIG_8139CP=y
> CONFIG_8139TOO=y
> CONFIG_8139TOO_PIO=y
> CONFIG_8139TOO_TUNE_TWISTER=y
> CONFIG_8139TOO_8129=y
> # CONFIG_8139_OLD_RX_RESET is not set
> CONFIG_R8169=y
> CONFIG_NET_VENDOR_RENESAS=y
> # CONFIG_NET_VENDOR_ROCKER is not set
> # CONFIG_NET_VENDOR_SAMSUNG is not set
> # CONFIG_NET_VENDOR_SEEQ is not set
> CONFIG_NET_VENDOR_SOLARFLARE=y
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=y
> CONFIG_SC92031=y
> CONFIG_NET_VENDOR_SIS=y
> CONFIG_SIS900=y
> CONFIG_SIS190=y
> # CONFIG_NET_VENDOR_SMSC is not set
> # CONFIG_NET_VENDOR_SOCIONEXT is not set
> # CONFIG_NET_VENDOR_STMICRO is not set
> # CONFIG_NET_VENDOR_SUN is not set
> CONFIG_NET_VENDOR_SYNOPSYS=y
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=y
> CONFIG_TEHUTI=y
> CONFIG_NET_VENDOR_TI=y
> # CONFIG_TI_CPSW_PHY_SEL is not set
> CONFIG_TLAN=y
> CONFIG_NET_VENDOR_VIA=y
> CONFIG_VIA_RHINE=y
> # CONFIG_VIA_RHINE_MMIO is not set
> CONFIG_VIA_VELOCITY=y
> CONFIG_NET_VENDOR_WIZNET=y
> CONFIG_WIZNET_W5100=y
> CONFIG_WIZNET_W5300=y
> # CONFIG_WIZNET_BUS_DIRECT is not set
> # CONFIG_WIZNET_BUS_INDIRECT is not set
> CONFIG_WIZNET_BUS_ANY=y
> CONFIG_NET_VENDOR_XILINX=y
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> CONFIG_FDDI=y
> CONFIG_DEFXX=m
> CONFIG_DEFXX_MMIO=y
> CONFIG_SKFP=m
> CONFIG_HIPPI=y
> CONFIG_ROADRUNNER=m
> # CONFIG_ROADRUNNER_LARGE_RINGS is not set
> CONFIG_NET_SB1000=m
> CONFIG_MDIO_DEVICE=y
> CONFIG_MDIO_BUS=y
> # CONFIG_MDIO_BCM_UNIMAC is not set
> CONFIG_MDIO_BITBANG=m
> # CONFIG_MDIO_GPIO is not set
> # CONFIG_MDIO_MSCC_MIIM is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_THUNDER is not set
> # CONFIG_MDIO_XPCS is not set
> CONFIG_PHYLIB=y
> CONFIG_SWPHY=y
> # CONFIG_LED_TRIGGER_PHY is not set
> 
> #
> # MII PHY device drivers
> #
> # CONFIG_ADIN_PHY is not set
> # CONFIG_AMD_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> # CONFIG_AX88796B_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> CONFIG_BCM_NET_PHYLIB=m
> CONFIG_BROADCOM_PHY=m
> # CONFIG_BCM84881_PHY is not set
> CONFIG_CICADA_PHY=m
> # CONFIG_CORTINA_PHY is not set
> CONFIG_DAVICOM_PHY=m
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> CONFIG_FIXED_PHY=m
> CONFIG_ICPLUS_PHY=m
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> CONFIG_LXT_PHY=m
> CONFIG_MARVELL_PHY=m
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MICREL_PHY is not set
> CONFIG_MICROCHIP_PHY=m
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_AT803X_PHY is not set
> CONFIG_QSEMI_PHY=m
> CONFIG_REALTEK_PHY=y
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> CONFIG_SMSC_PHY=m
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> CONFIG_VITESSE_PHY=m
> # CONFIG_XILINX_GMII2RGMII is not set
> CONFIG_PPP=m
> CONFIG_PPP_BSDCOMP=m
> CONFIG_PPP_DEFLATE=m
> CONFIG_PPP_FILTER=y
> CONFIG_PPP_MPPE=m
> CONFIG_PPP_MULTILINK=y
> CONFIG_PPPOE=m
> CONFIG_PPP_ASYNC=m
> CONFIG_PPP_SYNC_TTY=m
> CONFIG_SLIP=m
> CONFIG_SLHC=m
> CONFIG_SLIP_COMPRESSED=y
> CONFIG_SLIP_SMART=y
> CONFIG_SLIP_MODE_SLIP6=y
> CONFIG_USB_NET_DRIVERS=y
> CONFIG_USB_CATC=y
> CONFIG_USB_KAWETH=y
> CONFIG_USB_PEGASUS=y
> CONFIG_USB_RTL8150=y
> CONFIG_USB_RTL8152=y
> CONFIG_USB_LAN78XX=m
> CONFIG_USB_USBNET=y
> CONFIG_USB_NET_AX8817X=y
> CONFIG_USB_NET_AX88179_178A=y
> CONFIG_USB_NET_CDCETHER=y
> # CONFIG_USB_NET_CDC_EEM is not set
> CONFIG_USB_NET_CDC_NCM=y
> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> # CONFIG_USB_NET_CDC_MBIM is not set
> # CONFIG_USB_NET_DM9601 is not set
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> # CONFIG_USB_NET_SMSC75XX is not set
> # CONFIG_USB_NET_SMSC95XX is not set
> # CONFIG_USB_NET_GL620A is not set
> CONFIG_USB_NET_NET1080=y
> # CONFIG_USB_NET_PLUSB is not set
> # CONFIG_USB_NET_MCS7830 is not set
> # CONFIG_USB_NET_RNDIS_HOST is not set
> CONFIG_USB_NET_CDC_SUBSET_ENABLE=y
> CONFIG_USB_NET_CDC_SUBSET=y
> # CONFIG_USB_ALI_M5632 is not set
> # CONFIG_USB_AN2720 is not set
> CONFIG_USB_BELKIN=y
> CONFIG_USB_ARMLINUX=y
> # CONFIG_USB_EPSON2888 is not set
> # CONFIG_USB_KC2190 is not set
> CONFIG_USB_NET_ZAURUS=y
> # CONFIG_USB_NET_CX82310_ETH is not set
> # CONFIG_USB_NET_KALMIA is not set
> # CONFIG_USB_NET_QMI_WWAN is not set
> # CONFIG_USB_NET_INT51X1 is not set
> # CONFIG_USB_IPHETH is not set
> # CONFIG_USB_SIERRA_NET is not set
> # CONFIG_USB_VL600 is not set
> CONFIG_USB_NET_CH9200=m
> # CONFIG_USB_NET_AQC111 is not set
> # CONFIG_WLAN is not set
> 
> #
> # Enable WiMAX (Networking options) to see the WiMAX drivers
> #
> CONFIG_WAN=y
> CONFIG_LANMEDIA=m
> CONFIG_HDLC=m
> CONFIG_HDLC_RAW=m
> CONFIG_HDLC_RAW_ETH=m
> CONFIG_HDLC_CISCO=m
> CONFIG_HDLC_FR=m
> CONFIG_HDLC_PPP=m
> 
> #
> # X.25/LAPB support is disabled
> #
> CONFIG_PCI200SYN=m
> CONFIG_WANXL=m
> CONFIG_PC300TOO=m
> CONFIG_FARSYNC=m
> CONFIG_DLCI=m
> CONFIG_DLCI_MAX=8
> CONFIG_SBNI=m
> CONFIG_SBNI_MULTILINE=y
> CONFIG_XEN_NETDEV_FRONTEND=y
> CONFIG_XEN_NETDEV_BACKEND=y
> CONFIG_VMXNET3=y
> # CONFIG_FUJITSU_ES is not set
> CONFIG_HYPERV_NET=y
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=y
> # CONFIG_ISDN is not set
> # CONFIG_NVM is not set
> 
> #
> # Input device support
> #
> CONFIG_INPUT=y
> CONFIG_INPUT_LEDS=m
> # CONFIG_INPUT_FF_MEMLESS is not set
> CONFIG_INPUT_POLLDEV=m
> CONFIG_INPUT_SPARSEKMAP=m
> # CONFIG_INPUT_MATRIXKMAP is not set
> 
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=y
> CONFIG_INPUT_MOUSEDEV_PSAUX=y
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
> CONFIG_INPUT_JOYDEV=m
> CONFIG_INPUT_EVDEV=y
> # CONFIG_INPUT_EVBUG is not set
> 
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=y
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> CONFIG_KEYBOARD_ATKBD=y
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> CONFIG_KEYBOARD_XTKBD=y
> CONFIG_INPUT_MOUSE=y
> CONFIG_MOUSE_PS2=y
> CONFIG_MOUSE_PS2_ALPS=y
> CONFIG_MOUSE_PS2_BYD=y
> CONFIG_MOUSE_PS2_LOGIPS2PP=y
> CONFIG_MOUSE_PS2_SYNAPTICS=y
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=y
> CONFIG_MOUSE_PS2_CYPRESS=y
> CONFIG_MOUSE_PS2_LIFEBOOK=y
> CONFIG_MOUSE_PS2_TRACKPOINT=y
> # CONFIG_MOUSE_PS2_ELANTECH is not set
> # CONFIG_MOUSE_PS2_SENTELIC is not set
> CONFIG_MOUSE_PS2_TOUCHKIT=y
> # CONFIG_MOUSE_PS2_FOCALTECH is not set
> CONFIG_MOUSE_PS2_VMMOUSE=y
> CONFIG_MOUSE_PS2_SMBUS=y
> CONFIG_MOUSE_SERIAL=y
> CONFIG_MOUSE_APPLETOUCH=y
> # CONFIG_MOUSE_BCM5974 is not set
> # CONFIG_MOUSE_CYAPA is not set
> # CONFIG_MOUSE_ELAN_I2C is not set
> # CONFIG_MOUSE_VSXXXAA is not set
> # CONFIG_MOUSE_GPIO is not set
> # CONFIG_MOUSE_SYNAPTICS_I2C is not set
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=y
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> # CONFIG_INPUT_MSM_VIBRATOR is not set
> CONFIG_INPUT_PCSPKR=y
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_APANEL is not set
> # CONFIG_INPUT_GP2A is not set
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> # CONFIG_INPUT_ATLAS_BTNS is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> # CONFIG_INPUT_REGULATOR_HAPTIC is not set
> # CONFIG_INPUT_UINPUT is not set
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_CMA3000 is not set
> CONFIG_INPUT_XEN_KBDDEV_FRONTEND=y
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> # CONFIG_RMI4_CORE is not set
> 
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=y
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=y
> CONFIG_SERIO_I8042=y
> CONFIG_SERIO_SERPORT=m
> CONFIG_SERIO_CT82C710=m
> CONFIG_SERIO_PCIPS2=m
> CONFIG_SERIO_LIBPS2=y
> # CONFIG_SERIO_RAW is not set
> # CONFIG_SERIO_ALTERA_PS2 is not set
> # CONFIG_SERIO_PS2MULT is not set
> # CONFIG_SERIO_ARC_PS2 is not set
> CONFIG_HYPERV_KEYBOARD=y
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> CONFIG_GAMEPORT=m
> CONFIG_GAMEPORT_NS558=m
> CONFIG_GAMEPORT_L4=m
> CONFIG_GAMEPORT_EMU10K1=m
> CONFIG_GAMEPORT_FM801=m
> # end of Hardware I/O ports
> # end of Input device support
> 
> #
> # Character devices
> #
> CONFIG_TTY=y
> CONFIG_VT=y
> CONFIG_CONSOLE_TRANSLATIONS=y
> CONFIG_VT_CONSOLE=y
> CONFIG_VT_CONSOLE_SLEEP=y
> CONFIG_HW_CONSOLE=y
> CONFIG_VT_HW_CONSOLE_BINDING=y
> CONFIG_UNIX98_PTYS=y
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LDISC_AUTOLOAD=y
> 
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=y
> CONFIG_SERIAL_8250=y
> CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
> CONFIG_SERIAL_8250_PNP=y
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=y
> CONFIG_SERIAL_8250_DMA=y
> CONFIG_SERIAL_8250_PCI=y
> CONFIG_SERIAL_8250_EXAR=y
> CONFIG_SERIAL_8250_NR_UARTS=4
> CONFIG_SERIAL_8250_RUNTIME_UARTS=4
> CONFIG_SERIAL_8250_EXTENDED=y
> CONFIG_SERIAL_8250_MANY_PORTS=y
> CONFIG_SERIAL_8250_SHARE_IRQ=y
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=y
> CONFIG_SERIAL_8250_DWLIB=y
> # CONFIG_SERIAL_8250_DW is not set
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=y
> CONFIG_SERIAL_8250_MID=y
> 
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=y
> CONFIG_SERIAL_CORE_CONSOLE=y
> # CONFIG_SERIAL_JSM is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> # CONFIG_SERIAL_ARC is not set
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
> 
> CONFIG_SERIAL_MCTRL_GPIO=y
> # CONFIG_SERIAL_NONSTANDARD is not set
> # CONFIG_N_GSM is not set
> # CONFIG_NOZOMI is not set
> # CONFIG_NULL_TTY is not set
> # CONFIG_TRACE_SINK is not set
> CONFIG_HVC_DRIVER=y
> CONFIG_HVC_IRQ=y
> CONFIG_HVC_XEN=y
> CONFIG_HVC_XEN_FRONTEND=y
> # CONFIG_SERIAL_DEV_BUS is not set
> # CONFIG_TTY_PRINTK is not set
> # CONFIG_VIRTIO_CONSOLE is not set
> # CONFIG_IPMI_HANDLER is not set
> CONFIG_HW_RANDOM=y
> # CONFIG_HW_RANDOM_TIMERIOMEM is not set
> CONFIG_HW_RANDOM_INTEL=y
> CONFIG_HW_RANDOM_AMD=y
> CONFIG_HW_RANDOM_VIA=y
> # CONFIG_HW_RANDOM_VIRTIO is not set
> # CONFIG_APPLICOM is not set
> CONFIG_MWAVE=m
> CONFIG_DEVMEM=y
> CONFIG_DEVKMEM=y
> CONFIG_NVRAM=m
> # CONFIG_RAW_DRIVER is not set
> CONFIG_DEVPORT=y
> # CONFIG_HPET is not set
> # CONFIG_HANGCHECK_TIMER is not set
> # CONFIG_TCG_TPM is not set
> # CONFIG_TELCLOCK is not set
> # CONFIG_XILLYBUS is not set
> # end of Character devices
> 
> # CONFIG_RANDOM_TRUST_CPU is not set
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> 
> #
> # I2C support
> #
> CONFIG_I2C=y
> CONFIG_ACPI_I2C_OPREGION=y
> CONFIG_I2C_BOARDINFO=y
> CONFIG_I2C_COMPAT=y
> CONFIG_I2C_CHARDEV=m
> # CONFIG_I2C_MUX is not set
> CONFIG_I2C_HELPER_AUTO=y
> CONFIG_I2C_SMBUS=m
> CONFIG_I2C_ALGOBIT=y
> 
> #
> # I2C Hardware Bus support
> #
> 
> #
> # PC SMBus host controller drivers
> #
> CONFIG_I2C_ALI1535=m
> CONFIG_I2C_ALI1563=m
> CONFIG_I2C_ALI15X3=m
> CONFIG_I2C_AMD756=m
> CONFIG_I2C_AMD756_S4882=m
> CONFIG_I2C_AMD8111=m
> # CONFIG_I2C_AMD_MP2 is not set
> CONFIG_I2C_I801=m
> # CONFIG_I2C_ISCH is not set
> # CONFIG_I2C_ISMT is not set
> CONFIG_I2C_PIIX4=m
> CONFIG_I2C_NFORCE2=m
> # CONFIG_I2C_NFORCE2_S4985 is not set
> # CONFIG_I2C_NVIDIA_GPU is not set
> CONFIG_I2C_SIS5595=m
> CONFIG_I2C_SIS630=m
> CONFIG_I2C_SIS96X=m
> CONFIG_I2C_VIA=m
> CONFIG_I2C_VIAPRO=m
> 
> #
> # ACPI drivers
> #
> # CONFIG_I2C_SCMI is not set
> 
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=y
> CONFIG_I2C_DESIGNWARE_PLATFORM=y
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PCI=m
> # CONFIG_I2C_DESIGNWARE_BAYTRAIL is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> CONFIG_I2C_OCORES=m
> # CONFIG_I2C_PCA_PLATFORM is not set
> CONFIG_I2C_SIMTEC=m
> # CONFIG_I2C_XILINX is not set
> 
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> CONFIG_I2C_TAOS_EVM=m
> CONFIG_I2C_TINY_USB=m
> 
> #
> # Other I2C/SMBus bus drivers
> #
> # CONFIG_I2C_MLXCPLD is not set
> # end of I2C Hardware Bus support
> 
> # CONFIG_I2C_STUB is not set
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
> 
> # CONFIG_I3C is not set
> # CONFIG_SPI is not set
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=y
> # CONFIG_PPS_DEBUG is not set
> 
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> # CONFIG_PPS_CLIENT_LDISC is not set
> # CONFIG_PPS_CLIENT_GPIO is not set
> 
> #
> # PPS generators support
> #
> 
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=y
> 
> #
> # Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
> #
> CONFIG_PTP_1588_CLOCK_KVM=y
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # end of PTP clock support
> 
> CONFIG_PINCTRL=y
> CONFIG_PINMUX=y
> CONFIG_PINCONF=y
> CONFIG_GENERIC_PINCONF=y
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
> # CONFIG_PINCTRL_BAYTRAIL is not set
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=m
> CONFIG_PINCTRL_BROXTON=m
> # CONFIG_PINCTRL_CANNONLAKE is not set
> # CONFIG_PINCTRL_CEDARFORK is not set
> # CONFIG_PINCTRL_DENVERTON is not set
> # CONFIG_PINCTRL_GEMINILAKE is not set
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_LEWISBURG is not set
> # CONFIG_PINCTRL_SUNRISEPOINT is not set
> # CONFIG_PINCTRL_TIGERLAKE is not set
> CONFIG_GPIOLIB=y
> CONFIG_GPIOLIB_FASTPATH_LIMIT=512
> CONFIG_GPIO_ACPI=y
> CONFIG_GPIOLIB_IRQCHIP=y
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_SYSFS=y
> 
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> # CONFIG_GPIO_ICH is not set
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_XILINX is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
> 
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
> 
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
> 
> #
> # MFD GPIO expanders
> #
> # CONFIG_GPIO_CRYSTAL_COVE is not set
> # end of MFD GPIO expanders
> 
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
> 
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
> 
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_W1 is not set
> # CONFIG_POWER_AVS is not set
> # CONFIG_POWER_RESET is not set
> CONFIG_POWER_SUPPLY=y
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=y
> # CONFIG_PDA_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_MANAGER is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_SMB347 is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_CHARGER_RT9455 is not set
> CONFIG_HWMON=y
> CONFIG_HWMON_VID=m
> # CONFIG_HWMON_DEBUG_CHIP is not set
> 
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=m
> CONFIG_SENSORS_ABITUGURU3=m
> # CONFIG_SENSORS_AD7414 is not set
> CONFIG_SENSORS_AD7418=m
> CONFIG_SENSORS_ADM1021=m
> CONFIG_SENSORS_ADM1025=m
> CONFIG_SENSORS_ADM1026=m
> CONFIG_SENSORS_ADM1029=m
> CONFIG_SENSORS_ADM1031=m
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=m
> # CONFIG_SENSORS_ADT7410 is not set
> # CONFIG_SENSORS_ADT7411 is not set
> # CONFIG_SENSORS_ADT7462 is not set
> CONFIG_SENSORS_ADT7470=m
> # CONFIG_SENSORS_ADT7475 is not set
> # CONFIG_SENSORS_AS370 is not set
> # CONFIG_SENSORS_ASC7621 is not set
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=m
> # CONFIG_SENSORS_K10TEMP is not set
> # CONFIG_SENSORS_FAM15H_POWER is not set
> CONFIG_SENSORS_APPLESMC=m
> CONFIG_SENSORS_ASB100=m
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=m
> # CONFIG_SENSORS_DRIVETEMP is not set
> # CONFIG_SENSORS_DS620 is not set
> CONFIG_SENSORS_DS1621=m
> # CONFIG_SENSORS_DELL_SMM is not set
> CONFIG_SENSORS_I5K_AMB=m
> CONFIG_SENSORS_F71805F=m
> CONFIG_SENSORS_F71882FG=m
> CONFIG_SENSORS_F75375S=m
> CONFIG_SENSORS_FSCHMD=m
> CONFIG_SENSORS_GL518SM=m
> CONFIG_SENSORS_GL520SM=m
> # CONFIG_SENSORS_G760A is not set
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_I5500=y
> CONFIG_SENSORS_CORETEMP=m
> CONFIG_SENSORS_IT87=m
> # CONFIG_SENSORS_JC42 is not set
> # CONFIG_SENSORS_POWR1220 is not set
> # CONFIG_SENSORS_LINEAGE is not set
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC4151 is not set
> # CONFIG_SENSORS_LTC4215 is not set
> # CONFIG_SENSORS_LTC4222 is not set
> # CONFIG_SENSORS_LTC4245 is not set
> # CONFIG_SENSORS_LTC4260 is not set
> # CONFIG_SENSORS_LTC4261 is not set
> # CONFIG_SENSORS_MAX16065 is not set
> CONFIG_SENSORS_MAX1619=m
> # CONFIG_SENSORS_MAX1668 is not set
> # CONFIG_SENSORS_MAX197 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> # CONFIG_SENSORS_MAX6639 is not set
> # CONFIG_SENSORS_MAX6642 is not set
> CONFIG_SENSORS_MAX6650=m
> # CONFIG_SENSORS_MAX6697 is not set
> # CONFIG_SENSORS_MAX31790 is not set
> # CONFIG_SENSORS_MCP3021 is not set
> # CONFIG_SENSORS_TC654 is not set
> CONFIG_SENSORS_LM63=m
> # CONFIG_SENSORS_LM73 is not set
> CONFIG_SENSORS_LM75=m
> CONFIG_SENSORS_LM77=m
> CONFIG_SENSORS_LM78=m
> CONFIG_SENSORS_LM80=m
> CONFIG_SENSORS_LM83=m
> CONFIG_SENSORS_LM85=m
> CONFIG_SENSORS_LM87=m
> CONFIG_SENSORS_LM90=m
> CONFIG_SENSORS_LM92=m
> CONFIG_SENSORS_LM93=m
> # CONFIG_SENSORS_LM95234 is not set
> # CONFIG_SENSORS_LM95241 is not set
> # CONFIG_SENSORS_LM95245 is not set
> CONFIG_SENSORS_PC87360=m
> CONFIG_SENSORS_PC87427=m
> # CONFIG_SENSORS_NTC_THERMISTOR is not set
> # CONFIG_SENSORS_NCT6683 is not set
> # CONFIG_SENSORS_NCT6775 is not set
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> CONFIG_SENSORS_PCF8591=m
> # CONFIG_PMBUS is not set
> # CONFIG_SENSORS_SHT15 is not set
> # CONFIG_SENSORS_SHT21 is not set
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=m
> CONFIG_SENSORS_DME1737=m
> # CONFIG_SENSORS_EMC1403 is not set
> # CONFIG_SENSORS_EMC2103 is not set
> # CONFIG_SENSORS_EMC6W201 is not set
> CONFIG_SENSORS_SMSC47M1=m
> CONFIG_SENSORS_SMSC47M192=m
> CONFIG_SENSORS_SMSC47B397=m
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> # CONFIG_SENSORS_ADS7828 is not set
> # CONFIG_SENSORS_AMC6821 is not set
> # CONFIG_SENSORS_INA209 is not set
> # CONFIG_SENSORS_INA2XX is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=m
> # CONFIG_SENSORS_TMP102 is not set
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> # CONFIG_SENSORS_TMP401 is not set
> # CONFIG_SENSORS_TMP421 is not set
> # CONFIG_SENSORS_TMP513 is not set
> # CONFIG_SENSORS_VIA_CPUTEMP is not set
> CONFIG_SENSORS_VIA686A=m
> CONFIG_SENSORS_VT1211=m
> CONFIG_SENSORS_VT8231=m
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=m
> CONFIG_SENSORS_W83791D=m
> CONFIG_SENSORS_W83792D=m
> CONFIG_SENSORS_W83793=m
> # CONFIG_SENSORS_W83795 is not set
> CONFIG_SENSORS_W83L785TS=m
> # CONFIG_SENSORS_W83L786NG is not set
> CONFIG_SENSORS_W83627HF=m
> CONFIG_SENSORS_W83627EHF=m
> # CONFIG_SENSORS_XGENE is not set
> 
> #
> # ACPI drivers
> #
> # CONFIG_SENSORS_ACPI_POWER is not set
> # CONFIG_SENSORS_ATK0110 is not set
> CONFIG_THERMAL=y
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=0
> # CONFIG_THERMAL_HWMON is not set
> CONFIG_THERMAL_WRITABLE_TRIPS=y
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> # CONFIG_THERMAL_GOV_FAIR_SHARE is not set
> CONFIG_THERMAL_GOV_STEP_WISE=y
> # CONFIG_THERMAL_GOV_BANG_BANG is not set
> CONFIG_THERMAL_GOV_USER_SPACE=y
> # CONFIG_THERMAL_EMULATION is not set
> 
> #
> # Intel thermal drivers
> #
> # CONFIG_INTEL_POWERCLAMP is not set
> CONFIG_X86_PKG_TEMP_THERMAL=m
> CONFIG_INTEL_SOC_DTS_IOSF_CORE=m
> CONFIG_INTEL_SOC_DTS_THERMAL=m
> 
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
> 
> CONFIG_INTEL_PCH_THERMAL=m
> # end of Intel thermal drivers
> 
> # CONFIG_WATCHDOG is not set
> CONFIG_SSB_POSSIBLE=y
> CONFIG_SSB=y
> CONFIG_SSB_SPROM=y
> CONFIG_SSB_PCIHOST_POSSIBLE=y
> CONFIG_SSB_PCIHOST=y
> CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
> CONFIG_SSB_DRIVER_PCICORE=y
> # CONFIG_SSB_DRIVER_GPIO is not set
> CONFIG_BCMA_POSSIBLE=y
> CONFIG_BCMA=m
> CONFIG_BCMA_HOST_PCI_POSSIBLE=y
> CONFIG_BCMA_HOST_PCI=y
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=y
> # CONFIG_BCMA_DRIVER_GMAC_CMN is not set
> # CONFIG_BCMA_DRIVER_GPIO is not set
> # CONFIG_BCMA_DEBUG is not set
> 
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=y
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=m
> CONFIG_LPC_SCH=m
> CONFIG_INTEL_SOC_PMIC=y
> # CONFIG_INTEL_SOC_PMIC_CHTWC is not set
> # CONFIG_INTEL_SOC_PMIC_CHTDC_TI is not set
> CONFIG_MFD_INTEL_LPSS=m
> CONFIG_MFD_INTEL_LPSS_ACPI=m
> CONFIG_MFD_INTEL_LPSS_PCI=m
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_UCB1400_CORE is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SEC_CORE is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=m
> CONFIG_MFD_SM501_GPIO=y
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SMSC is not set
> # CONFIG_ABX500_CORE is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TPS68470 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS80031 is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> # CONFIG_MFD_VX855 is not set
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # end of Multifunction device drivers
> 
> CONFIG_REGULATOR=y
> # CONFIG_REGULATOR_DEBUG is not set
> # CONFIG_REGULATOR_FIXED_VOLTAGE is not set
> # CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
> # CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
> # CONFIG_REGULATOR_88PG86X is not set
> # CONFIG_REGULATOR_ACT8865 is not set
> # CONFIG_REGULATOR_AD5398 is not set
> # CONFIG_REGULATOR_DA9210 is not set
> # CONFIG_REGULATOR_DA9211 is not set
> # CONFIG_REGULATOR_FAN53555 is not set
> # CONFIG_REGULATOR_GPIO is not set
> # CONFIG_REGULATOR_ISL9305 is not set
> # CONFIG_REGULATOR_ISL6271A is not set
> # CONFIG_REGULATOR_LP3971 is not set
> # CONFIG_REGULATOR_LP3972 is not set
> # CONFIG_REGULATOR_LP872X is not set
> # CONFIG_REGULATOR_LP8755 is not set
> # CONFIG_REGULATOR_LTC3589 is not set
> # CONFIG_REGULATOR_LTC3676 is not set
> # CONFIG_REGULATOR_MAX1586 is not set
> # CONFIG_REGULATOR_MAX8649 is not set
> # CONFIG_REGULATOR_MAX8660 is not set
> # CONFIG_REGULATOR_MAX8952 is not set
> # CONFIG_REGULATOR_MP8859 is not set
> # CONFIG_REGULATOR_MT6311 is not set
> # CONFIG_REGULATOR_PFUZE100 is not set
> # CONFIG_REGULATOR_PV88060 is not set
> # CONFIG_REGULATOR_PV88080 is not set
> # CONFIG_REGULATOR_PV88090 is not set
> # CONFIG_REGULATOR_SLG51000 is not set
> # CONFIG_REGULATOR_TPS51632 is not set
> # CONFIG_REGULATOR_TPS62360 is not set
> # CONFIG_REGULATOR_TPS65023 is not set
> # CONFIG_REGULATOR_TPS6507X is not set
> # CONFIG_REGULATOR_TPS65132 is not set
> CONFIG_RC_CORE=y
> CONFIG_RC_MAP=y
> # CONFIG_LIRC is not set
> CONFIG_RC_DECODERS=y
> CONFIG_IR_NEC_DECODER=y
> CONFIG_IR_RC5_DECODER=y
> CONFIG_IR_RC6_DECODER=y
> CONFIG_IR_JVC_DECODER=y
> CONFIG_IR_SONY_DECODER=y
> CONFIG_IR_SANYO_DECODER=y
> CONFIG_IR_SHARP_DECODER=y
> CONFIG_IR_MCE_KBD_DECODER=y
> CONFIG_IR_XMP_DECODER=y
> # CONFIG_IR_IMON_DECODER is not set
> # CONFIG_IR_RCMM_DECODER is not set
> # CONFIG_RC_DEVICES is not set
> CONFIG_MEDIA_SUPPORT=y
> 
> #
> # Multimedia core support
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # CONFIG_VIDEO_ADV_DEBUG is not set
> # CONFIG_VIDEO_FIXED_MINOR_RANGES is not set
> 
> #
> # Media drivers
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> 
> #
> # Supported MMC/SDIO adapters
> #
> # CONFIG_CYPRESS_FIRMWARE is not set
> 
> #
> # Media ancillary drivers (tuners, sensors, i2c, spi, frontends)
> #
> 
> #
> # Customise DVB Frontends
> #
> 
> #
> # Tools to develop new frontends
> #
> # end of Customise DVB Frontends
> 
> #
> # Graphics support
> #
> CONFIG_AGP=y
> # CONFIG_AGP_AMD64 is not set
> CONFIG_AGP_INTEL=y
> # CONFIG_AGP_SIS is not set
> # CONFIG_AGP_VIA is not set
> CONFIG_INTEL_GTT=y
> CONFIG_VGA_ARB=y
> CONFIG_VGA_ARB_MAX_GPUS=16
> # CONFIG_VGA_SWITCHEROO is not set
> CONFIG_DRM=y
> CONFIG_DRM_MIPI_DSI=y
> # CONFIG_DRM_DP_AUX_CHARDEV is not set
> # CONFIG_DRM_DEBUG_MM is not set
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=y
> CONFIG_DRM_KMS_FB_HELPER=y
> # CONFIG_DRM_DEBUG_DP_MST_TOPOLOGY_REFS is not set
> CONFIG_DRM_FBDEV_EMULATION=y
> CONFIG_DRM_FBDEV_OVERALLOC=100
> # CONFIG_DRM_FBDEV_LEAK_PHYS_SMEM is not set
> CONFIG_DRM_LOAD_EDID_FIRMWARE=y
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=m
> CONFIG_DRM_TTM_DMA_PAGE_POOL=y
> CONFIG_DRM_VRAM_HELPER=m
> CONFIG_DRM_TTM_HELPER=m
> CONFIG_DRM_GEM_SHMEM_HELPER=y
> 
> #
> # I2C encoder or helper chips
> #
> # CONFIG_DRM_I2C_CH7006 is not set
> # CONFIG_DRM_I2C_SIL164 is not set
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
> 
> #
> # ARM devices
> #
> # end of ARM devices
> 
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_I915=y
> CONFIG_DRM_I915_FORCE_PROBE=""
> CONFIG_DRM_I915_CAPTURE_ERROR=y
> CONFIG_DRM_I915_COMPRESS_ERROR=y
> CONFIG_DRM_I915_USERPTR=y
> # CONFIG_DRM_I915_GVT is not set
> 
> #
> # drm/i915 Debugging
> #
> # CONFIG_DRM_I915_WERROR is not set
> # CONFIG_DRM_I915_DEBUG is not set
> # CONFIG_DRM_I915_DEBUG_MMIO is not set
> # CONFIG_DRM_I915_SW_FENCE_DEBUG_OBJECTS is not set
> # CONFIG_DRM_I915_SW_FENCE_CHECK_DAG is not set
> # CONFIG_DRM_I915_DEBUG_GUC is not set
> # CONFIG_DRM_I915_SELFTEST is not set
> # CONFIG_DRM_I915_LOW_LEVEL_TRACEPOINTS is not set
> # CONFIG_DRM_I915_DEBUG_VBLANK_EVADE is not set
> # CONFIG_DRM_I915_DEBUG_RUNTIME_PM is not set
> # end of drm/i915 Debugging
> 
> #
> # drm/i915 Profile Guided Optimisation
> #
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=640
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=8000
> CONFIG_DRM_I915_STOP_TIMEOUT=100
> CONFIG_DRM_I915_TIMESLICE_DURATION=1
> # end of drm/i915 Profile Guided Optimisation
> 
> # CONFIG_DRM_VGEM is not set
> CONFIG_DRM_VKMS=m
> CONFIG_DRM_VMWGFX=m
> # CONFIG_DRM_VMWGFX_FBCON is not set
> # CONFIG_DRM_GMA500 is not set
> # CONFIG_DRM_UDL is not set
> # CONFIG_DRM_AST is not set
> # CONFIG_DRM_MGAG200 is not set
> CONFIG_DRM_CIRRUS_QEMU=m
> CONFIG_DRM_QXL=m
> CONFIG_DRM_BOCHS=m
> CONFIG_DRM_VIRTIO_GPU=m
> CONFIG_DRM_PANEL=y
> 
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # end of Display Panels
> 
> CONFIG_DRM_BRIDGE=y
> CONFIG_DRM_PANEL_BRIDGE=y
> 
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
> 
> # CONFIG_DRM_ETNAVIV is not set
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_DRM_XEN is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=y
> 
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=y
> CONFIG_FB_NOTIFY=y
> CONFIG_FB=y
> CONFIG_FIRMWARE_EDID=y
> CONFIG_FB_BOOT_VESA_SUPPORT=y
> CONFIG_FB_CFB_FILLRECT=y
> CONFIG_FB_CFB_COPYAREA=y
> CONFIG_FB_CFB_IMAGEBLIT=y
> CONFIG_FB_SYS_FILLRECT=y
> CONFIG_FB_SYS_COPYAREA=y
> CONFIG_FB_SYS_IMAGEBLIT=y
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=y
> CONFIG_FB_DEFERRED_IO=y
> CONFIG_FB_MODE_HELPERS=y
> # CONFIG_FB_TILEBLITTING is not set
> 
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=y
> CONFIG_FB_EFI=y
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> CONFIG_XEN_FBDEV_FRONTEND=y
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> CONFIG_FB_HYPERV=y
> CONFIG_FB_SIMPLE=y
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
> 
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=y
> CONFIG_LCD_PLATFORM=y
> CONFIG_BACKLIGHT_CLASS_DEVICE=y
> CONFIG_BACKLIGHT_GENERIC=m
> # CONFIG_BACKLIGHT_APPLE is not set
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
> 
> CONFIG_HDMI=y
> 
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=y
> CONFIG_VGACON_SOFT_SCROLLBACK=y
> CONFIG_VGACON_SOFT_SCROLLBACK_SIZE=64
> # CONFIG_VGACON_SOFT_SCROLLBACK_PERSISTENT_ENABLE_BY_DEFAULT is not set
> CONFIG_DUMMY_CONSOLE=y
> CONFIG_DUMMY_CONSOLE_COLUMNS=80
> CONFIG_DUMMY_CONSOLE_ROWS=25
> CONFIG_FRAMEBUFFER_CONSOLE=y
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
> # CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
> 
> # CONFIG_LOGO is not set
> # end of Graphics support
> 
> CONFIG_SOUND=y
> CONFIG_SOUND_OSS_CORE=y
> CONFIG_SOUND_OSS_CORE_PRECLAIM=y
> CONFIG_SND=y
> CONFIG_SND_TIMER=y
> CONFIG_SND_PCM=y
> CONFIG_SND_HWDEP=y
> CONFIG_SND_SEQ_DEVICE=y
> CONFIG_SND_JACK=y
> CONFIG_SND_JACK_INPUT_DEV=y
> CONFIG_SND_OSSEMUL=y
> CONFIG_SND_MIXER_OSS=y
> CONFIG_SND_PCM_OSS=y
> CONFIG_SND_PCM_OSS_PLUGINS=y
> CONFIG_SND_PCM_TIMER=y
> # CONFIG_SND_HRTIMER is not set
> CONFIG_SND_DYNAMIC_MINORS=y
> CONFIG_SND_MAX_CARDS=32
> CONFIG_SND_SUPPORT_OLD_API=y
> CONFIG_SND_PROC_FS=y
> # CONFIG_SND_VERBOSE_PROCFS is not set
> # CONFIG_SND_VERBOSE_PRINTK is not set
> # CONFIG_SND_DEBUG is not set
> CONFIG_SND_VMASTER=y
> CONFIG_SND_DMA_SGBUF=y
> CONFIG_SND_SEQUENCER=y
> # CONFIG_SND_SEQ_DUMMY is not set
> CONFIG_SND_SEQUENCER_OSS=y
> CONFIG_SND_SEQ_MIDI_EVENT=y
> CONFIG_SND_AC97_CODEC=y
> CONFIG_SND_DRIVERS=y
> # CONFIG_SND_PCSP is not set
> # CONFIG_SND_DUMMY is not set
> # CONFIG_SND_ALOOP is not set
> # CONFIG_SND_VIRMIDI is not set
> # CONFIG_SND_MTPAV is not set
> # CONFIG_SND_SERIAL_U16550 is not set
> # CONFIG_SND_MPU401 is not set
> # CONFIG_SND_AC97_POWER_SAVE is not set
> CONFIG_SND_PCI=y
> # CONFIG_SND_AD1889 is not set
> # CONFIG_SND_ALS300 is not set
> # CONFIG_SND_ALS4000 is not set
> # CONFIG_SND_ALI5451 is not set
> # CONFIG_SND_ASIHPI is not set
> # CONFIG_SND_ATIIXP is not set
> # CONFIG_SND_ATIIXP_MODEM is not set
> # CONFIG_SND_AU8810 is not set
> # CONFIG_SND_AU8820 is not set
> # CONFIG_SND_AU8830 is not set
> # CONFIG_SND_AW2 is not set
> # CONFIG_SND_AZT3328 is not set
> # CONFIG_SND_BT87X is not set
> # CONFIG_SND_CA0106 is not set
> # CONFIG_SND_CMIPCI is not set
> # CONFIG_SND_OXYGEN is not set
> # CONFIG_SND_CS4281 is not set
> # CONFIG_SND_CS46XX is not set
> # CONFIG_SND_CTXFI is not set
> # CONFIG_SND_DARLA20 is not set
> # CONFIG_SND_GINA20 is not set
> # CONFIG_SND_LAYLA20 is not set
> # CONFIG_SND_DARLA24 is not set
> # CONFIG_SND_GINA24 is not set
> # CONFIG_SND_LAYLA24 is not set
> # CONFIG_SND_MONA is not set
> # CONFIG_SND_MIA is not set
> # CONFIG_SND_ECHO3G is not set
> # CONFIG_SND_INDIGO is not set
> # CONFIG_SND_INDIGOIO is not set
> # CONFIG_SND_INDIGODJ is not set
> # CONFIG_SND_INDIGOIOX is not set
> # CONFIG_SND_INDIGODJX is not set
> # CONFIG_SND_EMU10K1 is not set
> # CONFIG_SND_EMU10K1X is not set
> # CONFIG_SND_ENS1370 is not set
> # CONFIG_SND_ENS1371 is not set
> # CONFIG_SND_ES1938 is not set
> # CONFIG_SND_ES1968 is not set
> # CONFIG_SND_FM801 is not set
> # CONFIG_SND_HDSP is not set
> # CONFIG_SND_HDSPM is not set
> # CONFIG_SND_ICE1712 is not set
> # CONFIG_SND_ICE1724 is not set
> CONFIG_SND_INTEL8X0=y
> CONFIG_SND_INTEL8X0M=y
> # CONFIG_SND_KORG1212 is not set
> # CONFIG_SND_LOLA is not set
> # CONFIG_SND_LX6464ES is not set
> # CONFIG_SND_MAESTRO3 is not set
> # CONFIG_SND_MIXART is not set
> # CONFIG_SND_NM256 is not set
> # CONFIG_SND_PCXHR is not set
> # CONFIG_SND_RIPTIDE is not set
> # CONFIG_SND_RME32 is not set
> # CONFIG_SND_RME96 is not set
> # CONFIG_SND_RME9652 is not set
> # CONFIG_SND_SE6X is not set
> # CONFIG_SND_SONICVIBES is not set
> # CONFIG_SND_TRIDENT is not set
> # CONFIG_SND_VIA82XX is not set
> # CONFIG_SND_VIA82XX_MODEM is not set
> # CONFIG_SND_VIRTUOSO is not set
> # CONFIG_SND_VX222 is not set
> # CONFIG_SND_YMFPCI is not set
> 
> #
> # HD-Audio
> #
> CONFIG_SND_HDA=y
> CONFIG_SND_HDA_INTEL=y
> CONFIG_SND_HDA_HWDEP=y
> CONFIG_SND_HDA_RECONFIG=y
> # CONFIG_SND_HDA_INPUT_BEEP is not set
> CONFIG_SND_HDA_PATCH_LOADER=y
> CONFIG_SND_HDA_CODEC_REALTEK=y
> CONFIG_SND_HDA_CODEC_ANALOG=y
> CONFIG_SND_HDA_CODEC_SIGMATEL=y
> CONFIG_SND_HDA_CODEC_VIA=y
> CONFIG_SND_HDA_CODEC_HDMI=y
> CONFIG_SND_HDA_CODEC_CIRRUS=y
> CONFIG_SND_HDA_CODEC_CONEXANT=y
> CONFIG_SND_HDA_CODEC_CA0110=y
> CONFIG_SND_HDA_CODEC_CA0132=y
> CONFIG_SND_HDA_CODEC_CA0132_DSP=y
> CONFIG_SND_HDA_CODEC_CMEDIA=y
> CONFIG_SND_HDA_CODEC_SI3054=y
> CONFIG_SND_HDA_GENERIC=y
> CONFIG_SND_HDA_POWER_SAVE_DEFAULT=0
> # end of HD-Audio
> 
> CONFIG_SND_HDA_CORE=y
> CONFIG_SND_HDA_DSP_LOADER=y
> CONFIG_SND_HDA_COMPONENT=y
> CONFIG_SND_HDA_I915=y
> CONFIG_SND_HDA_PREALLOC_SIZE=64
> CONFIG_SND_INTEL_NHLT=y
> CONFIG_SND_INTEL_DSP_CONFIG=y
> # CONFIG_SND_USB is not set
> CONFIG_SND_FIREWIRE=y
> # CONFIG_SND_DICE is not set
> # CONFIG_SND_OXFW is not set
> # CONFIG_SND_ISIGHT is not set
> # CONFIG_SND_FIREWORKS is not set
> # CONFIG_SND_BEBOB is not set
> # CONFIG_SND_FIREWIRE_DIGI00X is not set
> # CONFIG_SND_FIREWIRE_TASCAM is not set
> # CONFIG_SND_FIREWIRE_MOTU is not set
> # CONFIG_SND_FIREFACE is not set
> CONFIG_SND_SOC=y
> CONFIG_SND_SOC_AC97_BUS=y
> # CONFIG_SND_SOC_AMD_ACP is not set
> # CONFIG_SND_SOC_AMD_ACP3x is not set
> # CONFIG_SND_ATMEL_SOC is not set
> # CONFIG_SND_BCM63XX_I2S_WHISTLER is not set
> # CONFIG_SND_DESIGNWARE_I2S is not set
> 
> #
> # SoC Audio for Freescale CPUs
> #
> 
> #
> # Common SoC Audio options for Freescale CPUs:
> #
> # CONFIG_SND_SOC_FSL_ASRC is not set
> # CONFIG_SND_SOC_FSL_SAI is not set
> # CONFIG_SND_SOC_FSL_AUDMIX is not set
> # CONFIG_SND_SOC_FSL_SSI is not set
> # CONFIG_SND_SOC_FSL_SPDIF is not set
> # CONFIG_SND_SOC_FSL_ESAI is not set
> # CONFIG_SND_SOC_FSL_MICFIL is not set
> # CONFIG_SND_SOC_IMX_AUDMUX is not set
> # end of SoC Audio for Freescale CPUs
> 
> # CONFIG_SND_I2S_HI6210_I2S is not set
> # CONFIG_SND_SOC_IMG is not set
> # CONFIG_SND_SOC_INTEL_SST_TOPLEVEL is not set
> # CONFIG_SND_SOC_MTK_BTCVSD is not set
> # CONFIG_SND_SOC_SOF_TOPLEVEL is not set
> 
> #
> # STMicroelectronics STM32 SOC audio support
> #
> # end of STMicroelectronics STM32 SOC audio support
> 
> # CONFIG_SND_SOC_XILINX_I2S is not set
> # CONFIG_SND_SOC_XILINX_AUDIO_FORMATTER is not set
> # CONFIG_SND_SOC_XILINX_SPDIF is not set
> # CONFIG_SND_SOC_XTFPGA_I2S is not set
> # CONFIG_ZX_TDM is not set
> CONFIG_SND_SOC_I2C_AND_SPI=y
> 
> #
> # CODEC drivers
> #
> CONFIG_SND_SOC_AC97_CODEC=m
> # CONFIG_SND_SOC_ADAU1701 is not set
> # CONFIG_SND_SOC_ADAU1761_I2C is not set
> # CONFIG_SND_SOC_ADAU7002 is not set
> # CONFIG_SND_SOC_ADAU7118_HW is not set
> # CONFIG_SND_SOC_ADAU7118_I2C is not set
> # CONFIG_SND_SOC_AK4118 is not set
> # CONFIG_SND_SOC_AK4458 is not set
> # CONFIG_SND_SOC_AK4554 is not set
> # CONFIG_SND_SOC_AK4613 is not set
> # CONFIG_SND_SOC_AK4642 is not set
> # CONFIG_SND_SOC_AK5386 is not set
> # CONFIG_SND_SOC_AK5558 is not set
> # CONFIG_SND_SOC_ALC5623 is not set
> # CONFIG_SND_SOC_BD28623 is not set
> # CONFIG_SND_SOC_BT_SCO is not set
> # CONFIG_SND_SOC_CS35L32 is not set
> # CONFIG_SND_SOC_CS35L33 is not set
> # CONFIG_SND_SOC_CS35L34 is not set
> # CONFIG_SND_SOC_CS35L35 is not set
> # CONFIG_SND_SOC_CS35L36 is not set
> # CONFIG_SND_SOC_CS42L42 is not set
> # CONFIG_SND_SOC_CS42L51_I2C is not set
> # CONFIG_SND_SOC_CS42L52 is not set
> # CONFIG_SND_SOC_CS42L56 is not set
> # CONFIG_SND_SOC_CS42L73 is not set
> # CONFIG_SND_SOC_CS4265 is not set
> # CONFIG_SND_SOC_CS4270 is not set
> # CONFIG_SND_SOC_CS4271_I2C is not set
> # CONFIG_SND_SOC_CS42XX8_I2C is not set
> # CONFIG_SND_SOC_CS43130 is not set
> # CONFIG_SND_SOC_CS4341 is not set
> # CONFIG_SND_SOC_CS4349 is not set
> # CONFIG_SND_SOC_CS53L30 is not set
> # CONFIG_SND_SOC_CX2072X is not set
> # CONFIG_SND_SOC_DA7213 is not set
> # CONFIG_SND_SOC_DMIC is not set
> # CONFIG_SND_SOC_ES7134 is not set
> # CONFIG_SND_SOC_ES7241 is not set
> # CONFIG_SND_SOC_ES8316 is not set
> # CONFIG_SND_SOC_ES8328_I2C is not set
> # CONFIG_SND_SOC_GTM601 is not set
> # CONFIG_SND_SOC_INNO_RK3036 is not set
> # CONFIG_SND_SOC_MAX98088 is not set
> # CONFIG_SND_SOC_MAX98357A is not set
> # CONFIG_SND_SOC_MAX98504 is not set
> # CONFIG_SND_SOC_MAX9867 is not set
> # CONFIG_SND_SOC_MAX98927 is not set
> # CONFIG_SND_SOC_MAX98373 is not set
> # CONFIG_SND_SOC_MAX9860 is not set
> # CONFIG_SND_SOC_MSM8916_WCD_DIGITAL is not set
> # CONFIG_SND_SOC_PCM1681 is not set
> # CONFIG_SND_SOC_PCM1789_I2C is not set
> # CONFIG_SND_SOC_PCM179X_I2C is not set
> # CONFIG_SND_SOC_PCM186X_I2C is not set
> # CONFIG_SND_SOC_PCM3060_I2C is not set
> # CONFIG_SND_SOC_PCM3168A_I2C is not set
> # CONFIG_SND_SOC_PCM512x_I2C is not set
> # CONFIG_SND_SOC_RK3328 is not set
> # CONFIG_SND_SOC_RT5616 is not set
> # CONFIG_SND_SOC_RT5631 is not set
> # CONFIG_SND_SOC_SGTL5000 is not set
> # CONFIG_SND_SOC_SIMPLE_AMPLIFIER is not set
> # CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
> # CONFIG_SND_SOC_SPDIF is not set
> # CONFIG_SND_SOC_SSM2305 is not set
> # CONFIG_SND_SOC_SSM2602_I2C is not set
> # CONFIG_SND_SOC_SSM4567 is not set
> # CONFIG_SND_SOC_STA32X is not set
> # CONFIG_SND_SOC_STA350 is not set
> # CONFIG_SND_SOC_STI_SAS is not set
> # CONFIG_SND_SOC_TAS2552 is not set
> # CONFIG_SND_SOC_TAS2562 is not set
> # CONFIG_SND_SOC_TAS2770 is not set
> # CONFIG_SND_SOC_TAS5086 is not set
> # CONFIG_SND_SOC_TAS571X is not set
> # CONFIG_SND_SOC_TAS5720 is not set
> # CONFIG_SND_SOC_TAS6424 is not set
> # CONFIG_SND_SOC_TDA7419 is not set
> # CONFIG_SND_SOC_TFA9879 is not set
> # CONFIG_SND_SOC_TLV320AIC23_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC31XX is not set
> # CONFIG_SND_SOC_TLV320AIC32X4_I2C is not set
> # CONFIG_SND_SOC_TLV320AIC3X is not set
> # CONFIG_SND_SOC_TLV320ADCX140 is not set
> # CONFIG_SND_SOC_TS3A227E is not set
> # CONFIG_SND_SOC_TSCS42XX is not set
> # CONFIG_SND_SOC_TSCS454 is not set
> # CONFIG_SND_SOC_UDA1334 is not set
> # CONFIG_SND_SOC_WM8510 is not set
> # CONFIG_SND_SOC_WM8523 is not set
> # CONFIG_SND_SOC_WM8524 is not set
> # CONFIG_SND_SOC_WM8580 is not set
> # CONFIG_SND_SOC_WM8711 is not set
> # CONFIG_SND_SOC_WM8728 is not set
> # CONFIG_SND_SOC_WM8731 is not set
> # CONFIG_SND_SOC_WM8737 is not set
> # CONFIG_SND_SOC_WM8741 is not set
> # CONFIG_SND_SOC_WM8750 is not set
> # CONFIG_SND_SOC_WM8753 is not set
> # CONFIG_SND_SOC_WM8776 is not set
> # CONFIG_SND_SOC_WM8782 is not set
> # CONFIG_SND_SOC_WM8804_I2C is not set
> # CONFIG_SND_SOC_WM8903 is not set
> # CONFIG_SND_SOC_WM8904 is not set
> # CONFIG_SND_SOC_WM8960 is not set
> # CONFIG_SND_SOC_WM8962 is not set
> # CONFIG_SND_SOC_WM8974 is not set
> # CONFIG_SND_SOC_WM8978 is not set
> # CONFIG_SND_SOC_WM8985 is not set
> # CONFIG_SND_SOC_ZX_AUD96P22 is not set
> # CONFIG_SND_SOC_MAX9759 is not set
> # CONFIG_SND_SOC_MT6351 is not set
> # CONFIG_SND_SOC_MT6358 is not set
> # CONFIG_SND_SOC_MT6660 is not set
> # CONFIG_SND_SOC_NAU8540 is not set
> # CONFIG_SND_SOC_NAU8810 is not set
> # CONFIG_SND_SOC_NAU8822 is not set
> # CONFIG_SND_SOC_NAU8824 is not set
> # CONFIG_SND_SOC_TPA6130A2 is not set
> # end of CODEC drivers
> 
> CONFIG_SND_SIMPLE_CARD_UTILS=y
> CONFIG_SND_SIMPLE_CARD=y
> CONFIG_SND_X86=y
> # CONFIG_HDMI_LPE_AUDIO is not set
> # CONFIG_SND_XEN_FRONTEND is not set
> CONFIG_AC97_BUS=y
> 
> #
> # HID support
> #
> CONFIG_HID=y
> # CONFIG_HID_BATTERY_STRENGTH is not set
> CONFIG_HIDRAW=y
> # CONFIG_UHID is not set
> CONFIG_HID_GENERIC=y
> 
> #
> # Special HID drivers
> #
> # CONFIG_HID_A4TECH is not set
> # CONFIG_HID_ACCUTOUCH is not set
> # CONFIG_HID_ACRUX is not set
> CONFIG_HID_APPLE=y
> # CONFIG_HID_APPLEIR is not set
> # CONFIG_HID_ASUS is not set
> # CONFIG_HID_AUREAL is not set
> # CONFIG_HID_BELKIN is not set
> # CONFIG_HID_BETOP_FF is not set
> # CONFIG_HID_BIGBEN_FF is not set
> # CONFIG_HID_CHERRY is not set
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> # CONFIG_HID_PRODIKEYS is not set
> # CONFIG_HID_CMEDIA is not set
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> # CONFIG_HID_CYPRESS is not set
> # CONFIG_HID_DRAGONRISE is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELAN is not set
> # CONFIG_HID_ELECOM is not set
> # CONFIG_HID_ELO is not set
> # CONFIG_HID_EZKEY is not set
> # CONFIG_HID_GEMBIRD is not set
> # CONFIG_HID_GFRM is not set
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_GT683R is not set
> # CONFIG_HID_KEYTOUCH is not set
> # CONFIG_HID_KYE is not set
> # CONFIG_HID_UCLOGIC is not set
> # CONFIG_HID_WALTOP is not set
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_GYRATION is not set
> # CONFIG_HID_ICADE is not set
> # CONFIG_HID_ITE is not set
> # CONFIG_HID_JABRA is not set
> # CONFIG_HID_TWINHAN is not set
> # CONFIG_HID_KENSINGTON is not set
> # CONFIG_HID_LCPOWER is not set
> # CONFIG_HID_LED is not set
> # CONFIG_HID_LENOVO is not set
> # CONFIG_HID_LOGITECH is not set
> # CONFIG_HID_MAGICMOUSE is not set
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_REDRAGON is not set
> # CONFIG_HID_MICROSOFT is not set
> # CONFIG_HID_MONTEREY is not set
> # CONFIG_HID_MULTITOUCH is not set
> # CONFIG_HID_NTI is not set
> # CONFIG_HID_NTRIG is not set
> # CONFIG_HID_ORTEK is not set
> # CONFIG_HID_PANTHERLORD is not set
> # CONFIG_HID_PENMOUNT is not set
> # CONFIG_HID_PETALYNX is not set
> # CONFIG_HID_PICOLCD is not set
> # CONFIG_HID_PLANTRONICS is not set
> # CONFIG_HID_PRIMAX is not set
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> # CONFIG_HID_SAITEK is not set
> # CONFIG_HID_SAMSUNG is not set
> # CONFIG_HID_SONY is not set
> # CONFIG_HID_SPEEDLINK is not set
> # CONFIG_HID_STEAM is not set
> # CONFIG_HID_STEELSERIES is not set
> # CONFIG_HID_SUNPLUS is not set
> # CONFIG_HID_RMI is not set
> # CONFIG_HID_GREENASIA is not set
> CONFIG_HID_HYPERV_MOUSE=y
> # CONFIG_HID_SMARTJOYPLUS is not set
> # CONFIG_HID_TIVO is not set
> # CONFIG_HID_TOPSEED is not set
> # CONFIG_HID_THINGM is not set
> # CONFIG_HID_THRUSTMASTER is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> # CONFIG_HID_WACOM is not set
> # CONFIG_HID_WIIMOTE is not set
> # CONFIG_HID_XINMO is not set
> # CONFIG_HID_ZEROPLUS is not set
> # CONFIG_HID_ZYDACRON is not set
> # CONFIG_HID_SENSOR_HUB is not set
> # CONFIG_HID_ALPS is not set
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
> 
> #
> # USB HID support
> #
> CONFIG_USB_HID=m
> # CONFIG_HID_PID is not set
> CONFIG_USB_HIDDEV=y
> 
> #
> # USB HID Boot Protocol drivers
> #
> # CONFIG_USB_KBD is not set
> # CONFIG_USB_MOUSE is not set
> # end of USB HID Boot Protocol drivers
> # end of USB HID support
> 
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID is not set
> # end of I2C HID support
> 
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=m
> CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER=m
> # end of Intel ISH HID support
> # end of HID support
> 
> CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> CONFIG_USB_SUPPORT=y
> CONFIG_USB_COMMON=y
> CONFIG_USB_LED_TRIG=y
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=y
> CONFIG_USB=y
> CONFIG_USB_PCI=y
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=y
> 
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=y
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_WHITELIST is not set
> # CONFIG_USB_OTG_BLACKLIST_HUB is not set
> # CONFIG_USB_LEDS_TRIGGER_USBPORT is not set
> CONFIG_USB_AUTOSUSPEND_DELAY=2
> # CONFIG_USB_MON is not set
> 
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=y
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PCI=y
> CONFIG_USB_XHCI_PLATFORM=m
> CONFIG_USB_EHCI_HCD=y
> # CONFIG_USB_EHCI_ROOT_HUB_TT is not set
> # CONFIG_USB_EHCI_TT_NEWSCHED is not set
> CONFIG_USB_EHCI_PCI=y
> # CONFIG_USB_EHCI_FSL is not set
> CONFIG_USB_EHCI_HCD_PLATFORM=y
> # CONFIG_USB_OXU210HP_HCD is not set
> CONFIG_USB_ISP116X_HCD=m
> # CONFIG_USB_FOTG210_HCD is not set
> CONFIG_USB_OHCI_HCD=y
> CONFIG_USB_OHCI_HCD_PCI=y
> CONFIG_USB_OHCI_HCD_SSB=y
> CONFIG_USB_OHCI_HCD_PLATFORM=y
> CONFIG_USB_UHCI_HCD=y
> CONFIG_USB_SL811_HCD=m
> # CONFIG_USB_SL811_HCD_ISO is not set
> CONFIG_USB_R8A66597_HCD=m
> # CONFIG_USB_HCD_BCMA is not set
> CONFIG_USB_HCD_SSB=y
> # CONFIG_USB_HCD_TEST_MODE is not set
> 
> #
> # USB Device Class drivers
> #
> CONFIG_USB_ACM=m
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
> 
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
> 
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=y
> # CONFIG_USB_STORAGE_DEBUG is not set
> CONFIG_USB_STORAGE_REALTEK=y
> # CONFIG_REALTEK_AUTOPM is not set
> CONFIG_USB_STORAGE_DATAFAB=m
> CONFIG_USB_STORAGE_FREECOM=m
> CONFIG_USB_STORAGE_ISD200=m
> CONFIG_USB_STORAGE_USBAT=m
> CONFIG_USB_STORAGE_SDDR09=m
> CONFIG_USB_STORAGE_SDDR55=m
> CONFIG_USB_STORAGE_JUMPSHOT=m
> CONFIG_USB_STORAGE_ALAUDA=m
> # CONFIG_USB_STORAGE_ONETOUCH is not set
> # CONFIG_USB_STORAGE_KARMA is not set
> CONFIG_USB_STORAGE_CYPRESS_ATACB=m
> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
> CONFIG_USB_UAS=m
> 
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_CDNS3 is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
> 
> #
> # USB port drivers
> #
> CONFIG_USB_SERIAL=m
> CONFIG_USB_SERIAL_GENERIC=y
> # CONFIG_USB_SERIAL_SIMPLE is not set
> CONFIG_USB_SERIAL_AIRCABLE=m
> CONFIG_USB_SERIAL_ARK3116=m
> # CONFIG_USB_SERIAL_BELKIN is not set
> CONFIG_USB_SERIAL_CH341=m
> CONFIG_USB_SERIAL_WHITEHEAT=m
> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> # CONFIG_USB_SERIAL_CP210X is not set
> # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
> # CONFIG_USB_SERIAL_EMPEG is not set
> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> # CONFIG_USB_SERIAL_VISOR is not set
> # CONFIG_USB_SERIAL_IPAQ is not set
> # CONFIG_USB_SERIAL_IR is not set
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> # CONFIG_USB_SERIAL_F81232 is not set
> # CONFIG_USB_SERIAL_F8153X is not set
> # CONFIG_USB_SERIAL_GARMIN is not set
> CONFIG_USB_SERIAL_IPW=m
> # CONFIG_USB_SERIAL_IUU is not set
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> # CONFIG_USB_SERIAL_KLSI is not set
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> # CONFIG_USB_SERIAL_MCT_U232 is not set
> # CONFIG_USB_SERIAL_METRO is not set
> CONFIG_USB_SERIAL_MOS7720=m
> CONFIG_USB_SERIAL_MOS7840=m
> # CONFIG_USB_SERIAL_MXUPORT is not set
> CONFIG_USB_SERIAL_NAVMAN=m
> # CONFIG_USB_SERIAL_PL2303 is not set
> CONFIG_USB_SERIAL_OTI6858=m
> # CONFIG_USB_SERIAL_QCAUX is not set
> # CONFIG_USB_SERIAL_QUALCOMM is not set
> # CONFIG_USB_SERIAL_SPCP8X5 is not set
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> # CONFIG_USB_SERIAL_SYMBOL is not set
> # CONFIG_USB_SERIAL_TI is not set
> # CONFIG_USB_SERIAL_CYBERJACK is not set
> # CONFIG_USB_SERIAL_XIRCOM is not set
> CONFIG_USB_SERIAL_WWAN=m
> CONFIG_USB_SERIAL_OPTION=m
> CONFIG_USB_SERIAL_OMNINET=m
> # CONFIG_USB_SERIAL_OPTICON is not set
> # CONFIG_USB_SERIAL_XSENS_MT is not set
> # CONFIG_USB_SERIAL_WISHBONE is not set
> # CONFIG_USB_SERIAL_SSU100 is not set
> # CONFIG_USB_SERIAL_QT2 is not set
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> # CONFIG_USB_SERIAL_DEBUG is not set
> 
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> CONFIG_USB_EZUSB_FX2=m
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> 
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
> 
> # CONFIG_USB_GADGET is not set
> # CONFIG_TYPEC is not set
> # CONFIG_USB_ROLE_SWITCH is not set
> CONFIG_MMC=m
> CONFIG_MMC_BLOCK=m
> CONFIG_MMC_BLOCK_MINORS=8
> CONFIG_SDIO_UART=m
> # CONFIG_MMC_TEST is not set
> 
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=m
> CONFIG_MMC_SDHCI_IO_ACCESSORS=y
> CONFIG_MMC_SDHCI_PCI=m
> CONFIG_MMC_RICOH_MMC=y
> CONFIG_MMC_SDHCI_ACPI=m
> CONFIG_MMC_SDHCI_PLTFM=m
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> CONFIG_MMC_WBSD=m
> CONFIG_MMC_TIFM_SD=m
> CONFIG_MMC_CB710=m
> CONFIG_MMC_VIA_SDMMC=m
> CONFIG_MMC_VUB300=m
> CONFIG_MMC_USHC=m
> CONFIG_MMC_USDHI6ROL0=m
> CONFIG_MMC_CQHCI=m
> # CONFIG_MMC_HSQ is not set
> CONFIG_MMC_TOSHIBA_PCI=m
> CONFIG_MMC_MTK=m
> # CONFIG_MMC_SDHCI_XENON is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=y
> CONFIG_LEDS_CLASS=m
> CONFIG_LEDS_CLASS_FLASH=m
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
> 
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> # CONFIG_LEDS_AS3645A is not set
> # CONFIG_LEDS_LM3530 is not set
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_LM3601X is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> # CONFIG_LEDS_LP3944 is not set
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP5521 is not set
> # CONFIG_LEDS_LP5523 is not set
> # CONFIG_LEDS_LP5562 is not set
> # CONFIG_LEDS_LP8501 is not set
> # CONFIG_LEDS_CLEVO_MAIL is not set
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_REGULATOR is not set
> # CONFIG_LEDS_BD2802 is not set
> # CONFIG_LEDS_INTEL_SS4200 is not set
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
> 
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
> #
> # CONFIG_LEDS_BLINKM is not set
> # CONFIG_LEDS_MLXCPLD is not set
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
> 
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=y
> CONFIG_LEDS_TRIGGER_TIMER=m
> # CONFIG_LEDS_TRIGGER_ONESHOT is not set
> # CONFIG_LEDS_TRIGGER_DISK is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=m
> # CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> # CONFIG_LEDS_TRIGGER_GPIO is not set
> # CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
> 
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> # CONFIG_LEDS_TRIGGER_TRANSIENT is not set
> # CONFIG_LEDS_TRIGGER_CAMERA is not set
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> # CONFIG_LEDS_TRIGGER_AUDIO is not set
> # CONFIG_ACCESSIBILITY is not set
> # CONFIG_INFINIBAND is not set
> CONFIG_EDAC_ATOMIC_SCRUB=y
> CONFIG_EDAC_SUPPORT=y
> # CONFIG_EDAC is not set
> CONFIG_RTC_LIB=y
> CONFIG_RTC_MC146818_LIB=y
> CONFIG_RTC_CLASS=y
> # CONFIG_RTC_HCTOSYS is not set
> CONFIG_RTC_SYSTOHC=y
> CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_NVMEM=y
> 
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=y
> CONFIG_RTC_INTF_PROC=y
> CONFIG_RTC_INTF_DEV=y
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
> 
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> # CONFIG_RTC_DRV_DS1307 is not set
> CONFIG_RTC_DRV_DS1374=m
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> # CONFIG_RTC_DRV_DS1672 is not set
> CONFIG_RTC_DRV_MAX6900=m
> # CONFIG_RTC_DRV_RS5C372 is not set
> # CONFIG_RTC_DRV_ISL1208 is not set
> # CONFIG_RTC_DRV_ISL12022 is not set
> # CONFIG_RTC_DRV_X1205 is not set
> # CONFIG_RTC_DRV_PCF8523 is not set
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> # CONFIG_RTC_DRV_PCF8563 is not set
> # CONFIG_RTC_DRV_PCF8583 is not set
> CONFIG_RTC_DRV_M41T80=m
> CONFIG_RTC_DRV_M41T80_WDT=y
> # CONFIG_RTC_DRV_BQ32K is not set
> # CONFIG_RTC_DRV_S35390A is not set
> # CONFIG_RTC_DRV_FM3130 is not set
> # CONFIG_RTC_DRV_RX8010 is not set
> # CONFIG_RTC_DRV_RX8581 is not set
> # CONFIG_RTC_DRV_RX8025 is not set
> # CONFIG_RTC_DRV_EM3027 is not set
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
> 
> #
> # SPI RTC drivers
> #
> CONFIG_RTC_I2C_AND_SPI=y
> 
> #
> # SPI and I2C RTC drivers
> #
> # CONFIG_RTC_DRV_DS3232 is not set
> # CONFIG_RTC_DRV_PCF2127 is not set
> # CONFIG_RTC_DRV_RV3029C2 is not set
> 
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=m
> # CONFIG_RTC_DRV_DS1286 is not set
> # CONFIG_RTC_DRV_DS1511 is not set
> CONFIG_RTC_DRV_DS1553=m
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=m
> # CONFIG_RTC_DRV_DS2404 is not set
> CONFIG_RTC_DRV_STK17TA8=m
> CONFIG_RTC_DRV_M48T86=m
> # CONFIG_RTC_DRV_M48T35 is not set
> CONFIG_RTC_DRV_M48T59=m
> # CONFIG_RTC_DRV_MSM6242 is not set
> # CONFIG_RTC_DRV_BQ4802 is not set
> # CONFIG_RTC_DRV_RP5C01 is not set
> CONFIG_RTC_DRV_V3020=m
> 
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
> 
> #
> # HID Sensor RTC drivers
> #
> CONFIG_DMADEVICES=y
> # CONFIG_DMADEVICES_DEBUG is not set
> 
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=y
> CONFIG_DMA_VIRTUAL_CHANNELS=y
> CONFIG_DMA_ACPI=y
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=m
> # CONFIG_INTEL_IDXD is not set
> CONFIG_INTEL_IOATDMA=m
> # CONFIG_PLX_DMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=y
> # CONFIG_DW_DMAC is not set
> # CONFIG_DW_DMAC_PCI is not set
> # CONFIG_DW_EDMA is not set
> # CONFIG_DW_EDMA_PCIE is not set
> CONFIG_HSU_DMA=y
> # CONFIG_SF_PDMA is not set
> 
> #
> # DMA Clients
> #
> # CONFIG_ASYNC_TX_DMA is not set
> # CONFIG_DMATEST is not set
> CONFIG_DMA_ENGINE_RAID=y
> 
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=y
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> # end of DMABUF options
> 
> CONFIG_DCA=m
> CONFIG_AUXDISPLAY=y
> # CONFIG_HD44780 is not set
> # CONFIG_IMG_ASCII_LCD is not set
> # CONFIG_CHARLCD_BL_OFF is not set
> # CONFIG_CHARLCD_BL_ON is not set
> CONFIG_CHARLCD_BL_FLASH=y
> CONFIG_UIO=y
> # CONFIG_UIO_CIF is not set
> # CONFIG_UIO_PDRV_GENIRQ is not set
> # CONFIG_UIO_DMEM_GENIRQ is not set
> # CONFIG_UIO_AEC is not set
> # CONFIG_UIO_SERCOS3 is not set
> CONFIG_UIO_PCI_GENERIC=m
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_PRUSS is not set
> # CONFIG_UIO_MF624 is not set
> # CONFIG_UIO_HV_GENERIC is not set
> # CONFIG_VFIO is not set
> CONFIG_VIRT_DRIVERS=y
> CONFIG_VBOXGUEST=m
> CONFIG_VIRTIO=y
> CONFIG_VIRTIO_MENU=y
> CONFIG_VIRTIO_PCI=y
> CONFIG_VIRTIO_PCI_LEGACY=y
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=y
> CONFIG_VIRTIO_INPUT=m
> CONFIG_VIRTIO_MMIO=y
> CONFIG_VIRTIO_MMIO_CMDLINE_DEVICES=y
> # CONFIG_VDPA is not set
> CONFIG_VHOST_DPN=y
> CONFIG_VHOST_MENU=y
> # CONFIG_VHOST_NET is not set
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
> 
> #
> # Microsoft Hyper-V guest support
> #
> CONFIG_HYPERV=y
> CONFIG_HYPERV_TIMER=y
> CONFIG_HYPERV_UTILS=y
> CONFIG_HYPERV_BALLOON=y
> # end of Microsoft Hyper-V guest support
> 
> #
> # Xen driver support
> #
> CONFIG_XEN_BALLOON=y
> CONFIG_XEN_SCRUB_PAGES_DEFAULT=y
> CONFIG_XEN_DEV_EVTCHN=y
> CONFIG_XEN_BACKEND=y
> CONFIG_XENFS=y
> CONFIG_XEN_COMPAT_XENFS=y
> CONFIG_XEN_SYS_HYPERVISOR=y
> CONFIG_XEN_XENBUS_FRONTEND=y
> CONFIG_XEN_GNTDEV=m
> CONFIG_XEN_GRANT_DEV_ALLOC=m
> # CONFIG_XEN_GRANT_DMA_ALLOC is not set
> CONFIG_SWIOTLB_XEN=y
> CONFIG_XEN_PCIDEV_BACKEND=m
> # CONFIG_XEN_PVCALLS_FRONTEND is not set
> # CONFIG_XEN_PVCALLS_BACKEND is not set
> CONFIG_XEN_PRIVCMD=y
> CONFIG_XEN_ACPI_PROCESSOR=m
> # CONFIG_XEN_MCE_LOG is not set
> CONFIG_XEN_HAVE_PVMMU=y
> CONFIG_XEN_EFI=y
> CONFIG_XEN_AUTO_XLATE=y
> CONFIG_XEN_ACPI=y
> CONFIG_XEN_SYMS=y
> CONFIG_XEN_HAVE_VPMU=y
> # end of Xen driver support
> 
> # CONFIG_GREYBUS is not set
> # CONFIG_STAGING is not set
> # CONFIG_X86_PLATFORM_DEVICES is not set
> CONFIG_PMC_ATOM=y
> # CONFIG_MFD_CROS_EC is not set
> # CONFIG_CHROME_PLATFORMS is not set
> # CONFIG_MELLANOX_PLATFORM is not set
> CONFIG_CLKDEV_LOOKUP=y
> CONFIG_HAVE_CLK_PREPARE=y
> CONFIG_COMMON_CLK=y
> 
> #
> # Common Clock Framework
> #
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # end of Common Clock Framework
> 
> # CONFIG_HWSPINLOCK is not set
> 
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=y
> CONFIG_I8253_LOCK=y
> CONFIG_CLKBLD_I8253=y
> # end of Clock Source drivers
> 
> CONFIG_MAILBOX=y
> CONFIG_PCC=y
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=m
> CONFIG_IOMMU_API=y
> CONFIG_IOMMU_SUPPORT=y
> 
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
> 
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> # CONFIG_AMD_IOMMU is not set
> # CONFIG_INTEL_IOMMU is not set
> # CONFIG_IRQ_REMAP is not set
> CONFIG_HYPERV_IOMMU=y
> 
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
> 
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
> 
> # CONFIG_SOUNDWIRE is not set
> 
> #
> # SOC (System On Chip) specific Drivers
> #
> 
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
> 
> #
> # Aspeed SoC drivers
> #
> # end of Aspeed SoC drivers
> 
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
> 
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
> 
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
> 
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
> 
> # CONFIG_SOC_TI is not set
> 
> #
> # Xilinx SoC drivers
> #
> # CONFIG_XILINX_VCU is not set
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
> 
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> # CONFIG_NTB is not set
> # CONFIG_VME_BUS is not set
> # CONFIG_PWM is not set
> 
> #
> # IRQ chip support
> #
> # end of IRQ chip support
> 
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
> 
> #
> # PHY Subsystem
> #
> CONFIG_GENERIC_PHY=y
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_INTEL_EMMC is not set
> # end of PHY Subsystem
> 
> # CONFIG_POWERCAP is not set
> # CONFIG_MCB is not set
> 
> #
> # Performance monitor support
> #
> # end of Performance monitor support
> 
> CONFIG_RAS=y
> # CONFIG_USB4 is not set
> 
> #
> # Android
> #
> CONFIG_ANDROID=y
> # CONFIG_ANDROID_BINDER_IPC is not set
> # end of Android
> 
> CONFIG_LIBNVDIMM=y
> # CONFIG_BLK_DEV_PMEM is not set
> CONFIG_ND_BLK=y
> CONFIG_ND_CLAIM=y
> CONFIG_ND_BTT=y
> CONFIG_BTT=y
> CONFIG_NVDIMM_KEYS=y
> CONFIG_DAX=m
> # CONFIG_DEV_DAX is not set
> CONFIG_NVMEM=y
> CONFIG_NVMEM_SYSFS=y
> 
> #
> # HW tracing support
> #
> # CONFIG_STM is not set
> # CONFIG_INTEL_TH is not set
> # end of HW tracing support
> 
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> # CONFIG_UNISYS_VISORBUS is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # end of Device Drivers
> 
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=y
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=y
> # CONFIG_EXT2_FS is not set
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=y
> CONFIG_EXT4_USE_FOR_EXT2=y
> CONFIG_EXT4_FS_POSIX_ACL=y
> CONFIG_EXT4_FS_SECURITY=y
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_JBD2=y
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=y
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> # CONFIG_XFS_FS is not set
> # CONFIG_GFS2_FS is not set
> # CONFIG_OCFS2_FS is not set
> CONFIG_BTRFS_FS=m
> # CONFIG_BTRFS_FS_POSIX_ACL is not set
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> # CONFIG_NILFS2_FS is not set
> # CONFIG_F2FS_FS is not set
> # CONFIG_FS_DAX is not set
> CONFIG_FS_POSIX_ACL=y
> CONFIG_EXPORTFS=y
> # CONFIG_EXPORTFS_BLOCK_OPS is not set
> CONFIG_FILE_LOCKING=y
> CONFIG_MANDATORY_FILE_LOCKING=y
> CONFIG_FS_ENCRYPTION=y
> CONFIG_FS_ENCRYPTION_ALGS=y
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=y
> CONFIG_DNOTIFY=y
> CONFIG_INOTIFY_USER=y
> CONFIG_FANOTIFY=y
> CONFIG_QUOTA=y
> # CONFIG_QUOTA_NETLINK_INTERFACE is not set
> CONFIG_PRINT_QUOTA_WARNING=y
> # CONFIG_QUOTA_DEBUG is not set
> # CONFIG_QFMT_V1 is not set
> # CONFIG_QFMT_V2 is not set
> CONFIG_QUOTACTL=y
> CONFIG_QUOTACTL_COMPAT=y
> CONFIG_AUTOFS4_FS=y
> CONFIG_AUTOFS_FS=y
> CONFIG_FUSE_FS=y
> CONFIG_CUSE=y
> # CONFIG_VIRTIO_FS is not set
> CONFIG_OVERLAY_FS=y
> CONFIG_OVERLAY_FS_REDIRECT_DIR=y
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> CONFIG_OVERLAY_FS_METACOPY=y
> 
> #
> # Caches
> #
> CONFIG_FSCACHE=y
> CONFIG_FSCACHE_STATS=y
> # CONFIG_FSCACHE_HISTOGRAM is not set
> # CONFIG_FSCACHE_DEBUG is not set
> # CONFIG_FSCACHE_OBJECT_LIST is not set
> # CONFIG_CACHEFILES is not set
> # end of Caches
> 
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=y
> CONFIG_JOLIET=y
> CONFIG_ZISOFS=y
> CONFIG_UDF_FS=y
> # end of CD-ROM/DVD Filesystems
> 
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=y
> CONFIG_MSDOS_FS=y
> CONFIG_VFAT_FS=y
> CONFIG_FAT_DEFAULT_CODEPAGE=437
> CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> # CONFIG_EXFAT_FS is not set
> CONFIG_NTFS_FS=y
> # CONFIG_NTFS_DEBUG is not set
> CONFIG_NTFS_RW=y
> # end of DOS/FAT/EXFAT/NT Filesystems
> 
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=y
> CONFIG_PROC_KCORE=y
> CONFIG_PROC_VMCORE=y
> CONFIG_PROC_VMCORE_DEVICE_DUMP=y
> CONFIG_PROC_SYSCTL=y
> # CONFIG_PROC_PAGE_MONITOR is not set
> CONFIG_PROC_CHILDREN=y
> CONFIG_PROC_PID_ARCH_STATUS=y
> CONFIG_KERNFS=y
> CONFIG_SYSFS=y
> CONFIG_TMPFS=y
> CONFIG_TMPFS_POSIX_ACL=y
> CONFIG_TMPFS_XATTR=y
> CONFIG_HUGETLBFS=y
> CONFIG_HUGETLB_PAGE=y
> CONFIG_MEMFD_CREATE=y
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=y
> CONFIG_CONFIGFS_FS=y
> CONFIG_EFIVAR_FS=y
> # end of Pseudo filesystems
> 
> CONFIG_MISC_FILESYSTEMS=y
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> # CONFIG_CRAMFS is not set
> CONFIG_SQUASHFS=y
> CONFIG_SQUASHFS_FILE_CACHE=y
> # CONFIG_SQUASHFS_FILE_DIRECT is not set
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> CONFIG_SQUASHFS_DECOMP_MULTI=y
> # CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU is not set
> CONFIG_SQUASHFS_XATTR=y
> CONFIG_SQUASHFS_ZLIB=y
> CONFIG_SQUASHFS_LZ4=y
> CONFIG_SQUASHFS_LZO=y
> CONFIG_SQUASHFS_XZ=y
> # CONFIG_SQUASHFS_ZSTD is not set
> CONFIG_SQUASHFS_4K_DEVBLK_SIZE=y
> CONFIG_SQUASHFS_EMBEDDED=y
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
> # CONFIG_VXFS_FS is not set
> # CONFIG_MINIX_FS is not set
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> # CONFIG_PSTORE is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> # CONFIG_VBOXSF_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=y
> CONFIG_NFS_FS=m
> CONFIG_NFS_V2=m
> CONFIG_NFS_V3=m
> CONFIG_NFS_V3_ACL=y
> CONFIG_NFS_V4=m
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=y
> CONFIG_NFS_V4_2=y
> CONFIG_PNFS_FILE_LAYOUT=m
> CONFIG_PNFS_BLOCK=m
> CONFIG_PNFS_FLEXFILE_LAYOUT=m
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN="kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_FSCACHE=y
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=y
> CONFIG_NFS_DISABLE_UDP_SUPPORT=y
> # CONFIG_NFSD is not set
> CONFIG_GRACE_PERIOD=m
> CONFIG_LOCKD=m
> CONFIG_LOCKD_V4=y
> CONFIG_NFS_ACL_SUPPORT=m
> CONFIG_NFS_COMMON=y
> CONFIG_SUNRPC=m
> CONFIG_SUNRPC_GSS=m
> CONFIG_SUNRPC_BACKCHANNEL=y
> CONFIG_RPCSEC_GSS_KRB5=m
> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> # CONFIG_SUNRPC_DEBUG is not set
> # CONFIG_CEPH_FS is not set
> CONFIG_CIFS=m
> # CONFIG_CIFS_STATS2 is not set
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=y
> CONFIG_CIFS_WEAK_PW_HASH=y
> # CONFIG_CIFS_UPCALL is not set
> CONFIG_CIFS_XATTR=y
> CONFIG_CIFS_POSIX=y
> CONFIG_CIFS_DEBUG=y
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> # CONFIG_CIFS_DFS_UPCALL is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_NLS=y
> CONFIG_NLS_DEFAULT="iso8859-1"
> CONFIG_NLS_CODEPAGE_437=y
> # CONFIG_NLS_CODEPAGE_737 is not set
> # CONFIG_NLS_CODEPAGE_775 is not set
> # CONFIG_NLS_CODEPAGE_850 is not set
> # CONFIG_NLS_CODEPAGE_852 is not set
> # CONFIG_NLS_CODEPAGE_855 is not set
> # CONFIG_NLS_CODEPAGE_857 is not set
> # CONFIG_NLS_CODEPAGE_860 is not set
> # CONFIG_NLS_CODEPAGE_861 is not set
> # CONFIG_NLS_CODEPAGE_862 is not set
> # CONFIG_NLS_CODEPAGE_863 is not set
> # CONFIG_NLS_CODEPAGE_864 is not set
> # CONFIG_NLS_CODEPAGE_865 is not set
> # CONFIG_NLS_CODEPAGE_866 is not set
> # CONFIG_NLS_CODEPAGE_869 is not set
> # CONFIG_NLS_CODEPAGE_936 is not set
> # CONFIG_NLS_CODEPAGE_950 is not set
> # CONFIG_NLS_CODEPAGE_932 is not set
> # CONFIG_NLS_CODEPAGE_949 is not set
> # CONFIG_NLS_CODEPAGE_874 is not set
> # CONFIG_NLS_ISO8859_8 is not set
> # CONFIG_NLS_CODEPAGE_1250 is not set
> # CONFIG_NLS_CODEPAGE_1251 is not set
> # CONFIG_NLS_ASCII is not set
> CONFIG_NLS_ISO8859_1=y
> # CONFIG_NLS_ISO8859_2 is not set
> # CONFIG_NLS_ISO8859_3 is not set
> # CONFIG_NLS_ISO8859_4 is not set
> # CONFIG_NLS_ISO8859_5 is not set
> # CONFIG_NLS_ISO8859_6 is not set
> # CONFIG_NLS_ISO8859_7 is not set
> # CONFIG_NLS_ISO8859_9 is not set
> # CONFIG_NLS_ISO8859_13 is not set
> # CONFIG_NLS_ISO8859_14 is not set
> # CONFIG_NLS_ISO8859_15 is not set
> # CONFIG_NLS_KOI8_R is not set
> # CONFIG_NLS_KOI8_U is not set
> # CONFIG_NLS_MAC_ROMAN is not set
> # CONFIG_NLS_MAC_CELTIC is not set
> # CONFIG_NLS_MAC_CENTEURO is not set
> # CONFIG_NLS_MAC_CROATIAN is not set
> # CONFIG_NLS_MAC_CYRILLIC is not set
> # CONFIG_NLS_MAC_GAELIC is not set
> # CONFIG_NLS_MAC_GREEK is not set
> # CONFIG_NLS_MAC_ICELAND is not set
> # CONFIG_NLS_MAC_INUIT is not set
> # CONFIG_NLS_MAC_ROMANIAN is not set
> # CONFIG_NLS_MAC_TURKISH is not set
> CONFIG_NLS_UTF8=y
> CONFIG_DLM=y
> # CONFIG_DLM_DEBUG is not set
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=y
> # end of File systems
> 
> #
> # Security options
> #
> CONFIG_KEYS=y
> # CONFIG_KEYS_REQUEST_CACHE is not set
> # CONFIG_PERSISTENT_KEYRINGS is not set
> # CONFIG_BIG_KEYS is not set
> CONFIG_ENCRYPTED_KEYS=y
> # CONFIG_KEY_DH_OPERATIONS is not set
> CONFIG_SECURITY_DMESG_RESTRICT=y
> # CONFIG_SECURITY is not set
> # CONFIG_SECURITYFS is not set
> CONFIG_PAGE_TABLE_ISOLATION=y
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=y
> CONFIG_HARDENED_USERCOPY=y
> CONFIG_HARDENED_USERCOPY_FALLBACK=y
> CONFIG_HARDENED_USERCOPY_PAGESPAN=y
> # CONFIG_FORTIFY_SOURCE is not set
> # CONFIG_STATIC_USERMODEHELPER is not set
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> CONFIG_DEFAULT_SECURITY_DAC=y
> CONFIG_LSM="lockdown,yama,loadpin,safesetid,integrity"
> 
> #
> # Kernel hardening options
> #
> 
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=y
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_USER is not set
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF is not set
> # CONFIG_GCC_PLUGIN_STRUCTLEAK_BYREF_ALL is not set
> # CONFIG_GCC_PLUGIN_STACKLEAK is not set
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
> 
> CONFIG_XOR_BLOCKS=m
> CONFIG_ASYNC_CORE=m
> CONFIG_ASYNC_MEMCPY=m
> CONFIG_ASYNC_XOR=m
> CONFIG_ASYNC_PQ=m
> CONFIG_ASYNC_RAID6_RECOV=m
> CONFIG_CRYPTO=y
> 
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=y
> CONFIG_CRYPTO_ALGAPI2=y
> CONFIG_CRYPTO_AEAD=y
> CONFIG_CRYPTO_AEAD2=y
> CONFIG_CRYPTO_SKCIPHER=y
> CONFIG_CRYPTO_SKCIPHER2=y
> CONFIG_CRYPTO_HASH=y
> CONFIG_CRYPTO_HASH2=y
> CONFIG_CRYPTO_RNG=y
> CONFIG_CRYPTO_RNG2=y
> CONFIG_CRYPTO_RNG_DEFAULT=y
> CONFIG_CRYPTO_AKCIPHER2=y
> CONFIG_CRYPTO_KPP2=y
> CONFIG_CRYPTO_ACOMP2=y
> CONFIG_CRYPTO_MANAGER=y
> CONFIG_CRYPTO_MANAGER2=y
> # CONFIG_CRYPTO_USER is not set
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
> CONFIG_CRYPTO_GF128MUL=y
> CONFIG_CRYPTO_NULL=y
> CONFIG_CRYPTO_NULL2=y
> # CONFIG_CRYPTO_PCRYPT is not set
> CONFIG_CRYPTO_CRYPTD=m
> CONFIG_CRYPTO_AUTHENC=m
> # CONFIG_CRYPTO_TEST is not set
> CONFIG_CRYPTO_ENGINE=m
> 
> #
> # Public-key cryptography
> #
> # CONFIG_CRYPTO_RSA is not set
> # CONFIG_CRYPTO_DH is not set
> # CONFIG_CRYPTO_ECDH is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
> 
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=y
> CONFIG_CRYPTO_GCM=y
> # CONFIG_CRYPTO_CHACHA20POLY1305 is not set
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_SEQIV=y
> CONFIG_CRYPTO_ECHAINIV=m
> 
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=y
> # CONFIG_CRYPTO_CFB is not set
> CONFIG_CRYPTO_CTR=y
> CONFIG_CRYPTO_CTS=y
> CONFIG_CRYPTO_ECB=y
> CONFIG_CRYPTO_LRW=m
> # CONFIG_CRYPTO_OFB is not set
> CONFIG_CRYPTO_PCBC=m
> CONFIG_CRYPTO_XTS=y
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_ESSIV=m
> 
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=y
> CONFIG_CRYPTO_HMAC=y
> CONFIG_CRYPTO_XCBC=m
> # CONFIG_CRYPTO_VMAC is not set
> 
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=y
> # CONFIG_CRYPTO_CRC32C_INTEL is not set
> # CONFIG_CRYPTO_CRC32 is not set
> # CONFIG_CRYPTO_CRC32_PCLMUL is not set
> CONFIG_CRYPTO_XXHASH=m
> CONFIG_CRYPTO_BLAKE2B=m
> # CONFIG_CRYPTO_BLAKE2S is not set
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> CONFIG_CRYPTO_CRCT10DIF=y
> # CONFIG_CRYPTO_CRCT10DIF_PCLMUL is not set
> CONFIG_CRYPTO_GHASH=y
> # CONFIG_CRYPTO_POLY1305 is not set
> # CONFIG_CRYPTO_POLY1305_X86_64 is not set
> CONFIG_CRYPTO_MD4=y
> CONFIG_CRYPTO_MD5=y
> CONFIG_CRYPTO_MICHAEL_MIC=m
> # CONFIG_CRYPTO_RMD128 is not set
> # CONFIG_CRYPTO_RMD160 is not set
> # CONFIG_CRYPTO_RMD256 is not set
> # CONFIG_CRYPTO_RMD320 is not set
> CONFIG_CRYPTO_SHA1=y
> # CONFIG_CRYPTO_SHA1_SSSE3 is not set
> # CONFIG_CRYPTO_SHA256_SSSE3 is not set
> # CONFIG_CRYPTO_SHA512_SSSE3 is not set
> CONFIG_CRYPTO_SHA256=y
> CONFIG_CRYPTO_SHA512=y
> # CONFIG_CRYPTO_SHA3 is not set
> # CONFIG_CRYPTO_SM3 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> # CONFIG_CRYPTO_TGR192 is not set
> # CONFIG_CRYPTO_WP512 is not set
> # CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL is not set
> 
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=y
> # CONFIG_CRYPTO_AES_TI is not set
> # CONFIG_CRYPTO_AES_NI_INTEL is not set
> # CONFIG_CRYPTO_ANUBIS is not set
> CONFIG_CRYPTO_ARC4=y
> CONFIG_CRYPTO_BLOWFISH=m
> CONFIG_CRYPTO_BLOWFISH_COMMON=m
> # CONFIG_CRYPTO_BLOWFISH_X86_64 is not set
> CONFIG_CRYPTO_CAMELLIA=m
> # CONFIG_CRYPTO_CAMELLIA_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_CAST_COMMON=m
> CONFIG_CRYPTO_CAST5=m
> # CONFIG_CRYPTO_CAST5_AVX_X86_64 is not set
> CONFIG_CRYPTO_CAST6=m
> # CONFIG_CRYPTO_CAST6_AVX_X86_64 is not set
> CONFIG_CRYPTO_DES=y
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> CONFIG_CRYPTO_FCRYPT=m
> # CONFIG_CRYPTO_KHAZAD is not set
> # CONFIG_CRYPTO_SALSA20 is not set
> # CONFIG_CRYPTO_CHACHA20 is not set
> # CONFIG_CRYPTO_CHACHA20_X86_64 is not set
> CONFIG_CRYPTO_SEED=m
> CONFIG_CRYPTO_SERPENT=m
> # CONFIG_CRYPTO_SERPENT_SSE2_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SERPENT_AVX2_X86_64 is not set
> # CONFIG_CRYPTO_SM4 is not set
> CONFIG_CRYPTO_TEA=m
> CONFIG_CRYPTO_TWOFISH=m
> CONFIG_CRYPTO_TWOFISH_COMMON=m
> CONFIG_CRYPTO_TWOFISH_X86_64=m
> # CONFIG_CRYPTO_TWOFISH_X86_64_3WAY is not set
> # CONFIG_CRYPTO_TWOFISH_AVX_X86_64 is not set
> 
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=m
> CONFIG_CRYPTO_LZO=m
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
> 
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=m
> CONFIG_CRYPTO_DRBG_MENU=y
> CONFIG_CRYPTO_DRBG_HMAC=y
> # CONFIG_CRYPTO_DRBG_HASH is not set
> # CONFIG_CRYPTO_DRBG_CTR is not set
> CONFIG_CRYPTO_DRBG=y
> CONFIG_CRYPTO_JITTERENTROPY=y
> CONFIG_CRYPTO_USER_API=y
> CONFIG_CRYPTO_USER_API_HASH=y
> # CONFIG_CRYPTO_USER_API_SKCIPHER is not set
> # CONFIG_CRYPTO_USER_API_RNG is not set
> # CONFIG_CRYPTO_USER_API_AEAD is not set
> 
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=y
> CONFIG_CRYPTO_LIB_ARC4=y
> # CONFIG_CRYPTO_LIB_BLAKE2S is not set
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=y
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=11
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA256=y
> CONFIG_CRYPTO_HW=y
> # CONFIG_CRYPTO_DEV_PADLOCK is not set
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> # CONFIG_CRYPTO_DEV_CCP is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCC is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXX is not set
> # CONFIG_CRYPTO_DEV_QAT_C62X is not set
> # CONFIG_CRYPTO_DEV_QAT_DH895xCCVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C3XXXVF is not set
> # CONFIG_CRYPTO_DEV_QAT_C62XVF is not set
> # CONFIG_CRYPTO_DEV_NITROX_CNN55XX is not set
> CONFIG_CRYPTO_DEV_VIRTIO=m
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> # CONFIG_ASYMMETRIC_KEY_TYPE is not set
> 
> #
> # Certificates for signature checking
> #
> # CONFIG_SYSTEM_BLACKLIST_KEYRING is not set
> # end of Certificates for signature checking
> 
> CONFIG_BINARY_PRINTF=y
> 
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=m
> CONFIG_RAID6_PQ_BENCHMARK=y
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=y
> CONFIG_GENERIC_STRNCPY_FROM_USER=y
> CONFIG_GENERIC_STRNLEN_USER=y
> CONFIG_GENERIC_NET_UTILS=y
> CONFIG_GENERIC_FIND_FIRST_BIT=y
> # CONFIG_CORDIC is not set
> CONFIG_RATIONAL=y
> CONFIG_GENERIC_PCI_IOMAP=y
> CONFIG_GENERIC_IOMAP=y
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=y
> CONFIG_CRC_CCITT=y
> CONFIG_CRC16=y
> CONFIG_CRC_T10DIF=y
> CONFIG_CRC_ITU_T=y
> CONFIG_CRC32=y
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=y
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=m
> CONFIG_LIBCRC32C=y
> # CONFIG_CRC8 is not set
> CONFIG_XXHASH=m
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=y
> CONFIG_ZLIB_DEFLATE=y
> CONFIG_LZO_COMPRESS=m
> CONFIG_LZO_DECOMPRESS=y
> CONFIG_LZ4_DECOMPRESS=y
> CONFIG_ZSTD_COMPRESS=m
> CONFIG_ZSTD_DECOMPRESS=m
> CONFIG_XZ_DEC=y
> CONFIG_XZ_DEC_X86=y
> CONFIG_XZ_DEC_POWERPC=y
> CONFIG_XZ_DEC_IA64=y
> CONFIG_XZ_DEC_ARM=y
> CONFIG_XZ_DEC_ARMTHUMB=y
> CONFIG_XZ_DEC_SPARC=y
> CONFIG_XZ_DEC_BCJ=y
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=y
> CONFIG_DECOMPRESS_BZIP2=y
> CONFIG_DECOMPRESS_LZMA=y
> CONFIG_DECOMPRESS_XZ=y
> CONFIG_DECOMPRESS_LZO=y
> CONFIG_DECOMPRESS_LZ4=y
> CONFIG_GENERIC_ALLOCATOR=y
> CONFIG_TEXTSEARCH=y
> CONFIG_TEXTSEARCH_KMP=m
> CONFIG_TEXTSEARCH_BM=m
> CONFIG_TEXTSEARCH_FSM=m
> CONFIG_BTREE=y
> CONFIG_INTERVAL_TREE=y
> CONFIG_XARRAY_MULTI=y
> CONFIG_ASSOCIATIVE_ARRAY=y
> CONFIG_HAS_IOMEM=y
> CONFIG_HAS_IOPORT_MAP=y
> CONFIG_HAS_DMA=y
> CONFIG_NEED_SG_DMA_LENGTH=y
> CONFIG_NEED_DMA_MAP_STATE=y
> CONFIG_ARCH_DMA_ADDR_T_64BIT=y
> CONFIG_SWIOTLB=y
> CONFIG_DMA_CMA=y
> 
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=0
> CONFIG_CMA_SIZE_SEL_MBYTES=y
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=8
> # CONFIG_DMA_API_DEBUG is not set
> CONFIG_SGL_ALLOC=y
> CONFIG_IOMMU_HELPER=y
> CONFIG_CHECK_SIGNATURE=y
> CONFIG_CPU_RMAP=y
> CONFIG_DQL=y
> CONFIG_GLOB=y
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=y
> CONFIG_IRQ_POLL=y
> CONFIG_OID_REGISTRY=m
> CONFIG_UCS2_STRING=y
> CONFIG_HAVE_GENERIC_VDSO=y
> CONFIG_GENERIC_GETTIMEOFDAY=y
> CONFIG_GENERIC_VDSO_TIME_NS=y
> CONFIG_FONT_SUPPORT=y
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=y
> CONFIG_FONT_8x16=y
> CONFIG_SG_POOL=y
> CONFIG_ARCH_HAS_PMEM_API=y
> CONFIG_MEMREGION=y
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=y
> CONFIG_ARCH_HAS_UACCESS_MCSAFE=y
> CONFIG_ARCH_STACKWALK=y
> CONFIG_STACKDEPOT=y
> CONFIG_SBITMAP=y
> # CONFIG_STRING_SELFTEST is not set
> # end of Library routines
> 
> #
> # Kernel hacking
> #
> 
> #
> # printk and dmesg options
> #
> # CONFIG_PRINTK_TIME is not set
> # CONFIG_PRINTK_CALLER is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
> # CONFIG_BOOT_PRINTK_DELAY is not set
> # CONFIG_DYNAMIC_DEBUG is not set
> CONFIG_SYMBOLIC_ERRNAME=y
> CONFIG_DEBUG_BUGVERBOSE=y
> # end of printk and dmesg options
> 
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=y
> # CONFIG_DEBUG_INFO_REDUCED is not set
> CONFIG_DEBUG_INFO_SPLIT=y
> CONFIG_DEBUG_INFO_DWARF4=y
> CONFIG_GDB_SCRIPTS=y
> CONFIG_ENABLE_MUST_CHECK=y
> CONFIG_FRAME_WARN=2048
> # CONFIG_STRIP_ASM_SYMS is not set
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> # CONFIG_DEBUG_SECTION_MISMATCH is not set
> CONFIG_SECTION_MISMATCH_WARN_ONLY=y
> CONFIG_STACK_VALIDATION=y
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
> 
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=y
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x0
> CONFIG_MAGIC_SYSRQ_SERIAL=y
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=""
> CONFIG_DEBUG_FS=y
> CONFIG_HAVE_ARCH_KGDB=y
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> # CONFIG_UBSAN is not set
> # end of Generic Kernel Debugging Instruments
> 
> CONFIG_DEBUG_KERNEL=y
> CONFIG_DEBUG_MISC=y
> 
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=y
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_OWNER=y
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_GENERIC_PTDUMP=y
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_DEBUG_SLAB is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=y
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> CONFIG_SCHED_STACK_END_CHECK=y
> # CONFIG_DEBUG_VM is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=y
> # CONFIG_DEBUG_VIRTUAL is not set
> # CONFIG_DEBUG_MEMORY_INIT is not set
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> # CONFIG_KASAN is not set
> CONFIG_KASAN_STACK=1
> # end of Memory Debugging
> 
> # CONFIG_DEBUG_SHIRQ is not set
> 
> #
> # Debug Oops, Lockups and Hangs
> #
> # CONFIG_PANIC_ON_OOPS is not set
> CONFIG_PANIC_ON_OOPS_VALUE=0
> CONFIG_PANIC_TIMEOUT=10
> # CONFIG_SOFTLOCKUP_DETECTOR is not set
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=y
> # CONFIG_HARDLOCKUP_DETECTOR is not set
> # CONFIG_DETECT_HUNG_TASK is not set
> # CONFIG_WQ_WATCHDOG is not set
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
> 
> #
> # Scheduler Debugging
> #
> # CONFIG_SCHED_DEBUG is not set
> CONFIG_SCHED_INFO=y
> # CONFIG_SCHEDSTATS is not set
> # end of Scheduler Debugging
> 
> # CONFIG_DEBUG_TIMEKEEPING is not set
> 
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=y
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> CONFIG_DEBUG_MUTEXES=y
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> # CONFIG_DEBUG_ATOMIC_SLEEP is not set
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
> 
> CONFIG_STACKTRACE=y
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
> 
> #
> # Debug kernel data structures
> #
> # CONFIG_DEBUG_LIST is not set
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> # CONFIG_BUG_ON_DATA_CORRUPTION is not set
> # end of Debug kernel data structures
> 
> # CONFIG_DEBUG_CREDENTIALS is not set
> 
> #
> # RCU Debugging
> #
> # CONFIG_RCU_PERF_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_CPU_STALL_TIMEOUT=21
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
> 
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> # CONFIG_LATENCYTOP is not set
> CONFIG_USER_STACKTRACE_SUPPORT=y
> CONFIG_NOP_TRACER=y
> CONFIG_HAVE_FUNCTION_TRACER=y
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
> CONFIG_HAVE_DYNAMIC_FTRACE=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
> CONFIG_HAVE_FENTRY=y
> CONFIG_HAVE_C_RECORDMCOUNT=y
> CONFIG_TRACE_CLOCK=y
> CONFIG_RING_BUFFER=y
> CONFIG_EVENT_TRACING=y
> CONFIG_CONTEXT_SWITCH_TRACER=y
> CONFIG_TRACING=y
> CONFIG_GENERIC_TRACER=y
> CONFIG_TRACING_SUPPORT=y
> CONFIG_FTRACE=y
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=y
> CONFIG_FUNCTION_GRAPH_TRACER=y
> CONFIG_DYNAMIC_FTRACE=y
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=y
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=y
> # CONFIG_FUNCTION_PROFILER is not set
> # CONFIG_STACK_TRACER is not set
> # CONFIG_PREEMPTIRQ_EVENTS is not set
> # CONFIG_IRQSOFF_TRACER is not set
> # CONFIG_SCHED_TRACER is not set
> # CONFIG_HWLAT_TRACER is not set
> # CONFIG_MMIOTRACE is not set
> # CONFIG_FTRACE_SYSCALLS is not set
> # CONFIG_TRACER_SNAPSHOT is not set
> CONFIG_BRANCH_PROFILE_NONE=y
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> # CONFIG_PROFILE_ALL_BRANCHES is not set
> # CONFIG_BLK_DEV_IO_TRACE is not set
> CONFIG_UPROBE_EVENTS=y
> CONFIG_BPF_EVENTS=y
> CONFIG_DYNAMIC_EVENTS=y
> CONFIG_PROBE_EVENTS=y
> CONFIG_FTRACE_MCOUNT_RECORD=y
> # CONFIG_HIST_TRIGGERS is not set
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> # CONFIG_RING_BUFFER_BENCHMARK is not set
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_PROVIDE_OHCI1394_DMA_INIT is not set
> # CONFIG_SAMPLES is not set
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=y
> # CONFIG_STRICT_DEVMEM is not set
> 
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_SUPPORT=y
> # CONFIG_X86_VERBOSE_BOOTUP is not set
> # CONFIG_EARLY_PRINTK is not set
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_WX is not set
> CONFIG_DOUBLEFAULT=y
> # CONFIG_DEBUG_TLBFLUSH is not set
> # CONFIG_IOMMU_DEBUG is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=y
> # CONFIG_X86_DECODER_SELFTEST is not set
> CONFIG_IO_DELAY_0X80=y
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> # CONFIG_DEBUG_BOOT_PARAMS is not set
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=y
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
> 
> #
> # Kernel Testing and Coverage
> #
> # CONFIG_KUNIT is not set
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> # CONFIG_FAULT_INJECTION is not set
> CONFIG_ARCH_HAS_KCOV=y
> CONFIG_CC_HAS_SANCOV_TRACE_PC=y
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=y
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_SORT is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> # CONFIG_ATOMIC64_SELFTEST is not set
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_BITFIELD is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_HASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> # CONFIG_TEST_BPF is not set
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_STACKINIT is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_MEMTEST is not set
> # CONFIG_HYPERV_TESTING is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> [    0.000000] Linux version 5.7.0-rc6-x86_64 (root@BIT-testing) (gcc version 9.2.0 (Gentoo Hardened 9.2.0-r2 p3), GNU ld (Gentoo 2.33.1 p2) 2.33.1) #3 SMP Thu May 21 15:29:23 PDT 2020
> [    0.000000] Command line: BOOT_IMAGE=/boot/vmlinuz-5.7.0-rc6-x86_64 root=UUID=639936b7-5333-4744-a29d-f68da8a9b5b7 ro video=uvesafb:1280x1024-32,mtrr:3,ywrap quiet splash domdadm
> [    0.000000] KERNEL supported cpus:
> [    0.000000]   Intel GenuineIntel
> [    0.000000]   AMD AuthenticAMD
> [    0.000000]   Hygon HygonGenuine
> [    0.000000]   Centaur CentaurHauls
> [    0.000000]   zhaoxin   Shanghai  
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> [    0.000000] x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> [    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> [    0.000000] x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> [    0.000000] x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> [    0.000000] x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using 'compacted' format.
> [    0.000000] BIOS-provided physical RAM map:
> [    0.000000] BIOS-e820: [mem 0x0000000000000000-0x0000000000057fff] usable
> [    0.000000] BIOS-e820: [mem 0x0000000000058000-0x0000000000058fff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000059000-0x000000000009efff] usable
> [    0.000000] BIOS-e820: [mem 0x000000000009f000-0x00000000000fffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000000100000-0x00000000ab20afff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000ab20b000-0x00000000ab20bfff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000ab20c000-0x00000000ab20cfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ab20d000-0x00000000b9d32fff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000b9d33000-0x00000000ba084fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ba085000-0x00000000ba1fefff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000ba1ff000-0x00000000ba8e0fff] ACPI NVS
> [    0.000000] BIOS-e820: [mem 0x00000000ba8e1000-0x00000000bafacfff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000bafad000-0x00000000baffefff] type 20
> [    0.000000] BIOS-e820: [mem 0x00000000bafff000-0x00000000baffffff] usable
> [    0.000000] BIOS-e820: [mem 0x00000000bb000000-0x00000000bfffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000f0000000-0x00000000f7ffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fed00000-0x00000000fed00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> [    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> [    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000023dffffff] usable
> [    0.000000] NX (Execute Disable) protection: active
> [    0.000000] efi: EFI v2.50 by American Megatrends
> [    0.000000] efi:  TPMFinalLog=0xba8b1000  ACPI 2.0=0xba4ff000  ACPI=0xba4ff000  SMBIOS=0xbaed8000  SMBIOS 3.0=0xbaed7000  ESRT=0xb86a7158 
> [    0.000000] SMBIOS 3.0.0 present.
> [    0.000000] DMI: Gigabyte Technology Co., Ltd. Q170M-MK/Q170M-MK, BIOS F23 YX 05/31/2018
> [    0.000000] tsc: Detected 3400.000 MHz processor
> [    0.001240] tsc: Detected 3399.906 MHz TSC
> [    0.001240] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
> [    0.001241] e820: remove [mem 0x000a0000-0x000fffff] usable
> [    0.001246] last_pfn = 0x23e000 max_arch_pfn = 0x400000000
> [    0.001247] MTRR default type: write-back
> [    0.001248] MTRR fixed ranges enabled:
> [    0.001248]   00000-9FFFF write-back
> [    0.001249]   A0000-BFFFF uncachable
> [    0.001249]   C0000-FFFFF write-protect
> [    0.001250] MTRR variable ranges enabled:
> [    0.001251]   0 base 00C0000000 mask 7FC0000000 uncachable
> [    0.001251]   1 base 00BC000000 mask 7FFC000000 uncachable
> [    0.001251]   2 base 00BB800000 mask 7FFF800000 uncachable
> [    0.001252]   3 disabled
> [    0.001252]   4 disabled
> [    0.001252]   5 disabled
> [    0.001252]   6 disabled
> [    0.001253]   7 disabled
> [    0.001253]   8 disabled
> [    0.001253]   9 disabled
> [    0.001635] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT  
> [    0.001761] last_pfn = 0xbb000 max_arch_pfn = 0x400000000
> [    0.007124] found SMP MP-table at [mem 0x000fccc0-0x000fcccf]
> [    0.007133] esrt: Reserving ESRT space from 0x00000000b86a7158 to 0x00000000b86a7190.
> [    0.007137] e820: update [mem 0xb86a7000-0xb86a7fff] usable ==> reserved
> [    0.007145] Using GB pages for direct mapping
> [    0.007147] BRK [0x20a01000, 0x20a01fff] PGTABLE
> [    0.007148] BRK [0x20a02000, 0x20a02fff] PGTABLE
> [    0.007148] BRK [0x20a03000, 0x20a03fff] PGTABLE
> [    0.007159] BRK [0x20a04000, 0x20a04fff] PGTABLE
> [    0.007160] BRK [0x20a05000, 0x20a05fff] PGTABLE
> [    0.007226] BRK [0x20a06000, 0x20a06fff] PGTABLE
> [    0.007240] BRK [0x20a07000, 0x20a07fff] PGTABLE
> [    0.007245] BRK [0x20a08000, 0x20a08fff] PGTABLE
> [    0.007250] Secure boot could not be determined
> [    0.007251] RAMDISK: [mem 0x2c92b000-0x3248cfff]
> [    0.007254] ACPI: Early table checksum verification disabled
> [    0.007257] ACPI: RSDP 0x00000000BA4FF000 000024 (v02 ALASKA)
> [    0.007259] ACPI: XSDT 0x00000000BA4FF0B0 0000E4 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007262] ACPI: FACP 0x00000000BA527CC0 000114 (v06 ALASKA A M I    01072009 AMI  00010013)
> [    0.007265] ACPI: DSDT 0x00000000BA4FF230 028A8E (v02 ALASKA A M I    01072009 INTL 20160422)
> [    0.007267] ACPI: FACS 0x00000000BA8B0C40 000040
> [    0.007268] ACPI: APIC 0x00000000BA527DD8 0000BC (v03 ALASKA A M I    01072009 AMI  00010013)
> [    0.007269] ACPI: FPDT 0x00000000BA527E98 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007271] ACPI: MCFG 0x00000000BA527EE0 00003C (v01 ALASKA A M I    01072009 MSFT 00000097)
> [    0.007272] ACPI: SSDT 0x00000000BA527F20 0003BC (v01 ALASKA A M I    00001000 INTL 20160422)
> [    0.007274] ACPI: FIDT 0x00000000BA5282E0 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007275] ACPI: SSDT 0x00000000BA528380 003159 (v02 ALASKA A M I    00003000 INTL 20160422)
> [    0.007277] ACPI: SSDT 0x00000000BA52B4E0 00255F (v02 ALASKA A M I    00001000 INTL 20160422)
> [    0.007278] ACPI: HPET 0x00000000BA52DA40 000038 (v01 ALASKA A M I    00000001 MSFT 0000005F)
> [    0.007280] ACPI: SSDT 0x00000000BA52DA78 000DE5 (v02 ALASKA A M I    00001000 INTL 20160422)
> [    0.007281] ACPI: SSDT 0x00000000BA52E860 002AD7 (v02 ALASKA A M I    00000000 INTL 20160422)
> [    0.007283] ACPI: UEFI 0x00000000BA531338 000042 (v01 ALASKA A M I    00000002      01000013)
> [    0.007284] ACPI: SSDT 0x00000000BA531380 000EDE (v02 ALASKA A M I    00003000 INTL 20160422)
> [    0.007286] ACPI: LPIT 0x00000000BA532260 000094 (v01 ALASKA A M I    00000000 MSFT 0000005F)
> [    0.007287] ACPI: WSMT 0x00000000BA5322F8 000028 (v01 ALASKA A M I    00000000 MSFT 0000005F)
> [    0.007289] ACPI: SSDT 0x00000000BA532320 00029F (v02 ALASKA A M I    00000000 INTL 20160422)
> [    0.007290] ACPI: SSDT 0x00000000BA5325C0 003002 (v02 ALASKA A M I    00001000 INTL 20160422)
> [    0.007291] ACPI: DBGP 0x00000000BA5355C8 000034 (v01 ALASKA A M I    00000002 MSFT 0000005F)
> [    0.007293] ACPI: DBG2 0x00000000BA535600 000054 (v00 ALASKA A M I    00000002 MSFT 0000005F)
> [    0.007294] ACPI: BGRT 0x00000000BA535658 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007296] ACPI: BGRT 0x00000000BA535690 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007297] ACPI: TPM2 0x00000000BA5356C8 000034 (v03 ALASKA A M I    00000001 AMI  00000000)
> [    0.007299] ACPI: BGRT 0x00000000BA535700 000038 (v01 ALASKA A M I    01072009 AMI  00010013)
> [    0.007300] ACPI: ASF! 0x00000000BA535738 0000A0 (v32 ALASKA A M I    00000001 TFSM 000F4240)
> [    0.007305] ACPI: Local APIC address 0xfee00000
> [    0.007318] Zone ranges:
> [    0.007318]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> [    0.007319]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> [    0.007320]   Normal   [mem 0x0000000100000000-0x000000023dffffff]
> [    0.007320] Movable zone start for each node
> [    0.007321] Early memory node ranges
> [    0.007321]   node   0: [mem 0x0000000000001000-0x0000000000057fff]
> [    0.007322]   node   0: [mem 0x0000000000059000-0x000000000009efff]
> [    0.007322]   node   0: [mem 0x0000000000100000-0x00000000ab20afff]
> [    0.007323]   node   0: [mem 0x00000000ab20d000-0x00000000b9d32fff]
> [    0.007323]   node   0: [mem 0x00000000ba085000-0x00000000ba1fefff]
> [    0.007323]   node   0: [mem 0x00000000bafff000-0x00000000baffffff]
> [    0.007324]   node   0: [mem 0x0000000100000000-0x000000023dffffff]
> [    0.007596] Zeroed struct page in unavailable ranges: 33207 pages
> [    0.007597] Initmem setup node 0 [mem 0x0000000000001000-0x000000023dffffff]
> [    0.007598] On node 0 totalpages: 2063945
> [    0.007599]   DMA zone: 64 pages used for memmap
> [    0.007599]   DMA zone: 43 pages reserved
> [    0.007600]   DMA zone: 3997 pages, LIFO batch:0
> [    0.007636]   DMA32 zone: 11835 pages used for memmap
> [    0.007637]   DMA32 zone: 757420 pages, LIFO batch:63
> [    0.014217]   Normal zone: 20352 pages used for memmap
> [    0.014218]   Normal zone: 1302528 pages, LIFO batch:63
> [    0.025261] Reserving Intel graphics memory at [mem 0xbc000000-0xbfffffff]
> [    0.025429] ACPI: PM-Timer IO Port: 0x1808
> [    0.025430] ACPI: Local APIC address 0xfee00000
> [    0.025434] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> [    0.025434] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> [    0.025434] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> [    0.025435] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> [    0.025435] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
> [    0.025435] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
> [    0.025436] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
> [    0.025436] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
> [    0.025462] IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> [    0.025463] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> [    0.025464] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> [    0.025465] ACPI: IRQ0 used by override.
> [    0.025465] ACPI: IRQ9 used by override.
> [    0.025466] Using ACPI (MADT) for SMP configuration information
> [    0.025467] ACPI: HPET id: 0x8086a201 base: 0xfed00000
> [    0.025469] smpboot: Allowing 8 CPUs, 0 hotplug CPUs
> [    0.025481] [mem 0xc0000000-0xefffffff] available for PCI devices
> [    0.025482] Booting paravirtualized kernel on bare hardware
> [    0.025484] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370452778343963 ns
> [    0.029685] setup_percpu: NR_CPUS:32 nr_cpumask_bits:32 nr_cpu_ids:8 nr_node_ids:1
> [    0.029855] percpu: Embedded 55 pages/cpu s185112 r8192 d31976 u262144
> [    0.029859] pcpu-alloc: s185112 r8192 d31976 u262144 alloc=1*2097152
> [    0.029859] pcpu-alloc: [0] 0 1 2 3 4 5 6 7 
> [    0.029871] Built 1 zonelists, mobility grouping on.  Total pages: 2031651
> [    0.029871] Kernel command line: BOOT_IMAGE=/boot/vmlinuz-5.7.0-rc6-x86_64 root=UUID=639936b7-5333-4744-a29d-f68da8a9b5b7 ro video=uvesafb:1280x1024-32,mtrr:3,ywrap quiet splash domdadm
> [    0.029948] printk: log_buf_len individual max cpu contribution: 131072 bytes
> [    0.029949] printk: log_buf_len total cpu_extra contributions: 917504 bytes
> [    0.029949] printk: log_buf_len min size: 32768 bytes
> [    0.030008] printk: log_buf_len: 1048576 bytes
> [    0.030009] printk: early log buf free: 20836(63%)
> [    0.030495] Dentry cache hash table entries: 1048576 (order: 11, 8388608 bytes, linear)
> [    0.030758] Inode-cache hash table entries: 524288 (order: 10, 4194304 bytes, linear)
> [    0.030810] mem auto-init: stack:off, heap alloc:off, heap free:off
> [    0.054732] Memory: 7814748K/8255780K available (16387K kernel code, 1310K rwdata, 4116K rodata, 1728K init, 10272K bss, 441032K reserved, 0K cma-reserved)
> [    0.054780] Kernel/User page tables isolation: enabled
> [    0.054793] ftrace: allocating 52879 entries in 207 pages
> [    0.067855] ftrace: allocated 207 pages with 6 groups
> [    0.067906] rcu: Hierarchical RCU implementation.
> [    0.067907] rcu: 	RCU restricting CPUs from NR_CPUS=32 to nr_cpu_ids=8.
> [    0.067908] rcu: RCU calculated value of scheduler-enlistment delay is 30 jiffies.
> [    0.067908] rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=8
> [    0.068013] NR_IRQS: 4352, nr_irqs: 2048, preallocated irqs: 16
> [    0.068301] random: get_random_bytes called from start_kernel+0x364/0x52b with crng_init=0
> [    0.068381] Console: colour dummy device 80x25
> [    0.068384] printk: console [tty0] enabled
> [    0.068388] ACPI: Core revision 20200326
> [    0.068614] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635855245 ns
> [    0.068678] APIC: Switch to symmetric I/O mode setup
> [    0.072658] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
> [    0.088700] clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x3101f59f5e6, max_idle_ns: 440795259996 ns
> [    0.088701] Calibrating delay loop (skipped), value calculated using timer frequency.. 6802.13 BogoMIPS (lpj=11333020)
> [    0.088703] pid_max: default: 32768 minimum: 301
> [    0.090959] Mount-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.090977] Mountpoint-cache hash table entries: 16384 (order: 5, 131072 bytes, linear)
> [    0.091112] mce: CPU0: Thermal monitoring enabled (TM1)
> [    0.091126] process: using mwait in idle threads
> [    0.091128] Last level iTLB entries: 4KB 64, 2MB 8, 4MB 8
> [    0.091128] Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> [    0.091129] Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sanitization
> [    0.091130] Spectre V2 : Mitigation: Full generic retpoline
> [    0.091130] Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch
> [    0.091131] Spectre V2 : Enabling Restricted Speculation for firmware calls
> [    0.091131] Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction Barrier
> [    0.091132] Spectre V2 : User space: Mitigation: STIBP via seccomp and prctl
> [    0.091132] Speculative Store Bypass: Vulnerable
> [    0.091133] TAA: Vulnerable: Clear CPU buffers attempted, no microcode
> [    0.091133] MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> [    0.091321] Freeing SMP alternatives memory: 48K
> [    0.092870] smpboot: CPU0: Intel(R) Core(TM) i7-6700 CPU @ 3.40GHz (family: 0x6, model: 0x5e, stepping: 0x3)
> [    0.092916] Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width counters, Intel PMU driver.
> [    0.092920] ... version:                4
> [    0.092921] ... bit width:              48
> [    0.092921] ... generic registers:      4
> [    0.092921] ... value mask:             0000ffffffffffff
> [    0.092922] ... max period:             00007fffffffffff
> [    0.092922] ... fixed-purpose events:   3
> [    0.092922] ... event mask:             000000070000000f
> [    0.092947] rcu: Hierarchical SRCU implementation.
> [    0.092997] smp: Bringing up secondary CPUs ...
> [    0.093038] x86: Booting SMP configuration:
> [    0.093039] .... node  #0, CPUs:      #1 #2 #3 #4
> [    0.093693] MDS CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/mds.html for more details.
> [    0.093693] TAA CPU bug present and SMT on, data leak possible. See https://www.kernel.org/doc/html/latest/admin-guide/hw-vuln/tsx_async_abort.html for more details.
> [    0.093693]  #5 #6 #7
> [    0.095726] smp: Brought up 1 node, 8 CPUs
> [    0.095726] smpboot: Max logical packages: 1
> [    0.095726] smpboot: Total of 8 processors activated (54420.10 BogoMIPS)
> [    0.097464] devtmpfs: initialized
> [    0.097464] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
> [    0.097464] futex hash table entries: 2048 (order: 5, 131072 bytes, linear)
> [    0.097464] pinctrl core: initialized pinctrl subsystem
> [    0.097464] thermal_sys: Registered thermal governor 'step_wise'
> [    0.097464] thermal_sys: Registered thermal governor 'user_space'
> [    0.097464] NET: Registered protocol family 16
> [    0.097464] audit: initializing netlink subsys (disabled)
> [    0.097464] audit: type=2000 audit(1590085029.026:1): state=initialized audit_enabled=0 res=1
> [    0.097464] cpuidle: using governor ladder
> [    0.097464] cpuidle: using governor menu
> [    0.097464] ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> [    0.097464] ACPI: bus type PCI registered
> [    0.097464] PCI: MMCONFIG for domain 0000 [bus 00-7f] at [mem 0xf0000000-0xf7ffffff] (base 0xf0000000)
> [    0.097464] PCI: MMCONFIG at [mem 0xf0000000-0xf7ffffff] reserved in E820
> [    0.097464] PCI: Using configuration type 1 for base access
> [    0.099892] HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> [    0.099892] HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> [    0.099892] ACPI: Added _OSI(Module Device)
> [    0.099892] ACPI: Added _OSI(Processor Device)
> [    0.099892] ACPI: Added _OSI(3.0 _SCP Extensions)
> [    0.099892] ACPI: Added _OSI(Processor Aggregator Device)
> [    0.099892] ACPI: Added _OSI(Linux-Dell-Video)
> [    0.099892] ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> [    0.099892] ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> [    0.121721] ACPI: 9 ACPI AML tables successfully acquired and loaded
> [    0.123435] ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> [    0.125470] ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
> [    0.126281] ACPI: Dynamic OEM Table Load:
> [    0.126284] ACPI: SSDT 0xFFFF94FC7404A600 000115 (v02 PmRef  Cpu0Hwp  00003000 INTL 20160422)
> [    0.127006] ACPI: Dynamic OEM Table Load:
> [    0.127008] ACPI: SSDT 0xFFFF94FC7404A400 0001A4 (v02 PmRef  HwpLvt   00003000 INTL 20160422)
> [    0.127892] ACPI: Dynamic OEM Table Load:
> [    0.127894] ACPI: SSDT 0xFFFF94FC7404A200 000197 (v02 PmRef  ApHwp    00003000 INTL 20160422)
> [    0.130752] ACPI: Interpreter enabled
> [    0.130757] ACPI: (supports S0 S5)
> [    0.130758] ACPI: Using IOAPIC for interrupt routing
> [    0.130778] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> [    0.131407] ACPI: Enabled 6 GPEs in block 00 to 7F
> [    0.132763] ACPI: Power Resource [PG00] (on)
> [    0.133005] ACPI: Power Resource [PG01] (on)
> [    0.133238] ACPI: Power Resource [PG02] (on)
> [    0.135285] ACPI: Power Resource [WRST] (on)
> [    0.135474] ACPI: Power Resource [WRST] (on)
> [    0.135660] ACPI: Power Resource [WRST] (on)
> [    0.135845] ACPI: Power Resource [WRST] (on)
> [    0.136030] ACPI: Power Resource [WRST] (on)
> [    0.136215] ACPI: Power Resource [WRST] (on)
> [    0.136400] ACPI: Power Resource [WRST] (on)
> [    0.136588] ACPI: Power Resource [WRST] (on)
> [    0.136786] ACPI: Power Resource [WRST] (on)
> [    0.136972] ACPI: Power Resource [WRST] (on)
> [    0.137156] ACPI: Power Resource [WRST] (on)
> [    0.137341] ACPI: Power Resource [WRST] (on)
> [    0.137527] ACPI: Power Resource [WRST] (on)
> [    0.137712] ACPI: Power Resource [WRST] (on)
> [    0.137898] ACPI: Power Resource [WRST] (on)
> [    0.138083] ACPI: Power Resource [WRST] (on)
> [    0.138269] ACPI: Power Resource [WRST] (on)
> [    0.138967] ACPI: Power Resource [WRST] (on)
> [    0.139152] ACPI: Power Resource [WRST] (on)
> [    0.139337] ACPI: Power Resource [WRST] (on)
> [    0.146871] ACPI: Power Resource [FN00] (off)
> [    0.146921] ACPI: Power Resource [FN01] (off)
> [    0.146967] ACPI: Power Resource [FN02] (off)
> [    0.147013] ACPI: Power Resource [FN03] (off)
> [    0.147059] ACPI: Power Resource [FN04] (off)
> [    0.147765] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
> [    0.147768] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
> [    0.147789] acpi PNP0A08:00: _OSC failed (AE_ERROR); disabling ASPM
> [    0.147989] PCI host bridge to bus 0000:00
> [    0.147990] pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> [    0.147991] pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> [    0.147992] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> [    0.147993] pci_bus 0000:00: root bus resource [mem 0xc0000000-0xefffffff window]
> [    0.147993] pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> [    0.147994] pci_bus 0000:00: root bus resource [bus 00-7e]
> [    0.148000] pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
> [    0.148203] pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
> [    0.148235] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> [    0.148363] pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
> [    0.148372] pci 0000:00:02.0: reg 0x10: [mem 0xee000000-0xeeffffff 64bit]
> [    0.148376] pci 0000:00:02.0: reg 0x18: [mem 0xd0000000-0xdfffffff 64bit pref]
> [    0.148379] pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
> [    0.148390] pci 0000:00:02.0: BAR 2: assigned to efifb
> [    0.148527] pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
> [    0.148544] pci 0000:00:14.0: reg 0x10: [mem 0xef230000-0xef23ffff 64bit]
> [    0.148597] pci 0000:00:14.0: PME# supported from D3hot D3cold
> [    0.148748] pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
> [    0.148770] pci 0000:00:16.0: reg 0x10: [mem 0xef24e000-0xef24efff 64bit]
> [    0.148832] pci 0000:00:16.0: PME# supported from D3hot
> [    0.148934] pci 0000:00:16.3: [8086:a13d] type 00 class 0x070002
> [    0.148946] pci 0000:00:16.3: reg 0x10: [io  0xf0a0-0xf0a7]
> [    0.148950] pci 0000:00:16.3: reg 0x14: [mem 0xef24d000-0xef24dfff]
> [    0.149063] pci 0000:00:17.0: [8086:2822] type 00 class 0x010400
> [    0.149077] pci 0000:00:17.0: reg 0x10: [mem 0xef248000-0xef249fff]
> [    0.149082] pci 0000:00:17.0: reg 0x14: [mem 0xef24c000-0xef24c0ff]
> [    0.149088] pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
> [    0.149093] pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
> [    0.149098] pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
> [    0.149104] pci 0000:00:17.0: reg 0x24: [mem 0xef24b000-0xef24b7ff]
> [    0.149134] pci 0000:00:17.0: PME# supported from D3hot
> [    0.149232] pci 0000:00:1b.0: [8086:a167] type 01 class 0x060400
> [    0.149292] pci 0000:00:1b.0: PME# supported from D0 D3hot D3cold
> [    0.149403] pci 0000:00:1b.2: [8086:a169] type 01 class 0x060400
> [    0.149468] pci 0000:00:1b.2: PME# supported from D0 D3hot D3cold
> [    0.149581] pci 0000:00:1b.3: [8086:a16a] type 01 class 0x060400
> [    0.149646] pci 0000:00:1b.3: PME# supported from D0 D3hot D3cold
> [    0.149771] pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
> [    0.149823] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> [    0.149931] pci 0000:00:1c.2: [8086:a112] type 01 class 0x060400
> [    0.149988] pci 0000:00:1c.2: PME# supported from D0 D3hot D3cold
> [    0.150099] pci 0000:00:1c.4: [8086:a114] type 01 class 0x060400
> [    0.150163] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
> [    0.150285] pci 0000:00:1d.0: [8086:a118] type 01 class 0x060400
> [    0.150349] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
> [    0.150485] pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
> [    0.150667] pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
> [    0.150680] pci 0000:00:1f.2: reg 0x10: [mem 0xef244000-0xef247fff]
> [    0.150811] pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
> [    0.150835] pci 0000:00:1f.3: reg 0x10: [mem 0xef240000-0xef243fff 64bit]
> [    0.150863] pci 0000:00:1f.3: reg 0x20: [mem 0xef220000-0xef22ffff 64bit]
> [    0.150905] pci 0000:00:1f.3: PME# supported from D3hot D3cold
> [    0.151036] pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
> [    0.151095] pci 0000:00:1f.4: reg 0x10: [mem 0xef24a000-0xef24a0ff 64bit]
> [    0.151164] pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
> [    0.151329] pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
> [    0.151354] pci 0000:00:1f.6: reg 0x10: [mem 0xef200000-0xef21ffff]
> [    0.151452] pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
> [    0.151564] pci 0000:01:00.0: [1b4b:9230] type 00 class 0x010601
> [    0.151575] pci 0000:01:00.0: reg 0x10: [io  0xe050-0xe057]
> [    0.151579] pci 0000:01:00.0: reg 0x14: [io  0xe040-0xe043]
> [    0.151583] pci 0000:01:00.0: reg 0x18: [io  0xe030-0xe037]
> [    0.151588] pci 0000:01:00.0: reg 0x1c: [io  0xe020-0xe023]
> [    0.151592] pci 0000:01:00.0: reg 0x20: [io  0xe000-0xe01f]
> [    0.151597] pci 0000:01:00.0: reg 0x24: [mem 0xef110000-0xef1107ff]
> [    0.151601] pci 0000:01:00.0: reg 0x30: [mem 0xef100000-0xef10ffff pref]
> [    0.151610] pci 0000:01:00.0: Enabling fixed DMA alias to 00.1
> [    0.151631] pci 0000:01:00.0: PME# supported from D3hot
> [    0.151677] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.151679] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
> [    0.151680] pci 0000:00:01.0:   bridge window [mem 0xef100000-0xef1fffff]
> [    0.151703] pci 0000:00:1b.0: PCI bridge to [bus 02]
> [    0.151730] pci 0000:00:1b.2: PCI bridge to [bus 03]
> [    0.151757] pci 0000:00:1b.3: PCI bridge to [bus 04]
> [    0.151781] pci 0000:00:1c.0: PCI bridge to [bus 05]
> [    0.151822] pci 0000:06:00.0: [8086:1539] type 00 class 0x020000
> [    0.151853] pci 0000:06:00.0: reg 0x10: [mem 0xef000000-0xef01ffff]
> [    0.151876] pci 0000:06:00.0: reg 0x18: [io  0xd000-0xd01f]
> [    0.151887] pci 0000:06:00.0: reg 0x1c: [mem 0xef020000-0xef023fff]
> [    0.152009] pci 0000:06:00.0: PME# supported from D0 D3hot D3cold
> [    0.152103] pci 0000:00:1c.2: PCI bridge to [bus 06]
> [    0.152105] pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
> [    0.152106] pci 0000:00:1c.2:   bridge window [mem 0xef000000-0xef0fffff]
> [    0.152131] pci 0000:00:1c.4: PCI bridge to [bus 07]
> [    0.152157] pci 0000:00:1d.0: PCI bridge to [bus 08]
> [    0.152187] pci_bus 0000:00: on NUMA node 0
> [    0.153577] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.153610] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 *10 11 12 14 15)
> [    0.153643] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.153674] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.153706] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.153738] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.153769] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.153801] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 10 *11 12 14 15)
> [    0.154104] iommu: Default domain type: Translated 
> [    0.154110] pci 0000:00:02.0: vgaarb: setting as boot VGA device
> [    0.154110] pci 0000:00:02.0: vgaarb: VGA device added: decodes=io+mem,owns=io+mem,locks=none
> [    0.154110] pci 0000:00:02.0: vgaarb: bridge control possible
> [    0.154110] vgaarb: loaded
> [    0.154110] SCSI subsystem initialized
> [    0.154110] libata version 3.00 loaded.
> [    0.154110] ACPI: bus type USB registered
> [    0.154110] usbcore: registered new interface driver usbfs
> [    0.154110] usbcore: registered new interface driver hub
> [    0.154110] usbcore: registered new device driver usb
> [    0.154110] pps_core: LinuxPPS API ver. 1 registered
> [    0.154110] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
> [    0.154110] PTP clock support registered
> [    0.154110] Registered efivars operations
> [    0.154110] Advanced Linux Sound Architecture Driver Initialized.
> [    0.154110] PCI: Using ACPI for IRQ routing
> [    0.167602] PCI: pci_cache_line_size set to 64 bytes
> [    0.167643] e820: reserve RAM buffer [mem 0x00058000-0x0005ffff]
> [    0.167644] e820: reserve RAM buffer [mem 0x0009f000-0x0009ffff]
> [    0.167644] e820: reserve RAM buffer [mem 0xab20b000-0xabffffff]
> [    0.167645] e820: reserve RAM buffer [mem 0xb86a7000-0xbbffffff]
> [    0.167646] e820: reserve RAM buffer [mem 0xb9d33000-0xbbffffff]
> [    0.167646] e820: reserve RAM buffer [mem 0xba1ff000-0xbbffffff]
> [    0.167647] e820: reserve RAM buffer [mem 0xbb000000-0xbbffffff]
> [    0.167647] e820: reserve RAM buffer [mem 0x23e000000-0x23fffffff]
> [    0.167752] clocksource: Switched to clocksource tsc-early
> [    0.169945] VFS: Disk quotas dquot_6.6.0
> [    0.169945] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> [    0.169945] FS-Cache: Loaded
> [    0.169945] pnp: PnP ACPI init
> [    0.169945] system 00:00: [io  0x0a00-0x0a2f] has been reserved
> [    0.169945] system 00:00: [io  0x0a30-0x0a3f] has been reserved
> [    0.169945] system 00:00: [io  0x0a40-0x0a4f] has been reserved
> [    0.169945] system 00:00: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.169945] pnp 00:01: [dma 0 disabled]
> [    0.169945] pnp 00:01: Plug and Play ACPI device, IDs PNP0400 (active)
> [    0.169945] pnp 00:02: [dma 0 disabled]
> [    0.169945] pnp 00:02: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.169945] pnp 00:03: [dma 0 disabled]
> [    0.169945] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (active)
> [    0.169945] system 00:04: [io  0x0680-0x069f] has been reserved
> [    0.169945] system 00:04: [io  0xffff] has been reserved
> [    0.169945] system 00:04: [io  0xffff] has been reserved
> [    0.169945] system 00:04: [io  0xffff] has been reserved
> [    0.169945] system 00:04: [io  0x1800-0x18fe] has been reserved
> [    0.169945] system 00:04: [io  0x164e-0x164f] has been reserved
> [    0.169945] system 00:04: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.169945] system 00:05: [io  0x0800-0x087f] has been reserved
> [    0.169945] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.169945] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
> [    0.169945] system 00:07: [io  0x1854-0x1857] has been reserved
> [    0.169945] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
> [    0.169945] system 00:08: [mem 0xfed10000-0xfed17fff] has been reserved
> [    0.169945] system 00:08: [mem 0xfed18000-0xfed18fff] has been reserved
> [    0.169945] system 00:08: [mem 0xfed19000-0xfed19fff] has been reserved
> [    0.169945] system 00:08: [mem 0xf0000000-0xf7ffffff] has been reserved
> [    0.169945] system 00:08: [mem 0xfed20000-0xfed3ffff] has been reserved
> [    0.169945] system 00:08: [mem 0xfed90000-0xfed93fff] has been reserved
> [    0.169945] system 00:08: [mem 0xfed45000-0xfed8ffff] has been reserved
> [    0.169945] system 00:08: [mem 0xff000000-0xffffffff] has been reserved
> [    0.169945] system 00:08: [mem 0xfee00000-0xfeefffff] could not be reserved
> [    0.169945] system 00:08: [mem 0xeffe0000-0xefffffff] has been reserved
> [    0.169945] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.169945] system 00:09: [mem 0xfd000000-0xfdabffff] has been reserved
> [    0.169945] system 00:09: [mem 0xfdad0000-0xfdadffff] has been reserved
> [    0.169945] system 00:09: [mem 0xfdb00000-0xfdffffff] has been reserved
> [    0.169945] system 00:09: [mem 0xfe000000-0xfe01ffff] could not be reserved
> [    0.169945] system 00:09: [mem 0xfe036000-0xfe03bfff] has been reserved
> [    0.169945] system 00:09: [mem 0xfe03d000-0xfe3fffff] has been reserved
> [    0.169945] system 00:09: [mem 0xfe410000-0xfe7fffff] has been reserved
> [    0.169945] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.169945] system 00:0a: [io  0xff00-0xfffe] has been reserved
> [    0.169945] system 00:0a: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.172580] system 00:0b: [mem 0xfdaf0000-0xfdafffff] has been reserved
> [    0.172581] system 00:0b: [mem 0xfdae0000-0xfdaeffff] has been reserved
> [    0.172581] system 00:0b: [mem 0xfdac0000-0xfdacffff] has been reserved
> [    0.172583] system 00:0b: Plug and Play ACPI device, IDs PNP0c02 (active)
> [    0.173070] pnp: PnP ACPI: found 12 devices
> [    0.178152] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
> [    0.178160] pci 0000:00:01.0: PCI bridge to [bus 01]
> [    0.178161] pci 0000:00:01.0:   bridge window [io  0xe000-0xefff]
> [    0.178163] pci 0000:00:01.0:   bridge window [mem 0xef100000-0xef1fffff]
> [    0.178166] pci 0000:00:1b.0: PCI bridge to [bus 02]
> [    0.178172] pci 0000:00:1b.2: PCI bridge to [bus 03]
> [    0.178179] pci 0000:00:1b.3: PCI bridge to [bus 04]
> [    0.178185] pci 0000:00:1c.0: PCI bridge to [bus 05]
> [    0.178190] pci 0000:00:1c.2: PCI bridge to [bus 06]
> [    0.178192] pci 0000:00:1c.2:   bridge window [io  0xd000-0xdfff]
> [    0.178194] pci 0000:00:1c.2:   bridge window [mem 0xef000000-0xef0fffff]
> [    0.178198] pci 0000:00:1c.4: PCI bridge to [bus 07]
> [    0.178204] pci 0000:00:1d.0: PCI bridge to [bus 08]
> [    0.178211] pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> [    0.178212] pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> [    0.178212] pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> [    0.178213] pci_bus 0000:00: resource 7 [mem 0xc0000000-0xefffffff window]
> [    0.178214] pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
> [    0.178214] pci_bus 0000:01: resource 0 [io  0xe000-0xefff]
> [    0.178215] pci_bus 0000:01: resource 1 [mem 0xef100000-0xef1fffff]
> [    0.178215] pci_bus 0000:06: resource 0 [io  0xd000-0xdfff]
> [    0.178216] pci_bus 0000:06: resource 1 [mem 0xef000000-0xef0fffff]
> [    0.178304] NET: Registered protocol family 2
> [    0.178393] tcp_listen_portaddr_hash hash table entries: 4096 (order: 4, 65536 bytes, linear)
> [    0.178403] TCP established hash table entries: 65536 (order: 7, 524288 bytes, linear)
> [    0.178468] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> [    0.178610] TCP: Hash tables configured (established 65536 bind 65536)
> [    0.178625] UDP hash table entries: 4096 (order: 5, 131072 bytes, linear)
> [    0.178644] UDP-Lite hash table entries: 4096 (order: 5, 131072 bytes, linear)
> [    0.178685] NET: Registered protocol family 1
> [    0.178693] pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
> [    0.179279] PCI: CLS 64 bytes, default 64
> [    0.179296] Trying to unpack rootfs image as initramfs...
> [    5.613141] Freeing initrd memory: 93576K
> [    5.613146] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> [    5.613147] software IO TLB: mapped [mem 0xb1708000-0xb5708000] (64MB)
> [    5.613245] RAPL PMU: API unit is 2^-32 Joules, 4 fixed counters, 655360 ms ovfl timer
> [    5.613245] RAPL PMU: hw unit of domain pp0-core 2^-14 Joules
> [    5.613246] RAPL PMU: hw unit of domain package 2^-14 Joules
> [    5.613246] RAPL PMU: hw unit of domain dram 2^-14 Joules
> [    5.613246] RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> [    5.613584] simple-framebuffer simple-framebuffer.0: framebuffer at 0xd0000000, 0x1d5000 bytes, mapped to 0x00000000a746ea17
> [    5.613585] simple-framebuffer simple-framebuffer.0: format=a8r8g8b8, mode=800x600x32, linelength=3200
> [    5.613624] Console: switching to colour frame buffer device 100x37
> [    5.614192] simple-framebuffer simple-framebuffer.0: fb0: simplefb registered!
> [    5.614408] workingset: timestamp_bits=46 max_order=21 bucket_order=0
> [    5.614497] DLM installed
> [    5.614531] squashfs: version 4.0 (2009/01/31) Phillip Lougher
> [    5.614542] ntfs: driver 2.1.32 [Flags: R/W].
> [    5.614556] fuse: init (API version 7.31)
> [    5.616834] NET: Registered protocol family 38
> [    5.616837] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 248)
> [    5.616838] io scheduler mq-deadline registered
> [    5.616839] io scheduler kyber registered
> [    5.617706] hv_vmbus: registering driver hyperv_fb
> [    5.617713] intel_idle: MWAIT substates: 0x142120
> [    5.617713] intel_idle: v0.5.1 model 0x5E
> [    5.617933] intel_idle: Local APIC timer is reliable in all C-states
> [    5.618032] input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/input0
> [    5.618064] ACPI: Sleep Button [SLPB]
> [    5.618079] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input1
> [    5.618086] ACPI: Power Button [PWRB]
> [    5.618102] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> [    5.618118] ACPI: Power Button [PWRF]
> [    5.618933] thermal LNXTHERM:00: registered as thermal_zone0
> [    5.618933] ACPI: Thermal Zone [TZ00] (28 C)
> [    5.619002] thermal LNXTHERM:01: registered as thermal_zone1
> [    5.619002] ACPI: Thermal Zone [TZ01] (30 C)
> [    5.619134] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> [    5.619202] 00:02: ttyS0 at I/O 0x3f8 (irq = 4, base_baud = 115200) is a 16550A
> [    5.619309] 00:03: ttyS1 at I/O 0x2f8 (irq = 3, base_baud = 115200) is a 16550A
> [    5.619550] serial 0000:00:16.3: enabling device (0000 -> 0003)
> [    5.619700] 0000:00:16.3: ttyS2 at I/O 0xf0a0 (irq = 19, base_baud = 115200) is a 16550A
> [    5.619807] Linux agpgart interface v0.103
> [    5.620074] checking generic (d0000000 1d5000) vs hw (ee000000 1000000)
> [    5.620074] checking generic (d0000000 1d5000) vs hw (d0000000 10000000)
> [    5.620075] fb0: switching to inteldrmfb from simple
> [    5.620183] Console: switching to colour dummy device 80x25
> [    5.620189] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    5.620629] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    5.620833] i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=io+mem,decodes=io+mem:owns=io+mem
> [    5.621289] i915 0000:00:02.0: [drm] Finished loading DMC firmware i915/skl_dmc_ver1_27.bin (v1.27)
> [    5.640760] [drm] Initialized i915 1.6.0 20200313 for 0000:00:02.0 on minor 0
> [    5.641915] ACPI: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> [    5.642127] input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:00/input/input3
> [    5.643379] brd: module loaded
> [    5.646246] loop: module loaded
> [    5.647878] Guest personality initialized and is inactive
> [    5.647900] VMCI host device registered (name=vmci, major=10, minor=59)
> [    5.647900] Initialized host personality
> [    5.647941] Loading iSCSI transport class v2.0-870.
> [    5.648104] iscsi: registered transport (tcp)
> [    5.648132] VMware PVSCSI driver - version 1.0.7.0-k
> [    5.648233] cnic: QLogic cnicDriver v2.5.22 (July 20, 2015)
> [    5.648421] e100: Intel(R) PRO/100 Network Driver, 3.5.24-k2-NAPI
> [    5.648421] e100: Copyright(c) 1999-2006 Intel Corporation
> [    5.648427] e1000: Intel(R) PRO/1000 Network Driver - version 7.3.21-k8-NAPI
> [    5.648427] e1000: Copyright (c) 1999-2006 Intel Corporation.
> [    5.648433] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
> [    5.648433] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> [    5.648606] e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic conservative mode
> [    5.663899] fbcon: i915drmfb (fb0) is primary device
> [    5.672775] Console: switching to colour frame buffer device 128x48
> [    5.690324] i915 0000:00:02.0: fb0: i915drmfb frame buffer device
> [    5.727814] e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> [    5.799775] e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 40:8d:5c:b0:7a:d3
> [    5.799776] e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> [    5.799852] e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
> [    5.799860] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.6.0-k
> [    5.799860] igb: Copyright (c) 2007-2014 Intel Corporation.
> [    5.828449] pps pps0: new PPS source ptp1
> [    5.828557] igb 0000:06:00.0: added PHC on eth1
> [    5.828558] igb 0000:06:00.0: Intel(R) Gigabit Ethernet Network Connection
> [    5.828572] igb 0000:06:00.0: eth1: (PCIe:2.5Gb/s:Width x1) 40:8d:5c:b0:7a:d5
> [    5.828573] igb 0000:06:00.0: eth1: PBA No: FFFFFF-0FF
> [    5.828574] igb 0000:06:00.0: Using MSI-X interrupts. 2 rx queue(s), 2 tx queue(s)
> [    5.828603] igbvf: Intel(R) Gigabit Virtual Function Network Driver - version 2.4.0-k
> [    5.828603] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
> [    5.828609] ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver - version 5.1.0-k
> [    5.828610] ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> [    5.828729] ixgbevf: Intel(R) 10 Gigabit PCI Express Virtual Function Network Driver - version 4.1.0-k
> [    5.828729] ixgbevf: Copyright (c) 2009 - 2018 Intel Corporation.
> [    5.828842] i40e: Intel(R) Ethernet Connection XL710 Network Driver - version 2.8.20-k
> [    5.828843] i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> [    5.828954] ixgb: Intel(R) PRO/10GbE Network Driver - version 1.0.135-k2-NAPI
> [    5.828954] ixgb: Copyright (c) 1999-2008 Intel Corporation.
> [    5.828959] iavf: Intel(R) Ethernet Adaptive Virtual Function Network Driver - version 3.2.3-k
> [    5.828959] Copyright (c) 2013 - 2018 Intel Corporation.
> [    5.829037] jme: JMicron JMC2XX ethernet driver version 1.0.8
> [    5.829059] sky2: driver version 1.30
> [    5.829146] myri10ge: Version 1.5.3-1.534
> [    5.829167] ns83820.c: National Semiconductor DP83820 10/100/1000 driver.
> [    5.829215] tehuti: Tehuti Networks(R) Network Driver, 7.29.3
> [    5.829215] tehuti: Options: hw_csum 
> [    5.829219] tlan: ThunderLAN driver v1.17
> [    5.829224] tlan: 0 devices installed, PCI: 0  EISA: 0
> [    5.829249] VMware vmxnet3 virtual NIC driver - version 1.4.17.0-k-NAPI
> [    5.829257] usbcore: registered new interface driver catc
> [    5.829260] usbcore: registered new interface driver kaweth
> [    5.829260] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB Ethernet driver
> [    5.829263] usbcore: registered new interface driver pegasus
> [    5.829265] usbcore: registered new interface driver rtl8150
> [    5.829268] usbcore: registered new interface driver r8152
> [    5.829271] usbcore: registered new interface driver asix
> [    5.829273] usbcore: registered new interface driver ax88179_178a
> [    5.829276] usbcore: registered new interface driver cdc_ether
> [    5.829278] usbcore: registered new interface driver net1080
> [    5.829281] usbcore: registered new interface driver cdc_subset
> [    5.829283] usbcore: registered new interface driver zaurus
> [    5.829287] usbcore: registered new interface driver cdc_ncm
> [    5.829287] hv_vmbus: registering driver hv_netvsc
> [    5.829412] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> [    5.829412] ehci-pci: EHCI PCI platform driver
> [    5.829417] ehci-platform: EHCI generic platform driver
> [    5.829436] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> [    5.829437] ohci-pci: OHCI PCI platform driver
> [    5.829441] ohci-platform: OHCI generic platform driver
> [    5.829445] uhci_hcd: USB Universal Host Controller Interface driver
> [    5.829532] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    5.829535] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> [    5.830594] xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0000000001109810
> [    5.830680] xhci_hcd 0000:00:14.0: cache line size of 64 is not supported
> [    5.830787] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002, bcdDevice= 5.07
> [    5.830788] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.830789] usb usb1: Product: xHCI Host Controller
> [    5.830789] usb usb1: Manufacturer: Linux 5.7.0-rc6-x86_64 xhci-hcd
> [    5.830790] usb usb1: SerialNumber: 0000:00:14.0
> [    5.830872] hub 1-0:1.0: USB hub found
> [    5.830886] hub 1-0:1.0: 16 ports detected
> [    5.831735] xhci_hcd 0000:00:14.0: xHCI Host Controller
> [    5.831737] xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> [    5.831738] xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> [    5.831757] usb usb2: New USB device found, idVendor=1d6b, idProduct=0003, bcdDevice= 5.07
> [    5.831758] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
> [    5.831758] usb usb2: Product: xHCI Host Controller
> [    5.831759] usb usb2: Manufacturer: Linux 5.7.0-rc6-x86_64 xhci-hcd
> [    5.831759] usb usb2: SerialNumber: 0000:00:14.0
> [    5.831834] hub 2-0:1.0: USB hub found
> [    5.831843] hub 2-0:1.0: 10 ports detected
> [    5.832528] usbcore: registered new interface driver usb-storage
> [    5.832532] usbcore: registered new interface driver ums-realtek
> [    5.832544] i8042: PNP: No PS/2 controller found.
> [    5.832545] hv_vmbus: registering driver hyperv_keyboard
> [    5.832639] mousedev: PS/2 mouse device common for all mice
> [    5.832885] usbcore: registered new interface driver appletouch
> [    5.832928] input: PC Speaker as /devices/platform/pcspkr/input/input4
> [    5.832965] IR NEC protocol handler initialized
> [    5.832965] IR RC5(x/sz) protocol handler initialized
> [    5.832965] IR RC6 protocol handler initialized
> [    5.832966] IR JVC protocol handler initialized
> [    5.832966] IR Sony protocol handler initialized
> [    5.832966] IR SANYO protocol handler initialized
> [    5.832966] IR Sharp protocol handler initialized
> [    5.832967] IR MCE Keyboard/mouse protocol handler initialized
> [    5.832967] IR XMP protocol handler initialized
> [    5.832974] intel_pstate: Intel P-state driver initializing
> [    5.833252] intel_pstate: HWP enabled
> [    5.833253] EFI Variables Facility v0.08 2004-May-17
> [    5.866977] hid: raw HID events driver (C) Jiri Kosina
> [    5.866988] hv_vmbus: registering driver hid_hyperv
> [    5.866991] hv_utils: Registering HyperV Utility Driver
> [    5.866992] hv_vmbus: registering driver hv_utils
> [    5.866992] hv_vmbus: registering driver hv_balloon
> [    5.867515] IPVS: Registered protocols ()
> [    5.867524] IPVS: Connection hash table configured (size=4096, memory=64Kbytes)
> [    5.867558] IPVS: ipvs loaded.
> [    5.867626] NET: Registered protocol family 10
> [    5.867703] snd_hda_intel 0000:00:1f.3: bound 0000:00:02.0 (ops 0xffffffffb429eb20)
> [    5.867825] Segment Routing with IPv6
> [    5.867899] NET: Registered protocol family 17
> [    5.867902] NET: Registered protocol family 15
> [    5.867906] sctp: Hash tables configured (bind 256/256)
> [    5.867925] Key type dns_resolver registered
> [    5.868269] microcode: sig=0x506e3, pf=0x2, revision=0xc2
> [    5.868430] microcode: Microcode Update Driver: v2.2.
> [    5.868431] IPI shorthand broadcast: enabled
> [    5.868435] sched_clock: Marking stable (5867996974, 430630)->(5871724807, -3297203)
> [    5.868473] registered taskstats version 1
> [    5.868475] page_owner is disabled
> [    5.868479] Key type ._fscrypt registered
> [    5.868479] Key type .fscrypt registered
> [    5.868479] Key type fscrypt-provisioning registered
> [    5.868624] Key type encrypted registered
> [    5.869280] ALSA device list:
> [    5.869281]   No soundcards found.
> [    5.869823] Freeing unused kernel image (initmem) memory: 1728K
> [    5.889505] random: fast init done
> [    5.889861] snd_hda_codec_realtek hdaudioC0D0: autoconfig for ALC887-VD: line_outs=1 (0x14/0x0/0x0/0x0/0x0) type:line
> [    5.889862] snd_hda_codec_realtek hdaudioC0D0:    speaker_outs=1 (0x17/0x0/0x0/0x0/0x0)
> [    5.889863] snd_hda_codec_realtek hdaudioC0D0:    hp_outs=1 (0x1b/0x0/0x0/0x0/0x0)
> [    5.889863] snd_hda_codec_realtek hdaudioC0D0:    mono: mono_out=0x0
> [    5.889864] snd_hda_codec_realtek hdaudioC0D0:    dig-out=0x11/0x0
> [    5.889864] snd_hda_codec_realtek hdaudioC0D0:    inputs:
> [    5.889865] snd_hda_codec_realtek hdaudioC0D0:      Front Mic=0x19
> [    5.889866] snd_hda_codec_realtek hdaudioC0D0:      Rear Mic=0x18
> [    5.889866] snd_hda_codec_realtek hdaudioC0D0:      Line=0x1a
> [    5.892060] Write protecting the kernel read-only data: 24576k
> [    5.892517] Freeing unused kernel image (text/rodata gap) memory: 2044K
> [    5.892743] Freeing unused kernel image (rodata/data gap) memory: 2028K
> [    5.892756] Run /init as init process
> [    5.892756]   with arguments:
> [    5.892756]     /init
> [    5.892757]     splash
> [    5.892757]     domdadm
> [    5.892757]   with environment:
> [    5.892758]     HOME=/
> [    5.892758]     TERM=linux
> [    5.892758]     BOOT_IMAGE=/boot/vmlinuz-5.7.0-rc6-x86_64
> [    5.909422] input: HDA Intel PCH Front Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input5
> [    5.909442] input: HDA Intel PCH Rear Mic as /devices/pci0000:00/0000:00:1f.3/sound/card0/input6
> [    5.909460] input: HDA Intel PCH Line as /devices/pci0000:00/0000:00:1f.3/sound/card0/input7
> [    5.909477] input: HDA Intel PCH Line Out as /devices/pci0000:00/0000:00:1f.3/sound/card0/input8
> [    5.909499] input: HDA Intel PCH Front Headphone as /devices/pci0000:00/0000:00:1f.3/sound/card0/input9
> [    5.909516] input: HDA Intel PCH HDMI/DP,pcm=3 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input10
> [    5.909533] input: HDA Intel PCH HDMI/DP,pcm=7 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input11
> [    5.909551] input: HDA Intel PCH HDMI/DP,pcm=8 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input12
> [    5.909567] input: HDA Intel PCH HDMI/DP,pcm=9 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input13
> [    5.909583] input: HDA Intel PCH HDMI/DP,pcm=10 as /devices/pci0000:00/0000:00:1f.3/sound/card0/input14
> [    6.061610] hv_vmbus: registering driver hv_storvsc
> [    6.129109] hv_vmbus: registering driver hv_storvsc
> [    6.162169] usb 1-5: new low-speed USB device number 2 using xhci_hcd
> [    6.183569] ahci 0000:00:17.0: version 3.0
> [    6.183668] ahci 0000:00:17.0: controller can't do SNTF, turning off CAP_SNTF
> [    6.193904] ahci 0000:00:17.0: AHCI 0001.0301 32 slots 6 ports 6 Gbps 0x3f impl RAID mode
> [    6.193906] ahci 0000:00:17.0: flags: 64bit ncq led clo only pio slum part ems deso sadm sds apst 
> [    6.242690] scsi host0: ahci
> [    6.243035] scsi host1: ahci
> [    6.243231] scsi host2: ahci
> [    6.243408] scsi host3: ahci
> [    6.243465] scsi host4: ahci
> [    6.243527] scsi host5: ahci
> [    6.243558] ata1: SATA max UDMA/133 abar m2048@0xef24b000 port 0xef24b100 irq 137
> [    6.243559] ata2: SATA max UDMA/133 abar m2048@0xef24b000 port 0xef24b180 irq 137
> [    6.243560] ata3: SATA max UDMA/133 abar m2048@0xef24b000 port 0xef24b200 irq 137
> [    6.243561] ata4: SATA max UDMA/133 abar m2048@0xef24b000 port 0xef24b280 irq 137
> [    6.243562] ata5: SATA max UDMA/133 abar m2048@0xef24b000 port 0xef24b300 irq 137
> [    6.243563] ata6: SATA max UDMA/133 abar m2048@0xef24b000 port 0xef24b380 irq 137
> [    6.243731] ahci 0000:01:00.0: controller can do FBS, turning on CAP_FBS
> [    6.253980] ahci 0000:01:00.0: AHCI 0001.0200 32 slots 8 ports 6 Gbps 0xff impl SATA mode
> [    6.253981] ahci 0000:01:00.0: flags: 64bit ncq fbs pio 
> [    6.254504] scsi host6: ahci
> [    6.254870] scsi host7: ahci
> [    6.254973] scsi host8: ahci
> [    6.255160] scsi host9: ahci
> [    6.255241] scsi host10: ahci
> [    6.255277] scsi host11: ahci
> [    6.255312] scsi host12: ahci
> [    6.255345] scsi host13: ahci
> [    6.255363] ata7: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110100 irq 138
> [    6.255364] ata8: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110180 irq 138
> [    6.255365] ata9: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110200 irq 138
> [    6.255366] ata10: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110280 irq 138
> [    6.255366] ata11: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110300 irq 138
> [    6.255370] ata12: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110380 irq 138
> [    6.255371] ata13: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110400 irq 138
> [    6.255372] ata14: SATA max UDMA/133 abar m2048@0xef110000 port 0xef110480 irq 138
> [    6.308741] usb 1-5: New USB device found, idVendor=15d9, idProduct=0a4f, bcdDevice= 1.00
> [    6.308742] usb 1-5: New USB device strings: Mfr=0, Product=1, SerialNumber=0
> [    6.308742] usb 1-5: Product:  USB OPTICAL MOUSE
> [    6.432164] usb 1-9: new low-speed USB device number 3 using xhci_hcd
> [    6.552173] ata1: SATA link down (SStatus 4 SControl 300)
> [    6.552199] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    6.555456] ata5: SATA link down (SStatus 4 SControl 300)
> [    6.555469] ata6: SATA link down (SStatus 4 SControl 300)
> [    6.555481] ata4: SATA link down (SStatus 4 SControl 300)
> [    6.557312] ata3: SATA link down (SStatus 4 SControl 300)
> [    6.557472] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SAT0.PRT1._GTF.DSSP], AE_NOT_FOUND (20200326/psargs-330)
> [    6.557475] ACPI Error: Aborting method \_SB.PCI0.SAT0.PRT1._GTF due to previous error (AE_NOT_FOUND) (20200326/psparse-529)
> [    6.557479] ata2.00: ATAPI: TSSTcorp CDDVDW SN-208FB, SB00, max UDMA/100
> [    6.562718] ACPI BIOS Error (bug): Could not resolve symbol [\_SB.PCI0.SAT0.PRT1._GTF.DSSP], AE_NOT_FOUND (20200326/psargs-330)
> [    6.562720] ACPI Error: Aborting method \_SB.PCI0.SAT0.PRT1._GTF due to previous error (AE_NOT_FOUND) (20200326/psparse-529)
> [    6.562725] ata2.00: configured for UDMA/100
> [    6.565810] ata10: SATA link down (SStatus 0 SControl 300)
> [    6.565821] ata9: SATA link down (SStatus 0 SControl 300)
> [    6.565831] ata8: SATA link down (SStatus 0 SControl 300)
> [    6.565842] ata11: SATA link down (SStatus 0 SControl 300)
> [    6.565853] ata12: SATA link down (SStatus 0 SControl 300)
> [    6.565876] ata7: SATA link down (SStatus 0 SControl 300)
> [    6.565886] ata14: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> [    6.565895] ata13: SATA link down (SStatus 0 SControl 300)
> [    6.566030] ata14.00: ATAPI: MARVELL VIRTUALL, 1.09, max UDMA/66
> [    6.566303] ata14.00: configured for UDMA/66
> [    6.571437] scsi 1:0:0:0: CD-ROM            TSSTcorp CDDVDW SN-208FB  SB00 PQ: 0 ANSI: 5
> [    6.595683] usb 1-9: New USB device found, idVendor=045e, idProduct=00dd, bcdDevice= 1.73
> [    6.595684] usb 1-9: New USB device strings: Mfr=1, Product=2, SerialNumber=0
> [    6.595685] usb 1-9: Product: Comfort Curve Keyboard 2000
> [    6.595686] usb 1-9: Manufacturer: Microsoft
> [    6.628836] tsc: Refined TSC clocksource calibration: 3408.054 MHz
> [    6.628839] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x3120070f444, max_idle_ns: 440795300015 ns
> [    6.628872] clocksource: Switched to clocksource tsc
> [    6.642715] sr 1:0:0:0: [sr0] scsi3-mmc drive: 24x/24x writer dvd-ram cd/rw xa/form2 cdda tray
> [    6.642716] cdrom: Uniform CD-ROM driver Revision: 3.20
> [    6.659001] sr 1:0:0:0: Attached scsi CD-ROM sr0
> [    6.659528] scsi 13:0:0:0: Processor         Marvell  Console          1.01 PQ: 0 ANSI: 5
> [    6.684188] Fusion MPT base driver 3.04.20
> [    6.684188] Copyright (c) 1999-2008 LSI Corporation
> [    6.684724] Fusion MPT SPI Host driver 3.04.20
> [    6.687106] megasas: 07.713.01.00-rc1
> [    6.696365] sr 1:0:0:0: Attached scsi generic sg0 type 5
> [    6.696414] scsi 13:0:0:0: Attached scsi generic sg1 type 3
> [    6.718765] usb 1-10: new high-speed USB device number 4 using xhci_hcd
> [    6.838434] GDT-HA: Storage RAID Controller Driver. Version: 3.05
> [    6.868797] usb 1-10: New USB device found, idVendor=13fe, idProduct=5500, bcdDevice= 1.00
> [    6.868798] usb 1-10: New USB device strings: Mfr=1, Product=2, SerialNumber=3
> [    6.868798] usb 1-10: Product: Patriot Memory
> [    6.868799] usb 1-10: Manufacturer:         
> [    6.868800] usb 1-10: SerialNumber: 07017B6749B2A409
> [    6.869529] usb-storage 1-10:1.0: USB Mass Storage device detected
> [    6.869571] scsi host14: usb-storage 1-10:1.0
> [    6.978655] Fusion MPT FC Host driver 3.04.20
> [    6.980821] Fusion MPT SAS Host driver 3.04.20
> [    6.984100] 3ware Storage Controller device driver for Linux v1.26.02.003.
> [    6.985392] 3ware 9000 Storage Controller device driver for Linux v2.26.02.014.
> [    6.998174] Adaptec aacraid driver 1.2.1[50983]-custom
> [    6.999661] megaraid cmm: 2.20.2.7 (Release Date: Sun Jul 16 00:01:03 EST 2006)
> [    6.999938] megaraid: 2.20.5.1 (Release Date: Thu Nov 16 15:32:35 EST 2006)
> [    7.008681] qla2xxx [0000:00:00.0]-0005: : QLogic Fibre Channel HBA Driver: 10.01.00.25-k.
> [    7.018792] Emulex LightPulse Fibre Channel SCSI driver 12.8.0.0
> [    7.018792] Copyright (C) 2017-2019 Broadcom. All Rights Reserved. The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
> [    7.023509] aic94xx: Adaptec aic94xx SAS/SATA driver version 1.0.3 loaded
> [    7.112955] usbcore: registered new interface driver uas
> [    7.120405] input:  USB OPTICAL MOUSE as /devices/pci0000:00/0000:00:14.0/usb1/1-5/1-5:1.0/0003:15D9:0A4F.0001/input/input15
> [    7.120447] hid-generic 0003:15D9:0A4F.0001: input,hidraw0: USB HID v1.11 Mouse [ USB OPTICAL MOUSE] on usb-0000:00:14.0-5/input0
> [    7.127363] input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.0/0003:045E:00DD.0002/input/input16
> [    7.182370] hid-generic 0003:045E:00DD.0002: input,hidraw1: USB HID v1.11 Keyboard [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:14.0-9/input0
> [    7.192613] input: Microsoft Comfort Curve Keyboard 2000 as /devices/pci0000:00/0000:00:14.0/usb1/1-9/1-9:1.1/0003:045E:00DD.0003/input/input17
> [    7.249024] hid-generic 0003:045E:00DD.0003: input,hidraw2: USB HID v1.11 Device [Microsoft Comfort Curve Keyboard 2000] on usb-0000:00:14.0-9/input1
> [    7.249051] usbcore: registered new interface driver usbhid
> [    7.249051] usbhid: USB HID core driver
> [    7.306642] device-mapper: uevent: version 1.0.3
> [    7.306747] device-mapper: ioctl: 4.42.0-ioctl (2020-02-27) initialised: dm-devel@redhat.com
> [    7.415369] raid6: avx2x4   gen() 44352 MB/s
> [    7.472036] raid6: avx2x4   xor() 12529 MB/s
> [    7.528702] raid6: avx2x2   gen() 45105 MB/s
> [    7.585368] raid6: avx2x2   xor() 27044 MB/s
> [    7.642035] raid6: avx2x1   gen() 38116 MB/s
> [    7.698702] raid6: avx2x1   xor() 21471 MB/s
> [    7.755370] raid6: sse2x4   gen() 18246 MB/s
> [    7.812036] raid6: sse2x4   xor() 10258 MB/s
> [    7.868702] raid6: sse2x2   gen() 18460 MB/s
> [    7.925370] raid6: sse2x2   xor() 11420 MB/s
> [    7.982035] raid6: sse2x1   gen() 15578 MB/s
> [    8.038703] raid6: sse2x1   xor()  7814 MB/s
> [    8.038703] raid6: using algorithm avx2x2 gen() 45105 MB/s
> [    8.038723] raid6: .... xor() 27044 MB/s, rmw enabled
> [    8.038723] raid6: using avx2x2 recovery algorithm
> [    8.038998] xor: automatically using best checksumming function   avx       
> [    8.039249] async_tx: api initialized (async)
> [    8.121812] Btrfs loaded, crc32c=crc32c-generic
> [    8.136000] RPC: Registered named UNIX socket transport module.
> [    8.136001] RPC: Registered udp transport module.
> [    8.136001] RPC: Registered tcp transport module.
> [    8.136002] RPC: Registered tcp NFSv4.1 backchannel transport module.
> [    8.148128] FS-Cache: Netfs 'nfs' registered for caching
> [    8.631323] scsi 14:0:0:0: Direct-Access              Patriot Memory   PMAP PQ: 0 ANSI: 6
> [    8.631529] sd 14:0:0:0: Attached scsi generic sg2 type 0
> [    8.631955] sd 14:0:0:0: [sda] 30965760 512-byte logical blocks: (15.9 GB/14.8 GiB)
> [    8.633202] sd 14:0:0:0: [sda] Write Protect is off
> [    8.633203] sd 14:0:0:0: [sda] Mode Sense: 23 00 00 00
> [    8.634484] sd 14:0:0:0: [sda] No Caching mode page found
> [    8.634485] sd 14:0:0:0: [sda] Assuming drive cache: write through
> [    8.670437]  sda: sda1 sda2 sda3
> [    8.674052] sd 14:0:0:0: [sda] Attached SCSI removable disk
> [    8.862307] BTRFS: device label Root devid 1 transid 2929 /dev/sda2 scanned by mount (3342)
> [    8.863024] BTRFS info (device sda2): disk space caching is enabled
> [    8.863024] BTRFS info (device sda2): has skinny extents
> [    9.387266] random: lvm: uninitialized urandom read (4 bytes read)
> [    9.390484] random: lvm: uninitialized urandom read (4 bytes read)
> [   10.019191] udevd[3949]: starting version 3.2.9
> [   10.050274] random: udevd: uninitialized urandom read (16 bytes read)
> [   10.065015] udevd[3949]: starting eudev-3.2.9
> [   10.144978] i801_smbus 0000:00:1f.4: enabling device (0001 -> 0003)
> [   10.145090] i801_smbus 0000:00:1f.4: SPD Write Disable is set
> [   10.145117] i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> [   10.146945] rtc_cmos 00:06: RTC can wake from S4
> [   10.147439] rtc_cmos 00:06: registered as rtc0
> [   10.147448] rtc_cmos 00:06: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> [   10.156522] igb 0000:06:00.0 enp6s0: renamed from eth1
> [   10.172196] e1000e 0000:00:1f.6 enp0s31f6: renamed from eth0
> [   11.118627] random: crng init done
> [   11.118628] random: 7 urandom warning(s) missed due to ratelimiting
> [   11.447262] BTRFS info (device sda2): use zlib compression, level 9
> [   11.447263] BTRFS info (device sda2): disk space caching is enabled
> [   16.949668] e1000e 0000:00:1f.6 enp0s31f6: NIC Link is Up 100 Mbps Full Duplex, Flow Control: Rx/Tx
> [   16.949669] e1000e 0000:00:1f.6 enp0s31f6: 10/100 speed: disabling TSO
> [   16.949719] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s31f6: link becomes ready
> [   77.187913] zram: Added device: zram0
> [   77.246343] zram0: detected capacity change from 0 to 85899345920
> [   78.407913] EXT4-fs (zram0): mounted filesystem without journal. Opts: discard
> [   78.725997] UDF-fs: INFO Mounting volume 'LinuxUDF', timestamp 2020/04/29 11:44 (1e5c)
> [   79.980492] broken atomic modeset userspace detected, disabling atomic
> [  148.074297] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 101447)
> [  148.074303] Buffer I/O error on device zram0, logical block 101447
> [  148.074304] Buffer I/O error on device zram0, logical block 101448
> [  148.074304] Buffer I/O error on device zram0, logical block 101449
> [  148.074305] Buffer I/O error on device zram0, logical block 101450
> [  148.074305] Buffer I/O error on device zram0, logical block 101451
> [  148.074306] Buffer I/O error on device zram0, logical block 101452
> [  148.074306] Buffer I/O error on device zram0, logical block 101453
> [  148.074307] Buffer I/O error on device zram0, logical block 101454
> [  148.074307] Buffer I/O error on device zram0, logical block 101455
> [  148.074308] Buffer I/O error on device zram0, logical block 101456
> [  148.074906] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 102400)
> [  148.075432] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 103424)
> [  148.076063] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 104448)
> [  148.076183] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 105916)
> [  148.076919] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 106496)
> [  148.077089] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 107819)
> [  148.077768] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 108544)
> [  148.077950] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 109697)
> [  148.078809] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 110592)
> [  153.845929] Buffer I/O error on dev zram0, logical block 1, lost async page write
> [  153.845946] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  153.845950] Buffer I/O error on dev zram0, logical block 33803, lost async page write
> [  153.845958] EXT4-fs warning: 103 callbacks suppressed
> [  153.845959] EXT4-fs warning (device zram0): ext4_end_bio:345: I/O error 10 writing to inode 12 starting block 215668)
> [  153.845960] buffer_io_error: 112164 callbacks suppressed
> [  153.845960] Buffer I/O error on device zram0, logical block 215668
> [  153.846060] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 176757, depth: 1 pblock 0
> [  153.846069] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  153.846070] EXT4-fs (zram0): I/O error while writing superblock
> [  153.846071] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 176757 with max blocks 2048 with error 117
> [  153.846071] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  153.915774] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  153.915965] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 178806, depth: 1 pblock 0
> [  153.915973] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  153.915974] EXT4-fs (zram0): I/O error while writing superblock
> [  153.915976] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 178806 with max blocks 2048 with error 117
> [  153.915976] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  153.985625] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  153.985844] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 180855, depth: 1 pblock 0
> [  153.985855] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  153.985856] EXT4-fs (zram0): I/O error while writing superblock
> [  153.985857] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 180855 with max blocks 2048 with error 117
> [  153.985858] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  154.055066] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  154.055288] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 182904, depth: 1 pblock 0
> [  154.055297] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  154.055298] EXT4-fs (zram0): I/O error while writing superblock
> [  154.125530] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 184953, depth: 1 pblock 0
> [  154.195359] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 187002, depth: 1 pblock 0
> [  154.273661] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 189051, depth: 1 pblock 0
> [  154.334239] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 191100, depth: 1 pblock 0
> [  154.404154] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 193149, depth: 1 pblock 0
> [  154.473517] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 195198, depth: 1 pblock 0
> [  158.865912] EXT4-fs error: 62 callbacks suppressed
> [  158.865914] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 324285, depth: 1 pblock 0
> [  158.865930] buffer_io_error: 137 callbacks suppressed
> [  158.865930] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  158.865931] EXT4-fs: 206 callbacks suppressed
> [  158.865932] EXT4-fs (zram0): I/O error while writing superblock
> [  158.865934] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 324285 with max blocks 2048 with error 117
> [  158.865934] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  158.866365] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  158.935939] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 326334, depth: 1 pblock 0
> [  158.935955] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  158.935956] EXT4-fs (zram0): I/O error while writing superblock
> [  158.935958] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 326334 with max blocks 2048 with error 117
> [  158.935959] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  158.936396] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  158.997075] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 328383, depth: 1 pblock 0
> [  158.997092] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  158.997093] EXT4-fs (zram0): I/O error while writing superblock
> [  158.997094] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 328383 with max blocks 2048 with error 117
> [  158.997095] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  158.997576] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  159.075352] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 330432, depth: 1 pblock 0
> [  159.075382] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  159.075383] EXT4-fs (zram0): I/O error while writing superblock
> [  159.075719] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  159.145104] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 332481, depth: 1 pblock 0
> [  159.145121] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  159.145654] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  159.206451] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 334530, depth: 1 pblock 0
> [  159.276340] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 336579, depth: 1 pblock 0
> [  159.353602] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 338628, depth: 1 pblock 0
> [  159.422680] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 340677, depth: 1 pblock 0
> [  159.483241] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 342726, depth: 1 pblock 0
> [  163.891347] EXT4-fs error: 62 callbacks suppressed
> [  163.891349] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 471781, depth: 1 pblock 0
> [  163.891365] buffer_io_error: 134 callbacks suppressed
> [  163.891365] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  163.891366] EXT4-fs: 206 callbacks suppressed
> [  163.891367] EXT4-fs (zram0): I/O error while writing superblock
> [  163.891368] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 471781 with max blocks 2048 with error 117
> [  163.891369] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  163.891778] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  163.961342] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 473829, depth: 1 pblock 0
> [  163.961358] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  163.961359] EXT4-fs (zram0): I/O error while writing superblock
> [  163.961361] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 473829 with max blocks 1024 with error 117
> [  163.961361] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  163.961624] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  163.996286] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 474853, depth: 1 pblock 0
> [  163.996301] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  163.996302] EXT4-fs (zram0): I/O error while writing superblock
> [  163.996304] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 474853 with max blocks 1024 with error 117
> [  163.996304] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  163.996560] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  164.031467] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 475877, depth: 1 pblock 0
> [  164.031482] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  164.031483] EXT4-fs (zram0): I/O error while writing superblock
> [  164.031687] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  164.066235] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 476901, depth: 1 pblock 0
> [  164.066250] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  164.066451] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  164.092685] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 477925, depth: 1 pblock 0
> [  164.136112] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 478949, depth: 1 pblock 0
> [  164.170881] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:16: bad extent address lblock: 479973, depth: 1 pblock 0
> [  164.197273] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 480997, depth: 1 pblock 0
> [  164.240291] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 482021, depth: 1 pblock 0
> [  168.906106] EXT4-fs error: 134 callbacks suppressed
> [  168.906108] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 620261, depth: 1 pblock 0
> [  168.906122] buffer_io_error: 278 callbacks suppressed
> [  168.906123] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  168.906124] EXT4-fs: 422 callbacks suppressed
> [  168.906124] EXT4-fs (zram0): I/O error while writing superblock
> [  168.906125] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 620261 with max blocks 1024 with error 117
> [  168.906126] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  168.906339] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  168.940674] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 621285, depth: 1 pblock 0
> [  168.940689] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  168.940690] EXT4-fs (zram0): I/O error while writing superblock
> [  168.940692] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 621285 with max blocks 1024 with error 117
> [  168.940692] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  168.940880] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  168.984120] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 622309, depth: 1 pblock 0
> [  168.984137] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  168.984139] EXT4-fs (zram0): I/O error while writing superblock
> [  168.984140] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 622309 with max blocks 1024 with error 117
> [  168.984141] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  168.984355] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  169.018724] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 623333, depth: 1 pblock 0
> [  169.018739] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  169.018740] EXT4-fs (zram0): I/O error while writing superblock
> [  169.018936] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  169.062062] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 624357, depth: 1 pblock 0
> [  169.062077] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  169.062287] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  169.097068] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 625381, depth: 1 pblock 0
> [  169.123068] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 626405, depth: 1 pblock 0
> [  169.166420] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 627429, depth: 1 pblock 0
> [  169.192407] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 628453, depth: 1 pblock 0
> [  169.235355] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 629477, depth: 1 pblock 0
> [  173.928987] EXT4-fs error: 134 callbacks suppressed
> [  173.928989] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 767717, depth: 1 pblock 0
> [  173.929004] buffer_io_error: 278 callbacks suppressed
> [  173.929005] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  173.929006] EXT4-fs: 422 callbacks suppressed
> [  173.929007] EXT4-fs (zram0): I/O error while writing superblock
> [  173.929008] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 767717 with max blocks 1024 with error 117
> [  173.929009] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  173.929241] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  173.972702] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 768741, depth: 1 pblock 0
> [  173.972718] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  173.972719] EXT4-fs (zram0): I/O error while writing superblock
> [  173.972721] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 768741 with max blocks 1024 with error 117
> [  173.972722] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  173.972965] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  173.998989] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 769765, depth: 1 pblock 0
> [  173.999004] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  173.999005] EXT4-fs (zram0): I/O error while writing superblock
> [  173.999007] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 769765 with max blocks 1024 with error 117
> [  173.999007] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  173.999216] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  174.033845] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 770789, depth: 1 pblock 0
> [  174.033860] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  174.033862] EXT4-fs (zram0): I/O error while writing superblock
> [  174.034065] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  174.069151] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 771813, depth: 1 pblock 0
> [  174.069167] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  174.069372] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  174.103902] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 772837, depth: 1 pblock 0
> [  174.138647] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 773861, depth: 1 pblock 0
> [  174.173896] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 774885, depth: 1 pblock 0
> [  174.208877] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 775909, depth: 1 pblock 0
> [  174.243815] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 776933, depth: 1 pblock 0
> [  178.949138] buffer_io_error: 277 callbacks suppressed
> [  178.949139] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  178.949279] EXT4-fs error: 134 callbacks suppressed
> [  178.949281] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 915173, depth: 1 pblock 0
> [  178.949291] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  178.949292] EXT4-fs: 422 callbacks suppressed
> [  178.949292] EXT4-fs (zram0): I/O error while writing superblock
> [  178.949294] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 915173 with max blocks 1024 with error 117
> [  178.949294] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  178.983822] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  178.983932] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 916197, depth: 1 pblock 0
> [  178.983954] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  178.983955] EXT4-fs (zram0): I/O error while writing superblock
> [  178.983956] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 916197 with max blocks 1024 with error 117
> [  178.983957] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  179.018712] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  179.018842] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 917221, depth: 1 pblock 0
> [  179.018851] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  179.018852] EXT4-fs (zram0): I/O error while writing superblock
> [  179.018854] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 917221 with max blocks 1024 with error 117
> [  179.018855] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  179.053474] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  179.053584] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 918245, depth: 1 pblock 0
> [  179.053593] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  179.053594] EXT4-fs (zram0): I/O error while writing superblock
> [  179.088149] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  179.088266] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 919269, depth: 1 pblock 0
> [  179.088275] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  179.123034] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 920293, depth: 1 pblock 0
> [  179.157662] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 921317, depth: 1 pblock 0
> [  179.192451] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 922341, depth: 1 pblock 0
> [  179.227155] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 923365, depth: 1 pblock 0
> [  179.253334] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 924389, depth: 1 pblock 0
> [  183.966738] buffer_io_error: 278 callbacks suppressed
> [  183.966739] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  183.966847] EXT4-fs error: 134 callbacks suppressed
> [  183.966849] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1062629, depth: 1 pblock 0
> [  183.966873] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  183.966874] EXT4-fs: 422 callbacks suppressed
> [  183.966874] EXT4-fs (zram0): I/O error while writing superblock
> [  183.966876] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1062629 with max blocks 1024 with error 117
> [  183.966876] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  183.984814] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  183.985130] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 1063653, depth: 1 pblock 0
> [  183.985156] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  183.985158] EXT4-fs (zram0): I/O error while writing superblock
> [  183.985160] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1063653 with max blocks 1024 with error 117
> [  183.985161] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  184.028798] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  184.028934] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1064677, depth: 1 pblock 0
> [  184.028942] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  184.028943] EXT4-fs (zram0): I/O error while writing superblock
> [  184.028944] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1064677 with max blocks 1024 with error 117
> [  184.028945] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  184.064828] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  184.064962] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1065701, depth: 1 pblock 0
> [  184.064975] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  184.064976] EXT4-fs (zram0): I/O error while writing superblock
> [  184.100328] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  184.100431] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1066725, depth: 1 pblock 0
> [  184.100439] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  184.100697] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1067749, depth: 1 pblock 0
> [  184.100978] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1068773, depth: 1 pblock 0
> [  184.101257] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1069797, depth: 1 pblock 0
> [  184.101516] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1070821, depth: 1 pblock 0
> [  184.101775] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1071845, depth: 1 pblock 0
> [  188.990374] buffer_io_error: 278 callbacks suppressed
> [  188.990376] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  188.990496] EXT4-fs error: 134 callbacks suppressed
> [  188.990498] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1210085, depth: 1 pblock 0
> [  188.990507] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  188.990507] EXT4-fs: 422 callbacks suppressed
> [  188.990508] EXT4-fs (zram0): I/O error while writing superblock
> [  188.990510] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1210085 with max blocks 1024 with error 117
> [  188.990510] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  189.017542] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  189.017672] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1211109, depth: 1 pblock 0
> [  189.017684] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  189.017685] EXT4-fs (zram0): I/O error while writing superblock
> [  189.017687] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1211109 with max blocks 1024 with error 117
> [  189.017688] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  189.053019] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  189.053300] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1212133, depth: 1 pblock 0
> [  189.053310] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  189.053311] EXT4-fs (zram0): I/O error while writing superblock
> [  189.053313] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1212133 with max blocks 1024 with error 117
> [  189.053313] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  189.089091] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  189.089224] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1213157, depth: 1 pblock 0
> [  189.089233] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  189.089233] EXT4-fs (zram0): I/O error while writing superblock
> [  189.124560] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  189.124686] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1214181, depth: 1 pblock 0
> [  189.124696] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  189.159982] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1215205, depth: 1 pblock 0
> [  189.195617] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1216229, depth: 1 pblock 0
> [  189.231669] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1217253, depth: 1 pblock 0
> [  189.267469] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1218277, depth: 1 pblock 0
> [  189.295033] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1219301, depth: 1 pblock 0
> [  194.017964] buffer_io_error: 278 callbacks suppressed
> [  194.017966] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  194.018077] EXT4-fs error: 134 callbacks suppressed
> [  194.018079] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1357541, depth: 1 pblock 0
> [  194.018088] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  194.018089] EXT4-fs: 422 callbacks suppressed
> [  194.018089] EXT4-fs (zram0): I/O error while writing superblock
> [  194.018091] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1357541 with max blocks 1024 with error 117
> [  194.018092] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  194.062839] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  194.062960] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1358565, depth: 1 pblock 0
> [  194.062968] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  194.062969] EXT4-fs (zram0): I/O error while writing superblock
> [  194.062970] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1358565 with max blocks 1024 with error 117
> [  194.062971] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  194.089961] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  194.090079] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1359589, depth: 1 pblock 0
> [  194.090090] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  194.090091] EXT4-fs (zram0): I/O error while writing superblock
> [  194.090092] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1359589 with max blocks 1024 with error 117
> [  194.090093] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  194.125127] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  194.125250] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1360613, depth: 1 pblock 0
> [  194.125261] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  194.125262] EXT4-fs (zram0): I/O error while writing superblock
> [  194.160620] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  194.160725] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1361637, depth: 1 pblock 0
> [  194.160734] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  194.187958] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1362661, depth: 1 pblock 0
> [  194.223812] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1363685, depth: 1 pblock 0
> [  194.268870] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1364709, depth: 1 pblock 0
> [  194.296138] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1365733, depth: 1 pblock 0
> [  194.331454] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1366757, depth: 1 pblock 0
> [  199.026160] buffer_io_error: 276 callbacks suppressed
> [  199.026162] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  199.026293] EXT4-fs error: 133 callbacks suppressed
> [  199.026295] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1503973, depth: 1 pblock 0
> [  199.026305] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  199.026306] EXT4-fs: 419 callbacks suppressed
> [  199.026306] EXT4-fs (zram0): I/O error while writing superblock
> [  199.026308] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1503973 with max blocks 1024 with error 117
> [  199.026309] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  199.061895] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  199.062028] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1504997, depth: 1 pblock 0
> [  199.062040] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  199.062042] EXT4-fs (zram0): I/O error while writing superblock
> [  199.062044] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1504997 with max blocks 1024 with error 117
> [  199.062044] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  199.088433] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  199.088537] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1506021, depth: 1 pblock 0
> [  199.088547] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  199.088548] EXT4-fs (zram0): I/O error while writing superblock
> [  199.088549] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1506021 with max blocks 1024 with error 117
> [  199.088550] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  199.124364] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  199.124471] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1507045, depth: 1 pblock 0
> [  199.124479] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  199.124480] EXT4-fs (zram0): I/O error while writing superblock
> [  199.160103] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  199.160222] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1508069, depth: 1 pblock 0
> [  199.160233] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  199.195466] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1509093, depth: 1 pblock 0
> [  199.231571] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1510117, depth: 1 pblock 0
> [  199.267374] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1511141, depth: 1 pblock 0
> [  199.294790] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1512165, depth: 1 pblock 0
> [  199.330775] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1513189, depth: 1 pblock 0
> [  204.063422] buffer_io_error: 278 callbacks suppressed
> [  204.063423] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  204.063582] EXT4-fs error: 134 callbacks suppressed
> [  204.063584] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1651429, depth: 1 pblock 0
> [  204.063596] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  204.063596] EXT4-fs: 422 callbacks suppressed
> [  204.063597] EXT4-fs (zram0): I/O error while writing superblock
> [  204.063599] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1651429 with max blocks 1024 with error 117
> [  204.063600] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  204.100773] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  204.100911] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1652453, depth: 1 pblock 0
> [  204.100922] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  204.100923] EXT4-fs (zram0): I/O error while writing superblock
> [  204.100925] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1652453 with max blocks 1024 with error 117
> [  204.100926] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  204.128149] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  204.128266] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1653477, depth: 1 pblock 0
> [  204.128275] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  204.128276] EXT4-fs (zram0): I/O error while writing superblock
> [  204.128277] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1653477 with max blocks 1024 with error 117
> [  204.128278] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  204.163769] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  204.163974] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1654501, depth: 1 pblock 0
> [  204.163985] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  204.163986] EXT4-fs (zram0): I/O error while writing superblock
> [  204.199836] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  204.199959] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1655525, depth: 1 pblock 0
> [  204.199967] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  204.235521] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1656549, depth: 1 pblock 0
> [  204.271518] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1657573, depth: 1 pblock 0
> [  204.298500] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1658597, depth: 1 pblock 0
> [  204.342658] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1659621, depth: 1 pblock 0
> [  204.369793] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1660645, depth: 1 pblock 0
> [  209.096219] buffer_io_error: 278 callbacks suppressed
> [  209.096220] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  209.096382] EXT4-fs error: 134 callbacks suppressed
> [  209.096384] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1798885, depth: 1 pblock 0
> [  209.096393] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  209.096394] EXT4-fs: 422 callbacks suppressed
> [  209.096394] EXT4-fs (zram0): I/O error while writing superblock
> [  209.096396] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1798885 with max blocks 1024 with error 117
> [  209.096397] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  209.132119] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  209.132253] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1799909, depth: 1 pblock 0
> [  209.132262] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  209.132263] EXT4-fs (zram0): I/O error while writing superblock
> [  209.132265] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1799909 with max blocks 1024 with error 117
> [  209.132265] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  209.167554] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  209.167672] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1800933, depth: 1 pblock 0
> [  209.167681] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  209.167682] EXT4-fs (zram0): I/O error while writing superblock
> [  209.167683] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1800933 with max blocks 1024 with error 117
> [  209.167684] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  209.203347] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  209.203475] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1801957, depth: 1 pblock 0
> [  209.203484] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  209.203485] EXT4-fs (zram0): I/O error while writing superblock
> [  209.238756] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  209.238902] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1802981, depth: 1 pblock 0
> [  209.238912] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  209.265041] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1804005, depth: 1 pblock 0
> [  209.309053] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1805029, depth: 1 pblock 0
> [  209.335924] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1806053, depth: 1 pblock 0
> [  209.380882] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1807077, depth: 1 pblock 0
> [  209.416750] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1808101, depth: 1 pblock 0
> [  214.130651] buffer_io_error: 278 callbacks suppressed
> [  214.130652] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  214.130755] EXT4-fs error: 134 callbacks suppressed
> [  214.130757] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1946341, depth: 1 pblock 0
> [  214.130765] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  214.130765] EXT4-fs: 422 callbacks suppressed
> [  214.130766] EXT4-fs (zram0): I/O error while writing superblock
> [  214.130767] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1946341 with max blocks 1024 with error 117
> [  214.130768] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  214.157787] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  214.157912] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1947365, depth: 1 pblock 0
> [  214.157920] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  214.157921] EXT4-fs (zram0): I/O error while writing superblock
> [  214.157923] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1947365 with max blocks 1024 with error 117
> [  214.157923] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  214.193983] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  214.194160] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1948389, depth: 1 pblock 0
> [  214.194171] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  214.194172] EXT4-fs (zram0): I/O error while writing superblock
> [  214.194173] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 1948389 with max blocks 1024 with error 117
> [  214.194174] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  214.229460] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  214.229567] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 1949413, depth: 1 pblock 0
> [  214.229576] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  214.229577] EXT4-fs (zram0): I/O error while writing superblock
> [  214.256427] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  214.256554] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1950437, depth: 1 pblock 0
> [  214.256564] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  214.292124] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1951461, depth: 1 pblock 0
> [  214.336107] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1952485, depth: 1 pblock 0
> [  214.372199] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 1953509, depth: 1 pblock 0
> [  214.408115] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1954533, depth: 1 pblock 0
> [  214.443722] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 1955557, depth: 1 pblock 0
> [  219.155740] buffer_io_error: 278 callbacks suppressed
> [  219.155741] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  219.155850] EXT4-fs error: 134 callbacks suppressed
> [  219.155852] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2093797, depth: 1 pblock 0
> [  219.155860] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  219.155861] EXT4-fs: 422 callbacks suppressed
> [  219.155861] EXT4-fs (zram0): I/O error while writing superblock
> [  219.155862] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2093797 with max blocks 1024 with error 117
> [  219.155863] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  219.192519] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  219.192631] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2094821, depth: 1 pblock 0
> [  219.192641] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  219.192641] EXT4-fs (zram0): I/O error while writing superblock
> [  219.192643] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2094821 with max blocks 1024 with error 117
> [  219.192643] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  219.218532] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  219.218722] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2095845, depth: 1 pblock 0
> [  219.218737] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  219.218738] EXT4-fs (zram0): I/O error while writing superblock
> [  219.218740] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2095845 with max blocks 1024 with error 117
> [  219.218741] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  219.254431] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  219.254565] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2096869, depth: 1 pblock 0
> [  219.254574] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  219.254575] EXT4-fs (zram0): I/O error while writing superblock
> [  219.299185] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  219.299326] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2097893, depth: 1 pblock 0
> [  219.299336] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  219.326228] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2098917, depth: 1 pblock 0
> [  219.370796] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 2099941, depth: 1 pblock 0
> [  219.398147] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 2100965, depth: 1 pblock 0
> [  219.434252] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 2101989, depth: 1 pblock 0
> [  219.478646] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 2103013, depth: 1 pblock 0
> [  224.183866] buffer_io_error: 278 callbacks suppressed
> [  224.183868] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  224.184000] EXT4-fs error: 134 callbacks suppressed
> [  224.184002] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2241253, depth: 1 pblock 0
> [  224.184012] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  224.184012] EXT4-fs: 422 callbacks suppressed
> [  224.184013] EXT4-fs (zram0): I/O error while writing superblock
> [  224.184015] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2241253 with max blocks 1024 with error 117
> [  224.184015] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  224.218682] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  224.218828] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2242277, depth: 1 pblock 0
> [  224.218837] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  224.218838] EXT4-fs (zram0): I/O error while writing superblock
> [  224.218839] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2242277 with max blocks 1024 with error 117
> [  224.218840] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  224.253585] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  224.253740] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2243301, depth: 1 pblock 0
> [  224.253748] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  224.253749] EXT4-fs (zram0): I/O error while writing superblock
> [  224.253750] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2243301 with max blocks 1024 with error 117
> [  224.253751] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  224.297173] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  224.297302] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2244325, depth: 1 pblock 0
> [  224.297310] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  224.297311] EXT4-fs (zram0): I/O error while writing superblock
> [  224.323503] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  224.323648] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2245349, depth: 1 pblock 0
> [  224.323657] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  224.358498] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2246373, depth: 1 pblock 0
> [  224.401958] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2247397, depth: 1 pblock 0
> [  224.427958] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2248421, depth: 1 pblock 0
> [  224.462876] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2249445, depth: 1 pblock 0
> [  224.506297] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2250469, depth: 1 pblock 0
> [  229.400702] buffer_io_error: 290 callbacks suppressed
> [  229.400703] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  229.400824] EXT4-fs error: 140 callbacks suppressed
> [  229.400825] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2394853, depth: 1 pblock 0
> [  229.400834] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  229.400835] EXT4-fs: 440 callbacks suppressed
> [  229.400835] EXT4-fs (zram0): I/O error while writing superblock
> [  229.400836] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2394853 with max blocks 1024 with error 117
> [  229.400837] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  229.401031] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  229.401115] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2395877, depth: 1 pblock 0
> [  229.401121] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  229.401121] EXT4-fs (zram0): I/O error while writing superblock
> [  229.401122] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2395877 with max blocks 1024 with error 117
> [  229.401122] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  229.401291] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  229.401372] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2396901, depth: 1 pblock 0
> [  229.401376] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  229.401376] EXT4-fs (zram0): I/O error while writing superblock
> [  229.401377] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2396901 with max blocks 1024 with error 117
> [  229.401378] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  229.401547] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  229.401641] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2397925, depth: 1 pblock 0
> [  229.401645] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  229.401646] EXT4-fs (zram0): I/O error while writing superblock
> [  229.401833] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  229.401926] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2398949, depth: 1 pblock 0
> [  229.401930] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  229.402199] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2399973, depth: 1 pblock 0
> [  229.402467] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2400997, depth: 1 pblock 0
> [  229.402729] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2402021, depth: 1 pblock 0
> [  229.403014] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2403045, depth: 1 pblock 0
> [  229.403294] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2404069, depth: 1 pblock 0
> [  234.409584] buffer_io_error: 278 callbacks suppressed
> [  234.409586] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  234.409684] EXT4-fs error: 134 callbacks suppressed
> [  234.409685] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2542309, depth: 1 pblock 0
> [  234.409694] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  234.409694] EXT4-fs: 422 callbacks suppressed
> [  234.409695] EXT4-fs (zram0): I/O error while writing superblock
> [  234.409696] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2542309 with max blocks 1024 with error 117
> [  234.409697] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  234.444238] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  234.444335] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2543333, depth: 1 pblock 0
> [  234.444344] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  234.444345] EXT4-fs (zram0): I/O error while writing superblock
> [  234.444346] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2543333 with max blocks 1024 with error 117
> [  234.444346] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  234.487636] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  234.487753] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2544357, depth: 1 pblock 0
> [  234.487764] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  234.487765] EXT4-fs (zram0): I/O error while writing superblock
> [  234.487767] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2544357 with max blocks 1024 with error 117
> [  234.487768] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  234.513875] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  234.514025] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2545381, depth: 1 pblock 0
> [  234.514035] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  234.514036] EXT4-fs (zram0): I/O error while writing superblock
> [  234.539840] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  234.539973] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2546405, depth: 1 pblock 0
> [  234.539981] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  234.574662] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2547429, depth: 1 pblock 0
> [  234.618070] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2548453, depth: 1 pblock 0
> [  234.652823] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2549477, depth: 1 pblock 0
> [  234.687619] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2550501, depth: 1 pblock 0
> [  234.722565] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2551525, depth: 1 pblock 0
> [  239.426092] buffer_io_error: 278 callbacks suppressed
> [  239.426093] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  239.426205] EXT4-fs error: 134 callbacks suppressed
> [  239.426206] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2689765, depth: 1 pblock 0
> [  239.426215] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  239.426215] EXT4-fs: 422 callbacks suppressed
> [  239.426216] EXT4-fs (zram0): I/O error while writing superblock
> [  239.426217] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2689765 with max blocks 1024 with error 117
> [  239.426218] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  239.460662] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  239.460763] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2690789, depth: 1 pblock 0
> [  239.460772] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  239.460773] EXT4-fs (zram0): I/O error while writing superblock
> [  239.460774] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2690789 with max blocks 1024 with error 117
> [  239.460775] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  239.495280] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  239.495459] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2691813, depth: 1 pblock 0
> [  239.495485] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  239.495486] EXT4-fs (zram0): I/O error while writing superblock
> [  239.495488] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2691813 with max blocks 1024 with error 117
> [  239.495489] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  239.529737] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  239.529885] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2692837, depth: 1 pblock 0
> [  239.529896] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  239.529898] EXT4-fs (zram0): I/O error while writing superblock
> [  239.572709] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  239.572827] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2693861, depth: 1 pblock 0
> [  239.572834] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  239.607923] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2694885, depth: 1 pblock 0
> [  239.634081] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2695909, depth: 1 pblock 0
> [  239.677401] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2696933, depth: 1 pblock 0
> [  239.711832] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2697957, depth: 1 pblock 0
> [  239.746575] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2698981, depth: 1 pblock 0
> [  244.564037] buffer_io_error: 286 callbacks suppressed
> [  244.564038] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  244.564152] EXT4-fs error: 138 callbacks suppressed
> [  244.564154] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2841317, depth: 1 pblock 0
> [  244.564162] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  244.564162] EXT4-fs: 434 callbacks suppressed
> [  244.564163] EXT4-fs (zram0): I/O error while writing superblock
> [  244.564164] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2841317 with max blocks 1024 with error 117
> [  244.564165] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  244.564331] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  244.564424] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2842341, depth: 1 pblock 0
> [  244.564430] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  244.564430] EXT4-fs (zram0): I/O error while writing superblock
> [  244.564431] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2842341 with max blocks 1024 with error 117
> [  244.564432] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  244.564626] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  244.564753] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2843365, depth: 1 pblock 0
> [  244.564758] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  244.564758] EXT4-fs (zram0): I/O error while writing superblock
> [  244.564759] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2843365 with max blocks 1024 with error 117
> [  244.564760] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  244.564969] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  244.565069] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2844389, depth: 1 pblock 0
> [  244.565074] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  244.565074] EXT4-fs (zram0): I/O error while writing superblock
> [  244.565256] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  244.565366] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2845413, depth: 1 pblock 0
> [  244.565372] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  244.737616] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2846437, depth: 1 pblock 0
> [  244.780475] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2847461, depth: 1 pblock 0
> [  244.806444] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 2848485, depth: 1 pblock 0
> [  244.841902] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2849509, depth: 1 pblock 0
> [  244.868639] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2850533, depth: 1 pblock 0
> [  249.604977] buffer_io_error: 282 callbacks suppressed
> [  249.604978] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  249.605092] EXT4-fs error: 136 callbacks suppressed
> [  249.605094] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 2990821, depth: 1 pblock 0
> [  249.605103] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  249.605103] EXT4-fs: 428 callbacks suppressed
> [  249.605104] EXT4-fs (zram0): I/O error while writing superblock
> [  249.605105] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2990821 with max blocks 1024 with error 117
> [  249.605106] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  249.640486] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  249.640668] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2991845, depth: 1 pblock 0
> [  249.640678] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  249.640679] EXT4-fs (zram0): I/O error while writing superblock
> [  249.640680] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2991845 with max blocks 1024 with error 117
> [  249.640681] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  249.666416] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  249.666545] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2992869, depth: 1 pblock 0
> [  249.666553] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  249.666553] EXT4-fs (zram0): I/O error while writing superblock
> [  249.666555] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 2992869 with max blocks 1024 with error 117
> [  249.666555] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  249.701129] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  249.701270] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2993893, depth: 1 pblock 0
> [  249.701280] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  249.701281] EXT4-fs (zram0): I/O error while writing superblock
> [  249.744185] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  249.744317] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2994917, depth: 1 pblock 0
> [  249.744324] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  249.770173] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2995941, depth: 1 pblock 0
> [  249.813377] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2996965, depth: 1 pblock 0
> [  249.847933] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2997989, depth: 1 pblock 0
> [  249.882530] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 2999013, depth: 1 pblock 0
> [  249.917220] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:18: bad extent address lblock: 3000037, depth: 1 pblock 0
> [  254.607982] buffer_io_error: 278 callbacks suppressed
> [  254.607983] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  254.608136] EXT4-fs error: 134 callbacks suppressed
> [  254.608138] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3138277, depth: 1 pblock 0
> [  254.608147] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  254.608148] EXT4-fs: 422 callbacks suppressed
> [  254.608148] EXT4-fs (zram0): I/O error while writing superblock
> [  254.608150] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3138277 with max blocks 1024 with error 117
> [  254.608150] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  254.642448] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  254.642593] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3139301, depth: 1 pblock 0
> [  254.642604] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  254.642606] EXT4-fs (zram0): I/O error while writing superblock
> [  254.642607] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3139301 with max blocks 1024 with error 117
> [  254.642608] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  254.660093] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  254.660208] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3140325, depth: 1 pblock 0
> [  254.660219] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  254.660220] EXT4-fs (zram0): I/O error while writing superblock
> [  254.660222] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3140325 with max blocks 1024 with error 117
> [  254.660223] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  254.694844] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  254.694986] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3141349, depth: 1 pblock 0
> [  254.695011] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  254.695012] EXT4-fs (zram0): I/O error while writing superblock
> [  254.738051] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  254.738187] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3142373, depth: 1 pblock 0
> [  254.738195] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  254.772768] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3143397, depth: 1 pblock 0
> [  254.815975] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3144421, depth: 1 pblock 0
> [  254.851571] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 3145445, depth: 1 pblock 0
> [  254.877863] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3146469, depth: 1 pblock 0
> [  254.912454] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:13: bad extent address lblock: 3147493, depth: 1 pblock 0
> [  259.627854] buffer_io_error: 278 callbacks suppressed
> [  259.627855] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  259.628013] EXT4-fs error: 134 callbacks suppressed
> [  259.628014] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3285733, depth: 1 pblock 0
> [  259.628024] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  259.628025] EXT4-fs: 422 callbacks suppressed
> [  259.628026] EXT4-fs (zram0): I/O error while writing superblock
> [  259.628027] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3285733 with max blocks 1024 with error 117
> [  259.628028] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  259.662543] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  259.662683] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3286757, depth: 1 pblock 0
> [  259.662692] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  259.662693] EXT4-fs (zram0): I/O error while writing superblock
> [  259.662694] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3286757 with max blocks 1024 with error 117
> [  259.662695] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  259.697083] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  259.697218] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3287781, depth: 1 pblock 0
> [  259.697227] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  259.697228] EXT4-fs (zram0): I/O error while writing superblock
> [  259.697229] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3287781 with max blocks 1024 with error 117
> [  259.697230] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  259.731509] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  259.731657] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3288805, depth: 1 pblock 0
> [  259.731666] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  259.731667] EXT4-fs (zram0): I/O error while writing superblock
> [  259.766351] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  259.766536] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3289829, depth: 1 pblock 0
> [  259.766562] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  259.801066] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3290853, depth: 1 pblock 0
> [  259.827325] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3291877, depth: 1 pblock 0
> [  259.870883] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3292901, depth: 1 pblock 0
> [  259.905218] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3293925, depth: 1 pblock 0
> [  259.931480] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3294949, depth: 1 pblock 0
> [  264.657136] buffer_io_error: 280 callbacks suppressed
> [  264.657137] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  264.657306] EXT4-fs error: 135 callbacks suppressed
> [  264.657308] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3434213, depth: 1 pblock 0
> [  264.657317] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  264.657317] EXT4-fs: 425 callbacks suppressed
> [  264.657318] EXT4-fs (zram0): I/O error while writing superblock
> [  264.657320] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3434213 with max blocks 1024 with error 117
> [  264.657320] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  264.700710] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  264.700885] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3435237, depth: 1 pblock 0
> [  264.700895] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  264.700896] EXT4-fs (zram0): I/O error while writing superblock
> [  264.700897] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3435237 with max blocks 1024 with error 117
> [  264.700898] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  264.726900] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  264.727099] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3436261, depth: 1 pblock 0
> [  264.727108] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  264.727109] EXT4-fs (zram0): I/O error while writing superblock
> [  264.727111] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3436261 with max blocks 1024 with error 117
> [  264.727111] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  264.770185] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  264.770350] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3437285, depth: 1 pblock 0
> [  264.770358] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  264.770359] EXT4-fs (zram0): I/O error while writing superblock
> [  264.796424] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  264.796565] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3438309, depth: 1 pblock 0
> [  264.796574] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  264.831159] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3439333, depth: 1 pblock 0
> [  264.874361] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3440357, depth: 1 pblock 0
> [  264.900612] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3441381, depth: 1 pblock 0
> [  264.935164] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3442405, depth: 1 pblock 0
> [  264.978716] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3443429, depth: 1 pblock 0
> [  270.272815] buffer_io_error: 314 callbacks suppressed
> [  270.272816] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  270.272964] EXT4-fs error: 152 callbacks suppressed
> [  270.272966] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3600101, depth: 1 pblock 0
> [  270.272974] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  270.272975] EXT4-fs: 476 callbacks suppressed
> [  270.272975] EXT4-fs (zram0): I/O error while writing superblock
> [  270.272976] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3600101 with max blocks 1024 with error 117
> [  270.272977] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  270.273192] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  270.273295] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3601125, depth: 1 pblock 0
> [  270.273301] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  270.273302] EXT4-fs (zram0): I/O error while writing superblock
> [  270.273303] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3601125 with max blocks 1024 with error 117
> [  270.273303] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  270.273478] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  270.273569] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3602149, depth: 1 pblock 0
> [  270.273574] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  270.273574] EXT4-fs (zram0): I/O error while writing superblock
> [  270.273575] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3602149 with max blocks 1024 with error 117
> [  270.273575] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  270.273782] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  270.273910] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3603173, depth: 1 pblock 0
> [  270.273915] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  270.273915] EXT4-fs (zram0): I/O error while writing superblock
> [  270.274083] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  270.274182] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3604197, depth: 1 pblock 0
> [  270.274186] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  270.274448] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3605221, depth: 1 pblock 0
> [  270.274747] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3606245, depth: 1 pblock 0
> [  270.275011] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3607269, depth: 1 pblock 0
> [  270.275333] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3608293, depth: 1 pblock 0
> [  270.275687] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:2: bad extent address lblock: 3609317, depth: 1 pblock 0
> [  275.306957] buffer_io_error: 280 callbacks suppressed
> [  275.306958] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  275.307087] EXT4-fs error: 135 callbacks suppressed
> [  275.307089] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3748581, depth: 1 pblock 0
> [  275.307097] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  275.307097] EXT4-fs: 425 callbacks suppressed
> [  275.307098] EXT4-fs (zram0): I/O error while writing superblock
> [  275.307100] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3748581 with max blocks 1024 with error 117
> [  275.307100] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  275.341811] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  275.341961] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3749605, depth: 1 pblock 0
> [  275.341971] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  275.341972] EXT4-fs (zram0): I/O error while writing superblock
> [  275.341974] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3749605 with max blocks 1024 with error 117
> [  275.341975] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  275.368033] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  275.368176] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3750629, depth: 1 pblock 0
> [  275.368184] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  275.368185] EXT4-fs (zram0): I/O error while writing superblock
> [  275.368186] EXT4-fs (zram0): Delayed block allocation failed for inode 12 at logical offset 3750629 with max blocks 1024 with error 117
> [  275.368187] EXT4-fs (zram0): This should not happen!! Data will be lost
> 
> [  275.411167] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  275.411304] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3751653, depth: 1 pblock 0
> [  275.411313] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  275.411314] EXT4-fs (zram0): I/O error while writing superblock
> [  275.445796] Buffer I/O error on dev zram0, logical block 1067, lost async page write
> [  275.445942] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3752677, depth: 1 pblock 0
> [  275.445951] Buffer I/O error on dev zram0, logical block 0, lost sync page write
> [  275.480548] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3753701, depth: 1 pblock 0
> [  275.514852] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3754725, depth: 1 pblock 0
> [  275.549841] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3755749, depth: 1 pblock 0
> [  275.584815] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3756773, depth: 1 pblock 0
> [  275.619386] EXT4-fs error (device zram0): ext4_ext_map_blocks:4054: inode #12: comm kworker/u16:17: bad extent address lblock: 3757797, depth: 1 pblock 0

