Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC6CC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14CCF2087C
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 22:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599257835;
	bh=bX7jsLYv1sDhwAMVdGB1HKc5fPOJWIv3JMZCsUQRhXU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=kUDzt5VV74qb16OS7ysznpIr7eisRNPfLoOGEBBJHMltvApWWqVHNj+/234fLq4tU
	 05A/+PqWi5bhuAOUr8JY9inZtHu5Y892/8MnFBnajTNv5M8A8Q3X40/cXeYkaMW2yX
	 9xOfdczvHayc6E5CNAjq/u5BN9WA0DR4eIkWR2g4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728165AbgIDWRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 18:17:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:57124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727923AbgIDWRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 18:17:12 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D15B2087C;
        Fri,  4 Sep 2020 22:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599257831;
        bh=bX7jsLYv1sDhwAMVdGB1HKc5fPOJWIv3JMZCsUQRhXU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=RwJC9bb4ri2PkLMqdpflMpGBF1HicyiBsYa66hrWum4tFvjyg2bPeqy/0VfbNT59B
         sTM9wWrQjCVwmWSFz7woQsPVMySzrz8BpZZ53IzjSxPPmeAghZQYWfaokFj4OhgatP
         M4EgLx5jFGKV2ZBztosmHIrKvS37OYm0sAQuT/b4=
Received: by mail-oi1-f182.google.com with SMTP id x19so7965259oix.3;
        Fri, 04 Sep 2020 15:17:11 -0700 (PDT)
X-Gm-Message-State: AOAM532QhwA/gwhcj1srmi+XEiJ7jFsFE4vUahEj2HvmkCUnDlhuJsBl
        qAR+ZxJOl7GRARoEm5rhCycc+t0UFDMxs4cVhA==
X-Google-Smtp-Source: ABdhPJyUka2+LqTrKWWh2vZG6IjAbbBF7qEafdcyvuFmBaPyXr4hS/jGoe947KhJRNFwDqFgdvppdJC40GjGpFmIYPU=
X-Received: by 2002:a54:4197:: with SMTP id 23mr6662831oiy.106.1599257830894;
 Fri, 04 Sep 2020 15:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200904213730.3467899-1-f.fainelli@gmail.com> <20200904213730.3467899-2-f.fainelli@gmail.com>
In-Reply-To: <20200904213730.3467899-2-f.fainelli@gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 4 Sep 2020 16:16:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+EXvKkFoKgFA4gh7e-PPt0wLHHm3nR1RCqtubBTaj+dw@mail.gmail.com>
Message-ID: <CAL_Jsq+EXvKkFoKgFA4gh7e-PPt0wLHHm3nR1RCqtubBTaj+dw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] of: Export of_remove_property() to modules
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE" 
        <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 3:37 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> We will need to remove some OF properties in drivers/net/dsa/bcm_sf2.c
> with a subsequent commit. Export of_remove_property() to modules so we
> can keep bcm_sf2 modular and provide an empty stub for when CONFIG_OF is
> disabled to maintain the ability to compile test.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  drivers/of/base.c  | 1 +
>  include/linux/of.h | 5 +++++
>  2 files changed, 6 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
