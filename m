Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F32EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7BD2070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 19:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GOi3sgux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728262AbgCSTaJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 15:30:09 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:26314 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727192AbgCSTaJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 15:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584646207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n7cgCt123/9s5EdM3uN46GsE87oxih4QTqJ6fbmKrSc=;
        b=GOi3sguxlo61/vamcpAXYeAQVTvCBmtqq18xSMBcf9NhjslU5/ekjXxpN8Q/W6Njt9fit5
        CNiA6hX+ZsgvooqwJJnwSUdovgnJAdwou1kFHIYWb8C6AkCI+JyQmDtERP9wcjp4tKRpSk
        dv5yaiLxhkoGU/Lyna/rP6cOxlUvyKM=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-156-D0wIaiu-M96WflHPkixSwg-1; Thu, 19 Mar 2020 15:30:04 -0400
X-MC-Unique: D0wIaiu-M96WflHPkixSwg-1
Received: by mail-io1-f70.google.com with SMTP id s66so2690033iod.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 12:30:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=n7cgCt123/9s5EdM3uN46GsE87oxih4QTqJ6fbmKrSc=;
        b=fDqWTpVMuxpUjYUYZbKx4eDEQU2rOJZr1n807fm13U0cRHyrMG/4QJeGcVtMK0ySI7
         Q0zwXIxIl9FjwGFEj5O2wDxs+MhEueJqH83Ay33JPp59qAIfyCq6w7RizLRUNPN47yn5
         I/vhVzlHlfwOnCppeLM6LfK08KH/ib/z99Avalt7XfPTQtB+BGwK9Si1Pqp8XSsK776Y
         bBGZItUV6yGXvtt5gIPzrq2mCNxmdt5hhfNbkbOtgl3MIVXsvAzBaOgHx3i9V9evLAkz
         u9p+JJjUFBNJOCM4QVBfqwgCYM7ABaNemnNujh52TSriZo+TU5RCWZU8SkvpHU9yTD7P
         gPIQ==
X-Gm-Message-State: ANhLgQ3+a9wLZ1zV4YBZy4hKDn7Qyz/PG+U8jhqbKEii+dHckEvMA/WA
        uDpdVXmar7K+7aDg3O+GrHVGEMiP5V3PWR0PiKlPJmSbg6liUwFnvBp0G/jLwSkeBGDzv9UlCZs
        oj0FJyKq9uSizgRmhhl1cEN6PP95if5HMVPRGeS0w
X-Received: by 2002:a92:8c0b:: with SMTP id o11mr4645682ild.135.1584646203370;
        Thu, 19 Mar 2020 12:30:03 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvVShStUfB2AGYam9Btfu27vVxasgER5AsPtAa4PgQ4ohw05qzh/EdsWzM9Dxc2ZTws9ccvB4BhM3f9ny30cf0=
X-Received: by 2002:a92:9606:: with SMTP id g6mr4691336ilh.119.1584646202385;
 Thu, 19 Mar 2020 12:30:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200318140605.45273-1-jarod@redhat.com> <8a88d1c8-c6b1-ad85-7971-e6ae8c6fa0e4@gmail.com>
 <CAKfmpSc0yea5-OfE1rnVdErDTeOza=owbL00QQEaH-M-A6Za7g@mail.gmail.com>
 <25629.1584564113@famine> <CAKfmpScbzEZAEw=zOEwguQJvr6L2fQiGmAY60SqSBQ_g-+B4tw@mail.gmail.com>
 <3dbabf42-90e6-4c82-0b84-d1b1a9e8fadf@gmail.com>
In-Reply-To: <3dbabf42-90e6-4c82-0b84-d1b1a9e8fadf@gmail.com>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Thu, 19 Mar 2020 15:29:51 -0400
Message-ID: <CAKfmpScXTnnz6wQK3OZcqw4aM1PaLnBRfQL769JgyR7tgM-u5A@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: don't auto-add link-local address to lag ports
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Jay Vosburgh <jay.vosburgh@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Moshe Levi <moshele@mellanox.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 1:06 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> On 3/19/20 9:42 AM, Jarod Wilson wrote:
>
> > Interesting. We'll keep digging over here, but that's definitely not
> > working for this particular use case with OVS for whatever reason.
>
> I did a quick test and confirmed that my bonding slaves do not have link-local addresses,
> without anything done to prevent them to appear.
>
> You might add a selftest, if you ever find what is the trigger :)

Okay, have a basic reproducer, courtesy of Marcelo:

# ip link add name bond0 type bond
# ip link set dev ens2f0np0 master bond0
# ip link set dev ens2f1np2 master bond0
# ip link set dev bond0 up
# ip a s
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: ens2f0np0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc
mq master bond0 state UP group default qlen 1000
    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
5: ens2f1np2: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc
mq master bond0 state DOWN group default qlen 1000
    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
11: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc
noqueue state UP group default qlen 1000
    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::20f:53ff:fe2f:ea40/64 scope link
       valid_lft forever preferred_lft forever

(above trimmed to relevant entries, obviously)

# sysctl net.ipv6.conf.ens2f0np0.addr_gen_mode=0
net.ipv6.conf.ens2f0np0.addr_gen_mode = 0
# sysctl net.ipv6.conf.ens2f1np2.addr_gen_mode=0
net.ipv6.conf.ens2f1np2.addr_gen_mode = 0

# ip a l ens2f0np0
2: ens2f0np0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc
mq master bond0 state UP group default qlen 1000
    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::20f:53ff:fe2f:ea40/64 scope link tentative
       valid_lft forever preferred_lft forever
# ip a l ens2f1np2
5: ens2f1np2: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc
mq master bond0 state DOWN group default qlen 1000
    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
    inet6 fe80::20f:53ff:fe2f:ea40/64 scope link tentative
       valid_lft forever preferred_lft forever

Looks like addrconf_sysctl_addr_gen_mode() bypasses the original "is
this a slave interface?" check, and results in an address getting
added, while w/the proposed patch added, no address gets added.

Looking back through git history again, I see a bunch of 'Fixes:
d35a00b8e33d ("net/ipv6: allow sysctl to change link-local address
generation mode")' patches, and I guess that's where this issue was
also introduced.

-- 
Jarod Wilson
jarod@redhat.com

