Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF05EC11D2F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 442222084E
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 18:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=4net.rs header.i=@4net.rs header.b="s+3ptdQY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgBXSY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:24:27 -0500
Received: from amazon.4net.rs ([159.69.148.70]:52822 "EHLO amazon.4net.rs"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727426AbgBXSY0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 13:24:26 -0500
Received: from localhost (amazon.4net.co.rs [127.0.0.1])
        by amazon.4net.rs (Postfix) with ESMTP id F1C2E6308DA1;
        Mon, 24 Feb 2020 19:24:23 +0100 (CET)
X-Virus-Scanned: amavisd-new at 4net.rs
Received: from amazon.4net.rs ([127.0.0.1])
        by localhost (amazon.dyn.4net.co.rs [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id adevOIITX0dk; Mon, 24 Feb 2020 19:24:22 +0100 (CET)
Received: from mail.4net.rs (green.4net.rs [10.188.221.8])
        by amazon.4net.rs (Postfix) with ESMTP id F007A6308DA0;
        Mon, 24 Feb 2020 19:24:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTP id B2959CB7B7873;
        Mon, 24 Feb 2020 19:24:21 +0100 (CET)
X-Virus-Scanned: amavisd-new at 4net.rs
Received: from mail.4net.rs ([127.0.0.1])
        by localhost (green.4net.rs [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aEHHbXzL2DuW; Mon, 24 Feb 2020 19:24:21 +0100 (CET)
Received: from mail.4net.rs (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTP id 6B429C9ACE815;
        Mon, 24 Feb 2020 19:24:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=4net.rs; h=mime-version
        :content-type:content-transfer-encoding:date:from:to:cc:subject
        :in-reply-to:references:message-id; s=4netrs; bh=zp1FCt+Z2yEUjDQ
        AJmoufUgRhdc=; b=s+3ptdQYesIXNnELd4PZ8eS9EAzpQqXJmPPTZoqLvHEtB0V
        tt++Ni32w9mB4or/vwmBmoOezplMNVVEZALfO+eHIQ5YDFtORSMnp3RpxieYvT5k
        /WEsBrOgoRX7Yk1zkWm2ibJVNxuH4iG4Mg5Lqp5vLCo85/J3xvxF17x6gEus=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=4net.rs; h=mime-version
        :content-type:content-transfer-encoding:date:from:to:cc:subject
        :in-reply-to:references:message-id; q=dns; s=4netrs; b=aa9s6qzVM
        LSRncT/h0/KQRsYZOsRaC6VMRP13W3uGIZkz8eZlsa0JOETUGbAumD/fZ/BZ+rva
        wltZ1U7EKlJP5YL4DFZi7aFMZDn+yZGoYoFMfD2P0fJt6JJ5+y3s3QonG3vMQJHw
        SUOD8r/3Yia+r5sXekMqbceVymhoakapJg=
Received: from 4net.co.rs (localhost [127.0.0.1])
        by mail.4net.rs (Postfix) with ESMTPSA id 2C57BCB7B7873;
        Mon, 24 Feb 2020 19:24:21 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Mon, 24 Feb 2020 19:24:21 +0100
From:   =?UTF-8?Q?Sini=C5=A1a_Bandin?= <sinisa@4net.rs>
To:     "Souza, Jose" <jose.souza@intel.com>
Cc:     airlied@gmail.com, jani.nikula@linux.intel.com,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] Linux 5.6-rc2
In-Reply-To: <f9081410ef1135003720fa29d27aa10b9d12d509.camel@intel.com>
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <99fb887f-4a1b-6c15-64a6-9d089773cdd4@4net.rs>
 <CAPM=9ty3NuSHBd+StNGxVCE9jkmppQ_VTr+jMRgB07qW3dRwrA@mail.gmail.com>
 <f9081410ef1135003720fa29d27aa10b9d12d509.camel@intel.com>
User-Agent: Roundcube Webmail/1.4-beta
Message-ID: <334460f458ccabfe77b7d71df4ff3a64@4net.rs>
X-Sender: sinisa@4net.rs
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Still the same in rc3

Hopefully patch will land in rc4...

---
Srdačan pozdrav/Best regards/Freundliche Grüße/Cordialement,
Siniša Bandin



On 21.02.2020 03:23, Souza, Jose wrote:
> We have a fix for this issue, still going through review.
> 
> https://gitlab.freedesktop.org/drm/intel/issues/1151
> 
> On Fri, 2020-02-21 at 11:38 +1000, Dave Airlie wrote:
>> looping in intel-gfx + Jani.
>> 
>> On Tue, 18 Feb 2020 at 05:20, sinisa <sinisa@4net.rs> wrote:
>> >
>> > On 2020-02-16 22:32, Linus Torvalds wrote:
>> >  > ...
>> >  > Chris Wilson (19):
>> >  >       drm/i915/pmu: Correct the rc6 offset upon enabling
>> >  >       drm/i915/gem: Take local vma references for the parser
>> >  >       drm/i915/selftests: Add a mock i915_vma to the mock_ring
>> >  >       drm/i915/gt: Use the BIT when checking the flags, not the
>> > index
>> >  >       drm/i915/execlists: Leave resetting ring to intel_ring
>> >  >       drm/i915/gem: Store mmap_offsets in an rbtree rather than
>> > a
>> > plain list
>> >  >       drm/i915: Don't show the blank process name for
>> > internal/simulated errors
>> >  >       drm/i915/gem: Detect overflow in calculating dumb buffer
>> > size
>> >  >       drm/i915: Check activity on i915_vma after confirming
>> > pin_count==0
>> >  >       drm/i915: Stub out i915_gpu_coredump_put
>> >  >       drm/i915: Tighten atomicity of i915_active_acquire vs
>> > i915_active_release
>> >  >       drm/i915/gt: Acquire ce->active before ce->pin_count/ce-
>> > >pin_mutex
>> >  >       drm/i915/gem: Tighten checks and acquiring the mmap object
>> >  >       drm/i915: Keep track of request among the scheduling lists
>> >  >       drm/i915/gt: Allow temporary suspension of inflight
>> > requests
>> >  >       drm/i915/execlists: Offline error capture
>> >  >       drm/i915/execlists: Take a reference while capturing the
>> > guilty
>> > request
>> >  >       drm/i915/execlists: Reclaim the hanging virtual request
>> >  >       drm/i915: Mark the removal of the i915_request from the
>> > sched.link
>> >  > ...
>> >
>> > Something from here makes my Toshiba Portege Z30-A (CPU is i5-4210U
>> > with
>> > integrated graphics) to to only get black screen when loading i915
>> > driver.
>> >
>> > Happens the same in rc1 and rc2, works OK with all previous
>> > kernels.
>> >
>> >
>> > Here is relevant part of the dmesg output:
>> >
>> >
>> > [    4.643848] i915 0000:00:02.0: vgaarb: deactivate vga console
>> > [    4.645363] Console: switching to colour dummy device 80x25
>> > [    4.667372] [drm] Supports vblank timestamp caching Rev 2
>> > (21.10.2013).
>> > [    4.667379] [drm] Driver supports precise vblank timestamp
>> > query.
>> > [    4.667743] i915 0000:00:02.0: vgaarb: changed VGA decodes:
>> > olddecodes=io+mem,decodes=io+mem:owns=io+mem
>> > [    4.682355] ------------[ cut here ]------------
>> > [    4.682389] WARNING: CPU: 3 PID: 459 at
>> > drivers/gpu/drm/drm_atomic.c:296
>> > drm_atomic_get_crtc_state+0xf8/0x110 [drm]
>> > [    4.682394] Modules linked in: iTCO_wdt iTCO_vendor_support
>> > nls_iso8859_1 snd_hda_codec_realtek i915(+) fuse nls_cp437
>> > snd_hda_codec_generic vfat fat iwlwifi uvcvideo ledtrig_audio
>> > aesni_intel(+) drm_kms_helper videobuf2_vmalloc crypto_simd
>> > snd_hda_intel videobuf2_memops cec snd_intel_dspcfg rc_core
>> > videobuf2_v4l2 cryptd snd_hda_codec glue_helper videobuf2_common
>> > cfg80211 drm pcspkr videodev snd_hda_core wmi_bmof snd_hwdep
>> > snd_pcm
>> > toshiba_acpi mc e1000e snd_timer sparse_keymap fb_sys_fops
>> > syscopyarea
>> > sysfillrect industrialio lpc_ich snd sysimgblt i2c_algo_bit
>> > toshiba_bluetooth soundcore thermal rfkill intel_smartconnect ac
>> > button
>> > xfs libcrc32c xhci_pci xhci_hcd rtsx_pci_sdmmc mmc_core ehci_pci
>> > ehci_hcd usbcore crc32c_intel rtsx_pci serio_raw battery wmi video
>> > l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppox sg
>> > ppp_mppe ppp_generic slhc libarc4 dm_multipath dm_mod scsi_dh_rdac
>> > scsi_dh_emc scsi_dh_alua
>> > [    4.682455] CPU: 3 PID: 459 Comm: systemd-udevd Not tainted
>> > 5.6.0-rc2-1.g327abc9-default #1 openSUSE Tumbleweed (unreleased)
>> > [    4.682460] Hardware name: TOSHIBA PORTEGE Z30-A/PORTEGE Z30-A,
>> > BIOS
>> > Version 4.30   04/26/2018
>> > [    4.682486] RIP: 0010:drm_atomic_get_crtc_state+0xf8/0x110 [drm]
>> > [    4.682490] Code: 89 2c 11 48 89 98 f0 01 00 00 48 8b 4d 20 8b
>> > 55 60
>> > e8 2c aa 00 00 48 8b 04 24 48 83 c4 08 5b 5d 41 5c c3 48 98 e9 4e
>> > ff ff
>> > ff <0f> 0b e9 28 ff ff ff 48 c7 c0 f4 ff ff ff e9 3b ff ff ff 0f 1f
>> > 44
>> > [    4.682497] RSP: 0000:ffffaa5bc04338a8 EFLAGS: 00010246
>> > [    4.682500] RAX: 0000000000000000 RBX: ffff9c97862c1000 RCX:
>> > ffff9c979101ed08
>> > [    4.682504] RDX: 000000000000002d RSI: 0000000000000000 RDI:
>> > ffff9c97862c1000
>> > [    4.682507] RBP: ffff9c97862c7800 R08: 0000000000000079 R09:
>> > 0000000000000079
>> > [    4.682510] R10: 000000000000002d R11: 0000000000000005 R12:
>> > 0000000000000000
>> > [    4.682513] R13: ffff9c97862c7800 R14: ffff9c97862c0800 R15:
>> > ffffffffc0ee0f80
>> > [    4.682517] FS:  00007f65d2c92dc0(0000)
>> > GS:ffff9c9792ec0000(0000)
>> > knlGS:0000000000000000
>> > [    4.682521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> > [    4.682524] CR2: 00007f016d25b610 CR3: 000000030f634004 CR4:
>> > 00000000001606e0
>> > [    4.682527] Call Trace:
>> > [    4.682551]  drm_atomic_add_affected_connectors+0x2e/0x110 [drm]
>> > [    4.682569]  drm_atomic_helper_check_modeset+0x492/0x770
>> > [drm_kms_helper]
>> > [    4.682641]  intel_atomic_check+0x93/0xcc0 [i915]
>> > [    4.682657]  ? drm_atomic_helper_duplicate_state+0x148/0x170
>> > [drm_kms_helper]
>> > [    4.682723]  intel_modeset_init+0xe55/0x1180 [i915]
>> > [    4.682777]  i915_driver_probe+0x48e/0x580 [i915]
>> > [    4.682784]  ? _cond_resched+0x15/0x30
>> > [    4.682788]  ? mutex_lock+0xe/0x30
>> > [    4.682839]  i915_pci_probe+0x54/0x140 [i915]
>> > [    4.682845]  local_pci_probe+0x42/0x80
>> > [    4.682851]  pci_device_probe+0x107/0x1b0
>> > [    4.682856]  really_probe+0x147/0x3c0
>> > [    4.682860]  driver_probe_device+0xb6/0x100
>> > [    4.682864]  device_driver_attach+0x53/0x60
>> > [    4.682867]  __driver_attach+0x8a/0x150
>> > [    4.682870]  ? device_driver_attach+0x60/0x60
>> > [    4.682874]  ? device_driver_attach+0x60/0x60
>> > [    4.682878]  bus_for_each_dev+0x78/0xc0
>> > [    4.682883]  bus_add_driver+0x14d/0x1f0
>> > [    4.682887]  driver_register+0x6c/0xc0
>> > [    4.682891]  ? 0xffffffffc0ff5000
>> > [    4.682946]  i915_init+0x5d/0x70 [i915]
>> > [    4.682952]  do_one_initcall+0x46/0x200
>> > [    4.682957]  ? _cond_resched+0x15/0x30
>> > [    4.682961]  ? kmem_cache_alloc_trace+0x189/0x280
>> > [    4.682966]  ? do_init_module+0x23/0x230
>> > [    4.682970]  do_init_module+0x5c/0x230
>> > [    4.682973]  load_module+0x14b2/0x1650
>> > [    4.682980]  ? __do_sys_init_module+0x16e/0x1a0
>> > [    4.682983]  __do_sys_init_module+0x16e/0x1a0
>> > [    4.682989]  do_syscall_64+0x64/0x240
>> > [    4.682994]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
>> > [    4.682998] RIP: 0033:0x7f65d38a9d9a
>> > [    4.683001] Code: 48 8b 0d e9 00 0c 00 f7 d8 64 89 01 48 83 c8
>> > ff c3
>> > 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00
>> > 00 0f
>> > 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b6 00 0c 00 f7 d8 64 89 01
>> > 48
>> > [    4.683007] RSP: 002b:00007fffae341008 EFLAGS: 00000246
>> > ORIG_RAX:
>> > 00000000000000af
>> > [    4.683012] RAX: ffffffffffffffda RBX: 0000563c1d4cb930 RCX:
>> > 00007f65d38a9d9a
>> > [    4.683015] RDX: 00007f65d356689d RSI: 00000000004bdde7 RDI:
>> > 00007f65cd60c010
>> > [    4.683018] RBP: 00007f65cd60c010 R08: 0000000000000000 R09:
>> > 00007f65d32649e0
>> > [    4.683022] R10: 0000000000000001 R11: 0000000000000246 R12:
>> > 00007f65d356689d
>> > [    4.683025] R13: 0000000000000000 R14: 0000563c1d22f0c0 R15:
>> > 0000563c1d4cb930
>> > [    4.683030] ---[ end trace 2b569a8878cd5b99 ]---
>> >
>> >
>> >
>> > --
>> > Srdačan pozdrav/Best regards/Freundliche Grüße/Cordialement
>> > Siniša Bandin
>> _______________________________________________
>> Intel-gfx mailing list
>> Intel-gfx@lists.freedesktop.org
>> https://lists.freedesktop.org/mailman/listinfo/intel-gfx
