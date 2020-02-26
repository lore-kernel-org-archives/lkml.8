Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FCBC4BA1F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:28:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E798222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582738084;
	bh=nQh/Bo/NBb5ljRBYa8nIGyLcht5dYXUQX4KXscm8GX8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=e/Iwh2aQ8I1oYUAlCZqtCz2V2cJ+rbXNzBvn+tknBgm+IaMngGPoVq4yjq0HF/3e6
	 pRYvrlQLwQpjr8ML4PrBhbfT3ve7EJZHyvfqjrXOPv+ZuJSnwerMPUwIzoOb+wLHYN
	 eae9TXa1M06Ixv1hQz57AoeKRtikAz3M4OWKcxCg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgBZR2D (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:28:03 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34845 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726579AbgBZR2D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:28:03 -0500
Received: by mail-oi1-f195.google.com with SMTP id b18so320428oie.2;
        Wed, 26 Feb 2020 09:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t83+nB3W6oXdApXXRMLwz8oHqiI3quakZhUjW8Nn9Jk=;
        b=R41L2VqiNyX3+m+mSoyCgp6ENq3oZAPp5TSB2pozKHwaFhYlfYEqrgX3z8RwEbS4Yy
         QVEej2EX+Igyj1P7kJOhN0VQaq6XfAQ+tJmvRyML/Uac8y3syGBqv9Tv11VbF3EkzThF
         0DKm8Q92/2AUv9ldHvZwm6QcgNED9KUNK8H2wjQ74PoIB23SfCrcVn4IZCwv/mmmPU4g
         VzWFrDCjHuwwBbQt49uj5g3pUdxC+TkCGDsGqATwuMqKuOA3Td+gUEVZJrb/6EuFeLV5
         xlSP+vgsZ7IEhfYyNXcj5hIfNYfFlhVyVlt0XsO6tTPC0t/JEnaW3TZk/8mZueC8HqKU
         Z/ag==
X-Gm-Message-State: APjAAAWMDZDeQyEsvVEiEa7CFQpiO/kLPsrx2msSdBlzQlnBtMWsYBId
        +gixTDbYmUrt8XtSZaSGlg==
X-Google-Smtp-Source: APXvYqxIZscytpwpjUEBs4aKZOxXofyE3s8jmDy1RE4Sc6pXr02J+2XwFazqn2VQDBxT94r/V+dHvw==
X-Received: by 2002:a05:6808:aa8:: with SMTP id r8mr50338oij.7.1582738082288;
        Wed, 26 Feb 2020 09:28:02 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v134sm1004026oia.38.2020.02.26.09.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 09:28:01 -0800 (PST)
Received: (nullmailer pid 10384 invoked by uid 1000);
        Wed, 26 Feb 2020 17:28:00 -0000
Date:   Wed, 26 Feb 2020 11:28:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Mark Rutland <mark.rutland@arm.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: Re: [RESEND PATCH v4 1/2] dt-bindings: dmaengine: Add UniPhier
 external DMA controller bindings
Message-ID: <20200226172800.GA10328@bogus>
References: <1582271550-3403-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1582271550-3403-2-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582271550-3403-2-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Feb 2020 16:52:29 +0900, Kunihiko Hayashi wrote:
> Add devicetree binding documentation for external DMA controller
> implemented on Socionext UniPhier SOCs.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/dma/socionext,uniphier-xdmac.yaml     | 63 ++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/dma/socionext,uniphier-xdmac.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
