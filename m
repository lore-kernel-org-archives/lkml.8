Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10969C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFD42177B
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 16:20:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgGaQUO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 12:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726502AbgGaQUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 12:20:12 -0400
Received: from hillosipuli.retiisi.org.uk (hillosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::81:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19C4AC061574;
        Fri, 31 Jul 2020 09:20:12 -0700 (PDT)
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id C6B8F634C87;
        Fri, 31 Jul 2020 19:19:08 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1k1XkS-0001fg-Lt; Fri, 31 Jul 2020 19:19:08 +0300
Date:   Fri, 31 Jul 2020 19:19:08 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Sowjanya Komatineni <skomatineni@nvidia.com>
Cc:     thierry.reding@gmail.com, jonathanh@nvidia.com, frankc@nvidia.com,
        hverkuil@xs4all.nl, luca@lucaceresoli.net,
        leonl@leopardimaging.com, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/3] dt-bindings: media: imx274: Add optional input
 clock and supplies
Message-ID: <20200731161908.GA6401@valkosipuli.retiisi.org.uk>
References: <1595264494-2400-1-git-send-email-skomatineni@nvidia.com>
 <1595264494-2400-2-git-send-email-skomatineni@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595264494-2400-2-git-send-email-skomatineni@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sowjanya,

On Mon, Jul 20, 2020 at 10:01:33AM -0700, Sowjanya Komatineni wrote:
> This patch adds IMX274 optional external clock input and voltage
> supplies to device tree bindings.
> 
> Reviewed-by: Luca Ceresoli <luca@lucaceresoli.net>
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  Documentation/devicetree/bindings/media/i2c/imx274.txt | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/imx274.txt b/Documentation/devicetree/bindings/media/i2c/imx274.txt
> index 80f2e89..0727079 100644
> --- a/Documentation/devicetree/bindings/media/i2c/imx274.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/imx274.txt
> @@ -13,6 +13,11 @@ Required Properties:
>  
>  Optional Properties:
>  - reset-gpios: Sensor reset GPIO
> +- clocks: Reference to the input clock.
> +- clock-names: Should be "inck".
> +- VANA-supply: Sensor 2.8v analog supply.
> +- VDIG-supply: Sensor 1.8v digital core supply.
> +- VDDL-supply: Sensor digital IO 1.2v supply.

I believe lower case is preferred.

>  
>  The imx274 device node should contain one 'port' child node with
>  an 'endpoint' subnode. For further reading on port node refer to

-- 
Sakari Ailus
