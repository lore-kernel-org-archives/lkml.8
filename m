Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66FA0C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3962065E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 00:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgGRA7A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 20:59:00 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52870 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726710AbgGRA67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 20:58:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id q15so17397335wmj.2;
        Fri, 17 Jul 2020 17:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:organization
         :mime-version:content-transfer-encoding;
        bh=/PdY9yUn2KrBvCorXfG7XyyrC50Lzxo7LNI7fuQTy0E=;
        b=Q1/tfDSOp8eNCDCch/EKNwtg0LLX6OTMJs3miiobZOEWmdUoenwjxF1siNmZOEvntr
         6WxWqf4phXukneBxj38hObZDvh0NiNmNToLlBZSxkk3vYnASXXhxcBpfvwfVR2/LXyfi
         x888sdxd5Q6Qx1bOdueiZsEvZTjlwEvFMILMgy5fbKvc6QaI9lOg/KW5xMOhtlLHza5a
         u+nFtKyZaiVuqzQIgN+FvpDggI5G17vmICYEwbwLYcwGO9zg8gAGDgEWpnqGIesqyvrX
         BpCfGnvixgcncMl7VWnD8vR7XqiPsGkCuAOj0JMXy1pGIabwB/KYGggrHe2ZqgCszmUH
         2DRA==
X-Gm-Message-State: AOAM533fWjzarSUOoaePYd38wx1aSKoPwDFR/2Qi4ezwF8BKEjGRIWV2
        4dRG1E33I5HkpN/BzHECqZc=
X-Google-Smtp-Source: ABdhPJwGs/Z4pAuvWhOKwGnUsoiphbr4YZfNvTKhb1dNYuQ6tPZcPVc/s8cvuWT84uvKKNeB60/CeA==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr12271552wml.25.1595033934373;
        Fri, 17 Jul 2020 17:58:54 -0700 (PDT)
Received: from msft-t490s.fritz.box (host-80-104-32-206.retail.telecomitalia.it. [80.104.32.206])
        by smtp.gmail.com with ESMTPSA id x11sm15623057wmc.26.2020.07.17.17.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2020 17:58:53 -0700 (PDT)
Date:   Sat, 18 Jul 2020 02:58:46 +0200
From:   Matteo Croce <mcroce@linux.microsoft.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kelsey Skunberg <skunberg.kelsey@gmail.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: warning unloading wmi
Message-ID: <20200718025846.16811ec8@msft-t490s.fritz.box>
Organization: Microsoft
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this warning when unloading wmi:

