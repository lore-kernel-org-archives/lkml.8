Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C94C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7856620797
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 13:29:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n6QTs08V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730430AbgIDN3G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 09:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730301AbgIDN1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 09:27:13 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3A5C061245
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 06:26:58 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id n12so1630769vkk.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EcvtgMkqtV+QMekKVdpR7+VGa/x86DjVYJCvIcGjyK8=;
        b=n6QTs08VggzC4TRruzKbItvKGOXVLpbSHGflONYffbYUuhXodFEZk5rF2ce4lJVCXf
         G/jZYiUQij/ybyYI7bQq22YLon4jSFDP5yI0O/J6OCCXtXh8xugcnhAJL5AXEPEY7i9d
         wa6m2CbLmR2x1kqwCOezY7lUGIPtejJ2i6AzkpMb5wGrYJuwWbSqnOFbiT2iOIKdVPab
         IdXRhxQBEzVvvJfGJNRGlw5fTGQmiw4rel47Vz7ph4VKhOfM0m8KzYBmJ5gEOHiiW+5g
         q1s6x3oOQduGCeCPapiRP+y3UfC1IuNOsIM2t0SzVzcD/MlpLtKoSFyFsLC5HaX52JuJ
         creg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EcvtgMkqtV+QMekKVdpR7+VGa/x86DjVYJCvIcGjyK8=;
        b=UJ66zduO3QVRVlBI5WnptFEbkRnWqTbHGrcu8FOobGY5u/glr+HCfiKmZUKLV3Nld4
         XaUrjYEC9mOcSSGLqF4VHCiFZ1kiq20KPV9MRuqcsgpU2DSlT67o8MNBhEEwcRNvz+dz
         RZMENvhIcTmsL/41XwBYbsWD9zeFc82C0dGRJDiGh2XWQGsYBP+aSwvTwzq6dY+meF49
         YIY06AczxUGueTN5eswtBfRV/6183IJlL7jLjdaop0v2rW2cT3mKPtbTGDgZt0atjVWL
         325D8MyI/wqVoXpj7yd+e1SSDE1d0ohQ2qqzQ+nSg+L6cXvUAbgl5N6VlNPByJ6tBxyC
         a0JA==
X-Gm-Message-State: AOAM531rtX1vzjK6gGw6AqXiDy692sCyKNPUx8GeynBEdivKUnXAB8U4
        RDQOjKeP3hg9L/pGvmRMN1NL8UCH8ldTEw==
X-Google-Smtp-Source: ABdhPJwlbrvWuGQ5zozJvJoMDK+c8M+iXnvt+HvpIEyrA+5KOmXBLc/CHtUHKBxAZDgtrPIkRjigJA==
X-Received: by 2002:a1f:a0c3:: with SMTP id j186mr5352851vke.76.1599226016801;
        Fri, 04 Sep 2020 06:26:56 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id c16sm557937vsh.5.2020.09.04.06.26.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 06:26:55 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id s29so1999390uae.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 06:26:54 -0700 (PDT)
X-Received: by 2002:ab0:2404:: with SMTP id f4mr4707114uan.108.1599226014262;
 Fri, 04 Sep 2020 06:26:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200904130608.19869-1-wanghai38@huawei.com>
In-Reply-To: <20200904130608.19869-1-wanghai38@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 4 Sep 2020 15:26:18 +0200
X-Gmail-Original-Message-ID: <CA+FuTSfMO4YPGp88HYRPWwRUCg79SVyYicOowCH9oJkKPtmdLA@mail.gmail.com>
Message-ID: <CA+FuTSfMO4YPGp88HYRPWwRUCg79SVyYicOowCH9oJkKPtmdLA@mail.gmail.com>
Subject: Re: [PATCH net-next] net/packet: Remove unused macro BLOCK_PRIV
To:     Wang Hai <wanghai38@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Mao Wenan <maowenan@huawei.com>, jrosen@cisco.com,
        Arnd Bergmann <arnd@arndb.de>,
        Colin King <colin.king@canonical.com>,
        Eric Dumazet <edumazet@google.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 3:09 PM Wang Hai <wanghai38@huawei.com> wrote:
>
> BPDU_TYPE_TCN is never used after it was introduced.
> So better to remove it.

This comment does not cover the patch contents. Otherwise the patch
looks good to me.

> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
>  net/packet/af_packet.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index da8254e680f9..c430672c6a67 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -177,7 +177,6 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
>  #define BLOCK_LEN(x)           ((x)->hdr.bh1.blk_len)
>  #define BLOCK_SNUM(x)          ((x)->hdr.bh1.seq_num)
>  #define BLOCK_O2PRIV(x)        ((x)->offset_to_priv)
> -#define BLOCK_PRIV(x)          ((void *)((char *)(x) + BLOCK_O2PRIV(x)))
>
>  struct packet_sock;
>  static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
> --
> 2.17.1
>
