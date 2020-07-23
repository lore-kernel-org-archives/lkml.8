Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A45AC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:59:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 399AB20771
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 16:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595523594;
	bh=cZuwCPQOLO+6nEe7+0KP/pp96e9FAAMuVpbKOrXMZm0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FzPrOVKNLu3QzIii9tuov+lZS6dL0MGPrbEI+1TkAxaLOtey45K/+WV+pYiyATvRd
	 EVYA0eLj17jWhH/eEJRbv7q7oBzJYkIKFZLCvnmNcxWT1KbwKNcPkkGo/+ATih4tv5
	 Ih7+0nXbO+Vw7WWvOo13Ok3EQ7fFPrNqZotwxV4w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729928AbgGWQ7x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 12:59:53 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:46031 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbgGWQ7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 12:59:52 -0400
Received: by mail-il1-f193.google.com with SMTP id o3so4884542ilo.12;
        Thu, 23 Jul 2020 09:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=a9J1QalhPnPlUfL8dEkhcJXOcummbHS6rnTdET71bMs=;
        b=pbtZSPOAR6mNc2Mx/tzXPF0XG3fnPjSJfNtNP1SQ6Prpm0puexmp/G12kMYMiXcp+2
         0qaa78Og7pL5I3wSvJ6mk+jFC3OtCZVIjy5KYHlDd7Y6E3jjXGoxAhN0/xtWKnWGKRAN
         YdOSmfwmflVLnR2nyp8TkRjcAZGbilQmgVOG0Sit0pQpidRsk8bqkLPqbD+EBLefWAqW
         mZLr8OovOJzjSbENrvpECsn2dV1dobrnrHZp9at4VoIoJSH644C14fNprsvre6svvc1Y
         LZqk2rus0QmFoiecvzUMYEnnDPxUcyvedc9hf0X7zS+1ShHKkX/xw801ipzyJpcxhH/m
         PEMw==
X-Gm-Message-State: AOAM533bqqrs3gwGU+B9SL0aHvIO9gaElgFMlA3V8JYguai047Q26Imq
        0IDNimT1d+a57Sqi3iunXw==
X-Google-Smtp-Source: ABdhPJyuR1S22aBp3Or2PleYDBAuKLxt9dS8HqZMwzT1XYskFKMphzrrK4Z7oxsJJzEUbVcdkKz2pw==
X-Received: by 2002:a05:6e02:1253:: with SMTP id j19mr5960074ilq.145.1595523591815;
        Thu, 23 Jul 2020 09:59:51 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id 5sm1721954ion.7.2020.07.23.09.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 09:59:51 -0700 (PDT)
Received: (nullmailer pid 531537 invoked by uid 1000);
        Thu, 23 Jul 2020 16:59:50 -0000
Date:   Thu, 23 Jul 2020 10:59:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [v7, PATCH 4/7] dt-bindings: mediatek: add rdma_fifo_size
 description for mt8183 display
Message-ID: <20200723165950.GA529262@bogus>
References: <1595469798-3824-1-git-send-email-yongqiang.niu@mediatek.com>
 <1595469798-3824-5-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595469798-3824-5-git-send-email-yongqiang.niu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 23, 2020 at 10:03:15AM +0800, Yongqiang Niu wrote:
> Update device tree binding document for rdma_fifo_size
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index b91e709..e6bbe32 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -66,6 +66,11 @@ Required properties (DMA function blocks):
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>    for details.
>  
> +Optional properties (RDMA function blocks):
> +- mediatek,rdma_fifo_size: rdma fifo size may be different even in same SOC, add this

s/_/-/

> +  property to the corresponding rdma
> +  the value is the Max value which defined in hardware data sheet.
> +
>  Examples:
>  
>  mmsys: clock-controller@14000000 {
> @@ -207,3 +212,12 @@ od@14023000 {
>  	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>  	clocks = <&mmsys CLK_MM_DISP_OD>;
>  };
> +
> +rdma1: rdma@1400c000 {
> +	compatible = "mediatek,mt8183-disp-rdma";
> +	reg = <0 0x1400c000 0 0x1000>;
> +	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +	clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +	mediatek,rdma_fifo_size = <2048>;
> +};
> -- 
> 1.8.1.1.dirty
