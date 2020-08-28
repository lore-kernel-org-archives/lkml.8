Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB4CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5BF620714
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 13:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N1WKD+Fk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbgH1NrT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 09:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbgH1Nqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 09:46:40 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC5CDC061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:46:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j15so743071lfg.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 06:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=E8Gd5MLxZn6jOYM+WPpbNwq7LhXbF6z4pnJoyKOuXzc=;
        b=N1WKD+FkWfXaW7VQba8YtluGsxQhhHCrl//hi2DgdTCub+LHW783ujyQ5SjvaQ3ltc
         zRLFWATcjnySoLWUN09lE6r97bT6OvFT57wahtsmX3F5Bf9RERj77As63lG1ZVwxMMGF
         zCyBmW1mfFtPsGb6RlXwM6Z4ad4VE2Gvq25dotQdosp4x9dUcYxOu6I2lq5pyYNQZbam
         O9MVsvJ8zcpziTl4/WNg+fi/s+6V4JpwaTJEL8RjEOTUL/1ChqPewMHqKtP6/XSzksIj
         Eqa7Wy13JtVG68rP0kfF3L6pOFotRGCiSSn8zEYU2aL2uInBJqeOSKv3L8uARVp5c68S
         ovVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=E8Gd5MLxZn6jOYM+WPpbNwq7LhXbF6z4pnJoyKOuXzc=;
        b=ZQHuft9xzrcqIvpvY6/rhKmjKQIyJxT6N5VprM1Yt3GzZY4i21GdJEH6aMjWPJ2M+E
         NOdA4vATbQTB/fXQuYegs/Pij7tmbXtuIvZImTUNaHaRWTDMOvKlOAYCn6foetskht/i
         hs6y2hKhQF1kouG2lxGaQWeiq1d/TbJPmh+7E32BoD+jzxfC/+43H46XqUkcQUPsrfDC
         mqd31HhRidGStDvrq9zYASogMMwdLCA2/37Fw8C+qTd1MTRCPc03XauIzsolHwBR9kZi
         Twk9ZuW5k9nmlnuB7lVVxaqbl3d44G6nwJEOw5DD9FkpD8lRXWzrF8Vfhqs17zwLFL5w
         MGRQ==
X-Gm-Message-State: AOAM533srOgZ5oMct6SYVNKSjTYN5qCb3LFiPP3IIUcLJzoDXfJEi6j9
        FLhP8ogufGwstdMFSQ20x7saYGMwfuetqxuMJAxtL6fro6w=
X-Google-Smtp-Source: ABdhPJzL9FebrX/muGgmBmsZA7UnX6X00kbIUXjWO45MBWqLCaJtPcTc76SNP6NgpyJvFa1UdgD/Ic1InJehnPZ+7T8=
X-Received: by 2002:a19:24c2:: with SMTP id k185mr850013lfk.120.1598622396788;
 Fri, 28 Aug 2020 06:46:36 -0700 (PDT)
MIME-Version: 1.0
From:   Chris Rankin <rankincj@gmail.com>
Date:   Fri, 28 Aug 2020 14:46:25 +0100
Message-ID: <CAK2bqVJGyf9fJhNbzeCvBC+JMbMEdFAu13pEWsNBRUtgN4Ej_Q@mail.gmail.com>
Subject: [AMDGPU] [OOPS] Warnings 5.8.3 / 5.8.5 kernel logs
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just noticed these oopsen in my dmesg logs. These are from 5.8.3:

