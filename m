Return-Path: <SRS0=OX35=4D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C430C2BA83
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F352081E
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Feb 2020 12:11:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NvvGzCee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgBOML6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Feb 2020 07:11:58 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45258 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbgBOML5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Feb 2020 07:11:57 -0500
Received: by mail-ot1-f67.google.com with SMTP id 59so11747221otp.12
        for <linux-kernel@vger.kernel.org>; Sat, 15 Feb 2020 04:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=WpEG6O+/GmPA3vTltQ1TUBRgR5nxXUpmTsYBS6OGxdw=;
        b=NvvGzCeeaHs4v57RVQ3qvmFMiF2NJhdgyla8a8b/zeJu3WSHva7IbqJJD/5KdHbWAV
         cjzfCaXIlx5pNYIu6CloBRROCD5HMNIAsAuJ3AVmy8ggPkcDwybTheteyxEylG9YOzWK
         wHiLetVQmOwLHRKVxXnvl8p2RVIv1bCGMnh5Qacx6AskF9Mo0Vu7nYfWZ+0cikkvm3fs
         d3ifY85/4oDMibtJwQ3T7BaRpTi/eUXl7DI2jHG7AAwoNJgDrhyUmYxjLcwRhf2y9o4s
         OiPuyrpxoCK6xduQzJ4YMith/iZnCuEnHTaIAWuRcHhP0HZzQ+neB0gH/mlYR5blZqk+
         QBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=WpEG6O+/GmPA3vTltQ1TUBRgR5nxXUpmTsYBS6OGxdw=;
        b=o/gZbktXWI6xhjoxsTRD9d+B7d6FvL2dssiCjkHGJDZd5G9yIUgsQiLM4Ngkqitm4j
         gDDodA0JzaZHX8S1aUmfOMVDMWYMM764sp7K/lEfz2po3gASZPW8cWB6Kzkf+WivLxdm
         y2tVDqfY1XMMuiJ2BKUGPzjQVDhOYGldySKFK5mJs7qaBdudJ9DGFfRpF9ikxkKtYqPu
         pBw5lYkh1IdzCnsuYhatopl6bCJi7+0dMgmaUEBHIHeqw1+VicQyWa+iI5+AprkfzzSp
         WlV9ahn39dhWDr2RQFrwN2/FRqPEVrpywTcECM7qfFdW6OPH7wzQcVmwqDcu0ydAEQ3a
         05pA==
X-Gm-Message-State: APjAAAXQOMrp+oJga4T//TMVKfn7UFMY5ZeHHBDMawPg85Su+fEqHUmN
        msqnUYITJUIyGoMSdR8DGfkIRPFJ5tra0r9KouzOnrcNE3M=
X-Google-Smtp-Source: APXvYqzjeq0bSYO14XBYupPmYuCSD0OKgITmk7bnKYjioWZGVFE8EaD5awIqWBIZNmdF6S14GqxZWBHpkbLHDf5WcKI=
X-Received: by 2002:a9d:d06:: with SMTP id 6mr5963825oti.176.1581768716672;
 Sat, 15 Feb 2020 04:11:56 -0800 (PST)
MIME-Version: 1.0
From:   Juerg Haefliger <juergh@gmail.com>
Date:   Sat, 15 Feb 2020 13:11:45 +0100
Message-ID: <CADLDEKugE-Y9rMumiCDJDW_FvGcBaQd3fBv80YeSS0=udnkMAQ@mail.gmail.com>
Subject: arm64 kernel crash in bochs_get_edid_block() with QEMU '-device VGA'
To:     LKML <linux-kernel@vger.kernel.org>, kraxel@redhat.com,
        virtualization@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QEMU default edid=off results in a kernel crash [1] on arm64 due
to commit [2]. To reproduce:

$ ARCH=arm64 make defconfig
$ ./scripts/config -e DRM -e DRM_BOCHS
$ ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- make olddefconfig Image
$ qemu-system-aarch64 -M virt -cpu cortex-a57 -device VGA -device
virtio-serial-pci -kernel arch/arm64/boot/Image -append
"console=ttyAMA0"

Using '-device VGA,edid=on' instead works just fine.

