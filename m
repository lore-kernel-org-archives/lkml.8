Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F15C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 968842076C
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 17:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598377349;
	bh=Iqt2erpFyqgPmzlkkdVamZ0XSnju1HiOp2ooMVL6Uqk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=HNstjf78yk37WC+TBjrwJySbQA9ysj537CmdoyrK4FjxhtwYF7GpGjvPl/UJqBa6V
	 D2Vgl47fxQtIuXRlKFO20G2HhYAWRIOf29HvTKvK3lf03Mm5C2TeHyf8Pewfx+74zX
	 X+2Kou2W7VL/GAV2gVeq5dyMZDQk1xJtDo3iOmIM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHYRmY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 13:42:24 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:39423 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726119AbgHYRmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 13:42:20 -0400
Received: by mail-il1-f196.google.com with SMTP id f12so11150418ils.6;
        Tue, 25 Aug 2020 10:42:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NTp9u+iFGhAjZbw/H+WbVNzQr+UMY6B6b4vLY7DE2lo=;
        b=MwlGuAjlcVWmp0YPF1lmEUSoBhrUUDjMmxWws8ytNAR+/KY0zxDwpjMidLibZe/sGW
         hAkxDiVb2tK5lRCEu3uX5kn7Ndb9QmXuVdF268DzLxTIyPTfCX7e1NVyND0oPf2UaJY4
         AaWuI84lZvsJ3m48+YboHOwyLnwNj1NXXGVP5gxJX1lidBnup70hntaXRtoOJuTUXnIo
         ioSkI/LdDb3kq8LO8FYABNTIiF3qZKhildyas5Qt9wgKB6gBsAdwwJA+TxJwCyRHPErx
         d4dstkYxE9p5dJ/Cj9deHjDm5wtMQebUaicPjjaotG7Gar5o2uXtKdavq/EyCKpC8GI+
         CfIA==
X-Gm-Message-State: AOAM531Xv1n1+bNnkDJLoTfsU1KVutA08YB2tcxPyVcFcUR9/wOeWQJ/
        1HrYTZUmPD2SrWxLjOWAbg==
X-Google-Smtp-Source: ABdhPJzWee0fZTqZEQWL/ptQEMx+PfSomfPDeGF7gm1FmOf20zLrifz3/STLKJkgTmLuKgxEqET0/Q==
X-Received: by 2002:a05:6e02:670:: with SMTP id l16mr10253072ilt.52.1598377338930;
        Tue, 25 Aug 2020 10:42:18 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id v84sm9831589ilk.4.2020.08.25.10.42.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 10:42:17 -0700 (PDT)
Received: (nullmailer pid 1008933 invoked by uid 1000);
        Tue, 25 Aug 2020 17:42:15 -0000
Date:   Tue, 25 Aug 2020 11:42:15 -0600
From:   Rob Herring <robh@kernel.org>
To:     Crystal Guo <crystal.guo@mediatek.com>
Cc:     p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, s-anna@ti.com, afd@ti.com,
        seiya.wang@mediatek.com, stanley.chu@mediatek.com,
        yingjoe.chen@mediatek.com, fan.chen@mediatek.com,
        yong.liang@mediatek.com
Subject: Re: [v4,1/4] dt-binding: reset-controller: ti: add reset-duration-us
 property
Message-ID: <20200825174215.GA999117@bogus>
References: <20200817030324.5690-1-crystal.guo@mediatek.com>
 <20200817030324.5690-2-crystal.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817030324.5690-2-crystal.guo@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:03:21AM +0800, Crystal Guo wrote:
> introduce 'reset' method to allow device do serialized assert and
> deassert operations in a single step, which needs a minimum delay
> to be waited between assert and deassert.

Why is Mediatek adding to a TI binding?

> 
> Signed-off-by: Crystal Guo <crystal.guo@mediatek.com>
> ---
>  Documentation/devicetree/bindings/reset/ti-syscon-reset.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> index 86945502ccb5..ab041032339b 100644
> --- a/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> +++ b/Documentation/devicetree/bindings/reset/ti-syscon-reset.txt
> @@ -59,6 +59,11 @@ Required properties:
>  Please also refer to Documentation/devicetree/bindings/reset/reset.txt for
>  common reset controller usage by consumers.
>  
> +Optional properties:
> +- reset-duration-us: When do serialized assert and deassert operations, minimum delay in microseconds
> +is needed to be waited between an assert and a deassert to reset the device. This value can be 0, 0 means
> +that such a delay is not needed.

This goes in the reset controller node or each consumer? For the latter, 
it should be a cell in 'resets' if you need this. But really, I think 
the reset controller should enforce some minimum time that works for all 
consumers. Surely having a minimum time per reset isn't really needed.

Rob
