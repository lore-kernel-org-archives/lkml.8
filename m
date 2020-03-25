Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F688C18E5B
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C202206F8
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 08:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="lQDQi0QD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYIp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 04:45:59 -0400
Received: from lb3-smtp-cloud9.xs4all.net ([194.109.24.30]:48969 "EHLO
        lb3-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726906AbgCYIp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 04:45:58 -0400
Received: from surfplank2.hierzo ([IPv6:2001:981:a812:0:b62e:99ff:fe92:5264])
        by smtp-cloud9.xs4all.net with ESMTPA
        id H1fejanokfHuvH1ffjwMR1; Wed, 25 Mar 2020 09:45:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1585125955; bh=86wzzks4jqlP5+0t8kensoltEG205KMzBv/NOMbBvlc=;
        h=Subject:From:To:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=lQDQi0QDWUBDiheZaXAgzGv0cEr+UHx3H/7x82C+867hNahuOxNWSIjLnJ2NSuREq
         f+3VyJOMjdx68PFDaUuXrVElVHpQnjSWsBZTSyXffHZEJxHsluy3HpjXU1f1xZGNCu
         aeI2ZHOVMl2HFx0h4aXx4D7APIeWQbyhKMhmm3g/TYlEuFg6SzccLd7SDM8VCNt3ha
         flX8jDYVE6qv6x0QdUcxWqBeyv7gT57c8PVf3cJbXJnG+VYNrfb1GdKQVQp6qzVVIG
         TGLdSe5hxyyc0CqqHaIM724BydjBDesPi6+fAr86oVCYFCVslryXClBFiANt2dFQT/
         Y267UK1XpdZSA==
Subject: Re: 5.3.18: BUG: kernel NULL pointer dereference
From:   Udo van den Heuvel <udovdh@xs4all.nl>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <93308fad-2462-c8f9-99b2-d8c8aab241d3@xs4all.nl>
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <13ec21bf-30d9-9aa3-e6ae-b8635ada306f@xs4all.nl>
Date:   Wed, 25 Mar 2020 09:45:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <93308fad-2462-c8f9-99b2-d8c8aab241d3@xs4all.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfMP5ZUv5OaQ5n6/88MFV1hGKT9J7GqLT/orA68mTqeNFmNAZsj3UBHe6Fyrcwo7DHo9e5znCTBpQ2ih+DUGfDLV7o+FD9+B3YjOFLHpchB9Jt0X6gzFu
 1N9vopWkkGzoXe8wUhRk+0Cdfyr9lDu4piYxXGU7P0p3j10kg8VRRoo3JEhpMdtE4HfjfPy2xmXQVxKkB2ZgWpfi0tNEhI6zFQ0Gvuibk4rgygyUB6UcMx1e
 h5cmnLlQLCnT3fjgAbjlLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Another thingie in dmesg; how does this one relate to
https://bugzilla.kernel.org/show_bug.cgi?id=206191 ?

[68167.282624] BUG: kernel NULL pointer dereference, address:
0000000000000028
[68167.324320] #PF: supervisor read access in kernel mode
[68167.355103] #PF: error_code(0x0000) - not-present page
[68167.385880] PGD 0 P4D 0
[68167.401034] Oops: 0000 [#2] PREEMPT SMP NOPTI
[68167.427127] CPU: 4 PID: 4510 Comm: transmission-gt Tainted: G      D
W         5.3.18 #25
[68167.476136] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[68167.534521] RIP: 0010:find_get_entry+0x80/0x130
[68167.561655] Code: 00 e8 f4 56 57 00 48 89 c2 48 3d 06 04 00 00 74 e4
48 3d 02 04 00 00 74 dc 48 85 c0 0f 84 a2 00 00 00 a8 01 0f 85 9f 00 00
00 <48> 8b 40 08 48 8d 78 ff a8 01 48 0f 44 fa 8b 47 34 85 c0 74 b6 8d
[68167.674199] RSP: 0018:ffffa85243f2fce8 EFLAGS: 00010246
[68167.705499] RAX: 0000000000000020 RBX: 0000000000000000 RCX:
ffffa2e9d1d6a240
[68167.748260] RDX: 0000000000000020 RSI: 0000000000000000 RDI:
ffffa85243f2fce8
[68167.791018] RBP: ffffa2ea60cf14c8 R08: 0000000000004000 R09:
0000000000000000
[68167.833776] R10: 0000000000000000 R11: 0000000000000000 R12:
ffffa2ea60cf14c8
[68167.876534] R13: 0000000000198a29 R14: 0000000000000000 R15:
0000000000198a29
[68167.919295] FS:  00007f967ed06700(0000) GS:ffffa2ea9f100000(0000)
knlGS:0000000000000000
[68167.967782] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[68168.002207] CR2: 0000000000000028 CR3: 000000040f44e000 CR4:
00000000003406e0
[68168.044965] Call Trace:
[68168.059604]  pagecache_get_page+0x22/0x220
[68168.084133]  generic_file_read_iter+0x175/0x7d0
[68168.111270]  ? __do_page_cache_readahead+0x18e/0x1b0
[68168.141008]  new_sync_read+0x106/0x1a0
[68168.163449]  vfs_read+0x98/0x120
[68168.182771]  ksys_pread64+0x60/0xa0
[68168.203657]  do_syscall_64+0x5f/0x2d0
[68168.225581]  ? schedule+0x48/0xc0
[68168.245425]  ? switch_fpu_return+0x24/0xc0
[68168.269954]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[68168.300214] RIP: 0033:0x7f968eb721af
[68168.321620] Code: 08 89 3c 24 48 89 4c 24 18 e8 4d f3 ff ff 4c 8b 54
24 18 48 8b 54 24 10 41 89 c0 48 8b 74 24 08 8b 3c 24 b8 11 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 2d 44 89 c7 48 89 04 24 e8 7d f3 ff ff 48 8b
[68168.434168] RSP: 002b:00007f967ed05870 EFLAGS: 00000293 ORIG_RAX:
0000000000000011
[68168.479532] RAX: ffffffffffffffda RBX: 0000000000000000 RCX:
00007f968eb721af
[68168.522288] RDX: 0000000000004000 RSI: 00007f9668d2114d RDI:
0000000000000066
[68168.565047] RBP: 00007f967ed05920 R08: 0000000000000000 R09:
00007f967ed05920
[68168.607806] R10: 0000000198a27fde R11: 0000000000000293 R12:
0000000000004000
[68168.650561] R13: 0000000000000001 R14: 00007f9668021ac8 R15:
00007f966802a8f0
[68168.693323] Modules linked in: fuse mq_deadline ip6t_REJECT
nf_reject_ipv6 xt_state ip6table_filter ip6_tables
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_MASQUERADE iptable_nat
nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid
msr iptable_filter uvcvideo videobuf2_vmalloc videobuf2_memops
snd_usb_audio videobuf2_v4l2 snd_hwdep snd_usbmidi_lib videodev
snd_hda_codec_realtek videobuf2_common snd_rawmidi cdc_acm
snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_seq
snd_seq_device snd_pcm i2c_piix4 k10temp snd_timer snd bfq evdev
acpi_cpufreq binfmt_misc ip_tables x_tables amdgpu hid_generic backlight
sr_mod gpu_sched aesni_intel ttm cdrom usbhid i2c_dev autofs4
[68169.136045] CR2: 0000000000000028
[68169.165281] ---[ end trace 76feac8f53a00049 ]---
[68169.192938] RIP: 0010:queued_spin_lock_slowpath+0x178/0x1d0
[68169.226320] Code: 8b 45 00 48 85 c0 74 f5 48 89 c2 eb e4 c1 ea 12 83
e0 03 ff ca 48 c1 e0 04 48 63 d2 48 05 c0 ed 01 00 48 03 04 d5 20 d5 e0
b1 <48> 89 28 8b 45 08 85 c0 75 09 f3 90 8b 45 08 85 c0 74 f7 48 8b 45
[68169.338870] RSP: 0018:ffffa85240747a88 EFLAGS: 00010002
[68169.370168] RAX: 0001812dff56fe58 RBX: ffffa2e9c6690350 RCX:
0000000000000000
[68169.412923] RDX: 0000000000003199 RSI: 00000000c6690300 RDI:
ffffa2e9c6690350
[68169.455683] RBP: ffffa2ea9f05edc0 R08: 0000000000000238 R09:
0000000000000002
[68169.498444] R10: ffffa2e9c6690348 R11: ffffa2ea8b08ed80 R12:
0000000000080000
[68169.541203] R13: 0000000000000001 R14: ffffa2e9c6690350 R15:
ffffddcf0c8ad008
[68169.583959] FS:  00007f967ed06700(0000) GS:ffffa2ea9f100000(0000)
knlGS:0000000000000000
[68169.632445] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[68169.666872] CR2: 0000000000000028 CR3: 000000040f44e000 CR4:
00000000003406e0


On 25-03-2020 06:07, Udo van den Heuvel wrote:
> Hello,
> 
> Due to the unusable 5.4.x and 5.5.x kernels, see
> https://bugzilla.kernel.org/show_bug.cgi?id=206191, I am running 5,3,18.
> This kernel crashes way less.
> It did show the fault below:
> 
> [56279.400332] general protection fault: 0000 [#1] PREEMPT SMP NOPTI
> [56279.436856] CPU: 1 PID: 233 Comm: kswapd0 Tainted: G        W
> 5.3.18 #25
> [56279.481174] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
> PRO/X570 AORUS PRO, BIOS F11 12/06/2019
> [56279.539562] RIP: 0010:queued_spin_lock_slowpath+0x178/0x1d0
> [56279.572948] Code: 8b 45 00 48 85 c0 74 f5 48 89 c2 eb e4 c1 ea 12 83
> e0 03 ff ca 48 c1 e0 04 48 63 d2 48 05 c0 ed 01 00 48 03 04 d5 20 d5 e0
> b1 <48> 89 28 8b 45 08 85 c0 75 09 f3 90 8b 45 08 85 c0 74 f7 48 8b 45
> [56279.685489] RSP: 0018:ffffa85240747a88 EFLAGS: 00010002
> [56279.716787] RAX: 0001812dff56fe58 RBX: ffffa2e9c6690350 RCX:
> 0000000000000000
> [56279.759547] RDX: 0000000000003199 RSI: 00000000c6690300 RDI:
> ffffa2e9c6690350
> [56279.802302] RBP: ffffa2ea9f05edc0 R08: 0000000000000238 R09:
> 0000000000000002
> [56279.845063] R10: ffffa2e9c6690348 R11: ffffa2ea8b08ed80 R12:
> 0000000000080000
> [56279.887823] R13: 0000000000000001 R14: ffffa2e9c6690350 R15:
> ffffddcf0c8ad008
> [56279.930579] FS:  0000000000000000(0000) GS:ffffa2ea9f040000(0000)
> knlGS:0000000000000000
> [56279.979068] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [56280.013491] CR2: 00007f07ef659fe0 CR3: 00000003eaa7e000 CR4:
> 00000000003406e0
> [56280.056253] Call Trace:
> [56280.070891]  _raw_spin_lock_irqsave+0x33/0x40
> [56280.096982]  __remove_mapping+0x4a/0x1e0
> [56280.120469]  shrink_page_list+0xb12/0xe60
> [56280.144477]  shrink_inactive_list+0x1ad/0x350
> [56280.170573]  shrink_node_memcg.isra.0+0x46e/0x7b0
> [56280.198747]  shrink_node+0x80/0x2e0
> [56280.219631]  balance_pgdat+0x239/0x4a0
> [56280.242078]  kswapd+0x165/0x2f0
> [56280.260880]  ? wait_woken+0x70/0x70
> [56280.281761]  kthread+0xfb/0x130
> [56280.300562]  ? balance_pgdat+0x4a0/0x4a0
> [56280.324052]  ? kthread_park+0x70/0x70
> [56280.345980]  ret_from_fork+0x22/0x40
> [56280.367383] Modules linked in: fuse mq_deadline ip6t_REJECT
> nf_reject_ipv6 xt_state ip6table_filter ip6_tables
> nf_conntrack_netbios_ns nf_conntrack_broadcast xt_MASQUERADE iptable_nat
> nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport xt_tcpudp
> xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 it87 hwmon_vid
> msr iptable_filter uvcvideo videobuf2_vmalloc videobuf2_memops
> snd_usb_audio videobuf2_v4l2 snd_hwdep snd_usbmidi_lib videodev
> snd_hda_codec_realtek videobuf2_common snd_rawmidi cdc_acm
> snd_hda_codec_generic snd_hda_intel snd_hda_codec snd_hda_core snd_seq
> snd_seq_device snd_pcm i2c_piix4 k10temp snd_timer snd bfq evdev
> acpi_cpufreq binfmt_misc ip_tables x_tables amdgpu hid_generic backlight
> sr_mod gpu_sched aesni_intel ttm cdrom usbhid i2c_dev autofs4
> [56280.442646] [drm] Fence fallback timer expired on ring gfx
> [56280.773148] ---[ end trace 76feac8f53a00048 ]---
> [56280.773152] RIP: 0010:queued_spin_lock_slowpath+0x178/0x1d0
> [56280.773154] Code: 8b 45 00 48 85 c0 74 f5 48 89 c2 eb e4 c1 ea 12 83
> e0 03 ff ca 48 c1 e0 04 48 63 d2 48 05 c0 ed 01 00 48 03 04 d5 20 d5 e0
> b1 <48> 89 28 8b 45 08 85 c0 75 09 f3 90 8b 45 08 85 c0 74 f7 48 8b 45
> [56280.773155] RSP: 0018:ffffa85240747a88 EFLAGS: 00010002
> [56280.773156] RAX: 0001812dff56fe58 RBX: ffffa2e9c6690350 RCX:
> 0000000000000000
> [56280.773157] RDX: 0000000000003199 RSI: 00000000c6690300 RDI:
> ffffa2e9c6690350
> [56280.773157] RBP: ffffa2ea9f05edc0 R08: 0000000000000238 R09:
> 0000000000000002
> [56280.773158] R10: ffffa2e9c6690348 R11: ffffa2ea8b08ed80 R12:
> 0000000000080000
> [56280.773159] R13: 0000000000000001 R14: ffffa2e9c6690350 R15:
> ffffddcf0c8ad008
> [56280.773160] FS:  0000000000000000(0000) GS:ffffa2ea9f040000(0000)
> knlGS:0000000000000000
> [56280.773160] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [56280.773161] CR2: 00007f07ef659fe0 CR3: 00000003eaa7e000 CR4:
> 00000000003406e0
> [56280.773163] note: kswapd0[233] exited with preempt_count 1
> 
> 
> 
> What happened here?
> Please let me know.
> 
> Kind regards,
> Udo
> 

