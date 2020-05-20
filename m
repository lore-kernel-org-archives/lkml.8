Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD62EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB9A8207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 12:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbgETMEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 08:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgETME3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 08:04:29 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C811C061A0E;
        Wed, 20 May 2020 05:04:29 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jbNSR-0007C7-Fx; Wed, 20 May 2020 14:04:23 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D83D3100C99; Wed, 20 May 2020 14:04:22 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+08003d278f04ed0944e0@syzkaller.appspotmail.com>,
        fweisbec@gmail.com, linux-kernel@vger.kernel.org,
        linux-next@vger.kernel.org, mingo@kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com
Subject: Re: linux-next boot error: BUG: Invalid wait context ]
In-Reply-To: <000000000000598a2905a60d50cd@google.com>
References: <000000000000598a2905a60d50cd@google.com>
Date:   Wed, 20 May 2020 14:04:22 +0200
Message-ID: <877dx66ce1.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+08003d278f04ed0944e0@syzkaller.appspotmail.com> writes:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    fb57b1fa Add linux-next specific files for 20200519
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=17c9196e100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2522f758a3588c2d
> dashboard link: https://syzkaller.appspot.com/bug?extid=08003d278f04ed0944e0
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+08003d278f04ed0944e0@syzkaller.appspotmail.com
>
> =============================
> [ BUG: Invalid wait context ]
> 5.7.0-rc6-next-20200519-syzkaller #0 Not tainted
> -----------------------------
> swapper/1/0 is trying to lock:
> ffff8880ae737518 (&pool->lock){..-.}-{3:3}, at: spin_lock include/linux/spinlock.h:353 [inline]
> ffff8880ae737518 (&pool->lock){..-.}-{3:3}, at: __queue_work+0x2bf/0x1350 kernel/workqueue.c:1448

Can you please disable CONFIG_PROVE_RAW_LOCK_NESTING for now?

From the help text:

NOTE:
  There are known nesting problems. So if you enable this option expect
  lockdep splats until these problems have been fully addressed which is
  work in progress. This config switch allows to identify and analyze
  these problems. It will be removed and the check permanentely enabled
  once the main issues have been fixed.

Thanks,

        tglx
