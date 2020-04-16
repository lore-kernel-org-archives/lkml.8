Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF520C2BB85
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD41721BE5
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 09:40:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503876AbgDPJkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 05:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2503645AbgDPJjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 05:39:42 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBEFC061A41
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 02:39:42 -0700 (PDT)
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1jP0zd-0002ad-L6; Thu, 16 Apr 2020 11:39:33 +0200
Received: from mfe by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <mfe@pengutronix.de>)
        id 1jP0zc-0008A1-NM; Thu, 16 Apr 2020 11:39:32 +0200
Date:   Thu, 16 Apr 2020 11:39:32 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Linux-imx@nxp.com
Subject: Re: [PATCH V2 1/5] dt-bindings: clock: Convert i.MX6Q clock to
 json-schema
Message-ID: <20200416093932.2mkcyv4rs6v6a24a@pengutronix.de>
References: <1587019158-12143-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587019158-12143-1-git-send-email-Anson.Huang@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 11:37:20 up 153 days, 55 min, 168 users,  load average: 0.00, 0.06,
 0.07
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On 20-04-16 14:39, Anson Huang wrote:

...

> diff --git a/Documentation/devicetree/bindings/clock/imx6q-clock.yaml b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> new file mode 100644
> index 0000000..1c6e600
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/imx6q-clock.yaml
> @@ -0,0 +1,66 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/imx6q-clock.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Clock bindings for Freescale i.MX6 Quad
> +
> +maintainers:
> +  - Anson Huang <Anson.Huang@nxp.com>
> +
> +properties:
> +  compatible:
> +    const: fsl,imx6q-ccm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 2

IMHO I would force them to have exactly two so we need
minItems: 2 too here.

Regards,
  Marco
