Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D54C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:53:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DA812076F
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 21:53:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c0Tl/DkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgCSVxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 17:53:23 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:58440 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726785AbgCSVxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 17:53:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584654800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfdaZlf6kOgQb4CeBwGTpbCE+UMt/Lv7sVpchM8h290=;
        b=c0Tl/DkWBTTmdFn+GN46pKisbhwS+/1mU30FDJ4/Yt7jZ35xAPNQJTXrHcmtdmiXLy8QhU
        QcKAkhnIPgdXUeVRJNMk/cUOuO3IkSX/97kFG+OzJaW7Q0KZFVZlgR8rpiCpv+BN8vWobY
        PxYjdzwMej3pcJOqmTwlAsZwF0RUoso=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-I5INA5NXPN6khFQVRAWi0Q-1; Thu, 19 Mar 2020 17:53:17 -0400
X-MC-Unique: I5INA5NXPN6khFQVRAWi0Q-1
Received: by mail-io1-f72.google.com with SMTP id s2so2979047iot.17
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 14:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sfdaZlf6kOgQb4CeBwGTpbCE+UMt/Lv7sVpchM8h290=;
        b=JAJ5cztcbQIp57mt2DI+/xFrg0Scz5JmPz4QAkhBEZCeyvIt/E9U/k4cfN64EdeWKG
         WTu/ILX8XzLXvt+VFHwcRSbPg7z1WeoNpVZT+OxTuhWbVQBvko2zD50dcKg1MUqKF730
         pa5JlvibrEgE7cAMkReSXMU7fC/t7T8rPgZR9SjduP3GlTPJ1fFvVYm2wcER6n3Z4vS0
         H+p546J6HuT/y45Sohu3TC3rJ8WlhL3hpDI4goP4U6EY9mC75HpWvXseB5NSWKMaIh5h
         m30he53Dn5QUnMtiYAt9MOnqrlg8sKhFnDqO0zUX7L9fQLkzGsVQu7DVGX74B12jqWOo
         XzcQ==
X-Gm-Message-State: ANhLgQ3tvFKsTIfMBBCMnjCMoMkzvKWS8PZtE9Niye8jmQkX1qFQD645
        HRyJrNXOT4jbTEN6/5t1Da7pUyYffgtNMMLYyeTu6ASaqVi3Hbd1pTc7W4TTfkS29ofKj/gFgqU
        Vk7B2CcBwkXa68CaxyMo8Wmrd6K9ACVCbus+LOwHo
X-Received: by 2002:a05:6638:201:: with SMTP id e1mr5268647jaq.111.1584654795238;
        Thu, 19 Mar 2020 14:53:15 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt7wgb+udfKl9vXnE86o8XTwCNKmWyvf1v7C4dl9OpvEtKtF78iguVy0Sy84eezKuSKS2luBzJx11/DeHG7bVs=
X-Received: by 2002:a05:6638:201:: with SMTP id e1mr5268628jaq.111.1584654794914;
 Thu, 19 Mar 2020 14:53:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200318140605.45273-1-jarod@redhat.com> <8a88d1c8-c6b1-ad85-7971-e6ae8c6fa0e4@gmail.com>
 <CAKfmpSc0yea5-OfE1rnVdErDTeOza=owbL00QQEaH-M-A6Za7g@mail.gmail.com>
 <25629.1584564113@famine> <CAKfmpScbzEZAEw=zOEwguQJvr6L2fQiGmAY60SqSBQ_g-+B4tw@mail.gmail.com>
 <3dbabf42-90e6-4c82-0b84-d1b1a9e8fadf@gmail.com> <CAKfmpScXTnnz6wQK3OZcqw4aM1PaLnBRfQL769JgyR7tgM-u5A@mail.gmail.com>
 <7028.1584647543@famine>
