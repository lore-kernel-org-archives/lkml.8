Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C44C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F0320747
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 06:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="n1saii3L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgDHGSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 02:18:41 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:36441 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725932AbgDHGSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 02:18:41 -0400
Received: from surfplank2.hierzo ([IPv6:2001:981:a812:0:b62e:99ff:fe92:5264])
        by smtp-cloud9.xs4all.net with ESMTPA
        id M42jj7OuhZJ1DM42kjqF1s; Wed, 08 Apr 2020 08:18:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1586326715; bh=IWz1Eol3hKpZRpRwjmmpdHhVcccvnlQ3NCKIzsoC4c8=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=n1saii3LqFyEe4IT0tfLpc3NP0rZMHe1YvhNLpPSnU50khmpeAtNfstbygXCeWH3A
         qDh6+izUrt7JOAdkXk0DTs5iSm3Z/kfPBJSgwBrOlB1vycEACfliyp8ZBCuGNMK/tY
         z7EI3gzA7u5MHLW7hZ6TlMyyOv2sym6KkiMQYd0gZ7gzRyeOOAnS9MF23GU5NAzHQM
         zeyMhqas6Juu/7q8AjWGW9CwFu2DovxmCbffgdedjUg5znjtyd3gKMZkTprfa9Hs7U
         mO9Mv1wFQ74TM1yLwanVJBOJG7u9KI8KuRG92mDbqVOPv70+IcWAWmvdTGp6BsSD2d
         r1/xdOex9vm9Q==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Subject: 5.6.2: general protection faultS
Message-ID: <0a16e994-db0a-8c2a-09bb-f3499a943e6f@xs4all.nl>
Date:   Wed, 8 Apr 2020 08:18:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMO6IwZHBIsZcqx1W2oAXP6f4N2sttPagadMmrKRQFCxxDTUCr/iZroV3Y46j20WRwUOESD99STBmKPN3urt7Q3Rl37OD3ziCis2Tf/plSMRcSHS/TcQ
 CAxi4rEHmU9Xi5iqPyrKj084AqhyCAXsYhq7tPeJhcvMBlOrRvwEv0ozzcZXPxZd7GKyx/h33oDwWpHPtbGnNUl6TWdcSHPSsxAaJIMqKJorrHrjcaLwHanf
 9GT29qyjGwZyuQewglO4pg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

These just happened, what can I do to help fix?
I filtered them from /var/log/messages:


 kernel: [157210.666153] general protection fault, probably for
