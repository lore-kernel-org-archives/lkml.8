Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBF6C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B77921532
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 04:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XxbSC4q4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgIHEzF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 00:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgIHEzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 00:55:04 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4E3C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 21:55:04 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id z46so4676486uac.13
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 21:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=herR/Nrj63cMKF7e1InzmeBz+Xvpa8xePmff5d5TtZ4=;
        b=XxbSC4q4XaWqM0WhIxfJj8DYKaYe7P12tbagPxAPXIZWgBm28kvGthT9Lw57VpNu4g
         2Ljtl//5dEINyp2huAHRWXUuXr2s5HMC9bht1QtIZtT9O0253JxIBkhWZqEensY1a1aG
         pYaqGQHdEzXdTcdLUZNrgoCqj0198eUck3AXDelLT5CDtYAhQLFsfq9xwbPxqiDnBKnp
         ABXXZuaOSdFts8A44fuKtOZRAOmlwaqnYHEs1mYrGNMhhcQ09xhismFdfzwxlDXo7u98
         xsoYFLb4U7DeFFCeSOK1Akq15T787EyC3wokJpfFVTCzattaTz+FG2XoBCT8wQ1zPS52
         Vpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=herR/Nrj63cMKF7e1InzmeBz+Xvpa8xePmff5d5TtZ4=;
        b=K8sDGa5yxDXoF+jZSuztooXHkpNAF53A4sXitymkvkMBHzCMBF3HT90coimkqKeOM8
         rrWW0G0QCV9SrQTUoXanXGiFmhyoMFzl20rT5SCLH2VsUMWh4stzH9HQflFck66XBKLz
         ygib67lKGmcupH3ND5P7Nm0GIVfIBeCDxP8wXml8kj4Ta53VYvwkA3AHpZp3P0gudJxd
         dqGv/IM1XMNvvIJpOcuT/wtGVp0BKA4FmujZstMWCRAKBp4YivFMEJ1NASGCD6Ynttst
         9/UutATjQaiPVwXCLGPt+xYJ9MN3KkJ3NHij4r4iJnQTcpusL51UW57/d+2dlybgaf/G
         /fEg==
X-Gm-Message-State: AOAM533BtOlyO50xgASkpSa8QnjxAmFUru1R0HGtxDx6v40tw9ouUdN4
        jV51gHkK/QFcDNgHTHXQSzzrQZ0gFH5xCXhw27A=
X-Google-Smtp-Source: ABdhPJzDJBs1gJiTSl2qscOWeyq8e3pcGIIBCTaOqx3R+5bdyHUtaNbR+97qjSNl9DeQCmcGfVUpZwa1oZVZGH/62I8=
X-Received: by 2002:ab0:29d7:: with SMTP id i23mr2477899uaq.121.1599540903174;
 Mon, 07 Sep 2020 21:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200831182210.850852-4-jim.cromie@gmail.com> <20200902074124.GP4299@shao2-debian>
In-Reply-To: <20200902074124.GP4299@shao2-debian>
From:   jim.cromie@gmail.com
Date:   Tue, 8 Sep 2020 00:54:37 -0400
Message-ID: <CAJfuBxy2kMcPRTux=ZogVCB7Uw-kSONyUyi9T_VKwu5TCDGgNA@mail.gmail.com>
Subject: Re: [dyndbg] 70f06a871f: kernel_BUG_at_lib/dynamic_debug.c
To:     kernel test robot <lkp@intel.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Got it.
will investigate asap