[   61.599710] ------------[ cut here ]------------
[   61.603145] WARNING: CPU: 0 PID: 1756 at
drivers/gpu/drm/drm_modeset_lock.c:185
drm_warn_on_modeset_not_all_locked+0x66/0x6e [drm]
[   61.613699] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter bnep it87 hwmon_vid snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel dm_mod dax
uvcvideo videobuf2_vmalloc videobuf2_memops btusb videobuf2_v4l2 btbcm
videobuf2_common btintel snd_usb_audio snd_intel_dspcfg snd_virtuoso
snd_usbmidi_lib snd_hda_codec videodev bluetooth snd_oxygen_lib
ecdh_generic snd_hwdep mc joydev snd_mpu401_uart rfkill snd_hda_core
snd_rawmidi ecc snd_seq snd_seq_device coretemp snd_pcm kvm_intel
mxm_wmi r8169 i2c_i801 snd_hrtimer psmouse kvm gpio_ich iTCO_wdt
snd_timer pcspkr wmi realtek snd irqbypass libphy i2c_smbus
i7core_edac tiny_power_button acpi_cpufreq soundcore lpc_ich button
binfmt_misc nfsd
[   61.613724]  auth_rpcgss nfs_acl lockd grace sunrpc ip_tables
x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod
usbhid uhci_hcd ehci_pci amdgpu ahci pata_jmicron libahci
firewire_ohci serio_raw firewire_core ehci_hcd libata crc32c_intel
crc_itu_t xhci_pci xhci_hcd mfd_core i2c_algo_bit gpu_sched scsi_mod
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
usbcore fb_sys_fops cfbcopyarea usb_common ttm drm
drm_panel_orientation_quirks sha256_ssse3 sha256_generic libsha256
ipv6 nf_defrag_ipv6
[   61.744494] CPU: 0 PID: 1756 Comm: Xorg Tainted: G          I       5.8.3 #1
[   61.750318] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   61.757959] RIP: 0010:drm_warn_on_modeset_not_all_locked+0x66/0x6e [drm]
[   61.763360] Code: 6d 10 48 83 ed 10 eb de 48 8d bb e0 01 00 00 e8
12 b3 f7 e0 84 c0 75 02 0f 0b 48 8d bb b8 01 00 00 e8 00 b3 f7 e0 84
c0 75 02 <0f> 0b 5b 5d 41 5c c3 c3 55 48 89 fd 53 48 83 7e 30 00 48 89
f3 74
[   61.780924] RSP: 0018:ffffc90001cc7a48 EFLAGS: 00010246
[   61.784918] RAX: 0000000000000000 RBX: ffff88833a9df000 RCX: 0000000000000000
[   61.790836] RDX: ffffffffa0510800 RSI: ffff88833a9da8b0 RDI: ffff88833a9df1b8
[   61.796784] RBP: ffff88833a9df340 R08: ffff88833d62b500 R09: 0000000000000002
[   61.802732] R10: ffff88833a9df258 R11: 000000000000003a R12: ffff88833a9df350
[   61.808695] R13: ffff88833a9da8b0 R14: ffffffffa05150c0 R15: 0000000000000000
[   61.814585] FS:  00007f03ffb01f00(0000) GS:ffff888343c00000(0000)
knlGS:0000000000000000
[   61.821473] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   61.826020] CR2: 000056007f066c60 CR3: 0000000302b9c000 CR4: 00000000000006f0
[   61.831971] Call Trace:
[   61.833201]  drm_crtc_helper_set_mode+0x56/0x3d0 [drm_kms_helper]
[   61.838132]  ? cpufreq_this_cpu_can_update+0x9/0x48
[   61.841816]  ? dequeue_load_avg+0x27/0x48
[   61.844703]  ? reweight_entity+0x99/0xfa
[   61.847431]  ? enqueue_entity+0x116/0x172
[   61.850241]  ? update_overutilized_status+0x2b/0x4a
[   61.853925]  ? enqueue_task_fair+0xfc/0x121
[   61.856884]  ? throttled_hierarchy+0x5/0x1c
[   61.859849]  ? check_preempt_wakeup+0x42/0x13e
[   61.863135]  ? check_preempt_curr+0x2e/0x67
[   61.866096]  ? __raw_spin_unlock+0xd/0x1e
[   61.868892]  ? update_cfs_rq_load_avg+0x13c/0x14a
[   61.872446]  ? update_load_avg+0x39/0x2af
[   61.875303]  amdgpu_connector_set_property+0x8a/0x1d4 [amdgpu]
[   61.879948]  drm_connector_set_obj_prop+0x4c/0x6c [drm]
[   61.883962]  drm_mode_obj_set_property_ioctl+0x1c3/0x255 [drm]
[   61.888572]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   61.892790]  drm_connector_property_set_ioctl+0x32/0x4c [drm]
[   61.897248]  drm_ioctl_kernel+0x8d/0xe1 [drm]
[   61.900333]  drm_ioctl+0x1f9/0x2d3 [drm]
[   61.902970]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   61.907129]  ? rpm_resume+0x9a/0x3dc
[   61.909444]  ? update_process_times+0x3c/0x51
[   61.912594]  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
[   61.915958]  vfs_ioctl+0x1a/0x28
[   61.917930]  ksys_ioctl+0x5c/0x7b
[   61.919990]  __x64_sys_ioctl+0x11/0x14
[   61.922493]  do_syscall_64+0x48/0x62
[   61.924845]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   61.928728] RIP: 0033:0x7f03fff8d3bb
[   61.931086] Code: 0f 1e fa 48 8b 05 dd aa 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad aa 0c 00 f7 d8 64 89
01 48
[   61.948753] RSP: 002b:00007fff05d4ebc8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   61.955114] RAX: ffffffffffffffda RBX: 00007fff05d4ec00 RCX: 00007f03fff8d3bb
[   61.961110] RDX: 00007fff05d4ec00 RSI: 00000000c01064ab RDI: 000000000000000e
[   61.967123] RBP: 00000000c01064ab R08: 000056007fcfe700 R09: 0000000000000001
[   61.973028] R10: 000056007fc9b230 R11: 0000000000000246 R12: 000056007fbfeec0
[   61.978986] R13: 000000000000000e R14: 000056007fc96540 R15: 000056007fc96540
[   61.984973] ---[ end trace 4f4ef8d328aee306 ]---
[   61.988419] ------------[ cut here ]------------
[   61.991836] WARNING: CPU: 0 PID: 1756 at
drivers/gpu/drm/drm_crtc_helper.c:148 drm_helper_crtc_in_use+0x31/0x73
[drm_kms_helper]
[   62.002167] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter bnep it87 hwmon_vid snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel dm_mod dax
uvcvideo videobuf2_vmalloc videobuf2_memops btusb videobuf2_v4l2 btbcm
videobuf2_common btintel snd_usb_audio snd_intel_dspcfg snd_virtuoso
snd_usbmidi_lib snd_hda_codec videodev bluetooth snd_oxygen_lib
ecdh_generic snd_hwdep mc joydev snd_mpu401_uart rfkill snd_hda_core
snd_rawmidi ecc snd_seq snd_seq_device coretemp snd_pcm kvm_intel
mxm_wmi r8169 i2c_i801 snd_hrtimer psmouse kvm gpio_ich iTCO_wdt
snd_timer pcspkr wmi realtek snd irqbypass libphy i2c_smbus
i7core_edac tiny_power_button acpi_cpufreq soundcore lpc_ich button
binfmt_misc nfsd
[   62.002204]  auth_rpcgss nfs_acl lockd grace sunrpc ip_tables
x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod
usbhid uhci_hcd ehci_pci amdgpu ahci pata_jmicron libahci
firewire_ohci serio_raw firewire_core ehci_hcd libata crc32c_intel
crc_itu_t xhci_pci xhci_hcd mfd_core i2c_algo_bit gpu_sched scsi_mod
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
usbcore fb_sys_fops cfbcopyarea usb_common ttm drm
drm_panel_orientation_quirks sha256_ssse3 sha256_generic libsha256
ipv6 nf_defrag_ipv6
[   62.133787] CPU: 0 PID: 1756 Comm: Xorg Tainted: G        W I       5.8.3 #1
[   62.139627] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   62.147237] RIP: 0010:drm_helper_crtc_in_use+0x31/0x73 [drm_kms_helper]
[   62.152642] Code: 48 8b 2f 48 89 ef e8 11 ff ff ff 84 c0 74 02 0f
0b 83 3d 85 4a c7 e1 00 75 12 48 8d bd b8 01 00 00 e8 f1 e2 de e0 84
c0 75 02 <0f> 0b 48 8b 85 20 03 00 00 48 81 c5 20 03 00 00 48 8d 58 f8
48 8d
[   62.170128] RSP: 0018:ffffc90001cc7a48 EFLAGS: 00010246
[   62.174095] RAX: 0000000000000000 RBX: ffff88833a9da800 RCX: 0000000000000000
[   62.179986] RDX: ffffffffa0510800 RSI: ffff88833a9da8b0 RDI: ffff88833a9df1b8
[   62.185879] RBP: ffff88833a9df000 R08: ffff88833d62b500 R09: 0000000000000002
[   62.191739] R10: ffff88833a9df258 R11: 000000000000003a R12: ffff88833a9da800
[   62.197596] R13: ffff88833a9da8b0 R14: ffffffffa05150c0 R15: 0000000000000000
[   62.203732] FS:  00007f03ffb01f00(0000) GS:ffff888343c00000(0000)
knlGS:0000000000000000
[   62.210563] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.215105] CR2: 000056007f066c60 CR3: 0000000302b9c000 CR4: 00000000000006f0
[   62.221018] Call Trace:
[   62.222242]  drm_crtc_helper_set_mode+0x68/0x3d0 [drm_kms_helper]
[   62.227139]  ? cpufreq_this_cpu_can_update+0x9/0x48
[   62.230793]  ? dequeue_load_avg+0x27/0x48
[   62.233620]  ? reweight_entity+0x99/0xfa
[   62.236300]  ? enqueue_entity+0x116/0x172
[   62.239156]  ? update_overutilized_status+0x2b/0x4a
[   62.242806]  ? enqueue_task_fair+0xfc/0x121
[   62.245730]  ? throttled_hierarchy+0x5/0x1c
[   62.248686]  ? check_preempt_wakeup+0x42/0x13e
[   62.251902]  ? check_preempt_curr+0x2e/0x67
[   62.254833]  ? __raw_spin_unlock+0xd/0x1e
[   62.257675]  ? update_cfs_rq_load_avg+0x13c/0x14a
[   62.261180]  ? update_load_avg+0x39/0x2af
[   62.263940]  amdgpu_connector_set_property+0x8a/0x1d4 [amdgpu]
[   62.268543]  drm_connector_set_obj_prop+0x4c/0x6c [drm]
[   62.272579]  drm_mode_obj_set_property_ioctl+0x1c3/0x255 [drm]
[   62.277133]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   62.281278]  drm_connector_property_set_ioctl+0x32/0x4c [drm]
[   62.285802]  drm_ioctl_kernel+0x8d/0xe1 [drm]
[   62.288885]  drm_ioctl+0x1f9/0x2d3 [drm]
[   62.291543]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   62.295671]  ? rpm_resume+0x9a/0x3dc
[   62.298023]  ? update_process_times+0x3c/0x51
[   62.301145]  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
[   62.304647]  vfs_ioctl+0x1a/0x28
[   62.306700]  ksys_ioctl+0x5c/0x7b
[   62.308725]  __x64_sys_ioctl+0x11/0x14
[   62.311195]  do_syscall_64+0x48/0x62
[   62.313535]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   62.317392] RIP: 0033:0x7f03fff8d3bb
[   62.319814] Code: 0f 1e fa 48 8b 05 dd aa 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad aa 0c 00 f7 d8 64 89
01 48
[   62.337384] RSP: 002b:00007fff05d4ebc8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   62.343781] RAX: ffffffffffffffda RBX: 00007fff05d4ec00 RCX: 00007f03fff8d3bb
[   62.349783] RDX: 00007fff05d4ec00 RSI: 00000000c01064ab RDI: 000000000000000e
[   62.355687] RBP: 00000000c01064ab R08: 000056007fcfe700 R09: 0000000000000001
[   62.361534] R10: 000056007fc9b230 R11: 0000000000000246 R12: 000056007fbfeec0
[   62.367468] R13: 000000000000000e R14: 000056007fc96540 R15: 000056007fc96540
[   62.373430] ---[ end trace 4f4ef8d328aee307 ]---
[   62.376825] ------------[ cut here ]------------
[   62.380263] WARNING: CPU: 0 PID: 1756 at
drivers/gpu/drm/drm_crtc_helper.c:108
drm_helper_encoder_in_use+0x43/0xaa [drm_kms_helper]
[   62.390820] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter bnep it87 hwmon_vid snd_hda_codec_hdmi
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel dm_mod dax
uvcvideo videobuf2_vmalloc videobuf2_memops btusb videobuf2_v4l2 btbcm
videobuf2_common btintel snd_usb_audio snd_intel_dspcfg snd_virtuoso
snd_usbmidi_lib snd_hda_codec videodev bluetooth snd_oxygen_lib
ecdh_generic snd_hwdep mc joydev snd_mpu401_uart rfkill snd_hda_core
snd_rawmidi ecc snd_seq snd_seq_device coretemp snd_pcm kvm_intel
mxm_wmi r8169 i2c_i801 snd_hrtimer psmouse kvm gpio_ich iTCO_wdt
snd_timer pcspkr wmi realtek snd irqbypass libphy i2c_smbus
i7core_edac tiny_power_button acpi_cpufreq soundcore lpc_ich button
binfmt_misc nfsd
[   62.390841]  auth_rpcgss nfs_acl lockd grace sunrpc ip_tables
x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod
usbhid uhci_hcd ehci_pci amdgpu ahci pata_jmicron libahci
firewire_ohci serio_raw firewire_core ehci_hcd libata crc32c_intel
crc_itu_t xhci_pci xhci_hcd mfd_core i2c_algo_bit gpu_sched scsi_mod
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
usbcore fb_sys_fops cfbcopyarea usb_common ttm drm
drm_panel_orientation_quirks sha256_ssse3 sha256_generic libsha256
ipv6 nf_defrag_ipv6
[   62.521610] CPU: 0 PID: 1756 Comm: Xorg Tainted: G        W I       5.8.3 #1
[   62.527428] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   62.535032] RIP: 0010:drm_helper_encoder_in_use+0x43/0xaa [drm_kms_helper]
[   62.540611] Code: 10 31 c0 48 89 ef e8 a9 ff ff ff 84 c0 74 02 0f
0b 83 3d 1d 4b c7 e1 00 75 24 48 8d bd b8 01 00 00 e8 89 e3 de e0 84
c0 75 02 <0f> 0b 48 8d bd e0 01 00 00 e8 77 e3 de e0 84 c0 75 02 0f 0b
48 89
[   62.558061] RSP: 0018:ffffc90001cc7a18 EFLAGS: 00010246
[   62.562037] RAX: 0000000000000000 RBX: ffff888338cb2400 RCX: 0000000000000000
[   62.567903] RDX: ffffffffa0510800 RSI: ffff88833a9da8b0 RDI: ffff88833a9df1b8
[   62.573781] RBP: ffff88833a9df000 R08: ffff88833d62b500 R09: 0000000000000002
[   62.579628] R10: ffff88833a9df258 R11: 000000000000003a R12: ffff88833a9da800
[   62.585505] R13: ffff88833a9da8b0 R14: ffffffffa05150c0 R15: 0000000000000000
[   62.591478] FS:  00007f03ffb01f00(0000) GS:ffff888343c00000(0000)
knlGS:0000000000000000
[   62.598432] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   62.602976] CR2: 000056007f066c60 CR3: 0000000302b9c000 CR4: 00000000000006f0
[   62.608912] Call Trace:
[   62.610145]  ? drm_helper_crtc_in_use+0x33/0x73 [drm_kms_helper]
[   62.614988]  drm_helper_crtc_in_use+0x66/0x73 [drm_kms_helper]
[   62.619658]  drm_crtc_helper_set_mode+0x68/0x3d0 [drm_kms_helper]
[   62.624557]  ? cpufreq_this_cpu_can_update+0x9/0x48
[   62.628222]  ? dequeue_load_avg+0x27/0x48
[   62.631041]  ? reweight_entity+0x99/0xfa
[   62.633752]  ? enqueue_entity+0x116/0x172
[   62.636544]  ? update_overutilized_status+0x2b/0x4a
[   62.640244]  ? enqueue_task_fair+0xfc/0x121
[   62.643226]  ? throttled_hierarchy+0x5/0x1c
[   62.646183]  ? check_preempt_wakeup+0x42/0x13e
[   62.649428]  ? check_preempt_curr+0x2e/0x67
[   62.652495]  ? __raw_spin_unlock+0xd/0x1e
[   62.655317]  ? update_cfs_rq_load_avg+0x13c/0x14a
[   62.658886]  ? update_load_avg+0x39/0x2af
[   62.661643]  amdgpu_connector_set_property+0x8a/0x1d4 [amdgpu]
[   62.666298]  drm_connector_set_obj_prop+0x4c/0x6c [drm]
[   62.670352]  drm_mode_obj_set_property_ioctl+0x1c3/0x255 [drm]
[   62.675012]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   62.679266]  drm_connector_property_set_ioctl+0x32/0x4c [drm]
[   62.683841]  drm_ioctl_kernel+0x8d/0xe1 [drm]
[   62.686927]  drm_ioctl+0x1f9/0x2d3 [drm]
[   62.689688]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   62.693894]  ? rpm_resume+0x9a/0x3dc
[   62.696185]  ? update_process_times+0x3c/0x51
[   62.699434]  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
[   62.702907]  vfs_ioctl+0x1a/0x28
[   62.704948]  ksys_ioctl+0x5c/0x7b
[   62.707028]  __x64_sys_ioctl+0x11/0x14
[   62.709583]  do_syscall_64+0x48/0x62
[   62.711872]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   62.715727] RIP: 0033:0x7f03fff8d3bb
[   62.718017] Code: 0f 1e fa 48 8b 05 dd aa 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad aa 0c 00 f7 d8 64 89
01 48
[   62.735568] RSP: 002b:00007fff05d4ebc8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   62.741895] RAX: ffffffffffffffda RBX: 00007fff05d4ec00 RCX: 00007f03fff8d3bb
[   62.747744] RDX: 00007fff05d4ec00 RSI: 00000000c01064ab RDI: 000000000000000e
[   62.753642] RBP: 00000000c01064ab R08: 000056007fcfe700 R09: 0000000000000001
[   62.759487] R10: 000056007fc9b230 R11: 0000000000000246 R12: 000056007fbfeec0
[   62.765404] R13: 000000000000000e R14: 000056007fc96540 R15: 000056007fc96540
[   62.771370] ---[ end trace 4f4ef8d328aee308 ]---

