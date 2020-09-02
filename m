Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C509C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:34:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD78A208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 14:34:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqX9sYhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgIBOeO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 10:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbgIBOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 10:33:55 -0400
Received: from mail-vk1-xa44.google.com (mail-vk1-xa44.google.com [IPv6:2607:f8b0:4864:20::a44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D73C061245
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 07:33:55 -0700 (PDT)
Received: by mail-vk1-xa44.google.com with SMTP id t189so1260079vka.10
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GTgJ8jRvYHfsaCYMvrvH0r8WVjN4146hJg98Kfc6e3E=;
        b=GqX9sYheDnvfIvKTFK/YljPYXr+3kQcZ5oeuEyfjrmPv9ynxsoVZe1l347TGAbC+Rp
         rEvI0xz61c68O22SRUFr+GZTyhQ+UdS7P+IDlWIamL7aM5WBSJmp8LD3ICvXd6fYhJOj
         21cSc2kz+u10AgNpfA9qcMnUMYrAYW86iQI6sUoPi7zjVTcTR2jigazQAZ25eq21E/WF
         mjDqeDGhHfwiALlh1OkrVcNqZMcpZOqRDelWt04/+Em4OXmFpgWfbFaT1nKFsS6o8CXX
         F7DQO15/wvL/9NZF7GjQ4HKldIVHxa7y2XhS3m6tk3zyNHM3vlL5gkmrgOhY1ubPQYu4
         nKHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GTgJ8jRvYHfsaCYMvrvH0r8WVjN4146hJg98Kfc6e3E=;
        b=hXl5Stm3EiJL38/xOuhE2l1zpfEJb4o9zUYhS0l8S+4cHbYmJVSO/R+uA77/YDnJaS
         uGvsCJXQEchJvjNqOuNk/FFC6n5FQ3fTES8iTai/kjIezmTK4RgrYl3emRntPEtOP3aj
         W0oKN3Q30gKVg+zZlVu8ukKqE9jm8kl6NX1gH9pjSIvAeG8kuTfm3cbTc/dF58iZjVAi
         pFlHYLBqudq22iJ+7be95gULIDD/Ek2j6LRCgUhPYzVyCwDlc6K7cwYxun3dQ0bPyITP
         /Layd8YbxLoLGUlZ9/L2vlqVgJVnVQfxL2FpFFbx5AH2YsW0+oPEQzY3YSYtooVKRI7c
         VG+Q==
X-Gm-Message-State: AOAM532Eiw7E3gob8Z0Icl1LiB1Mg17h2Q54PzMgk8deG4s3BUSgNMYZ
        VtW+E7DppQ7JcEQ8SItEcBz6+/y4MHfUhw==
X-Google-Smtp-Source: ABdhPJyges5I9Vf40gyBUf53h8e1zVIrwWHbelkPigorcl2HS2A2vUsE2Wl8vYzB+1fUu+9DSME7Dw==
X-Received: by 2002:a1f:2444:: with SMTP id k65mr5461792vkk.33.1599057233315;
        Wed, 02 Sep 2020 07:33:53 -0700 (PDT)
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com. [209.85.222.48])
        by smtp.gmail.com with ESMTPSA id h27sm791621vko.38.2020.09.02.07.33.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 07:33:52 -0700 (PDT)
Received: by mail-ua1-f48.google.com with SMTP id g16so1156714uan.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 07:33:51 -0700 (PDT)
X-Received: by 2002:a9f:2237:: with SMTP id 52mr1270900uad.141.1599057231345;
 Wed, 02 Sep 2020 07:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <1599048911-7923-1-git-send-email-tanhuazhong@huawei.com>
In-Reply-To: <1599048911-7923-1-git-send-email-tanhuazhong@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Wed, 2 Sep 2020 16:33:13 +0200
X-Gmail-Original-Message-ID: <CA+FuTSc_KOZRTdh34Vw3gTCzGMmi5XvDZKjpWMOXw7aby53wqw@mail.gmail.com>
Message-ID: <CA+FuTSc_KOZRTdh34Vw3gTCzGMmi5XvDZKjpWMOXw7aby53wqw@mail.gmail.com>
Subject: Re: [RFC net-next] udp: add a GSO type for UDPv6
To:     Huazhong Tan <tanhuazhong@huawei.com>
Cc:     David Miller <davem@davemloft.net>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        salil.mehta@huawei.com, yisen.zhuang@huawei.com,
        linuxarm@huawei.com, Jakub Kicinski <kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 2:18 PM Huazhong Tan <tanhuazhong@huawei.com> wrote:
>
> In some cases, for UDP GSO, UDPv4 and UDPv6 need to be handled
> separately, for example, checksum offload, so add new GSO type
> SKB_GSO_UDPV6_L4 for UDPv6, and the old SKB_GSO_UDP_L4 stands
> for UDPv4.

This is in preparation for hardware you have that actually cares about
this distinction, I guess?


> diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
> index 2cc3cf8..b7c1a76 100644
> --- a/include/linux/netdev_features.h
> +++ b/include/linux/netdev_features.h
> @@ -54,6 +54,7 @@ enum {
>         NETIF_F_GSO_UDP_BIT,            /* ... UFO, deprecated except tuntap */
>         NETIF_F_GSO_UDP_L4_BIT,         /* ... UDP payload GSO (not UFO) */
>         NETIF_F_GSO_FRAGLIST_BIT,               /* ... Fraglist GSO */
> +       NETIF_F_GSO_UDPV6_L4_BIT,       /* ... UDPv6 payload GSO (not UFO) */
>         /**/NETIF_F_GSO_LAST =          /* last bit, see GSO_MASK */
>                 NETIF_F_GSO_FRAGLIST_BIT,

Need to update NETIF_F_GSO_LAST then, too.