On Wed, Sep 2, 2020 at 3:42 AM kernel test robot <lkp@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: 70f06a871f5d40ca8f977eb412358ab03b6804da ("[PATCH v3 3/3] dyndbg:=
 fix problem parsing format=3D"foo bar"")
> url: https://github.com/0day-ci/linux/commits/Jim-Cromie/dyndbg-cleanups-=
for-5-9/20200901-022403
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git f75=
aef392f869018f78cfedf3c320a6b3fcfda6b
>
> in testcase: kernel-selftests
> with following parameters:
>
>         group: kselftests-livepatch
>
> test-description: The kernel contains a set of "self tests" under the too=
ls/testing/selftests/ directory. These are intended to be small unit tests =
to exercise individual code paths in the kernel.
> test-url: https://www.kernel.org/doc/Documentation/kselftest.txt
>
>
> on test machine: qemu-system-x86_64 -enable-kvm -cpu SandyBridge -smp 2 -=
m 8G
>
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>
>
> +------------------------------------------+------------+------------+
> |                                          | 12aeaa9439 | 70f06a871f |
> +------------------------------------------+------------+------------+
> | boot_successes                           | 6          | 2          |
> | boot_failures                            | 0          | 4          |
> | kernel_BUG_at_lib/dynamic_debug.c        | 0          | 4          |
> | invalid_opcode:#[##]                     | 0          | 4          |
> | RIP:ddebug_exec_query                    | 0          | 4          |
> | Kernel_panic-not_syncing:Fatal_exception | 0          | 4          |
> +------------------------------------------+------------+------------+
>
>
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>
>
>
> [   78.796907] kernel BUG at lib/dynamic_debug.c:267!
> [   78.799930] invalid opcode: 0000 [#1] PREEMPT SMP PTI
> [   78.801632] CPU: 1 PID: 1068 Comm: test-livepatch. Tainted: G         =
     K   5.9.0-rc3-00003-g70f06a871f5d4 #1
> [   78.803877] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.12.0-1 04/01/2014
> [   78.805929] RIP: 0010:ddebug_exec_query+0x684/0x760
> [   78.807642] Code: 0f 85 c0 08 00 00 4c 89 7c 24 28 e9 2d fc ff ff 4c 8=
9 fe 48 8d 7c 24 10 e8 a9 f8 ff ff 85 c0 0f 84 18 fc ff ff e9 c1 07 00 00 <=
0f> 0b 8b 15 ac 37 e2 02 85 d2 0f 85 c1 00 00 00 45 31 e4 48 c7 c6
> [   78.812169] RSP: 0018:ffffb325411c7d78 EFLAGS: 00010246
> [   78.815411] RAX: 000000000000003d RBX: ffff9f4dab69286c RCX: 000000000=
0000000
> [   78.821166] RDX: 000000000000003d RSI: ffff9f4dab692868 RDI: ffff9f4da=
b69286c
> [   78.823160] RBP: 0000000000000004 R08: ffff9f4dab69286e R09: 000000000=
0000001
> [   78.825172] R10: 0000000000000000 R11: 0000000000000246 R12: 000000000=
0000004
> [   78.827212] R13: 0000000000000004 R14: 0000000000000000 R15: 000000000=
0000000
> [   78.829228] FS:  00007f024c29c740(0000) GS:ffff9f4e77d00000(0000) knlG=
S:0000000000000000
> [   78.831343] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   78.833243] CR2: 00007f024c45c8a0 CR3: 0000000168360000 CR4: 000000000=
00406e0
> [   78.835312] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   78.837371] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 000000000=
0000400
> [   78.839398] Call Trace:
> [   78.840935]  ? __might_fault+0x36/0x80
> [   78.842574]  ddebug_exec_queries+0x6a/0x100
> [   78.844322]  ddebug_proc_write+0x4e/0x80
> [   78.845985]  full_proxy_write+0x56/0x80
> [   78.847621]  vfs_write+0xec/0x240
> [   78.849189]  ksys_write+0x68/0xe0
> [   78.850738]  do_syscall_64+0x33/0x40
> [   78.852347]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [   78.854106] RIP: 0033:0x7f024c389504
> [   78.855634] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 8=
0 00 00 00 00 48 8d 05 f9 61 0d 00 8b 00 85 c0 75 13 b8 01 00 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 49 89 d4 55 48 89 f5 53
> [   78.860364] RSP: 002b:00007fff5962d2b8 EFLAGS: 00000246 ORIG_RAX: 0000=
000000000001
> [   78.864609] RAX: ffffffffffffffda RBX: 00000000000000bc RCX: 00007f024=
c389504
> [   78.866696] RDX: 00000000000000bc RSI: 00005582ce63dcd0 RDI: 000000000=
0000001
> [   78.868751] RBP: 00005582ce63dcd0 R08: fffffffffffffff0 R09: 00007f024=
c419e80
> [   78.870832] R10: 00005582ce63dd8c R11: 0000000000000246 R12: 00007f024=
c45b760
> [   78.872933] R13: 00000000000000bc R14: 00007f024c456760 R15: 000000000=
00000bc
> [   78.875077] Modules linked in: intel_rapl_msr intel_rapl_common snd_pc=
m sr_mod cdrom sg crct10dif_pclmul ppdev crc32_pclmul snd_timer bochs_drm c=
rc32c_intel ata_generic ghash_clmulni_intel snd pata_acpi drm_vram_helper a=
esni_intel drm_ttm_helper crypto_simd ttm cryptd ata_piix glue_helper sound=
core joydev pcspkr serio_raw parport_pc libata parport ipmi_devintf ipmi_ms=
ghandler floppy i2c_piix4 ip_tables [last unloaded: test_klp_atomic_replace=
]
> [   78.889926] ---[ end trace aae1acea69a78e4f ]---
>
>
> To reproduce:
>
>         # build kernel
>         cd linux
>         cp config-5.9.0-rc3-00003-g70f06a871f5d4 .config
>         make HOSTCC=3Dgcc-9 CC=3Dgcc-9 ARCH=3Dx86_64 olddefconfig prepare=
 modules_prepare bzImage
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp qemu -k <bzImage> job-script # job-script is attached in =
this email
>
>
>
> Thanks,
> lkp
>
