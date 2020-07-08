Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3C7C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A378206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 17:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLYC/3Eb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgGHRqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 13:46:40 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35647 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728542AbgGHRq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:46:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594230386;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZkaID9R3Jhc4tsMAVwPHjs/XB1tI9aBrCq6liU7gBk8=;
        b=BLYC/3Eb16X7K9CIRnllLaqetTQUAwzdaUPt5DdqqwP2K1gdKZ7x+eESrt3OWbeBGQdHib
        Bttckp5dRgk2tX93DYDNos6xLVCZanlLAKYIB+N3sYZZzjtRgZRLxykuOkLGWwYZJ9vSfM
        wUEW4j89upD216S5Gny8ImQ1ztYL/MQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-E69th0-vNwSGo19tI00IWQ-1; Wed, 08 Jul 2020 13:46:18 -0400
X-MC-Unique: E69th0-vNwSGo19tI00IWQ-1
Received: by mail-oi1-f200.google.com with SMTP id x7so23657872oif.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 10:46:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZkaID9R3Jhc4tsMAVwPHjs/XB1tI9aBrCq6liU7gBk8=;
        b=XuO/BvqDnUKYZTv5Jswo1/UA7+UleItRg4ZNUFhFt/sR/MW0efST/QmzxepMqZAbgt
         2OJuQpwgzhWVX6XxuWIRAoG3XMjL56lqNTGXAQSxt4l1XnayEgYbsTTRVT9NUbC5wgu1
         IDVK7DQ2uYZfGxroiD+oxmvjBxZExkMVrdfzTB6j7MFs+3PEy+c9mWv8EcD86UTKOoJE
         StEjga8YDOnmziZpGyD0bjRM4wSj5448hkv8owto7q3j6PZKz847oL95TLPgZ+jjs4fg
         ILeSIowNPtlYKseHviWqBPZBeR7ZUXxJGkNA2ZvGeR+mPi+5hYXBOHnVmhTVKbweDLvb
         JocA==
X-Gm-Message-State: AOAM530d3vqE8FvlSn4nzdUjLpaJhiYO77dtfoXsMo1rJC0uEns0FnAP
        oDyrhcghhcAJoIkrQICsYWHBdwvmFb4xVQ1rDApJ1uiuieii56IC0x5sVsVD91CZQg8UOMicP02
        q/WxKpGRWvAuO5dBlM9nQnaIUhbIF48W/oOm4Bkk/
X-Received: by 2002:aca:ecc7:: with SMTP id k190mr7845684oih.92.1594230377648;
        Wed, 08 Jul 2020 10:46:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzBvnBE7vG7SYjJlNlw8BxUfO77iK66DtTfRnuh/WddAXOJxgxj9SwafZ44RoN1GuiRH4m4WrcdoV7b09jm+5A=
X-Received: by 2002:aca:ecc7:: with SMTP id k190mr7845656oih.92.1594230377328;
 Wed, 08 Jul 2020 10:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000b164d505a9c7b802@google.com>
In-Reply-To: <000000000000b164d505a9c7b802@google.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Wed, 8 Jul 2020 13:46:06 -0400
Message-ID: <CAKfmpSdmC1QEmht7BbrDM5FMqyZfwxJXTTt+OJB3qyy5bzucTA@mail.gmail.com>
Subject: Re: WARNING: suspicious RCU usage in bond_ipsec_add_sa
To:     syzbot <syzbot+582c98032903dcc04816@syzkaller.appspotmail.com>
Cc:     Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>, j.vosburgh@gmail.com,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, syzkaller-bugs@googlegroups.com,
        Veaceslav Falico <vfalico@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 11:44 AM syzbot
<syzbot+582c98032903dcc04816@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    e44f65fd xen-netfront: remove redundant assignment to vari..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=16148f87100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=829871134ca5e230
> dashboard link: https://syzkaller.appspot.com/bug?extid=582c98032903dcc04816
> compiler:       gcc (GCC) 10.1.0-syz 20200507
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+582c98032903dcc04816@syzkaller.appspotmail.com
>
> =============================
> WARNING: suspicious RCU usage
> 5.8.0-rc2-syzkaller #0 Not tainted
> -----------------------------
> drivers/net/bonding/bond_main.c:387 suspicious rcu_dereference_protected() usage!

Hm. Access to curr_active_slave in the bonding driver is kind of all
over the place, between rtnl_dereference, rcu_deference,
rcu_access_pointer and just reading it without any protections. It
does look like this is a case where bond_ipsec_add_sa() gets called
without RTNL being held, so perhaps we should be using rcu_dereference
here, since we do need to dereference the acquired pointer, but
probably don't need to be holding RTNL here.


> other info that might help us debug this:
>
>
> rcu_scheduler_active = 2, debug_locks = 1
> 1 lock held by syz-executor.0/5186:
>  #0: ffff888089791a28 (&net->xfrm.xfrm_cfg_mutex){+.+.}-{3:3}, at: xfrm_netlink_rcv+0x5c/0x90 net/xfrm/xfrm_user.c:2687
>
> stack backtrace:
> CPU: 1 PID: 5186 Comm: syz-executor.0 Not tainted 5.8.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x18f/0x20d lib/dump_stack.c:118
>  bond_ipsec_add_sa+0x1c8/0x220 drivers/net/bonding/bond_main.c:387
>  xfrm_dev_state_add+0x2da/0x7b0 net/xfrm/xfrm_device.c:268
>  xfrm_state_construct net/xfrm/xfrm_user.c:655 [inline]
>  xfrm_add_sa+0x2166/0x34f0 net/xfrm/xfrm_user.c:684
>  xfrm_user_rcv_msg+0x414/0x700 net/xfrm/xfrm_user.c:2680
>  netlink_rcv_skb+0x15a/0x430 net/netlink/af_netlink.c:2469
>  xfrm_netlink_rcv+0x6b/0x90 net/xfrm/xfrm_user.c:2688
>  netlink_unicast_kernel net/netlink/af_netlink.c:1303 [inline]
>  netlink_unicast+0x533/0x7d0 net/netlink/af_netlink.c:1329
>  netlink_sendmsg+0x856/0xd90 net/netlink/af_netlink.c:1918
>  sock_sendmsg_nosec net/socket.c:652 [inline]
>  sock_sendmsg+0xcf/0x120 net/socket.c:672
>  ____sys_sendmsg+0x6e8/0x810 net/socket.c:2352
>  ___sys_sendmsg+0xf3/0x170 net/socket.c:2406
>  __sys_sendmsg+0xe5/0x1b0 net/socket.c:2439
>  do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
>  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> RIP: 0033:0x45cb29
> Code: Bad RIP value.
> RSP: 002b:00007ff7e9a92c78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00000000005027e0 RCX: 000000000045cb29
> RDX: 0000000000000000 RSI: 0000000020000180 RDI: 0000000000000003
> RBP: 000000000078bf00 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00000000ffffffff
> R13: 0000000000000a45 R14: 00000000004cd2c9 R15: 00007ff7e9a936d4
> bond0: (slave bond_slave_0): Slave does not support ipsec offload
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>


-- 
Jarod Wilson
jarod@redhat.com

