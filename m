Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82F7AC3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59FA02084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 09:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578906982;
	bh=yyz9OX86kAKLtZA2YLPwxpuQedHX3W7gDr+3r11s6RA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KJo+KjFG29my9lsGCs9u0Z7abp5tmTNmepuCwhGzMd7tt2LyUXl6irHwZl3ol9xCl
	 tXSLWlSkkg0gazHBKxNuQWuiF7ctmx781CGhvjN3m27UcStHMjFF9ed+uz1t6VytIJ
	 LisNOP3slWRuBG+UP0aEwfdqsUzSivNnvexaI4OY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgAMJQV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 04:16:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725954AbgAMJQV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 04:16:21 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 216982080D;
        Mon, 13 Jan 2020 09:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578906980;
        bh=yyz9OX86kAKLtZA2YLPwxpuQedHX3W7gDr+3r11s6RA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NXZQsHqvj0GqJ7z0FoNq9LhYhpeo1fRRkyX9bNYtcDjqHQxe6Og3APlOGHTRJlowR
         x7I8ZOmWGEjERbE+qB8iYa57JA7cvouAsSkDqPYh+WtNtNpPL+FYre471Qqx47xQYp
         x5rItNwbxcLVPCXtoYhVK25h0DoY1wIRcWSIrGpg=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1iqvpa-00016r-4Q; Mon, 13 Jan 2020 09:16:18 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Jan 2020 09:16:18 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     jason@lakedaemon.net, tglx@linutronix.de, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
        fugang.duan@nxp.com
Subject: Re: [PATCH V4 RESEND 1/2] dt-bindings/irq: add binding for NXP INTMUX
 interrupt multiplexer
In-Reply-To: <1578899321-1365-2-git-send-email-qiangqing.zhang@nxp.com>
References: <1578899321-1365-1-git-send-email-qiangqing.zhang@nxp.com>
 <1578899321-1365-2-git-send-email-qiangqing.zhang@nxp.com>
Message-ID: <e5aa95d7fd1c2d9c0586b7d8689cbfa0@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.8
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: qiangqing.zhang@nxp.com, jason@lakedaemon.net, tglx@linutronix.de, robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com, fugang.duan@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-13 07:08, Joakim Zhang wrote:
> This patch adds the DT bindings for the NXP INTMUX interrupt 
> multiplexer
> for i.MX8 family SoCs.
> 
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  .../interrupt-controller/fsl,intmux.yaml      | 77 +++++++++++++++++++
>  1 file changed, 77 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> 
> diff --git
> a/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> new file mode 100644
> index 000000000000..4dba532fe0bd
> --- /dev/null
> +++ 
> b/Documentation/devicetree/bindings/interrupt-controller/fsl,intmux.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: 
> http://devicetree.org/schemas/interrupt-controller/fsl,intmux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Freescale INTMUX interrupt multiplexer
> +
> +maintainers:
> +  - Marc Zyngier <maz@kernel.org>

Err... No. I have absolutely no desire to maintain this binding on its 
own.
Feel free to add yourself as the maintainer for this file, as I'm merely
the conduit for updates to irqchip DT bindings.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
