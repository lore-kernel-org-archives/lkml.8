Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403EBC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF2C2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 16:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4dqGfu8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730436AbgAKQd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 11:33:57 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37201 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729957AbgAKQd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 11:33:56 -0500
Received: by mail-io1-f65.google.com with SMTP id k24so5327073ioc.4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jan 2020 08:33:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8dPTpf9yDGah93vn5e2BNFKtz81w78/O28Zww7aii2U=;
        b=K4dqGfu8lKcPcoyVHARoWNQ/mkzcT0RP7q7yp8LCOZTlKLnrP28uR9G6zYNvTMcVS0
         L2P34R2RX5qKrDNuQjIUn1BU3zELB8Kn1f7kiDuAWFnNcoTNb1jtzkjV/9/7StkHnstB
         cac4Z7l62HG71y9NF3DPz4Uf77+78EoqM1eWANgGA5Va1F1O6r8KDNnHRy/Ry2NqmfF8
         eaaHzmYaAK3Jt6/qo44M/K5DtmIaG+OgtzTsNzAxcBzax0a9pnEcfTuvUBIj6pU0CgnG
         OgH0j4Bpnh1fwp0gC33CNwGfUGwEPjGG6Qymf/6cyWrypno8H8MFy4yMrmopKl/mvgJo
         0E+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8dPTpf9yDGah93vn5e2BNFKtz81w78/O28Zww7aii2U=;
        b=SMfAt6thoAnkYGrLr2CDvw9MnN56CiQBEh+c9SIESbnwFzkO1Sw33TIqud0Sixnw6C
         R9huvg86IrJJxkG+gqfXk1iAfeA5TWwr2Pl/HiJf+TpRwRxl8kOKQfV4wETf9c65VRnv
         vGvfXHhI2PyM64F0Qzs/aKYrf2DcIMd6xk16pnDIngaxeFVKLVLvBl0RRPD7SkqauMQF
         mV6rwFO2HAtJfZPa8agukT+20YVdiRd3WUQY5/XVILg8RkBJcopWUgR5B6g+++7cTFHt
         15cV7HLKtA6kbAowlqGQLPuECdb6a8ea/9CtRbzZizLUNzko8yYH1a/EKuS5fle4RCsa
         lQKw==
X-Gm-Message-State: APjAAAXlMdzIC51uWb2o7CRDon1c26UpsNFAqoGLvh4MFAuLUP31uFTM
        x3o6VweZX0JDIE3AEeVHXv4geh2UpaiPQEY46gvfUTe3zuxlYA==
X-Google-Smtp-Source: APXvYqyliCKJkTbvLbpby8tUymOH9pg7SLOuFG0ZI1GtDdBTqcuUgCHc8JQ8gW2GuV5IVknxsDWQUMHGn3PFw771Pis=
X-Received: by 2002:a6b:8e51:: with SMTP id q78mr6673448iod.179.1578760435768;
 Sat, 11 Jan 2020 08:33:55 -0800 (PST)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Sat, 11 Jan 2020 21:33:45 +0500
