Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E548C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 194EE20768
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:25:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgFZNZo convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726013AbgFZNZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:25:44 -0400
X-Greylist: delayed 492 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 26 Jun 2020 06:25:43 PDT
Received: from unicorn.mansr.com (unicorn.mansr.com [IPv6:2001:8b0:ca0d:8d8e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1893C03E979;
        Fri, 26 Jun 2020 06:25:43 -0700 (PDT)
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 7F4E515360; Fri, 26 Jun 2020 14:17:27 +0100 (BST)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: dts: tango: Align L2 cache-controller nodename with dtschema
References: <20200626080543.3511-1-krzk@kernel.org>
Date:   Fri, 26 Jun 2020 14:17:27 +0100
In-Reply-To: <20200626080543.3511-1-krzk@kernel.org> (Krzysztof Kozlowski's
        message of "Fri, 26 Jun 2020 10:05:43 +0200")
Message-ID: <yw1x5zbevue0.fsf@mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzk@kernel.org> writes:

> Fix dtschema validator warnings like:
>     l2-cache-controller@20100000: $nodename:0:
>         'l2-cache-controller@20100000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Acked-by: Mans Rullgard <mans@mansr.com>

> ---
>  arch/arm/boot/dts/tango4-common.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/tango4-common.dtsi b/arch/arm/boot/dts/tango4-common.dtsi
> index 54fd522badfc..d584da314500 100644
> --- a/arch/arm/boot/dts/tango4-common.dtsi
> +++ b/arch/arm/boot/dts/tango4-common.dtsi
> @@ -51,7 +51,7 @@
>  		};
>  	};
>
> -	l2cc: l2-cache-controller@20100000 {
> +	l2cc: cache-controller@20100000 {
>  		compatible = "arm,pl310-cache";
>  		reg = <0x20100000 0x1000>;
>  		cache-level = <2>;
> -- 
> 2.17.1
>

-- 
Måns Rullgård
