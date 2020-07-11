Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E02FC433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:43:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED72620674
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 01:43:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="OETpcIsZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NGRfGRRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726818AbgGKBnL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 21:43:11 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:40485 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726605AbgGKBnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 21:43:11 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 665F358046B;
        Fri, 10 Jul 2020 21:43:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 10 Jul 2020 21:43:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm3; bh=H
        LgEH/278Opa5rtB0os+SzkGd6M293q0r6hnuwndsH4=; b=OETpcIsZ/w7fLD9vI
        jxBVrbG1+yoNJiZDSsgRR33JmQ6otsy2LGhaP5Dq58q4YOwlkDpFzVee4Q7NBFx5
        z6WDuvdrTdQZsulT139LLHJDRLWo0FyX4Wd1ovAndYUIY0DDhXBEcRhsNtDnJ0+S
        0kWneIuFWNSU9NNNSlfgduIjawEU8G+ChV9JZImOcAeU6C/a76GNJ1apnk9i/GYw
        04XqQPMI7gsKz8zwRvmx60G+eARIou5YpUPipfz66JJgbFLH+Jiakjk0LKxpBM/i
        oXt1HLyNchf/qL9T5XdgS0F9cktz+a1uf5R+Djqbd1gESe+7nSd2ZNvN3gQ33tL6
        BO0kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=HLgEH/278Opa5rtB0os+SzkGd6M293q0r6hnuwnds
        H4=; b=NGRfGRRjGajfOa4oqWhCMRfPjEQ/fr7k8P05hv1bTcZujnTjc2hGyJ2rH
        yBU3GsXTSxgylf6z3muV57ukJ7bEtIsHwlS8raLVq+MPOgzPr3LJ0WETIoxx1SoA
        y2xy+qY2cvjB7DjEWXnCU0QXqWKpDJ3gsKEeVEw8YOSOc2Cl6Ge7Fq/0Cgu/SegO
        rJlovnUz+/AC8XExAQ1UM9LnAmP2rgaXJ1Cmh5/bJ8lwkjXSGMmukAyzCFF2stUi
        wPR3uBu+2dGAvKpz12iJgFKROAU1wHhYr9c8XRZxENr04vmytKXVXveKEupu9fJE
        RH7L81sjA0qET3942aOCdM/onOoVg==
X-ME-Sender: <xms:KhkJX8z8q--1SxP5KnunZarNkXEv-kogxKbThIpnzq0mIcMyDZUTKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrvddvgdehtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtkeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpefgleekudevjedtjefhieelvdfhgeegieeikeelhfeffeffffffgedu
    teetleeijeenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:KhkJXwQHYM1QAUstOd77deyOhQBUZff43ws-qBJIxN7USRUmFe8dWA>
    <xmx:KhkJX-XsQJ_88C10qwIzJiegM2XRZb0y6q1tAAMTgww0TmpKjWcUzA>
    <xmx:KhkJX6gHemG4by0MW23SaKB1d9f5LAEaQ4Shj8Uz7R_rzqNIN_17MA>
    <xmx:LBkJX_LcUWuqKwq4qdAKDUb-1Fpe50g72-jcW2_uCpIbXCPEqSepMA>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id AED6D328005D;
        Fri, 10 Jul 2020 21:43:05 -0400 (EDT)
Subject: Re: [linux-sunxi] [PATCH 01/16] ASoC: sun4i-i2s: Add support for H6
 I2S
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@siol.net>,
        peron.clem@gmail.com, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
References: <20200704113902.336911-1-peron.clem@gmail.com>
 <20200704113902.336911-2-peron.clem@gmail.com>
 <72a6fddf-5e84-f050-2eee-74178d457789@sholland.org>
 <3787973.dVgI16VYFl@jernej-laptop>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <6f183057-2c5b-2acf-4394-535ee09fe8db@sholland.org>
Date:   Fri, 10 Jul 2020 20:43:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <3787973.dVgI16VYFl@jernej-laptop>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jernej,

On 7/10/20 2:22 PM, Jernej Škrabec wrote:
>> From the description in the manual, this looks off by one. The number of
>> BCLKs per LRCK is LRCK_PERIOD + 1.
> 
> Are you sure? Macro SUN8I_I2S_FMT0_LRCK_PERIOD() is defined as follows:
> 
> #define SUN8I_I2S_FMT0_LRCK_PERIOD(period)	((period - 1) << 8)
> 
> which already lowers value by 1.

No, sorry, I had missed the subtraction happening in the macro. So there's no
problem here.

Thanks,
Samuel
