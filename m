Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393BCC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:31:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DA582072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 09:31:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vD1K2c1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387767AbgDBJbh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 05:31:37 -0400
Received: from mail-wm1-f53.google.com ([209.85.128.53]:35236 "EHLO
        mail-wm1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbgDBJbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 05:31:36 -0400
Received: by mail-wm1-f53.google.com with SMTP id i19so2856652wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=98HEBPiTX0aD3yRnqTr3ggCDi/1mz/vXtTE23yid15E=;
        b=vD1K2c1WL4si1ajAZXFoDPHP/BjEqLOh8b3osiGpVteRFdKRBprFNSRJbvljV9tZrx
         5YN5yLS951Txt51ksklVfbvhxCJ/H/opFF7AWjwJdiNAX+4u8SUk5BTd4jrGz0mWvKG2
         iU7fzILjEP1ld21lkMPKNX+rP/gRx3AXi0GHbOGKojaGO2cZMbpdoaMuH/NCOEF+s3OB
         xYTNTMGrEQfHaTLAUBe/TP6LJfVYFthDSXNGAF88ANIM260zIm3Vr9Bmuog9lllGQquL
         jgK0RWPksO3KMch+nqo0MOcpwFaY+tPlEsiNlc1HoUj9MEfAsZwxtoUSLnafdMZ2Z04N
         Hfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=98HEBPiTX0aD3yRnqTr3ggCDi/1mz/vXtTE23yid15E=;
        b=NVBUN2v9zY8hqpjXvQ5D+egbLylOuk0cp4BuPYnvBQjXpDkAxQ+jWMwXktPBRHicPs
         kC6XVyWedf9IGZBIGtSltumfCugvyg+5INSQk9Qf1zTRsakW63Y44iwwX623TDwkOoXs
         f2zTSPoSzTlDf+XQnoYXNn6y1ArTFviF5Qc+fo+PyG9KjJrHDVAVZzVEqeiTDL9ENdI0
         mDrqhAZrrnDMrbvpZHE/AONya+0P+M5dIojNs8BLYM6dh9TeGJGYoq0pZwG89VCa64gA
         YLi49+Mm6zeTPZ3SACVx6n9NrlfR9u06ADzmdcSVAS3wSVhZ3/KjSWqnSJrrjUmdex8R
         wdEw==
X-Gm-Message-State: AGi0PuaKR08Y6iAJ6fA4oyWH3E0MNYbIMRos1imxWAVVEcwWp64wIYBA
        uydB5lGFGMlPAdZ5qzV3fY7RzIoO
X-Google-Smtp-Source: APiQypLzUjaETps37sNknaNpJRd69e4q4Njurum7A/YgheUuLkxBGJ0L+S9BOzo0gzPYgFm4gGc56g==
X-Received: by 2002:a7b:c051:: with SMTP id u17mr2417618wmc.129.1585819895057;
        Thu, 02 Apr 2020 02:31:35 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id q9sm7144883wrp.84.2020.04.02.02.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 02:31:34 -0700 (PDT)
Date:   Thu, 2 Apr 2020 11:31:32 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     qemu-discuss@nongnu.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: qemu-x86: kernel panic when host is loaded
Message-ID: <20200402093132.GA15839@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On our kernelci lab, each qemu worker pass an healtcheck job each day and after each job failure, so it is heavily used.
The healtcheck job is a Linux boot with a stable release.

Since we upgraded our worker to buster, the qemu x86_64 healthcheck randomly panic with:
<6>[    0.001000] APIC: Switch to symmetric I/O mode setup
<6>[    0.001000] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
<3>[    0.005000] ..MP-BIOS bug: 8254 timer not connected to IO-APIC
<6>[    0.005000] ...trying to set up timer (IRQ0) through the 8259A ...
<6>[    0.005000] ..... (found apic 0 pin 2) ...
<6>[    0.009000] ....... failed.
<6>[    0.009000] ...trying to set up timer as Virtual Wire IRQ...
<6>[    0.009000] ..... failed.
<6>[    0.009000] ...trying to set up timer as ExtINT IRQ...
<6>[    0.009000] ..... failed :(.
<0>[    0.009000] Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report.  Then try booting with the 'noapic' option.
<4>[    0.009000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.23 #1
<4>[    0.009000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
<4>[    0.009000] Call Trace:
<4>[    0.009000]  dump_stack+0x50/0x70
<4>[    0.009000]  panic+0xf6/0x2b7
<4>[    0.009000]  setup_IO_APIC+0x7c3/0x81c
<4>[    0.009000]  ? clear_IO_APIC_pin+0xb3/0x100
<4>[    0.009000]  x86_late_time_init+0x1b/0x20
<4>[    0.009000]  start_kernel+0x429/0x4e2
<4>[    0.009000]  secondary_startup_64+0xa4/0xb0

The qemu is called with:
/usr/bin/qemu-system-x86_64 -cpu host -enable-kvm -nographic -net nic,model=virtio,macaddr=52:54:00:12:34:58 -net user -m 512 -monitor none -kernel /var/lib/lava/dispatcher/tmp/741722/deployimages-xl6ogak_/kernel/bzImage -append "console=ttyS0,115200 root=/dev/ram0 debug verbose console_msg_format=syslog" -initrd /var/lib/lava/dispatcher/tmp/741722/deployimages-xl6ogak_/ramdisk/rootfs.cpio.gz -drive format=qcow2,file=/var/lib/lava/dispatcher/tmp/741722/apply-overlay-guest-sfn3zqna/lava-guest.qcow2,media=disk,if=ide,id=lavatest

We have tried to upgrade the Linux version from 5.0.21 to 5.4.23 without any change.
Only our buster worker fail like this, no problem with stretch.

We believing that only buster's qemu was failling since my other lab (gentoo with qemu 4.2) never failed.
This was until yesterday, were I hit the same problem on this gentoo lab.

After some test I found the source of this kernel panic, the host is loaded and qemu run "slower".
Simply renicing all qemu removed this behavour.

So now what can I do ?
Appart renicing qemu process, does something could be done ?

Thanks
Regards
