Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDAE3C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:03:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF22220730
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 13:03:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vAIRMq8S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgBDND0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 08:03:26 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:36769 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727126AbgBDND0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 08:03:26 -0500
Received: by mail-ot1-f65.google.com with SMTP id j20so8542592otq.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 05:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5kwMY+yOcoe9hemHRL4Y06hBc7IAz8tTHyF8xqYySrw=;
        b=vAIRMq8SoUHEI2zcLg6Qytv91Rusr976z0RRPo/o6VAnOW13HGwWguRH8xGdq0cw0z
         yvrRohCP2MtVydNTLQRSJIgM6ZZZflHTwOvTpGxMuuL2P0Ar2EtF+qihMQap9pRMt6GU
         kPwlHKIiiJ6VXG2phr8zGOi3qpafsIDAXK+o0mEudVv6ov9W3E63Czn5EHAdrzj9OWWN
         UpOB51VKBYLb1vCdR5hM/mJe4XlV0puUyQaaJlccAC+4d+XLe8z9gADbuDAelzFEuoNF
         5XroVNWj/G2Ck28XDSJQBD01EJhMLUFWzMSGIbJBipnPW3/bwWyhqjWoyhMIZPuOa9uu
         2qYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5kwMY+yOcoe9hemHRL4Y06hBc7IAz8tTHyF8xqYySrw=;
        b=LYjMNiMnzFFhlWpuDULimr02jqAl5I0LjSbrhtqq79t5ts7MBq/VYRUinv32PSosH7
         5jag5MhYv5gjENXs75h789r7KQJgQbA2fUDKe4oQysbtlfdmxsmLWS/vTWYHpm1pMYfM
         KycNfx3XMFDjWM156MqdKJ4+NMvBYcKL+OUZuWTjt2GbFeZ0oUAB8cqfAq0QWZOSMCjT
         vHDaJybbjUyvAwVY5er6ud3gj4PUjURkZpB5GpJfhyFjs+0yDWHP/JA3qzEjK63/xBSG
         hQKAbGCB+2zvmYRMmZNQBd8Z2q65fAf0ozfSWcx93KtOcOHXt1fxffcyteniyH/dbXdS
         dpMg==
X-Gm-Message-State: APjAAAVpSSEKqZHwd5eLtREPoWiUoG7DFdbYn96lv9iOtPwEg9MvaI20
        C9nZApgkoYzynwQT7U0+/TyihBherFXkaACaiiYPFQ==
X-Google-Smtp-Source: APXvYqyUDEChjDRXpZSB7Ici17ut0o0FeHEcZPweNHQh7TrPef5JWZJJ3GGksPBLGT6NChvfjIm+gcL4NY1dAnPk0kQ=
X-Received: by 2002:a05:6830:22cc:: with SMTP id q12mr22662566otc.110.1580821405204;
 Tue, 04 Feb 2020 05:03:25 -0800 (PST)
MIME-Version: 1.0
References: <0000000000005cad20059db8adba@google.com>
In-Reply-To: <0000000000005cad20059db8adba@google.com>
From:   Jann Horn <jannh@google.com>
Date:   Tue, 4 Feb 2020 14:02:58 +0100
Message-ID: <CAG48ez3tsUWA8tXL7rVMJ+CEpuNmxZrX=RjFhvMcu1SkvXkHDw@mail.gmail.com>
Subject: unbounded recursion through bond_netdev_event notifier? [was: BUG:
 stack guard page was hit in update_stack_state]
To:     syzbot <syzbot+c2fb6f9ddcea95ba49b5@syzkaller.appspotmail.com>,
        Network Development <netdev@vger.kernel.org>,
        Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>
Cc:     Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        kernel list <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 5:43 AM syzbot
<syzbot+c2fb6f9ddcea95ba49b5@syzkaller.appspotmail.com> wrote:
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    b3a60822 Merge branch 'for-v5.6' of git://git.kernel.org:/..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=147ae5f1e00000

In the console output, you can see that this seems to be an unbounded
recursion bug. The stack trace is unreliable, but it looks like the
actual recursion might be something like the following, where a netdev
change triggers the bond_netdev_event notifier, which in turn causes
another netdev change, and so on:

[  734.548523][T28658]  ? netdev_lower_get_next_private+0x85/0xb0
[  734.554632][T28658]  ? bond_compute_features.isra.0+0x56a/0xa80
[inlined bond_slave_netdev_event ?]
[  734.572769][T28658]  ? bond_netdev_event+0x71a/0x950
[  734.577901][T28658]  ? notifier_call_chain+0xc2/0x230
[  734.583113][T28658]  ? raw_notifier_call_chain+0x2e/0x40
[  734.588589][T28658]  ? call_netdevice_notifiers_info+0xba/0x130
[  734.594765][T28658]  ? netdev_update_features+0xc7/0xd0
[  734.600142][T28658]  ? __netdev_update_features+0x13e0/0x13e0
[...]
[  734.617522][T28658]  ? netdev_upper_get_next_dev_rcu+0xac/0x110
[  734.623605][T28658]  ? __netdev_update_features+0x8af/0x13e0
[...]
[  734.649988][T28658]  ? netdev_change_features+0x64/0xb0
[...]


> kernel config:  https://syzkaller.appspot.com/x/.config?x=614e56d86457f3a7

says CONFIG_UNWINDER_FRAME_POINTER=y. Unfortunately, the x86 frame
pointer unwinder apparently can't unwind out of a double fault...
maybe it'd be better to use ORC for syzkaller?

> dashboard link: https://syzkaller.appspot.com/bug?extid=c2fb6f9ddcea95ba49b5
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+c2fb6f9ddcea95ba49b5@syzkaller.appspotmail.com