$ qemu-system-aarch64 -version
QEMU emulator version 4.0.0 (Debian 1:4.0+dfsg-0ubuntu9.2)
Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers

...Juerg

[1]
[    0.740886] Internal error: synchronous external abort: 96000010
[#1] PREEMPT SMP
[    0.741120] Modules linked in:
[    0.741435] CPU: 0 PID: 1 Comm: swapper/0 Not tainted
4.19.0-rc6-01554-g7118072afbf2 #48
[    0.741605] Hardware name: linux,dummy-virt (DT)
[    0.741817] pstate: 80000005 (Nzcv daif -PAN -UAO)
[    0.741945] pc : bochs_get_edid_block+0x20/0x48
[    0.742052] lr : drm_do_get_edid+0x64/0x318
[    0.742148] sp : ffff00000805ba00
[    0.742239] x29: ffff00000805ba00 x28: 0000000000000000
[    0.742381] x27: 0000000000000000 x26: ffff0000092404dc
[    0.742504] x25: ffff80003c0a4590 x24: ffff80003c218680
[    0.742625] x23: ffff80003c0a496c x22: ffff80003c0a4000
[    0.742745] x21: ffff000008653db0 x20: 0000000000000001
[    0.742865] x19: ffff80003c2a3c00 x18: 0000000000000400
[    0.742986] x17: 0000000000000000 x16: 0000000000000000
[    0.743106] x15: 0000000000000400 x14: 0000000000000400
[    0.743226] x13: 0000000000000374 x12: 0000000000000028
[    0.743345] x11: 0000000000000040 x10: ffff80003c0b3ab0
[    0.743482] x9 : 0000000000000000 x8 : ffff80003c538a40
[    0.743605] x7 : 0000000000800004 x6 : 0000000000000000
[    0.743726] x5 : 0000000000000080 x4 : ffff80003c2a3c00
[    0.743846] x3 : 0000000000000080 x2 : 0000000000000000
[    0.743966] x1 : ffff0000097fd000 x0 : ffff80003c0a4000
[    0.744131] Process swapper/0 (pid: 1, stack limit = 0x(____ptrval____))
[    0.744339] Call trace:
[    0.744709]  bochs_get_edid_block+0x20/0x48
[    0.744816]  bochs_hw_load_edid+0x34/0x58
[    0.744917]  bochs_kms_init+0x15c/0x1e0
[    0.745006]  bochs_load+0x84/0xc8
[    0.745086]  drm_dev_register+0x140/0x1d0
[    0.745178]  drm_get_pci_dev+0x9c/0x160
[    0.745266]  bochs_pci_probe+0x70/0x98
[    0.745354]  local_pci_probe+0x3c/0xb0
[    0.745441]  pci_device_probe+0x188/0x1a0
[    0.745532]  really_probe+0x1ec/0x280
[    0.745616]  driver_probe_device+0x54/0xe8
[    0.745709]  __driver_attach+0xe4/0xe8
[    0.745811]  bus_for_each_dev+0x70/0xb8
[    0.745897]  driver_attach+0x20/0x28
[    0.745978]  bus_add_driver+0x1a0/0x210
[    0.746063]  driver_register+0x60/0x110
[    0.746151]  __pci_register_driver+0x40/0x48
[    0.746246]  bochs_init+0x28/0x38
[    0.746325]  do_one_initcall+0x54/0x154
[    0.746413]  kernel_init_freeable+0x18c/0x228
[    0.746511]  kernel_init+0x10/0x100
[    0.746592]  ret_from_fork+0x10/0x18
[    0.746834] Code: cb020024 b4000123 f9400001 8b020021 (08dffc21)
[    0.747380] ---[ end trace 4353104b0caf319a ]---
[    0.747791] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x0000000b
[    0.747791]
[    0.748046] SMP: stopping secondary CPUs
[    0.748338] Kernel Offset: disabled
[    0.748598] CPU features: 0x0,21806082
[    0.748707] Memory Limit: none
[    0.748871] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x0000000b
[    0.748871]  ]---

[2] 01f23459cf93 ("drm/bochs: add edid support.")
