Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8DAEC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEF7020716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599151684;
	bh=CtrdesPsuW6WAFarngZudSohiAmcIwQaJrGNCMdJbqQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ygcKqWsf8EW3hIzOfCEEtkARjLv5EeMuY/WOUU54rAznlliToyZU/yX4/QGdWDWm5
	 qxHbhEKjK3E63hiJ7ljcuppX4z06ADD/vJU8hI+bE9Xl3CF/tqQge2pYg/MqEPRXxj
	 0jf+Hg39/3rFEiok4FUJeeJBeDHZDJrir7otjjwA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728980AbgICQsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:48:02 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33753 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgICQsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:48:02 -0400
Received: by mail-il1-f196.google.com with SMTP id x2so3361894ilm.0;
        Thu, 03 Sep 2020 09:48:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=91c9OrdX8+HmEgzIn/3VaO9IW3UnvjWcIpdy1+QI8PU=;
        b=ORFpjotoK0d8dzx/vj3r2u0GpazVW7b8mvAV0zrEoODPRq4yMo+in3hGpf9WXi9Zvg
         NHTiVmR2NHxF7UC4Vcsr1v8lhY8B9UiVJvQ6AGuJzc46knCxsbEjeYxzQsfTgZnmJxXR
         iF0L7z0T3CgRjRloViP3ZRYX2W8ZpcJlJaebe5wF0Z9jXkRDy+YYH7RebzVcn9D48u6Q
         AkLsUZyVmn/2pu+nre4nFU7df0B8cs76SE/VaFaejIMr3lsz6rmksB3pn9hHaVIuYSku
         VThaMdIhsDGoc8h9V6+8uJH9AsVkensetuxqPWTV3grVEJihr4iQfxvzNC7CkpBZWCTN
         2+UQ==
X-Gm-Message-State: AOAM531NiOMujvpZ0EbXAHlOh6SUdflv4R6EmNEIBG11R7Q6fOlZOr2j
        Y5rosCQ9GtKjVxKAIqOnsQ==
X-Google-Smtp-Source: ABdhPJzu8GKf6yafl/5GKeQPTiAeHvCLs2/CscMiEjp4LSMoVeMlrK0a5PKntlu3sOnYPcZxA1bTGg==
X-Received: by 2002:a05:6e02:13aa:: with SMTP id h10mr3896481ilo.212.1599151679716;
        Thu, 03 Sep 2020 09:47:59 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id y10sm1518577ioy.25.2020.09.03.09.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 09:47:59 -0700 (PDT)
Received: (nullmailer pid 2931914 invoked by uid 1000);
        Thu, 03 Sep 2020 16:47:58 -0000
Date:   Thu, 3 Sep 2020 10:47:58 -0600
From:   Rob Herring <robh@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Inki Dae <inki.dae@samsung.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: gpu: samsung-rotator: Use
 unevaluatedProperties
Message-ID: <20200903164758.GA2931633@bogus>
References: <20200830113002.7080-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200830113002.7080-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 01:30:02PM +0200, Krzysztof Kozlowski wrote:
> Additional properties or nodes actually might appear (e.g. power
> domains) so use unevaluatedProperties to fix dtbs_check warnings like:
> 
>   arch/arm/boot/dts/exynos4210-i9100.dt.yaml: rotator@12810000:
>     'iommus', 'power-domains' do not match any of the regexes: 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  Documentation/devicetree/bindings/gpu/samsung-rotator.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

NAK. See https://lore.kernel.org/r/CAL_JsqKPXJxsHPS34_TCf9bwgKxZNSV4mvQR-WKRnknQVtGGxQ@mail.gmail.com/
