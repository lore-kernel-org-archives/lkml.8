Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F256C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:41:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD4DA20767
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:41:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20150623.gappssmtp.com header.i=@networkplumber-org.20150623.gappssmtp.com header.b="g8CBTU6s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbgCSWlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:41:18 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:40307 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727178AbgCSWlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:41:18 -0400
Received: by mail-pg1-f193.google.com with SMTP id t24so2050938pgj.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WXEQfKHEEKAelELookAm5SU+lK6q1bQG9Mw5VpyZmF4=;
        b=g8CBTU6sxn6T4xPZseWeYWrS5c2fU1YrKHctdLN7SdJkAJISIDCr5m0LaspEqrOmhD
         uTI8obdRF3vzI2y0rF8wtNoSa900A7FfL7SgNfB5AwkuAW6IHw6IV9IkQFZD0UQcwKJx
         LsQgW9jxKg7JRXncd6ZbGUXHGh/DQyToH6ZJjDZwKCp6VpktLif0vqnPo4fshTuE4E4o
         1kxzN3vl0B1ISGKet0jS2XPX7pTZkOUAfTOrgrC8yvocw0nWSukI7TsdYhKL6Yf7g8cr
         heRQUn53r8bSQQzkQ1Y9ru38cZRn+URJuVq9ZQdTGtzxLtoKvDCVrW+uRPUSZiAmdofu
         /7nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WXEQfKHEEKAelELookAm5SU+lK6q1bQG9Mw5VpyZmF4=;
        b=dPO4ZAipQABZLO/JGLQhaYo/xdlhzuk1DAeWfE+SqGI2YeszYp9Z/9CQ8EcOAkbqdh
         PHhbmlOOr2GV4yflYTs907eITBiMTE+0qEk1eke/2wpQNsNKjFLSGGmoqXChtVNIXc/y
         6iBmlStrRJdUm7xUZ8kl6SfII8VE5bCsl6fCcSUSPG2VGzarRbHgIeylFAmJEMNiynMA
         7alRXfQEN79fqnkHWVfkm5DqGx9DsfTRj71doVY4gB2rql46mMr2wtSAw1t4GpmmrQfh
         fH/lX8PPJ9BpZYJO8JIx0SCvOVq8H5KVNoX9sZk2++JibX7Rs71BH7Q9fwTjnP4+YZdz
         GuiQ==
X-Gm-Message-State: ANhLgQ2iBaZDF4z1yCEGilAv/0qje1t4Hn/N+ytM9zYVWALN5uW+4zdK
        TtGen9vthb2w+brfpMJUU9StyA==
X-Google-Smtp-Source: ADFU+vsURs9x5ZcqM9iGwCqnOiL5lB6PekLLvHfEUJZ/UFuhuQewOryqnWPZvWqAFiW+wiQispt9Tg==
X-Received: by 2002:a63:e141:: with SMTP id h1mr5395924pgk.129.1584657676741;
        Thu, 19 Mar 2020 15:41:16 -0700 (PDT)
Received: from hermes.lan (204-195-22-127.wavecable.com. [204.195.22.127])
        by smtp.gmail.com with ESMTPSA id x27sm3508545pfj.74.2020.03.19.15.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 15:41:16 -0700 (PDT)
Date:   Thu, 19 Mar 2020 15:41:08 -0700
From:   Stephen Hemminger <stephen@networkplumber.org>
To:     Jarod Wilson <jarod@redhat.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Jay Vosburgh <jay.vosburgh@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Moshe Levi <moshele@mellanox.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH net] ipv6: don't auto-add link-local address to lag
 ports