There is somethig similar in my 5.8.5 dmesg logs too:

[   62.780939] ------------[ cut here ]------------
[   62.784388] WARNING: CPU: 6 PID: 1713 at
drivers/gpu/drm/drm_modeset_lock.c:185
drm_warn_on_modeset_not_all_locked+0x66/0x6e [drm]
[   62.794979] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter bnep it87 hwmon_vid dm_mod dax snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel btusb btbcm
btintel bluetooth uvcvideo ecdh_generic videobuf2_vmalloc rfkill
videobuf2_memops videobuf2_v4l2 videobuf2_common ecc videodev
snd_usb_audio snd_usbmidi_lib mc joydev coretemp snd_virtuoso
kvm_intel snd_oxygen_lib snd_intel_dspcfg snd_hda_codec kvm
snd_mpu401_uart snd_hwdep irqbypass iTCO_wdt snd_rawmidi snd_hda_core
gpio_ich snd_seq r8169 mxm_wmi realtek psmouse snd_seq_device
tiny_power_button lpc_ich snd_pcm libphy pcspkr snd_hrtimer
acpi_cpufreq i2c_i801 i7core_edac snd_timer i2c_smbus snd button
soundcore wmi nfsd auth_rpcgss
[   62.795007]  binfmt_misc nfs_acl lockd grace sunrpc ip_tables
x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod
usbhid uhci_hcd crc32c_intel ehci_pci serio_raw firewire_ohci ahci
libahci pata_jmicron amdgpu ehci_hcd mfd_core firewire_core
i2c_algo_bit crc_itu_t xhci_pci xhci_hcd libata gpu_sched
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
scsi_mod fb_sys_fops cfbcopyarea usbcore ttm usb_common drm
drm_panel_orientation_quirks sha256_ssse3 sha256_generic libsha256
ipv6 nf_defrag_ipv6
[   62.931886] CPU: 6 PID: 1713 Comm: Xorg Tainted: G          I       5.8.5 #1
[   62.937867] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   62.945823] RIP: 0010:drm_warn_on_modeset_not_all_locked+0x66/0x6e [drm]
[   62.951498] Code: 6d 10 48 83 ed 10 eb de 48 8d bb e0 01 00 00 e8
12 b3 f7 e0 84 c0 75 02 0f 0b 48 8d bb b8 01 00 00 e8 00 b3 f7 e0 84
c0 75 02 <0f> 0b 5b 5d 41 5c c3 c3 55 48 89 fd 53 48 83 7e 30 00 48 89
f3 74
[   62.969891] RSP: 0018:ffffc90001c2fa48 EFLAGS: 00010246
[   62.974065] RAX: 0000000000000000 RBX: ffff888338568800 RCX: 0000000000000000
[   62.980133] RDX: ffffffffa05a1800 RSI: ffff8883382848b0 RDI: ffff8883385689b8
[   62.986232] RBP: ffff888338568b40 R08: ffff888341340000 R09: 0000000000000002
[   62.992345] R10: ffff888338568a58 R11: 000000000000003a R12: ffff888338568b50
[   62.998494] R13: ffff8883382848b0 R14: ffffffffa05a60c0 R15: 0000000000000000
[   63.004711] FS:  00007fc338eccf00(0000) GS:ffff888343d80000(0000)
knlGS:0000000000000000
[   63.011808] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.016396] CR2: 000055fda0926c60 CR3: 000000033c86c000 CR4: 00000000000006e0
[   63.022690] Call Trace:
[   63.023904]  drm_crtc_helper_set_mode+0x56/0x3d0 [drm_kms_helper]
[   63.028983]  ? blk_mq_dispatch_rq_list+0x3e4/0x41d
[   63.032479]  ? deadline_remove_request+0x79/0x8e
[   63.035946]  ? debug_mutex_unlock+0x84/0x88
[   63.038951]  ? deadline_front_merges_show+0x1c/0x1c
[   63.042701]  ? blk_mq_do_dispatch_sched+0x59/0xf5
[   63.046394]  ? __blk_mq_sched_dispatch_requests+0xdb/0x135
[   63.050776]  ? cpufreq_this_cpu_can_update+0x9/0x48
[   63.054693]  ? dbs_update_util_handler+0x11/0x74
[   63.058130]  ? newidle_balance.constprop.0+0xb6/0x287
[   63.062120]  ? dequeue_entity+0x198/0x1bb
[   63.065016]  amdgpu_connector_set_property+0x8a/0x1d4 [amdgpu]
[   63.069816]  drm_connector_set_obj_prop+0x4c/0x6c [drm]
[   63.074068]  drm_mode_obj_set_property_ioctl+0x1c3/0x255 [drm]
[   63.078900]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   63.083158]  drm_connector_property_set_ioctl+0x32/0x4c [drm]
[   63.087907]  drm_ioctl_kernel+0x8d/0xe1 [drm]
[   63.091222]  drm_ioctl+0x1f9/0x2d3 [drm]
[   63.093982]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   63.098496]  ? rpm_resume+0x9a/0x3dc
[   63.100903]  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
[   63.104463]  vfs_ioctl+0x1a/0x28
[   63.106493]  ksys_ioctl+0x5c/0x7b
[   63.108589]  __x64_sys_ioctl+0x11/0x14
[   63.111128]  do_syscall_64+0x48/0x62
[   63.113495]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   63.117414] RIP: 0033:0x7fc3393583bb
[   63.119755] Code: 0f 1e fa 48 8b 05 dd aa 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad aa 0c 00 f7 d8 64 89
01 48
[   63.137791] RSP: 002b:00007ffe020ca448 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   63.144301] RAX: ffffffffffffffda RBX: 00007ffe020ca480 RCX: 00007fc3393583bb
[   63.150298] RDX: 00007ffe020ca480 RSI: 00000000c01064ab RDI: 000000000000000e
[   63.156422] RBP: 00000000c01064ab R08: 000055fda302fc30 R09: 0000000000000001
[   63.162594] R10: 000055fda2ef7f50 R11: 0000000000000246 R12: 000055fda2eaa500
[   63.168773] R13: 000000000000000e R14: 000055fda2f97000 R15: 000055fda2f97000
[   63.174904] ---[ end trace 99e93b277d68b706 ]---
[   63.178417] ------------[ cut here ]------------
[   63.181898] WARNING: CPU: 6 PID: 1713 at
drivers/gpu/drm/drm_crtc_helper.c:148 drm_helper_crtc_in_use+0x31/0x73
[drm_kms_helper]
[   63.192658] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter bnep it87 hwmon_vid dm_mod dax snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel btusb btbcm
btintel bluetooth uvcvideo ecdh_generic videobuf2_vmalloc rfkill
videobuf2_memops videobuf2_v4l2 videobuf2_common ecc videodev
snd_usb_audio snd_usbmidi_lib mc joydev coretemp snd_virtuoso
kvm_intel snd_oxygen_lib snd_intel_dspcfg snd_hda_codec kvm
snd_mpu401_uart snd_hwdep irqbypass iTCO_wdt snd_rawmidi snd_hda_core
gpio_ich snd_seq r8169 mxm_wmi realtek psmouse snd_seq_device
tiny_power_button lpc_ich snd_pcm libphy pcspkr snd_hrtimer
acpi_cpufreq i2c_i801 i7core_edac snd_timer i2c_smbus snd button
soundcore wmi nfsd auth_rpcgss
[   63.192684]  binfmt_misc nfs_acl lockd grace sunrpc ip_tables
x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod
usbhid uhci_hcd crc32c_intel ehci_pci serio_raw firewire_ohci ahci
libahci pata_jmicron amdgpu ehci_hcd mfd_core firewire_core
i2c_algo_bit crc_itu_t xhci_pci xhci_hcd libata gpu_sched
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
scsi_mod fb_sys_fops cfbcopyarea usbcore ttm usb_common drm
drm_panel_orientation_quirks sha256_ssse3 sha256_generic libsha256
ipv6 nf_defrag_ipv6
[   63.329928] CPU: 6 PID: 1713 Comm: Xorg Tainted: G        W I       5.8.5 #1
[   63.335988] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   63.343968] RIP: 0010:drm_helper_crtc_in_use+0x31/0x73 [drm_kms_helper]
[   63.349439] Code: 48 8b 2f 48 89 ef e8 11 ff ff ff 84 c0 74 02 0f
0b 83 3d 85 9a ba e1 00 75 12 48 8d bd b8 01 00 00 e8 f1 32 d2 e0 84
c0 75 02 <0f> 0b 48 8b 85 20 03 00 00 48 81 c5 20 03 00 00 48 8d 58 f8
48 8d
[   63.367718] RSP: 0018:ffffc90001c2fa48 EFLAGS: 00010246
[   63.371885] RAX: 0000000000000000 RBX: ffff888338284800 RCX: 0000000000000000
[   63.378067] RDX: ffffffffa05a1800 RSI: ffff8883382848b0 RDI: ffff8883385689b8
[   63.384243] RBP: ffff888338568800 R08: ffff888341340000 R09: 0000000000000002
[   63.390374] R10: ffff888338568a58 R11: 000000000000003a R12: ffff888338284800
[   63.396497] R13: ffff8883382848b0 R14: ffffffffa05a60c0 R15: 0000000000000000
[   63.402683] FS:  00007fc338eccf00(0000) GS:ffff888343d80000(0000)
knlGS:0000000000000000
[   63.409890] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.414708] CR2: 000055fda0926c60 CR3: 000000033c86c000 CR4: 00000000000006e0
[   63.420920] Call Trace:
[   63.422128]  drm_crtc_helper_set_mode+0x68/0x3d0 [drm_kms_helper]
[   63.427220]  ? blk_mq_dispatch_rq_list+0x3e4/0x41d
[   63.430896]  ? deadline_remove_request+0x79/0x8e
[   63.434326]  ? debug_mutex_unlock+0x84/0x88
[   63.437320]  ? deadline_front_merges_show+0x1c/0x1c
[   63.441062]  ? blk_mq_do_dispatch_sched+0x59/0xf5
[   63.444587]  ? __blk_mq_sched_dispatch_requests+0xdb/0x135
[   63.448987]  ? cpufreq_this_cpu_can_update+0x9/0x48
[   63.452808]  ? dbs_update_util_handler+0x11/0x74
[   63.456324]  ? newidle_balance.constprop.0+0xb6/0x287
[   63.460339]  ? dequeue_entity+0x198/0x1bb
[   63.463286]  amdgpu_connector_set_property+0x8a/0x1d4 [amdgpu]
[   63.468069]  drm_connector_set_obj_prop+0x4c/0x6c [drm]
[   63.472248]  drm_mode_obj_set_property_ioctl+0x1c3/0x255 [drm]
[   63.477074]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   63.481569]  drm_connector_property_set_ioctl+0x32/0x4c [drm]
[   63.486265]  drm_ioctl_kernel+0x8d/0xe1 [drm]
[   63.489725]  drm_ioctl+0x1f9/0x2d3 [drm]
[   63.492597]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   63.497062]  ? rpm_resume+0x9a/0x3dc
[   63.499554]  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
[   63.503162]  vfs_ioctl+0x1a/0x28
[   63.505235]  ksys_ioctl+0x5c/0x7b
[   63.507323]  __x64_sys_ioctl+0x11/0x14
[   63.509799]  do_syscall_64+0x48/0x62
[   63.512143]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   63.516061] RIP: 0033:0x7fc3393583bb
[   63.518414] Code: 0f 1e fa 48 8b 05 dd aa 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad aa 0c 00 f7 d8 64 89
01 48
[   63.536807] RSP: 002b:00007ffe020ca448 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   63.543425] RAX: ffffffffffffffda RBX: 00007ffe020ca480 RCX: 00007fc3393583bb
[   63.549805] RDX: 00007ffe020ca480 RSI: 00000000c01064ab RDI: 000000000000000e
[   63.555922] RBP: 00000000c01064ab R08: 000055fda302fc30 R09: 0000000000000001
[   63.562293] R10: 000055fda2ef7f50 R11: 0000000000000246 R12: 000055fda2eaa500
[   63.568565] R13: 000000000000000e R14: 000055fda2f97000 R15: 000055fda2f97000
[   63.574940] ---[ end trace 99e93b277d68b707 ]---
[   63.578435] ------------[ cut here ]------------
[   63.582062] WARNING: CPU: 6 PID: 1713 at
drivers/gpu/drm/drm_crtc_helper.c:108
drm_helper_encoder_in_use+0x43/0xaa [drm_kms_helper]
[   63.593155] Modules linked in: nf_nat_ftp nf_conntrack_ftp cfg80211
af_packet nft_ct nft_chain_nat nf_tables ebtable_nat ebtable_broute
ip6table_nat ip6table_mangle ip6table_raw iptable_nat nf_nat
nf_conntrack nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter bnep it87 hwmon_vid dm_mod dax snd_hda_codec_realtek
snd_hda_codec_generic snd_hda_codec_hdmi snd_hda_intel btusb btbcm
btintel bluetooth uvcvideo ecdh_generic videobuf2_vmalloc rfkill
videobuf2_memops videobuf2_v4l2 videobuf2_common ecc videodev
snd_usb_audio snd_usbmidi_lib mc joydev coretemp snd_virtuoso
kvm_intel snd_oxygen_lib snd_intel_dspcfg snd_hda_codec kvm
snd_mpu401_uart snd_hwdep irqbypass iTCO_wdt snd_rawmidi snd_hda_core
gpio_ich snd_seq r8169 mxm_wmi realtek psmouse snd_seq_device
tiny_power_button lpc_ich snd_pcm libphy pcspkr snd_hrtimer
acpi_cpufreq i2c_i801 i7core_edac snd_timer i2c_smbus snd button
soundcore wmi nfsd auth_rpcgss
[   63.593180]  binfmt_misc nfs_acl lockd grace sunrpc ip_tables
x_tables ext4 crc32c_generic crc16 mbcache jbd2 sr_mod cdrom sd_mod
usbhid uhci_hcd crc32c_intel ehci_pci serio_raw firewire_ohci ahci
libahci pata_jmicron amdgpu ehci_hcd mfd_core firewire_core
i2c_algo_bit crc_itu_t xhci_pci xhci_hcd libata gpu_sched
drm_kms_helper cfbfillrect syscopyarea cfbimgblt sysfillrect sysimgblt
scsi_mod fb_sys_fops cfbcopyarea usbcore ttm usb_common drm
drm_panel_orientation_quirks sha256_ssse3 sha256_generic libsha256
ipv6 nf_defrag_ipv6
[   63.730716] CPU: 6 PID: 1713 Comm: Xorg Tainted: G        W I       5.8.5 #1
[   63.736692] Hardware name: Gigabyte Technology Co., Ltd.
EX58-UD3R/EX58-UD3R, BIOS FB  05/04/2009
[   63.744576] RIP: 0010:drm_helper_encoder_in_use+0x43/0xaa [drm_kms_helper]
[   63.750384] Code: 10 31 c0 48 89 ef e8 a9 ff ff ff 84 c0 74 02 0f
0b 83 3d 1d 9b ba e1 00 75 24 48 8d bd b8 01 00 00 e8 89 33 d2 e0 84
c0 75 02 <0f> 0b 48 8d bd e0 01 00 00 e8 77 33 d2 e0 84 c0 75 02 0f 0b
48 89
[   63.768713] RSP: 0018:ffffc90001c2fa18 EFLAGS: 00010246
[   63.772781] RAX: 0000000000000000 RBX: ffff888339076000 RCX: 0000000000000000
[   63.778935] RDX: ffffffffa05a1800 RSI: ffff8883382848b0 RDI: ffff8883385689b8
[   63.785066] RBP: ffff888338568800 R08: ffff888341340000 R09: 0000000000000002
[   63.791151] R10: ffff888338568a58 R11: 000000000000003a R12: ffff888338284800
[   63.797234] R13: ffff8883382848b0 R14: ffffffffa05a60c0 R15: 0000000000000000
[   63.803319] FS:  00007fc338eccf00(0000) GS:ffff888343d80000(0000)
knlGS:0000000000000000
[   63.810406] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   63.815065] CR2: 000055fda0926c60 CR3: 000000033c86c000 CR4: 00000000000006e0
[   63.821145] Call Trace:
[   63.822300]  ? drm_helper_crtc_in_use+0x33/0x73 [drm_kms_helper]
[   63.827327]  drm_helper_crtc_in_use+0x66/0x73 [drm_kms_helper]
[   63.832061]  drm_crtc_helper_set_mode+0x68/0x3d0 [drm_kms_helper]
[   63.837078]  ? blk_mq_dispatch_rq_list+0x3e4/0x41d
[   63.840718]  ? deadline_remove_request+0x79/0x8e
[   63.844234]  ? debug_mutex_unlock+0x84/0x88
[   63.847274]  ? deadline_front_merges_show+0x1c/0x1c
[   63.851065]  ? blk_mq_do_dispatch_sched+0x59/0xf5
[   63.854713]  ? __blk_mq_sched_dispatch_requests+0xdb/0x135
[   63.859071]  ? cpufreq_this_cpu_can_update+0x9/0x48
[   63.862888]  ? dbs_update_util_handler+0x11/0x74
[   63.866299]  ? newidle_balance.constprop.0+0xb6/0x287
[   63.870206]  ? dequeue_entity+0x198/0x1bb
[   63.873060]  amdgpu_connector_set_property+0x8a/0x1d4 [amdgpu]
[   63.877788]  drm_connector_set_obj_prop+0x4c/0x6c [drm]
[   63.881901]  drm_mode_obj_set_property_ioctl+0x1c3/0x255 [drm]
[   63.886705]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   63.891044]  drm_connector_property_set_ioctl+0x32/0x4c [drm]
[   63.895807]  drm_ioctl_kernel+0x8d/0xe1 [drm]
[   63.899008]  drm_ioctl+0x1f9/0x2d3 [drm]
[   63.901647]  ? drm_connector_set_obj_prop+0x6c/0x6c [drm]
[   63.905764]  ? rpm_resume+0x9a/0x3dc
[   63.908094]  amdgpu_drm_ioctl+0x45/0x71 [amdgpu]
[   63.911472]  vfs_ioctl+0x1a/0x28
[   63.913465]  ksys_ioctl+0x5c/0x7b
[   63.915542]  __x64_sys_ioctl+0x11/0x14
[   63.918020]  do_syscall_64+0x48/0x62
[   63.920370]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[   63.924306] RIP: 0033:0x7fc3393583bb
[   63.926669] Code: 0f 1e fa 48 8b 05 dd aa 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d ad aa 0c 00 f7 d8 64 89
01 48
[   63.944688] RSP: 002b:00007ffe020ca448 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[   63.951250] RAX: ffffffffffffffda RBX: 00007ffe020ca480 RCX: 00007fc3393583bb
[   63.957333] RDX: 00007ffe020ca480 RSI: 00000000c01064ab RDI: 000000000000000e
[   63.963393] RBP: 00000000c01064ab R08: 000055fda302fc30 R09: 0000000000000001
[   63.969559] R10: 000055fda2ef7f50 R11: 0000000000000246 R12: 000055fda2eaa500
[   63.975693] R13: 000000000000000e R14: 000055fda2f97000 R15: 000055fda2f97000
[   63.982154] ---[ end trace 99e93b277d68b708 ]---

