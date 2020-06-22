Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C24C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6885720656
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 03:15:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2t/laGm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731093AbgFVDPN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 23:15:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726783AbgFVDPM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 23:15:12 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C64EC061794;
        Sun, 21 Jun 2020 20:15:11 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d21so6630953lfb.6;
        Sun, 21 Jun 2020 20:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Ych9qsXYRdyWSqxacfEEmFrepQ/w/vnS3kTHuzEFOiA=;
        b=J2t/laGm6RBErO7XT/08Vtz6eCSP0E5F0znEcjlnl01WqJfO3CQmf0G9jVRf04P1Fz
         RHUU9hrr4KIiDIzG6Fcrli88122gfEFbOLEcV6lfBagN5367+SGnBk0KmJZ3JLnYHvHw
         5o2PM+9w+o+zHHfCFpsdgIU3zlOcXng5k+3cxsZOhhuAra3X7wREErsqMfbirNz6oegT
         BcwWtoRaO+cTbZn1qMhj6Tgt1AveggEFf7Xjt6sbLU3/Q7BP4aFMQqHpzlwmyetVnUaG
         gXY7241eM2OkYoGtjJ4tCRQ6B5fIWUcJkMfoenkoG5xIkXIu8Xg+Pumtmuinp7U93Zlq
         hDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Ych9qsXYRdyWSqxacfEEmFrepQ/w/vnS3kTHuzEFOiA=;
        b=q1SEW3cmXYIK9XwhVRKpgDs/HxGL/L5ytMbRTHfm1/ikA/tk/pW6Htd45cvh8vlxdB
         R5jfGrhutAZe5gpbxKiTFAm+AAfhxjHsXLzSHMMc4O7BpLYKNk5nomx786giqveGi2cl
         oiXyt0lljIYO/LnnrwJAxGX0DFZvi+sM/0gmfhElRo2cCBVMlY8xgHiqFk+mzTDQLgW1
         k5Aya4BvRkzVIIAoQYGNwteUTbQP0x43HKxkgHHeanUv/R0lAx44Q/auipgVnkcQnZdB
         JydVglUKn9YJ9JIqzelPgC6VWZFE0sfh4DDKv65KeVYR2+zjBTFBeryqOkmStH6LLNjm
         6idA==
X-Gm-Message-State: AOAM531hgYcfM2xjaCdTv4tMP2n23EbvOozVDTpYgfIeVLNLTRUV+74e
        5bjaUABZXx8DnP/xB1AmZJIqohdFnF4xzNSOORbLwdnz
X-Google-Smtp-Source: ABdhPJw7OywllhUghoiimJ+k56wIeR0SenXFaTng87Z9PB6uNsjJIcwWyarl0STO+HmKMYTMRc6xR3B1u/+shC47AeE=
X-Received: by 2002:a19:1d1:: with SMTP id 200mr8666888lfb.57.1592795709495;
 Sun, 21 Jun 2020 20:15:09 -0700 (PDT)
MIME-Version: 1.0
From:   Kyungtae Kim <kt0755@gmail.com>
Date:   Sun, 21 Jun 2020 23:14:58 -0400
Message-ID: <CAEAjamu8BjiCZ+93ptGQmPu9jyHbTu=nHqdbVGW-kw9nFq6SVA@mail.gmail.com>
Subject: WARNING in usb_ep_queue
To:     Felipe Balbi <balbi@kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     USB list <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>,
        Dave Tian <dave.jing.tian@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We report a bug (in linux-5.6.11) found by FuzzUSB (a modified version
of syzkaller)

==================================================================
WARNING: CPU: 0 PID: 4452 at drivers/usb/gadget/udc/core.c:276
usb_ep_queue+0x157/0x3a0 drivers/usb/gadget/udc/core.c:276
Kernel panic - not syncing: panic_on_warn set ...
CPU: 0 PID: 4452 Comm: syz-executor.0 Not tainted 5.6.11 #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Bochs 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xce/0x128 lib/dump_stack.c:118
 panic+0x2de/0x6fa kernel/panic.c:221
 __warn+0x1e1/0x1f6 kernel/panic.c:582
 report_bug+0x208/0x320 lib/bug.c:195
 fixup_bug.part.6+0x37/0x80 arch/x86/kernel/traps.c:174
 fixup_bug arch/x86/kernel/traps.c:261 [inline]
 do_error_trap+0x131/0x170 arch/x86/kernel/traps.c:267
 do_invalid_op+0x36/0x40 arch/x86/kernel/traps.c:286
 invalid_op+0x23/0x30 arch/x86/entry/entry_64.S:1027
RIP: 0010:usb_ep_queue+0x157/0x3a0 drivers/usb/gadget/udc/core.c:276
Code: 48 0f a3 1d 7b c3 12 05 0f 82 2b 01 00 00 e8 e0 0a 8c fd 44 89
e8 48 83 c4 08 5b 41 5c 41 5d 41 5e 41 5f 5d c3 e8 c9 0a 8c fd <0f> 0b
41 bd 94 ff ff ff eb 96 e8 ba 0a 8c fd 65 44 8b 25 a2 da 4a
RSP: 0018:ffff888039f37c78 EFLAGS: 00010216
RAX: 0000000000040000 RBX: ffff888065ecc0d8 RCX: ffffffff83b6d8a7
RDX: 00000000000000f1 RSI: ffffc900009b3000 RDI: ffff888065ecc10d
RBP: ffff888039f37ca8 R08: ffffed100a825a17 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000a20 R14: ffff88803e970710 R15: 0000000000000001
 f_hidg_write+0x6a9/0x9e0 drivers/usb/gadget/function/f_hid.c:396
 __vfs_write+0x85/0x110 fs/read_write.c:494
 vfs_write+0x1cd/0x510 fs/read_write.c:558
 ksys_write+0x18a/0x220 fs/read_write.c:611
 __do_sys_write fs/read_write.c:623 [inline]
 __se_sys_write fs/read_write.c:620 [inline]
 __x64_sys_write+0x73/0xb0 fs/read_write.c:620
 do_syscall_64+0x9e/0x510 arch/x86/entry/common.c:294
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x4531a9
Code: ed 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 0f 83 bb 60 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007efd8e783c78 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 00000000004531a9
RDX: 0000000000000001 RSI: 0000000020000080 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00000000004c09c7
R13: 00000000004d8a48 R14: 00007efd8e7846d4 R15: 00000000ffffffff
==================================================================

Thanks,
Kyungtae Kim
