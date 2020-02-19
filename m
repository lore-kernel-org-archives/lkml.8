Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 037D4C34050
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF48A2464E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 08:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wBEHaUaN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726668AbgBSIeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:34:25 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36096 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbgBSIeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 03:34:25 -0500
Received: by mail-qk1-f194.google.com with SMTP id t83so5281569qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 00:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BrEcUMZPTrT7d1g05LGvZTD+j+iks+IRZfoSSrJsAno=;
        b=wBEHaUaNMkZl1d7d2+pnRIZl6ftxi/c9QXNIkQVQs9kaUSkpcGo+fF7Vi031GtrTP2
         9xfy316BmNssZahfqa50ZIkvOf83KBSt+M1FCzJLA3kYfeCmnX39zBeGQuwCS6VuYO/D
         1qDX9GnGMwEkfI81CWm15eUtYl/m237sy4FRe01YazzrV/pR+ygkpII+dZGvvb+5mJi3
         b36lZAnBFv3YNKUOQ56IE/vBYOAY5zDqD5QOqpuc3A5CLLpRMrD87PSG+jLXy8xG1hHL
         F/q2QW3TOmwgIn5kGdB4VdMFKcO+J07yfZ549OTEML81aTNF6JoQnO5dGSSL14Ew4/3+
         Gm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BrEcUMZPTrT7d1g05LGvZTD+j+iks+IRZfoSSrJsAno=;
        b=mZm39s9j5KRYLyYHw2Q/7RnMPAatWCKManp5PTMZDJ1FcvMFkDdNIwYcTt4PBpuoyU
         5TBTu7tNs+KeixmWPMUcx8P5OqoJktHvbVeiO0wqnSb6vO6dAN6msIp0CWElyIuhDNxT
         0ffat78I3bZ7Unr4iWB0Qsr/otDFhqCbyq0RmTiwoAeBj5CAMTRnRhFCyMVSx5F4c0tV
         44gxBWHEixMWpDLpSnUk2QBrZjjR4jdrDJuZ8eF3xjsbxr5cQrbsQOAaqGWOi6JlyFcF
         3tNFI1O+3N//t35EwsqckcbleFrMBL1Q6OFbU5qCVFHFFdBV8gV4sMqj49qWv8GLZlXZ
         SWDQ==
X-Gm-Message-State: APjAAAUe3ZMfB+OpwCB9Eu5U/d7mv/bR8ThNC2V3HXzIZLBXIlj/trYK
        aQU27l1TrDS7Bo5ZzRjqR1wqi39aLqHP1sH0loRurQ==
X-Google-Smtp-Source: APXvYqwehC36qQ69QHQkcQGawhD9GhERSJx7/HzdURAscwGWYR4p/EqE7AuuFtkmN9F/jxfV5qtUjSoUzV4vH4kZNpU=
X-Received: by 2002:a37:5686:: with SMTP id k128mr19072142qkb.8.1582101263392;
 Wed, 19 Feb 2020 00:34:23 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a40746058c784ef3@google.com> <CACT4Y+b=zF2_S-7SOPZqWBZSaxmWWYgjVs6oVEfXn+ARmy6F7A@mail.gmail.com>
In-Reply-To: <CACT4Y+b=zF2_S-7SOPZqWBZSaxmWWYgjVs6oVEfXn+ARmy6F7A@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 19 Feb 2020 09:34:11 +0100
Message-ID: <CACT4Y+bbfvKHM1mg_BDu-iSv6A5xpyD3Z8kW+hhbBZ6nMgyu+A@mail.gmail.com>
Subject: Re: BUG: using smp_processor_id() in preemptible [ADDR] code: syz-executor
To:     Hillf Danton <hdanton@sina.com>, jmaloy@redhat.com
Cc:     syzbot <syzbot+1a68504d96cd17b33a05@syzkaller.appspotmail.com>,
        allison@lohutok.net, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        tipc-discussion@lists.sourceforge.net,
        Ying Xue <ying.xue@windriver.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 9:31 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Sun, Jun 30, 2019 at 7:19 AM Hillf Danton <hdanton@sina.com> wrote:
