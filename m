Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67FF2C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AE2622522
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 20:52:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Je1OUHJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgATUwW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 15:52:22 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41173 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgATUwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 15:52:21 -0500
Received: by mail-pl1-f196.google.com with SMTP id t14so329379plr.8;
        Mon, 20 Jan 2020 12:52:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20W3kHQ2ooYhQoQvia2Gc3zF0AucBdu+8E+2mCx01kg=;
        b=Je1OUHJZsVQZjxP9ZNAIX68khadS41TWuBX1qjxDQObdqid8K3ulgrg+kZkUwKMNx1
         TZ38qRt7BuXIt7dHwty9llBmqToCdwSIBkLOtIVM76uRenF7cga5WL2QozTacSz2XZ5F
         tSBZ0biV2h164zZTD4+i1ejusu8VYJT4nVe+gDNBGN75YR3rM8RPCP5JvPY7BtxkpXlK
         2nkcl4yfZKi6KMF1sFeBTMwN7ki35pNT1/81EVITEFabgVYPr0+UbbHZMcK+5pIvjH8/
         lfV7jpuZcyPJYHKS04O0UOzDXeO4IEHn8jOOFnoWH+1F5K3kpxpAiQ9DzpAarY4Dj4+s
         LVyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20W3kHQ2ooYhQoQvia2Gc3zF0AucBdu+8E+2mCx01kg=;
        b=UllzReGfz6VM+eBwLB0VKS4PvIxNH2MG+weYB6vsZvbMK8u2yoto8kDtnqdjUXzsw/
         TALtIs8EOhnWhili5xYGBSq+qRaKnCGDnMD1RsXyXU7f0NKh++oFB7gR8FGWR1tdFW6t
         uPZWX7B4R0QV80TN99s+vtCIN5lby++k/kKLqFDl8u0bcvBYojIg8xhO7uw6vqmBnYiw
         dF0hf63bssuX1AlDq3i7usoqV6E2N6ByTvMsKwXmSGIk3GjTlZehyKreaV4B9ajTTPC3
         2eIrFvS0ZkZxKO5E0OR+nN4lHHFurOjpzvk4/H6nMnrE/XhswrMOx8OddlTfIbLP8fHD
         yK5A==
X-Gm-Message-State: APjAAAVN4OzRt6dzUGZFMVjr77vcc7u0hBruf2pE53ooLCiufqW5hIFJ
        CA7e+g0aKc8IfF1DS90Qsy4=
X-Google-Smtp-Source: APXvYqw/oKicg+ExJpWd2pWfofzJAGUEjZWWg5WsQSV9mY9XEgHAHnX+RNPCOJUZdDWLAbEBDNL7Rw==
X-Received: by 2002:a17:90a:eb14:: with SMTP id j20mr948246pjz.95.1579553538829;
        Mon, 20 Jan 2020 12:52:18 -0800 (PST)
Received: from EliteBook (174-17-125-110.phnx.qwest.net. [174.17.125.110])
        by smtp.gmail.com with ESMTPSA id v13sm42156509pgc.54.2020.01.20.12.52.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jan 2020 12:52:18 -0800 (PST)