Both compilers were compiled with:

$ gcc --version
gcc (GCC) 10.2.1 20200723 (Red Hat 10.2.1-1)
Copyright (C) 2020 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

My graphics card is:

02:00.0 VGA compatible controller: Advanced Micro Devices, Inc.
[AMD/ATI] Tobago PRO [Radeon R7 360 / R9 360 OEM] (rev 81)
02:00.1 Audio device: Advanced Micro Devices, Inc. [AMD/ATI] Tobago
HDMI Audio [Radeon R7 360 / R9 360 OEM]

02:00.0 0300: 1002:665f (rev 81) (prog-if 00 [VGA controller])
Subsystem: 1682:7360
Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin A routed to IRQ 42
Region 0: Memory at b0000000 (64-bit, prefetchable) [size=256M]
Region 2: Memory at cf800000 (64-bit, prefetchable) [size=8M]
Region 4: I/O ports at ce00 [size=256]
Region 5: Memory at fbc80000 (32-bit, non-prefetchable) [size=256K]
Expansion ROM at 000c0000 [virtual] [disabled] [size=128K]
Capabilities: [48] Vendor Specific Information: Len=08 <?>
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1+,D2+,D3hot+,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM L0s L1 Enabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s (downgraded), Width x16 (ok)
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, NROPrPrP-, LTR-
10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt+,
EETLPPrefix+, MaxEETLPPrefixes 1
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
AtomicOpsCtl: ReqEn-
LnkCtl2: Target Link Speed: 8GT/s, EnterCompliance- SpeedDis-
Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
Compliance De-emphasis: -6dB
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee20004  Data: 4023
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Capabilities: [200 v1] Resizable BAR <?>
Capabilities: [270 v1] Secondary PCI Express
LnkCtl3: LnkEquIntrruptEn-, PerformEqu-
LaneErrStat: 0
Capabilities: [2b0 v1] Address Translation Service (ATS)
ATSCap: Invalidate Queue Depth: 00
ATSCtl: Enable-, Smallest Translation Unit: 00
Capabilities: [2c0 v1] Page Request Interface (PRI)
PRICtl: Enable- Reset-
PRISta: RF- UPRGI- Stopped+
Page Request Capacity: 00000020, Page Request Allocation: 00000000
Capabilities: [2d0 v1] Process Address Space ID (PASID)
PASIDCap: Exec+ Priv+, Max PASID Width: 10
PASIDCtl: Enable- Exec- Priv-
Kernel driver in use: amdgpu
Kernel modules: amdgpu

