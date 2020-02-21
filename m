Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B2DC11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAEA8208CD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbDt85TF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbgBUBjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:39:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39592 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729226AbgBUBjD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:39:03 -0500
Received: by mail-oi1-f196.google.com with SMTP id z2so58171oih.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 17:39:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=+yc9LuMWnx8luvldH2c5SxEZiYTEp+nLnYQiXdDyLQw=;
        b=FbDt85TFQkiIBXQwaF8z0+fvLIV/BYFGKiL929TM5Oy+E0UA6weUCGe3aG+Vmd5qgY
         0Gg9EhmbjnAF0V0scyRuXgrrHcf8hK2zNuGZs+XQwiDhRXL0w/SsxSdoplZ/JFcOQahb
         BVnJb1D6lJba0uvXCYoRI0Hz3bVTxgjl/pJQinxXVglfT+cPmcLQLAgQqbYdItDuz1E8
         j4hBIri/epaoTziawIa54GYtN7eJg0uqwco7OOf/gcUtUk1UVoKcRB3i0e8BaU7HdsnT
         FDu/DucMr4m4bxiYpT+01d9QLY68hRl2mI0U4+qd2UAiTnJx2ylJ6CCHV+u75NrQq55u
         fQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=+yc9LuMWnx8luvldH2c5SxEZiYTEp+nLnYQiXdDyLQw=;
        b=Vy2mBjiYFglru/Wdpkzy7lxmzz1WA7aD+JfayWZJIVt+CbEXHYbR8vGBHkVYwatnUj
         zbeZDIhABqe6BqPfCIK64PJDtEMyyCepWh02zobgm2BUcZPwfxiGHDz33YFur8Urpv6m
         f46ax72FT6czs2TcYMX9siQyD9ZE2PazUlLJgJwr/8PjuJgAyvcidon5haGdxB7GJNq9
         DPck8BI64LsSSX5MjArZrugMYvqUU/G3hUPEcfz/vQugQtkviLM2mYtRzO/VNuxTwMAd
         JSrL12T13mE+vbzd/i5MZz3Xo55+3XeAMM3uEC1iZ1tIVPMHNTfkLnDZrMqWN2KzlcSt
         pZLw==
X-Gm-Message-State: APjAAAURUMASPBK7SrSKD32KLDrG5lUj18Rn6YjpTZO3UX0IHwx8nHUb
        cw8iSWi+RIqJ+ofKfzZxh25/QHIxsPwqjivldlGz+rlH
X-Google-Smtp-Source: APXvYqxB00CdrVKcSo989pmDteYs4Vy+QnBzrZbjVOv6dWjkagocOEqF5KFMMbR2FFbsLzGy305AramM0HPeqRxNL0s=
X-Received: by 2002:aca:3857:: with SMTP id f84mr41684oia.150.1582249142229;
 Thu, 20 Feb 2020 17:39:02 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <99fb887f-4a1b-6c15-64a6-9d089773cdd4@4net.rs>
In-Reply-To: <99fb887f-4a1b-6c15-64a6-9d089773cdd4@4net.rs>
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 21 Feb 2020 11:38:50 +1000
Message-ID: <CAPM=9ty3NuSHBd+StNGxVCE9jkmppQ_VTr+jMRgB07qW3dRwrA@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     sinisa <sinisa@4net.rs>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

looping in intel-gfx + Jani.