non-canonical address 0xffffff00ffffff: 0000 [#1] PREEMPT SMP NOPTI
 kernel: [157210.795363] CPU: 0 PID: 3797 Comm: gnome-shell Not tainted
5.6.2 #6
 kernel: [157210.871504] Hardware name: Gigabyte Technology Co., Ltd.
X570 AORUS PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: [157210.989312] RIP: 0010:rb_prev+0x14/0x50
 kernel: [157211.036287] Code: 89 c0 c3 45 31 c0 eb db 66 66 2e 0f 1f 84
00 00 00 00 00 0f 1f 00 48 8b 17 48 39 d7 74 35 48 8b 47 10 48 85 c0 74
1c 49 89 c0 <48> 8b 40 08 48 85 c0 75 f4 4c 89 c0 c3 48 3b 78 10 75 f6
48 8b 10
kernel: [157211.262425] RSP: 0018:ffffba648261f848 EFLAGS: 00010006
kernel: [157211.328150] RAX: 00ffffff00ffffff RBX: 00000000000b2e6a RCX:
0000000000000009
 kernel: [157211.414710] RDX: ffffa0b0981fc481 RSI: 0000000000000000
RDI: ffffa0afa4b15cc0
 kernel: [157211.501271] RBP: ffffa0b1cacb0008 R08: 00ffffff00ffffff
R09: ffffa0aec5a75440
 kernel: [157211.587829] R10: 0000000000000000 R11: ffffa0af3339d268
R12: ffffa0aec5a75440
 kernel: [157211.674389] R13: 0000000000000200 R14: 0000000000000297
R15: fffffffffffffe00
 kernel: [157211.760947] FS:  00007f4bdfd3bd00(0000)
GS:ffffa0b1df000000(0000) knlGS:0000000000000000
 kernel: [157211.858963] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: [157211.928856] CR2: 00007fae92bd1020 CR3: 00000003cc85c000
CR4: 00000000003406f0
 kernel: [157212.015415] Call Trace:
 kernel: [157212.045730]  alloc_iova+0xa0/0x140
 kernel: [157212.087502]  alloc_iova_fast+0x4b/0x26d
 kernel: [157212.134479]  ? __iommu_map+0xf1/0x1d0
 kernel: [157212.179373]  iommu_dma_alloc_iova.isra.0+0xcc/0xe0
 kernel: [157212.237810]  __iommu_dma_map+0x5e/0xc0
 kernel: [157212.283746]  ttm_populate_and_map_pages+0xbe/0x220 [ttm]
 kernel: [157212.348431]  ttm_tt_populate.part.0+0x19/0x60 [ttm]
 kernel: [157212.407906]  ttm_tt_bind+0x43/0x50 [ttm]
 kernel: [157212.455929]  ttm_bo_handle_move_mem+0x294/0x5a0 [ttm]
 kernel: [157212.517486]  ttm_bo_validate+0x12f/0x140 [ttm]
 kernel: [157212.571754]  ? drm_vma_offset_add+0x50/0x60
 kernel: [157212.622896]  ? vsnprintf+0xdd/0x5b0
 kernel: [157212.665704]  ttm_bo_init_reserved+0x2b2/0x320 [ttm]
 kernel: [157212.725205]  amdgpu_bo_do_create+0x1a9/0x4a0 [amdgpu]
 kernel: [157212.786768]  ? amdgpu_bo_subtract_pin_size+0x60/0x60 [amdgpu]
 kernel: [157212.856665]  amdgpu_bo_create+0x3b/0x230 [amdgpu]
 kernel: [157212.914051]  amdgpu_gem_object_create+0x89/0x110 [amdgpu]
 kernel: [157212.979777]  ? amdgpu_gem_object_close+0x190/0x190 [amdgpu]
 kernel: [157213.047601]  amdgpu_gem_create_ioctl+0x1c2/0x240 [amdgpu]
 kernel: [157213.113295]  ? atime_needs_update+0x6e/0xd0
 kernel: [157213.164463]  ? amdgpu_gem_object_close+0x190/0x190 [amdgpu]
 kernel: [157213.232251]  drm_ioctl_kernel+0xa5/0xf0
 kernel: [157213.279224]  drm_ioctl+0x1df/0x366
 kernel: [157213.321014]  ? amdgpu_gem_object_close+0x190/0x190 [amdgpu]
 kernel: [157213.388805]  ? __switch_to_asm+0x34/0x70
 kernel: [157213.436822]  ? __switch_to_asm+0x40/0x70
 kernel: [157213.484841]  ? __switch_to_asm+0x34/0x70
 kernel: [157213.532862]  ? __switch_to_asm+0x40/0x70
 kernel: [157213.580877]  ? __switch_to_asm+0x34/0x70
 kernel: [157213.628897]  ? __switch_to_asm+0x40/0x70
 kernel: [157213.676916]  ? __switch_to_asm+0x34/0x70
 kernel: [157213.724935]  ? __switch_to_asm+0x40/0x70
 kernel: [157213.772952]  ksys_ioctl+0x195/0x750
 kernel: [157213.815764]  ? __switch_to_asm+0x40/0x70
 kernel: [157213.863783]  ? _raw_spin_unlock_irq+0xe/0x20
 kernel: [157213.915967]  ? finish_task_switch+0x7b/0x220
 kernel: [157213.968152]  ? __switch_to_asm+0x40/0x70
 kernel: [157214.016175]  __x64_sys_ioctl+0x11/0x20
 kernel: [157214.062108]  do_syscall_64+0x63/0x430
 kernel: [157214.107007]  ? switch_fpu_return+0x24/0xc0
 kernel: [157214.157104]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 kernel: [157214.218663] RIP: 0033:0x7f4be39be35b
 kernel: [157214.262517] Code: 0f 1e fa 48 8b 05 2d 9b 0c 00 64 c7 00 26
00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 9a 0c 00 f7 d8 64
89 01 48
 kernel: [157214.488651] RSP: 002b:00007fff061da878 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
 kernel: [157214.580420] RAX: ffffffffffffffda RBX: 00007fff061da8d0
RCX: 00007f4be39be35b
 kernel: [157214.666977] RDX: 00007fff061da8d0 RSI: 00000000c0206440
RDI: 000000000000000d
 kernel: [157214.753536] RBP: 00000000c0206440 R08: 00005618f51e2c90
R09: 00005618f3d20010
 kernel: [157214.840095] R10: 00007f4be3a889e0 R11: 0000000000000246
R12: 00005618f51e2c90
 kernel: [157214.926654] R13: 000000000000000d R14: 000000000364d000
R15: 00005618f3e1b340
 kernel: [157215.013215] Modules linked in: isofs nls_utf8 btrfs
blake2b_generic zstd_decompress zstd_compress xxhash lzo_compress
zlib_deflate usb_storage fuse mq_deadline ip6t_REJECT nf_reject_ipv6
xt_state ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_MASQUERADE iptable_nat nf_nat ipt_REJECT
nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid msr iptable_filter
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel uvcvideo
snd_intel_dspcfg snd_usb_audio videobuf2_vmalloc snd_hda_codec
videobuf2_memops snd_hwdep videobuf2_v4l2 snd_usbmidi_lib snd_hda_core
snd_rawmidi videodev snd_seq snd_seq_device snd_pcm videobuf2_common
cdc_acm snd_timer bfq snd k10temp i2c_piix4 evdev acpi_cpufreq
binfmt_misc ip_tables x_tables hid_generic aesni_intel amdgpu gpu_sched
ttm sr_mod cdrom usbhid i2c_dev autofs4
 kernel: [157215.949744] ---[ end trace 4e83f25d585018ba ]---
 kernel: [157216.006094] RIP: 0010:rb_prev+0x14/0x50
 kernel: [157216.053068] Code: 89 c0 c3 45 31 c0 eb db 66 66 2e 0f 1f 84
00 00 00 00 00 0f 1f 00 48 8b 17 48 39 d7 74 35 48 8b 47 10 48 85 c0 74
1c 49 89 c0 <48> 8b 40 08 48 85 c0 75 f4 4c 89 c0 c3 48 3b 78 10 75 f6
48 8b 10
 kernel: [157216.279203] RSP: 0018:ffffba648261f848 EFLAGS: 00010006
 kernel: [157216.342846] RAX: 00ffffff00ffffff RBX: 00000000000b2e6a
RCX: 0000000000000009
 kernel: [157216.429407] RDX: ffffa0b0981fc481 RSI: 0000000000000000
RDI: ffffa0afa4b15cc0
 kernel: [157216.515965] RBP: ffffa0b1cacb0008 R08: 00ffffff00ffffff
R09: ffffa0aec5a75440
 kernel: [157216.602524] R10: 0000000000000000 R11: ffffa0af3339d268
R12: ffffa0aec5a75440
 kernel: [157216.689085] R13: 0000000000000200 R14: 0000000000000297
R15: fffffffffffffe00
 kernel: [157216.775642] FS:  00007f4bdfd3bd00(0000)
GS:ffffa0b1df000000(0000) knlGS:0000000000000000
 kernel: [157216.873660] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: [157216.943553] CR2: 00007fae92bd1020 CR3: 00000003cc85c000
CR4: 00000000003406f0
 kernel: [157217.030113] note: gnome-shell[3797] exited with preempt_count 1
 kernel: [157217.033452] ------------[ cut here ]------------
 kernel: general protection fault, probably for non-canonical address
0xffffff00ffffff: 0000 [#1] PREEMPT SMP NOPTI
 kernel: CPU: 0 PID: 3797 Comm: gnome-shell Not tainted 5.6.2 #6
 kernel: Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: RIP: 0010:rb_prev+0x14/0x50
 kernel: Code: 89 c0 c3 45 31 c0 eb db 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 48 8b 17 48 39 d7 74 35 48 8b 47 10 48 85 c0 74 1c 49 89 c0
<48> 8b 40 08 48 85 c0 75 f4 4c 89 c0 c3 48 3b 78 10 75 f6 48 8b 10
 kernel: RSP: 0018:ffffba648261f848 EFLAGS: 00010006
 kernel: RAX: 00ffffff00ffffff RBX: 00000000000b2e6a RCX: 0000000000000009
 kernel: RDX: ffffa0b0981fc481 RSI: 0000000000000000 RDI: ffffa0afa4b15cc0
 kernel: RBP: ffffa0b1cacb0008 R08: 00ffffff00ffffff R09: ffffa0aec5a75440
 kernel: R10: 0000000000000000 R11: ffffa0af3339d268 R12: ffffa0aec5a75440
 kernel: R13: 0000000000000200 R14: 0000000000000297 R15: fffffffffffffe00
 kernel: FS:  00007f4bdfd3bd00(0000) GS:ffffa0b1df000000(0000)
knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 00007fae92bd1020 CR3: 00000003cc85c000 CR4: 00000000003406f0
 kernel: Call Trace:
 kernel: alloc_iova+0xa0/0x140
 kernel: alloc_iova_fast+0x4b/0x26d
 kernel: ? __iommu_map+0xf1/0x1d0
 kernel: iommu_dma_alloc_iova.isra.0+0xcc/0xe0
 kernel: __iommu_dma_map+0x5e/0xc0
 kernel: ttm_populate_and_map_pages+0xbe/0x220 [ttm]
 kernel: ttm_tt_populate.part.0+0x19/0x60 [ttm]
 kernel: ttm_tt_bind+0x43/0x50 [ttm]
 kernel: ttm_bo_handle_move_mem+0x294/0x5a0 [ttm]
 kernel: ttm_bo_validate+0x12f/0x140 [ttm]
 kernel: ? drm_vma_offset_add+0x50/0x60
 kernel: ? vsnprintf+0xdd/0x5b0
 kernel: ttm_bo_init_reserved+0x2b2/0x320 [ttm]
 kernel: amdgpu_bo_do_create+0x1a9/0x4a0 [amdgpu]
 kernel: ? amdgpu_bo_subtract_pin_size+0x60/0x60 [amdgpu]
 kernel: amdgpu_bo_create+0x3b/0x230 [amdgpu]
 kernel: amdgpu_gem_object_create+0x89/0x110 [amdgpu]
 kernel: ? amdgpu_gem_object_close+0x190/0x190 [amdgpu]
 kernel: amdgpu_gem_create_ioctl+0x1c2/0x240 [amdgpu]
 kernel: ? atime_needs_update+0x6e/0xd0
 kernel: ? amdgpu_gem_object_close+0x190/0x190 [amdgpu]
 kernel: drm_ioctl_kernel+0xa5/0xf0
 kernel: drm_ioctl+0x1df/0x366
 kernel: ? amdgpu_gem_object_close+0x190/0x190 [amdgpu]
 kernel: ? __switch_to_asm+0x34/0x70
 kernel: ? __switch_to_asm+0x40/0x70
 kernel: ? __switch_to_asm+0x34/0x70
 kernel: ? __switch_to_asm+0x40/0x70
 kernel: ? __switch_to_asm+0x34/0x70
 kernel: ? __switch_to_asm+0x40/0x70
 kernel: ? __switch_to_asm+0x34/0x70
 kernel: ? __switch_to_asm+0x40/0x70
 kernel: ksys_ioctl+0x195/0x750
 kernel: ? __switch_to_asm+0x40/0x70
 kernel: ? _raw_spin_unlock_irq+0xe/0x20
 kernel: ? finish_task_switch+0x7b/0x220
 kernel: ? __switch_to_asm+0x40/0x70
 kernel: __x64_sys_ioctl+0x11/0x20
 kernel: do_syscall_64+0x63/0x430
 kernel: ? switch_fpu_return+0x24/0xc0
 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
 kernel: RIP: 0033:0x7f4be39be35b
 kernel: Code: 0f 1e fa 48 8b 05 2d 9b 0c 00 64 c7 00 26 00 00 00 48 c7
c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 9a 0c 00 f7 d8 64 89 01 48
 kernel: RSP: 002b:00007fff061da878 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
 kernel: RAX: ffffffffffffffda RBX: 00007fff061da8d0 RCX: 00007f4be39be35b
 kernel: RDX: 00007fff061da8d0 RSI: 00000000c0206440 RDI: 000000000000000d
 kernel: RBP: 00000000c0206440 R08: 00005618f51e2c90 R09: 00005618f3d20010
 kernel: R10: 00007f4be3a889e0 R11: 0000000000000246 R12: 00005618f51e2c90
 kernel: R13: 000000000000000d R14: 000000000364d000 R15: 00005618f3e1b340
 kernel: Modules linked in: isofs nls_utf8 btrfs blake2b_generic
zstd_decompress zstd_compress xxhash lzo_compress zlib_deflate
usb_storage fuse mq_deadline ip6t_REJECT nf_reject_ipv6 xt_state
ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_MASQUERADE iptable_nat nf_nat ipt_REJECT
nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid msr iptable_filter
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel uvcvideo
snd_intel_dspcfg snd_usb_audio videobuf2_vmalloc snd_hda_codec
videobuf2_memops snd_hwdep videobuf2_v4l2 snd_usbmidi_lib snd_hda_core
snd_rawmidi videodev snd_seq snd_seq_device snd_pcm videobuf2_common
cdc_acm snd_timer bfq snd k10temp i2c_piix4 evdev acpi_cpufreq
binfmt_misc ip_tables x_tables hid_generic aesni_intel amdgpu gpu_sched
ttm sr_mod cdrom usbhid i2c_dev autofs4
 kernel: ---[ end trace 4e83f25d585018ba ]---
 kernel: RIP: 0010:rb_prev+0x14/0x50
 kernel: Code: 89 c0 c3 45 31 c0 eb db 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 48 8b 17 48 39 d7 74 35 48 8b 47 10 48 85 c0 74 1c 49 89 c0
<48> 8b 40 08 48 85 c0 75 f4 4c 89 c0 c3 48 3b 78 10 75 f6 48 8b 10
 kernel: RSP: 0018:ffffba648261f848 EFLAGS: 00010006
 kernel: RAX: 00ffffff00ffffff RBX: 00000000000b2e6a RCX: 0000000000000009
 kernel: RDX: ffffa0b0981fc481 RSI: 0000000000000000 RDI: ffffa0afa4b15cc0
 kernel: RBP: ffffa0b1cacb0008 R08: 00ffffff00ffffff R09: ffffa0aec5a75440
 kernel: R10: 0000000000000000 R11: ffffa0af3339d268 R12: ffffa0aec5a75440
 kernel: R13: 000000000000000d R14: 000000000364d000 R15: 00005618f3e1b340
 kernel: Modules linked in: isofs nls_utf8 btrfs blake2b_generic
zstd_decompress zstd_compress xxhash lzo_compress zlib_deflate
usb_storage fuse mq_deadline ip6t_REJECT nf_reject_ipv6 xt_state
ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_MASQUERADE iptable_nat nf_nat ipt_REJECT
nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid msr iptable_filter
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel uvcvideo
snd_intel_dspcfg snd_usb_audio videobuf2_vmalloc snd_hda_codec
videobuf2_memops snd_hwdep videobuf2_v4l2 snd_usbmidi_lib snd_hda_core
snd_rawmidi videodev snd_seq snd_seq_device snd_pcm videobuf2_common
cdc_acm snd_timer bfq snd k10temp i2c_piix4 evdev acpi_cpufreq
binfmt_misc ip_tables x_tables hid_generic aesni_intel amdgpu gpu_sched
ttm sr_mod cdrom usbhid i2c_dev autofs4
 kernel: ---[ end trace 4e83f25d585018ba ]---
 kernel: RIP: 0010:rb_prev+0x14/0x50
 kernel: Code: 89 c0 c3 45 31 c0 eb db 66 66 2e 0f 1f 84 00 00 00 00 00
0f 1f 00 48 8b 17 48 39 d7 74 35 48 8b 47 10 48 85 c0 74 1c 49 89 c0
<48> 8b 40 08 48 85 c0 75 f4 4c 89 c0 c3 48 3b 78 10 75 f6 48 8b 10
 kernel: RSP: 0018:ffffba648261f848 EFLAGS: 00010006
 kernel: RAX: 00ffffff00ffffff RBX: 00000000000b2e6a RCX: 0000000000000009
 kernel: RDX: ffffa0b0981fc481 RSI: 0000000000000000 RDI: ffffa0afa4b15cc0
 kernel: RBP: ffffa0b1cacb0008 R08: 00ffffff00ffffff R09: ffffa0aec5a75440
 kernel: R10: 0000000000000000 R11: ffffa0af3339d268 R12: ffffa0aec5a75440
 kernel: R13: 0000000000000200 R14: 0000000000000297 R15: fffffffffffffe00
 kernel: FS:  00007f4bdfd3bd00(0000) GS:ffffa0b1df000000(0000)
knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 00007fae92bd1020 CR3: 00000003cc85c000 CR4: 00000000003406f0
 kernel: note: gnome-shell[3797] exited with preempt_count 1
 kernel: ------------[ cut here ]------------
 kernel: [157217.158553] NETDEV WATCHDOG: eth0 (igb): transmit queue 0
timed out
 kernel: [157217.158561] WARNING: CPU: 5 PID: 243 at
net/sched/sch_generic.c:442 dev_watchdog+0x212/0x220
 kernel: [157217.336871] Modules linked in: isofs nls_utf8 btrfs
blake2b_generic zstd_decompress zstd_compress xxhash lzo_compress
zlib_deflate usb_storage fuse mq_deadline ip6t_REJECT nf_reject_ipv6
xt_state ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_MASQUERADE iptable_nat nf_nat ipt_REJECT
nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid msr iptable_filter
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel uvcvideo
snd_intel_dspcfg snd_usb_audio videobuf2_vmalloc snd_hda_codec
videobuf2_memops snd_hwdep videobuf2_v4l2 snd_usbmidi_lib snd_hda_core
snd_rawmidi videodev snd_seq snd_seq_device snd_pcm videobuf2_common
cdc_acm snd_timer bfq snd k10temp i2c_piix4 evdev acpi_cpufreq
binfmt_misc ip_tables x_tables hid_generic aesni_intel amdgpu gpu_sched
ttm sr_mod cdrom usbhid i2c_dev autofs4
 kernel: [157218.273399] CPU: 5 PID: 243 Comm: kswapd0 Tainted: G      D
          5.6.2 #6
 kernel: [157218.360996] Hardware name: Gigabyte Technology Co., Ltd.
X570 AORUS PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: [157218.478808] RIP: 0010:dev_watchdog+0x212/0x220
 kernel: [157218.533079] Code: 63 54 24 28 eb 89 4c 89 f7 c6 05 71 4a a7
00 01 e8 a3 76 fd ff 44 89 e9 4c 89 f6 48 c7 c7 30 60 e1 af 48 89 c2 e8
0c 8a a8 ff <0f> 0b eb ba 66 2e 0f 1f 84 00 00 00 00 00 48 c7 47 08 00
00 00 00
 kernel: [157218.759209] RSP: 0018:ffffba6480244e88 EFLAGS: 00010282
 kernel: [157218.822851] RAX: 0000000000000000 RBX: ffffa0b1cae828c0
RCX: 0000000000000000
 kernel: [157218.909413] RDX: 0000000000000104 RSI: 0000000000000003
RDI: 00000000ffffffff
 kernel: [157218.995968] RBP: ffffa0b1cefcc39c R08: 00008efcf8e35fa9
R09: ffffffffb0461bb4
 kernel: [157219.082528] R10: 00000000000007a0 R11: 0000000000011300
R12: ffffa0b1cefcc440
 kernel: [157219.169085] R13: 0000000000000000 R14: ffffa0b1cefcc000
R15: ffffa0b1cae82940
 kernel: [157219.255645] FS:  0000000000000000(0000)
GS:ffffa0b1df140000(0000) knlGS:0000000000000000
 kernel: [157219.353665] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: [157219.423558] CR2: 00007f86ee098000 CR3: 0000000103fa2000
CR4: 00000000003406e0
 kernel: [157219.510116] Call Trace:
 kernel: [157219.540428]  <IRQ>
 kernel: [157219.565531]  ? qdisc_put_unlocked+0x30/0x30
 kernel: [157219.616676]  ? qdisc_put_unlocked+0x30/0x30
 kernel: [157219.667818]  call_timer_fn.isra.0+0x11/0x70
 kernel: [157219.718964]  run_timer_softirq+0x1ae/0x1d0
 kernel: [157219.769069]  ? tick_sched_timer+0x6d/0x160
 kernel: [157219.819166]  ? timerqueue_add+0x96/0xb0
 kernel: [157219.866145]  ? sched_clock_cpu+0x10/0xd0
 kernel: [157219.914163]  __do_softirq+0xfc/0x24c
 kernel: [157219.958017]  irq_exit+0x73/0x80
 kernel: [157219.996658]  smp_apic_timer_interrupt+0x7f/0xd0
 kernel: [157220.051969]  apic_timer_interrupt+0xf/0x20
 kernel: [157220.102072]  </IRQ>
 kernel: [157220.128216] RIP: 0010:smp_call_function_many_cond+0x25f/0x2a0
 kernel: [157220.198111] Code: 00 3b 05 38 43 f9 00 89 c7 0f 83 36 fe ff
ff 48 63 c7 49 8b 4d 00 48 03 0c c5 20 f5 e1 af 8b 41 18 a8 01 74 0a f3
90 8b 51 18 <83> e2 01 75 f6 eb c8 48 c7 c2 70 41 08 b0 4c 89 fe 44 89
f7 e8 38
 kernel: [157220.424251] RSP: 0018:ffffba64806f7a28 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
 kernel: [157220.516014] RAX: 0000000000000003 RBX: ffffa0b1df161210
RCX: ffffda647fc04d20
 kernel: [157220.602569] RDX: 0000000000000003 RSI: 0000000000000000
RDI: 0000000000000000
 kernel: [157220.689130] RBP: 0000000000000000 R08: 0000000000000000
R09: 0000000000000000
 kernel: [157220.775688] R10: 0000000000000000 R11: 0000000000000098
R12: 0000000000000000
 kernel: [157220.862250] R13: ffffa0b1df161200 R14: 0000000000000008
R15: ffffa0b1df161208
 kernel: [157220.948808]  ? smp_call_function_many_cond+0x236/0x2a0
 kernel: [157221.011411]  ? do_kernel_range_flush+0x100/0x100
 kernel: [157221.067763]  ? do_kernel_range_flush+0x100/0x100
 kernel: [157221.124112]  smp_call_function+0x32/0x60
 kernel: [157221.172134]  ? do_kernel_range_flush+0x100/0x100
 kernel: [157221.228483]  on_each_cpu+0x25/0x60
 kernel: [157221.270253]  __purge_vmap_area_lazy+0x68/0x6c0
 kernel: [157221.324523]  _vm_unmap_aliases.part.0+0xe6/0x120
 kernel: [157221.380877]  change_page_attr_set_clr+0xa2/0x1a0
 kernel: [157221.437226]  set_pages_array_wb+0x23/0x80
 kernel: [157221.486289]  ttm_pages_put+0x74/0x80 [ttm]
 kernel: [157221.536392]  ttm_page_pool_free+0x132/0x190 [ttm]
 kernel: [157221.593784]  ttm_pool_shrink_scan+0xc9/0x110 [ttm]
 kernel: [157221.652223]  shrink_slab.constprop.0+0x1af/0x280
 kernel: [157221.708569]  shrink_node+0x16f/0x420
 kernel: [157221.752420]  balance_pgdat+0x21e/0x460
 kernel: [157221.798357]  kswapd+0x165/0x2f0
 kernel: [157221.837001]  ? wait_woken+0x70/0x70
 kernel: [157221.879814]  ? balance_pgdat+0x460/0x460
 kernel: [157221.927834]  kthread+0x10d/0x130
 kernel: [157221.967518]  ? kthread_create_worker_on_cpu+0x60/0x60
 kernel: [157222.029080]  ret_from_fork+0x22/0x40
 kernel: [157222.072932] ---[ end trace 4e83f25d585018bb ]---
 kernel: NETDEV WATCHDOG: eth0 (igb): transmit queue 0 timed out
 kernel: WARNING: CPU: 5 PID: 243 at net/sched/sch_generic.c:442
dev_watchdog+0x212/0x220
 kernel: Modules linked in: isofs nls_utf8 btrfs blake2b_generic
zstd_decompress zstd_compress xxhash lzo_compress zlib_deflate
usb_storage fuse mq_deadline ip6t_REJECT nf_reject_ipv6 xt_state
ip6table_filter ip6_tables nf_conntrack_netbios_ns
nf_conntrack_broadcast xt_MASQUERADE iptable_nat nf_nat ipt_REJECT
nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp xt_conntrack nf_conntrack
nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid msr iptable_filter
snd_hda_codec_realtek snd_hda_codec_generic snd_hda_intel uvcvideo
snd_intel_dspcfg snd_usb_audio videobuf2_vmalloc snd_hda_codec
videobuf2_memops snd_hwdep videobuf2_v4l2 snd_usbmidi_lib snd_hda_core
snd_rawmidi videodev snd_seq snd_seq_device snd_pcm videobuf2_common
cdc_acm snd_timer bfq snd k10temp i2c_piix4 evdev acpi_cpufreq
binfmt_misc ip_tables x_tables hid_generic aesni_intel amdgpu gpu_sched
ttm sr_mod cdrom usbhid i2c_dev autofs4
 kernel: CPU: 5 PID: 243 Comm: kswapd0 Tainted: G      D           5.6.2 #6
 kernel: Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: RIP: 0010:dev_watchdog+0x212/0x220
 kernel: Code: 63 54 24 28 eb 89 4c 89 f7 c6 05 71 4a a7 00 01 e8 a3 76
fd ff 44 89 e9 4c 89 f6 48 c7 c7 30 60 e1 af 48 89 c2 e8 0c 8a a8 ff
<0f> 0b eb ba 66 2e 0f 1f 84 00 00 00 00 00 48 c7 47 08 00 00 00 00
 kernel: RSP: 0018:ffffba6480244e88 EFLAGS: 00010282
 kernel: RAX: 0000000000000000 RBX: ffffa0b1cae828c0 RCX: 0000000000000000
 kernel: RDX: 0000000000000104 RSI: 0000000000000003 RDI: 00000000ffffffff
 kernel: RBP: ffffa0b1cefcc39c R08: 00008efcf8e35fa9 R09: ffffffffb0461bb4
 kernel: R10: 00000000000007a0 R11: 0000000000011300 R12: ffffa0b1cefcc440
 kernel: R13: 0000000000000000 R14: ffffa0b1cefcc000 R15: ffffa0b1cae82940
 kernel: FS:  0000000000000000(0000) GS:ffffa0b1df140000(0000)
knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 00007f86ee098000 CR3: 0000000103fa2000 CR4: 00000000003406e0
 kernel: Call Trace:
 kernel: <IRQ>
 kernel: ? qdisc_put_unlocked+0x30/0x30
 kernel: ? qdisc_put_unlocked+0x30/0x30
 kernel: call_timer_fn.isra.0+0x11/0x70
 kernel: run_timer_softirq+0x1ae/0x1d0
 kernel: ? tick_sched_timer+0x6d/0x160
 kernel: ? timerqueue_add+0x96/0xb0
 kernel: ? sched_clock_cpu+0x10/0xd0
 kernel: __do_softirq+0xfc/0x24c
 kernel: irq_exit+0x73/0x80
 kernel: smp_apic_timer_interrupt+0x7f/0xd0
 kernel: apic_timer_interrupt+0xf/0x20
 kernel: </IRQ>
 kernel: RIP: 0010:smp_call_function_many_cond+0x25f/0x2a0
 kernel: Code: 00 3b 05 38 43 f9 00 89 c7 0f 83 36 fe ff ff 48 63 c7 49
8b 4d 00 48 03 0c c5 20 f5 e1 af 8b 41 18 a8 01 74 0a f3 90 8b 51 18
<83> e2 01 75 f6 eb c8 48 c7 c2 70 41 08 b0 4c 89 fe 44 89 f7 e8 38
 kernel: RSP: 0018:ffffba64806f7a28 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
 kernel: RAX: 0000000000000003 RBX: ffffa0b1df161210 RCX: ffffda647fc04d20
 kernel: RDX: 0000000000000003 RSI: 0000000000000000 RDI: 0000000000000000
 kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
 kernel: R10: 0000000000000000 R11: 0000000000000098 R12: 0000000000000000
 kernel: R13: ffffa0b1df161200 R14: 0000000000000008 R15: ffffa0b1df161208
 kernel: ? smp_call_function_many_cond+0x236/0x2a0
 kernel: ? do_kernel_range_flush+0x100/0x100
 kernel: ? do_kernel_range_flush+0x100/0x100
 kernel: smp_call_function+0x32/0x60
 kernel: ? do_kernel_range_flush+0x100/0x100
 kernel: on_each_cpu+0x25/0x60
 kernel: __purge_vmap_area_lazy+0x68/0x6c0
 kernel: _vm_unmap_aliases.part.0+0xe6/0x120
 kernel: change_page_attr_set_clr+0xa2/0x1a0
 kernel: set_pages_array_wb+0x23/0x80
 kernel: ttm_pages_put+0x74/0x80 [ttm]
 kernel: ttm_page_pool_free+0x132/0x190 [ttm]
 kernel: ttm_pool_shrink_scan+0xc9/0x110 [ttm]
 kernel: shrink_slab.constprop.0+0x1af/0x280
 kernel: shrink_node+0x16f/0x420
 kernel: balance_pgdat+0x21e/0x460
 kernel: kswapd+0x165/0x2f0
 kernel: ? wait_woken+0x70/0x70
 kernel: ? balance_pgdat+0x460/0x460
 kernel: kthread+0x10d/0x130
 kernel: ? kthread_create_worker_on_cpu+0x60/0x60
 kernel: ret_from_fork+0x22/0x40
 kernel: ---[ end trace 4e83f25d585018bb ]---

 kernel: [157282.128180] rcu: INFO: rcu_preempt self-detected stall on CPU
 kernel: [157282.198023] rcu:   5-....: (1 GPs behind)
idle=f6a/1/0x4000000000000002 softirq=29821932/29821933 fqs=6841
 kernel: [157282.314783]        (t=15018 jiffies g=39524417 q=9403)
 kernel: [157282.371140] Sending NMI from CPU 5 to CPUs 2:
 kernel: [157282.425357] NMI backtrace for cpu 2
 kernel: [157282.425357] CPU: 2 PID: 406042 Comm: Compositor Tainted: G
    D W         5.6.2 #6
 kernel: [157282.425358] Hardware name: Gigabyte Technology Co., Ltd.
X570 AORUS PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: [157282.425358] RIP: 0010:queued_spin_lock_slowpath+0x46/0x1e0
 kernel: [157282.425358] Code: 47 f0 0f ba 2b 08 0f 92 c0 0f b6 c0 c1 e0
08 89 c2 8b 03 30 e4 09 d0 a9 00 01 ff ff 75 21 85 c0 74 0e 8b 03 84 c0
74 08 f3 90 <8b> 03 84 c0 75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41
5d c3 f6
 kernel: [157282.425359] RSP: 0018:ffffba6482fe7aa8 EFLAGS: 00000002
 kernel: [157282.425359] RAX: 0000000000100101 RBX: ffffa0b1cacb0008
RCX: 0000000000000001
 kernel: [157282.425360] RDX: 0000000000000000 RSI: 0000000000000000
RDI: ffffa0b1cacb0008
 kernel: [157282.425360] RBP: ffffa0b1cacb0008 R08: 00000000ffffffff
R09: ffffa0b18c4f2000
 kernel: [157282.425360] R10: 0000000000000002 R11: 00000000000000f0
R12: 0000000000000086
 kernel: [157282.425361] R13: ffffa0b1cacb0008 R14: 0000000000000082
R15: ffffa0af36a16000
 kernel: [157282.425361] FS:  00007f0406c89700(0000)
GS:ffffa0b1df080000(0000) knlGS:0000000000000000
 kernel: [157282.425361] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: [157282.425362] CR2: 00002a197ad55000 CR3: 0000000173dda000
CR4: 00000000003406e0
 kernel: [157282.425362] Call Trace:
 kernel: [157282.425362]  _raw_spin_lock_irqsave+0x33/0x40
 kernel: [157282.425362]  iova_magazine_free_pfns+0x19/0x70
 kernel: [157282.425362]  free_iova_fast+0x17d/0x240
 kernel: [157282.425363]  fq_ring_free+0x63/0xa0
 kernel: [157282.425363]  queue_iova+0x114/0x130
 kernel: [157282.425363]  __iommu_dma_unmap+0x92/0xf0
 kernel: [157282.425363]  ttm_unmap_and_unpopulate_pages+0xa4/0x130 [ttm]
 kernel: [157282.425364]  ttm_tt_destroy.part.0+0x44/0x50 [ttm]
 kernel: [157282.425364]  ttm_bo_cleanup_memtype_use+0x2d/0x80 [ttm]
 kernel: [157282.425364]  ttm_bo_put+0x2ae/0x330 [ttm]
 kernel: [157282.425364]  amdgpu_bo_unref+0x15/0x20 [amdgpu]
 kernel: [157282.425364]  amdgpu_gem_object_free+0x26/0x40 [amdgpu]
 kernel: [157282.425365]  drm_gem_object_release_handle+0x6b/0x90
 kernel: [157282.425365]  drm_gem_handle_delete+0x53/0x90
 kernel: [157282.425365]  ? drm_gem_handle_create+0x40/0x40
 kernel: [157282.425365]  drm_ioctl_kernel+0xa5/0xf0
 kernel: [157282.425366]  drm_ioctl+0x1df/0x366
 kernel: [157282.425366]  ? drm_gem_handle_create+0x40/0x40
 kernel: [157282.425366]  ksys_ioctl+0x195/0x750
 kernel: [157282.425366]  ? _copy_to_user+0x28/0x30
 kernel: [157282.425366]  ? put_timespec64+0x37/0x60
 kernel: [157282.425367]  __x64_sys_ioctl+0x11/0x20
 kernel: [157282.425367]  do_syscall_64+0x63/0x430
 kernel: [157282.425367]  ? switch_fpu_return+0x24/0xc0
 kernel: [157282.425367]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
 kernel: [157282.425367] RIP: 0033:0x7f0414e1a35b
 kernel: [157282.425368] Code: 0f 1e fa 48 8b 05 2d 9b 0c 00 64 c7 00 26
00 00 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00
00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 9a 0c 00 f7 d8 64
89 01 48
 kernel: [157282.425368] RSP: 002b:00007f0406c86be8 EFLAGS: 00000246
ORIG_RAX: 0000000000000010
 kernel: [157282.425369] RAX: ffffffffffffffda RBX: 00007f0406c86c20
RCX: 00007f0414e1a35b
 kernel: [157282.425369] RDX: 00007f0406c86c20 RSI: 0000000040086409
RDI: 0000000000000021
 kernel: [157282.425369] RBP: 0000000040086409 R08: 0000000000000000
R09: 00000000000de4f0
 kernel: [157282.425370] R10: 0000000000000027 R11: 0000000000000246
R12: 00007f03f91f8848
 kernel: [157282.425370] R13: 0000000000000021 R14: 00007f03f91f979c
R15: 00007f0406c86c68
 kernel: [157282.425371] NMI backtrace for cpu 5
 kernel: [157285.885473] CPU: 5 PID: 243 Comm: kswapd0 Tainted: G      D
W         5.6.2 #6
 kernel: [157285.973074] Hardware name: Gigabyte Technology Co., Ltd.
X570 AORUS PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: [157286.090883] Call Trace:
 kernel: [157286.121195]  <IRQ>
 kernel: [157286.146298]  dump_stack+0x50/0x70
 kernel: [157286.187026]  ? lapic_can_unplug_cpu.cold+0x45/0x45
 kernel: [157286.245460]  nmi_cpu_backtrace.cold+0x13/0x51
 kernel: [157286.298688]  ? lapic_can_unplug_cpu.cold+0x45/0x45
 kernel: [157286.357122]  nmi_trigger_cpumask_backtrace+0xc2/0xd0
 kernel: [157286.417642]  rcu_dump_cpu_stacks+0x7b/0xa9
 kernel: [157286.467744]  rcu_sched_clock_irq.cold+0x173/0x4ff
 kernel: [157286.525135]  ? hrtimer_run_queues+0x12/0x120
 kernel: [157286.577321]  update_process_times+0x1f/0x50
 kernel: [157286.628467]  tick_sched_timer+0x55/0x160
 kernel: [157286.676484]  ? tick_switch_to_oneshot.cold+0x74/0x74
 kernel: [157286.737003]  __hrtimer_run_queues+0xe5/0x180
 kernel: [157286.789189]  hrtimer_interrupt+0x113/0x240
 kernel: [157286.839291]  smp_apic_timer_interrupt+0x7a/0xd0
 kernel: [157286.894601]  apic_timer_interrupt+0xf/0x20
 kernel: [157286.944704]  </IRQ>
 kernel: [157286.970846] RIP: 0010:smp_call_function_many_cond+0x25a/0x2a0
 kernel: [157287.040740] Code: fe e8 ba 25 5f 00 3b 05 38 43 f9 00 89 c7
0f 83 36 fe ff ff 48 63 c7 49 8b 4d 00 48 03 0c c5 20 f5 e1 af 8b 41 18
a8 01 74 0a <f3> 90 8b 51 18 83 e2 01 75 f6 eb c8 48 c7 c2 70 41 08 b0
4c 89 fe
 kernel: [157287.266878] RSP: 0018:ffffba64806f7a28 EFLAGS: 00000202
ORIG_RAX: ffffffffffffff13
 kernel: [157287.358643] RAX: 0000000000000003 RBX: ffffa0b1df161210
RCX: ffffda647fc84d20
 kernel: [157287.445201] RDX: 0000000000000001 RSI: 0000000000000000
RDI: 0000000000000002
 kernel: [157287.531762] RBP: 0000000000000000 R08: 0000000000000000
R09: 0000000000000002
 kernel: [157287.618322] R10: 0000000000000000 R11: 0000000000000098
R12: 0000000000000000
 kernel: [157287.704880] R13: ffffa0b1df161200 R14: 0000000000000008
R15: ffffa0b1df161208
 kernel: [157287.791438]  ? smp_call_function_many_cond+0x236/0x2a0
 kernel: [157287.854041]  ? do_kernel_range_flush+0x100/0x100
 kernel: [157287.910395]  ? do_kernel_range_flush+0x100/0x100
 kernel: [157287.966745]  smp_call_function+0x32/0x60
 kernel: [157288.014762]  ? do_kernel_range_flush+0x100/0x100
 kernel: [157288.071116]  on_each_cpu+0x25/0x60
 kernel: [157288.112883]  __purge_vmap_area_lazy+0x68/0x6c0
 kernel: [157288.167155]  _vm_unmap_aliases.part.0+0xe6/0x120
 kernel: [157288.223505]  change_page_attr_set_clr+0xa2/0x1a0
 kernel: [157288.279858]  set_pages_array_wb+0x23/0x80
 kernel: rcu: INFO: rcu_preempt self-detected stall on CPU
 kernel: [157288.328920]  ttm_pages_put+0x74/0x80 [ttm]
 kernel: [157288.379023]  ttm_page_pool_free+0x132/0x190 [ttm]
 kernel: [157288.436414]  ttm_pool_shrink_scan+0xc9/0x110 [ttm]
 kernel: [157288.494849]  shrink_slab.constprop.0+0x1af/0x280
 kernel: [157288.551201]  shrink_node+0x16f/0x420
 kernel: [157288.595054]  balance_pgdat+0x21e/0x460
 kernel: [157288.640989]  kswapd+0x165/0x2f0
 kernel: [157288.679632]  ? wait_woken+0x70/0x70
 kernel: [157288.722442]  ? balance_pgdat+0x460/0x460
 kernel: [157288.770465]  kthread+0x10d/0x130
 kernel: [157288.810149]  ? kthread_create_worker_on_cpu+0x60/0x60
 kernel: [157288.871707]  ret_from_fork+0x22/0x40
 kernel: rcu: #0115-....: (1 GPs behind) idle=f6a/1/0x4000000000000002
softirq=29821932/29821933 fqs=6841
 kernel: #011(t=15018 jiffies g=39524417 q=9403)
 kernel: Sending NMI from CPU 5 to CPUs 2:
 kernel: NMI backtrace for cpu 2
 kernel: CPU: 2 PID: 406042 Comm: Compositor Tainted: G      D W
5.6.2 #6
 kernel: Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: RIP: 0010:queued_spin_lock_slowpath+0x46/0x1e0
 kernel: Code: 47 f0 0f ba 2b 08 0f 92 c0 0f b6 c0 c1 e0 08 89 c2 8b 03
30 e4 09 d0 a9 00 01 ff ff 75 21 85 c0 74 0e 8b 03 84 c0 74 08 f3 90
<8b> 03 84 c0 75 f8 b8 01 00 00 00 66 89 03 5b 5d 41 5c 41 5d c3 f6
 kernel: RSP: 0018:ffffba6482fe7aa8 EFLAGS: 00000002
 kernel: RAX: 0000000000100101 RBX: ffffa0b1cacb0008 RCX: 0000000000000001
 kernel: RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffa0b1cacb0008
 kernel: RBP: ffffa0b1cacb0008 R08: 00000000ffffffff R09: ffffa0b18c4f2000
 kernel: R10: 0000000000000002 R11: 00000000000000f0 R12: 0000000000000086
 kernel: R13: ffffa0b1cacb0008 R14: 0000000000000082 R15: ffffa0af36a16000
 kernel: FS:  00007f0406c89700(0000) GS:ffffa0b1df080000(0000)
knlGS:0000000000000000
 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 kernel: CR2: 00002a197ad55000 CR3: 0000000173dda000 CR4: 00000000003406e0
 kernel: Call Trace:
 kernel: _raw_spin_lock_irqsave+0x33/0x40
 kernel: iova_magazine_free_pfns+0x19/0x70
 kernel: free_iova_fast+0x17d/0x240
 kernel: fq_ring_free+0x63/0xa0
 kernel: queue_iova+0x114/0x130
 kernel: __iommu_dma_unmap+0x92/0xf0
 kernel: ttm_unmap_and_unpopulate_pages+0xa4/0x130 [ttm]
 kernel: ttm_tt_destroy.part.0+0x44/0x50 [ttm]
 kernel: ttm_bo_cleanup_memtype_use+0x2d/0x80 [ttm]
 kernel: ttm_bo_put+0x2ae/0x330 [ttm]
 kernel: amdgpu_bo_unref+0x15/0x20 [amdgpu]
 kernel: amdgpu_gem_object_free+0x26/0x40 [amdgpu]
 kernel: drm_gem_object_release_handle+0x6b/0x90
 kernel: drm_gem_handle_delete+0x53/0x90
 kernel: ? drm_gem_handle_create+0x40/0x40
 kernel: drm_ioctl_kernel+0xa5/0xf0
 kernel: drm_ioctl+0x1df/0x366
 kernel: ? drm_gem_handle_create+0x40/0x40
 kernel: ksys_ioctl+0x195/0x750
 kernel: ? _copy_to_user+0x28/0x30
 kernel: ? put_timespec64+0x37/0x60
 kernel: __x64_sys_ioctl+0x11/0x20
 kernel: do_syscall_64+0x63/0x430
 kernel: ? switch_fpu_return+0x24/0xc0
 kernel: entry_SYSCALL_64_after_hwframe+0x44/0xa9
 kernel: RIP: 0033:0x7f0414e1a35b
 kernel: Code: 0f 1e fa 48 8b 05 2d 9b 0c 00 64 c7 00 26 00 00 00 48 c7
c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05
<48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d fd 9a 0c 00 f7 d8 64 89 01 48
 kernel: RSP: 002b:00007f0406c86be8 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
 kernel: RAX: ffffffffffffffda RBX: 00007f0406c86c20 RCX: 00007f0414e1a35b
 kernel: RDX: 00007f0406c86c20 RSI: 0000000040086409 RDI: 0000000000000021
 kernel: RBP: 0000000040086409 R08: 0000000000000000 R09: 00000000000de4f0
 kernel: R10: 0000000000000027 R11: 0000000000000246 R12: 00007f03f91f8848
 kernel: R13: 0000000000000021 R14: 00007f03f91f979c R15: 00007f0406c86c68
 kernel: NMI backtrace for cpu 5
 kernel: CPU: 5 PID: 243 Comm: kswapd0 Tainted: G      D W         5.6.2 #6
 kernel: Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
 kernel: Call Trace:
 kernel: <IRQ>
 kernel: dump_stack+0x50/0x70
 kernel: ? lapic_can_unplug_cpu.cold+0x45/0x45
 kernel: nmi_cpu_backtrace.cold+0x13/0x51
 kernel: ? lapic_can_unplug_cpu.cold+0x45/0x45
 kernel: nmi_trigger_cpumask_backtrace+0xc2/0xd0
 kernel: rcu_dump_cpu_stacks+0x7b/0xa9
 kernel: rcu_sched_clock_irq.cold+0x173/0x4ff
 kernel: ? hrtimer_run_queues+0x12/0x120
 kernel: update_process_times+0x1f/0x50
 kernel: tick_sched_timer+0x55/0x160
 kernel: ? tick_switch_to_oneshot.cold+0x74/0x74
 kernel: __hrtimer_run_queues+0xe5/0x180
 kernel: hrtimer_interrupt+0x113/0x240
 kernel: smp_apic_timer_interrupt+0x7a/0xd0
 kernel: apic_timer_interrupt+0xf/0x20
 kernel: </IRQ>
 kernel: RIP: 0010:smp_call_function_many_cond+0x25a/0x2a0
 kernel: Code: fe e8 ba 25 5f 00 3b 05 38 43 f9 00 89 c7 0f 83 36 fe ff
ff 48 63 c7 49 8b 4d 00 48 03 0c c5 20 f5 e1 af 8b 41 18 a8 01 74 0a
<f3> 90 8b 51 18 83 e2 01 75 f6 eb c8 48 c7 c2 70 41 08 b0 4c 89 fe
 kernel: RSP: 0018:ffffba64806f7a28 EFLAGS: 00000202 ORIG_RAX:
ffffffffffffff13
 kernel: RAX: 0000000000000003 RBX: ffffa0b1df161210 RCX: ffffda647fc84d20
 kernel: RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000002
 kernel: RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000002
 kernel: R10: 0000000000000000 R11: 0000000000000098 R12: 0000000000000000
 kernel: R13: ffffa0b1df161200 R14: 0000000000000008 R15: ffffa0b1df161208
 kernel: ? smp_call_function_many_cond+0x236/0x2a0
 kernel: ? do_kernel_range_flush+0x100/0x100
 kernel: ? do_kernel_range_flush+0x100/0x100
 kernel: smp_call_function+0x32/0x60
 kernel: ? do_kernel_range_flush+0x100/0x100
 kernel: on_each_cpu+0x25/0x60
 kernel: __purge_vmap_area_lazy+0x68/0x6c0
 kernel: _vm_unmap_aliases.part.0+0xe6/0x120
 kernel: change_page_attr_set_clr+0xa2/0x1a0
 kernel: set_pages_array_wb+0x23/0x80
 kernel: ttm_pages_put+0x74/0x80 [ttm]
 kernel: ttm_page_pool_free+0x132/0x190 [ttm]
 kernel: ttm_pool_shrink_scan+0xc9/0x110 [ttm]
 kernel: shrink_slab.constprop.0+0x1af/0x280
 kernel: shrink_node+0x16f/0x420
 kernel: balance_pgdat+0x21e/0x460
 kernel: kswapd+0x165/0x2f0
 kernel: ? wait_woken+0x70/0x70
 kernel: ? balance_pgdat+0x460/0x460
 kernel: kthread+0x10d/0x130
 kernel: ? kthread_create_worker_on_cpu+0x60/0x60
 kernel: ret_from_fork+0x22/0x40
 systemd[1]: systemd-udevd.service: Watchdog timeout (limit 3min)!
 systemd[1]: systemd-udevd.service: Killing process 1473 (systemd-udevd)
with signal SIGABRT.
 avahi-daemon[2045]: Withdrawing address record for
2011:681:a812:0:b62e:99ff:fe92:5214 on eth0.




	
Udo
