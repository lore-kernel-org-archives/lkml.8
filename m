Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13388C433F7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE6FD206E9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 02:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595296997;
	bh=fxhi3TaR7fdeXNdX+9DGO5TrZu3rxIGdGIpUgsboGK4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eLc1jp59EGUfR2NNOoHxFrg/69dguh1k9b0k/1N58bkGorQvspiuX094tUpG1095e
	 xsCfhyaCRPKtNwQcC5NwW2Jzo56NiZwobU4nACG8a4bYh0AgsjcG7KYAqjL+e8EpUF
	 OqpC04Jqi8xGQkBU4Gm1TXr0oVmFYATC8Z6etmGI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgGUCDP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 22:03:15 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:40308 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGUCDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 22:03:14 -0400
Received: by mail-il1-f195.google.com with SMTP id e18so15070181ilr.7;
        Mon, 20 Jul 2020 19:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NI0Hxq+b23u61HCgb6cNvKoXwQP7jMZ4BvjN9EOpDkY=;
        b=lr1YtpAgVkUMHWVBrWztp1yWPkXXJcTDFsiuzJyH3+D0yPid/7pqtAixu5dU+nAsBZ
         BQZLG1pxLRcP90KBzQ8BZ8daiZkJ4qdZ0IDQKjpvfdSsCufg/4MW0hGJelwCrm/vGuWx
         +HHoloWbOexcbvdGrfElFFGKXp49LUI1UQsWu08L3SELCoroGPAeISLJ+cssbbsbEYhC
         A5nH3DLQYxrxKQDEIkNX8KgGvIFVFAjH0aJHUh8vpJeZoC359NlHVnOzkasYXt4a/cfl
         J/quffiJKMWrit3n76YuGot8i1s1lXLuyQPIDoy9s1RixJyII5LJyh8ImS+ItcWaCJUs
         elIg==
X-Gm-Message-State: AOAM530h0Ict9s7GnspqruN893aUbGidMELdcvlNyD2y7Qb4dZ6FJRyd
        tiYrqUD7GNcZviDtV3NfqA==
X-Google-Smtp-Source: ABdhPJzmsRID8T/oluWCq8KPBMnZBgnmkwCQskK/tjvFgX/rIZQhMljjjrf1/cVgMwDrcoB6A8xwkg==
X-Received: by 2002:a92:77d2:: with SMTP id s201mr26324309ilc.256.1595296993570;
        Mon, 20 Jul 2020 19:03:13 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id h5sm9883666ilq.22.2020.07.20.19.03.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 19:03:12 -0700 (PDT)
Received: (nullmailer pid 3376169 invoked by uid 1000);
        Tue, 21 Jul 2020 02:03:09 -0000
Date:   Mon, 20 Jul 2020 20:03:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Vinod Koul <vkoul@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        "David S. Miller" <davem@davemloft.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        netdev@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        linux-renesas-soc@vger.kernel.org,
        Sergei Shtylyov <sergei.shtylyov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        iommu@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 8/9] dt-bindings: net: renesas,ravb: Add support for
 r8a774e1 SoC
Message-ID: <20200721020309.GA3376098@bogus>
References: <1594676120-5862-1-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1594676120-5862-9-git-send-email-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jul 2020 22:35:19 +0100, Lad Prabhakar wrote:
> From: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> 
> Document RZ/G2H (R8A774E1) SoC bindings.
> 
> Signed-off-by: Marian-Cristian Rotariu <marian-cristian.rotariu.rb@bp.renesas.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> ---
>  Documentation/devicetree/bindings/net/renesas,ravb.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
