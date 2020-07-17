Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A98AC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:46:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5906F20768
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 10:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594982761;
	bh=gzAzZEWZ4zcnTdpvAxvmiBYma0LVGacmwIHpIe9SHpY=;
	h=To:From:Subject:Date:List-ID:From;
	b=11JkgpJ2KRhSngW+vXGofeH7GiUm74ZnI5dcNmOvKrd3apYduHcbKLV4HU7XuZc8L
	 MV/4KNe0IHtanXQhc3Q7SdqAcuCvBV5Grjv1WIh/89CesvHYOkvYyA8vhD86fur2I3
	 sXRBVMzwfSjvO7kr1Q+RbgC/RxRx0dbj/AIMzHlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgGQKp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 06:45:59 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42649 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbgGQKp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 06:45:58 -0400
Received: by mail-ed1-f67.google.com with SMTP id z17so7280672edr.9
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jul 2020 03:45:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=SxFQKimgxEIwUhPX1Be+/21oiM24B74LtbvuOYqc5O4=;
        b=bjXBVP/IT3WhspsPbAMh8B+78uryg4w7QK7p3QftyxBmR/rLiVDtP0hdi0176s1Nkc
         vUvn8t5RLfqOZCa3cjmJHzob0wtZODWCcVuzn3aFQVFK9qG+872440LUguedQ0TykrAS
         g4ty2r9GKpZUXBgtxeNpDs3+4MHRVylQYTx/5gvSfuDsYIShWdOzA7rtDb41SVsQjFdK
         WFGDak1FpjAtHEhlG4cuplGtAGMujWm2BiNa2CSoKpqLBgd1yZqfKFaP4WKWxLAM1T0b
         rlbHRdWFvYqoG3+G4YZ4u0Bc9OuqzI+8vWQRQmL/opwSIPr28ZKq+fycGBG5QQD3rBXW
         tDpQ==
X-Gm-Message-State: AOAM530H9LmoONbX84SmhOl/5ySOFPRKBM5dfYtUha82riiGGwMACFnv
        p7dRv9lcAsBL9IfrXCwf9Vu8UTcu
X-Google-Smtp-Source: ABdhPJzekm9J6wnDJd9WpB8FzZLRYXO06m0WfBIw2m7eJ8cCfduvSJ3vfJOYaz2lSB/bvpy6b1VASA==
X-Received: by 2002:a50:f385:: with SMTP id g5mr8260891edm.347.1594982756108;
        Fri, 17 Jul 2020 03:45:56 -0700 (PDT)
Received: from ?IPv6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id i2sm8126631edk.30.2020.07.17.03.45.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Jul 2020 03:45:55 -0700 (PDT)
To:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From:   Jiri Slaby <jirislaby@kernel.org>
Subject: 5.8-rc*: kernel BUG at kernel/signal.c:1917
Message-ID: <6b253b55-586d-0bc4-9f58-c45c631abc60@kernel.org>
Date:   Fri, 17 Jul 2020 12:45:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

the strace testsuite triggers this on 5.8-rc4 and -rc5 both on x86_64
and i586:
> kernel BUG at kernel/signal.c:1917!
> invalid opcode: 0000 [#1] SMP NOPTI 
> CPU: 7 PID: 18367 Comm: filter-unavaila Not tainted 5.8.0-rc4-3.g2cd7849-default #1 openSUSE Tumbleweed (unreleased)
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.0-59-gc9ba527-rebuilt.opensuse.org 04/01/2014
> RIP: 0010:do_notify_parent+0x239/0x270 
> Code: d1 e8 41 89 c5 41 83 e5 01 48 8b 95 28 05 00 00 45 31 c0 4c 89 f6 44 89 e7 b9 01 00 00 00 e8 ce f2 ff ff e9 5b ff ff ff 0f 0b <0f> 0b 48 39 bf 50 05 00 00 75 17 48 8b 97 c0 05 00 00 48 8d 87 c0
> RSP: 0018:ffffa05400f93d00 EFLAGS: 00010002
> RAX: 0000000000000008 RBX: ffff9024ebb6dd00 RCX: 00000000000102f9
> RDX: 0000000000000000 RSI: 0000000000000011 RDI: ffff9024ebb6dd00
> RBP: ffff9024ebb6dd00 R08: 0000000000000000 R09: 000000000000000d
> R10: 00007f7813000000 R11: ffffc2690721ae80 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000009 R15: 0000000000000000
> FS:  00007f7812ffc700(0000) GS:ffff902537dc0000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f9c246a4a10 CR3: 00000001eba7c000 CR4: 00000000000406e0
> Call Trace:
>  exit_notify+0x1c0/0x1f0 
>  do_exit+0x234/0x430
>  do_group_exit+0x33/0xa0 
>  get_signal+0x171/0x640
>  do_signal+0x2a/0x1c0
>  exit_to_usermode_loop+0x89/0x110
>  __prepare_exit_to_usermode+0x92/0xd0
>  do_syscall_64+0x59/0xd0 
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x7f78149db992
> Code: Bad RIP value.
> RSP: 002b:00007f7812ffbed0 EFLAGS: 00000293 ORIG_RAX: 0000000000000022
> RAX: fffffffffffffdfe RBX: 0000000000000000 RCX: 00007f78149db992
> RDX: 0000000000000001 RSI: 0000558a4e07e033 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 00007f7812ffc700
> R10: 00007f7812ffc9d0 R11: 0000000000000293 R12: 0000000000000000
> R13: 00007ffe4853b4bf R14: 00007ffe4853b4c0 R15: 00007f7812ffc700
> Modules linked in: ata_generic ata_piix qemu_fw_cfg e1000 nls_iso8859_1 nls_cp437 vfat fat virtio_blk virtio_mmio xfs btrfs blake2b_generic xor raid6_pq libcrc32c crc32c_intel reiserfs squashfs fuse dm_snapshot dm_bufio dm_crypt dm_mod binfmt_misc loop sg virtio_rng
> ---[ end trace 364c3385f192fee3 ]---

Any ideas?

thanks,
-- 
js
suse labs
