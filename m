Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86F0CC2D0F0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CD402063A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 16:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="dLRSLCXF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pV/3AZI7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387946AbgDAQzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 12:55:42 -0400
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:45731 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733298AbgDAQzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 12:55:38 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A2F2C5800E4;
        Wed,  1 Apr 2020 12:55:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Apr 2020 12:55:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=1
        HvVrQVgf8h1xwI4xlSisY5uAmH78ioNToEd5ZqROGo=; b=dLRSLCXF4QI/ZvstT
        RTK/iKO7vJFrPwPmtUOFhf71BqNsFb9xL5thVfMoFcY8Z1KdDJrtiBN9x0XDxX6R
        WDYmkfZ0VtyLDjfvKrF0t6rRZ3TUVu9kU0i2UzUWfKhSSIFbDnraFtPppKAJB7be
        kiYF8FWjEAQR3qeifFoLajBSPF43EP0JqkTXcOq6rDlRn7s5fC1SzUIfVzVargsI
        iuF9dj8uYJhodSktI7ajo2LwysdyM/5iDLWJhT6Ykzp5EkJef8qAR57TafoLwAuW
        EJo5wDMk8sinT6vK9NIZcTGJ68eH8PvkpnKd1mYYwgB2p62neUW+7rpbqnU+S4Sn
        I5vvw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=1HvVrQVgf8h1xwI4xlSisY5uAmH78ioNToEd5ZqRO
        Go=; b=pV/3AZI7xio9jPNP/fQsHuqkYqEftJWH2VRcjCrZpmJ5hn7/JJ1nXZj0U
        zxQq6KAnO+Dx/QIbe4KTTMGLw0OJKJ2zrwoJlHTOOhHKvWOhWPbM4t4t27hCXvBJ
        pyd6NLuCV82QXwlN57vspRGKjTXNGtMtAxnvD24VXi9LxaKvVxM/h6rWkZ/QFiZn
        QVvCWY8+3wP40ns/o7yt7etVkCHQ1RCk6keyLgywj1DVnd9jt3zhrPiHkBisYqNK
        n/laYmia4QoMeAOCmU6tNTwsl2o2uVjszN6aBFwOyPE0n5oOD42i1cA6WLtvVtIF
        x+om72uu9LgFVzPzURFYCtuScpbOg==
X-ME-Sender: <xms:h8eEXi_AC7cBT8VflyA_pQ4vzWVbRahRqpTXNfmfILTHnHsDFFJS1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrtddvgddutdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepuffvfhfhkffffgggjggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuff
    homhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepjedtrddufeehrddugeekrdduhedu
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmh
    huvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:h8eEXjA83Kbeeuchm-TFfZ-_rgepSDMLFcq6TLmo-TQ6RkH4jBXvfg>
    <xmx:h8eEXvqjowOwm8XxVq6BQhy3O4iesWDDdywZyitqcrxONwrF05ZIow>
    <xmx:h8eEXlEfqVLVCSou99VtCYzV9opFB3iwNNE99Q3kmsEEQolVgonZGA>
    <xmx:iMeEXhRRLxhty-Sm4IOQ0Odd5b6pnsFRi6C9HwCwbRdbaPBi-OpyJA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF8CD3280065;
        Wed,  1 Apr 2020 12:55:34 -0400 (EDT)
Subject: Re: [PATCH v7 0/6] Allwinner sun6i message box support
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>
Cc:     Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20200223040853.2658-1-samuel@sholland.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <59dc1ee9-a369-7cf9-df6a-4b5b99e24324@sholland.org>
Date:   Wed, 1 Apr 2020 11:55:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200223040853.2658-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/20 10:08 PM, Samuel Holland wrote:
> Samuel Holland (6):
>   dt-bindings: mailbox: Add a binding for the sun6i msgbox
>   mailbox: sun6i-msgbox: Add a new mailbox driver

These two patches have been applied for 5.7[1], so the DTS changes should be
ready to apply as well.

[1]:
https://lore.kernel.org/lkml/CABb+yY0-q+5+pqP-rBHCYpw-LmT+h80+OU26XL34fTrXhO+T3Q@mail.gmail.com/

Cheers,
Samuel

>   ARM: dts: sunxi: a83t: Add msgbox node
>   ARM: dts: sunxi: h3/h5: Add msgbox node
>   arm64: dts: allwinner: a64: Add msgbox node
>   arm64: dts: allwinner: h6: Add msgbox node
> 
>  .../mailbox/allwinner,sun6i-a31-msgbox.yaml   |  80 +++++
>  arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
>  arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
>  arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  10 +
>  arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
>  drivers/mailbox/Kconfig                       |   9 +
>  drivers/mailbox/Makefile                      |   2 +
>  drivers/mailbox/sun6i-msgbox.c                | 326 ++++++++++++++++++
>  8 files changed, 457 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
>  create mode 100644 drivers/mailbox/sun6i-msgbox.c
> 

