Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4753C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71D2D207DE
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 19:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599594615;
	bh=rmiIaK1c8XLPkFOrsvQ7NKcgn/J1TrsXhVVAvXCLh0g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BOmuGB2RXorR7DfvxA966DJeEFnVDzflkql0+kdBMIMduVlKpBgXjh/Wz5RlJ5o0F
	 /0ph1Zww3v/Ja14hSJ8F+5Z03PVOz276b8WuQuqswDLBqzeCkOea4bgjlnKg78nRUe
	 Gcy2mfwUOTYGQMEthIyuusip4jDkQluknZiwUg+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730824AbgIHTuO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 15:50:14 -0400
Received: from mail-il1-f194.google.com ([209.85.166.194]:33272 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbgIHTs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 15:48:26 -0400
Received: by mail-il1-f194.google.com with SMTP id x2so111374ilm.0;
        Tue, 08 Sep 2020 12:48:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PlBmgS/sjuCEIQu1u5ZYl8mMPlH7KVu/qGuOumfaosA=;
        b=Q6CeA5uBJtyvuRMItAyYfB19VI/txvSN9UevF7UwmdPVMahRfNfPwl2+TFZFJCkV9r
         JXjYIy6dKZb1PFbuejaciJErxopKHXzcUgDGBSsy98Cv4TtD+2Ma/xk6gDnGG3oLt/t6
         NMFOPNWix7fkalacRa36Dx4roUnhmZ1DeEf5IZzjSJpjQZcVY/up5/rDl2ABE3BpzL7d
         z+EcdjLwgqCVogQvlWJ7x+pui5hO8rGSy4B/vcyY2Ir3kLaRMptI9i5CHh1b4unfiYU5
         1KDxG/DSDkEjaedwF/MbpF15JaFvi/7eJ6NyQFeqBtX+nf9W3DkAm6eR4LUIOJvLYpcH
         PRBg==
X-Gm-Message-State: AOAM530besdD7lh11W8AKAqyHys60j7EBwPUPkhM1+j31zvkio6igfT5
        7SfRLVXozETEksYUU5lAVg==
X-Google-Smtp-Source: ABdhPJwN1OwrU3sDw8effHgraPgDprUoh6q/VhYkCUX+OIayZE87xKJpLW8f/hji5fWBS4UIu+vurg==
X-Received: by 2002:a05:6e02:13aa:: with SMTP id h10mr370198ilo.212.1599594505051;
        Tue, 08 Sep 2020 12:48:25 -0700 (PDT)
Received: from xps15 ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id l2sm102112ilk.19.2020.09.08.12.48.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 12:48:24 -0700 (PDT)
Received: (nullmailer pid 791744 invoked by uid 1000);
        Tue, 08 Sep 2020 19:48:21 -0000
Date:   Tue, 8 Sep 2020 13:48:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     kishon@ti.com, linux-amlogic@lists.infradead.org,
        repk@triplefau.lt, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: phy: amlogic,
 meson-axg-mipi-pcie-analog: remove reg attribute
Message-ID: <20200908194821.GA790974@bogus>
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

On Mon, 07 Sep 2020 09:34:00 +0200, Neil Armstrong wrote:
> The Amlogic AXG MIPI + PCIe Analog PHY should be a subnode of the hhi mfd
> node like the axg-clkc node.
> 
> Thus the reg attribute is not needed.
> 
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  .../bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml      | 4 ----
>  1 file changed, 4 deletions(-)
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.example.dt.yaml: phy@0: 'reg' does not match any of the regexes: 'pinctrl-[0-9]+'
	From schema: /builds/robherring/linux-dt-review/Documentation/devicetree/bindings/phy/amlogic,meson-axg-mipi-pcie-analog.yaml


See https://patchwork.ozlabs.org/patch/1358643

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

