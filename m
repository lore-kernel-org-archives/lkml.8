Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27B4DC1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 045662051A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 07:44:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCYHoE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 03:44:04 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:45797 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYHoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 03:44:04 -0400
Received: by mail-io1-f72.google.com with SMTP id h76so1286147iof.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 00:44:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gNDY/4UDpTVqa+EmUfktT2GdNAoB4MqoMT+n2q2xnEA=;
        b=OtOzj18xhibEg+iO4LOVjK93mCMuJo2yeAQ12LSzm4IlHMZ5pX34fHjCbwK1o0IsfG
         k1sZDmnkO71dcphZ3pMYx/Wi4qisACqvX7QyuaFT0GLEElSw/ntsj8tiEEIhZpxX3i4X
         BfugZESDYzA/iAEU9sWurSbbkEZmGQmjyr8DQ3Mr8psx6vRXYW4DJkCXyQSBqoAxJPVi
         mdE1DpplpzlF3cQkJvcRvrohuFpsVyy0h/R/4H8vhrQyAFY2Rg2g2+U+6/EcUj6yxLnN
         SUTk3ehwZBIfHFHpbtCEv8Y/dAVdu4HmnwiCOxTOxmHDGQ+l5l5WspIBh7Ra71ek8V4Z
         Tn8w==
X-Gm-Message-State: ANhLgQ3NOEeS4jQarIVB/omBlapw3rSgKn/EqqCZKVZBtbSz1RhqY4PR
        2rrAsLH62GDgJfmYAYnVWWz6cH4afPtxf+DDMy4BNPg9uprh
X-Google-Smtp-Source: ADFU+vuBr+EZqBTQ32wJc4atYKAMwj4v+Mqkla7YUlAYoGt0z26bZnT9J44rCUzLh4uY869UZtxGAlKJiiioaHFFRlgh9dhzUR27
MIME-Version: 1.0
X-Received: by 2002:a02:6016:: with SMTP id i22mr1794989jac.87.1585122243625;
 Wed, 25 Mar 2020 00:44:03 -0700 (PDT)
Date:   Wed, 25 Mar 2020 00:44:03 -0700
In-Reply-To: <CADG63jBvx_NarKZT-+QmMAgdHKoYSQwtd9KO0c6rxkgtF_JnyA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000041cce505a1a9087d@google.com>
Subject: Re: KASAN: slab-out-of-bounds Read in edge_interrupt_callback
From:   syzbot <syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com>
To:     andreyknvl@google.com, anenbupt@gmail.com,
        gregkh@linuxfoundation.org, johan@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger crash:

Reported-and-tested-by: syzbot+37ba33391ad5f3935bbd@syzkaller.appspotmail.com

Tested on:

commit:         e17994d1 usb: core: kcov: collect coverage from usb comple..
git tree:       https://github.com/google/kasan.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5d64370c438bc60
dashboard link: https://syzkaller.appspot.com/bug?extid=37ba33391ad5f3935bbd
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
patch:          https://syzkaller.appspot.com/x/patch.diff?x=165cc813e00000

Note: testing is done by a robot and is best-effort only.
