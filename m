Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8699C43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93E95221EB
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:43:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MK9zQOSX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgIKQnx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgIKPIY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 11:08:24 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FC9C06136F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:32:34 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id y194so5486840vsc.4
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NQAm+3y6fCAECF7HBt/KX1e0yG8P1XL6nlxfCnayxHg=;
        b=MK9zQOSXSiWzoI1iCGLugJPqcjKnzVnthtw31ehkWRU8wuFXliRGbnEYo7rng19WYk
         zRH0kxyo+E03zOxAH65S2s6LgeOLL+LhOXPxPlkxFEW7n9Iei6P3gnCB15/LRjTzVPvk
         tQNlg4d6pvUxQYKe08T/4jf/TLzlkPkTWs1/CxSuHA3InGQZlQhgD2ZcBHytKP5UyzEW
         JYeT0jWAOsSl4CRBXKwXi061nO5L/c2UOhNR0YgEPvNFvr2fHMZRnLs3ltOKp27XIlyt
         dYKnaSq4ZdeRkolzLQsIEKTsjx7NAxSGXpnUGYJXg/JtW1tAUYyMX6Bi3f/Wz34zR3f/
         iHvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NQAm+3y6fCAECF7HBt/KX1e0yG8P1XL6nlxfCnayxHg=;
        b=dy3qwP5kmGRM4nAJvlOILgRVnG/WCK+UPebe6Zfb2841qvRyUTq8tiuEpnoe3VPBoU
         MbFFIyopszqMo9SOstsi5saTgp3fKddOhsITLt+fKtUCzZ76DO4RtE46f2eEebxCzeh6
         Fe3aSwzIva3cCC7axEH0AA0FsxkPSsMHXEQ/jnPUj8KESm5kSf+ivF7azWIlEmRNR+GL
         AWODOCLsU3/2xCKWoew+EzEr2q50NFQQB3+JKQfJNWpHVvVRtIXw4JKsqh2eozqFOWEh
         WpDognVeAfzGrmQCxwFelXtWQXFFF1jjZz+zuvuGXKlN+qPitD+FXRv03DZhTDlaF19B
         qUaA==
X-Gm-Message-State: AOAM531XWLfspc2Msz5ExZ9EfA2vSCtUHjF30KchKw4W74bbHYMGeQZ8
        K8epZsCbS0/qcwjRymh9UuNjZ8eienIitg==
X-Google-Smtp-Source: ABdhPJySMncgs77tFayTQ3zRUN1KvqqxheAZfft5h4Sh99zfbw8BNiE1aZUplVKM7s85vGQohOIFpQ==
X-Received: by 2002:a67:efc4:: with SMTP id s4mr1254617vsp.72.1599834752877;
        Fri, 11 Sep 2020 07:32:32 -0700 (PDT)
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com. [209.85.222.43])
        by smtp.gmail.com with ESMTPSA id 68sm165936vkx.0.2020.09.11.07.32.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Sep 2020 07:32:31 -0700 (PDT)
Received: by mail-ua1-f43.google.com with SMTP id g16so3153665uan.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Sep 2020 07:32:31 -0700 (PDT)
X-Received: by 2002:ab0:60d7:: with SMTP id g23mr1198133uam.122.1599834751042;
 Fri, 11 Sep 2020 07:32:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200911050359.25042-1-xie.he.0141@gmail.com>
In-Reply-To: <20200911050359.25042-1-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 11 Sep 2020 16:31:54 +0200
X-Gmail-Original-Message-ID: <CA+FuTSeOUKJYOFamA+fKBxEb22VosOXZRWGf2DungBGRorcyfg@mail.gmail.com>
Message-ID: <CA+FuTSeOUKJYOFamA+fKBxEb22VosOXZRWGf2DungBGRorcyfg@mail.gmail.com>
Subject: Re: [PATCH net-next] net/packet: Fix a comment about hard_header_len
 and add a warning for it
To:     Xie He <xie.he.0141@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Cong Wang <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 7:04 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> This patch tries to clarify the difference between hard_header_len and
> needed_headroom by fixing an outdated comment and adding a WARN_ON_ONCE
> warning for hard_header_len.
>
> The difference between hard_header_len and needed_headroom as understood
> by this patch is based on the following reasons:
>
> 1.
>
> In af_packet.c, the function packet_snd first reserves a headroom of
> length (dev->hard_header_len + dev->needed_headroom).
> Then if the socket is a SOCK_DGRAM socket, it calls dev_hard_header,
> which calls dev->header_ops->create, to create the link layer header.
> If the socket is a SOCK_RAW socket, it "un-reserves" a headroom of
> length (dev->hard_header_len), and checks if the user has provided a
> header sized between (dev->min_header_len) and (dev->hard_header_len)
> (in dev_validate_header).
> This shows the developers of af_packet.c expect hard_header_len to
> be consistent with header_ops.
>
> 2.
>
> In af_packet.c, the function packet_sendmsg_spkt has a FIXME comment.
> That comment states that prepending an LL header internally in a driver
> is considered a bug. I believe this bug can be fixed by setting
> hard_header_len to 0, making the internal header completely invisible
> to af_packet.c (and requesting the headroom in needed_headroom instead).
>
> 3.
>
> There is a commit for a WiFi driver:
> commit 9454f7a895b8 ("mwifiex: set needed_headroom, not hard_header_len")
> According to the discussion about it at:
>   https://patchwork.kernel.org/patch/11407493/
> The author tried to set the WiFi driver's hard_header_len to the Ethernet
> header length, and request additional header space internally needed by
> setting needed_headroom.
> This means this usage is already adopted by driver developers.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>
> ---
>  net/packet/af_packet.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index af6c93ed9fa0..93c89d3b2511 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -93,12 +93,15 @@
>
>  /*
>     Assumptions:
> -   - if device has no dev->hard_header routine, it adds and removes ll header
> -     inside itself. In this case ll header is invisible outside of device,
> -     but higher levels still should reserve dev->hard_header_len.
> -     Some devices are enough clever to reallocate skb, when header
> -     will not fit to reserved space (tunnel), another ones are silly
> -     (PPP).
> +   - If the device has no dev->header_ops, there is no LL header visible
> +     above the device. In this case, its hard_header_len should be 0.
> +     The device may prepend its own header internally. In this case, its
> +     needed_headroom should be set to the space needed for it to add its
> +     internal header.
> +     For example, a WiFi driver pretending to be an Ethernet driver should
> +     set its hard_header_len to be the Ethernet header length, and set its
> +     needed_headroom to be (the real WiFi header length - the fake Ethernet
> +     header length).
>     - packet socket receives packets with pulled ll header,
>       so that SOCK_RAW should push it back.
>
> @@ -2936,6 +2939,8 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>         skb_reset_network_header(skb);
>
>         err = -EINVAL;
> +       if (!dev->header_ops)
> +               WARN_ON_ONCE(dev->hard_header_len != 0);
>         if (sock->type == SOCK_DGRAM) {
>                 offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len);
>                 if (unlikely(offset < 0))

From a quick scan, a few device types that might trigger this

net/atm/clip.c
drivers/net/wan/hdlc_fr.c
drivers/net/appletalk/ipddp.c
drivers/net/ppp/ppp_generic.c
drivers/net/net_failover.c
