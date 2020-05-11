Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A4C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:06:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43BAD2075E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 09:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIdrz+tR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgEKJGS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbgEKJGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 05:06:18 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAAB0C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:06:17 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id f4so2383169iov.11
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 02:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QAyVYN5Y2FuhYroZ4HYJatEhHS6cbEGx+yjI6Qlad5w=;
        b=WIdrz+tRCPq24nylIoJ9yYXHQyPba6LI/9ibZhmo+cRRvhfnhqJRbTkr9RtRx/avs9
         iq1hHVxhjnzRI7qe1vo+lCk9vOkR0uK4ZmWp+zaNkCJIxExth4n0y0re+U+/mPLSUIRz
         LJaCxV3bL/kI1xIVQO5blfE8W3+IGRJ3rjHsi5SILsD/ogMae9FcxYYb9IqIbOUiCJHq
         GxCFHycImjuy0JEB+KA0NYrT2RMIFlUq72HKqr3BgfRLHL2HLQ7VKSF0QOjqSC5FqkiB
         lfqYPb76wMVwnVcIKs7+oJRugr6s5kQ909EKsqLsYywVoBK2OB0oNPbbK5JwZsGNiN4E
         GZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=QAyVYN5Y2FuhYroZ4HYJatEhHS6cbEGx+yjI6Qlad5w=;
        b=VlIpP+PVvp63qk48m0Rc+y4stpa10h6sjbboO8N3oN2EuSJt7Rm8VmycpBBkBVjMc3
         pnihGvlktzR7ARzLFnAoJqVmdqTIuVI4gXQh5urFktXVjtHa/uj0WteRluHTvIqZmEFa
         28o5Ajz4aljdOxL64ITTuW9QCVNiLaNczkhClGO0hVH8xkW7B0thEC2P2FkgFJfpcbe8
         anNZdqkXlX31Pj/6R9yIqQ7j7us9QqFMvncvi5brp+lxdoYjOO5Ujsq6lQ/Sy9iOI/+i
         52NntkyBFry15YSu8AHUcHuQVlXyGZXsMeyGwY/CuOlTziVF/3+vg4bKwvGQbU971Ici
         9MYQ==
X-Gm-Message-State: AGi0PuaD3xcLZWixwC7IR8o7J/at6Z6cCQpUZKM1cNgD0Wk4aUO9uHuw
        MiEMLR7C/lUqEWOrSclsGP973IasOmLHjeCsbuse11NaLvEnWQ==
X-Google-Smtp-Source: APiQypK83qQvbVQwjO7cN1uOCxkiUV3OTluUWr/YMfe1xlglByPNKC4n8mlhdEPGtYsPJS44AKi+hVCUfMlfoAWGfl0=
X-Received: by 2002:a6b:b512:: with SMTP id e18mr14201827iof.168.1589187976937;
 Mon, 11 May 2020 02:06:16 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 11 May 2020 14:06:06 +0500
