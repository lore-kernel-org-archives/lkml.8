Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA85C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDEC420C09
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 08:26:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IQpO+ZJN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730477AbgIJI0s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 04:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730401AbgIJIY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 04:24:26 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FD36C061756
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:24:14 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id a16so2900387vsp.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQRoi7azmXw9DhQr/EkZeyb3raZh2+EzD84kCzPcKmQ=;
        b=IQpO+ZJN8hEIxKKXEVX6pnZXoK7U8oJe3Rtm3II8W+/5GYDow3YNmnH96hrHx/wuqG
         SFRb4xr8BLqx8LItlGDnyQjxqZ/ZSlgBH3BGxzq9Os8zm/g0b1gVjHP7PGzx9a5o5B6/
         EDEc9DE5S5gVqIyGLNhaQAsT9VqTWPTwtmUgu+7ANNK1/QFxxXfUCvyzXmxLmQ44BRGh
         tkQjJzv5WFK5eilLOXHbkW70t8ezZlDleZTaVT9xdiks1rnLSwa6yuHa2zX5qbzLvNSU
         Euh7ET4qW9jY4Bw1ryswD3A5u/iQXJd+47RYjxdjBZnNUTUspU1ELTTSyLOg7B8ufiJb
         ZlxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQRoi7azmXw9DhQr/EkZeyb3raZh2+EzD84kCzPcKmQ=;
        b=jy0pJnZjyJB9RU4w3wR65PWQqpKYxBUiTKoeJYQZG+ZxQG+askfNeLhPcZcrgkP1/s
         eLofVbQFTETq2T2eQl5lPsGQfGU5Lnykjh2/QoqwhfQlLU2kEDjDOrTvQLzTCvlOqx1v
         p/cm1Z2z5BL8RBhOF8JQrTuKLiqDoRUykCwYA1gy1Tj+LFEX3UWexexod3fzzOf3YQyN
         yRvRiLQJLYIrHS4tKGHepUX17q+R+UsrdSlgxlEkV8cgrOXA2OguJigQ6398KxJN0L1f
         rBya6aU87CGqxtzZtznqudhpCasu/DW36M9Er8Dz+2WRYU7l4HXIvjVf5Si9xPT6+Kk3
         c85w==
X-Gm-Message-State: AOAM533QvqkfFVgl/6E11QdRR1xq2B4No+XK2z3UYNTUOCdVhzgsprbJ
        uavNXr/LgAJ/nXQBqBxjLegkp/qYXSMtcQ==
X-Google-Smtp-Source: ABdhPJzr1GXhPuG45YbvdFgS2cj+z0XuaRX7l/WQLasE9SaQCLB48FQrL7jcADXIXadwNJH/IYovOA==
X-Received: by 2002:a67:9c6:: with SMTP id 189mr2996489vsj.26.1599726252013;
        Thu, 10 Sep 2020 01:24:12 -0700 (PDT)
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com. [209.85.221.170])
        by smtp.gmail.com with ESMTPSA id p130sm830990vke.14.2020.09.10.01.24.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 01:24:10 -0700 (PDT)
Received: by mail-vk1-f170.google.com with SMTP id c25so1369492vkm.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 01:24:10 -0700 (PDT)
X-Received: by 2002:a1f:964c:: with SMTP id y73mr3236074vkd.8.1599726249873;
 Thu, 10 Sep 2020 01:24:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200910054333.447888-1-xie.he.0141@gmail.com>
In-Reply-To: <20200910054333.447888-1-xie.he.0141@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Thu, 10 Sep 2020 10:23:33 +0200
X-Gmail-Original-Message-ID: <CA+FuTSdcT70_zyJHiMPT_HK8zJbTg72y-AO2XYUXL28RX+tY9A@mail.gmail.com>
Message-ID: <CA+FuTSdcT70_zyJHiMPT_HK8zJbTg72y-AO2XYUXL28RX+tY9A@mail.gmail.com>
Subject: Re: [PATCH net v2] net: Clarify the difference between
 hard_header_len and needed_headroom
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

On Thu, Sep 10, 2020 at 7:44 AM Xie He <xie.he.0141@gmail.com> wrote:
>
> The difference between hard_header_len and needed_headroom has long been
> confusing to driver developers. Let's clarify it.
>
> The understanding on this issue in this patch is based on the following
> reasons:
>
> 1.
>
> In af_packet.c, the function packet_snd first reserves a headroom of
> length (dev->hard_header_len + dev->needed_headroom).
> Then if the socket is a SOCK_DGRAM socket, it calls dev_hard_header,
> which calls dev->header_ops->create, to create the link layer header.
> If the socket is a SOCK_RAW socket, it "un-reserves" a headroom of
> length (dev->hard_header_len), and checks if the user has provided a
> header of length (dev->hard_header_len) (in dev_validate_header).

I think if you want to clarify, we have to be exact: [up to]
dev->hard_header_len. For protocols with variable length link layer
headers, the length is at least dev->min_header_len.

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
> setting needed_headroom. This means this usage is already adopted by
> driver developers.
>
> Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Cc: Eric Dumazet <eric.dumazet@gmail.com>
> Cc: Brian Norris <briannorris@chromium.org>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Signed-off-by: Xie He <xie.he.0141@gmail.com>

Thanks for trying to clarify the behavior.

This patch should target net-next.

> ---
>
> Change from v1:
> Small change to the commit message.
>
> ---
>  include/linux/netdevice.h |  4 ++--
>  net/packet/af_packet.c    | 19 +++++++++++++------
>  2 files changed, 15 insertions(+), 8 deletions(-)
>
> diff --git a/include/linux/netdevice.h b/include/linux/netdevice.h
> index 7bd4fcdd0738..3999b04e435d 100644
> --- a/include/linux/netdevice.h
> +++ b/include/linux/netdevice.h
> @@ -1691,8 +1691,8 @@ enum netdev_priv_flags {
>   *     @min_mtu:       Interface Minimum MTU value
>   *     @max_mtu:       Interface Maximum MTU value
>   *     @type:          Interface hardware type
> - *     @hard_header_len: Maximum hardware header length.
> - *     @min_header_len:  Minimum hardware header length
> + *     @hard_header_len: Maximum length of the headers created by header_ops
> + *     @min_header_len:  Minimum length of the headers created by header_ops

This does not help imho. The existing definitions were clear and more
exact: hardware (i.e., link layer) headers.

Even more explicit, the hardware headers here must (probably) match
those dictated by dev->type, such as ARPHRD_ETHER.

>   *
>   *     @needed_headroom: Extra headroom the hardware may need, but not in all
>   *                       cases can this be guaranteed
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 2b33e977a905..0e324b08cb2e 100644
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
> @@ -2937,10 +2940,14 @@ static int packet_snd(struct socket *sock, struct msghdr *msg, size_t len)
>         skb_reset_network_header(skb);
>
>         err = -EINVAL;
> +       if (!dev->header_ops)
> +               WARN_ON_ONCE(dev->hard_header_len != 0);

Please make clear in the commit message that this is not just a
comment clarification.


>         if (sock->type == SOCK_DGRAM) {
>                 offset = dev_hard_header(skb, dev, ntohs(proto), addr, NULL, len);
>                 if (unlikely(offset < 0))
>                         goto out_free;
> +               WARN_ON_ONCE(offset > dev->hard_header_len);
> +               WARN_ON_ONCE(offset < dev->min_header_len);

This is not necessary. If worthwhile, this would belong inside
dev_hard_header itself.