Date:   Mon, 20 Jan 2020 13:52:15 -0700
From:   Paul Zimmerman <pauldzim@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     David Heinzelmann <heinzelmann.david@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>
Subject: Re: [REGRESSION][BISECTED] 5.5-rc suspend/resume failure caused by
 patch a4f55d8b8c14 ("usb: hub: Check device descriptor before
 resusciation")
Message-ID: <20200120135215.27c8d826@EliteBook>
In-Reply-To: <Pine.LNX.4.44L0.2001201016300.16814-100000@netrider.rowland.org>
References: <20200119211145.7dcc86ec@EliteBook>
        <Pine.LNX.4.44L0.2001201016300.16814-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 10:23:11 -0500 (EST) Alan Stern <stern@rowland.harvard.edu> wrote:

> On Sun, 19 Jan 2020, Paul Zimmerman wrote:
> 
> > I reported this regression last week (see
> > https://lore.kernel.org/linux-usb/20200115153714.03d5b3aa@EliteBook/T/#u)
> > but I got no response to my email. Today I have retested with
> > 5.5-rc7 and verified that the problem still exists. So I am
> > resending with a different subject line to see if anyone responds.
> > 
> > The $subject patch causes a regression on my HP EliteBook laptop
> > with a built-in USB bluetooth adapter. About 50% of the time, a
> > suspend/resume cycle will cause the bluetooth adapter to stop
> > working.
> > 
> > The dmesg log below shows two suspend/resume cycles. At time 63.928
> > you can see the bluetooth adapter being successfully resumed, and
> > at time 140.969 you can see it fail. After reverting the patch, the
> > bluetooth adapter resumes 100% of the time.
> > 
> > I also included below a lsusb -v of the bluetooth adapter. Is there
> > any other debugging info you'd like me to send?  
> 
> It looks like your dmesg log was made without enabling debugging 
> messages in usbcore.  Can you collect another log with debugging 
> messages turned on?
> 
> 	echo 'module usbcore =p'
> >/sys/kernel/debug/dynamic_debug/control
> 
> Also, it might not hurt to collect and post a usbmon trace for a bad
> suspend-resume cycle.

Hi Alan,

Thanks for responding. The new dmesg log and the usbmon trace are below.
The dmesg shows a good suspend/resume followed by a bad one. The
bluetooth device is usb 2-3.2 I believe. The usbmon trace is only for
the failed suspend/resume case.

[ 1235.712529] wlo1: deauthenticating from 58:8b:f3:44:8f:5c by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1245.764338] PM: suspend entry (deep)
[ 1245.774056] Filesystems sync: 0.009 seconds
[ 1245.774884] Freezing user space processes ... (elapsed 0.003 seconds) done.
[ 1245.778388] OOM killer disabled.
[ 1245.778390] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 1245.779934] printk: Suspending console(s) (use no_console_suspend to debug)
[ 1245.780920] usb 2-5: usb suspend, wakeup 0
[ 1245.780947] usb usb3: usb auto-resume
[ 1245.780968] hub 3-0:1.0: hub_resume
[ 1245.781038] usb usb3-port3: status 0263 change 0000
[ 1245.781062] usb usb1: usb auto-resume
[ 1245.781086] hub 1-0:1.0: hub_resume
[ 1245.781111] usb usb1-port1: status 0507 change 0000
[ 1245.781219] usb 1-1: usb auto-resume
[ 1245.795011] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1245.796132] sd 0:0:0:0: [sda] Stopping disk
[ 1245.806970] usb 3-3: usb auto-resume
[ 1245.827005] usb 2-3: usb auto-resume
[ 1245.847092] usb 1-1: Waited 0ms for CONNECT
[ 1245.847100] usb 1-1: finish resume
[ 1245.847368] hub 1-1:1.0: hub_resume
[ 1245.848381] hub 1-1:1.0: hub_suspend
[ 1245.850120] usb 1-1: usb suspend, wakeup 0
[ 1245.850153] hub 1-0:1.0: hub_suspend
[ 1245.850197] usb usb1: bus suspend, wakeup 0
[ 1245.873393] e1000e: EEE TX LPI TIMER: 00000011
[ 1245.874977] usb 3-3: Waited 0ms for CONNECT
[ 1245.874983] usb 3-3: finish resume
[ 1245.875803] hub 3-3:1.0: hub_resume
[ 1245.876840] hub 3-3:1.0: hub_suspend
[ 1245.898946] usb 2-3: Waited 0ms for CONNECT
[ 1245.898949] usb 2-3: finish resume
[ 1245.899039] hub 2-3:1.0: hub_resume
[ 1245.899127] usb 2-3-port2: status 0101 change 0000
[ 1245.899194] hub 2-3:1.0: hub_suspend
[ 1245.899236] usb 2-3: usb suspend, wakeup 0
[ 1245.899246] hub 2-0:1.0: hub_suspend
[ 1245.899260] usb usb2: bus suspend, wakeup 0
[ 1245.902913] usb 3-3: usb suspend, wakeup 0
[ 1245.923026] hub 3-0:1.0: hub_suspend
[ 1245.923076] usb usb3: bus suspend, wakeup 0
[ 1246.280222] radeon 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:1c.4 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[ 1246.309024] [drm] PCIE gen 2 link speeds already enabled
[ 1246.319037] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[ 1246.319133] radeon 0000:03:00.0: WB enabled
[ 1246.319135] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x0000000067be349a
[ 1246.319136] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x0000000057315ff0
[ 1246.319137] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x000000001e461818
[ 1246.319138] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000058e3f68e
[ 1246.319139] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x000000004beb9f61
[ 1246.319932] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000a33a1135
[ 1246.420369] radeon 0000:03:00.0: failed VCE resume (-110).
[ 1246.652894] [drm] ring test on 0 succeeded in 1 usecs
[ 1246.652899] [drm] ring test on 1 succeeded in 1 usecs
[ 1246.652904] [drm] ring test on 2 succeeded in 1 usecs
[ 1246.652913] [drm] ring test on 3 succeeded in 5 usecs
[ 1246.652921] [drm] ring test on 4 succeeded in 5 usecs
[ 1246.828587] [drm] ring test on 5 succeeded in 2 usecs
[ 1246.828592] [drm] UVD initialized successfully.
[ 1246.828652] [drm] ib test on ring 0 succeeded in 0 usecs
[ 1246.828716] [drm] ib test on ring 1 succeeded in 0 usecs
[ 1246.828773] [drm] ib test on ring 2 succeeded in 0 usecs
[ 1246.828822] [drm] ib test on ring 3 succeeded in 0 usecs
[ 1246.828875] [drm] ib test on ring 4 succeeded in 0 usecs
[ 1247.503113] [drm] ib test on ring 5 succeeded
[ 1248.415476] ACPI: EC: interrupt blocked
[ 1248.419491] ehci-pci 0000:00:1d.0: wakeup: 1
[ 1248.419739] xhci_hcd 0000:00:14.0: wakeup: 1
[ 1248.439187] ehci-pci 0000:00:1d.0: --> PCI D3hot
[ 1248.439911] xhci_hcd 0000:00:14.0: --> PCI D3hot
[ 1248.459698] ACPI: Preparing to enter system sleep state S3
[ 1248.462575] ACPI: EC: event blocked
[ 1248.462576] ACPI: EC: EC stopped
[ 1248.462577] PM: Saving platform NVS memory
[ 1248.462595] Disabling non-boot CPUs ...
[ 1248.463112] irq_migrate_all_off_this_cpu: 5 callbacks suppressed
[ 1248.463115] IRQ 42: no longer affine to CPU1
[ 1248.463122] IRQ 43: no longer affine to CPU1
[ 1248.463129] IRQ 45: no longer affine to CPU1
[ 1248.463135] IRQ 46: no longer affine to CPU1
[ 1248.463142] IRQ 50: no longer affine to CPU1
[ 1248.463147] IRQ 51: no longer affine to CPU1
[ 1248.464200] smpboot: CPU 1 is now offline
[ 1248.465679] IRQ 53: no longer affine to CPU2
[ 1248.467608] smpboot: CPU 2 is now offline
[ 1248.468470] IRQ 1: no longer affine to CPU3
[ 1248.468476] IRQ 8: no longer affine to CPU3
[ 1248.468480] IRQ 9: no longer affine to CPU3
[ 1248.469542] smpboot: CPU 3 is now offline
[ 1248.471041] ACPI: Low-level resume complete
[ 1248.471147] ACPI: EC: EC started
[ 1248.471148] PM: Restoring platform NVS memory
[ 1248.477905] Enabling non-boot CPUs ...
[ 1248.478010] x86: Booting SMP configuration:
[ 1248.478012] smpboot: Booting Node 0 Processor 1 APIC 0x1
[ 1248.480324] CPU1 is up
[ 1248.480405] smpboot: Booting Node 0 Processor 2 APIC 0x2
[ 1248.486595] CPU2 is up
[ 1248.486653] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 1248.488352] CPU3 is up
[ 1248.491870] ACPI: Waking up from system sleep state S3
[ 1248.633481] ACPI: EC: interrupt unblocked
[ 1248.746351] ACPI: EC: event unblocked
[ 1248.746891] usb usb2: usb resume
[ 1248.747065] usb usb3: usb resume
[ 1248.747083] hub 3-0:1.0: hub_resume
[ 1248.747149] usb usb3-port3: status 0263 change 0000
[ 1248.749813] usb usb1: usb resume
[ 1248.750514] sd 0:0:0:0: [sda] Starting disk
[ 1248.761789] [drm] PCIE gen 2 link speeds already enabled
[ 1248.771990] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[ 1248.772082] radeon 0000:03:00.0: WB enabled
[ 1248.772084] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x0000000067be349a
[ 1248.772085] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x0000000057315ff0
[ 1248.772085] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x000000001e461818
[ 1248.772086] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000058e3f68e
[ 1248.772087] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x000000004beb9f61
[ 1248.772907] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000a33a1135
[ 1248.780678] usb 3-3: usb resume
[ 1248.803705] hub 2-0:1.0: hub_resume
[ 1248.803731] usb usb2-port3: status 0503 change 0000
[ 1248.803742] usb usb2-port5: status 0101 change 0001
[ 1248.803764] usb usb2-port8: status 0101 change 0001
[ 1248.811674] hub 1-0:1.0: hub_resume
[ 1248.811684] usb usb1-port1: status 0503 change 0000
[ 1248.811714] usb 1-1: Waited 0ms for CONNECT
[ 1248.811715] usb 1-1: finish resume
[ 1248.811856] hub 1-1:1.0: hub_resume
[ 1248.848681] usb 3-3: Waited 0ms for CONNECT
[ 1248.848682] usb 3-3: finish resume
[ 1248.849265] hub 3-3:1.0: hub_resume
[ 1248.873684] radeon 0000:03:00.0: failed VCE resume (-110).
[ 1248.908694] usb 2-3: Waited 0ms for CONNECT
[ 1248.908696] usb 2-3: finish resume
[ 1248.908701] usb 2-5: Waited 0ms for CONNECT
[ 1248.908703] usb 2-5: finish reset-resume
[ 1248.908729] hub 2-3:1.0: hub_resume
[ 1248.908817] usb 2-3-port2: status 0101 change 0001
[ 1249.036846] usb 2-5: reset full-speed USB device number 3 using xhci_hcd
[ 1249.063115] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1249.064338] ata1.00: supports DRM functions and may not be fully accessible
[ 1249.109274] [drm] ring test on 0 succeeded in 1 usecs
[ 1249.109279] [drm] ring test on 1 succeeded in 1 usecs
[ 1249.109284] [drm] ring test on 2 succeeded in 1 usecs
[ 1249.109293] [drm] ring test on 3 succeeded in 5 usecs
[ 1249.109301] [drm] ring test on 4 succeeded in 5 usecs
[ 1249.112864] ata1.00: ATA Identify Device Log not supported
[ 1249.112864] ata1.00: Security Log not supported
[ 1249.161705] ata1.00: supports DRM functions and may not be fully accessible
[ 1249.184676] usb 2-5: ep0 maxpacket = 8
[ 1249.210351] ata1.00: ATA Identify Device Log not supported
[ 1249.210352] ata1.00: Security Log not supported
[ 1249.210355] ata1.00: configured for UDMA/100
[ 1249.285285] [drm] ring test on 5 succeeded in 1 usecs
[ 1249.285290] [drm] UVD initialized successfully.
[ 1249.285346] [drm] ib test on ring 0 succeeded in 0 usecs
[ 1249.285395] [drm] ib test on ring 1 succeeded in 0 usecs
[ 1249.285443] [drm] ib test on ring 2 succeeded in 0 usecs
[ 1249.285487] [drm] ib test on ring 3 succeeded in 0 usecs
[ 1249.285543] [drm] ib test on ring 4 succeeded in 0 usecs
[ 1249.936824] [drm] ib test on ring 5 succeeded
[ 1250.341517] tpm tpm0: tpm_try_transmit: send(): error -5
[ 1250.352206] acpi LNXPOWER:02: Turning OFF
[ 1250.352269] acpi LNXPOWER:01: Turning OFF
[ 1250.352307] OOM killer enabled.
[ 1250.352308] Restarting tasks ... 
[ 1250.352431] hub 3-0:1.0: state 7 ports 4 chg 0000 evt 0008
[ 1250.352433] hub 2-3:1.0: state 7 ports 4 chg 0004 evt 0000
[ 1250.352453] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1250.352457] hub 2-0:1.0: state 7 ports 9 chg 0120 evt 0008
[ 1250.352465] hub 3-3:1.0: state 7 ports 4 chg 0000 evt 0000
[ 1250.352474] acpi PNP0501:00: Still not present
[ 1250.352644] hub 1-1:1.0: state 7 ports 8 chg 0120 evt 0000
[ 1250.353658] usb usb2-port5: status 0103, change 0000, 12 Mb/s
[ 1250.354135] done.
[ 1250.354599] usb 2-3-port2: status 0101, change 0000, 12 Mb/s
[ 1250.356441] hub 3-3:1.0: hub_suspend
[ 1250.356474] usb usb2-port8: status 0101, change 0000, 12 Mb/s
[ 1250.361270] usb 1-1-port5: status 0100, change 0000, 12 Mb/s
[ 1250.361464] usb 1-1-port8: status 0100, change 0000, 12 Mb/s
[ 1250.361472] hub 1-1:1.0: hub_suspend
[ 1250.363749] usb 1-1: usb auto-suspend, wakeup 1
[ 1250.380707] hub 1-0:1.0: hub_suspend
[ 1250.380716] usb usb1: bus auto-suspend, wakeup 1
[ 1250.392694] usb 3-3: usb auto-suspend, wakeup 1
[ 1250.412743] hub 3-0:1.0: hub_suspend
[ 1250.412754] usb usb3: bus auto-suspend, wakeup 1
[ 1250.432698] usb 2-3.2: new full-speed USB device number 20 using xhci_hcd
[ 1250.438289] PM: suspend exit
[ 1250.537993] usb 2-3.2: udev 20, busnum 2, minor = 147
[ 1250.537995] usb 2-3.2: New USB device found, idVendor=8087, idProduct=07dc, bcdDevice= 0.01
[ 1250.537996] usb 2-3.2: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[ 1250.538084] usb 2-3.2: usb_probe_device
[ 1250.538087] usb 2-3.2: configuration #1 chosen from 1 choice
[ 1250.545229] usb 2-3.2: adding 2-3.2:1.0 (config #1, interface 0)
[ 1250.545277] btusb 2-3.2:1.0: usb_probe_interface
[ 1250.545280] btusb 2-3.2:1.0: usb_probe_interface - got id
[ 1250.546873] usb 2-3.2: adding 2-3.2:1.1 (config #1, interface 1)
[ 1250.558249] Bluetooth: hci0: read Intel version: 370710018002030d00
[ 1250.558282] Bluetooth: hci0: Intel Bluetooth firmware file: intel/ibt-hw-37.7.10-fw-1.80.2.3.d.bseq
[ 1250.604695] usb usb2-port8: not reset yet, waiting 60ms
[ 1250.613782] e1000e: enp0s25 NIC Link is Down
[ 1250.666242] Bluetooth: hci0: unexpected event for opcode 0xfc2f
[ 1250.672701] usb usb2-port8: not reset yet, waiting 200ms
[ 1250.682244] Bluetooth: hci0: Intel firmware patch completed and activated
[ 1250.880714] usb usb2-port8: not reset yet, waiting 200ms
[ 1251.088702] usb usb2-port8: not reset yet, waiting 200ms
[ 1251.296784] usb usb2-port8: not reset yet, waiting 200ms
[ 1251.296860] hub 2-0:1.0: state 7 ports 9 chg 0000 evt 0100
[ 1251.296873] usb usb2-port8: status 0100, change 0001, 12 Mb/s
[ 1251.440846] usb usb2-port8: debounce total 100ms stable 100ms status 0x100
[ 1251.720031] psmouse serio3: synaptics: queried max coordinates: x [..5658], y [..4706]
[ 1251.754626] psmouse serio3: synaptics: queried min coordinates: x [1368..], y [1234..]
[ 1253.662989] e1000e: enp0s25 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[ 1253.663021] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s25: link becomes ready
[ 1257.469186] wlo1: authenticate with 58:8b:f3:44:8f:5c
[ 1257.473261] wlo1: send auth to 58:8b:f3:44:8f:5c (try 1/3)
[ 1257.480321] wlo1: authenticated
[ 1257.480782] wlo1: associate with 58:8b:f3:44:8f:5c (try 1/3)
[ 1257.484530] wlo1: RX AssocResp from 58:8b:f3:44:8f:5c (capab=0x1011 status=0 aid=12)
[ 1257.486319] wlo1: associated
[ 1257.514490] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[ 1306.040671] wlo1: deauthenticating from 58:8b:f3:44:8f:5c by local choice (Reason: 3=DEAUTH_LEAVING)
[ 1316.086506] PM: suspend entry (deep)
[ 1316.099332] Filesystems sync: 0.012 seconds
[ 1316.100109] Freezing user space processes ... (elapsed 0.003 seconds) done.
[ 1316.103470] OOM killer disabled.
[ 1316.103471] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[ 1316.104968] printk: Suspending console(s) (use no_console_suspend to debug)
[ 1316.105973] usb usb3: usb auto-resume
[ 1316.105994] hub 3-0:1.0: hub_resume
[ 1316.106032] usb 2-5: usb suspend, wakeup 0
[ 1316.106053] usb usb3-port3: status 0263 change 0000
[ 1316.106057] usb usb1: usb auto-resume
[ 1316.106079] hub 1-0:1.0: hub_resume
[ 1316.106110] usb usb1-port1: status 0507 change 0000
[ 1316.106213] usb 1-1: usb auto-resume
[ 1316.111455] usb 2-3.2: usb suspend, wakeup 0
[ 1316.111478] hub 2-3:1.0: hub_suspend
[ 1316.111561] usb 2-3: usb suspend, wakeup 0
[ 1316.121686] sd 0:0:0:0: [sda] Synchronizing SCSI cache
[ 1316.124238] sd 0:0:0:0: [sda] Stopping disk
[ 1316.133587] usb 3-3: usb auto-resume
[ 1316.153175] hub 2-0:1.0: hub_suspend
[ 1316.153242] usb usb2: bus suspend, wakeup 0
[ 1316.173548] usb 1-1: Waited 0ms for CONNECT
[ 1316.173552] usb 1-1: finish resume
[ 1316.173792] hub 1-1:1.0: hub_resume
[ 1316.174741] hub 1-1:1.0: hub_suspend
[ 1316.176905] usb 1-1: usb suspend, wakeup 0
[ 1316.176962] hub 1-0:1.0: hub_suspend
[ 1316.177009] usb usb1: bus suspend, wakeup 0
[ 1316.200175] e1000e: EEE TX LPI TIMER: 00000011
[ 1316.201557] usb 3-3: Waited 0ms for CONNECT
[ 1316.201563] usb 3-3: finish resume
[ 1316.202218] hub 3-3:1.0: hub_resume
[ 1316.203037] hub 3-3:1.0: hub_suspend
[ 1316.229515] usb 3-3: usb suspend, wakeup 0
[ 1316.249606] hub 3-0:1.0: hub_suspend
[ 1316.249647] usb usb3: bus suspend, wakeup 0
[ 1316.618973] radeon 0000:03:00.0: 16.000 Gb/s available PCIe bandwidth, limited by 5 GT/s x4 link at 0000:00:1c.4 (capable of 63.008 Gb/s with 8 GT/s x8 link)
[ 1316.645911] [drm] PCIE gen 2 link speeds already enabled
[ 1316.655907] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[ 1316.656001] radeon 0000:03:00.0: WB enabled
[ 1316.656003] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x0000000067be349a
[ 1316.656004] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x0000000057315ff0
[ 1316.656005] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x000000001e461818
[ 1316.656006] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000058e3f68e
[ 1316.656007] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x000000004beb9f61
[ 1316.656800] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000a33a1135
[ 1316.757238] radeon 0000:03:00.0: failed VCE resume (-110).
[ 1316.989936] [drm] ring test on 0 succeeded in 1 usecs
[ 1316.989941] [drm] ring test on 1 succeeded in 1 usecs
[ 1316.989946] [drm] ring test on 2 succeeded in 1 usecs
[ 1316.989955] [drm] ring test on 3 succeeded in 5 usecs
[ 1316.989961] [drm] ring test on 4 succeeded in 4 usecs
[ 1317.165662] [drm] ring test on 5 succeeded in 2 usecs
[ 1317.165668] [drm] UVD initialized successfully.
[ 1317.165717] [drm] ib test on ring 0 succeeded in 0 usecs
[ 1317.165762] [drm] ib test on ring 1 succeeded in 0 usecs
[ 1317.165807] [drm] ib test on ring 2 succeeded in 0 usecs
[ 1317.165850] [drm] ib test on ring 3 succeeded in 0 usecs
[ 1317.165893] [drm] ib test on ring 4 succeeded in 0 usecs
[ 1317.841699] [drm] ib test on ring 5 succeeded
[ 1318.754062] ACPI: EC: interrupt blocked
[ 1318.758954] ehci-pci 0000:00:1d.0: wakeup: 1
[ 1318.759155] xhci_hcd 0000:00:14.0: wakeup: 1
[ 1318.777761] ehci-pci 0000:00:1d.0: --> PCI D3hot
[ 1318.778773] xhci_hcd 0000:00:14.0: --> PCI D3hot
[ 1318.798212] ACPI: Preparing to enter system sleep state S3
[ 1318.801253] ACPI: EC: event blocked
[ 1318.801254] ACPI: EC: EC stopped
[ 1318.801255] PM: Saving platform NVS memory
[ 1318.801272] Disabling non-boot CPUs ...
[ 1318.801706] irq_migrate_all_off_this_cpu: 5 callbacks suppressed
[ 1318.801708] IRQ 42: no longer affine to CPU1
[ 1318.801714] IRQ 43: no longer affine to CPU1
[ 1318.801720] IRQ 45: no longer affine to CPU1
[ 1318.801727] IRQ 51: no longer affine to CPU1
[ 1318.803648] smpboot: CPU 1 is now offline
[ 1318.804671] IRQ 53: no longer affine to CPU2
[ 1318.805698] smpboot: CPU 2 is now offline
[ 1318.807024] IRQ 1: no longer affine to CPU3
[ 1318.807031] IRQ 8: no longer affine to CPU3
[ 1318.807036] IRQ 9: no longer affine to CPU3
[ 1318.807040] IRQ 12: no longer affine to CPU3
[ 1318.807046] IRQ 17: no longer affine to CPU3
[ 1318.808107] smpboot: CPU 3 is now offline
[ 1318.809463] ACPI: Low-level resume complete
[ 1318.809570] ACPI: EC: EC started
[ 1318.809572] PM: Restoring platform NVS memory
[ 1318.816336] Enabling non-boot CPUs ...
[ 1318.816440] x86: Booting SMP configuration:
[ 1318.816443] smpboot: Booting Node 0 Processor 1 APIC 0x1
[ 1318.818749] CPU1 is up
[ 1318.818829] smpboot: Booting Node 0 Processor 2 APIC 0x2
[ 1318.825049] CPU2 is up
[ 1318.825110] smpboot: Booting Node 0 Processor 3 APIC 0x3
[ 1318.826835] CPU3 is up
[ 1318.830400] ACPI: Waking up from system sleep state S3
[ 1318.970931] ACPI: EC: interrupt unblocked
[ 1319.085723] ACPI: EC: event unblocked
[ 1319.086598] usb usb1: usb resume
[ 1319.089935] usb usb2: usb resume
[ 1319.093882] usb usb3: usb resume
[ 1319.093904] hub 3-0:1.0: hub_resume
[ 1319.094030] usb usb3-port3: status 0263 change 0000
[ 1319.094450] sd 0:0:0:0: [sda] Starting disk
[ 1319.102011] [drm] PCIE gen 2 link speeds already enabled
[ 1319.112446] [drm] PCIE GART of 2048M enabled (table at 0x00000000001D6000).
[ 1319.112540] radeon 0000:03:00.0: WB enabled
[ 1319.112542] radeon 0000:03:00.0: fence driver on ring 0 use gpu addr 0x0000000040000c00 and cpu addr 0x0000000067be349a
[ 1319.112543] radeon 0000:03:00.0: fence driver on ring 1 use gpu addr 0x0000000040000c04 and cpu addr 0x0000000057315ff0
[ 1319.112544] radeon 0000:03:00.0: fence driver on ring 2 use gpu addr 0x0000000040000c08 and cpu addr 0x000000001e461818
[ 1319.112544] radeon 0000:03:00.0: fence driver on ring 3 use gpu addr 0x0000000040000c0c and cpu addr 0x0000000058e3f68e
[ 1319.112545] radeon 0000:03:00.0: fence driver on ring 4 use gpu addr 0x0000000040000c10 and cpu addr 0x000000004beb9f61
[ 1319.113348] radeon 0000:03:00.0: fence driver on ring 5 use gpu addr 0x0000000000075a18 and cpu addr 0x00000000a33a1135
[ 1319.119148] usb 3-3: usb resume
[ 1319.142165] hub 1-0:1.0: hub_resume
[ 1319.142179] usb usb1-port1: status 0503 change 0000
[ 1319.142214] usb 1-1: Waited 0ms for CONNECT
[ 1319.142215] usb 1-1: finish resume
[ 1319.142283] hub 1-1:1.0: hub_resume
[ 1319.146148] hub 2-0:1.0: hub_resume
[ 1319.146175] usb usb2-port3: status 0503 change 0000
[ 1319.146188] usb usb2-port5: status 0101 change 0001
[ 1319.146213] usb usb2-port8: status 0101 change 0001
[ 1319.187140] usb 3-3: Waited 0ms for CONNECT
[ 1319.187141] usb 3-3: finish resume
[ 1319.187713] hub 3-3:1.0: hub_resume
[ 1319.214130] radeon 0000:03:00.0: failed VCE resume (-110).
[ 1319.251188] usb 2-5: Waited 0ms for CONNECT
[ 1319.251190] usb 2-5: finish reset-resume
[ 1319.251199] usb 2-3: Waited 0ms for CONNECT
[ 1319.251201] usb 2-3: finish resume
[ 1319.251261] hub 2-3:1.0: hub_resume
[ 1319.251338] usb 2-3-port2: status 0101 change 0001
[ 1319.359171] usb 2-3.2: Waited 0ms for CONNECT
[ 1319.359172] usb 2-3.2: finish reset-resume
[ 1319.379314] usb 2-5: reset full-speed USB device number 3 using xhci_hcd
[ 1319.405650] ata1: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
[ 1319.414218] ata1.00: supports DRM functions and may not be fully accessible
[ 1319.450258] [drm] ring test on 0 succeeded in 1 usecs
[ 1319.450263] [drm] ring test on 1 succeeded in 1 usecs
[ 1319.450268] [drm] ring test on 2 succeeded in 1 usecs
[ 1319.450277] [drm] ring test on 3 succeeded in 5 usecs
[ 1319.450283] [drm] ring test on 4 succeeded in 4 usecs
[ 1319.462738] ata1.00: ATA Identify Device Log not supported
[ 1319.462739] ata1.00: Security Log not supported
[ 1319.511570] ata1.00: supports DRM functions and may not be fully accessible
[ 1319.527115] usb 2-5: ep0 maxpacket = 8
[ 1319.560250] ata1.00: ATA Identify Device Log not supported
[ 1319.560251] ata1.00: Security Log not supported
[ 1319.560253] ata1.00: configured for UDMA/100
[ 1319.607328] usb 2-3.2: reset full-speed USB device number 20 using xhci_hcd
[ 1319.626254] [drm] ring test on 5 succeeded in 2 usecs
[ 1319.626260] [drm] UVD initialized successfully.
[ 1319.626329] [drm] ib test on ring 0 succeeded in 0 usecs
[ 1319.626381] [drm] ib test on ring 1 succeeded in 0 usecs
[ 1319.626436] [drm] ib test on ring 2 succeeded in 0 usecs
[ 1319.626503] [drm] ib test on ring 3 succeeded in 0 usecs
[ 1319.626566] [drm] ib test on ring 4 succeeded in 0 usecs
[ 1319.708396] btusb 2-3.2:1.0: no reset_resume for driver btusb?
[ 1319.708397] btusb 2-3.2:1.1: no reset_resume for driver btusb?
[ 1319.708398] btusb 2-3.2:1.0: forced unbind
[ 1320.307364] [drm] ib test on ring 5 succeeded
[ 1320.679967] tpm tpm0: tpm_try_transmit: send(): error -5
[ 1320.690896] acpi LNXPOWER:02: Turning OFF
[ 1320.690961] acpi LNXPOWER:01: Turning OFF
[ 1320.691001] OOM killer enabled.
[ 1320.691002] Restarting tasks ... 
[ 1320.691189] acpi PNP0501:00: Still not present
[ 1320.691368] hub 3-3:1.0: state 7 ports 4 chg 0000 evt 0000
[ 1320.691373] hub 2-3:1.0: state 7 ports 4 chg 0004 evt 0000
[ 1320.692830] btusb 2-3.2:1.0: usb_probe_interface
[ 1320.692833] btusb 2-3.2:1.0: usb_probe_interface - got id
[ 1320.692959] hub 3-0:1.0: state 7 ports 4 chg 0000 evt 0008
[ 1320.692974] hub 1-0:1.0: state 7 ports 3 chg 0000 evt 0000
[ 1320.692977] hub 1-1:1.0: state 7 ports 8 chg 0120 evt 0000
[ 1320.693752] usb 1-1-port5: status 0100, change 0000, 12 Mb/s
[ 1320.693798] usb 2-3-port2: status 0103, change 0000, 12 Mb/s
[ 1320.694041] hub 2-0:1.0: state 7 ports 9 chg 0120 evt 0000
[ 1320.694058] usb usb2-port5: status 0103, change 0000, 12 Mb/s
[ 1320.694064] usb 1-1-port8: status 0100, change 0000, 12 Mb/s
[ 1320.694071] hub 1-1:1.0: hub_suspend
[ 1320.694251] done.
[ 1320.694837] hub 3-3:1.0: hub_suspend
[ 1320.696147] usb usb2-port8: status 0101, change 0000, 12 Mb/s
[ 1320.697084] usb 1-1: usb auto-suspend, wakeup 1
[ 1320.716855] hub 1-0:1.0: hub_suspend
[ 1320.716880] usb usb1: bus auto-suspend, wakeup 1
[ 1320.727189] usb 3-3: usb auto-suspend, wakeup 1
[ 1320.747227] hub 3-0:1.0: hub_suspend
[ 1320.747236] usb usb3: bus auto-suspend, wakeup 1
[ 1320.763319] usb usb2-port8: not reset yet, waiting 60ms
[ 1320.783921] PM: suspend exit
[ 1320.831328] usb usb2-port8: not reset yet, waiting 200ms
[ 1320.947718] e1000e: enp0s25 NIC Link is Down
[ 1321.039172] usb usb2-port8: not reset yet, waiting 200ms
[ 1321.247148] usb usb2-port8: not reset yet, waiting 200ms
[ 1321.455245] usb usb2-port8: not reset yet, waiting 200ms
[ 1321.455318] hub 2-0:1.0: state 7 ports 9 chg 0000 evt 0100
[ 1321.455336] usb usb2-port8: status 0100, change 0001, 12 Mb/s
[ 1321.599263] usb usb2-port8: debounce total 100ms stable 100ms status 0x100
[ 1322.062020] psmouse serio3: synaptics: queried max coordinates: x [..5658], y [..4706]
[ 1322.094600] psmouse serio3: synaptics: queried min coordinates: x [1368..], y [1234..]
[ 1322.707256] Bluetooth: hci0: Reading Intel version information failed (-110)
[ 1322.707260] Bluetooth: hci0: command 0xfc05 tx timeout
[ 1324.065460] e1000e: enp0s25 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: Rx/Tx
[ 1324.065490] IPv6: ADDRCONF(NETDEV_CHANGE): enp0s25: link becomes ready
[ 1324.723278] Bluetooth: hci0: command 0x0c03 tx timeout
[ 1325.717424] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/18
[ 1325.717431] usb 2-3.2: can't read device descriptor -110
[ 1325.717434] usb 2-3.2: USB disconnect, device number 20
[ 1325.717436] usb 2-3.2: unregistering device
[ 1325.717439] usb 2-3.2: unregistering interface 2-3.2:1.0
[ 1325.717558] xhci_hcd 0000:00:14.0: shutdown urb ffff9a6cbc38fa80 ep1in-intr
[ 1325.719493] xhci_hcd 0000:00:14.0: shutdown urb ffff9a6cbc38f180 ep2in-bulk
[ 1325.719499] xhci_hcd 0000:00:14.0: shutdown urb ffff9a6cbc38fd80 ep2in-bulk
[ 1325.721627] Bluetooth: hci0: sending initial HCI reset command failed (-19)
[ 1325.723991] usb 2-3.2: unregistering interface 2-3.2:1.1
[ 1325.724127] usb 2-3.2: usb_disable_device nuking all URBs
[ 1325.807315] usb 2-3.2: new full-speed USB device number 23 using xhci_hcd
[ 1328.056571] wlo1: authenticate with 58:8b:f3:44:8f:5c
[ 1328.060808] wlo1: send auth to 58:8b:f3:44:8f:5c (try 1/3)
[ 1328.066076] wlo1: authenticated
[ 1328.067277] wlo1: associate with 58:8b:f3:44:8f:5c (try 1/3)
[ 1328.072874] wlo1: RX AssocResp from 58:8b:f3:44:8f:5c (capab=0x1011 status=0 aid=12)
[ 1328.075184] wlo1: associated
[ 1328.099896] IPv6: ADDRCONF(NETDEV_CHANGE): wlo1: link becomes ready
[ 1330.837224] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1335.957600] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1341.077606] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1341.155553] usb 2-3.2: device descriptor read/64, error -110
[ 1346.453615] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1351.573728] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1356.693745] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1356.771742] usb 2-3.2: device descriptor read/64, error -110
[ 1356.959617] usb 2-3.2: new full-speed USB device number 24 using xhci_hcd
[ 1362.069897] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1367.189813] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1372.310022] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1372.387976] usb 2-3.2: device descriptor read/64, error -110
[ 1377.686028] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1382.806048] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1387.926136] usb 2-3.2: kworker/3:1 timed out on ep0in len=0/64
[ 1388.004163] usb 2-3.2: device descriptor read/64, error -110
[ 1388.112248] usb 2-3-port2: attempt power cycle
[ 1388.448275] hub 2-3:1.0: port_wait_reset: err = -11
[ 1388.448280] usb 2-3-port2: not enabled, trying reset again...
[ 1388.716065] usb 2-3.2: new full-speed USB device number 25 using xhci_hcd
[ 1393.812212] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[ 1394.020293] usb 2-3.2: Device not responding to setup address.
[ 1394.228149] usb 2-3.2: device not accepting address 25, error -71
[ 1394.308150] usb 2-3.2: new full-speed USB device number 26 using xhci_hcd
[ 1399.444262] xhci_hcd 0000:00:14.0: Timeout while waiting for setup device command
[ 1399.652400] usb 2-3.2: Device not responding to setup address.
[ 1399.860225] usb 2-3.2: device not accepting address 26, error -71
[ 1399.860462] usb 2-3-port2: unable to enumerate USB device
[ 1399.860595] hub 2-3:1.0: state 7 ports 4 chg 0000 evt 0004
[ 1399.860767] hub 2-3:1.0: hub_suspend
[ 1399.880251] usb 2-3: usb auto-suspend, wakeup 1