Message-ID: <CABXGCsPsnkcN7T=ZBSrpvLRX+eOs=G=eUsspwk=PG4hBJwAUTg@mail.gmail.com>
Subject: [BUG] general protection fault, probably for non-canonical address
 0xfe5d6f0af7831e5e: 0000 [#1] SMP NOPTI (5.7RC4 GIT 79dede78c057)
To:     amd-gfx list <amd-gfx@lists.freedesktop.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks.
I didn=E2=80=99t do anything unusual, I just restarted the computer after t=
he
update, launched all the applications that I usually launch and went
to drink tea.
When I returned, I found that the monitor was on (it should have
turned off since I had set the energy-saving mode for 5 minutes in DE)
I tried to move the mouse, after that I realized that the computer was
completely frozen. Even Alt+PrnScr+B did not helped reboot computer.
I decided to fill the bug report here since this is a really serious proble=
m.

general protection fault, probably for non-canonical address
0xfe5d6f0af7831e5e: 0000 [#1] SMP NOPTI
CPU: 16 PID: 6372 Comm: chrome:cs0 Not tainted
5.7.0-0.rc4.20200508git79dede78c057.1.fc33.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 1405 11/19/2019
RIP: 0010:kmem_cache_alloc+0x83/0x310
Code: 02 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 5b a3 cc 5e 4d
8b 20 4d 85 e4 0f 84 3e 02 00 00 8b 45 20 48 8b 7d 00 4c 01 e0 <48> 8b
18 48 89 c1 48 33 9d d0 01 00 00 48 0f c9 48 31 cb 40 f6 c7
RSP: 0018:ffffa8398b357b08 EFLAGS: 00010282
RAX: fe5d6f0af7831e5e RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000062b6 RSI: 0000000000000400 RDI: 00000000001f83c0
RBP: ffff9513740e9200 R08: ffff95137c3f83c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: fe5d6f0af7831dee
R13: 0000000000000dc0 R14: ffff9513740e9200 R15: ffffffffc03a3e92
FS:  00007fd77db5c700(0000) GS:ffff95137c200000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fea1fe56540 CR3: 000000060424a000 CR4: 0000000000340ee0
Call Trace:
 drm_sched_fence_create+0x22/0xc0 [gpu_sched]
 drm_sched_job_init+0x5d/0xa0 [gpu_sched]
 amdgpu_cs_ioctl+0x17d5/0x1eb0 [amdgpu]
 ? amdgpu_cs_find_mapping+0xf0/0xf0 [amdgpu]
 drm_ioctl_kernel+0x86/0xd0 [drm]
 drm_ioctl+0x206/0x390 [drm]
 ? amdgpu_cs_find_mapping+0xf0/0xf0 [amdgpu]
 amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
 ksys_ioctl+0x82/0xc0
 __x64_sys_ioctl+0x16/0x20
 do_syscall_64+0x5c/0xa0
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7fd7954654bb
Code: 0f 1e fa 48 8b 05 cd b9 0c 00 64 c7 00 26 00 00 00 48 c7 c0 ff
ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 00 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 8b 0d 9d b9 0c 00 f7 d8 64 89 01 48
RSP: 002b:00007fd77db5b628 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd77db5b690 RCX: 00007fd7954654bb
RDX: 00007fd77db5b690 RSI: 00000000c0186444 RDI: 0000000000000016
RBP: 00000000c0186444 R08: 00007fd77db5b7a0 R09: 00007fd77db5b670
R10: 0000000000000000 R11: 0000000000000246 R12: 00003a732f36f000
R13: 0000000000000016 R14: 00003a732f5122ec R15: 00003a732f50a0f8
Modules linked in: snd_seq_dummy snd_hrtimer uinput rfcomm xt_CHECKSUM
xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp
tun nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nft_chain_nat
ip6table_nat ip6table_mangle ip6table_raw ip6table_security
iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4
iptable_mangle iptable_raw iptable_security ip_set nf_tables nfnetlink
ip6table_filter ip6_tables iptable_filter cmac bnep sunrpc vfat fat
hid_logitech_hidpp xpad ff_memless joydev edac_mce_amd kvm_amd kvm
irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel
hid_logitech_dj eeepc_wmi asus_wmi sparse_keymap video snd_usb_audio
btusb btrtl wmi_bmof btbcm snd_usbmidi_lib btintel snd_rawmidi
bluetooth mc ecdh_generic ecc pcspkr sp5100_tco k10temp iwlmvm
i2c_piix4 snd_hda_codec_realtek mac80211 snd_hda_codec_generic
ledtrig_audio
 snd_hda_codec_hdmi libarc4 snd_hda_intel snd_intel_dspcfg
snd_hda_codec iwlwifi snd_hda_core snd_hwdep cfg80211 snd_seq
snd_seq_device snd_pcm rfkill snd_timer snd ccp soundcore acpi_cpufreq
binfmt_misc ip_tables xfs libcrc32c amdgpu amd_iommu_v2 gpu_sched ttm
drm_kms_helper cec drm crc32c_intel igb nvme dca nvme_core
i2c_algo_bit wmi pinctrl_amd br_netfilter bridge stp llc fuse
---[ end trace 4528e591387ed399 ]---
RIP: 0010:kmem_cache_alloc+0x83/0x310
Code: 02 00 00 4c 8b 45 00 65 49 8b 50 08 65 4c 03 05 5b a3 cc 5e 4d
8b 20 4d 85 e4 0f 84 3e 02 00 00 8b 45 20 48 8b 7d 00 4c 01 e0 <48> 8b
18 48 89 c1 48 33 9d d0 01 00 00 48 0f c9 48 31 cb 40 f6 c7
RSP: 0018:ffffa8398b357b08 EFLAGS: 00010282
RAX: fe5d6f0af7831e5e RBX: 0000000000000000 RCX: 0000000000000000
RDX: 00000000000062b6 RSI: 0000000000000400 RDI: 00000000001f83c0
RBP: ffff9513740e9200 R08: ffff95137c3f83c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: fe5d6f0af7831dee
R13: 0000000000000dc0 R14: ffff9513740e9200 R15: ffffffffc03a3e92
FS:  00007fd77db5c700(0000) GS:ffff95137c200000(0000) knlGS:000000000000000=
0
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fea1fe56540 CR3: 000000060424a000 CR4: 0000000000340ee0

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/`uname -r`/vmlinux kmem_cache_alloc+0x83/0x310
kmem_cache_alloc+0x83/0x310:
freelist_ptr at mm/slub.c:261
(inlined by) freelist_dereference at mm/slub.c:272
(inlined by) get_freepointer at mm/slub.c:278
(inlined by) get_freepointer_safe at mm/slub.c:292
(inlined by) slab_alloc_node at mm/slub.c:2754
(inlined by) slab_alloc at mm/slub.c:2795
(inlined by) kmem_cache_alloc at mm/slub.c:2800

I think this issue related to amdgpu driver.
Can anyone look into it?

Thanks.

Here is full system log: https://pastebin.com/H4NYTy9U

--
Best Regards,
Mike Gavrilov.
