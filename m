Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616FDC2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3CE620673
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 04:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="fx5gbimK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725993AbgDJEqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 00:46:43 -0400
Received: from lb1-smtp-cloud8.xs4all.net ([194.109.24.21]:42975 "EHLO
        lb1-smtp-cloud8.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgDJEqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 00:46:42 -0400
Received: from cust-57f2be97 ([IPv6:fc0c:c196:c6c4:fdf1:aa47:ab6:e251:d2a8])
        by smtp-cloud8.xs4all.net with ESMTPA
        id MlYtj6xKZlKa1MlYujrZGp; Fri, 10 Apr 2020 06:46:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1586494000; bh=7/6VRqf1T9ovGfBGedYovm5h6VJqa+jswRx17EIUcWg=;
        h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=fx5gbimKOP4e1jmCzjK6nhG+D5vlWu+5HozxfxKqnkAynFZeeU7vnRmqxh5X5kjMl
         0RPxyh7C8rusyMwAxP2HxvzRNhZ7ZLJj+apGAcpp+693jUlL0ht4yCwoNX6CMnen68
         uyjZJF8/jbhod07EQS/FixsUyWC5JVf/T4vhQId8lUPvZuEwikCMvNGUWsiCeaqaia
         O2WAGzeJPD+wt3fZNF1SK0HtKU3q1rr18i40CHCMXwFD2WP5frDUAcluolWRGppMNC
         abW2iK2WlT9rZ8B+01tXcClaFiDsDalW9k+pwJPIgoCf0Zzb7XhvgAdtIRZ0//gwqZ
         P/Hsaobf9+Yxg==
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   Udo van den Heuvel <udovdh@xs4all.nl>
Subject: 5.6.2: BUG: Bad page map, Bad rss-counter state
Autocrypt: addr=udovdh@xs4all.nl; prefer-encrypt=mutual; keydata=
 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
 JjyRAfO8kEkwCkTZ6/Mnrxsunx9VNLGDEw==
Organization: hierzo
Message-ID: <836f7580-526d-52e2-5ceb-3cfd0b501970@xs4all.nl>
Date:   Fri, 10 Apr 2020 06:46:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC575Bkm200eHQjbIbtfR3gJyomS9phqUStPxnPBvej2YCij915y7l3i2wwFH+vBq1JTiHT3ARvvaBGZhUlApbeWHuhBB2u1kquyAldFwYtBnen3Dd6Y
 4x1+L8twX/ksbER8+kCvdcTEmpZZqyXEsvyYa419VDnP/+SFnID4+cnzZCyAaGeQh8vFemmYstQj9Paz/drGiKgUAduLbsnIsws2YhrlElW+RfjAySkPc/1B
 4TJH/2ty28a5i85pQe0daw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Found these in dmesg.
What can I do to help fix these?

[106601.847053] traps: Web Content[270439] general protection fault
ip:7f9acaa00d82 sp:7ffcb7bca6b0 error:0 in libxul.so[7f9ac6f7e000+4bf9000]
[121178.597634] Web Content[270460]: segfault at ffffc955ffffc965 ip
00007f338c1b366e sp 00007ffc5693fe70 error 5 in
libxul.so[7f3387993000+4bf9000]
[121178.754856] Code: 0f 84 8e 00 00 00 48 83 c3 18 49 c1 e4 05 49 89 e6
eb 13 66 0f 1f 84 00 00 00 00 00 48 83 c3 20 49 83 c4 e0 74 6e 48 8b 43
f8 <48> 8b 48 10 48 89 04 24 48 89 4c 24 08 48 8b 08 48 83 f9 ff 74 16
[121179.144620] BUG: Bad rss-counter state mm:0000000070be7b16
type:MM_ANONPAGES val:1
[121179.248451] BUG: Bad rss-counter state mm:0000000070be7b16
type:MM_SHMEMPAGES val:-1
[167164.401164] ThreadPoolForeg[475080]: segfault at 20c000000007 ip
0000560103a34528 sp 00007f66acff7130 error 4 in
skypeforlinux[560102f50000+5425000]
[167164.561845] Code: 1e 00 00 00 0f b7 7b 0b 49 8b 17 48 89 de 89 c1 4d
89 f0 48 83 c4 08 5b 41 5e 41 5f 5d e9 e0 40 01 00 55 48 89 e5 48 83 ec
10 <8a> 46 07 84 c0 74 0c 0f b6 c0 c1 e0 03 48 83 c4 10 5d c3 0f b7 46
[167164.810773] BUG: Bad page map in process skypeforlinux
pte:8000000318f79067 pmd:1b32f7067
[167164.910953] page:fffff49c0ad76278 refcount:2 mapcount:-1
mapping:ffffa01e8b5166f8 index:0x8c
[167165.013220] 0xffffffffb4c15800 name:".org.chromium.Chromium.94hBw8"
[167165.089368] flags: 0x800000000008001c(uptodate|dirty|lru|swapbacked)
[167165.166551] raw: 800000000008001c fffff49c0afac800 fffff49c0cac5218
ffffa01e8b5166f8
[167165.260402] raw: 000000000000008c 0000000000000000 00000002fffffffe
[167165.336538] page dumped because: bad pte
[167165.384570] addr:00007f6618a8e000 vm_flags:000000bb
anon_vma:0000000000000000 mapping:ffffa01e8b5166f8 index:8c
[167165.506703] file:.org.chromium.Chromium.94hBw8 fault:shmem_fault
mmap:shmem_mmap readpage:0x0
[167165.609985] CPU: 1 PID: 279870 Comm: skypeforlinux Not tainted 5.6.2 #6
[167165.690309] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[167165.808116] Call Trace:
[167165.838433]  dump_stack+0x50/0x70
[167165.879170]  print_bad_pte.cold+0x7d/0xfe
[167165.928217]  unmap_page_range+0x693/0xa50
[167165.977280]  unmap_vmas+0x6b/0xd0
[167166.018009]  exit_mmap+0x98/0x180
[167166.058737]  mmput+0x2a/0xe0
[167166.094252]  do_exit+0x2e4/0xa40
[167166.125932] [drm] Fence fallback timer expired on ring gfx
[167166.133943]  do_group_exit+0x35/0x90
[167166.133946]  get_signal+0x117/0x7a0
[167166.133950]  do_signal+0x2b/0x5c0
[167166.328102]  ? __x64_sys_futex+0x132/0x160
[167166.378199]  do_syscall_64+0x316/0x430
[167166.424137]  ? handle_mm_fault+0x4b/0xc0
[167166.472153]  ? do_page_fault+0x1c1/0x41a
[167166.520172]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[167166.581734] RIP: 0033:0x7f66f4433d45
[167166.625586] Code: Bad RIP value.
[167166.665266] RSP: 002b:00007fff92968180 EFLAGS: 00000282 ORIG_RAX:
00000000000000ca
[167166.701914] [drm] Fence fallback timer expired on ring gfx
[167166.757035] RAX: fffffffffffffe00 RBX: 0000000000000000 RCX:
00007f66f4433d45
[167166.757036] RDX: 0000000000000000 RSI: 0000000000000080 RDI:
00005601096e0ab8
[167166.757037] RBP: 00005601096e0a90 R08: 0000000000000000 R09:
0000000000000000
[167166.757038] R10: 0000000000000000 R11: 0000000000000282 R12:
00007fff929681b0
[167166.757039] R13: 00005601096e0a68 R14: 00005601096e0ab8 R15:
0000000000000000
[167166.757138] Disabling lock debugging due to kernel taint
[167167.325848] BUG: Bad page state in process ImageBr~geChild  pfn:318f79
[167167.405137] page:fffff49c0ad76278 refcount:0 mapcount:-1
mapping:ffffa01e8b5166f8 index:0x1
[167167.506273] 0xffffffffb4c15800
[167167.543879] flags: 0x8000000000000000()
[167167.590858] raw: 8000000000000000 dead000000000100 dead000000000122
ffffa01e8b5166f8
[167167.684707] raw: 0000000000000001 0000000000000000 00000000fffffffe
[167167.760844] page dumped because: non-NULL mapping
[167167.818235] Modules linked in: fuse mq_deadline xt_MASQUERADE
iptable_nat nf_nat ipt_REJECT nf_reject_ipv4 xt_u32 xt_multiport
iptable_filter nf_conntrack_netbios_ns nf_conntrack_broadcast
ip6t_REJECT nf_reject_ipv6 it87 hwmon_vid xt_tcpudp xt_state
xt_conntrack nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip6table_filter
ip6_tables msr uvcvideo snd_usb_audio videobuf2_vmalloc videobuf2_memops
snd_hwdep videobuf2_v4l2 videodev snd_usbmidi_lib videobuf2_common
snd_rawmidi cdc_acm snd_hda_codec_realtek k10temp snd_hda_codec_generic
i2c_piix4 snd_hda_intel snd_intel_dspcfg snd_hda_codec snd_hda_core
snd_seq snd_seq_device snd_pcm snd_timer snd bfq evdev acpi_cpufreq
binfmt_misc ip_tables x_tables hid_generic aesni_intel amdgpu gpu_sched
ttm sr_mod cdrom usbhid i2c_dev autofs4
[167167.821893] [drm] Fence fallback timer expired on ring gfx
[167168.638106] CPU: 1 PID: 465939 Comm: ImageBr~geChild Tainted: G    B
            5.6.2 #6
[167168.638108] Hardware name: Gigabyte Technology Co., Ltd. X570 AORUS
PRO/X570 AORUS PRO, BIOS F11 12/06/2019
[167168.638109] Call Trace:
[167168.638117]  dump_stack+0x50/0x70
[167168.638122]  bad_page.cold+0x8d/0xbe
[167168.638125]  free_pcppages_bulk+0x17d/0x540
[167168.638129]  free_unref_page_list+0xd0/0x120
[167168.638132]  release_pages+0x28f/0x2f0
[167168.638136]  tlb_batch_pages_flush+0x1e/0x40
[167168.638138]  tlb_finish_mmu+0x43/0x150
[167168.638141]  unmap_region+0xd1/0x100
[167168.638144]  __do_munmap+0x1d2/0x4a0
[167168.638147]  __vm_munmap+0x62/0xb0
[167168.638150]  __x64_sys_munmap+0x12/0x20
[167168.638153]  do_syscall_64+0x63/0x430
[167168.638161]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[167168.642421] [drm] Fence fallback timer expired on ring sdma0
[167169.229858] [drm] Fence fallback timer expired on ring gfx
[167169.238077] RIP: 0033:0x7fe9d904f3fb
[167169.238080] Code: 8b 15 91 5a 0c 00 f7 d8 64 89 02 48 c7 c0 ff ff ff
ff eb 89 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 0b 00 00 00 0f
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 5d 5a 0c 00 f7 d8 64 89 01 48
[167169.238081] RSP: 002b:00007fe9bb2e0808 EFLAGS: 00000206 ORIG_RAX:
000000000000000b
[167169.238082] RAX: ffffffffffffffda RBX: 00007fe9a4753d50 RCX:
00007fe9d904f3fb
[167169.238083] RDX: 00007fe9cfb907e0 RSI: 000000000009e000 RDI:
00007fe9a9162000
[167169.238084] RBP: 00007fe9a01feba0 R08: 00007fe9bd36e0b0 R09:
00007fe9bd36e0b0
[167169.238085] R10: 0000000000000000 R11: 0000000000000206 R12:
00007fe9a4753d30
[167169.238086] R13: 00007fe9bb2e0900 R14: 00007fe9d697b1a0 R15:
0000000000000002



Udo
