Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76ACBC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:18:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D7B6205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L+0MgA0F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726075AbgENDSr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 23:18:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55795 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725860AbgENDSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:18:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589426323;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type; bh=asqYu1Io84Hc74evsgnkwdMNUeCYVbUW4PlP/c85uvY=;
        b=L+0MgA0FX1qQhuRUiaSxqXEhdvRmvdbFHB4Sr9yu9I0j8C7H6r92fPaGEjcyuE9tKAUoTT
        efX9sO3Kbw24SRG80b/CBwFN80ZONqHlURYKl3jbhXblR5Q602Ds9XFPna4o3CsicNczsM
        DzEbT/4EAxhcGGGBJjQYuvSwBcoBVfo=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-330-cSFcwI-3NLmZFij_P-l4OA-1; Wed, 13 May 2020 23:18:42 -0400
X-MC-Unique: cSFcwI-3NLmZFij_P-l4OA-1
Received: by mail-qk1-f198.google.com with SMTP id f200so1827643qke.14
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 20:18:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:mime-version:content-disposition;
        bh=asqYu1Io84Hc74evsgnkwdMNUeCYVbUW4PlP/c85uvY=;
        b=dSd9I4s3YRgBfo45D42XND981EjLNQaE0/T8sqfyXl9ewZhmK0s09tRGaFEynQPBb3
         qeYHkfyYb/eOwtZmKpoXHYaklQE87/zyH3FXHrgPSWEfE3EGm3D2wRSK2kzRFpVcpvEQ
         W5PaN+9cai1b5ph8vwp7wSi+sVYSk3vjTY8cTB5En1EV2Mb8XfNU6Rnyjf1X5VwWWKLM
         loOHp2qVJKJ0kbGTg7nTGqtu4tuPLGFWihupaWApjpK0jpUvMQIEXTpp4LrkPVT12DXV
         UK6AiPhRbHqaghKANK2C8WRkYqHc2XSPDjU0ioIf01KETZoHCTQ0+jV0kXIxr68al5nO
         UBvQ==
X-Gm-Message-State: AOAM530Q8oAD420Q3lti4W7zbz0oUCqaLxrR9lngnyQ3d/zl2fcI/0GC
        BdALvnwTjpNtZwljPdxn07DOK61OMp3OD8WjS1ikMquZtz/WwHSajFooeDxtArjV+PtcvLGoqOy
        XaIu5hJ+wdpg+lsDvsIsy96D4
X-Received: by 2002:a05:620a:208f:: with SMTP id e15mr2675139qka.377.1589426321113;
        Wed, 13 May 2020 20:18:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwn2d7Jag/5cHR213Dg1PLABPyU6dlnEnCoEgKQlDFCue9b4NXw3YUiW0VH8dfCyNSF7FeVew==
X-Received: by 2002:a05:620a:208f:: with SMTP id e15mr2675112qka.377.1589426320577;
        Wed, 13 May 2020 20:18:40 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id i3sm1729197qkf.39.2020.05.13.20.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 20:18:39 -0700 (PDT)
Date:   Wed, 13 May 2020 20:18:38 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Cc:     Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Murphy <murphyt7@tcd.ie>
Subject: amd kdump failure with iommu=nopt
Message-ID: <20200514031838.2oklmyrc3n5it2ox@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Murphy <murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've seen kdump failures with recent kernels (5.5, 5.6, 5.7-rc1) on
amd systems when iommu is enabled in translation mode. In the cases so
far there has been mpt3sas involved, but I'm also seeing io page
faults for ahci right before mpt3sas has an io page fault:

