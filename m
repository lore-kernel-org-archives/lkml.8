Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAE1C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22DF720727
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dt06uaq/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgEPMfX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726229AbgEPMfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:35:21 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C05C061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:35:21 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 72so4208132otu.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 May 2020 05:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VCdaa5cTAfwuzCLHW+LybXWQhIMwruNo2CxljO6DLnI=;
        b=dt06uaq/3JxwpIE23kzRFTmcXWCLbRVzbCVAANV5aepfYdgd75iwyaHcd8F7+vjjAy
         fKouD8f+AZzk6ztZKi+glOu1IpxqS3ZlJJFCtwAx2edcNuJcCt7UGqYwmngBokFPS7P0
         hj+9CLOfiO+JWx4KuHOZzuuUx4EEH1Lu150KJAv/Ta2KfyLn2xUtQ3H5Kn2DwQwH1icd
         HBWli2wM+zEiYyHOkmPXquDMwZgA6NsJ2KkJavwCsLhx4AlvxUJdJ0ggzRAu028xppYj
         IPbxO1lDERSe6c90hLfQ9wnb6yOy3MwSBbSi1f+B7tLepdswG288bFwMgstvef5hqe5/
         dLQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=VCdaa5cTAfwuzCLHW+LybXWQhIMwruNo2CxljO6DLnI=;
        b=kwht7Az/tK1I+pMeU3vLO83/lxJR7POcqgRfwBg9uYAj2SfIkRYVgQ/ue5gAfpTWWT
         5JjItNa6Zke4mDxXlH2elPuucBqb6mxqCMWNIvXDYkcLxEOV/TDB0K5Nys89AVX+D1/h
         ZxRyS3nVZkDh9d5R7MM9Y4vyra4bHsyBvZ0VvKlTcD8kLCtHKskp66tmDt/OOn1EEzu3
         XPDgX7I/SQ8I7qMBhUNDQebg4pZj11rEPBxKR21uQXBwReC8RY16MqXQq2Jh3ayxOuHt
         H5FIHltoIOY+x+jsYJmBD7Zg/yXnn55YgMaVn2pSQoke8a2zwk5tn6MbsV+7K3wNNPIP
         tq0w==
X-Gm-Message-State: AOAM530wJXA2tIUHMeYUWgHFxzp8v6icQi2TQWfN/kRXQoVd2bWjG8fz
        n/8StCVZ+7i4xtfiVpQ+YhACrdrjeKpzIu+S0uAvBNeByOA=
X-Google-Smtp-Source: ABdhPJzKziAX3zevk5PGVwEDdLeBNJoEbarGXDLIUR20blOYAWCJ1+PPs+gLUP77v55nE3mGBJ0eEo/0YbDDsjvk+X0=
X-Received: by 2002:a9d:39b6:: with SMTP id y51mr5455690otb.368.1589632520549;
 Sat, 16 May 2020 05:35:20 -0700 (PDT)
MIME-Version: 1.0
From:   Subhashini Rao Beerisetty <subhashbeerisetty@gmail.com>
Date:   Sat, 16 May 2020 18:05:07 +0530
Message-ID: <CAPY=qRQ6gzN1BWh=ianVDBQ1C9kibWHwxs5Z0+QSwGxKymLDTQ@mail.gmail.com>
Subject: general protection fault vs Oops
To:     kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

In my Linux box, I see that kernel crashes for a known test case.

