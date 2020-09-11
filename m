Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C002C2D0A7
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:17:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A2D3208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 01:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nwOJbGJ5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725779AbgIKBRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 21:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKBRB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 21:17:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9A3C061573;
        Thu, 10 Sep 2020 18:17:00 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id i26so11478447ejb.12;
        Thu, 10 Sep 2020 18:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qCmr6GtTRUVNMstlQGu5HfhuoPvjXOmhgGjk3oqJXP8=;
        b=nwOJbGJ51iJS9jtAMnqK7Mm5zybB2q3TkewTWxpS2zj8xyhXGMLedCMmXmrPzs7oS2
         zSeD2YzMLSrMu5LaX3YpAg/+prqmC7yhd8lPXYfIHA0M/hw6OTDyW3AFrEdNf5oPkTEX
         iFRNxsoc2P3AzxDHx1/eiNpFAYbT+bxbE5nMk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCmr6GtTRUVNMstlQGu5HfhuoPvjXOmhgGjk3oqJXP8=;
        b=VLfFE8/47WLwhsYzhaFZAelyYov/pHGKcxtIu2GFIz4brOz7Afr2RAX7jvtu6jFVBN
         Lq466CtPAAU+Sy5H3T2kfecJJUu36aVOw00LT7g08C++YHRhUZGj7QSiTx0lEq6YZN+y
         ykSanlMh96p9eTb6oHH+HLIJf7eFXX+MuXRPcHqsYfIbwURn3YMIHqGU0EGWYAKkTe5B
         tKpXjt5kSZzSeDsYdgVlcjBf9HvZjTei+d7j3mqRkUuc8lUu0b9IB2nkRLqje0KxrneS
         Psn2rEeliytBfWdDNUDYdeboLRmBv/uzFGEoMJe5DWmV7sOEY2OrOQznMFI22sFwkQB2
         r5og==
X-Gm-Message-State: AOAM531fduVFDdFpSu2EK7fAJ4ROBGgyJW96E6yzlGYYxU0KONmk+/tA
        DhylxuUnJa6UvAAiEmIfDwPQ1NeKGUgHNtF37y4=
X-Google-Smtp-Source: ABdhPJxznsa97+hjW+1Lf952YVMsO/Bg3uH+xCCYEp+PmEnbqsZ0PhKvpFXk2mt41KaSjH7q9joy2tNFywgTif3/PSI=
X-Received: by 2002:a17:906:8401:: with SMTP id n1mr11400758ejx.215.1599787016868;
 Thu, 10 Sep 2020 18:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200910151840.25333-1-eajames@linux.ibm.com> <20200910151840.25333-4-eajames@linux.ibm.com>
In-Reply-To: <20200910151840.25333-4-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Fri, 11 Sep 2020 01:16:44 +0000
Message-ID: <CACPK8XdTsDtDAvaNrz7e3hGXdcx_1=A0vPuTiXF7GhnWQrQi3g@mail.gmail.com>
Subject: Re: [PATCH 3/4] dt-bindings: fsi: Aspeed master: Add bus-frequency property
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        linux-fsi@lists.ozlabs.org, Andrew Jeffery <andrew@aj.id.au>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jeremy Kerr <jk@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Sep 2020 at 15:18, Eddie James <eajames@linux.ibm.com> wrote:
>
> Document the bus-frequency property.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

I think this is good terminology, and it's consistent with similar
protocols such as i2c.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> index a513e65ec0c9..d84bd19526ca 100644
> --- a/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> +++ b/Documentation/devicetree/bindings/fsi/fsi-master-aspeed.txt
> @@ -17,6 +17,7 @@ Optional properties:
>
>   - fsi-routing-gpios: GPIO for setting the FSI mux (internal or cabled)
>   - fsi-mux-gpios: GPIO for detecting the desired FSI mux state
> + - bus-frequency: the frequency of the FSI bus
>
>
>  Examples:
> --
> 2.26.2
>
