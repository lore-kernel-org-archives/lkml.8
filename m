Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FEAC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 288C2206F1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 08:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgFPIUm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 04:20:42 -0400
Received: from v6.sk ([167.172.42.174]:47516 "EHLO v6.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726261AbgFPIUm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 04:20:42 -0400
Received: from localhost (v6.sk [IPv6:::1])
        by v6.sk (Postfix) with ESMTP id 0150061626;
        Tue, 16 Jun 2020 08:20:09 +0000 (UTC)
Date:   Tue, 16 Jun 2020 10:20:05 +0200
From:   Lubomir Rintel <lkundrak@v3.sk>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 15/29] dt: fix reference to olpc,xo1.75-ec.txt
Message-ID: <20200616082005.GA931489@furthur.local>
References: <cover.1592203542.git.mchehab+huawei@kernel.org>
 <d0262854582ee754e4b8bd80677d96b3e098ea5c.1592203542.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0262854582ee754e4b8bd80677d96b3e098ea5c.1592203542.git.mchehab+huawei@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 08:46:54AM +0200, Mauro Carvalho Chehab wrote:
> This file was converted and renamed.
> 
> Fixes: 7882d822b3f9 ("dt-bindings: spi: Convert spi-pxa2xx to json-schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Thank you,

Reviewed-by: Lubomir Rintel <lkundrak@v3.sk>

I'm wondering -- which tree is this targetted for? I may end up
converting the XO-1.75 EC docs to YAML for 5.9, and I suppose I'd need
to base it on this and send it in the same direction.

Lubo


> ---
>  Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> index 8c4d649cdd8f..2d7cdf19a0d0 100644
> --- a/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> +++ b/Documentation/devicetree/bindings/misc/olpc,xo1.75-ec.txt
> @@ -8,7 +8,7 @@ The embedded controller requires the SPI controller driver to signal readiness
>  to receive a transfer (that is, when TX FIFO contains the response data) by
>  strobing the ACK pin with the ready signal. See the "ready-gpios" property of the
>  SSP binding as documented in:
> -<Documentation/devicetree/bindings/spi/spi-pxa2xx.txt>.
> +<Documentation/devicetree/bindings/spi/marvell,mmp2-ssp.yaml>.
>  
>  Example:
>  	&ssp3 {
> -- 
> 2.26.2
> 
