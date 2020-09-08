Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA516C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5AA20658
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594644;
	bh=XA3XmwhgTEagE7sLyFFI3GNE6kqdL3le3JsFG6UEYsQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=eW6n9jB6cxHYjkEdcOqdWe/4Hp41akF0lJipI8/WWtUSuOkTcRinF1VVyQXyfv8mQ
	 IdFtH/TOAbZjxgVv/YLPyfV/JnhFZGJfEgFM8gsRY4Gf9UeT/TMZVoTSLo5j2qXcdL
	 zhawNRYRbzwbrtPwtEzVpZ+2c3mTUbDB6SdjtR84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732025AbgIHTum (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:50:42 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:36728 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731854AbgIHTuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:50:10 -0400
Received: by mail-il1-f196.google.com with SMTP id p13so101348ils.3;
        Tue, 08 Sep 2020 12:50:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5c1HRgnQ3n06UIr0qlZyRVS1Vpy/Owe423E/eWb8Yz0=;
        b=i0vdxeM1lkFa05dG+d3dkiKG3Yzowrmhe8zJny7u9+laIgih6E0ulsW9COiZvLZkpz
         rLYth++u9KII1CpQd+hiOYH/AK3HWDUMyn6oWXEBwImkJJlvCoaxJJ6I7u0waiYotYgy
         i3yOynvmmfnQhhNTWHjxIzBDuBEtK7CCg8EQK+NmV+4JXzjD94gQpoRfhYH8fsvulNAq
         PTMn/i5TEi+e05TwfB3cg7idOumqku2tqKPQnemEnyz6wd/1uVw6IHNApO6z837ql8hu
         SHumWiLpE7STYRSlmm1MzWX90UiR2+10h+4/k7ntrEG9WimRCJiQnchiz5Y162eJsFSU
         OaUQ==
X-Gm-Message-State: AOAM532gS5fAr7c17sj7/VAuhWhqPpLyAiA5SMvxaCGrfsh2gBsoxF4I
        3vP7j3gML0+eH0C9VPGrbw==
X-Google-Smtp-Source: ABdhPJzcBJdUYSOqv5vyyPlfYhRkyAZLdFPz4Ih+Qvjiv4ZaD+Mgtxnccaffyn/7jgGO/9dLHjaRQQ==
X-Received: by 2002:a05:6e02:807:: with SMTP id u7mr360581ilm.67.1599594609068;
        Tue, 08 Sep 2020 12:50:09 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z4sm132715iol.52.2020.09.08.12.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:50:08 -0700 (PDT)
Received: (nullmailer pid 794409 invoked by uid 1000);
        Tue, 08 Sep 2020 19:50:03 -0000
Date:   Tue, 8 Sep 2020 13:50:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, repk@triplefau.lt, devicetree@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy:
 amlogic,meson-axg-mipi-pcie-analog: remove reg attribute
Message-ID: <20200908195003.GB790974@bogus>
References: <20200907073402.26674-1-narmstrong@baylibre.com>
 <20200907073402.26674-2-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907073402.26674-2-narmstrong@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 09:34:00AM +0200, Neil Armstrong wrote:
> The Amlogic AXG MIPI + PCIe Analog PHY should be a subnode of the hhi mfd
> node like the axg-clkc node.
> 
> Thus the reg attribute is not needed.

If the phy registers have an address then it should remain even if Linux 
happens to not care. The exception is if the registers are all 
interleaved with other stuff.

> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
> index 18c1ec5e19ad..a9040aa387cf 100644
> --- a/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
> +++ b/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml
> @@ -13,15 +13,11 @@ properties:
>    compatible:
>      const: amlogic,axg-mipi-pcie-analog-phy
>  
> -  reg:
> -    maxItems: 1
> -
>    "#phy-cells":
>      const: 1
>  
>  required:
>    - compatible
> -  - reg
>    - "#phy-cells"
>  
>  additionalProperties: false
> -- 
> 2.22.0
> 