In the first attempt when I run that test case I landed into =E2=80=9Cgener=
al
protection fault: 0000 [#1] SMP" .. Next I rebooted and ran the same
test , but now it resulted the =E2=80=9COops: 0002 [#1] SMP".
In both cases the call trace looks exactly same and RIP points to
=E2=80=9Cnative_queued_spin_lock_slowpath+0xfe/0x170"..

So, can some one clarify me , what are the difference between =E2=80=9Cgene=
ral
protection fault: 0000 [#1] SMP" & =E2=80=9COops: 0002 [#1] SMP". In which
scenario kernel throws =E2=80=9COops: 0002 [#1] SMP" Or =E2=80=9Cgeneral pr=
otection
fault: 0000 [#1] SMP"..


May 16 12:06:17 test-pc kernel: [96934.528114] general protection
fault: 0000 [#1] SMP
May 16 12:06:17 test-pc kernel: [96934.528990] Modules linked in:
dbg(OE) mcore(OE) osa(OE) cfg80211 ppdev intel_rapl intel_soc_dts_iosf
intel_powerclamp coretemp kvm irqbypass punit_atom_debug cdc_acm
mei_txe  mei lpc_ich shpchp parport_pc mac_hid parport tpm_infineon
8250_fintek ib_iser rdma_cm iw_cm ib_cm ib_sa ib_mad ib_core ib_addr
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel i915
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd igb
drm_kms_helper dca syscopyarea ptp sysfillrect sysimgblt pps_core
fb_sys_fops i2c_algo_bit drm ahci libahci fjes video [last unloaded:
osa]
May 16 12:06:17 test-pc kernel: [96934.537343] CPU: 2 PID: 5457 Comm:
multi/complete Tainted: G           OE   4.4.0-66-generic #87-Ubuntu
May 16 12:06:17 test-pc kernel: [96934.538715] Hardware name:
Supermicro Super Server/X10SDV-TLN4F, BIOS 1.0b 09/09/2015
May 16 12:06:17 test-pc kernel: [96934.540146] task: ffff880139d02640
ti: ffff880034fe0000 task.ti: ffff880034fe0000
May 16 12:06:17 test-pc kernel: [96934.541632] RIP:
0010:[<ffffffff810cafee>]  [<ffffffff810cafee>]
native_queued_spin_lock_slowpath+0xfe/0x170
May 16 12:06:17 test-pc kernel: [96934.543224] RSP:
0018:ffff880034fe3e08  EFLAGS: 00010002
May 16 12:06:17 test-pc kernel: [96934.544837] RAX: 0000000000002be1
RBX: 0000000000000082 RCX: 0004b8107b8cc138
May 16 12:06:17 test-pc kernel: [96934.546511] RDX: ffff88013fd17900
RSI: 00000000000c0000 RDI: ffff8800b35fbb88
May 16 12:06:17 test-pc kernel: [96934.548213] RBP: ffff880034fe3e08
R08: 0000000000000101 R09: 0000000180200019
May 16 12:06:17 test-pc kernel: [96934.549949] R10: ffff8800340c9680
R11: 0000000000000001 R12: ffff8800b35fbb88
May 16 12:06:17 test-pc kernel: [96934.551713] R13: 0000000000000246
R14: 0000000000000001 R15: ffff8800340c9d00
May 16 12:06:17 test-pc kernel: [96934.553501] FS:
0000000000000000(0000) GS:ffff88013fd00000(0000)
knlGS:0000000000000000
May 16 12:06:17 test-pc kernel: [96934.555346] CS:  0010 DS: 0000 ES:
0000 CR0: 000000008005003b
May 16 12:06:17 test-pc kernel: [96934.557216] CR2: 00007ffe8614d938
CR3: 00000000b35ef000 CR4: 00000000001006e0
May 16 12:06:17 test-pc kernel: [96934.559146] Stack:
May 16 12:06:17 test-pc kernel: [96934.561081]  ffff880034fe3e20
ffffffff8183c427 ffff8800b35fbb70 ffff880034fe3e50
May 16 12:06:17 test-pc kernel: [96934.563133]  ffffffffc0606812
ffff880035581cc0 ffff8800b1eb5ec8 0000000000000246
May 16 12:06:17 test-pc kernel: [96934.565220]  ffff8800b1eb5ef0
ffff880034fe3e60 ffffffffc06aa2a4 ffff880034fe3ea
May 16 12:06:17 test-pc kernel: [96934.567347] Call Trace:
May 16 12:06:17 test-pc kernel: [96934.569475]  [<ffffffff8183c427>]
_raw_spin_lock_irqsave+0x37/0x40
May 16 12:06:17 test-pc kernel: [96934.571686]  [<ffffffffc0606812>]
event_raise+0x22/0x60 [osa]
May 16 12:06:17 test-pc kernel: [96934.573935]  [<ffffffffc06aa2a4>]
multi_q_completed_one_buffer+0x34/0x40 [mcore]
May 16 12:06:17 test-pc kernel: [96934.576236]  [<ffffffffc06a919e>]
complete_thread+0x7e/0x110 [mcore]
May 16 12:06:17 test-pc kernel: [96934.578567]  [<ffffffffc0606a10>] ?
thread_should_stop+0x10/0x10 [osa]
May 16 12:06:17 test-pc kernel: [96934.580934]  [<ffffffffc0606a26>]
thread_func+0x16/0x50 [osa]
May 16 12:06:17 test-pc kernel: [96934.583326]  [<ffffffffc0606a10>] ?
thread_should_stop+0x10/0x10 [osa]
May 16 12:06:17 test-pc kernel: [96934.585762]  [<ffffffff810a0ba8>]
kthread+0xd8/0xf0
May 16 12:06:17 test-pc kernel: [96934.588219]  [<ffffffff810a0ad0>] ?
kthread_create_on_node+0x1e0/0x1e0
May 16 12:06:17 test-pc kernel: [96934.590724]  [<ffffffff8183c98f>]
ret_from_fork+0x3f/0x70
May 16 12:06:17 test-pc kernel: [96934.593251]  [<ffffffff810a0ad0>] ?
kthread_create_on_node+0x1e0/0x1e0
May 16 12:06:17 test-pc kernel: [96934.595822] Code: 87 47 02 c1 e0 10
85 c0 74 38 48 89 c1 c1 e8 12 48 c1 e9 0c 83 e8 01 83 e1 30 48 98 48
81 c1 00 79 01 00 48 03 0c c5 40 75 f3 81 <48> 89 11 8b 42 08 85 c0 75
0d f3 90 8b 42 08 85 c0 74 f7 eb 02
May 16 12:06:17 test-pc kernel: [96934.601479] RIP
[<ffffffff810cafee>] native_queued_spin_lock_slowpath+0xfe/0x17
May 16 12:06:17 test-pc kernel: [96934.604306]  RSP <ffff880034fe3e08>
May 16 12:06:17 test-pc kernel: [96934.617229] ---[ end trace
0b60bd63d72bdffa ]---





May 16 12:59:22 test-pc kernel: [ 3011.360710] BUG: unable to handle
kernel paging request at 0000000000017900
May 16 12:59:22 test-pc kernel: [ 3011.361623] IP:
[<ffffffff810cafee>] native_queued_spin_lock_slowpath+0xfe/0x170
May 16 12:59:22 test-pc kernel: [ 3011.362547] PGD
May 16 12:59:22 test-pc kernel: [ 3011.363419] Oops: 0002 [#1] SMP
May 16 12:59:22 test-pc kernel: [ 3011.364298] Modules linked in:
dbg(OE) mcore(OE) osa(OE) cfg80211 ppdev intel_rapl intel_soc_dts_iosf
intel_powerclamp coretemp kvm irqbypass punit_atom_debug cdc_acm
mei_txe  mei lpc_ich shpchp parport_pc mac_hid parport tpm_infineon
8250_fintek ib_iser rdma_cm iw_cm ib_cm ib_sa ib_mad ib_core ib_addr
iscsi_tcp libiscsi_tcp libiscsi scsi_transport_iscsi autofs4 btrfs
raid10 raid456 async_raid6_recov async_memcpy async_pq async_xor
async_tx xor raid6_pq libcrc32c raid1 raid0 multipath linear
crct10dif_pclmul crc32_pclmul ghash_clmulni_intel aesni_intel i915
aes_x86_64 lrw gf128mul glue_helper ablk_helper cryptd igb
drm_kms_helper dca syscopyarea ptp sysfillrect sysimgblt pps_core
fb_sys_fops i2c_algo_bit drm ahci libahci fjes video [last unloaded:
osa]
May 16 12:59:22 test-pc kernel: [ 3011.373097] CPU: 1 PID: 4103 Comm:
multi/complete Tainted: G           OE   4.4.0-66-generic #87-Ubunt
May 16 12:59:22 test-pc kernel: [ 3011.374622] Hardware name:
Supermicro Super Server/X10SDV-TLN4F, BIOS 1.0b 09/09/2015
May 16 12:59:22 test-pc kernel: [ 3011.376203] task: ffff8800b3b972c0
ti: ffff8800b1cb0000 task.ti: ffff8800b1cb0000
May 16 12:59:22 test-pc kernel: [ 3011.377825] RIP:
0010:[<ffffffff810cafee>]  [<ffffffff810cafee>]
native_queued_spin_lock_slowpath+0xfe/0x170
May 16 12:59:22 test-pc kernel: [ 3011.379575] RSP:
0018:ffff8800b1cb3e08  EFLAGS: 00010006
May 16 12:59:22 test-pc kernel: [ 3011.381324] RAX: 0000000000000e8c
RBX: 0000000000000082 RCX: 000000000001790
May 16 12:59:22 test-pc kernel: [ 3011.383141] RDX: ffff88013fc97900
RSI: 0000000000080000 RDI: ffff88013a347b88
May 16 12:59:22 test-pc kernel: [ 3011.384997] RBP: ffff8800b1cb3e08
R08: 0000000000000101 R09: 0000000180200003
May 16 12:59:22 test-pc kernel: [ 3011.386878] R10: ffff880034fb4580
R11: 0000000000000001 R12: ffff88013a347b88
May 16 12:59:22 test-pc kernel: [ 3011.388792] R13: 0000000000000246
R14: 0000000000000001 R15: ffff880034fb4100
May 16 12:59:22 test-pc kernel: [ 3011.390726] FS:
0000000000000000(0000) GS:ffff88013fc80000(0000)
knlGS:0000000000000000
May 16 12:59:22 test-pc kernel: [ 3011.392722] CS:  0010 DS: 0000 ES:
0000 CR0: 000000008005003b
May 16 12:59:22 test-pc kernel: [ 3011.394738] CR2: 0000000000017900
CR3: 0000000001e0a000 CR4: 00000000001006e0
May 16 12:59:22 test-pc kernel: [ 3011.396819] Stack:
May 16 12:59:22 test-pc kernel: [ 3011.398896]  ffff8800b1cb3e20
ffffffff8183c427 ffff88013a347b70 ffff8800b1cb3e50
May 16 12:59:22 test-pc kernel: [ 3011.401093]  ffffffffc0604812
ffff8800b49f46c0 ffff880034a238c8 0000000000000246
May 16 12:59:22 test-pc kernel: [ 3011.403327]  ffff880034a238f0
ffff8800b1cb3e60 ffffffffc06b72a4 ffff8800b1cb3ea8
May 16 12:59:22 test-pc kernel: [ 3011.405602] Call Trace:
May 16 12:59:22 test-pc kernel: [ 3011.407892]  [<ffffffff8183c427>]
_raw_spin_lock_irqsave+0x37/0x40
May 16 12:59:22 test-pc kernel: [ 3011.410256]  [<ffffffffc0604812>]
event_raise+0x22/0x60 [osa]
May 16 12:59:22 test-pc kernel: [ 3011.412652]  [<ffffffffc06b72a4>]
multi_q_completed_one_buffer+0x34/0x40 [mcore]
May 16 12:59:22 test-pc kernel: [ 3011.415103]  [<ffffffffc06b619e>]
complete_thread+0x7e/0x110 [mcore]
May 16 12:59:22 test-pc kernel: [ 3011.417584]  [<ffffffffc0604a10>] ?
thread_should_stop+0x10/0x10 [osa]
May 16 12:59:22 test-pc kernel: [ 3011.420113]  [<ffffffffc0604a26>]
thread_func+0x16/0x50 [osa
May 16 12:59:22 test-pc kernel: [ 3011.422654]  [<ffffffffc0604a10>] ?
thread_should_stop+0x10/0x10 [osa]
May 16 12:59:22 test-pc kernel: [ 3011.425241]  [<ffffffff810a0ba8>]
kthread+0xd8/0xf0
May 16 12:59:22 test-pc kernel: [ 3011.427857]  [<ffffffff810a0ad0>] ?
kthread_create_on_node+0x1e0/0x1e0
May 16 12:59:22 test-pc kernel: [ 3011.430511]  [<ffffffff8183c98f>]
ret_from_fork+0x3f/0x70
May 16 12:59:22 test-pc kernel: [ 3011.433185]  [<ffffffff810a0ad0>] ?
kthread_create_on_node+0x1e0/0x1e0
May 16 12:59:22 test-pc kernel: [ 3011.435915] Code: 87 47 02 c1 e0 10
85 c0 74 38 48 89 c1 c1 e8 12 48 c1 e9 0c 83 e8 01 83 e1 30 48 98 48
81 c1 00 79 01 00 48 03 0c c5 40 75 f3 81 <48>
89 11 8b 42 08 85 c0 75 0d f3 90 8b 42 08 85 c0 74 f7 eb 02
May 16 12:59:22 test-pc kernel: [ 3011.441870] RIP
[<ffffffff810cafee>] native_queued_spin_lock_slowpath+0xfe/0x170
May 16 12:59:22 test-pc kernel: [ 3011.444858]  RSP <ffff8800b1cb3e08>
May 16 12:59:22 test-pc kernel: [ 3011.447817] CR2: 000000000001790
May 16 12:59:22 test-pc kernel: [ 3011.460906] ---[ end trace
0337c6fc94b1cb3d ]---

Thanks
