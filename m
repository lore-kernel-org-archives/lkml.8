Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F68AC55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFEA2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 23:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="K/lTPU4i";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FFBV6YEE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgDVXu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 19:50:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52027 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725846AbgDVXu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 19:50:58 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 672565C024C;
        Wed, 22 Apr 2020 19:50:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 22 Apr 2020 19:50:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=v
        ZGbnC8RdlpxgKLz2nXfyLccHHit/zhrLhFtuEcHKTc=; b=K/lTPU4iiQf6FH5rw
        0zf9PwVrEUeYd37vwn0BW7dSg81WiTB9rQG3DlWhbrai7UvMaIE2vv+glKdGHUgH
        Kgw250BFWps6RmrMnkd/qf9ivkitUxm7Ef2FOmusU2QrRuvxZ660c776xDQgt2Ih
        c0S2zPl8JM3tmbYTjWS49vf+C60UQ8jaAWd3oO1TG2KBMSsRdLx6v5dm65+18KxK
        lKcuGrCQfitpYqvyZjhlFdEtMxo/9iOKMagPcPgb/e2CNB4DTFj/fh6HjwR+nkd3
        /7XSrBXpJ69IzHBMbVE7tedAnXfJ3m9gyoMD6eQRJiD5gbB8qdQcq5wlwMjjjmez
        E9eBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=vZGbnC8RdlpxgKLz2nXfyLccHHit/zhrLhFtuEcHK
        Tc=; b=FFBV6YEE06fvGorfmJ+6zAncPHAXA+6LE+QoMK1qUv8MYOPhoFJHgp6z8
        ei/NzXteugeW7ZOyzjkw+lykJYRWeBz9NKiUm5BSPZpCO4dTqx4HYnQTdDU+Ie96
        r7EIjvGc0Uj3bBnnJdw2R/ehtg6Q0p6vuDTcIAzjajW/cYkwOAKCi6NRrltjVxro
        1BquSDZcjyqJ8bNXCSq2sfXamazkNbIXC5T3hLmVp/b1OILwA9+AoUzN//+CrhWx
        aXpcE8hHC0FA2cQP19WJZutpRmoCglBmGA3RY7MC+OvNv47NWV1VbRflZ6wSDjZN
        K//MOl+yvwehsxTu4fkGhOjKvN7lg==
X-ME-Sender: <xms:YNigXu2IquSGcQPJpUfESJf0wxsif3Xeghy6QJa3A3GEQ9LKJKkgMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduhedrgeekgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:YNigXrXYWA6_dxSXpXeRQovQ0O2ptgPTobJoFV97fswf3McTyqSC1w>
    <xmx:YNigXoqxZJj3dTZf3NK6-xPLPTlmXwmMZ0JRmfnxLXuziEjHiFG01w>
    <xmx:YNigXkbZv5yWWb2Q4fAUt7WxoWYC0Yo3IPqlIG0jjMRTfHNfWRzomA>
    <xmx:YdigXp0nXKljZYZIzOMW5y_t1v-x59e_T-speuINAiwbz_7FUjdUUQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id BC5863065CF7;
        Wed, 22 Apr 2020 19:50:55 -0400 (EDT)
Subject: Re: [PATCH] arm64: dts: allwinner: a64: Disable SPDIF by default
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
References: <20200422041502.7497-1-samuel@sholland.org>
 <20200422151616.httmhmo2tbd4m4eu@gilmour.lan>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <b554ea70-16da-1637-d349-db51dddcf95b@sholland.org>
Date:   Wed, 22 Apr 2020 18:50:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200422151616.httmhmo2tbd4m4eu@gilmour.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Maxime,

On 4/22/20 10:16 AM, Maxime Ripard wrote:
> On Tue, Apr 21, 2020 at 11:15:02PM -0500, Samuel Holland wrote:
>> As of v5.7-rc2, Linux now prints the following message at boot:
>>
>>   [   33.848525] platform sound_spdif: deferred probe pending
>>
>> This is because &sound_spdif is waiting on its DAI link component
>> &spdif to probe, but &spdif is disabled in the DTS. Disable the
>> audio card as well to match.
>>
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
> 
> The patch looks good, but don't we have some boards with SPDIF enabled that
> should be modified accordingly?

I don't see any in-tree. The only A64 DTS that references &spdif at all is
sun50i-a64-pine64.dts, which explicitly disables it:

	/* On Euler connector */
	&spdif {
  		status = "disabled";
	};

I'm leaning toward agreeing with Clement that the sound_spdif node (and also
spdif_out) should be removed altogether from the A64 DTSI.

Regards,
Samuel