On Tue, 18 Feb 2020 at 05:20, sinisa <sinisa@4net.rs> wrote:
>
>
> On 2020-02-16 22:32, Linus Torvalds wrote:
>  > ...
>  > Chris Wilson (19):
>  >       drm/i915/pmu: Correct the rc6 offset upon enabling
>  >       drm/i915/gem: Take local vma references for the parser
>  >       drm/i915/selftests: Add a mock i915_vma to the mock_ring
>  >       drm/i915/gt: Use the BIT when checking the flags, not the index
>  >       drm/i915/execlists: Leave resetting ring to intel_ring
>  >       drm/i915/gem: Store mmap_offsets in an rbtree rather than a
> plain list
>  >       drm/i915: Don't show the blank process name for
> internal/simulated errors
>  >       drm/i915/gem: Detect overflow in calculating dumb buffer size
>  >       drm/i915: Check activity on i915_vma after confirming pin_count=
=3D=3D0
>  >       drm/i915: Stub out i915_gpu_coredump_put
>  >       drm/i915: Tighten atomicity of i915_active_acquire vs
> i915_active_release
>  >       drm/i915/gt: Acquire ce->active before ce->pin_count/ce->pin_mut=
ex
>  >       drm/i915/gem: Tighten checks and acquiring the mmap object
>  >       drm/i915: Keep track of request among the scheduling lists
>  >       drm/i915/gt: Allow temporary suspension of inflight requests
>  >       drm/i915/execlists: Offline error capture
>  >       drm/i915/execlists: Take a reference while capturing the guilty
> request
>  >       drm/i915/execlists: Reclaim the hanging virtual request
>  >       drm/i915: Mark the removal of the i915_request from the sched.li=
nk
>  > ...
>
> Something from here makes my Toshiba Portege Z30-A (CPU is i5-4210U with
> integrated graphics) to to only get black screen when loading i915 driver=
.
>
> Happens the same in rc1 and rc2, works OK with all previous kernels.
>
>
> Here is relevant part of the dmesg output:
>
>
> [    4.643848] i915 0000:00:02.0: vgaarb: deactivate vga console
> [    4.645363] Console: switching to colour dummy device 80x25
> [    4.667372] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013)=
.
> [    4.667379] [drm] Driver supports precise vblank timestamp query.
> [    4.667743] i915 0000:00:02.0: vgaarb: changed VGA decodes:
> olddecodes=3Dio+mem,decodes=3Dio+mem:owns=3Dio+mem
> [    4.682355] ------------[ cut here ]------------
> [    4.682389] WARNING: CPU: 3 PID: 459 at
> drivers/gpu/drm/drm_atomic.c:296 drm_atomic_get_crtc_state+0xf8/0x110 [dr=
m]
> [    4.682394] Modules linked in: iTCO_wdt iTCO_vendor_support
> nls_iso8859_1 snd_hda_codec_realtek i915(+) fuse nls_cp437
> snd_hda_codec_generic vfat fat iwlwifi uvcvideo ledtrig_audio
> aesni_intel(+) drm_kms_helper videobuf2_vmalloc crypto_simd
> snd_hda_intel videobuf2_memops cec snd_intel_dspcfg rc_core
> videobuf2_v4l2 cryptd snd_hda_codec glue_helper videobuf2_common
> cfg80211 drm pcspkr videodev snd_hda_core wmi_bmof snd_hwdep snd_pcm
> toshiba_acpi mc e1000e snd_timer sparse_keymap fb_sys_fops syscopyarea
> sysfillrect industrialio lpc_ich snd sysimgblt i2c_algo_bit
> toshiba_bluetooth soundcore thermal rfkill intel_smartconnect ac button
> xfs libcrc32c xhci_pci xhci_hcd rtsx_pci_sdmmc mmc_core ehci_pci
> ehci_hcd usbcore crc32c_intel rtsx_pci serio_raw battery wmi video
> l2tp_ppp l2tp_netlink l2tp_core ip6_udp_tunnel udp_tunnel pppox sg
> ppp_mppe ppp_generic slhc libarc4 dm_multipath dm_mod scsi_dh_rdac
> scsi_dh_emc scsi_dh_alua
> [    4.682455] CPU: 3 PID: 459 Comm: systemd-udevd Not tainted
> 5.6.0-rc2-1.g327abc9-default #1 openSUSE Tumbleweed (unreleased)
> [    4.682460] Hardware name: TOSHIBA PORTEGE Z30-A/PORTEGE Z30-A, BIOS
> Version 4.30   04/26/2018
> [    4.682486] RIP: 0010:drm_atomic_get_crtc_state+0xf8/0x110 [drm]
> [    4.682490] Code: 89 2c 11 48 89 98 f0 01 00 00 48 8b 4d 20 8b 55 60
> e8 2c aa 00 00 48 8b 04 24 48 83 c4 08 5b 5d 41 5c c3 48 98 e9 4e ff ff
> ff <0f> 0b e9 28 ff ff ff 48 c7 c0 f4 ff ff ff e9 3b ff ff ff 0f 1f 44
> [    4.682497] RSP: 0000:ffffaa5bc04338a8 EFLAGS: 00010246
> [    4.682500] RAX: 0000000000000000 RBX: ffff9c97862c1000 RCX:
> ffff9c979101ed08
> [    4.682504] RDX: 000000000000002d RSI: 0000000000000000 RDI:
> ffff9c97862c1000
> [    4.682507] RBP: ffff9c97862c7800 R08: 0000000000000079 R09:
> 0000000000000079
> [    4.682510] R10: 000000000000002d R11: 0000000000000005 R12:
> 0000000000000000
> [    4.682513] R13: ffff9c97862c7800 R14: ffff9c97862c0800 R15:
> ffffffffc0ee0f80
> [    4.682517] FS:  00007f65d2c92dc0(0000) GS:ffff9c9792ec0000(0000)
> knlGS:0000000000000000
> [    4.682521] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    4.682524] CR2: 00007f016d25b610 CR3: 000000030f634004 CR4:
> 00000000001606e0
> [    4.682527] Call Trace:
> [    4.682551]  drm_atomic_add_affected_connectors+0x2e/0x110 [drm]
> [    4.682569]  drm_atomic_helper_check_modeset+0x492/0x770 [drm_kms_help=
er]
> [    4.682641]  intel_atomic_check+0x93/0xcc0 [i915]
> [    4.682657]  ? drm_atomic_helper_duplicate_state+0x148/0x170
> [drm_kms_helper]
> [    4.682723]  intel_modeset_init+0xe55/0x1180 [i915]
> [    4.682777]  i915_driver_probe+0x48e/0x580 [i915]
> [    4.682784]  ? _cond_resched+0x15/0x30
> [    4.682788]  ? mutex_lock+0xe/0x30
> [    4.682839]  i915_pci_probe+0x54/0x140 [i915]
> [    4.682845]  local_pci_probe+0x42/0x80
> [    4.682851]  pci_device_probe+0x107/0x1b0
> [    4.682856]  really_probe+0x147/0x3c0
> [    4.682860]  driver_probe_device+0xb6/0x100
> [    4.682864]  device_driver_attach+0x53/0x60
> [    4.682867]  __driver_attach+0x8a/0x150
> [    4.682870]  ? device_driver_attach+0x60/0x60
> [    4.682874]  ? device_driver_attach+0x60/0x60
> [    4.682878]  bus_for_each_dev+0x78/0xc0
> [    4.682883]  bus_add_driver+0x14d/0x1f0
> [    4.682887]  driver_register+0x6c/0xc0
> [    4.682891]  ? 0xffffffffc0ff5000
> [    4.682946]  i915_init+0x5d/0x70 [i915]
> [    4.682952]  do_one_initcall+0x46/0x200
> [    4.682957]  ? _cond_resched+0x15/0x30
> [    4.682961]  ? kmem_cache_alloc_trace+0x189/0x280
> [    4.682966]  ? do_init_module+0x23/0x230
> [    4.682970]  do_init_module+0x5c/0x230
> [    4.682973]  load_module+0x14b2/0x1650
> [    4.682980]  ? __do_sys_init_module+0x16e/0x1a0
> [    4.682983]  __do_sys_init_module+0x16e/0x1a0
> [    4.682989]  do_syscall_64+0x64/0x240
> [    4.682994]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> [    4.682998] RIP: 0033:0x7f65d38a9d9a
> [    4.683001] Code: 48 8b 0d e9 00 0c 00 f7 d8 64 89 01 48 83 c8 ff c3
> 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 af 00 00 00 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b6 00 0c 00 f7 d8 64 89 01 48
> [    4.683007] RSP: 002b:00007fffae341008 EFLAGS: 00000246 ORIG_RAX:
> 00000000000000af
> [    4.683012] RAX: ffffffffffffffda RBX: 0000563c1d4cb930 RCX:
> 00007f65d38a9d9a
> [    4.683015] RDX: 00007f65d356689d RSI: 00000000004bdde7 RDI:
> 00007f65cd60c010
> [    4.683018] RBP: 00007f65cd60c010 R08: 0000000000000000 R09:
> 00007f65d32649e0
> [    4.683022] R10: 0000000000000001 R11: 0000000000000246 R12:
> 00007f65d356689d
> [    4.683025] R13: 0000000000000000 R14: 0000563c1d22f0c0 R15:
> 0000563c1d4cb930
> [    4.683030] ---[ end trace 2b569a8878cd5b99 ]---
>
>
>
> --
> Srda=C4=8Dan pozdrav/Best regards/Freundliche Gr=C3=BC=C3=9Fe/Cordialemen=
t
> Sini=C5=A1a Bandin
