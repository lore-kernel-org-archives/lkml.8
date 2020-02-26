Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2222BC4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:14:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC87A2072D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582755286;
	bh=i+7/S81WydlhcrcdQ9KBb+ZDSbg6YX0wIuoqhIFxgeU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=XM+3g5yMqJt0tIXHAioJg77YSnqkbs/bHBrZIIAKzh0TSZ4jM3RXrtKBAQ05a74oa
	 8S4R9z5mFlfP90hAL9t83Pd4jCFhqzthom2dwzpr7Lj3EMAUv6JHQCJwmUXpTNC1dE
	 GQuGoiEol0eomSZyFkXGaAmkcxLrK5x+h4DyCWow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgBZWOo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:14:44 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37640 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727715AbgBZWOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:14:44 -0500
Received: by mail-oi1-f193.google.com with SMTP id q84so1220041oic.4;
        Wed, 26 Feb 2020 14:14:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bok3LP1w1qmqsuO1k7gdAuotciHOwlDqvixeOQYTb0o=;
        b=YGqpM8dZcGihH6WBlaxUkEguc+HOJxTEVgTtCCwcjVGb294UE8WCYrR66uqxmNw8Bc
         8K4fsUlLwl4kNNGO/OoKjacdA3BvZFEg36DCkaSbmHX2X1WATOcxS6fZDysszstO5i5D
         b1rJ9KPHQXijVVGzC8EukPXUD3A235ZmfWgpddYErNcOcIRVPY75Y1mtiC59HVRh+Ex/
         qsLbx1sTsup2e11ahGXWTJHbRMQDzKs84ck271oArGWmj8rB0RDkT8tVhk1kIPeKHTjc
         ClgRaLcvGVVfOptYTvlD94WSZVhFdv67Skl0D3N/s/EayEi5CMe5t4dXGMHPz0N59aHD
         84Qw==
X-Gm-Message-State: APjAAAWcu3pqsMf10plxJspB1GnPkNTb7SOTdtHrRq2ZgAWUpdQhelR9
        ZVWAs3MS0w3s+gYJYNUVHw==
X-Google-Smtp-Source: APXvYqxM2+l7pZyEyd1X9E2oBGjRy47x/nyBH4hVjeWJ+OHmmT1cq5nXasi2tof7gwpMjMdC0Ozchw==
X-Received: by 2002:aca:55cc:: with SMTP id j195mr1017627oib.22.1582755282012;
        Wed, 26 Feb 2020 14:14:42 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z21sm1229903oto.52.2020.02.26.14.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 14:14:41 -0800 (PST)
Received: (nullmailer pid 28496 invoked by uid 1000);
        Wed, 26 Feb 2020 22:14:40 -0000
Date:   Wed, 26 Feb 2020 16:14:40 -0600
From:   Rob Herring <robh@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        masahiroy@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vinod Koul <vkoul@kernel.org>, dmaengine@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] dt-bindings: dma: Convert UniPhier MIO DMA controller
 to json-schema
Message-ID: <20200226221440.GA28411@bogus>
References: <20200222112042.32345-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200222112042.32345-1-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Feb 2020 20:20:42 +0900, Masahiro Yamada wrote:
> Convert the UniPhier MIO (Media I/O) DMA controller binding to DT
> schema format.
> 
> While I was here, I added the resets property.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
> 
> Changes in v2:
>  - add 'resets'
> 
>  .../dma/socionext,uniphier-mio-dmac.yaml      | 63 +++++++++++++++++++
>  .../bindings/dma/uniphier-mio-dmac.txt        | 25 --------
>  2 files changed, 63 insertions(+), 25 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-mio-dmac.yaml
>  delete mode 100644 Documentation/devicetree/bindings/dma/uniphier-mio-dmac.txt
> 

Applied, thanks.

Rob
