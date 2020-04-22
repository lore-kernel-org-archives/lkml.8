Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D096EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:11:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC30820767
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 19:11:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY8jDXYK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726343AbgDVTLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 15:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725913AbgDVTLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 15:11:21 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06763C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:11:21 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id u189so3097985ilc.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Ut85GakqMmW46eXHzFMTltX4Z5rhoReL+qfSZEo9ZsA=;
        b=kY8jDXYKvCTDvfmVkwNrK+PCDTYEWoiaPuh1ZYAgiDYRlCat2zr0e8mn7jdxSviIRv
         m5OuamiNmfdx6pIXfW3uRRWTExR0xBJm2v+4DopXKqVtG+BlmZI4KJ1cFZOhkPI+K+BE
         yOGkpKLFvTI8KoXtNrcEG2XlnfjVroXoABSfHwbq4zhmxg/PG2iJXt9iS1LiCSaUQQHQ
         8qfMWm6gWWagQ92ADOxpT2EaFkO0jOczqRikMZ6jOMHFYkrPngfqskfAAXa115rpmDHr
         uV/wVAb1FzQhHp9puZv79fehJ7Me3RePPlmqZSMq3XkrVx4FD/09EuMYr2P7wsAdDkN4
         x0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Ut85GakqMmW46eXHzFMTltX4Z5rhoReL+qfSZEo9ZsA=;
        b=qMxgl1Nz5AFm56O+HEcGoEZ6QRmC89rVE3DS1VB9v4AeRFvZgHn7Bd0eLjtVWjNddQ
         BAyVSAVPjDQUP4thBcUQPROYErKYhdzlhlrS+/Td7QW1qmWAZxwk1SwoKvFfb79Ti3xu
         3TUkZjeKfmW0AtVVVzJ809sei6flkdCLdVw832kguQzsEtDQLcaRtyYnobaGKsAe967S
         WhJR1cbsPXC8KqAd+NwOuauLeITMLKOJRwubNXjHFahX5U3QBaTJDkTBHaJwPgB32CKk
         G6jSEVCkJGMWwsJfv2RuKnB9FQ3tQUwVgsquT6wHdwFouoaFLofnNSHITehPYRA9chIn
         oB+Q==
X-Gm-Message-State: AGi0PuaPtHjnHCPVCqaF0yu4TWJO/1ebDbZ3abkkK4Ie1KIuaxbLsQwO
        /A8pd06/S58aZefCMBsE9KW6w5A9F0L9osS6AKaeub7JATY=
X-Google-Smtp-Source: APiQypIoA4/YsJrsK3wgVq6XZFIDDOsqC3wjY1zO5dMFKlQmiZDvvQ11iKFbUIQVsO2QltotDxTvZVE/0qu7V7MUxYQ=
X-Received: by 2002:a92:4086:: with SMTP id d6mr6810854ill.91.1587582679894;
 Wed, 22 Apr 2020 12:11:19 -0700 (PDT)
MIME-Version: 1.0
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Thu, 23 Apr 2020 00:11:09 +0500
Message-ID: <CABXGCsMGcb=nO-76=q2w+Oz3UcTcTKqvRy-=Y=NGB4sCH4ZHFg@mail.gmail.com>
Subject: 5.7RC1 BUG: kernel NULL pointer dereference, address:
 00000000000007a0 [mod_zone_page_state+0x5/0x70]
To:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Today I caught another Oops: 0000 [#1] SMP NOPTI BUG.
It happened two minutes later after gnome-shell run out of memory and crashes.
(gnome-shell[931475]: JS ERROR: out of memory)
so it not surprised to me because I use
vm.overcommit_memory = 2 and  vm.overcommit_ratio = 100
and today it happened the second time.
What really surprised it (BUG: kernel NULL pointer dereference,
address: 00000000000007a0) message in the kernel log.
I have not expected it so I am here and write bug report.
Maybe someone already encountered such Oops or it something new?

BUG: kernel NULL pointer dereference, address: 00000000000007a0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] SMP NOPTI
CPU: 5 PID: 2118304 Comm: kworker/5:0 Tainted: G        W
--------- ---  5.7.0-0.rc1.20200416git9786cab67457.1.2.fc33.x86_64 #1
Hardware name: System manufacturer System Product Name/ROG STRIX
X570-I GAMING, BIOS 1405 11/19/2019
Workqueue:  0x0 (events)
RIP: 0010:mod_zone_page_state+0x5/0x70
Code: 04 f5 80 07 a1 b0 65 44 88 09 c3 48 c7 c6 e8 13 38 b0 e8 2e 45
01 00 0f 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 0f 1f 44 00 00 <4c> 8b
57 60 41 89 f3 49 89 f9 49 89 d0 4b 8d 4c 1a 4f 65 41 8a 42
RSP: 0018:ffffb6e5604d7df0 EFLAGS: 00010202
RAX: 0000000000000333 RBX: 0000000000000008 RCX: 0000000000000000
RDX: fffffffffffffffc RSI: 0000000000000009 RDI: 0000000000000740
RBP: fffffffffffffffc R08: ffff9330ddf37840 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff932bab905000
R13: ffff932d6e780000 R14: 0000000000000000 R15: 0000000000000080
FS:  0000000000000000(0000) GS:ffff93327aa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000178 CR3: 000000003ca12000 CR4: 00000000003406e0
Call Trace:
 account_kernel_stack+0x6e/0x130
 put_task_stack+0x37/0x90
 finish_task_switch+0x236/0x2b0
 __schedule+0x346/0xa30
 schedule+0x5f/0xd0
 worker_thread+0xd2/0x3d0
 ? process_one_work+0x5c0/0x5c0
 kthread+0x131/0x150
 ? __kthread_bind_mask+0x60/0x60
 ret_from_fork+0x27/0x50
Modules linked in: crypto_user overlay netconsole snd_seq_dummy
snd_hrtimer hid_logitech_hidpp hid_logitech_dj uinput rfcomm
xt_CHECKSUM xt_MASQUERADE xt_conntrack ipt_REJECT nf_nat_tftp
nf_conntrack_tftp tun nft_objref nf_conntrack_netbios_ns
nf_conntrack_broadcast nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib
nft_reject_inet nf_reject_ipv4 nf_reject_ipv6 nft_reject nft_ct
nft_chain_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat nf_conntrack nf_defrag_ipv6
nf_defrag_ipv4 libcrc32c iptable_mangle iptable_raw iptable_security
ip_set nf_tables nfnetlink ip6table_filter ip6_tables iptable_filter
cmac bnep sunrpc vfat fat joydev edac_mce_amd kvm_amd gspca_zc3xx
gspca_main kvm irqbypass crct10dif_pclmul crc32_pclmul
ghash_clmulni_intel eeepc_wmi asus_wmi btusb sparse_keymap video btrtl
wmi_bmof btbcm btintel uvcvideo bluetooth videobuf2_vmalloc
videobuf2_memops snd_usb_audio videobuf2_v4l2 videobuf2_common
snd_usbmidi_lib videodev ecdh_generic
 snd_rawmidi ecc mc pcspkr iwlmvm sp5100_tco k10temp i2c_piix4
mac80211 snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio
snd_hda_codec_hdmi libarc4 snd_hda_intel snd_intel_dspcfg iwlwifi
snd_hda_codec snd_hda_core cfg80211 snd_hwdep snd_seq snd_seq_device
snd_pcm rfkill snd_timer snd ccp soundcore acpi_cpufreq binfmt_misc
ip_tables amdgpu amd_iommu_v2 gpu_sched ttm drm_kms_helper drm
crc32c_intel igb nvme nvme_core dca i2c_algo_bit wmi pinctrl_amd
br_netfilter bridge stp llc fuse
CR2: 00000000000007a0
---[ end trace 8d2fde8ea9fbdd7d ]---

Full system log here: https://pastebin.com/D3FveMH5

faddr2line said that it happened somewhere in MM subsystem, but as far
as I know, the culprit may be in a completely different place.

So I politely add mm list please do not swear if this does not apply to you.

$ /usr/src/kernels/`uname -r`/scripts/faddr2line
/lib/debug/lib/modules/5.7.0-0.rc1.20200416git9786cab67457.1.2.fc33.x86_64/vmlinux
mod_zone_page_state+0x5
mod_zone_page_state+0x5/0x70:
mod_zone_state at mm/vmstat.c:483
(inlined by) mod_zone_page_state at mm/vmstat.c:521



--
Best Regards,
Mike Gavrilov.
