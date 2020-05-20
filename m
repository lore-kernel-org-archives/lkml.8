Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64A82C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 408242070A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:53:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecfTGfSH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbgETMxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgETMxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:53:21 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE86C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:53:21 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id u190so682018ooa.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 05:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Jtf10WSNp4f8hcuYT2S8rPAx8R8VIlLPm6wtnJIBRFI=;
        b=ecfTGfSHaW1t2rwJ1XNKCrSp/FWpSx6j4QbHWTg8+bqsl4W5jt0BbLyaBoo6jFwAQb
         du/7KQyv1F81REFqRvnJZHU4poyaW161c7WqE0SD3cqsKbW+jXl8G4CISV+8IThBjiZI
         jTGoDGLkIh6wzRV+C4nqS3au/to+FVB/VOhBhw+LSoe8yoibSS7jRdBdBTLFYXoMj6eN
         Lz7cOSIW+j34kF4arDGSNHVwXmzxUlBAkSg/2ObBYOw3+AjB1W0lxqQEYY8IARLwCWWO
         uK+mh0fcUMlGnNFsJFY8rXlbSQhiJwZfVtEtNJhWMNlSeGGFM9rctDWwVn59Hs2ibzVx
         BvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Jtf10WSNp4f8hcuYT2S8rPAx8R8VIlLPm6wtnJIBRFI=;
        b=rgLcPMwtrj3p/pH2NYiHyjwyCDwTB3XrC5kXkSnqV0dbAa3QVg24TJA1ucTgWL5ANj
         NKV7mjXYHiX23CSb/oaFvsQZ2U0ZTdk/3ce9FsOGwU6eXtGauNwm175KYHyjWwz/OGbK
         pAusFj0giCjaIzvh1TG5GiMeM11ifqZhZyL1fxFar3FgBVGQX9DxhjaynvvZoBSZsIWj
         ZZhPzryMKq7XvAWvVmWQdeJmfaUn1mDvWD1DsSmLwLBbc+7oaYBZv9UTTa+EFe9chCld
         sI0Cls9sggwsg4eGHzq2hgbMzN43FoMo6RVvwHMS4Z8JYex7xwtKQc69Ez8izdf1m/aw
         /k6A==
X-Gm-Message-State: AOAM532eKy3T2+qHP3PScDxp8km35sb2Dj2pJ/IJ0WCeqmTSCUbLIEj5
        9FmGm5pnqv4nnW9J8Ekp0b3fh/IibMja6fNqLOsTyNMb
X-Google-Smtp-Source: ABdhPJwRposyyHbI+pfyNAWaSFSYQe7nmUXweHVj1uxxlbgXLOX/7PEw5BxUrZqt2KXIgqO6LpdWcmT08gtQXtNv3lE=
X-Received: by 2002:a4a:4cca:: with SMTP id a193mr3244104oob.46.1589979200021;
 Wed, 20 May 2020 05:53:20 -0700 (PDT)
MIME-Version: 1.0
From:   nirinA raseliarison <nirina.raseliarison@gmail.com>
Date:   Wed, 20 May 2020 15:57:53 +0300
Message-ID: <CANsGL8Mb31NWVSgj=B2fNtT3x4oYm3tDKYZxpBCKfNC9ROLcGA@mail.gmail.com>
Subject: kernel BUG at fs/inode.c:531!
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hello ,

i repeatedly hit this bug since gcc-10.1.0:

May 20 05:06:25 supernova kernel: [16312.604136] ------------[ cut
here ]------------
May 20 05:06:25 supernova kernel: [16312.604139] kernel BUG at fs/inode.c:531!
May 20 05:06:25 supernova kernel: [16312.604145] invalid opcode: 0000
[#1] SMP PTI
May 20 05:06:25 supernova kernel: [16312.604148] CPU: 1 PID: 149 Comm:
kswapd0 Not tainted 5.7.0-rc6.20200519 #1
May 20 05:06:25 supernova kernel: [16312.604150] Hardware name: To be
filled by O.E.M. To be filled by O.E.M./ONDA H61V Ver:4.01, BIOS 4.6.5
01/07/2013
May 20 05:06:25 supernova kernel: [16312.604155] RIP: 0010:clear_inode+0x75/0x80
May 20 05:06:25 supernova kernel: [16312.604157] Code: a8 20 74 2a a8
40 75 28 48 8b 83 28 01 00 00 48 8d 93 28 01 00 00 48 39 c2 75 17 48
c7 83 98 00 00 00 60 00 00 00 5b c3 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 0f
0b 90 0f 1f 44 00 00 53 ba 48 02 00 00
May 20 05:06:25 supernova kernel: [16312.604158] RSP:
0000:ffffc9000048fb50 EFLAGS: 00010006
May 20 05:06:25 supernova kernel: [16312.604160] RAX: 0000000000000000
RBX: ffff88808c5f9e38 RCX: 0000000000000000
May 20 05:06:25 supernova kernel: [16312.604161] RDX: 0000000000000001
RSI: 0000000000000000 RDI: ffff88808c5f9fb8
May 20 05:06:25 supernova kernel: [16312.604162] RBP: ffff88808c5f9e38
R08: ffffffffffffffff R09: ffffc9000048fcd8
May 20 05:06:25 supernova kernel: [16312.604163] R10: 0000000000000000
R11: 0000000000000520 R12: ffff88808c5f9fb0
May 20 05:06:25 supernova kernel: [16312.604164] R13: ffff88820f14d000
R14: ffff88820f14d070 R15: 0000000000000122
May 20 05:06:25 supernova kernel: [16312.604166] FS:
0000000000000000(0000) GS:ffff888217700000(0000)
knlGS:0000000000000000
May 20 05:06:25 supernova kernel: [16312.604167] CS:  0010 DS: 0000
ES: 0000 CR0: 0000000080050033
May 20 05:06:25 supernova kernel: [16312.604168] CR2: 00007f7849e58000
CR3: 000000001e676006 CR4: 00000000001606e0
May 20 05:06:25 supernova kernel: [16312.604169] Call Trace:
May 20 05:06:25 supernova kernel: [16312.604174]  ext4_clear_inode+0x16/0x80
May 20 05:06:25 supernova kernel: [16312.604177]  ext4_evict_inode+0x58/0x4c0
May 20 05:06:25 supernova kernel: [16312.604180]  evict+0xbf/0x180
May 20 05:06:25 supernova kernel: [16312.604183]  prune_icache_sb+0x7e/0xb0
May 20 05:06:25 supernova kernel: [16312.604186]  super_cache_scan+0x161/0x1e0
May 20 05:06:25 supernova kernel: [16312.604189]  do_shrink_slab+0x146/0x290
May 20 05:06:25 supernova kernel: [16312.604191]  shrink_slab+0xac/0x2a0
May 20 05:06:25 supernova kernel: [16312.604194]  ? __switch_to_asm+0x40/0x70
May 20 05:06:25 supernova kernel: [16312.604196]  shrink_node+0x16f/0x660
May 20 05:06:25 supernova kernel: [16312.604199]  balance_pgdat+0x2cf/0x5b0
May 20 05:06:25 supernova kernel: [16312.604201]  kswapd+0x1dc/0x3a0
May 20 05:06:25 supernova kernel: [16312.604204]  ? __schedule+0x217/0x710
May 20 05:06:25 supernova kernel: [16312.604206]  ? wait_woken+0x80/0x80
May 20 05:06:25 supernova kernel: [16312.604208]  ? balance_pgdat+0x5b0/0x5b0
May 20 05:06:25 supernova kernel: [16312.604210]  kthread+0x118/0x130
May 20 05:06:25 supernova kernel: [16312.604212]  ?
kthread_create_worker_on_cpu+0x70/0x70
May 20 05:06:25 supernova kernel: [16312.604214]  ret_from_fork+0x35/0x40
May 20 05:06:25 supernova kernel: [16312.604215] Modules linked in:
nct6775 hwmon_vid rfkill ipv6 nf_defrag_ipv6 snd_pcm_oss snd_mixer_oss
fuse hid_generic usbhid hid i2c_dev snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic coretemp hwmon
x86_pkg_temp_thermal intel_powerclamp i915 kvm_intel kvm irqbypass
evdev crc32_pclmul serio_raw r8169 drm_kms_helper snd_hda_intel
snd_intel_dspcfg realtek snd_hda_codec libphy snd_hwdep syscopyarea
sysfillrect sysimgblt snd_hda_core fan fb_sys_fops thermal snd_pcm drm
8250 mei_me snd_timer drm_panel_orientation_quirks 8250_base
serial_core intel_gtt video snd ehci_pci lpc_ich ehci_hcd mei agpgart
soundcore button i2c_algo_bit i2c_i801 loop
May 20 05:06:25 supernova kernel: [16312.604237] ---[ end trace
6d45434b7eb1e097 ]---
May 20 05:06:25 supernova kernel: [16312.604240] RIP: 0010:clear_inode+0x75/0x80
May 20 05:06:25 supernova kernel: [16312.604241] Code: a8 20 74 2a a8
40 75 28 48 8b 83 28 01 00 00 48 8d 93 28 01 00 00 48 39 c2 75 17 48
c7 83 98 00 00 00 60 00 00 00 5b c3 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 0f
0b 90 0f 1f 44 00 00 53 ba 48 02 00 00
May 20 05:06:25 supernova kernel: [16312.604242] RSP:
0000:ffffc9000048fb50 EFLAGS: 00010006
May 20 05:06:25 supernova kernel: [16312.604244] RAX: 0000000000000000
RBX: ffff88808c5f9e38 RCX: 0000000000000000
May 20 05:06:25 supernova kernel: [16312.604245] RDX: 0000000000000001
RSI: 0000000000000000 RDI: ffff88808c5f9fb8
May 20 05:06:25 supernova kernel: [16312.604246] RBP: ffff88808c5f9e38
R08: ffffffffffffffff R09: ffffc9000048fcd8
May 20 05:06:25 supernova kernel: [16312.604246] R10: 0000000000000000
R11: 0000000000000520 R12: ffff88808c5f9fb0
May 20 05:06:25 supernova kernel: [16312.604247] R13: ffff88820f14d000
R14: ffff88820f14d070 R15: 0000000000000122
May 20 05:06:25 supernova kernel: [16312.604249] FS:
0000000000000000(0000) GS:ffff888217700000(0000)
knlGS:0000000000000000
May 20 05:06:25 supernova kernel: [16312.604250] CS:  0010 DS: 0000
ES: 0000 CR0: 0000000080050033
May 20 05:06:25 supernova kernel: [16312.604251] CR2: 00007f7849e58000
CR3: 000000001e676006 CR4: 00000000001606e0

--
nirinA
