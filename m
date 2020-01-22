Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE15C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:22:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89E87217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579710179;
	bh=8XWxfAy4NLRIuBegeI/Fx1b7jFFjwZM8fJ+SzsLiKrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kCSQc6wy1bhHZ4UVh78U9l0ZRd/+XwQy3OdJ5q9joeS7vuiZzfsGSlzpXrcTb8+n6
	 Kn0Zw7fp4A0dASeiYB1aNdAh/lq6WW9rJ8O4U9MBXZ9qi0doikjMPslqncZfIB54eM
	 uiwh1C9R/B4RP/zrcg9YonARws3nAt7VgOVCNFzs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgAVQW7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 11:22:59 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42829 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgAVQW6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 11:22:58 -0500
Received: by mail-ot1-f65.google.com with SMTP id 66so6762832otd.9;
        Wed, 22 Jan 2020 08:22:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H48xzwe81R+26WhYO3nqyiBO2COcYsRIJ2Nk8wvtWJY=;
        b=OT5oDQ3tt94CiGmlPb1URnsC5rZF5HmU+GZPzGmEFKLlstiiloNlMvNt0TWq/B+1xZ
         uUV4YOqS28MLdmWtvCPRcb5BA7u8gGk7ytYNQ3/MkLzEO0yH5Tj7j/2nOxq2BMi1cunz
         LBchBQ+uc6YeLP/1rlHZsWZTAaz72M/LjBGB+GGUOv5/b9OTSm1YkVuq02XaLQ9r2uMV
         VhfLRpG4isyCQ6jw8ThoOurKKNigfCtm/nX0HI4eOTJN0MGX+Kk6kF/Cj2koa7Em4sSO
         UrFGnZq5YpcVDxssex2tHbSXlCSgJ/5MHXIXz3v1JwaMyAmaHshqTmoEWr0LlOiTbl0/
         dNPg==
X-Gm-Message-State: APjAAAUq1BQXqAdnhkPy/ayQGoxWpKddq7V1JYjge2f1HN9A4BJ5tqN2
        xoCSJwIgXno5xhDQKCt8ng==
X-Google-Smtp-Source: APXvYqxcjr0sfIFeNw2oiHRfxPjHsDbIHqrW5Bh7o4c21JY+hP+yL3lpp4Zd3t22QZ3ST/gX2WcF7g==
X-Received: by 2002:a05:6830:13d3:: with SMTP id e19mr7921563otq.135.1579710178117;
        Wed, 22 Jan 2020 08:22:58 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g8sm14627581otq.19.2020.01.22.08.22.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 08:22:57 -0800 (PST)
Received: (nullmailer pid 7491 invoked by uid 1000);
        Wed, 22 Jan 2020 16:22:56 -0000
Date:   Wed, 22 Jan 2020 10:22:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     broonie@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        heiko@sntech.de, linux-spi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 2/3] dt-bindings: spi: spi-rockchip: add
 description for rk3308
Message-ID: <20200122162256.GA7429@bogus>
References: <20200118230848.15326-1-jbx6244@gmail.com>
 <20200118230848.15326-2-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118230848.15326-2-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Jan 2020 00:08:47 +0100, Johan Jonker wrote:
> The description below is already in use for rk3308.dtsi,
> but was somehow never added to a document, so add
> "rockchip,rk3308-spi", "rockchip,rk3066-spi"
> for spi nodes on a rk3308 platform to spi-rockchip.yaml.
> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  Documentation/devicetree/bindings/spi/spi-rockchip.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
