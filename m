Return-Path: <SRS0=C9WH=4E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EDFC3B1BF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 22:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5096E2084E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Feb 2020 22:22:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgBPWWR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Feb 2020 17:22:17 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:52125 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgBPWWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Feb 2020 17:22:17 -0500
X-Originating-IP: 209.85.222.43
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
        (Authenticated sender: pshelar@ovn.org)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 8CB781C0004;
        Sun, 16 Feb 2020 22:22:14 +0000 (UTC)
Received: by mail-ua1-f43.google.com with SMTP id f7so5471468uaa.8;
        Sun, 16 Feb 2020 14:22:14 -0800 (PST)
X-Gm-Message-State: APjAAAXOuO0FtgIz44XaZ5s7sSxC0Gag4k/bRYp9ZDN8KXc6i7bm1drZ
        yfKiiRnuPx9eCOwQkgrowMIJu/k8F4Ynorpg4yk=
X-Google-Smtp-Source: APXvYqx2go22AofIyIP98/l6l45UOkLo/JVU6KDf6hZMx9X9FgplBl+/pgthlodHMYDcGG1odYWa6E/YfMjVrHqpEXI=
X-Received: by 2002:ab0:4753:: with SMTP id i19mr6353393uac.70.1581891733184;
 Sun, 16 Feb 2020 14:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20200215132056.42124-1-mcroce@redhat.com>
In-Reply-To: <20200215132056.42124-1-mcroce@redhat.com>
From:   Pravin Shelar <pshelar@ovn.org>
Date:   Sun, 16 Feb 2020 14:22:02 -0800
X-Gmail-Original-Message-ID: <CAOrHB_AgZJAc4oD+9pxuUEvepVK1RstD8veC5gfj1m4rhKPROg@mail.gmail.com>
Message-ID: <CAOrHB_AgZJAc4oD+9pxuUEvepVK1RstD8veC5gfj1m4rhKPROg@mail.gmail.com>
Subject: Re: [PATCH net-next v5] openvswitch: add TTL decrement action
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Linux Kernel Network Developers <netdev@vger.kernel.org>,
        ovs dev <dev@openvswitch.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bindiya Kurle <bindiyakurle@gmail.com>,
        Simon Horman <simon.horman@netronome.com>,
        Ben Pfaff <blp@ovn.org>,
        Nikolay Aleksandrov <nikolay@cumulusnetworks.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Jeremy Harris <jgh@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 15, 2020 at 5:21 AM Matteo Croce <mcroce@redhat.com> wrote:
>
> New action to decrement TTL instead of setting it to a fixed value.
> This action will decrement the TTL and, in case of expired TTL, drop it
> or execute an action passed via a nested attribute.
> The default TTL expired action is to drop the packet.
>
> Supports both IPv4 and IPv6 via the ttl and hop_limit fields, respectively.
>
> Tested with a corresponding change in the userspace:
>
>     # ovs-dpctl dump-flows
>     in_port(2),eth(),eth_type(0x0800), packets:0, bytes:0, used:never, actions:dec_ttl{ttl<=1 action:(drop)},1
>     in_port(1),eth(),eth_type(0x0800), packets:0, bytes:0, used:never, actions:dec_ttl{ttl<=1 action:(drop)},2
>     in_port(1),eth(),eth_type(0x0806), packets:0, bytes:0, used:never, actions:2
>     in_port(2),eth(),eth_type(0x0806), packets:0, bytes:0, used:never, actions:1
>
>     # ping -c1 192.168.0.2 -t 42
>     IP (tos 0x0, ttl 41, id 61647, offset 0, flags [DF], proto ICMP (1), length 84)
>         192.168.0.1 > 192.168.0.2: ICMP echo request, id 386, seq 1, length 64
>     # ping -c1 192.168.0.2 -t 120
>     IP (tos 0x0, ttl 119, id 62070, offset 0, flags [DF], proto ICMP (1), length 84)
>         192.168.0.1 > 192.168.0.2: ICMP echo request, id 388, seq 1, length 64
>     # ping -c1 192.168.0.2 -t 1
>     #
>
> Co-developed-by: Bindiya Kurle <bindiyakurle@gmail.com>
> Signed-off-by: Bindiya Kurle <bindiyakurle@gmail.com>
> Signed-off-by: Matteo Croce <mcroce@redhat.com>
> ---

Thanks!

Acked-by: Pravin B Shelar <pshelar@ovn.org>
