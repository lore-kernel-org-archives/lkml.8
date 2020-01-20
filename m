Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40222C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5D9920679
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 04:11:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVPHj78M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729098AbgATELv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 23:11:51 -0500
Received: from mail-pj1-f48.google.com ([209.85.216.48]:39040 "EHLO
        mail-pj1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgATELu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 23:11:50 -0500
Received: by mail-pj1-f48.google.com with SMTP id e11so6475382pjt.4;
        Sun, 19 Jan 2020 20:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kqTipXcERxxNQzN84wIRq5T5s8OHmc89Bmr44Qlf0GU=;
        b=AVPHj78My0r52Ba4rwkgO5mgJiq1tZzFT/JcmfjP74B4HAUUZDTwn2GvS7qvhv4Nvz
         YmxXkIdXsb5/Cho7WBFrSI0tSBz1zUk9MufCsPZ+tgK7VJfJyZjPDNnA2riooFPOIk6k
         /xXYSg4tr3UcSo9SHwhTSDl4OkorruIyrfmffZvgK04NWbCBZOEPX5Xn8tYBiCRyCxWW
         FspOJm0m2ys3UuAQJDCWbcigRwK23XX275jlf/hPJYUYGuCu9gWSgh7VKdpxFrDbVfZt
         F2uOKgTL/UAMnwfo29wdeCjh7H6j0LCmu2dziEYBEIq2h5xqEQJGzuQ04zn/r0di/Tqd
         54LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kqTipXcERxxNQzN84wIRq5T5s8OHmc89Bmr44Qlf0GU=;
        b=Da6286J3R5ZJGZtHgpVLucopUwT8eT//SAVoFhL5gnwymaBnvrS/1+X6tsWD7pe2Gc
         MZEWnoA/uGYMiiHDK6v6j121J0M4cZhy32JPzc2C13C9iLRAC+kjw+nQO7ZG6J5DCoQ+
         FF00Vrgx7REAhBZZ3ZQbZCzj4N8zQfWkcb1GD00KZLGyhPp5cFVN3tSig25mvzNPfuOt
         3nYNbSBY1MA0R32P2ZpBem8eKbew+/LswlkvOiZGKxTlpUtYrpzZCAUqrgmkIanJFoyX
         csv2ccLLthPstwh3pv+ieZeyPMqDQA62amck5Ul0/Qh167ciiFRJAO1IqCo/5hgGw/ZI
         x/FA==
X-Gm-Message-State: APjAAAUDS2D0QgNovBYAOwoxoGxwiFfMfgOw1RxSwV1CSt33PnuyOedx
        TqfrDnzkDtft9D3T8VFsPyDGGoh9KWg=
X-Google-Smtp-Source: APXvYqyeAj5Ukf8ypCq0JvWXDSjT2kyKH3fdbmQPovVu8APgJUYToPgZngmBLzhiJiJ8CNhJQZyolQ==
X-Received: by 2002:a17:90a:c390:: with SMTP id h16mr21658747pjt.131.1579493509259;
        Sun, 19 Jan 2020 20:11:49 -0800 (PST)
Received: from EliteBook (174-17-125-110.phnx.qwest.net. [174.17.125.110])
        by smtp.gmail.com with ESMTPSA id e19sm15457288pjr.10.2020.01.19.20.11.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 20:11:48 -0800 (PST)
Date:   Sun, 19 Jan 2020 21:11:45 -0700
From:   Paul Zimmerman <pauldzim@gmail.com>
To:     David Heinzelmann <heinzelmann.david@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before
 resusciation")
Message-ID: <20200119211145.7dcc86ec@EliteBook>
In-Reply-To: <20200115153714.03d5b3aa@EliteBook>
References: <20200115153714.03d5b3aa@EliteBook>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I reported this regression last week (see
https://lore.kernel.org/linux-usb/20200115153714.03d5b3aa@EliteBook/T/#u)
but I got no response to my email. Today I have retested with 5.5-rc7
and verified that the problem still exists. So I am resending with a
different subject line to see if anyone responds.

The $subject patch causes a regression on my HP EliteBook laptop with a
built-in USB bluetooth adapter. About 50% of the time, a suspend/resume
cycle will cause the bluetooth adapter to stop working.

The dmesg log below shows two suspend/resume cycles. At time 63.928 you can
see the bluetooth adapter being successfully resumed, and at time 140.969
you can see it fail. After reverting the patch, the bluetooth adapter
resumes 100% of the time.

I also included below a lsusb -v of the bluetooth adapter. Is there any
other debugging info you'd like me to send?

This misbehavior goes back at least to 5.5-rc1.

[   49.249536] wlo1: deauthenticating from 58:8b:f3:44:8f:5c by local choice (Reason: 3=DEAUTH_LEAVING)
[   59.300552] PM: suspend entry (deep)
[   59.305440] Filesystems sync: 0.004 seconds
[   59.305859] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   59.307450] OOM killer disabled.
[   59.307451] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   59.308604] printk: Suspending console(s) (use no_console_suspend to debug)
[   59.343478] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[   59.344508] sd 0:0:0:0: [sda] Stopping disk
[   59.424472] e1000e: EEE TX LPI TIMER: 00000011
[   59.852914] radeon 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:1c.4 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[   59.876708] [drm] PCIE gen 2 link speeds already enabled
[   59.886714] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[   59.886808] radeon 0000:03:00.0: WB enabled
[   59.886810] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x000000000c629f9f
[   59.886810] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x00000000dee9b232
[   59.886811] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x00000000eddb39fc
[   59.886812] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000004e1d27c
[   59.886813] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x0000000043709b8a
[   59.887627] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000fa6308aa
[   59.988072] radeon 0000:03:00.0: failed VCE resume (-110).
[   60.220341] [drm] ring test on 0 succeeded in 1 usecs
[   60.220346] [drm] ring test on 1 succeeded in 1 usecs
[   60.220351] [drm] ring test on 2 succeeded in 1 usecs
[   60.220359] [drm] ring test on 3 succeeded in 5 usecs
[   60.220367] [drm] ring test on 4 succeeded in 5 usecs
[   60.396050] [drm] ring test on 5 succeeded in 2 usecs
[   60.396056] [drm] UVD initialized successfully.
[   60.396117] [drm] ib test on ring 0 succeeded in 0 usecs
[   60.396179] [drm] ib test on ring 1 succeeded in 0 usecs
[   60.396225] [drm] ib test on ring 2 succeeded in 0 usecs
[   60.396267] [drm] ib test on ring 3 succeeded in 0 usecs
[   60.396321] [drm] ib test on ring 4 succeeded in 0 usecs
[   61.075516] [drm] ib test on ring 5 succeeded
[   61.987920] ACPI: EC: interrupt blocked
[   62.031807] ACPI: Preparing to enter system sleep state S3
[   62.034281] ACPI: EC: event blocked
[   62.034282] ACPI: EC: EC stopped
[   62.034282] PM: Saving platform NVS memory
[   62.034294] Disabling non-boot CPUs ...
[   62.034559] IRQ 42: no longer affine to CPU1
[   62.034562] IRQ 43: no longer affine to CPU1
[   62.034566] IRQ 45: no longer affine to CPU1
[   62.034569] IRQ 46: no longer affine to CPU1
[   62.034573] IRQ 51: no longer affine to CPU1
[   62.035897] smpboot: CPU 1 is now offline
[   62.036390] IRQ 53: no longer affine to CPU2
[   62.037397] smpboot: CPU 2 is now offline
[   62.037937] IRQ 1: no longer affine to CPU3
[   62.037940] IRQ 8: no longer affine to CPU3
[   62.037942] IRQ 9: no longer affine to CPU3
[   62.037944] IRQ 12: no longer affine to CPU3
[   62.038958] smpboot: CPU 3 is now offline
[   62.040172] ACPI: Low-level resume complete
[   62.040270] ACPI: EC: EC started
[   62.040271] PM: Restoring platform NVS memory
[   62.047040] Enabling non-boot CPUs ...
[   62.047141] x86: Booting SMP configuration:
[   62.047144] smpboot: Booting Node 0 Processor 1 APIC 0x1
[   62.049459] CPU1 is up
[   62.049539] smpboot: Booting Node 0 Processor 2 APIC 0x2
[   62.055736] CPU2 is up
[   62.055797] smpboot: Booting Node 0 Processor 3 APIC 0x3
[   62.057475] CPU3 is up
[   62.060610] ACPI: Waking up from system sleep state S3
[   62.202438] ACPI: EC: interrupt unblocked
[   62.313530] ACPI: EC: event unblocked
[   62.324891] sd 0:0:0:0: [sda] Starting disk
[   62.327013] [drm] PCIE gen 2 link speeds already enabled
[   62.337552] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[   62.337645] radeon 0000:03:00.0: WB enabled
[   62.337647] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x000000000c629f9f
[   62.337648] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x00000000dee9b232
[   62.337648] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x00000000eddb39fc
[   62.337649] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000004e1d27c
[   62.337650] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x0000000043709b8a
[   62.338447] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000fa6308aa
[   62.439210] radeon 0000:03:00.0: failed VCE resume (-110).
[   62.609068] usb 2-5: reset full-speed USB device number 3 using xhci_hcd
[   62.635003] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[   62.643521] ata1.00: supports DRM functions and may not be fully accessible
[   62.673227] [drm] ring test on 0 succeeded in 1 usecs
[   62.673232] [drm] ring test on 1 succeeded in 1 usecs
[   62.673237] [drm] ring test on 2 succeeded in 1 usecs
[   62.673246] [drm] ring test on 3 succeeded in 5 usecs
[   62.673253] [drm] ring test on 4 succeeded in 5 usecs
[   62.692012] ata1.00: ATA Identify Device Log not supported
[   62.692013] ata1.00: Security Log not supported
[   62.740856] ata1.00: supports DRM functions and may not be fully accessible
[   62.789506] ata1.00: ATA Identify Device Log not supported
[   62.789506] ata1.00: Security Log not supported
[   62.789509] ata1.00: configured for UDMA/100
[   62.837092] usb 2-3.2: reset full-speed USB device number 4 using xhci_hcd
[   62.849223] [drm] ring test on 5 succeeded in 2 usecs
[   62.849228] [drm] UVD initialized successfully.
[   62.849290] [drm] ib test on ring 0 succeeded in 0 usecs
[   62.849355] [drm] ib test on ring 1 succeeded in 0 usecs
[   62.849414] [drm] ib test on ring 2 succeeded in 0 usecs
[   62.849461] [drm] ib test on ring 3 succeeded in 0 usecs
[   62.849514] [drm] ib test on ring 4 succeeded in 0 usecs
[   63.509106] [drm] ib test on ring 5 succeeded
[   63.901356] tpm tpm0: tpm_try_transmit: send(): error -5
[   63.906084] acpi LNXPOWER:02: Turning OFF
[   63.906128] acpi LNXPOWER:01: Turning OFF
[   63.906162] OOM killer enabled.
[   63.906163] Restarting tasks ... 
[   63.906304] acpi PNP0501:00: Still not present
[   63.910752] done.
[   63.928642] Bluetooth: hci0: read Intel version: 370710018002030d00
[   63.928646] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[   63.985337] PM: suspend exit
[   64.035638] Bluetooth: hci0: unexpected event for opcode 0xfc2f
[   64.051657] Bluetooth: hci0: Intel firmware patch completed and activated
[   64.161465] e1000e: enp0s25 NIC Link is Down
[   65.270730] psmouse serio3: synaptics: queried max coordinates: x [..5658], y [..4706]
[   65.305008] psmouse serio3: synaptics: queried min coordinates: x [1368..], y [1234..]
[   68.471403] e1000e: enp0s25 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[   68.471457] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s25: link becomes ready
[   71.144846] wlo1: authenticate with 58:8b:f3:44:8f:5c
[   71.149124] wlo1: send auth to 58:8b:f3:44:8f:5c (try 1/3)
[   71.153318] wlo1: authenticated
[   71.157026] wlo1: associate with 58:8b:f3:44:8f:5c (try 1/3)
[   71.160772] wlo1: RX AssocResp from 58:8b:f3:44:8f:5c (capab=0x1011 status=0 aid=8)
[   71.162365] wlo1: associated
[   71.197208] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[  126.321068] wlo1: deauthenticating from 58:8b:f3:44:8f:5c by local choice (Reason: 3=DEAUTH_LEAVING)
[  136.367748] PM: suspend entry (deep)
[  136.377378] Filesystems sync: 0.009 seconds
[  136.378191] Freezing user space processes ... (elapsed 0.002 seconds) done.
[  136.381154] OOM killer disabled.
[  136.381155] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[  136.382553] printk: Suspending console(s) (use no_console_suspend to debug)
[  136.411098] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[  136.412116] sd 0:0:0:0: [sda] Stopping disk
[  136.477379] e1000e: EEE TX LPI TIMER: 00000011
[  136.883799] radeon 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:1c.4 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[  136.909481] [drm] PCIE gen 2 link speeds already enabled
[  136.920054] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[  136.920147] radeon 0000:03:00.0: WB enabled
[  136.920148] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x000000000c629f9f
[  136.920149] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x00000000dee9b232
[  136.920150] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x00000000eddb39fc
[  136.920151] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000004e1d27c
[  136.920152] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x0000000043709b8a
[  136.920945] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000fa6308aa
[  137.021396] radeon 0000:03:00.0: failed VCE resume (-110).
[  137.254078] [drm] ring test on 0 succeeded in 1 usecs
[  137.254083] [drm] ring test on 1 succeeded in 1 usecs
[  137.254088] [drm] ring test on 2 succeeded in 1 usecs
[  137.254097] [drm] ring test on 3 succeeded in 5 usecs
[  137.254105] [drm] ring test on 4 succeeded in 5 usecs
[  137.429787] [drm] ring test on 5 succeeded in 2 usecs
[  137.429792] [drm] UVD initialized successfully.
[  137.429843] [drm] ib test on ring 0 succeeded in 0 usecs
[  137.429889] [drm] ib test on ring 1 succeeded in 0 usecs
[  137.429934] [drm] ib test on ring 2 succeeded in 0 usecs
[  137.429977] [drm] ib test on ring 3 succeeded in 0 usecs
[  137.430021] [drm] ib test on ring 4 succeeded in 0 usecs
[  138.107123] [drm] ib test on ring 5 succeeded
[  139.027561] ACPI: EC: interrupt blocked
[  139.067824] ACPI: Preparing to enter system sleep state S3
[  139.070169] ACPI: EC: event blocked
[  139.070170] ACPI: EC: EC stopped
[  139.070172] PM: Saving platform NVS memory
[  139.070190] Disabling non-boot CPUs ...
[  139.070688] irq_migrate_all_off_this_cpu: 5 callbacks suppressed
[  139.070691] IRQ 42: no longer affine to CPU1
[  139.070698] IRQ 43: no longer affine to CPU1
[  139.070705] IRQ 45: no longer affine to CPU1
[  139.070713] IRQ 50: no longer affine to CPU1
[  139.070719] IRQ 51: no longer affine to CPU1
[  139.072626] smpboot: CPU 1 is now offline
[  139.073667] IRQ 53: no longer affine to CPU2
[  139.074689] smpboot: CPU 2 is now offline
[  139.076006] IRQ 1: no longer affine to CPU3
[  139.076013] IRQ 8: no longer affine to CPU3
[  139.076017] IRQ 9: no longer affine to CPU3
[  139.076022] IRQ 12: no longer affine to CPU3
[  139.077062] smpboot: CPU 3 is now offline
[  139.079093] ACPI: Low-level resume complete
[  139.079199] ACPI: EC: EC started
[  139.079201] PM: Restoring platform NVS memory
[  139.086013] Enabling non-boot CPUs ...
[  139.086111] x86: Booting SMP configuration:
[  139.086114] smpboot: Booting Node 0 Processor 1 APIC 0x1
[  139.088429] CPU1 is up
[  139.088507] smpboot: Booting Node 0 Processor 2 APIC 0x2
[  139.094759] CPU2 is up
[  139.094820] smpboot: Booting Node 0 Processor 3 APIC 0x3
[  139.096582] CPU3 is up
[  139.100117] ACPI: Waking up from system sleep state S3
[  139.240985] ACPI: EC: interrupt unblocked
[  139.354665] ACPI: EC: event unblocked
[  139.358374] sd 0:0:0:0: [sda] Starting disk
[  139.370787] [drm] PCIE gen 2 link speeds already enabled
[  139.380867] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[  139.380960] radeon 0000:03:00.0: WB enabled
[  139.380961] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x000000000c629f9f
[  139.380962] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x00000000dee9b232
[  139.380963] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x00000000eddb39fc
[  139.380964] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000004e1d27c
[  139.380965] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x0000000043709b8a
[  139.381803] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000fa6308aa
[  139.482569] radeon 0000:03:00.0: failed VCE resume (-110).
[  139.645301] usb 2-5: reset full-speed USB device number 3 using xhci_hcd
[  139.675546] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[  139.682220] ata1.00: supports DRM functions and may not be fully accessible
[  139.716719] [drm] ring test on 0 succeeded in 1 usecs
[  139.716724] [drm] ring test on 1 succeeded in 1 usecs
[  139.716729] [drm] ring test on 2 succeeded in 1 usecs
[  139.716738] [drm] ring test on 3 succeeded in 5 usecs
[  139.716746] [drm] ring test on 4 succeeded in 5 usecs
[  139.730748] ata1.00: ATA Identify Device Log not supported
[  139.730749] ata1.00: Security Log not supported
[  139.779570] ata1.00: supports DRM functions and may not be fully accessible
[  139.828221] ata1.00: ATA Identify Device Log not supported
[  139.828222] ata1.00: Security Log not supported
[  139.828224] ata1.00: configured for UDMA/100
[  139.873303] usb 2-3.2: reset full-speed USB device number 4 using xhci_hcd
[  139.892715] [drm] ring test on 5 succeeded in 2 usecs
[  139.892721] [drm] UVD initialized successfully.
[  139.892785] [drm] ib test on ring 0 succeeded in 0 usecs
[  139.892850] [drm] ib test on ring 1 succeeded in 0 usecs
[  139.892926] [drm] ib test on ring 2 succeeded in 0 usecs
[  139.892980] [drm] ib test on ring 3 succeeded in 0 usecs
[  139.893023] [drm] ib test on ring 4 succeeded in 0 usecs
[  140.573268] [drm] ib test on ring 5 succeeded
[  140.941885] tpm tpm0: tpm_try_transmit: send(): error -5
[  140.952149] acpi LNXPOWER:02: Turning OFF
[  140.952214] acpi LNXPOWER:01: Turning OFF
[  140.952256] OOM killer enabled.
[  140.952257] Restarting tasks ... 
[  140.952433] acpi PNP0501:00: Still not present
[  140.953050] done.
[  140.969200] Bluetooth: hci0: read Intel version: 370710018002030d00
[  140.969204] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[  140.971196] Bluetooth: hci0: sending Intel patch command (0xfc8e) failed (-16)
[  140.977133] usb 2-3.2: USB disconnect, device number 4
[  141.034495] PM: suspend exit
[  141.193736] e1000e: enp0s25 NIC Link is Down
[  142.320662] psmouse serio3: synaptics: queried max coordinates: x [..5658], y [..4706]
[  142.354225] psmouse serio3: synaptics: queried min coordinates: x [1368..], y [1234..]
[  142.973317] Bluetooth: hci0: Exiting manufacturer mode failed (-110)
[  142.973321] Bluetooth: hci0: command 0xfc11 tx timeout
[  143.261354] usb 2-3.2: new full-speed USB device number 8 using xhci_hcd
[  143.363390] usb 2-3.2: New USB device found, idVendor=8087, idProduct=07dc, bcdDevice= 0.01
[  143.363394] usb 2-3.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[  143.372219] Bluetooth: hci0: unexpected event for opcode 0xfc11
[  145.405426] Bluetooth: hci0: command 0xfc05 tx timeout
[  145.405431] Bluetooth: hci0: Reading Intel version information failed (-110)
[  145.535740] e1000e: enp0s25 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[  145.535782] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s25: link becomes ready
[  147.421518] Bluetooth: hci0: command 0x0c03 tx timeout
[  148.122192] wlo1: authenticate with 58:8b:f3:44:8f:5c
[  148.125506] wlo1: send auth to 58:8b:f3:44:8f:5c (try 1/3)
[  148.128140] wlo1: authenticated
[  148.129567] wlo1: associate with 58:8b:f3:44:8f:5c (try 1/3)
[  148.134895] wlo1: RX AssocResp from 58:8b:f3:44:8f:5c (capab=0x1011 status=0 aid=8)
[  148.136495] wlo1: associated
[  148.172360] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[  155.517826] Bluetooth: hci0: sending initial HCI reset command failed (-110)