[   15.156620] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b300 flags=0x0020]
[   15.166889] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b320 flags=0x0020]
[   15.177169] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   15.186100] ata4.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)
[   15.193786] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f730c0 flags=0x0020]
[   15.204059] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f732c0 flags=0x0020]
[   15.214327] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f734c0 flags=0x0020]
[   15.224597] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f736c0 flags=0x0020]
[   15.234867] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f738c0 flags=0x0020]
[   15.245138] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ac0 flags=0x0020]
[   15.255407] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73cc0 flags=0x0020]
[   15.265677] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ec0 flags=0x0020]
[   20.599101] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   20.916172] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   20.922429] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b300 flags=0x0020]
[   20.932703] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xfff9b320 flags=0x0020]
[   20.943234] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   20.949430] ata4.00: failed to IDENTIFY (device reports invalid type, err_mask=0x0)
[   20.957115] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f730c0 flags=0x0020]
[   20.967384] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f732c0 flags=0x0020]
[   20.977654] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f734c0 flags=0x0020]
[   20.987923] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f736c0 flags=0x0020]
[   20.998193] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f738c0 flags=0x0020]
[   21.008464] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ac0 flags=0x0020]
[   21.018733] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73cc0 flags=0x0020]
[   21.029005] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ec0 flags=0x0020]
[   26.231097] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   26.238415] ata2: limiting SATA link speed to 3.0 Gbps
[   26.548169] ata4: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   26.564483] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 320)
[   26.571026] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f730c0 flags=0x0020]
[   26.581301] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f732c0 flags=0x0020]
[   26.591568] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f734c0 flags=0x0020]
[   26.601839] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f736c0 flags=0x0020]
[   26.612109] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f738c0 flags=0x0020]
[   26.622377] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ac0 flags=0x0020]
[   26.632647] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73cc0 flags=0x0020]
[   26.642917] ahci 0000:63:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0042 address=0xf1f73ec0 flags=0x0020]
[   26.654047] ata2.00: failed to IDENTIFY (INIT_DEV_PARAMS failed, err_mask=0x80)
[   26.743097] xhci_hcd 0000:05:00.3: Error while assigning device slot ID
[   26.749718] xhci_hcd 0000:05:00.3: Max number of devices this xHCI host supports is 64.
[   26.757730] usb usb1-port2: couldn't allocate usb_device
[   26.987555] mpt3sas version 33.100.00.00 loaded
[   26.994668] mpt3sas_cm0: 63 BIT PCI BUS DMA ADDRESSING SUPPORTED, total mem (226256 kB)
[   27.060443] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
[   27.068469] mpt3sas_cm0: MSI-X vectors supported: 96
[   27.073444] 	 no of cores: 1, max_msix_vectors: -1
[   27.078244] mpt3sas_cm0:  0 1
[   27.081471] mpt3sas_cm0: High IOPs queues : disabled
[   27.086458] mpt3sas0-msix0: PCI-MSI-X enabled: IRQ 81
[   27.091525] mpt3sas_cm0: iomem(0x00000000cf600000), mapped(0x000000001e78b962), size(65536)
[   27.099884] mpt3sas_cm0: ioport(0x0000000000007000), size(256)
[   27.163505] mpt3sas_cm0: CurrentHostPageSize is 0: Setting default host page size to 4k
[   27.171515] mpt3sas_cm0: sending message unit reset !!
[   27.178166] mpt3sas_cm0: message unit reset: SUCCESS
[   27.210746] mpt3sas_cm0: scatter gather: sge_in_main_msg(1), sge_per_chain(7), sge_per_io(32), chains_per_io(5)
[   27.220864] mpt3sas_cm0: request pool(0x00000000fed2db53) - dma(0xfffe0000): depth(437), frame_size(128), pool_size(54 kB)
[   27.232004] mpt3sas_cm0: sense pool(0x000000009497c16e)- dma(0xfffb0000): depth(200),element_size(96), pool_size(18 kB)
[   27.242811] mpt3sas_cm0: config page(0x000000009f24a585) - dma(0xfff9e000): size(512)
[   27.250648] mpt3sas_cm0: Allocated physical memory: size(170 kB)
[   27.256658] mpt3sas_cm0: Current Controller Queue Depth(197),Max Controller Queue Depth(9584)
[   27.265187] mpt3sas_cm0: Scatter Gather Elements per IO(32)
[   27.315042] mpt3sas 0000:61:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0041 address=0xfffe9e80 flags=0x0000]
[   32.182274] ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 320)
[   29.241641] systemd-udevd[414]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   42.615097] mpt3sas_cm0: _base_display_fwpkg_version: complete
[   42.620943] mpt3sas_cm0: _base_display_fwpkg_version: timeout
[   42.626702] mf:
[   42.626702] 	
[   42.626703] 12000001 
[   42.630031] 00000000 
[   42.632319] 00000000 
[   42.634604] 00000000 
[   42.636891] 00000000 
[   42.639179] 00000000 
[   42.641466] 00000000 
[   42.643754] 00000100 
[   42.646041] 
[   42.646041] 	
[   42.648323] fff9d000 
[   42.651389] 00000000 
[   42.653677] 00000100 
[   42.655968] 40000000 
[   42.658255] 
[   42.662212] mpt3sas_cm0 fault info from func: _base_make_ioc_ready
[   42.668399] mpt3sas_cm0: fault_state(0x2623)!
[   42.672770] mpt3sas_cm0: sending diag reset !!
[   43.590290] mpt3sas_cm0: diag reset: SUCCESS
[   43.594953] mpt3sas_cm0: failure at drivers/scsi/mpt3sas/mpt3sas_scsih.c:10790/_scsih_probe()!
[  167.493060] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts
[  168.037841] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts
[  168.565044] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts
[  169.091831] dracut-initqueue[416]: Warning: dracut-initqueue timeout - starting timeout scripts

