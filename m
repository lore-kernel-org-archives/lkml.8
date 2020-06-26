Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB96C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:18:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E8D420720
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 20:18:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="sy7tvbn+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725928AbgFZUSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 16:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725780AbgFZUSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 16:18:03 -0400
X-Greylist: delayed 395 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Jun 2020 13:18:03 PDT
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF9D5C03E979;
        Fri, 26 Jun 2020 13:18:03 -0700 (PDT)
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id D62985C0678;
        Fri, 26 Jun 2020 22:11:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1593202285;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A9NdSN7MzYe3M0t6hNqQzBzu71mmBpiOtRo4i0LRvN8=;
        b=sy7tvbn+ji/gBGJqBUa8HYHzAuAxCdhJbbPTslRq2V0vTuO9hEDm79LniRLOwxNGTw58RZ
        egNAoYnlJoXPP/s/OCXbJFMK8qh0AfSPuay0ZL2z3gO1i746FyerwSSU7pNz4z56hBL9q+
        LG1LVXc9MLRarpS92Zp89fP/9SnLqYo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Fri, 26 Jun 2020 22:11:25 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: vf610: Align L2 cache-controller nodename with
 dtschema
In-Reply-To: <20200626080547.3569-1-krzk@kernel.org>
References: <20200626080547.3569-1-krzk@kernel.org>
User-Agent: Roundcube Webmail/1.4.1
Message-ID: <ea533f120d67df5bea9d2224037ae895@agner.ch>
X-Sender: stefan@agner.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-26 10:05, Krzysztof Kozlowski wrote:
> Fix dtschema validator warnings like:
>     l2-cache@40006000: $nodename:0:
>         'l2-cache@40006000' does not match
> '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  arch/arm/boot/dts/vf610.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/vf610.dtsi b/arch/arm/boot/dts/vf610.dtsi
> index 7fd39817f8ab..956182d08e74 100644
> --- a/arch/arm/boot/dts/vf610.dtsi
> +++ b/arch/arm/boot/dts/vf610.dtsi
> @@ -10,7 +10,7 @@
>  };
>  
>  &aips0 {
> -	L2: l2-cache@40006000 {
> +	L2: cache-controller@40006000 {
>  		compatible = "arm,pl310-cache";
>  		reg = <0x40006000 0x1000>;
>  		cache-unified;