ffff9a6cfcad6e40 1303001511 S Co:2:020:0 s 20 00 0000 0000 0009 9 = 05200649 64f510b7 3d
ffff9a6cfcad6e40 1303001711 C Co:2:020:0 0 9 >
ffff9a6cfaae1180 1303002584 C Ii:2:020:1 0:1 6 = 0e040105 2000
ffff9a6cfaae1180 1303002605 S Ii:2:020:1 -115:1 64 <
ffff9a6cfcad6e40 1303002641 S Co:2:020:0 s 20 00 0000 0000 000a 10 = 0b200701 24001200 0100
ffff9a6cfcad6e40 1303002877 C Co:2:020:0 0 10 >
ffff9a6cfaae1180 1303003531 C Ii:2:020:1 0:1 6 = 0e04010b 2000
ffff9a6cfaae1180 1303003549 S Ii:2:020:1 -115:1 64 <
ffff9a6cfcad6e40 1303003576 S Co:2:020:0 s 20 00 0000 0000 0005 5 = 0c200201 01
ffff9a6cfcad6e40 1303003804 C Co:2:020:0 0 5 >
ffff9a6cfaae1180 1303004556 C Ii:2:020:1 0:1 6 = 0e04020c 2000
ffff9a6cfaae1180 1303004570 S Ii:2:020:1 -115:1 64 <
ffff9a6c502aac00 1303004589 S Co:2:020:0 s 20 00 0000 0000 0008 8 = 01040533 8b9e0800
ffff9a6c502aac00 1303004828 C Co:2:020:0 0 8 >
ffff9a6cfaae1180 1303005556 C Ii:2:020:1 0:1 6 = 0f040002 0104
ffff9a6cfaae1180 1303005568 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303055530 C Ii:2:020:1 0:1 32 = 3e1e0201 0001e07c b377515c 1202011a 020a0c0b ff4c0010 06031a2e b70af1d2
ffff9a6cfaae1180 1303055544 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303056552 C Ii:2:020:1 0:1 14 = 3e0c0201 0401e07c b377515c 00d2
ffff9a6cfaae1180 1303056563 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303073530 C Ii:2:020:1 0:1 31 = 3e1d0201 00015179 86e3bf57 1102011a 020a0c0a ff4c0010 05031820 2e44cc
ffff9a6cfaae1180 1303073539 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303074526 C Ii:2:020:1 0:1 14 = 3e0c0201 04015179 86e3bf57 00cc
ffff9a6cfaae1180 1303074531 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303098528 C Ii:2:020:1 0:1 29 = 3e1b0201 0000c82a 29e29914 0f02011a 0bff4c00 09060303 c0a8000b aa
ffff9a6cfaae1180 1303098538 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303109596 C Ii:2:020:1 0:1 42 = 3e280201 03007dce 6f7d495c 1c1bff75 00420401 80605c49 7d6fce7d 5e497d6f
ffff9a6cfaae1180 1303109614 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303185566 C Ii:2:020:1 0:1 45 = 3e2b0201 00015bc0 891804d0 1f020106 11061bc5 d5a50200 aa9de311 2af21019
ffff9a6cfaae1180 1303185593 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303186535 C Ii:2:020:1 0:1 38 = 3e240201 04015bc0 891804d0 18020a04 14094578 70657274 5f443030 34313838
ffff9a6cfaae1180 1303186549 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1303748637 C Ii:2:020:1 0:1 31 = 3e1d0201 0001aebf 2982ad72 1102011a 020a0c0a ff4c0010 05511cbe 012db1
ffff9a6cfaae1180 1303748657 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1304294599 C Ii:2:020:1 0:1 14 = 3e0c0201 0401aebf 2982ad72 00b3
ffff9a6cfaae1180 1304294626 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1304603523 C Ii:2:020:1 0:1 42 = 3e280201 0201ed2c 50e07a4f 1c03039f fe17169f fe000000 00000000 00000000
ffff9a6cfaae1180 1304603543 S Ii:2:020:1 -115:1 64 <
ffff9a6c502aad80 1304715749 S Co:2:020:0 s 20 00 0000 0000 0003 3 = 020400
ffff9a6c502aad80 1304715978 C Co:2:020:0 0 3 >
ffff9a6cfaae1180 1304716504 C Ii:2:020:1 0:1 6 = 0e040202 0400
ffff9a6cfaae1180 1304716512 S Ii:2:020:1 -115:1 64 <
ffff9a6c502aad80 1304716524 S Co:2:020:0 s 20 00 0000 0000 0005 5 = 0c200200 00
ffff9a6c502aad80 1304716725 C Co:2:020:0 0 5 >
ffff9a6cfaae1180 1304723520 C Ii:2:020:1 0:1 6 = 0e04020c 2000
ffff9a6cfaae1180 1304723535 S Ii:2:020:1 -115:1 64 <
ffff9a6cfaae1180 1316077522 C Ii:2:020:1 -2:1 0
ffff9a6cf334e300 1316079524 C Bi:2:020:2 -2 0
ffff9a6cfaae1480 1316081510 C Bi:2:020:2 -2 0
ffff9a6cf51a2b40 1316081627 C Ii:2:002:1 -2:2048 0
ffff9a6cf5c8f600 1316123311 C Ii:2:001:1 -2:2048 0
ffff9a6c502aa780 1319114635 S Ci:2:001:0 s a3 00 0000 0001 0004 4 <
ffff9a6c502aa780 1319114640 C Ci:2:001:0 0 4 = 00010000
ffff9a6cfa0d2540 1319114646 S Ci:2:001:0 s a3 00 0000 0002 0004 4 <
ffff9a6cfa0d2540 1319114649 C Ci:2:001:0 0 4 = 00010000
ffff9a6c502aad80 1319114653 S Ci:2:001:0 s a3 00 0000 0003 0004 4 <
ffff9a6c502aad80 1319114656 C Ci:2:001:0 0 4 = 03050000
ffff9a6cfa0d23c0 1319114661 S Ci:2:001:0 s a3 00 0000 0004 0004 4 <
ffff9a6cfa0d23c0 1319114664 C Ci:2:001:0 0 4 = 00010000
ffff9a6c502aab40 1319114667 S Ci:2:001:0 s a3 00 0000 0005 0004 4 <
ffff9a6c502aab40 1319114670 C Ci:2:001:0 0 4 = 01010100
ffff9a6cfa0d20c0 1319114674 S Co:2:001:0 s 23 01 0010 0005 0000 0
ffff9a6cfa0d20c0 1319114678 C Co:2:001:0 0 0
ffff9a6c502aa000 1319114681 S Ci:2:001:0 s a3 00 0000 0006 0004 4 <
ffff9a6c502aa000 1319114683 C Ci:2:001:0 0 4 = 00010000
ffff9a6cfa0d2780 1319114686 S Ci:2:001:0 s a3 00 0000 0007 0004 4 <
ffff9a6cfa0d2780 1319114689 C Ci:2:001:0 0 4 = 00010000
ffff9a6c502aacc0 1319114692 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aacc0 1319114694 C Ci:2:001:0 0 4 = 01010100
ffff9a6cfa0d2840 1319114698 S Co:2:001:0 s 23 01 0010 0008 0000 0
ffff9a6cfa0d2840 1319114702 C Co:2:001:0 0 0
ffff9a6c502aa900 1319114705 S Ci:2:001:0 s a3 00 0000 0009 0004 4 <
ffff9a6c502aa900 1319114707 C Ci:2:001:0 0 4 = 00010000
ffff9a6cf5c8f600 1319219617 S Ii:2:001:1 -115:2048 4 <
ffff9a6c502aaf00 1319219633 S Ci:2:001:0 s a3 00 0000 0005 0004 4 <
ffff9a6c502aaf00 1319219646 C Ci:2:001:0 0 4 = 01010000
ffff9a6cfa0d2e40 1319219672 S Ci:2:001:0 s a3 00 0000 0003 0004 4 <
ffff9a6cfa0d2e40 1319219675 C Ci:2:001:0 0 4 = 03050000
ffff9a6c502aaf00 1319219676 S Co:2:001:0 s 23 03 0004 0005 0000 0
ffff9a6c502aaf00 1319219682 C Co:2:001:0 0 0
ffff9a6cfcafa900 1319219686 S Ci:2:002:0 s 80 00 0000 0000 0002 2 <
ffff9a6cfcafa900 1319219702 C Ci:2:002:0 0 2 = 0100
ffff9a6cfcafa900 1319219746 S Ci:2:002:0 s a3 00 0000 0001 0004 4 <
ffff9a6cfcafa900 1319219759 C Ci:2:002:0 0 4 = 00010000
ffff9a6cfcafa900 1319219764 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cfcafa900 1319219798 C Ci:2:002:0 0 4 = 01010100
ffff9a6cfcafa900 1319219823 S Co:2:002:0 s 23 01 0010 0002 0000 0
ffff9a6cfcafa900 1319219839 C Co:2:002:0 0 0
ffff9a6cfcafa900 1319219878 S Ci:2:002:0 s a3 00 0000 0003 0004 4 <
ffff9a6cfcafa900 1319219890 C Ci:2:002:0 0 4 = 00010000
ffff9a6cfcafa900 1319219893 S Ci:2:002:0 s a3 00 0000 0004 0004 4 <
ffff9a6cfcafa900 1319219930 C Ci:2:002:0 0 4 = 00010000
ffff9a6cfa0d2240 1319287606 S Ci:2:001:0 s a3 00 0000 0005 0004 4 <
ffff9a6cfa0d2240 1319287610 C Ci:2:001:0 0 4 = 03011000
ffff9a6c502aa180 1319287618 S Co:2:001:0 s 23 01 0014 0005 0000 0
ffff9a6c502aa180 1319287624 C Co:2:001:0 0 0
ffff9a6cf51a2b40 1319327617 S Ii:2:002:1 -115:2048 1 <
ffff9a6cfcafa900 1319327631 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cfcafa900 1319327644 C Ci:2:002:0 0 4 = 01010000
ffff9a6c502aa240 1319347798 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6c502aa240 1319348057 C Ci:2:000:0 0 8 = 12011001 ff12ff08
ffff9a6c502aa240 1319348079 S Co:2:001:0 s 23 03 0004 0005 0000 0
ffff9a6c502aa240 1319348087 C Co:2:001:0 0 0
ffff9a6c502aa0c0 1319415616 S Ci:2:001:0 s a3 00 0000 0005 0004 4 <
ffff9a6c502aa0c0 1319415628 C Ci:2:001:0 0 4 = 03011000
ffff9a6cfa0d2240 1319415633 S Co:2:001:0 s 23 01 0014 0005 0000 0
ffff9a6cfa0d2240 1319415638 C Co:2:001:0 0 0
ffff9a6cfcafa900 1319495597 S Ci:2:003:0 s 80 06 0100 0000 0012 18 <
ffff9a6cfcafa900 1319495808 C Ci:2:003:0 0 18 = 12011001 ff12ff08 8a133f00 04010000 0101
ffff9a6cfcafa900 1319495815 S Ci:2:003:0 s 80 06 0200 0000 002e 46 <
ffff9a6cfa0d2e40 1319495817 S Co:2:002:0 s 23 03 0004 0002 0000 0
ffff9a6cfa0d2e40 1319495847 C Co:2:002:0 0 0
ffff9a6cfcafa900 1319496136 C Ci:2:003:0 0 46 = 09022e00 010100a0 32090400 0004ff00 00000705 01024000 00070581 02400000
ffff9a6cfcafa900 1319496139 S Ci:2:003:0 s 80 06 0301 0409 00ff 255 <
ffff9a6cfcafa900 1319496383 C Ci:2:003:0 0 26 = 1a033000 30006200 30003600 30003100 36003900 66003900 3300
ffff9a6cfcafa900 1319496591 S Co:2:003:0 s 00 09 0001 0000 0000 0
ffff9a6cfcafa900 1319496696 C Co:2:003:0 0 0
ffff9a6cfcafa900 1319496706 S Ci:2:003:0 s 80 00 0000 0000 0002 2 <
ffff9a6cfcafa900 1319496825 C Ci:2:003:0 0 2 = 0000
ffff9a6cfa0d2e40 1319515618 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cfa0d2e40 1319515646 C Ci:2:002:0 0 4 = 03011000
ffff9a6cfa0d2e40 1319515650 S Co:2:002:0 s 23 01 0014 0002 0000 0
ffff9a6cfa0d2e40 1319515703 C Co:2:002:0 0 0
ffff9a6cfa0d2e40 1319575809 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cfa0d2e40 1319575997 C Ci:2:000:0 0 18 = 12010002 e0010140 8780dc07 01000000 0001
ffff9a6cfa0d2e40 1319576002 S Co:2:002:0 s 23 03 0004 0002 0000 0
ffff9a6cfa0d2e40 1319576021 C Co:2:002:0 0 0
ffff9a6cfa0d2e40 1319595616 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cfa0d2e40 1319595635 C Ci:2:002:0 0 4 = 03011000
ffff9a6cfa0d2e40 1319595639 S Co:2:002:0 s 23 01 0014 0002 0000 0
ffff9a6cfa0d2e40 1319595690 C Co:2:002:0 0 0
ffff9a6cfa0d2e40 1319675620 S Ci:2:020:0 s 80 06 0100 0000 0012 18 <
ffff9a6cfa0d2e40 1319675813 C Ci:2:020:0 0 18 = 12010002 e0010140 8780dc07 01000000 0001
ffff9a6cfa0d2840 1319675820 S Ci:2:020:0 s 80 06 0200 0000 00b1 177 <
ffff9a6cfa0d2840 1319676280 C Ci:2:020:0 0 177 = 0902b100 020100e0 32090400 0003e001 01000705 81034000 01070502 02400001
ffff9a6cfa0d2e40 1319676502 S Co:2:020:0 s 00 09 0001 0000 0000 0
ffff9a6cfa0d2e40 1319676666 C Co:2:020:0 0 0
ffff9a6cfa0d2e40 1319676679 S Ci:2:020:0 s 80 00 0000 0000 0002 2 <
ffff9a6cfa0d2e40 1319676866 C Ci:2:020:0 0 2 = 0100
ffff9a6c502aaa80 1320661397 S Ii:2:020:1 -115:1 64 <
ffff9a6c502aa0c0 1320661402 S Bi:2:020:2 -115 1028 <
ffff9a6c502aa240 1320661404 S Bi:2:020:2 -115 1028 <
ffff9a6c502aa180 1320661411 S Co:2:020:0 s 20 00 0000 0000 0003 3 = 030c00
ffff9a6c502aa180 1320661563 C Co:2:020:0 0 3 >
ffff9a6cbc385cc0 1320662266 S Ci:2:020:0 s 80 06 0100 0000 0012 18 <
ffff9a6c502aacc0 1320662510 S Ci:2:001:0 s a3 00 0000 0005 0004 4 <
ffff9a6c502aacc0 1320662520 C Ci:2:001:0 0 4 = 03010000
ffff9a6c502aacc0 1320662526 S Ci:2:003:0 s 80 06 0100 0000 0012 18 <
ffff9a6c502aacc0 1320662781 C Ci:2:003:0 0 18 = 12011001 ff12ff08 8a133f00 04010000 0101
ffff9a6c502aacc0 1320662789 S Ci:2:003:0 s 80 06 0200 0000 002e 46 <
ffff9a6c502aacc0 1320663190 C Ci:2:003:0 0 46 = 09022e00 010100a0 32090400 0004ff00 00000705 01024000 00070581 02400000
ffff9a6c502aacc0 1320663198 S Ci:2:003:0 s 80 06 0301 0409 00ff 255 <
ffff9a6c502aacc0 1320663486 C Ci:2:003:0 0 26 = 1a033000 30006200 30003600 30003100 36003900 66003900 3300
ffff9a6c502aacc0 1320664598 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aacc0 1320664606 C Ci:2:001:0 0 4 = 01010000
ffff9a6c502aaf00 1320665526 S Co:2:001:0 s 23 03 0004 0008 0000 0
ffff9a6c502aaf00 1320665535 C Co:2:001:0 0 0
ffff9a6c502aaa80 1320673190 C Ii:2:020:1 0:1 6 = 0e040103 0c00
ffff9a6c502aaa80 1320673200 S Ii:2:020:1 -115:1 64 <
ffff9a6c501c8e40 1320673223 S Co:2:020:0 s 20 00 0000 0000 0003 3 = 05fc00
ffff9a6c502aad80 1320731723 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aad80 1320731772 C Ci:2:001:0 0 4 = 00011100
ffff9a6c502aa480 1320799773 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1320799786 C Ci:2:001:0 0 4 = 00011100
ffff9a6cf5c8f600 1320903644 C Ii:2:001:1 0:2048 2 = 0001
ffff9a6cf5c8f600 1320903681 S Ii:2:001:1 -115:2048 4 <
ffff9a6c502aa480 1321007614 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321007625 C Ci:2:001:0 0 4 = 00011100
ffff9a6cf5c8f600 1321151630 C Ii:2:001:1 0:2048 2 = 0001
ffff9a6cf5c8f600 1321151634 S Ii:2:001:1 -115:2048 4 <
ffff9a6c502aa480 1321215593 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321215600 C Ci:2:001:0 0 4 = 00011100
ffff9a6cf5c8f600 1321399677 C Ii:2:001:1 0:2048 2 = 0001
ffff9a6cf5c8f600 1321399686 S Ii:2:001:1 -115:2048 4 <
ffff9a6c502aa480 1321423630 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321423690 C Ci:2:001:0 0 4 = 00011100
ffff9a6c502aa480 1321423703 S Co:2:001:0 s 23 01 0014 0008 0000 0
ffff9a6c502aa480 1321423709 C Co:2:001:0 0 0
ffff9a6c502aa480 1321423712 S Co:2:001:0 s 23 01 0001 0008 0000 0
ffff9a6c502aa480 1321423717 C Co:2:001:0 0 0
ffff9a6c502aa480 1321423748 S Co:2:001:0 s 23 01 0001 0008 0000 0
ffff9a6c502aa480 1321423762 C Co:2:001:0 0 0
ffff9a6c502aa480 1321423776 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321423780 C Ci:2:001:0 0 4 = 00010100
ffff9a6c502aa480 1321423783 S Co:2:001:0 s 23 01 0010 0008 0000 0
ffff9a6c502aa480 1321423788 C Co:2:001:0 0 0
ffff9a6c502aa480 1321423794 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321423797 C Ci:2:001:0 0 4 = 00010000
ffff9a6c502aa480 1321459684 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321459703 C Ci:2:001:0 0 4 = 00010000
ffff9a6c502aa480 1321495686 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321495708 C Ci:2:001:0 0 4 = 00010000
ffff9a6c502aa480 1321531685 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321531702 C Ci:2:001:0 0 4 = 00010000
ffff9a6c502aa480 1321567682 S Ci:2:001:0 s a3 00 0000 0008 0004 4 <
ffff9a6c502aa480 1321567706 C Ci:2:001:0 0 4 = 00010000
ffff9a6c501c8e40 1322677771 C Co:2:020:0 -2 0
ffff9a6c502aaa80 1322679780 C Ii:2:020:1 -2:1 0
ffff9a6c502aa240 1322681774 C Bi:2:020:2 -2 0
ffff9a6c502aa0c0 1322683803 C Bi:2:020:2 -2 0
ffff9a6cbc38fa80 1322683895 S Ii:2:020:1 -115:1 64 <
ffff9a6cbc38fd80 1322683903 S Bi:2:020:2 -115 1028 <
ffff9a6cbc38f180 1322683904 S Bi:2:020:2 -115 1028 <
ffff9a6c502aa0c0 1322683960 S Co:2:020:0 s 20 00 0000 0000 0003 3 = 030c00
ffff9a6cbc385cc0 1325685692 C Ci:2:020:0 -2 0
ffff9a6cbc38fa80 1325687862 C Ii:2:020:1 -108:1 0
ffff9a6cbc38f180 1325689944 C Bi:2:020:2 -108 0
ffff9a6cbc38fd80 1325689963 C Bi:2:020:2 -108 0
ffff9a6c502aa0c0 1325692037 C Co:2:020:0 -2 0
ffff9a6c50049000 1325694270 S Co:2:002:0 s 23 03 0004 0002 0000 0
ffff9a6c50049000 1325694301 C Co:2:002:0 0 0
ffff9a6cf51a2b40 1325709999 C Ii:2:002:1 0:2048 1 = 04
ffff9a6cf51a2b40 1325710007 S Ii:2:002:1 -115:2048 1 <
ffff9a6c50049000 1325715616 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6c50049000 1325715638 C Ci:2:002:0 0 4 = 03011000
ffff9a6c50049000 1325715644 S Co:2:002:0 s 23 01 0014 0002 0000 0
ffff9a6c50049000 1325715677 C Co:2:002:0 0 0
ffff9a6c50049000 1325775868 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6c50049000 1330805543 C Ci:2:000:0 -2 0
ffff9a6cbc38ff00 1330805568 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cbc38ff00 1335925830 C Ci:2:000:0 -2 0
ffff9a6cf618a240 1335925888 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cf618a240 1341045768 C Ci:2:000:0 -2 0
ffff9a6cbc38ff00 1341045831 S Co:2:002:0 s 23 03 0004 0002 0000 0
ffff9a6cbc38ff00 1341045870 C Co:2:002:0 0 0
ffff9a6cbc38ff00 1341063703 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cbc38ff00 1341063763 C Ci:2:002:0 0 4 = 03011000
ffff9a6cbc38ff00 1341063792 S Co:2:002:0 s 23 01 0014 0002 0000 0
ffff9a6cbc38ff00 1341063825 C Co:2:002:0 0 0
ffff9a6cbc38ff00 1341231715 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cbc38ff00 1346421706 C Ci:2:000:0 -2 0
ffff9a6cbc38ff00 1346421771 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cbc38ff00 1351541768 C Ci:2:000:0 -2 0
ffff9a6cfd15c840 1351541821 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cfd15c840 1356661708 C Ci:2:000:0 -2 0
ffff9a6cbc385240 1356661777 S Co:2:002:0 s 23 03 0004 0002 0000 0
ffff9a6cbc385240 1356661813 C Co:2:002:0 0 0
ffff9a6cbc385240 1356679709 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cbc385240 1356679765 C Ci:2:002:0 0 4 = 03011000
ffff9a6cbc385240 1356679789 S Co:2:002:0 s 23 01 0014 0002 0000 0
ffff9a6cbc385240 1356679821 C Co:2:002:0 0 0
ffff9a6cbc385240 1356847713 S Co:2:002:0 s 23 01 0001 0002 0000 0
ffff9a6cbc385240 1356847762 C Co:2:002:0 0 0
ffff9a6cbc385240 1356847926 S Co:2:002:0 s 23 03 0004 0002 0000 0
ffff9a6cbc385240 1356847988 C Co:2:002:0 0 0
ffff9a6cbc385240 1356867618 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cbc385240 1356867662 C Ci:2:002:0 0 4 = 03011000
ffff9a6cbc385240 1356867676 S Co:2:002:0 s 23 01 0014 0002 0000 0
ffff9a6cbc385240 1356867701 C Co:2:002:0 0 0
ffff9a6cbc385240 1356927679 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cbc385240 1362037781 C Ci:2:000:0 -2 0
ffff9a6cbc385240 1362037862 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cbc385240 1367157662 C Ci:2:000:0 -2 0
ffff9a6cbc385240 1367157712 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cbc385240 1372277779 C Ci:2:000:0 -2 0
ffff9a6cbc385240 1372277865 S Co:2:002:0 s 23 03 0004 0002 0000 0
ffff9a6cbc385240 1372277901 C Co:2:002:0 0 0
ffff9a6cbc385240 1372295702 S Ci:2:002:0 s a3 00 0000 0002 0004 4 <
ffff9a6cbc385240 1372295759 C Ci:2:002:0 0 4 = 03011000
ffff9a6cbc385240 1372295827 S Co:2:002:0 s 23 01 0014 0002 0000 0
ffff9a6cbc385240 1372295865 C Co:2:002:0 0 0
ffff9a6cbc385240 1372471642 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <
ffff9a6cbc385240 1377653718 C Ci:2:000:0 -2 0
ffff9a6cbc385240 1377653807 S Ci:2:000:0 s 80 06 0100 0000 0040 64 <

Thanks,
Paul
