Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9567C4BA28
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:28:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE25824656
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 20:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582748930;
	bh=X+heKnO6iZTZfGKI6KSWMm0otaVfMYMz/2QFDt5Deug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LZI0gPjZYJBp7pi8rBpxes0kpqHYQi8/NzADWeTmMuSux2R/HwH9TzyZr/rVgd2v0
	 NTm708JDNa4ayi+6fbm5yp2ynHt011BTEeh/rJIBBiETslv6coSu8UhUZ/D7hFf90h
	 FhUsSDvod2zLQiUQgRJGca1s16VSzcHKPil/iO04=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgBZU2t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 15:28:49 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40817 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727289AbgBZU2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 15:28:49 -0500
Received: by mail-ot1-f66.google.com with SMTP id i6so716301otr.7;
        Wed, 26 Feb 2020 12:28:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=O/ZmfWy9/9XjBdv30P0G0kcHPh66hW3ql84KTaPPF/A=;
        b=tejn9+7PuRfQB+7/Y8fniQ4VqaUBICLZRN/doe5HIMv9P8kDr3uiephZvF0PAYP97a
         SmEhM5DiBrvJbV9S/rGBzWecQV/B+3uwfGR7mfYC2+fASqkpw/oCGE/8UJuZ07vYArxt
         OV7oBOt6lZL3H8ZN86bcBLGYTFdpIeldA7G+kX7sSYhsLOUeu98seB6K6UcCPGVmBQSu
         aq31XkoKdp2wUfzZkwnQ6c1SKOWpeGLXqD2Nqz7+j7x9edlLST4ie+ZHwjxcxWeFER2S
         RDOwBpG1pwKAHUiNf6KIhnFc5IMrFHIgHafnd7pPizmsQSL0ueFprj0zPQIqqHuSBVnv
         LghQ==
X-Gm-Message-State: APjAAAVAAYvj5Lr0+rTxmaUNTkX4XOCqYvl1nYDXqv7W131dWz05kWhy
        dKNbArzhDIb62c1TBxOFSw==
X-Google-Smtp-Source: APXvYqx+ekwwPkyIdV8FoaGq7rSPdBmF6vtqNYcfh4IlzHYSrpmvQXBFhWXQgJrWcFqq1sadnCd3OA==
X-Received: by 2002:a9d:74c4:: with SMTP id a4mr456108otl.119.1582748926618;
        Wed, 26 Feb 2020 12:28:46 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e10sm507605otl.0.2020.02.26.12.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 12:28:45 -0800 (PST)
Received: (nullmailer pid 4643 invoked by uid 1000);
        Wed, 26 Feb 2020 20:28:44 -0000
Date:   Wed, 26 Feb 2020 14:28:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        mtk01761 <wendell.lin@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Weiyi Lu <weiyi.lu@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Sean Wang <Sean.Wang@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Evan Green <evgreen@chromium.org>,
        Yong Wu <yong.wu@mediatek.com>, Joerg Roedel <jroedel@suse.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <Ryder.Lee@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Mediatek WSD Upstream <wsd_upstream@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>
Subject: Re: [PATCH 2/5] dt-bindings: clock: mediatek: document clk bindings
 mipi0a for Mediatek MT6765 SoC
Message-ID: <20200226202844.GA18610@bogus>
References: <1582278742-1626-1-git-send-email-macpaul.lin@mediatek.com>
 <1582278742-1626-3-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582278742-1626-3-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 05:52:19PM +0800, Macpaul Lin wrote:
> This patch adds the binding documentation for mipi0a.
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../bindings/arm/mediatek/mediatek,mipi0a.txt | 28 +++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt

Please use DT schema for new bindings. See 
Documentation/devicetree/writing-schema.rst.

> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> new file mode 100644
> index 000000000000..8be5978f388d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> @@ -0,0 +1,28 @@
> +Mediatek mipi0a (mipi_rx_ana_csi0a) controller
> +============================
> +
> +The Mediatek mipi0a controller provides various clocks
> +to the system.
> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	- "mediatek,mt6765-mipi0a", "syscon"
> +- #clock-cells: Must be 1
> +
> +The mipi0a controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
> +The mipi0a controller also uses the common power domain from
> +Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +The available power doamins are defined in dt-bindings/power/mt*-power.h.
> +
> +Example:
> +
> +mipi0a: clock-controller@11c10000 {
> +	compatible = "mediatek,mt6765-mipi0a", "syscon";
> +	reg = <0 0x11c10000 0 0x1000>;

Not documented.

> +	power-domains = <&scpsys MT6765_POWER_DOMAIN_CAM>;

Not documented.

> +	#clock-cells = <1>;
> +};
> -- 
> 2.18.0