Message-ID: <20200319154108.2de87e34@hermes.lan>
In-Reply-To: <CAKfmpScXTnnz6wQK3OZcqw4aM1PaLnBRfQL769JgyR7tgM-u5A@mail.gmail.com>
References: <20200318140605.45273-1-jarod@redhat.com>
        <8a88d1c8-c6b1-ad85-7971-e6ae8c6fa0e4@gmail.com>
        <CAKfmpSc0yea5-OfE1rnVdErDTeOza=owbL00QQEaH-M-A6Za7g@mail.gmail.com>
        <25629.1584564113@famine>
        <CAKfmpScbzEZAEw=zOEwguQJvr6L2fQiGmAY60SqSBQ_g-+B4tw@mail.gmail.com>
        <3dbabf42-90e6-4c82-0b84-d1b1a9e8fadf@gmail.com>
        <CAKfmpScXTnnz6wQK3OZcqw4aM1PaLnBRfQL769JgyR7tgM-u5A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 15:29:51 -0400
Jarod Wilson <jarod@redhat.com> wrote:

> On Thu, Mar 19, 2020 at 1:06 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >
> > On 3/19/20 9:42 AM, Jarod Wilson wrote:
> >  
> > > Interesting. We'll keep digging over here, but that's definitely not
> > > working for this particular use case with OVS for whatever reason.  
> >
> > I did a quick test and confirmed that my bonding slaves do not have link-local addresses,
> > without anything done to prevent them to appear.
> >
> > You might add a selftest, if you ever find what is the trigger :)  
> 
> Okay, have a basic reproducer, courtesy of Marcelo:
> 
> # ip link add name bond0 type bond
> # ip link set dev ens2f0np0 master bond0
> # ip link set dev ens2f1np2 master bond0
> # ip link set dev bond0 up
> # ip a s
> 1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN
> group default qlen 1000
>     link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
>     inet 127.0.0.1/8 scope host lo
>        valid_lft forever preferred_lft forever
>     inet6 ::1/128 scope host
>        valid_lft forever preferred_lft forever
> 2: ens2f0np0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc
> mq master bond0 state UP group default qlen 1000
>     link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
> 5: ens2f1np2: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc
> mq master bond0 state DOWN group default qlen 1000
>     link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
> 11: bond0: <BROADCAST,MULTICAST,MASTER,UP,LOWER_UP> mtu 1500 qdisc
> noqueue state UP group default qlen 1000
>     link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::20f:53ff:fe2f:ea40/64 scope link
>        valid_lft forever preferred_lft forever
> 
> (above trimmed to relevant entries, obviously)
> 
> # sysctl net.ipv6.conf.ens2f0np0.addr_gen_mode=0
> net.ipv6.conf.ens2f0np0.addr_gen_mode = 0
> # sysctl net.ipv6.conf.ens2f1np2.addr_gen_mode=0
> net.ipv6.conf.ens2f1np2.addr_gen_mode = 0
> 
> # ip a l ens2f0np0
> 2: ens2f0np0: <BROADCAST,MULTICAST,SLAVE,UP,LOWER_UP> mtu 1500 qdisc
> mq master bond0 state UP group default qlen 1000
>     link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::20f:53ff:fe2f:ea40/64 scope link tentative
>        valid_lft forever preferred_lft forever
> # ip a l ens2f1np2
> 5: ens2f1np2: <NO-CARRIER,BROADCAST,MULTICAST,SLAVE,UP> mtu 1500 qdisc
> mq master bond0 state DOWN group default qlen 1000
>     link/ether 00:0f:53:2f:ea:40 brd ff:ff:ff:ff:ff:ff
>     inet6 fe80::20f:53ff:fe2f:ea40/64 scope link tentative
>        valid_lft forever preferred_lft forever
> 
> Looks like addrconf_sysctl_addr_gen_mode() bypasses the original "is
> this a slave interface?" check, and results in an address getting
> added, while w/the proposed patch added, no address gets added.
> 
> Looking back through git history again, I see a bunch of 'Fixes:
> d35a00b8e33d ("net/ipv6: allow sysctl to change link-local address
> generation mode")' patches, and I guess that's where this issue was
> also introduced.
> 

Yes the addrgen mode patches caused bad things to happen with hyper-v
sub devices.  Addrconf code is very tricky to get right.
If you look back there have been a large number of changes where
a patch looks good, gets reviewed, merged, and then breaks something
and has to be reverted.

Probably the original patch should just be reverted rather than
trying to add more here.