In-Reply-To: <7028.1584647543@famine>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Thu, 19 Mar 2020 17:53:03 -0400
Message-ID: <CAKfmpSfw0xvmOKYA+VDdTP4GM=uxWsrYQ7ywHufa+KDrLEvf_Q@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: don't auto-add link-local address to lag ports
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Moshe Levi <moshele@mellanox.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Netdev <netdev@vger.kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 3:52 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >On Thu, Mar 19, 2020 at 1:06 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >>
> >> On 3/19/20 9:42 AM, Jarod Wilson wrote:
> >>
> >> > Interesting. We'll keep digging over here, but that's definitely not
> >> > working for this particular use case with OVS for whatever reason.
> >>
> >> I did a quick test and confirmed that my bonding slaves do not have link-local addresses,
> >> without anything done to prevent them to appear.
> >>
> >> You might add a selftest, if you ever find what is the trigger :)
> >
> >Okay, have a basic reproducer, courtesy of Marcelo:
> >
> ># ip link add name bond0 type bond
> ># ip link set dev ens2f0np0 master bond0
> ># ip link set dev ens2f1np2 master bond0
> ># ip link set dev bond0 up
> ># ip a s
> >1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> >group default qlen 1000
> >    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
> >    inet 127.0.0.1/8 scope host lo
> >       valid_lft forever preferred_lft forever
> >    inet6 ::1/128 scope host
> >       valid_lft forever preferred_lft forever
> >2: ens2f0np0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc
> >mq master bond0 state UP group default qlen 1000
> >    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
> >5: ens2f1np2: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc
> >mq master bond0 state DOWN group default qlen 1000
> >    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
> >11: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc
> >noqueue state UP group default qlen 1000
> >    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
> >    inet6 fe80::20f:53ff:fe2f:ea40/64 scope link
> >       valid_lft forever preferred_lft forever
> >
> >(above trimmed to relevant entries, obviously)
> >
> ># sysctl net.ipv6.conf.ens2f0np0.addr_gen_mode=0
> >net.ipv6.conf.ens2f0np0.addr_gen_mode = 0
> ># sysctl net.ipv6.conf.ens2f1np2.addr_gen_mode=0
> >net.ipv6.conf.ens2f1np2.addr_gen_mode = 0
> >
> ># ip a l ens2f0np0
> >2: ens2f0np0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc
> >mq master bond0 state UP group default qlen 1000
> >    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
> >    inet6 fe80::20f:53ff:fe2f:ea40/64 scope link tentative
> >       valid_lft forever preferred_lft forever
> ># ip a l ens2f1np2
> >5: ens2f1np2: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc
> >mq master bond0 state DOWN group default qlen 1000
> >    link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
> >    inet6 fe80::20f:53ff:fe2f:ea40/64 scope link tentative
> >       valid_lft forever preferred_lft forever
> >
> >Looks like addrconf_sysctl_addr_gen_mode() bypasses the original "is
> >this a slave interface?" check, and results in an address getting
> >added, while w/the proposed patch added, no address gets added.
>
>         I wonder if this also breaks for the netvsc usage of IFF_SLAVE
> to suppress ipv6 addrconf?  Adding the hyperv maintainers to Cc.
>
>         In any event, it looks like addrconf_sysctl_addr_gen_mode()
> calls addrconf_dev_config() directly, which bypasses the IFF_SLAVE check
> in addrconf_notify() that would gate other callers.

Yeah, that's what I was thinking as well.

>         From my reading, your patch appears to cover a superset of cases
> as compared to the existing IFF_SLAVE test from c2edacf80e15.

I wasn't aware of additional devices that would want to prevent these
addresses, could certainly alter the patch to reject anything with
IFF_SLAVE too for consistency.

> >Looking back through git history again, I see a bunch of 'Fixes:
> >d35a00b8e33d ("net/ipv6: allow sysctl to change link-local address
> >generation mode")' patches, and I guess that's where this issue was
> >also introduced.
>
>         Can the problem be induced via ip link set ... addrgenmode ?
> That functionality predates the sysctl interface, looks like it was
> introduced with

Doesn't look like it, no. No change after either trying addrgenmode
none or random.

-- 
Jarod Wilson
jarod@redhat.com