02:00.1 0403: 1002:aac0
Subsystem: 1682:aac0
Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr-
Stepping- SERR- FastB2B- DisINTx+
Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort-
<TAbort- <MAbort- >SERR- <PERR- INTx-
Latency: 0, Cache Line Size: 64 bytes
Interrupt: pin B routed to IRQ 45
Region 0: Memory at fbcfc000 (64-bit, non-prefetchable) [size=16K]
Capabilities: [48] Vendor Specific Information: Len=08 <?>
Capabilities: [50] Power Management version 3
Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
Capabilities: [58] Express (v2) Legacy Endpoint, MSI 00
DevCap: MaxPayload 256 bytes, PhantFunc 0, Latency L0s <4us, L1 unlimited
ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset-
DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
MaxPayload 256 bytes, MaxReadReq 512 bytes
DevSta: CorrErr+ NonFatalErr- FatalErr- UnsupReq+ AuxPwr- TransPend-
LnkCap: Port #0, Speed 8GT/s, Width x16, ASPM L0s L1, Exit Latency L0s
<64ns, L1 <1us
ClockPM- Surprise- LLActRep- BwNot- ASPMOptComp+
LnkCtl: ASPM Disabled; RCB 64 bytes Disabled- CommClk+
ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
LnkSta: Speed 5GT/s (downgraded), Width x16 (ok)
TrErr- Train- SlotClk+ DLActive- BWMgmt- ABWMgmt-
DevCap2: Completion Timeout: Not Supported, TimeoutDis-, NROPrPrP-, LTR-
10BitTagComp-, 10BitTagReq-, OBFF Not Supported, ExtFmt+,
EETLPPrefix+, MaxEETLPPrefixes 1
EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
FRS-
AtomicOpsCap: 32bit- 64bit- 128bitCAS-
DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis-, LTR-, OBFF Disabled
AtomicOpsCtl: ReqEn-
LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete-,
EqualizationPhase1-
EqualizationPhase2-, EqualizationPhase3-, LinkEqualizationRequest-
Capabilities: [a0] MSI: Enable+ Count=1/1 Maskable- 64bit+
Address: 00000000fee08004  Data: 4024
Capabilities: [100 v1] Vendor Specific Information: ID=0001 Rev=1 Len=010 <?>
Capabilities: [150 v2] Advanced Error Reporting
UESta: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UEMsk: DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF-
MalfTLP- ECRC- UnsupReq- ACSViol-
UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+
MalfTLP+ ECRC- UnsupReq- ACSViol-
CESta: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
CEMsk: RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr+
AERCap: First Error Pointer: 00, ECRCGenCap+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-
MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
HeaderLog: 00000000 00000000 00000000 00000000
Kernel driver in use: snd_hda_intel
Kernel modules: snd_hda_intel

Cheers,
Chris
