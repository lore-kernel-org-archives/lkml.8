Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 165BAC433FB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D8020759
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 15:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkYe2Adf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729673AbgGWPll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 11:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729551AbgGWPlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 11:41:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2508AC0619DC;
        Thu, 23 Jul 2020 08:41:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z18so2050227wrm.12;
        Thu, 23 Jul 2020 08:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=AcBqtfKEF6k5xr/VSNWblkqKGVnRPP3ztKfalGbMQTA=;
        b=SkYe2AdfwGFlttVB8ifdFjjVZf8HGW9GVwFpei2V5+07UZ2DNP+x0zYdNcOp8FUCsF
         gNXqpKEzsxBa+Qu3MJcUipZBHqhct/OgxsNrCmknYegj38zb4BF2SLJq3N6WGMTWmraB
         B68nHR+yUFADlOABBYYUgvoAkPtscNgsZOPSOjA4kSDdAHEAMlH5xjOW4Li3I3Ulpxw8
         NpDGKc4G1rDb3mUtFK0bLrfZt7zexmcZSZBdtVbhxJgFeyBs7EUV/734GMksnuNBjAF6
         gSyn+dIOifPnVGrHxRnFVBYWGXbrkoW77cJycp0pqhWeA+sedQIrQ1DJF+nHSyDhmOw/
         Yrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=AcBqtfKEF6k5xr/VSNWblkqKGVnRPP3ztKfalGbMQTA=;
        b=kUrupn4h9Y5In2uQFptoHfdEyTJfxQtIRCKEB1IOwOOePEJRAo7PWMjIehSFZuLnqY
         ifmUWHho1oMePX/XCFYw6TDsErWAOFTTTtegP2lP5x1mdovIMI9zyDph57vnABxW/XJW
         C4cv9u/6thzlQ9Ddy4qiHnfQRhBa3UNGJRhb+1vfdWFiUk7ajueRuKMn884PV53NfO23
         yWlSNdhGoLfGU2qSW+BBfH+WpCL3rZoQfBiU9rnmk+Mjsg+V8a/nqL0dJHVc0QjSQVhN
         hMy58MQmfGeyWE6vDxwOxDwbcKh7IL8mE4rtbUkxXsNc8lbjgROvAcexafcSIponD7zA
         FlFQ==
X-Gm-Message-State: AOAM533GK04kGXcNm38CC/XRbfIcxc9JeSxIA/yUn7IMbUnpTJ5INuDI
        kQGyzwwBsErIdtie56Q4s7o=
X-Google-Smtp-Source: ABdhPJxo8GvOapToh6OIkdSOCYVuIFV3tlBpD96mQIzsqG+h/NUdrRmgV0G9vYZUqr5+YsUfvS6bxA==
X-Received: by 2002:adf:eccd:: with SMTP id s13mr4915144wro.217.1595518898886;
        Thu, 23 Jul 2020 08:41:38 -0700 (PDT)
Received: from ziggy.stardust ([213.195.122.158])
        by smtp.gmail.com with ESMTPSA id o7sm4169352wrv.50.2020.07.23.08.41.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2020 08:41:38 -0700 (PDT)
Subject: Re: [v7, PATCH 4/7] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
 <1595469798-3824-5-git-send-email-yongqiang.niu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <b3f97fc8-d95e-8245-1178-9a70353d379c@gmail.com>
Date:   Thu, 23 Jul 2020 17:41:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1595469798-3824-5-git-send-email-yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 23/07/2020 04:03, Yongqiang Niu wrote:
> Update device tree binding document for rdma_fifo_size
> 

Please explain better what you are doing in the patch.
Also DT binding patches should normally go as the first of a series, as this 
helps Rob to review them.

Regards,
Matthias

> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>   .../devicetree/bindings/display/mediatek/mediatek,disp.txt | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index b91e709..e6bbe32 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -66,6 +66,11 @@ Required properties (DMA function blocks):
>     argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>     for details.
>   
> +Optional properties (RDMA function blocks):
> +- mediatek,rdma_fifo_size: rdma fifo size may be different even in same SOC, add this
> +  property to the corresponding rdma
> +  the value is the Max value which defined in hardware data sheet.
> +
>   Examples:
>   
>   mmsys: clock-controller@14000000 {
> @@ -207,3 +212,12 @@ od@14023000 {
>   	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>   	clocks = <&mmsys CLK_MM_DISP_OD>;
>   };
> +
> +rdma1: rdma@1400c000 {
> +	compatible = "mediatek,mt8183-disp-rdma";
> +	reg = <0 0x1400c000 0 0x1000>;
> +	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +	clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +	mediatek,rdma_fifo_size = <2048>;
> +};
> 
