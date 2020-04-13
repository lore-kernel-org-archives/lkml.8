Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBDFEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B1E62051A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 23:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SFp6T0s4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390022AbgDMXnp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 19:43:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:41443 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727804AbgDMXno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 19:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586821421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xqr4dsXCGQ7mBSR00NAzM1Q6acm6mNGXK+xaVCuI9s0=;
        b=SFp6T0s4x/mpYT7OZuM9ZVhf0knXif1xJWlcoWokAmOSe57awSUuPpAn7yzjLIIsk0KZkC
        qdzApij+wVzacZ6OlrTlNEVTX/4FfiimwHxOhXzjZJTLD4Ax9Y4oxffDAj+6kNxG6CGPtN
        n+xe6HtkaXFpsmlbS8O0JbRGH4SQWzw=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-466-3tvLQx0XNVOMXgwoRFgZJg-1; Mon, 13 Apr 2020 19:43:40 -0400
X-MC-Unique: 3tvLQx0XNVOMXgwoRFgZJg-1
Received: by mail-ed1-f70.google.com with SMTP id q27so10688116edc.15
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 16:43:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xqr4dsXCGQ7mBSR00NAzM1Q6acm6mNGXK+xaVCuI9s0=;
        b=uX1EbuvWmGErMal8vmDktOHhRlsffNk2Si3nDk7bDzvClFNM9V0uXcsvyZa1EXYdSv
         iDY5ZHSl9mFfhtaA2Gtkovnipz+0UewoFRS4frzC6Nt2HiBPqohz1rzQU2D3OH/VhbSw
         1u5NRlYSVYbiUucZmmifJadU5OV+VAB2LuoaVBQ+VAa4/+ObXbpYPtNWvOv/66iiHAqE
         RCRSx0tyAfO3MNT77vqRyTX/Z031Ej4jP9ttnJiluNWXS0ZzHFq1Ces6zQRTpdfPwCwi
         2fwYkFewvcknKXoWVA6dOrosfi+VVJMpTl6wiMkRadEnrznEiSf9fXr+cpQjSnCYLjSW
         dtIg==
X-Gm-Message-State: AGi0PuY5dYHrK4D2KF4oKbOAmumbLOknIiEua35ZWiRBh8vFjY9Cynz1
        NIVO/5IzcGcoKFedZaS9fuRB90O6tQzIYyWSoXnyA2Q9tURB22tIfmK1SZ/yem4+ciUOnGB75em
        kWtDsPiet9R37MJw+poBeGG78kEgsFHxf2TW5Z9WB
X-Received: by 2002:a17:906:a418:: with SMTP id l24mr4284476ejz.362.1586821418588;
        Mon, 13 Apr 2020 16:43:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypKa/t6ZDKsi78psOMm2ofYlu33r+ev1cgYcUx7E9J7maeva3YKq+x4SEnS8Mxo6UUPZcXftIkJxkGJxL//DCa8=
X-Received: by 2002:a17:906:a418:: with SMTP id l24mr4284462ejz.362.1586821418314;
 Mon, 13 Apr 2020 16:43:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190524100554.8606-1-maxime.chevallier@bootlin.com> <20190524100554.8606-4-maxime.chevallier@bootlin.com>
In-Reply-To: <20190524100554.8606-4-maxime.chevallier@bootlin.com>
From:   Matteo Croce <mcroce@redhat.com>
Date:   Tue, 14 Apr 2020 01:43:02 +0200
Message-ID: <CAGnkfhzsx_uEPkZQC-_-_NamTigD8J0WgcDioqMLSHVFa3V6GQ@mail.gmail.com>
Subject: Re: [PATCH net-next 3/5] net: mvpp2: cls: Use RSS contexts to handle
 RSS tables
To:     Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        Nadav Haklai <nadavh@marvell.com>,
        Stefan Chulski <stefanc@marvell.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 1:21 AM Maxime Chevallier
<maxime.chevallier@bootlin.com> wrote:
>
> The PPv2 controller has 8 RSS tables that are shared across all ports on
> a given PPv2 instance. The previous implementation allocated one table
> per port, leaving others unused.
>
> By using RSS contexts, we can make use of multiple RSS tables per
> port, one being the default table (always id 0), the other ones being
> used as destinations for flow steering, in the same way as rx rings.
>
> This commit introduces RSS contexts management in the PPv2 driver. We
> always reserve one table per port, allocated when the port is probed.
>
> The global table list is stored in the struct mvpp2, as it's a global
> resource. Each port then maintains a list of indices in that global
> table, that way each port can have it's own numbering scheme starting
> from 0.
>
> One limitation that seems unavoidable is that the hashing parameters are
> shared across all RSS contexts for a given port. Hashing parameters for
> ctx 0 will be applied to all contexts.
>
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Hi all,

I noticed that enabling rxhash blocks the RX on my Macchiatobin. It
works fine with the 10G ports (the RX rate goes 4x up) but it
completely kills the gigabit interface.

# 10G port
root@macchiatobin:~# iperf3 -c 192.168.0.2
Connecting to host 192.168.0.2, port 5201
[  5] local 192.168.0.1 port 42394 connected to 192.168.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   941 MBytes  7.89 Gbits/sec  4030    250 KBytes
[  5]   1.00-2.00   sec   933 MBytes  7.82 Gbits/sec  4393    240 KBytes
root@macchiatobin:~# ethtool -K eth0 rxhash on
root@macchiatobin:~# iperf3 -c 192.168.0.2
Connecting to host 192.168.0.2, port 5201
[  5] local 192.168.0.1 port 42398 connected to 192.168.0.2 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   860 MBytes  7.21 Gbits/sec  428    410 KBytes
[  5]   1.00-2.00   sec   859 MBytes  7.20 Gbits/sec  185    563 KBytes

# gigabit port
root@macchiatobin:~# iperf3 -c turbo
Connecting to host turbo, port 5201
[  5] local 192.168.85.42 port 45144 connected to 192.168.85.6 port 5201
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec   113 MBytes   948 Mbits/sec    0    407 KBytes
[  5]   1.00-2.00   sec   112 MBytes   942 Mbits/sec    0    428 KBytes
root@macchiatobin:~# ethtool -K eth2 rxhash on
root@macchiatobin:~# iperf3 -c turbo
iperf3: error - unable to connect to server: Resource temporarily unavailable

I've bisected and it seems that this commit causes the issue. I tried
to revert it on nex-next as a second test, but the code has changed a
lot much since, generating too much conflicts.
Can you have a look into this?

Thanks,
-- 
Matteo Croce
per aspera ad upstream

