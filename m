Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1EBCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:46:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9598A207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 13:46:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+OXNP3C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgHNNqk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 09:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgHNNqh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 09:46:37 -0400
Received: from mail-vk1-xa42.google.com (mail-vk1-xa42.google.com [IPv6:2607:f8b0:4864:20::a42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF5D7C061384
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:46:36 -0700 (PDT)
Received: by mail-vk1-xa42.google.com with SMTP id l184so2010743vki.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=30BzHOMWkpYticntxIn5D2wVFVe2pdTakVPv+YwkfO0=;
        b=E+OXNP3C2gPG31JY2im+qLw5HH7P030ku1k6hC3PnAFxodip+0/dMY6H0lUxWYVr67
         7AxFd5vkVIvEUWjrRpdHZzKB1uf8BtTuLLwAtPxo8SqCHfnP/MCqq6rLKqAXCTMiamEv
         Nvc2pWMcEDO42QVoILw6sn3pn6X8FGJiZwEiQKCnegW7d5/PNJu6JxEcGH18tODSuJgA
         ZHhQV7uUOh6i3IGmOb+Qw3lvubwOvAiOs391nsfsFQ7tPlqaViy2+XKuiBWqeAkPcHEY
         N/KXgI9PAyBADrdQUnLDrZsdiLkDk1NA4knHWJyf4safdh2FEmQTEk4VXYy04+zLGllu
         WavQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=30BzHOMWkpYticntxIn5D2wVFVe2pdTakVPv+YwkfO0=;
        b=aYUlzoumt03nRhm/W7dkS2FKva5sdb6hevepNqJjiDjYa8/BIDtoHaZm9eCHmaH+oS
         WFkyD8qBgdtCC5qJ5CtNGxqU5Hkf4mt3AKSNxnn1+6Pj7T42ilRnI6sPM0+VfkaI3W7i
         c3airTxPewEvIkJXCbRICxcMhxjF3vVK4+pHOQ2A9opE/UT3pZwdiUYLb5twDX0Yn1dI
         qkvijOIBpXtKLhkG2lKj5YByVQ6L2UPgbP1VRsJDSzg3X20PydNFL1ZSC2T0WgkSx9G3
         5kirMuUjnYcYT9DJ9Z2NFjCbHoU/ksI66Hedir+swwHqAlPYF/Jze7v2QmSCxdcUNSC+
         O8Bg==
X-Gm-Message-State: AOAM533XdLaEzWka9Ki7aCT/9za4gx2ciqlmWWx1Dp8S5cAqWq8ipdMn
        XPbKocjueyDgLP/ioRE5AGYya0XQPvMbsw==
X-Google-Smtp-Source: ABdhPJxvq1vI1afLdTe9G/X9NOkA+CAtS84zhB7MWihUj7odKcYtcN92GDv0WtAHdKqrTljpqthXgw==
X-Received: by 2002:a1f:a0c3:: with SMTP id j186mr1508417vke.76.1597412794992;
        Fri, 14 Aug 2020 06:46:34 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id y6sm1503395vke.35.2020.08.14.06.46.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Aug 2020 06:46:34 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id y17so2656674uaq.6
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 06:46:34 -0700 (PDT)
X-Received: by 2002:ab0:1892:: with SMTP id t18mr1348930uag.108.1597412793876;
 Fri, 14 Aug 2020 06:46:33 -0700 (PDT)
MIME-Version: 1.0
References: <e9b280b79ba444a68f5279cea77a84bf@huawei.com>
In-Reply-To: <e9b280b79ba444a68f5279cea77a84bf@huawei.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Fri, 14 Aug 2020 15:45:58 +0200
X-Gmail-Original-Message-ID: <CA+FuTSczcJPgTzi5+UP8NnXX0PAH_PAiEuyzS69A5_YA3y81Gg@mail.gmail.com>
Message-ID: <CA+FuTSczcJPgTzi5+UP8NnXX0PAH_PAiEuyzS69A5_YA3y81Gg@mail.gmail.com>
Subject: Re: [PATCH] net: add missing skb_uarg refcount increment in pskb_carve_inside_header()
To:     linmiaohe <linmiaohe@huawei.com>
Cc:     Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Florian Westphal <fw@strlen.de>,
        "martin.varghese@nokia.com" <martin.varghese@nokia.com>,
        "pshelar@ovn.org" <pshelar@ovn.org>,
        "dcaratti@redhat.com" <dcaratti@redhat.com>,
        Eric Dumazet <edumazet@google.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Shmulik Ladkani <shmulik@metanetworks.com>,
        Yadu Kishore <kyk.segfault@gmail.com>,
        "sowmini.varadhan@oracle.com" <sowmini.varadhan@oracle.com>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 9:20 AM linmiaohe <linmiaohe@huawei.com> wrote:
>
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >On Thu, Aug 13, 2020 at 2:16 PM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> If the skb is zcopied, we should increase the skb_uarg refcount before
> >> we involve skb_release_data(). See pskb_expand_head() as a reference.
> >
> >Did you manage to observe a bug through this datapath in practice?
> >
> >pskb_carve_inside_header is called
> >  from pskb_carve
> >    from pskb_extract
> >      from rds_tcp_data_recv
> >
> >That receive path should not see any packets with zerocopy state associated.
> >
>
> This works fine yet as its caller is limited. But we should take care of the skb_uarg refcount for future use.

If a new application of this interface is proposed, the author will
have to make sure that it is exercised correctly.

> On the other hand, because this codepath should not see any packets with zerocopy state associated, then we
> should not call skb_orphan_frags here.

I'm also not convinced that the skb_orphan_frags here are needed,
given the only path is from tcp_read_sock.
