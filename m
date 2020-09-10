Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99ED4C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E0F921D40
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 03:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Rgq9EPWW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgIJDTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 23:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbgIJDTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 23:19:50 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B77C061573;
        Wed,  9 Sep 2020 20:19:49 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id a12so4756704eds.13;
        Wed, 09 Sep 2020 20:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYnG8g1OXjCEZvsNS7qUv8EcZAN6EKkdlhqeP9kn+nY=;
        b=Rgq9EPWWGYiqY2DdgSyemU/sJRKCmZz0UNbwdRAGZUWF7DhqPv+cj2ifMs75KMOUdD
         Q4wAgKHTZJq0763WeDwq45zmTDP50AJpLLBiqwa6Mp/n11La+rwXwqPpddRTxjsNaidZ
         90aIPmV2siYV1gMpuKSAhznKUhi5e4al81epQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYnG8g1OXjCEZvsNS7qUv8EcZAN6EKkdlhqeP9kn+nY=;
        b=Oayc8dxFkJl8yXcFvcrZS/ro+OkKbaGLSU5ElOcEVPVcnwfCT8EbCiLhyayLEgRtmZ
         DTsU+hvKd+OWq9zVak1DJXshbBfCx6nfF2eLbilVm479ZFNB9XIX2rEBrPaZ+zX2avUE
         unEqFDzLbVzndjEo00jw3Eb4ar+5IyNVjrfb+TwW5dWLdpLlhFGsJ971iNEIrYg9zE5p
         epeVwAfewdZgfRjBi4laP4YAfwJ3uu5geUIvR/lmJjMzeXRHakQo+7XzqREsQmZl05S/
         qArBsvSaSaU5qTPkVrO9Y8QVdnHF7eXE0YK8AqfDfm526uD1avU240hFK1jpMjcGXvxn
         EMMw==
X-Gm-Message-State: AOAM53257KVWHr4djegjP++JIcuukw9dl9Xh9kwQpCA2aDlG6GggdrSu
        eBnzNwpUjAtmRmLFBuRy++UzvzPwGFHE3LTgSe/1itoqW1g=
X-Google-Smtp-Source: ABdhPJztvH21yX503RRfEKAijGeEVGzRJ2v0afoEPzzI9wed+4D7RjfpT7KicJHk4K8nd6aXIBoWTv2Yk6P1EFWq/Sc=
X-Received: by 2002:aa7:c38a:: with SMTP id k10mr7407719edq.325.1599707988052;
 Wed, 09 Sep 2020 20:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20200910031143.2997298-1-andrew@aj.id.au>
In-Reply-To: <20200910031143.2997298-1-andrew@aj.id.au>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 10 Sep 2020 03:19:34 +0000
Message-ID: <CACPK8XeZe2n_a56LGJ16VswvPwRu7jWcSCTH+3grJ5zY9Wq38g@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: rainier: Disable internal pull-downs on eMMC pins
To:     Andrew Jeffery <andrew@aj.id.au>
Cc:     Rob Herring <robh+dt@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 at 03:12, Andrew Jeffery <andrew@aj.id.au> wrote:
>
> There's a veritable tug-of-war going on in the design, so disable one of
> the warring parties.
>
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>

Applied to the aspeed tree for 5.10.

Cheers,

Joel

> ---
>  arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> index 1fa233d2da26..21ae880c7530 100644
> --- a/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> +++ b/arch/arm/boot/dts/aspeed-bmc-ibm-rainier.dts
> @@ -180,6 +180,10 @@ &emmc_controller {
>         status = "okay";
>  };
>
> +&pinctrl_emmc_default {
> +       bias-disable;
> +};
> +
>  &emmc {
>         status = "okay";
>  };
> --
> 2.25.1
>