Message-ID: <CABXGCsMLCt+jheJMmSQsjW_pEpyZ0QUeDG1vz7cSuYqbZJ7z-g@mail.gmail.com>
Subject: [BUG] RIP: 0010:__kmalloc+0xa8/0x330 (general protection fault: 0000
 [#1] SMP NOPTI)
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks, I caused a kernel panic by just starting downloading
simultaneously several big files by Google Chrome browser and removing
games in parallel  in the Steam client (because the disk was almost
full)

general protection fault: 0000 [#1] SMP NOPTI
CPU: 15 PID: 104506 Comm: Chrome_IOThread Not tainted
5.5.0-0.rc5.git3.2.fc32.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 1405 11/19/2019
RIP: 0010:__kmalloc+0xa8/0x330
Code: e3 01 00 00 4d 8b 06 65 49 8b 50 08 65 4c 03 05 be 91 cc 5e 4d
8b 38 4d 85 ff 0f 84 22 02 00 00 41 8b 5e 20 49 8b 3e 4c 01 fb <48> 33
1b 49 33 9e d0 01 00 00 40 f6 c7 0f 0f 85 1f 02 00 00 48 8d
RSP: 0018:ffffa4428b6bfb00 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 669e19e5410de38b RCX: 0000000000000000
RDX: 000000000016fcfc RSI: 0000000000000400 RDI: 00000000001f4080
RBP: 0000000000000cc0 R08: ffff889a7c1f4080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
R13: ffff889a76c07800 R14: ffff889a76c07800 R15: 669e19e5410de38b
FS:  00007fd5dc49d700(0000) GS:ffff889a7c000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00001a0409c04000 CR3: 000000078042e000 CR4: 0000000000340ee0
Call Trace:
 ? shmem_initxattrs+0x89/0xd0
 shmem_initxattrs+0x89/0xd0
 security_inode_init_security+0xf8/0x140
 ? shmem_enabled_store+0x1f0/0x1f0
 shmem_mknod+0x76/0xe0
 lookup_open+0x5bd/0x820
 path_openat+0x33d/0xc90
 ? touch_atime+0x33/0xe0
 do_filp_open+0x91/0x100
 ? _raw_spin_unlock+0x1f/0x30
 ? __alloc_fd+0xe9/0x1d0
 do_sys_open+0x184/0x220
 do_syscall_64+0x5c/0xa0
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x7fd5ee1d3134
Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 26 4c f9 ff 44 8b 54 24 0c
44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
00 f0 ff ff 77 32 44 89 c7 89 44 24 0c e8 58 4c f9 ff 8b 44
RSP: 002b:00007fd5dc49bc30 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd5ee1d3134
RDX: 00000000000000c2 RSI: 00001baff2871330 RDI: 00000000ffffff9c
RBP: 00001baff2871330 R08: 0000000000000000 R09: 00007fd5dc49bcd8
R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
R13: 00007fd5ee272c60 R14: 00007fd5dc49bcd0 R15: 8421084210842109
Modules linked in: uinput rfcomm xt_CHECKSUM xt_MASQUERADE
xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp
llc nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_tables_set
nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
iptable_raw iptable_security ip_set nfnetlink ebtable_filter ebtables
ip6table_filter ip6_tables iptable_filter cmac bnep sunrpc vfat fat
snd_hda_codec_realtek snd_hda_codec_generic edac_mce_amd ledtrig_audio
snd_hda_codec_hdmi iwlmvm snd_hda_intel kvm_amd snd_intel_dspcfg
snd_usb_audio kvm snd_hda_codec snd_hda_core snd_usbmidi_lib btusb
irqbypass snd_rawmidi mac80211 snd_hwdep uvcvideo btrtl snd_seq btbcm
videobuf2_vmalloc btintel videobuf2_memops snd_seq_device
 videobuf2_v4l2 crct10dif_pclmul videobuf2_common bluetooth
crc32_pclmul libarc4 snd_pcm videodev joydev iwlwifi eeepc_wmi xpad mc
snd_timer ff_memless ghash_clmulni_intel asus_wmi ecdh_generic
sparse_keymap ecc video sp5100_tco wmi_bmof pcspkr snd cfg80211
k10temp ccp i2c_piix4 soundcore rfkill acpi_cpufreq binfmt_misc
ip_tables hid_logitech_hidpp hid_logitech_dj amdgpu amd_iommu_v2
gpu_sched ttm drm_kms_helper drm igb nvme crc32c_intel dca nvme_core
i2c_algo_bit wmi pinctrl_amd fuse
---[ end trace 8503eed9a4b0cd11 ]---
RIP: 0010:__kmalloc+0xa8/0x330
Code: e3 01 00 00 4d 8b 06 65 49 8b 50 08 65 4c 03 05 be 91 cc 5e 4d
8b 38 4d 85 ff 0f 84 22 02 00 00 41 8b 5e 20 49 8b 3e 4c 01 fb <48> 33
1b 49 33 9e d0 01 00 00 40 f6 c7 0f 0f 85 1f 02 00 00 48 8d
RSP: 0018:ffffa4428b6bfb00 EFLAGS: 00010206
RAX: 0000000000000000 RBX: 669e19e5410de38b RCX: 0000000000000000
RDX: 000000000016fcfc RSI: 0000000000000400 RDI: 00000000001f4080
RBP: 0000000000000cc0 R08: ffff889a7c1f4080 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
R13: ffff889a76c07800 R14: ffff889a76c07800 R15: 669e19e5410de38b
FS:  00007fd5dc49d700(0000) GS:ffff889a7c000000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00001a0409c04000 CR3: 000000078042e000 CR4: 0000000000340ee0

I don=E2=80=99t think that git bisect is really possible here because the
state on the disk will be different each time (there are no more
deleted files) and there is no exact case that would reproduce the
error.

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux __kmalloc+0xa8/0x330
__kmalloc+0xa8/0x330:
freelist_ptr at mm/slub.c:261
(inlined by) freelist_dereference at mm/slub.c:272
(inlined by) get_freepointer at mm/slub.c:278
(inlined by) get_freepointer_safe at mm/slub.c:292
(inlined by) slab_alloc_node at mm/slub.c:2726
(inlined by) slab_alloc at mm/slub.c:2767
(inlined by) __kmalloc at mm/slub.c:3799

From the trace, I see that the problem comes from mm/slub.c so I added
this report in the linux-mm mailing list please correct me if I'm
wrong.

--
Best Regards,
Mike Gavrilov.
