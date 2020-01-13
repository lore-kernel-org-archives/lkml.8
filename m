Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F068C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:44:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A06214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 13:44:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbgAMNoy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 08:44:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:47044 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbgAMNox (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 08:44:53 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4E2CCB18F;
        Mon, 13 Jan 2020 13:44:51 +0000 (UTC)
Subject: Re: [BUG] RIP: 0010:__kmalloc+0xa8/0x330 (general protection fault:
 0000 [#1] SMP NOPTI)
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux.com>
References: <CABXGCsMLCt+jheJMmSQsjW_pEpyZ0QUeDG1vz7cSuYqbZJ7z-g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; prefer-encrypt=mutual; keydata=
 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
Message-ID: <66871c0a-d763-abfc-46f1-d6ce3441f9fb@suse.cz>
Date:   Mon, 13 Jan 2020 14:44:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CABXGCsMLCt+jheJMmSQsjW_pEpyZ0QUeDG1vz7cSuYqbZJ7z-g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+CC Christoph

On 1/11/20 5:33 PM, Mikhail Gavrilov wrote:
> Hi folks, I caused a kernel panic by just starting downloading
> simultaneously several big files by Google Chrome browser and removing
> games in parallel  in the Steam client (because the disk was almost
> full)
> 
> general protection fault: 0000 [#1] SMP NOPTI
> CPU: 15 PID: 104506 Comm: Chrome_IOThread Not tainted
> 5.5.0-0.rc5.git3.2.fc32.x86_64 #1
> Hardware name: System manufacturer System Product Name/ROG STRIX
> X570-I GAMING, BIOS 1405 11/19/2019
> RIP: 0010:__kmalloc+0xa8/0x330
> Code: e3 01 00 00 4d 8b 06 65 49 8b 50 08 65 4c 03 05 be 91 cc 5e 4d
> 8b 38 4d 85 ff 0f 84 22 02 00 00 41 8b 5e 20 49 8b 3e 4c 01 fb <48> 33
> 1b 49 33 9e d0 01 00 00 40 f6 c7 0f 0f 85 1f 02 00 00 48 8d
> RSP: 0018:ffffa4428b6bfb00 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 669e19e5410de38b RCX: 0000000000000000
> RDX: 000000000016fcfc RSI: 0000000000000400 RDI: 00000000001f4080
> RBP: 0000000000000cc0 R08: ffff889a7c1f4080 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
> R13: ffff889a76c07800 R14: ffff889a76c07800 R15: 669e19e5410de38b
> FS:  00007fd5dc49d700(0000) GS:ffff889a7c000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00001a0409c04000 CR3: 000000078042e000 CR4: 0000000000340ee0
> Call Trace:
>  ? shmem_initxattrs+0x89/0xd0
>  shmem_initxattrs+0x89/0xd0
>  security_inode_init_security+0xf8/0x140
>  ? shmem_enabled_store+0x1f0/0x1f0
>  shmem_mknod+0x76/0xe0
>  lookup_open+0x5bd/0x820
>  path_openat+0x33d/0xc90
>  ? touch_atime+0x33/0xe0
>  do_filp_open+0x91/0x100
>  ? _raw_spin_unlock+0x1f/0x30
>  ? __alloc_fd+0xe9/0x1d0
>  do_sys_open+0x184/0x220
>  do_syscall_64+0x5c/0xa0
>  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> RIP: 0033:0x7fd5ee1d3134
> Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 26 4c f9 ff 44 8b 54 24 0c
> 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <48> 3d
> 00 f0 ff ff 77 32 44 89 c7 89 44 24 0c e8 58 4c f9 ff 8b 44
> RSP: 002b:00007fd5dc49bc30 EFLAGS: 00000293 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd5ee1d3134
> RDX: 00000000000000c2 RSI: 00001baff2871330 RDI: 00000000ffffff9c
> RBP: 00001baff2871330 R08: 0000000000000000 R09: 00007fd5dc49bcd8
> R10: 0000000000000180 R11: 0000000000000293 R12: 00000000000000c2
> R13: 00007fd5ee272c60 R14: 00007fd5dc49bcd0 R15: 8421084210842109
> Modules linked in: uinput rfcomm xt_CHECKSUM xt_MASQUERADE
> xt_conntrack ipt_REJECT nf_nat_tftp nf_conntrack_tftp tun bridge stp
> llc nft_objref nf_conntrack_netbios_ns nf_conntrack_broadcast
> nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet
> nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct nf_tables_set
> nft_chain_nat nf_tables ebtable_nat ebtable_broute ip6table_nat
> ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat
> nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c iptable_mangle
> iptable_raw iptable_security ip_set nfnetlink ebtable_filter ebtables
> ip6table_filter ip6_tables iptable_filter cmac bnep sunrpc vfat fat
> snd_hda_codec_realtek snd_hda_codec_generic edac_mce_amd ledtrig_audio
> snd_hda_codec_hdmi iwlmvm snd_hda_intel kvm_amd snd_intel_dspcfg
> snd_usb_audio kvm snd_hda_codec snd_hda_core snd_usbmidi_lib btusb
> irqbypass snd_rawmidi mac80211 snd_hwdep uvcvideo btrtl snd_seq btbcm
> videobuf2_vmalloc btintel videobuf2_memops snd_seq_device
>  videobuf2_v4l2 crct10dif_pclmul videobuf2_common bluetooth
> crc32_pclmul libarc4 snd_pcm videodev joydev iwlwifi eeepc_wmi xpad mc
> snd_timer ff_memless ghash_clmulni_intel asus_wmi ecdh_generic
> sparse_keymap ecc video sp5100_tco wmi_bmof pcspkr snd cfg80211
> k10temp ccp i2c_piix4 soundcore rfkill acpi_cpufreq binfmt_misc
> ip_tables hid_logitech_hidpp hid_logitech_dj amdgpu amd_iommu_v2
> gpu_sched ttm drm_kms_helper drm igb nvme crc32c_intel dca nvme_core
> i2c_algo_bit wmi pinctrl_amd fuse
> ---[ end trace 8503eed9a4b0cd11 ]---
> RIP: 0010:__kmalloc+0xa8/0x330
> Code: e3 01 00 00 4d 8b 06 65 49 8b 50 08 65 4c 03 05 be 91 cc 5e 4d
> 8b 38 4d 85 ff 0f 84 22 02 00 00 41 8b 5e 20 49 8b 3e 4c 01 fb <48> 33
> 1b 49 33 9e d0 01 00 00 40 f6 c7 0f 0f 85 1f 02 00 00 48 8d
> RSP: 0018:ffffa4428b6bfb00 EFLAGS: 00010206
> RAX: 0000000000000000 RBX: 669e19e5410de38b RCX: 0000000000000000
> RDX: 000000000016fcfc RSI: 0000000000000400 RDI: 00000000001f4080
> RBP: 0000000000000cc0 R08: ffff889a7c1f4080 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000011
> R13: ffff889a76c07800 R14: ffff889a76c07800 R15: 669e19e5410de38b
> FS:  00007fd5dc49d700(0000) GS:ffff889a7c000000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00001a0409c04000 CR3: 000000078042e000 CR4: 0000000000340ee0
> 
> I don’t think that git bisect is really possible here because the
> state on the disk will be different each time (there are no more
> deleted files) and there is no exact case that would reproduce the
> error.

But is the bug reproducible at all? And is it always the same stack trace?

> $ /usr/src/kernels/`uname -r`/scripts/faddr2line
> /lib/debug/lib/modules/`uname -r`/vmlinux __kmalloc+0xa8/0x330
> __kmalloc+0xa8/0x330:
> freelist_ptr at mm/slub.c:261
> (inlined by) freelist_dereference at mm/slub.c:272
> (inlined by) get_freepointer at mm/slub.c:278
> (inlined by) get_freepointer_safe at mm/slub.c:292
> (inlined by) slab_alloc_node at mm/slub.c:2726
> (inlined by) slab_alloc at mm/slub.c:2767
> (inlined by) __kmalloc at mm/slub.c:3799
> 
> From the trace, I see that the problem comes from mm/slub.c so I added
> this report in the linux-mm mailing list please correct me if I'm
> wrong.

SLUB is most likely just a victim of somebody else doing something wrong
with kmalloced objects. You can boot with extra debugging that could
tell us more, i.e. add this boot kernel parameter:

slub_debug=FU,kmalloc-*

Or a more thorough version, but making the system even slower:

slub_debug=FZPU,kmalloc-*

Vlastimil

> --
> Best Regards,
> Mike Gavrilov.
> 

