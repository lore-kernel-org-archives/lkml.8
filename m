Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25CA2C433EC
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01C6C207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595519526;
	bh=/GQ2QhGK0gBCaytDhB9A8xX+MTJEtVpDuAAUfpwB38c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxsG7HePOuUZ94AHZ8VAajbXmE7YGzP78bhn5q3fHTyPOIrvLfN3kdUWQTM7zK0Pn
	 hZnKBe7LQR3YwtqFYEK38Cre/5JbnuXtPTna515oHPM8H6hZKdOa+1/D5kRlpY9Ke7
	 gQ2LGuO+Jqt62Dghy9iO2SJqJUyygnn8md/AiIwE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgGWPwE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:52:04 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:38914 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWPwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:52:04 -0400
Received: by mail-io1-f66.google.com with SMTP id z6so6754215iow.6;
        Thu, 23 Jul 2020 08:52:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QY9kXtA33cXH0+WLfNZ9onY7TD+FXlnMCD83KHcN4Qs=;
        b=UPPOiAfwyYwMQ3Z/wyDaSLFZAtwYxP9xIzzAacv0cHD3S93HDQF7JwfB5qGsro1Qsp
         d0zZBSi8amDsdXnYt9xQD4vHsBMw96VjoQtmwEVCVnbZLCsfFEWY7BEsCvjXJM/kVhDe
         Yc3chG3CCngA1crsl4Pd9cdH+PNNSbRQm++jdPfxSENH/OaQovqZuxgQBXPLH24EwIcs
         qJsHyL/KmpwnB2eprRAREsMCWRYy+6vRnxuNKStkHzcPeNPB5y3Jrf5Qszidic1tPiHI
         guEgTQrXZEikbVyUAnoD3iwUbc+Uk6e01PrAB8JQ+SHKJk0yDD97OZVo8VYk8ACfm6Ex
         qxnA==
X-Gm-Message-State: AOAM531DxcIaR2vvaxxNAjSpbGvgk6dt3AOsBYg6fumZ9q+3wWN5A4/r
        cSTzL3dnJ83jdlCiZtnRoQ==
X-Google-Smtp-Source: ABdhPJzB7/A+V1wRpSWO9D+GvJjuQx16r7g+IJe1Jh2draWFxJPpCwENrGDTtSYu4PAi0I2uf+GxjQ==
X-Received: by 2002:a6b:c815:: with SMTP id y21mr5472143iof.83.1595519523112;
        Thu, 23 Jul 2020 08:52:03 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l5sm1642553ios.3.2020.07.23.08.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 08:52:02 -0700 (PDT)
Received: (nullmailer pid 437545 invoked by uid 1000);
        Thu, 23 Jul 2020 15:51:59 -0000
Date:   Thu, 23 Jul 2020 09:51:59 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hanks Chen <hanks.chen@mediatek.com>
Cc:     Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Loda Chou <loda.chou@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        CC Hwang <cc.hwang@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>, wsd_upstream@mediatek.com,
        Andy Teng <andy.teng@mediatek.com>, devicetree@vger.kernel.org,
        mtk01761 <wendell.lin@mediatek.com>,
        Michael Turquette <mturquette@baylibre.com>
Subject: Re: [PATCH v9 2/7] dt-bindings: pinctrl: add bindings for MediaTek
 MT6779 SoC
Message-ID: <20200723155159.GB436360@bogus>
References: <1595503197-15246-1-git-send-email-hanks.chen@mediatek.com>
 <1595503197-15246-3-git-send-email-hanks.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595503197-15246-3-git-send-email-hanks.chen@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Jul 2020 19:19:52 +0800, Hanks Chen wrote:
> From: Andy Teng <andy.teng@mediatek.com>
> 
> Add devicetree bindings for MediaTek MT6779 pinctrl driver.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Andy Teng <andy.teng@mediatek.com>
> Signed-off-by: Hanks Chen <hanks.chen@mediatek.com>
> ---
>  .../pinctrl/mediatek,mt6779-pinctrl.yaml      | 197 ++++++++++++++++++
>  1 file changed, 197 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:0: [0, 268455936, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:1: [0, 297926656, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:2: [0, 298909696, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:3: [0, 300023808, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:4: [0, 300351488, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:5: [0, 300548096, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:6: [0, 301072384, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:7: [0, 301137920, 0, 4096] is too long
/builds/robherring/linux-dt-review/Documentation/devicetree/bindings/pinctrl/mediatek,mt6779-pinctrl.example.dt.yaml: example-0: pinctrl@10005000:reg:8: [0, 268480512, 0, 4096] is too long


See https://patchwork.ozlabs.org/patch/1334743

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure dt-schema is up to date:

pip3 install git+https://github.com/devicetree-org/dt-schema.git@master --upgrade

Please check and re-submit.

