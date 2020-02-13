Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AB8C3B188
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13FC20873
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 01:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="f3fRodTy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drnYkKGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgBMBn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 20:43:58 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:43773 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729285AbgBMBn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 20:43:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 0BBBC75F4;
        Wed, 12 Feb 2020 20:43:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Wed, 12 Feb 2020 20:43:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm1; bh=8
        T4iiTyw3eLQepB6swSO7o/IfktgWfWV0D82VwCjj/E=; b=f3fRodTyc87ROjGZg
        f6xhISXZ8IB4FeYJ2BWIeWPLgahI9JYegZPO7P3CcMH6/E4ydS7USxBYX2uSIqqS
        j62qH7kzAabWTmpAVWPikAKGKFD/QG5SFc6Od2kIc6ut7vCx200g/R3VVLgZSuNc
        VHmSqEkF1SY43S7Usd4yCT2NzLl0v23IpC2N+Hb/6RldnsWJJCeAFwMPy9jj0/rC
        oIUvhGpeCvQT7eyybmFmraHrBilL1k5ys8ollF57F1bJNZjx+hIO5ovAu8vCMOri
        8lIQetjnk/emqeAK9wG9NZbzoKw8BCAgyWSP7VduZfBv71R85r9vzKIUSEbtpHvR
        FLZKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=8T4iiTyw3eLQepB6swSO7o/IfktgWfWV0D82VwCjj
        /E=; b=drnYkKGaLTWK14k5w3ipnZ0N5vk+Z9lFw9AqTR7g3IZo/uZR3r4Pi215u
        BCNDdsa2swlyANH3o90lDNa9E2HJxm4mAVkX3MHXRVp/0G3azrsu0/lyCtV8Vy83
        IBLbA7B2MNJ2VQVbhgP7tmRBwBoh6IhpUoNIwCiQ7w+yOQQDv2vfwYI0UohX3QPc
        iCHZEnZgbhOXdzo3kkpNH+42s0oWlR7HDVWK4w0/kFbX2+ylgJySJ8tEld6jHMXE
        9L32xohyxvReK865aZXNm6GdMJ7y/l9+ajDXnzNI/HSC6DKK0dEsOtLsR6oVOn8j
        pzPgsmWTVCEvdRd6+bu8x1i/i+UiA==
X-ME-Sender: <xms:26lEXr8b79IcrzKys9NpAd6DwBB77LrlZx_bbpvVslYAvylDCO-JEQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrieejgdeflecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:26lEXr9f9XlBa5oH29pVAzdTfXbpVeaYIDa2u5YUyTRzjS8wwnXjYQ>
    <xmx:26lEXkBLPgkXz84vAue5vmJFLZ_p9mUjFH2TTkHEnYWC4MxW_ZKNZw>
    <xmx:26lEXryTINXz7iU6GoqyhRcI4gKucxJm_VTijjkYJmJ_nADf4geiLQ>
    <xmx:26lEXtsaxZdRgXSTUxrimXLAZYwEysseRnM26aYv-EFsaNnmo91MaQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 88B8C3060717;
        Wed, 12 Feb 2020 20:43:54 -0500 (EST)
Subject: Re: [PATCH v6 0/6] Allwinner sun6i message box support
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20200113051852.15996-1-samuel@sholland.org>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <36f1fee4-c2b7-af55-d867-21edd6bf1e56@sholland.org>
Date:   Wed, 12 Feb 2020 19:43:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200113051852.15996-1-samuel@sholland.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jassi,

On 1/12/20 11:18 PM, Samuel Holland wrote:
> This series adds support for the "hardware message box" in sun8i, sun9i,
> and sun50i SoCs, used for communication with the ARISC management
> processor (the platform's equivalent of the ARM SCP). The end goal is to
> use the arm_scpi driver as a client, communicating with firmware running
> on the ARISC CPU.
> 
> I have tested this driver with various firmware programs and mailbox
> clients on the A64, H5, and H6 SoCs (including specifically the arm_scpi
> driver), and Ondrej Jirman has tested the driver on the A83T (using a
> similar patch to arm_scpi).

Ping. Any comments on this? Can this be merged?

Thanks,
Samuel Holland
