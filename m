Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6317BC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 09:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0B1206B6
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 09:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCfT5JrY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgHIJNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 05:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgHIJNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 05:13:13 -0400
Received: from mail-ua1-x943.google.com (mail-ua1-x943.google.com [IPv6:2607:f8b0:4864:20::943])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524F2C061A27
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 02:13:13 -0700 (PDT)
Received: by mail-ua1-x943.google.com with SMTP id g20so1638414uan.7
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 02:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r+74zSb8Mdp9nDMJHIbR9g9Xvn68Ir31r0eIPx9VKJQ=;
        b=uCfT5JrYlSPG0FEa68vEPgOHLYMvfbUL6H6bDMPguXZp/Qlh6YGNBBSj7uXfYtckc3
         cCO8ZypmSwK+tFs6jZQZ8bV5QoFG6dMLcGwBbYmTjQcJwhzbAZy1FuTLz8rCe1U3HJeC
         zKvA5bxJpLgNBw3IKo6tBM7xvaAiyNa4gqbUktEbvi/BpJLo4OBC3d6nFRRMLvo0jYFV
         mPIozp32zeE+OPwRs8ihRtN221ms6sh5PQG6jmDjxMWrjY1xXxJxA5cEv4MHobpF6mWm
         6+gT3Jq0cUI/PRGxlQM9zzh+6uviWzHh/PFTNjQmhz9Z6vZaU+wg6EVnCUNC5JBQVOpM
         bM2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r+74zSb8Mdp9nDMJHIbR9g9Xvn68Ir31r0eIPx9VKJQ=;
        b=jRial0VyIzOJjLRtJx3Tg2tHLmCiK76rMkNNclZ3ZTi2nErQEv6jZ3K1aT4q10WPO8
         mh30bDxbXgl8b6jT1ks9fk+RuBisEQJfn8xVBT+ug+xU8PU7nP0F5DJxbZcqWWrXsVVP
         xxvQYq2reHpFpN4Fcmk9mIulE+yCtwOp5QZuPC8kJlJjQXG/GKVtTGv/SkyDs4UdFBZU
         Hnq345fygXvwHnzaBBo7VD16ARVJWswgojmYU8zgIt0DqsQ1ZesjgSCTTE24L2DVd9Qg
         PaOIcnX5rxUIc0C1A9qj5Ytp5UDzzbVwcaY89oAJ2bNNDOTYD7lEa3FGk7VyoY0RXKTl
         ektA==
X-Gm-Message-State: AOAM531B6ZMnbzZ231MBdkA45Qx0gYCdR5vyLxRCWwqcttahoHjzZ18K
        xUZu1Zyikuxav/jhTXGh2OYvnsA8ftM=
X-Google-Smtp-Source: ABdhPJxn3bPSXAHzL/cGHzzAzh8yjISoHM903w+UZfVQ3H2TWUZoiWr5i0+QjsuGCIB4VdwJZ6FrWA==
X-Received: by 2002:a9f:3630:: with SMTP id r45mr15569087uad.31.1596964391562;
        Sun, 09 Aug 2020 02:13:11 -0700 (PDT)
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com. [209.85.217.54])
        by smtp.gmail.com with ESMTPSA id u74sm3347308vsu.14.2020.08.09.02.13.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Aug 2020 02:13:10 -0700 (PDT)
Received: by mail-vs1-f54.google.com with SMTP id a1so2835986vsp.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 02:13:10 -0700 (PDT)
X-Received: by 2002:a05:6102:517:: with SMTP id l23mr15265082vsa.114.1596964389659;
 Sun, 09 Aug 2020 02:13:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200809023548.684217-1-xie.he.0141@gmail.com>
In-Reply-To: <20200809023548.684217-1-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sun, 9 Aug 2020 11:12:33 +0200
X-Gmail-Original-Message-ID: <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com>
Message-ID: <CA+FuTSe-FaQFn4WNvVPJ1v+jVZAghgd1AZc-cWn2+GjPR4GzVQ@mail.gmail.com>
Subject: Re: [PATCH net] drivers/net/wan/x25_asy: Added needed_headroom and a
 skb->len check
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux X25 <linux-x25@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Martin Schiller <ms@dev.tdt.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 9, 2020 at 4:36 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> 1. Added a skb->len check
>
> This driver expects upper layers to include a pseudo header of 1 byte
> when passing down a skb for transmission. This driver will read this
> 1-byte header. This patch added a skb->len check before reading the
> header to make sure the header exists.
>
> 2. Added needed_headroom
>
> When this driver transmits data,
>   first this driver will remove a pseudo header of 1 byte,
>   then the lapb module will prepend the LAPB header of 2 or 3 bytes.
> So the value of needed_headroom in this driver should be 3 - 1.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Martin Schiller <ms@dev.tdt.de>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

The patch is analogous to commit c7ca03c216ac
("drivers/net/wan/lapbether: Added needed_headroom and a skb->len
check").

Seems to make sense based on call stack

  x25_asy_xmit               // skb_pull(skb, 1)
  lapb_data_request
  lapb_kick
  lapb_send_iframe        // skb_push(skb, 2)
  lapb_transmit_buffer    // skb_push(skb, 1)
  lapb_data_transmit
  x25_asy_data_transmit
  x25_asy_encaps

But I frankly don't know this code and would not modify logic that no
one has complained about for many years without evidence of a real
bug.

Were you able to actually exercise this path, similar to lapb_ether:
configure the device, send data from a packet socket? If so, can you
share the configuration steps?