[  246.219255] ------------[ cut here ]------------
[  246.219257] sysfs group 'power' not found for kobject '1F13AB7F-6220-4210-8F8E-8BB5E71EE969'
[  246.219271] WARNING: CPU: 4 PID: 1744 at fs/sysfs/group.c:279 sysfs_remove_group+0x6f/0x80
[  246.219271] Modules linked in: ccm rfcomm xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat ip_set nf_tables nfnetlink cmac bnep vfat fat elan_i2c mei_hdcp mei_wdt intel_rapl_msr iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_sof_pci snd_sof_intel_byt snd_sof_intel_ipc irqbypass snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_xtensa_dsp intel_cstate snd_sof_intel_hda snd_sof intel_uncore snd_hda_codec_hdmi intel_rapl_perf snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core iwlmvm snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_hda_codec_realtek snd_hda_codec_generic snd_compress ac97_bus mac80211 snd_pcm_dmaengine snd_hda_intel uvcvideo
[  246.219291]  snd_intel_dspcfg btusb snd_hda_codec btrtl videobuf2_vmalloc pcspkr btbcm videobuf2_memops btintel libarc4 snd_hda_core bluetooth videobuf2_v4l2 videobuf2_common snd_hwdep iwlwifi videodev joydev thunderbolt snd_seq mc snd_seq_device ecdh_generic ecc cfg80211 snd_pcm ucsi_acpi mei_me processor_thermal_device intel_rapl_common snd_timer mei intel_soc_dts_iosf i2c_i801 intel_pch_thermal typec_ucsi typec thinkpad_acpi ledtrig_audio snd soundcore rfkill int3403_thermal int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad i2c_dev ip_tables i915 hid_multitouch rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit cec drm_kms_helper e1000e ghash_clmulni_intel nvme drm serio_raw nvme_core rtsx_pci wmi(-) video pinctrl_cannonlake pinctrl_intel fuse [last unloaded: intel_wmi_thunderbolt]
[  246.219312] CPU: 4 PID: 1744 Comm: rmmod Not tainted 5.7.8-200.fc32.x86_64 #1
[  246.219312] Hardware name: LENOVO 20NYSA084G/20NYSA084G, BIOS N2JET88W (1.66 ) 04/22/2020
[  246.219315] RIP: 0010:sysfs_remove_group+0x6f/0x80
[  246.219317] Code: ff 5b 48 89 ef 5d 41 5c e9 8e c3 ff ff 48 89 ef e8 e6 bc ff ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 f0 68 39 9e e8 a8 09 d1 ff <0f> 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[  246.219318] RSP: 0018:ffffac1580de3dc8 EFLAGS: 00010292
[  246.219319] RAX: 0000000000000050 RBX: ffffffff9e0f6400 RCX: 0000000000000007
[  246.219320] RDX: 00000000fffffff8 RSI: 0000000000000092 RDI: ffff9527fe719cc0
[  246.219320] RBP: 0000000000000000 R08: 00000000000004dd R09: 0000000000000003
[  246.219321] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9527fb505c00
[  246.219322] R13: ffff9527fb505c80 R14: ffff9527fb423000 R15: 0000000000000000
[  246.219323] FS:  00007fcfa6e60740(0000) GS:ffff9527fe700000(0000) knlGS:0000000000000000
[  246.219324] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  246.219325] CR2: 000055b55a202078 CR3: 000000047a64e005 CR4: 00000000003606e0
[  246.219326] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  246.219326] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  246.219327] Call Trace:
[  246.219334]  device_del+0x97/0x3f0
[  246.219338]  ? acpi_os_signal_semaphore+0x29/0x40
[  246.219341]  ? acpi_ut_release_mutex+0x70/0x75
[  246.219343]  device_unregister+0x16/0x60
[  246.219346]  acpi_wmi_remove+0xf0/0x110 [wmi]
[  246.219348]  platform_drv_remove+0x24/0x40
[  246.219350]  __device_release_driver+0x15c/0x210
[  246.219352]  driver_detach+0xcb/0x10d
[  246.219353]  bus_remove_driver+0x58/0xcc
[  246.219356]  acpi_wmi_exit+0xc/0xfac [wmi]
[  246.219358]  __do_sys_delete_module.constprop.0+0x14e/0x2d0
[  246.219362]  do_syscall_64+0x5b/0xf0
[  246.219366]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  246.219368] RIP: 0033:0x7fcfa6f9031b
[  246.219369] Code: 73 01 c3 48 8b 0d 7d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 0b 0c 00 f7 d8 64 89 01 48
[  246.219370] RSP: 002b:00007ffcb61b3f28 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.219371] RAX: ffffffffffffffda RBX: 000055b55a1f7760 RCX: 00007fcfa6f9031b
[  246.219372] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b55a1f77c8
[  246.219373] RBP: 000055b55a1f72a0 R08: 1999999999999999 R09: 0000000000000000
[  246.219373] R10: 00007fcfa7004ac0 R11: 0000000000000206 R12: 00007ffcb61b471e
[  246.219374] R13: 0000000000000000 R14: 00007ffcb61b4150 R15: 000055b55a1f7760
[  246.219376] ---[ end trace e72269a76e8f7465 ]---
[  246.219420] ------------[ cut here ]------------
[  246.219421] sysfs group 'power' not found for kobject '2BC49DEF-7B15-4F05-8BB7-EE37B9547C0B'
[  246.219431] WARNING: CPU: 4 PID: 1744 at fs/sysfs/group.c:279 sysfs_remove_group+0x6f/0x80
[  246.219431] Modules linked in: ccm rfcomm xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat ip_set nf_tables nfnetlink cmac bnep vfat fat elan_i2c mei_hdcp mei_wdt intel_rapl_msr iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_sof_pci snd_sof_intel_byt snd_sof_intel_ipc irqbypass snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_xtensa_dsp intel_cstate snd_sof_intel_hda snd_sof intel_uncore snd_hda_codec_hdmi intel_rapl_perf snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core iwlmvm snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_hda_codec_realtek snd_hda_codec_generic snd_compress ac97_bus mac80211 snd_pcm_dmaengine snd_hda_intel uvcvideo
[  246.219445]  snd_intel_dspcfg btusb snd_hda_codec btrtl videobuf2_vmalloc pcspkr btbcm videobuf2_memops btintel libarc4 snd_hda_core bluetooth videobuf2_v4l2 videobuf2_common snd_hwdep iwlwifi videodev joydev thunderbolt snd_seq mc snd_seq_device ecdh_generic ecc cfg80211 snd_pcm ucsi_acpi mei_me processor_thermal_device intel_rapl_common snd_timer mei intel_soc_dts_iosf i2c_i801 intel_pch_thermal typec_ucsi typec thinkpad_acpi ledtrig_audio snd soundcore rfkill int3403_thermal int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad i2c_dev ip_tables i915 hid_multitouch rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit cec drm_kms_helper e1000e ghash_clmulni_intel nvme drm serio_raw nvme_core rtsx_pci wmi(-) video pinctrl_cannonlake pinctrl_intel fuse [last unloaded: intel_wmi_thunderbolt]
[  246.219459] CPU: 4 PID: 1744 Comm: rmmod Tainted: G        W         5.7.8-200.fc32.x86_64 #1
[  246.219459] Hardware name: LENOVO 20NYSA084G/20NYSA084G, BIOS N2JET88W (1.66 ) 04/22/2020
[  246.219461] RIP: 0010:sysfs_remove_group+0x6f/0x80
[  246.219462] Code: ff 5b 48 89 ef 5d 41 5c e9 8e c3 ff ff 48 89 ef e8 e6 bc ff ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 f0 68 39 9e e8 a8 09 d1 ff <0f> 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[  246.219463] RSP: 0018:ffffac1580de3dc8 EFLAGS: 00010292
[  246.219464] RAX: 0000000000000050 RBX: ffffffff9e0f6400 RCX: 0000000000000007
[  246.219465] RDX: 00000000fffffff8 RSI: 0000000000000092 RDI: ffff9527fe719cc0
[  246.219466] RBP: 0000000000000000 R08: 0000000000000508 R09: 0000000000000003
[  246.219466] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9527fb507400
[  246.219467] R13: ffff9527fb507480 R14: ffff9527fb420800 R15: 0000000000000000
[  246.219468] FS:  00007fcfa6e60740(0000) GS:ffff9527fe700000(0000) knlGS:0000000000000000
[  246.219469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  246.219469] CR2: 000055b55a202078 CR3: 000000047a64e005 CR4: 00000000003606e0
[  246.219470] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  246.219471] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  246.219471] Call Trace:
[  246.219474]  device_del+0x97/0x3f0
[  246.219477]  ? acpi_os_signal_semaphore+0x29/0x40
[  246.219478]  ? acpi_ut_release_mutex+0x70/0x75
[  246.219480]  device_unregister+0x16/0x60
[  246.219483]  acpi_wmi_remove+0xf0/0x110 [wmi]
[  246.219485]  platform_drv_remove+0x24/0x40
[  246.219486]  __device_release_driver+0x15c/0x210
[  246.219488]  driver_detach+0xcb/0x10d
[  246.219489]  bus_remove_driver+0x58/0xcc
[  246.219491]  acpi_wmi_exit+0xc/0xfac [wmi]
[  246.219493]  __do_sys_delete_module.constprop.0+0x14e/0x2d0
[  246.219496]  do_syscall_64+0x5b/0xf0
[  246.219498]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  246.219499] RIP: 0033:0x7fcfa6f9031b
[  246.219500] Code: 73 01 c3 48 8b 0d 7d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 0b 0c 00 f7 d8 64 89 01 48
[  246.219501] RSP: 002b:00007ffcb61b3f28 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.219502] RAX: ffffffffffffffda RBX: 000055b55a1f7760 RCX: 00007fcfa6f9031b
[  246.219503] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b55a1f77c8
[  246.219503] RBP: 000055b55a1f72a0 R08: 1999999999999999 R09: 0000000000000000
[  246.219504] R10: 00007fcfa7004ac0 R11: 0000000000000206 R12: 00007ffcb61b471e
[  246.219505] R13: 0000000000000000 R14: 00007ffcb61b4150 R15: 000055b55a1f7760
[  246.219506] ---[ end trace e72269a76e8f7466 ]---
[  246.219515] ------------[ cut here ]------------
[  246.219515] sysfs group 'power' not found for kobject 'A6FEA33E-DABF-46F5-BFC8-460D961BEC9F'
[  246.219525] WARNING: CPU: 4 PID: 1744 at fs/sysfs/group.c:279 sysfs_remove_group+0x6f/0x80
[  246.219525] Modules linked in: ccm rfcomm xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat ip_set nf_tables nfnetlink cmac bnep vfat fat elan_i2c mei_hdcp mei_wdt intel_rapl_msr iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_sof_pci snd_sof_intel_byt snd_sof_intel_ipc irqbypass snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_xtensa_dsp intel_cstate snd_sof_intel_hda snd_sof intel_uncore snd_hda_codec_hdmi intel_rapl_perf snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core iwlmvm snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_hda_codec_realtek snd_hda_codec_generic snd_compress ac97_bus mac80211 snd_pcm_dmaengine snd_hda_intel uvcvideo
[  246.219538]  snd_intel_dspcfg btusb snd_hda_codec btrtl videobuf2_vmalloc pcspkr btbcm videobuf2_memops btintel libarc4 snd_hda_core bluetooth videobuf2_v4l2 videobuf2_common snd_hwdep iwlwifi videodev joydev thunderbolt snd_seq mc snd_seq_device ecdh_generic ecc cfg80211 snd_pcm ucsi_acpi mei_me processor_thermal_device intel_rapl_common snd_timer mei intel_soc_dts_iosf i2c_i801 intel_pch_thermal typec_ucsi typec thinkpad_acpi ledtrig_audio snd soundcore rfkill int3403_thermal int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad i2c_dev ip_tables i915 hid_multitouch rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit cec drm_kms_helper e1000e ghash_clmulni_intel nvme drm serio_raw nvme_core rtsx_pci wmi(-) video pinctrl_cannonlake pinctrl_intel fuse [last unloaded: intel_wmi_thunderbolt]
[  246.219552] CPU: 4 PID: 1744 Comm: rmmod Tainted: G        W         5.7.8-200.fc32.x86_64 #1
[  246.219552] Hardware name: LENOVO 20NYSA084G/20NYSA084G, BIOS N2JET88W (1.66 ) 04/22/2020
[  246.219554] RIP: 0010:sysfs_remove_group+0x6f/0x80
[  246.219555] Code: ff 5b 48 89 ef 5d 41 5c e9 8e c3 ff ff 48 89 ef e8 e6 bc ff ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 f0 68 39 9e e8 a8 09 d1 ff <0f> 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[  246.219556] RSP: 0018:ffffac1580de3dc8 EFLAGS: 00010292
[  246.219557] RAX: 0000000000000050 RBX: ffffffff9e0f6400 RCX: 0000000000000007
[  246.219557] RDX: 00000000fffffff8 RSI: 0000000000000092 RDI: ffff9527fe719cc0
[  246.219558] RBP: 0000000000000000 R08: 0000000000000533 R09: 0000000000000003
[  246.219559] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9527fb501c00
[  246.219559] R13: ffff9527fb501c80 R14: ffff9527fb420800 R15: 0000000000000000
[  246.219560] FS:  00007fcfa6e60740(0000) GS:ffff9527fe700000(0000) knlGS:0000000000000000
[  246.219561] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  246.219562] CR2: 000055b55a202078 CR3: 000000047a64e005 CR4: 00000000003606e0
[  246.219562] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  246.219563] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  246.219563] Call Trace:
[  246.219566]  device_del+0x97/0x3f0
[  246.219568]  device_unregister+0x16/0x60
[  246.219570]  acpi_wmi_remove+0xf0/0x110 [wmi]
[  246.219572]  platform_drv_remove+0x24/0x40
[  246.219574]  __device_release_driver+0x15c/0x210
[  246.219575]  driver_detach+0xcb/0x10d
[  246.219577]  bus_remove_driver+0x58/0xcc
[  246.219579]  acpi_wmi_exit+0xc/0xfac [wmi]
[  246.219580]  __do_sys_delete_module.constprop.0+0x14e/0x2d0
[  246.219583]  do_syscall_64+0x5b/0xf0
[  246.219585]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  246.219586] RIP: 0033:0x7fcfa6f9031b
[  246.219587] Code: 73 01 c3 48 8b 0d 7d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 0b 0c 00 f7 d8 64 89 01 48
[  246.219587] RSP: 002b:00007ffcb61b3f28 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.219589] RAX: ffffffffffffffda RBX: 000055b55a1f7760 RCX: 00007fcfa6f9031b
[  246.219589] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b55a1f77c8
[  246.219590] RBP: 000055b55a1f72a0 R08: 1999999999999999 R09: 0000000000000000
[  246.219591] R10: 00007fcfa7004ac0 R11: 0000000000000206 R12: 00007ffcb61b471e
[  246.219591] R13: 0000000000000000 R14: 00007ffcb61b4150 R15: 000055b55a1f7760
[  246.219593] ---[ end trace e72269a76e8f7467 ]---
[  246.219600] ------------[ cut here ]------------
[  246.219601] sysfs group 'power' not found for kobject '05901221-D566-11D1-B2F0-00A0C9062910'
[  246.219610] WARNING: CPU: 4 PID: 1744 at fs/sysfs/group.c:279 sysfs_remove_group+0x6f/0x80
[  246.219610] Modules linked in: ccm rfcomm xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat ip_set nf_tables nfnetlink cmac bnep vfat fat elan_i2c mei_hdcp mei_wdt intel_rapl_msr iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_sof_pci snd_sof_intel_byt snd_sof_intel_ipc irqbypass snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_xtensa_dsp intel_cstate snd_sof_intel_hda snd_sof intel_uncore snd_hda_codec_hdmi intel_rapl_perf snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core iwlmvm snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_hda_codec_realtek snd_hda_codec_generic snd_compress ac97_bus mac80211 snd_pcm_dmaengine snd_hda_intel uvcvideo
[  246.219623]  snd_intel_dspcfg btusb snd_hda_codec btrtl videobuf2_vmalloc pcspkr btbcm videobuf2_memops btintel libarc4 snd_hda_core bluetooth videobuf2_v4l2 videobuf2_common snd_hwdep iwlwifi videodev joydev thunderbolt snd_seq mc snd_seq_device ecdh_generic ecc cfg80211 snd_pcm ucsi_acpi mei_me processor_thermal_device intel_rapl_common snd_timer mei intel_soc_dts_iosf i2c_i801 intel_pch_thermal typec_ucsi typec thinkpad_acpi ledtrig_audio snd soundcore rfkill int3403_thermal int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad i2c_dev ip_tables i915 hid_multitouch rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit cec drm_kms_helper e1000e ghash_clmulni_intel nvme drm serio_raw nvme_core rtsx_pci wmi(-) video pinctrl_cannonlake pinctrl_intel fuse [last unloaded: intel_wmi_thunderbolt]
[  246.219637] CPU: 4 PID: 1744 Comm: rmmod Tainted: G        W         5.7.8-200.fc32.x86_64 #1
[  246.219637] Hardware name: LENOVO 20NYSA084G/20NYSA084G, BIOS N2JET88W (1.66 ) 04/22/2020
[  246.219639] RIP: 0010:sysfs_remove_group+0x6f/0x80
[  246.219640] Code: ff 5b 48 89 ef 5d 41 5c e9 8e c3 ff ff 48 89 ef e8 e6 bc ff ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 f0 68 39 9e e8 a8 09 d1 ff <0f> 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[  246.219641] RSP: 0018:ffffac1580de3dc8 EFLAGS: 00010292
[  246.219642] RAX: 0000000000000050 RBX: ffffffff9e0f6400 RCX: 0000000000000007
[  246.219642] RDX: 00000000fffffff8 RSI: 0000000000000092 RDI: ffff9527fe719cc0
[  246.219643] RBP: 0000000000000000 R08: 000000000000055c R09: 0000000000000003
[  246.219643] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9527fb502400
[  246.219644] R13: ffff9527fb502480 R14: ffff9527fb420800 R15: 0000000000000000
[  246.219645] FS:  00007fcfa6e60740(0000) GS:ffff9527fe700000(0000) knlGS:0000000000000000
[  246.219646] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  246.219646] CR2: 000055b55a202078 CR3: 000000047a64e005 CR4: 00000000003606e0
[  246.219647] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  246.219648] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  246.219648] Call Trace:
[  246.219651]  device_del+0x97/0x3f0
[  246.219653]  device_unregister+0x16/0x60
[  246.219654]  acpi_wmi_remove+0xf0/0x110 [wmi]
[  246.219656]  platform_drv_remove+0x24/0x40
[  246.219658]  __device_release_driver+0x15c/0x210
[  246.219659]  driver_detach+0xcb/0x10d
[  246.219660]  bus_remove_driver+0x58/0xcc
[  246.219662]  acpi_wmi_exit+0xc/0xfac [wmi]
[  246.219664]  __do_sys_delete_module.constprop.0+0x14e/0x2d0
[  246.219666]  do_syscall_64+0x5b/0xf0
[  246.219668]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  246.219669] RIP: 0033:0x7fcfa6f9031b
[  246.219671] Code: 73 01 c3 48 8b 0d 7d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 0b 0c 00 f7 d8 64 89 01 48
[  246.219671] RSP: 002b:00007ffcb61b3f28 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.219672] RAX: ffffffffffffffda RBX: 000055b55a1f7760 RCX: 00007fcfa6f9031b
[  246.219673] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b55a1f77c8
[  246.219673] RBP: 000055b55a1f72a0 R08: 1999999999999999 R09: 0000000000000000
[  246.219674] R10: 00007fcfa7004ac0 R11: 0000000000000206 R12: 00007ffcb61b471e
[  246.219675] R13: 0000000000000000 R14: 00007ffcb61b4150 R15: 000055b55a1f7760
[  246.219676] ---[ end trace e72269a76e8f7468 ]---
[  246.219719] ------------[ cut here ]------------
[  246.219720] sysfs group 'power' not found for kobject '86CCFD48-205E-4A77-9C48-2021CBEDE341'
[  246.219730] WARNING: CPU: 4 PID: 1744 at fs/sysfs/group.c:279 sysfs_remove_group+0x6f/0x80
[  246.219730] Modules linked in: ccm rfcomm xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nft_objref nf_conntrack_tftp nft_counter tun bridge stp llc nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c ip6_tables nft_compat ip_set nf_tables nfnetlink cmac bnep vfat fat elan_i2c mei_hdcp mei_wdt intel_rapl_msr iTCO_wdt iTCO_vendor_support x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm snd_sof_pci snd_sof_intel_byt snd_sof_intel_ipc irqbypass snd_sof_intel_hda_common snd_soc_hdac_hda snd_sof_xtensa_dsp intel_cstate snd_sof_intel_hda snd_sof intel_uncore snd_hda_codec_hdmi intel_rapl_perf snd_soc_skl snd_soc_sst_ipc snd_soc_sst_dsp snd_hda_ext_core iwlmvm snd_soc_acpi_intel_match snd_soc_acpi snd_soc_core snd_hda_codec_realtek snd_hda_codec_generic snd_compress ac97_bus mac80211 snd_pcm_dmaengine snd_hda_intel uvcvideo
[  246.219744]  snd_intel_dspcfg btusb snd_hda_codec btrtl videobuf2_vmalloc pcspkr btbcm videobuf2_memops btintel libarc4 snd_hda_core bluetooth videobuf2_v4l2 videobuf2_common snd_hwdep iwlwifi videodev joydev thunderbolt snd_seq mc snd_seq_device ecdh_generic ecc cfg80211 snd_pcm ucsi_acpi mei_me processor_thermal_device intel_rapl_common snd_timer mei intel_soc_dts_iosf i2c_i801 intel_pch_thermal typec_ucsi typec thinkpad_acpi ledtrig_audio snd soundcore rfkill int3403_thermal int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad i2c_dev ip_tables i915 hid_multitouch rtsx_pci_sdmmc mmc_core crct10dif_pclmul crc32_pclmul crc32c_intel i2c_algo_bit cec drm_kms_helper e1000e ghash_clmulni_intel nvme drm serio_raw nvme_core rtsx_pci wmi(-) video pinctrl_cannonlake pinctrl_intel fuse [last unloaded: intel_wmi_thunderbolt]
[  246.219757] CPU: 4 PID: 1744 Comm: rmmod Tainted: G        W         5.7.8-200.fc32.x86_64 #1
[  246.219758] Hardware name: LENOVO 20NYSA084G/20NYSA084G, BIOS N2JET88W (1.66 ) 04/22/2020
[  246.219760] RIP: 0010:sysfs_remove_group+0x6f/0x80
[  246.219761] Code: ff 5b 48 89 ef 5d 41 5c e9 8e c3 ff ff 48 89 ef e8 e6 bc ff ff eb d1 49 8b 14 24 48 8b 33 48 c7 c7 f0 68 39 9e e8 a8 09 d1 ff <0f> 0b 5b 5d 41 5c c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00
[  246.219761] RSP: 0018:ffffac1580de3dc8 EFLAGS: 00010292
[  246.219762] RAX: 0000000000000050 RBX: ffffffff9e0f6400 RCX: 0000000000000007
[  246.219763] RDX: 00000000fffffff8 RSI: 0000000000000092 RDI: ffff9527fe719cc0
[  246.219763] RBP: 0000000000000000 R08: 0000000000000585 R09: 0000000000000003
[  246.219764] R10: 0000000000000000 R11: 0000000000000001 R12: ffff9527fb505000
[  246.219765] R13: ffff9527fb505080 R14: ffff9527fb41b800 R15: 0000000000000000
[  246.219766] FS:  00007fcfa6e60740(0000) GS:ffff9527fe700000(0000) knlGS:0000000000000000
[  246.219767] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  246.219767] CR2: 000055b55a202078 CR3: 000000047a64e005 CR4: 00000000003606e0
[  246.219768] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  246.219769] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  246.219769] Call Trace:
[  246.219772]  device_del+0x97/0x3f0
[  246.219774]  ? acpi_os_signal_semaphore+0x29/0x40
[  246.219776]  ? acpi_ut_release_mutex+0x70/0x75
[  246.219778]  device_unregister+0x16/0x60
[  246.219780]  acpi_wmi_remove+0xf0/0x110 [wmi]
[  246.219782]  platform_drv_remove+0x24/0x40
[  246.219783]  __device_release_driver+0x15c/0x210
[  246.219784]  driver_detach+0xcb/0x10d
[  246.219786]  bus_remove_driver+0x58/0xcc
[  246.219788]  acpi_wmi_exit+0xc/0xfac [wmi]
[  246.219789]  __do_sys_delete_module.constprop.0+0x14e/0x2d0
[  246.219791]  do_syscall_64+0x5b/0xf0
[  246.219794]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  246.219795] RIP: 0033:0x7fcfa6f9031b
[  246.219796] Code: 73 01 c3 48 8b 0d 7d 0b 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 0b 0c 00 f7 d8 64 89 01 48
[  246.219796] RSP: 002b:00007ffcb61b3f28 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  246.219797] RAX: ffffffffffffffda RBX: 000055b55a1f7760 RCX: 00007fcfa6f9031b
[  246.219798] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055b55a1f77c8
[  246.219799] RBP: 000055b55a1f72a0 R08: 1999999999999999 R09: 0000000000000000
[  246.219799] R10: 00007fcfa7004ac0 R11: 0000000000000206 R12: 00007ffcb61b471e
[  246.219800] R13: 0000000000000000 R14: 00007ffcb61b4150 R15: 000055b55a1f7760
[  246.219801] ---[ end trace e72269a76e8f7469 ]---

$ uname -a
Linux t490s 5.7.8-200.fc32.x86_64 #1 SMP Thu Jul 9 14:34:51 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

Regards,
-- 
per aspera ad upstream