Actually testing just now on another system without mptsas it also fails. It doesn't show io page faults,
but there are some ata errors and it appears to be stuck waiting on a usb device:

[   19.037113] ata1.00: qc timeout (cmd 0xec)
[   19.041215] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   19.509122] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   29.789122] ata1.00: qc timeout (cmd 0xec)
[   29.793235] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   29.799324] ata1: limiting SATA link speed to 3.0 Gbps
[   30.269122] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   60.509121] ata1.00: qc timeout (cmd 0xec)
[   60.513227] ata1.00: failed to IDENTIFY (I/O error, err_mask=0x4)
[   60.981121] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 320)
[   61.098503] [drm] Using P2A bridge for configuration
[   61.103473] [drm] AST 2500 detected
[   61.106967] [drm] Analog VGA only
[   61.110297] [drm] dram MCLK=800 Mhz type=7 bus_width=16 size=01000000
[   61.118219] [TTM] Zone  kernel: Available graphics memory: 113168 KiB
[   61.124660] [TTM] Initializing pool allocator
[   61.129040] [TTM] Initializing DMA pool allocator
[   61.143850] fbcon: astdrmfb (fb0) is primary device
[   61.166392] Console: switching to colour frame buffer device 128x48
[   61.195840] ast 0000:64:00.0: fb0: astdrmfb frame buffer device
[   61.201763] [drm] Initialized ast 0.1.0 20120228 for 0000:64:00.0 on minor 0
[   55.456688] systemd-udevd[418]: link_config: autonegotiation is unset or enabled, the speed and duplex are not writable.
[   66.967202] systemd-udevd[395]: seq 3198 '/devices/pci0000:20/0000:20:08.1/0000:23:00.3/usb1' is taking a long time
[  186.967741] systemd-udevd[395]: seq 3198 '/devices/pci0000:20/0000:20:08.1/0000:23:00.3/usb1' killed
[  186.978323] systemd-udevd[395]: worker [419] terminated by signal 9 (KILL)
[  186.987747] systemd-udevd[395]: worker [419] failed while handling '/devices/pci0000:20/0000:20:08.1/0000:23:00.3/usb1'
[  253.021118] INFO: task kworker/0:1:12 blocked for more than 122 seconds.
[  253.027819]       Not tainted 5.5.0-1.elrdy.x86_64 #1
[  253.032871] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  253.040695] kworker/0:1     D    0    12      2 0x80004000
[  253.046181] Workqueue: usb_hub_wq hub_event
[  253.050361] Call Trace:
[  253.052820]  ? __schedule+0x25f/0x690
[  253.056477]  schedule+0x40/0xb0
[  253.059618]  schedule_timeout+0x20d/0x310
[  253.063628]  wait_for_completion+0x113/0x180
[  253.067895]  ? wake_up_q+0xa0/0xa0
[  253.071300]  xhci_alloc_dev+0x9b/0x270
[  253.075050]  usb_alloc_dev+0x6f/0x336
[  253.078708]  hub_port_connect+0x24d/0x850
[  253.082711]  port_event+0x569/0x850
[  253.086194]  hub_event+0x141/0x3a0
[  253.089594]  process_one_work+0x1a1/0x360
[  253.093605]  worker_thread+0x30/0x380
[  253.097262]  ? max_active_store+0x80/0x80
[  253.101266]  kthread+0x112/0x130
[  253.104489]  ? __kthread_parkme+0x70/0x70
[  253.108495]  ret_from_fork+0x22/0x40



It was bisected to:

commit be62dbf554c5b50718a54a359372c148cd9975c7
Author: Tom Murphy <murphyt7@tcd.ie>
Date:   Sun Sep 8 09:56:41 2019 -0700

     iommu/amd: Convert AMD iommu driver to the dma-iommu api
     
     Convert the AMD iommu driver to the dma-iommu api. Remove the iova
     handling and reserve region code from the AMD iommu driver.
     
     Signed-off-by: Tom Murphy <murphyt7@tcd.ie>
     Signed-off-by: Joerg Roedel <jroedel@suse.de>

I've reproduced with 5.7-rc4 + your latest fixes for amd_iommu. With passthrough mode kdump succeeds.

Regards,
Jerry

