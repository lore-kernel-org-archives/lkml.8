Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0652AC3567B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD2732080D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JdwcqiGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgBXKwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:52:46 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:35645 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbgBXKwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:52:46 -0500
Received: by mail-lj1-f176.google.com with SMTP id q8so9553634ljb.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 02:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zg2WJRlJF7lQZjckaa918FBkC8FwNDD55Z0L/Cf2LyE=;
        b=JdwcqiGCRNerkZv2Lq6cWfQFSlse6vnRnV/dHTOZJq/BLbhm00v88klavMJbWum9ri
         U2qpb4d9W1y5DE/mTjlz2g3JU5LnovrAyVrv8yur/ayYT/dLq70JA5pumXBNJOnr7kny
         ld5ED0XMKS3imb/zak8eF5Jf/DRGqlsxz1XuesD4Jyddr2/7HgvL66kthKsA+uKocAOO
         MUioKpf0F64YbxGVixoARX/Og9L7jjoZbucP8kMiD6hNX+aC/eAOtWFTOypZd46NzvM4
         nK7igAJV0cYSg3TsBtWLrvDjwq9O0AFx9fK/zvf+8QnrQZ5UGJF7I3jcabF3JUQUxsKt
         SKBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=zg2WJRlJF7lQZjckaa918FBkC8FwNDD55Z0L/Cf2LyE=;
        b=Kyp/5DUCBwc5DUbB0VEhAg60lqzi6hO9qP5g+a/b2baJy6y6FZlSBZqnD959chLN7T
         Su5fH9cf1RxuHzN9Ht6NqfriWX9shLELQmzDIqvzEOgAE6u0LNhn4MZdjIokJVTEWAiT
         lIfNuW+3eBHZapdsajp8n+FPS2KV8Whh2y/k7mGRzxAMXzhfnyxPiOoLmNIDkHFTGnmy
         UXMqfAxb8B+oiHCPxqt75nFKxgmLRyAj/4mMxfXaoF/G75qUgic/B7sRw78QWrymPOK6
         irrrpJl+bz6IWTUJaU7JJaJtb2wusbQqNH7YGiHMAo5OYGEe5nYk1ME/vKQdGrCJpUDZ
         76LA==
X-Gm-Message-State: APjAAAVDgGVBf24+K805eScIWVD/jYLvRtNKiIkzNND7Myu1FE3clNyH
        jesMt/BPTnrbRIhvvJLx6fISu83wmSmLnOOa7Hi9
X-Google-Smtp-Source: APXvYqytGQ/Z8B8a5mzI/6s0Qdr5xL/mTQE9asc7Vv97OVXi/Mu/8MimOFkMUZBJvbVtRXgESUbFvW2zxFwLNy3BnxM=
X-Received: by 2002:a2e:7818:: with SMTP id t24mr29371830ljc.195.1582541563954;
 Mon, 24 Feb 2020 02:52:43 -0800 (PST)
MIME-Version: 1.0
From:   =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Date:   Mon, 24 Feb 2020 11:52:32 +0100
Message-ID: <CADDKRnBq6oFFfVzqDRwwx2Eoc74M7f_9Z7UCdSVmS_xGMD1wdQ@mail.gmail.com>
Subject: i915 GPU-hang regression in v5.6-rcx
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Airlie <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In v5.6-rcx I sporadically see a hanging GPU.

[  640.919302] i915 0000:00:02.0: Resetting chip for stopped heartbeat on r=
cs0
[  641.021808] i915 0000:00:02.0: Xorg[722] context reset due to GPU hang

[ 2229.764709] i915 0000:00:02.0: Resetting chip for stopped heartbeat on r=
cs0
[ 2229.867534] i915 0000:00:02.0: kwin_x11[1005] context reset due to GPU h=
ang

To recover Xorg must be killed and restarted or reboot is required.
I've never seen this before v5.6-rcx.

Best way to reproduce seem to be "heavily scrolling with the mouse wheel"
in graphic applications. I also saw this once while video streaming in
a browser.


System:  Host: fichte Kernel: 5.6.0-rc1 x86_64 bits: 64 Console: tty 3
Distro: Ubuntu 18.04.3 LTS
Machine: Device: Notebook System: FUJITSU product: LIFEBOOK A544
serial: <filter>
         Mobo: FUJITSU model: FJNBB35 serial: <filter>
         BIOS: FUJITSU // Phoenix v: Version 1.17 rv 1.17 date: 05/09/2014
CPU:     Dual core Intel Core i5-4200M (-MT-MCP-) cache: 3072 KB
         clock speeds: max: 3100 MHz 1: 1127 MHz 2: 964 MHz 3: 1034
MHz 4: 984 MHz
Graphics:Card: Intel 4th Gen Core Processor Integrated Graphics Controller
         Display Server: X.Org 1.19.6 drivers: modesetting (unloaded:
fbdev,vesa) Resolution: 1366x768@60.00hz
         OpenGL: renderer: Mesa DRI Intel Haswell Mobile version: 4.5
Mesa 19.2.8


Thanks, J=C3=B6rg