Bus 002 Device 004: ID 8087:07dc Intel Corp. 
Couldn't open device, some information will be missing
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x8087 Intel Corp.
  idProduct          0x07dc 
  bcdDevice            0.01
  iManufacturer           0 
  iProduct                0 
  iSerial                 0 
  bNumConfigurations      1
  Configuration Descriptor:
    bLength                 9
    bDescriptorType         2
    wTotalLength          177
    bNumInterfaces          2
    bConfigurationValue     1
    iConfiguration          0 
    bmAttributes         0xe0
      Self Powered
      Remote Wakeup
    MaxPower              100mA
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        0
      bAlternateSetting       0
      bNumEndpoints           3
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x81  EP 1 IN
        bmAttributes            3
          Transfer Type            Interrupt
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x02  EP 2 OUT
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x82  EP 2 IN
        bmAttributes            2
          Transfer Type            Bulk
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0040  1x 64 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       0
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0000  1x 0 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       1
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0009  1x 9 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       2
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0011  1x 17 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       3
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0019  1x 25 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       4
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0021  1x 33 bytes
        bInterval               1
    Interface Descriptor:
      bLength                 9
      bDescriptorType         4
      bInterfaceNumber        1
      bAlternateSetting       5
      bNumEndpoints           2
      bInterfaceClass       224 Wireless
      bInterfaceSubClass      1 Radio Frequency
      bInterfaceProtocol      1 Bluetooth
      iInterface              0 
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x03  EP 3 OUT
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1
      Endpoint Descriptor:
        bLength                 7
        bDescriptorType         5
        bEndpointAddress     0x83  EP 3 IN
        bmAttributes            1
          Transfer Type            Isochronous
          Synch Type               None
          Usage Type               Data
        wMaxPacketSize     0x0031  1x 49 bytes
        bInterval               1

Thanks, 
Paul
