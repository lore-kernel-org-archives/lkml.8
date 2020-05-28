Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECD0C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3787E207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 20:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590696413;
	bh=eqYgS+Y1QQ0T0zGF4/FgYkCrrnsLTujM0Ss45eGJJuo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Bl5r7EqvLRndNLips3GT4psBuK/g2y5snK02qYnDHCJyJDsGnY8585dphyt/Hws9r
	 lZpZXq9QEqjPpJtLUbhnF+ZZI/7Cr2imP5lu03bOUC/8W6UNo6D4/Q6Dyp+/NA9PJw
	 lfk5Qs9OsVRHhG781zxr9UXhqCpK9yzLc+h+FY3o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406880AbgE1UGv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 16:06:51 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:43352 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406875AbgE1UGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 16:06:45 -0400
Received: by mail-io1-f67.google.com with SMTP id h10so31544920iob.10;
        Thu, 28 May 2020 13:06:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=alQRvIslSpoIEoACN2wgbbq5NpfmtJxPULKC8RXWn7c=;
        b=RqfIamkvy15C//LGF2QBPv/RD+Ff3IgupXNYASFghzxMNbT+W/hVSIVork2qLYoFXl
         QfaXWMb9F4ek9e4GZViuQbWNrjnP5xnJCyhdlyVAGKDB7W4MoCa1z2nU5rJOqHogjW7F
         HlKFygekZ/7E6SGd0PZnRHE+rFTEkgeM0r9wL7wt6gnU4YxvfwVnEe0w/uhiDQdT7xr+
         RrnRA3HJqf3uD1csiORvMVvla9xvBeqd3Klz33ULoBtEFGFi1CBsTe28UeIG5+uuPseu
         NhRE14v3iYA3qppENlr1GafioFKBeIyUg3XEDZCJxFB0CVvDT7NX4wPfe7nOQKLTdbLn
         vkWw==
X-Gm-Message-State: AOAM5333rWV6glcflKcL3/0SQA/ayepgHxLNOd/iDPUrmvec2HhOFdbx
        O9cPPaX7bo7sn2DOSskokw==
X-Google-Smtp-Source: ABdhPJyr03xCLZdtHeWGTNv1Qq8K/J3sq/Ku9AL1uvBEt9HD1IoWyB9VMTGmkFHQ2GOkMh+/h75cdg==
X-Received: by 2002:a05:6638:11c6:: with SMTP id g6mr4060864jas.134.1590696403582;
        Thu, 28 May 2020 13:06:43 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id s71sm3747140ilc.32.2020.05.28.13.06.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 13:06:42 -0700 (PDT)
Received: (nullmailer pid 594100 invoked by uid 1000);
        Thu, 28 May 2020 20:06:40 -0000
Date:   Thu, 28 May 2020 14:06:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v3] dt-bindings: gpio: renesas,rcar-gpio: Add r8a7742
 (RZ/G1H) support
Message-ID: <20200528200640.GA594044@bogus>
References: <1589557527-6057-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1589557527-6057-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 May 2020 16:45:27 +0100, Lad Prabhakar wrote:
> Renesas RZ/G1H (R8A7742) SoC GPIO blocks are identical to the R-Car Gen2
> family. Add support for its GPIO controllers.
> 
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v2->v3:
> 1: Rebased the patch as binding were converted into json format.
>    I have restored the Acks' from Geert and Rob
>    (https://patchwork.kernel.org/patch/11518759/).
> 
> v1->v2:
> * No change
> ---
>  Documentation/devicetree/bindings/gpio/renesas,rcar-gpio.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