> >
> >
> > Hello,
> >
> > On Sat, 29 Jun 2019 08:47:06 -0700 (PDT)
> > > syzbot found the following crash on:
> > >
> > > HEAD commit:    ee7dd773 sis900: remove TxIDLE
> > > git tree:       net-next
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17ceb9a9a00000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=7ac9edef4d37e5fb
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=1a68504d96cd17b33a05
> > > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119b2a13a00000
> > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13127bada00000
> > >
> > > The bug was bisected to:
> >
> > Hm... I doubt it is e9c1a793210f ("tipc: add dst_cache support for udp media")
> > based on one of the lines dumped:
> >
> >         >   tipc_udp_xmit.isra.0+0xc4/0xb80 net/tipc/udp_media.c:164
> >
> >
> > And getting the local bottom half disabled looks like a teaspoon of
> > cough syrup.
> > ---
> >
> > --- a/net/tipc/udp_media.c
> > +++ b/net/tipc/udp_media.c
> > @@ -224,6 +224,8 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
> >         struct udp_bearer *ub;
> >         int err = 0;
> >
> > +       local_bh_disable();
> > +
> >         if (skb_headroom(skb) < UDP_MIN_HEADROOM) {
> >                 err = pskb_expand_head(skb, UDP_MIN_HEADROOM, 0, GFP_ATOMIC);
> >                 if (err)
> > @@ -237,9 +239,12 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
> >                 goto out;
> >         }
> >
> > -       if (addr->broadcast != TIPC_REPLICAST_SUPPORT)
> > -               return tipc_udp_xmit(net, skb, ub, src, dst,
> > +       if (addr->broadcast != TIPC_REPLICAST_SUPPORT) {
> > +               err = tipc_udp_xmit(net, skb, ub, src, dst,
> >                                      &ub->rcast.dst_cache);
> > +               local_bh_enable();
> > +               return err;
> > +       }
> >
> >         /* Replicast, send an skb to each configured IP address */
> >         list_for_each_entry_rcu(rcast, &ub->rcast.list, list) {
> > @@ -259,6 +264,7 @@ static int tipc_udp_send_msg(struct net *net, struct sk_buff *skb,
> >         err = 0;
> >  out:
> >         kfree_skb(skb);
> > +       local_bh_enable();
> >         return err;
> >  }
> >
> > --
> >
> > > commit 52dfae5c85a4c1078e9f1d5e8947d4a25f73dd81
> > > Author: Jon Maloy <jon.maloy@ericsson.com>
> > > Date:   Thu Mar 22 19:42:52 2018 +0000
> > >
> > >      tipc: obtain node identity from interface by default
>
> What is the fate of this fix?
> There is also another fix for this pending for half a year as far as I can tell.
>
> This is one of the top crashes and it prevents most other kernel
> testing from happening.  All kernels just crash on this right away.

/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\/\

+jmaloy new email address


> > > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=160ad903a00000
> > > final crash:    https://syzkaller.appspot.com/x/report.txt?x=150ad903a00000
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=110ad903a00000
> > >
> > > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > > Reported-by: syzbot+1a68504d96cd17b33a05@syzkaller.appspotmail.com
> > > Fixes: 52dfae5c85a4 ("tipc: obtain node identity from interface by default")
> > >
> > > Started in network mode
> > > Own node identity 7f000001, cluster identity 4711
> > > New replicast peer: 172.20.20.22
> > > check_preemption_disabled: 3 callbacks suppressed
> > > BUG: using smp_processor_id() in preemptible [00000000] code:
> > > syz-executor834/8612
> > > caller is dst_cache_get+0x3d/0xb0 net/core/dst_cache.c:68
> > > CPU: 0 PID: 8612 Comm: syz-executor834 Not tainted 5.2.0-rc6+ #48
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> > > Google 01/01/2011
> > > Call Trace:
> > >   __dump_stack lib/dump_stack.c:77 [inline]
> > >   dump_stack+0x172/0x1f0 lib/dump_stack.c:113
> > >   check_preemption_disabled lib/smp_processor_id.c:47 [inline]
> > >   debug_smp_processor_id+0x251/0x280 lib/smp_processor_id.c:57
> > >   dst_cache_get+0x3d/0xb0 net/core/dst_cache.c:68
> > >   tipc_udp_xmit.isra.0+0xc4/0xb80 net/tipc/udp_media.c:164
> > >   tipc_udp_send_msg+0x29a/0x4b0 net/tipc/udp_media.c:254
> > >   tipc_bearer_xmit_skb+0x16c/0x360 net/tipc/bearer.c:503
> > >   tipc_enable_bearer+0xabe/0xd20 net/tipc/bearer.c:328
> > >   __tipc_nl_bearer_enable+0x2de/0x3a0 net/tipc/bearer.c:899
> > >   tipc_nl_bearer_enable+0x23/0x40 net/tipc/bearer.c:907
> > >   genl_family_rcv_msg+0x74b/0xf90 net/netlink/genetlink.c:629
> > >   genl_rcv_msg+0xca/0x16c net/netlink/genetlink.c:654
> > >   netlink_rcv_skb+0x177/0x450 net/netlink/af_netlink.c:2477
> > >   genl_rcv+0x29/0x40 net/netlink/genetlink.c:665
> > >   netlink_unicast_kernel net/netlink/af_netlink.c:1302 [inline]
> > >   netlink_unicast+0x531/0x710 net/netlink/af_netlink.c:1328
> > >   netlink_sendmsg+0x8ae/0xd70 net/netlink/af_netlink.c:1917
> > >   sock_sendmsg_nosec net/socket.c:646 [inline]
> > >   sock_sendmsg+0xd7/0x130 net/socket.c:665
> > >   ___sys_sendmsg+0x803/0x920 net/socket.c:2286
> > >   __sys_sendmsg+0x105/0x1d0 net/socket.c:2324
> > >   __do_sys_sendmsg net/socket.c:2333 [inline]
> > >   __se_sys_sendmsg net/socket.c:2331 [inline]
> > >   __x64_sys_sendmsg+0x78/0xb0 net/socket.c:2331
> > >   do_syscall_64+0xfd/0x680 arch/x86/entry/common.c:301
> > >   entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > > RIP: 0033:0x444679
> > > Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7
> > > 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff
> > > ff 0f 83 1b d8 fb ff c3 66 2e 0f 1f 84 00 00 00 00
> > > RSP: 002b:00007fff0201a8b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> > > RAX: ffffffffffffffda RBX: 00000000004002e0 RCX: 0000000000444679
> > > RDX: 0000000000000000 RSI: 0000000020000580 RDI: 0000000000000003
> > > RBP: 00000000006cf018 R08: 0000000000000001 R09: 00000000004002e0
> > > R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000402320
> > > R13: 00000000004023b0 R14: 0000000000000000 R15: 0000000000
> > >
> > >
> > > ---
> > > This bug is generated by a bot. It may contain errors.
> > > See https://goo.gl/tpsmEJ for more information about syzbot.
> > > syzbot engineers can be reached at syzkaller@googlegroups.com.
> > >
> > > syzbot will keep track of this bug report. See:
> > > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> > > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> > > syzbot can test patches for this bug, for details see:
> > > https://goo.gl/tpsmEJ#testing-patches
> > >
> >
> >
> > --
> > You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000a40746058c784ef3%40google.com.
> > For more options, visit https://groups.google.com/d/optout.
