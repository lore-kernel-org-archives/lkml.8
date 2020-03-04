Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B956DC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C8AA2072D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 09:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbgCDJPl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 04:15:41 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57539 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725271AbgCDJPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 04:15:41 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9Q7q-0002le-4g; Wed, 04 Mar 2020 10:15:34 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1j9Q7o-0004aA-7T; Wed, 04 Mar 2020 10:15:32 +0100
Message-ID: <4d0e0f3ec4a883889f3abfb1d222abe8e137af2a.camel@pengutronix.de>
Subject: Re: [PATCH 2/4] dt-bindings: reset: imx7: Document usage on i.MX8MP
 SoC
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Anson Huang <Anson.Huang@nxp.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Linux-imx@nxp.com
Date:   Wed, 04 Mar 2020 10:15:32 +0100
In-Reply-To: <1582708431-14161-2-git-send-email-Anson.Huang@nxp.com>
References: <1582708431-14161-1-git-send-email-Anson.Huang@nxp.com>
         <1582708431-14161-2-git-send-email-Anson.Huang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anson,

On Wed, 2020-02-26 at 17:13 +0800, Anson Huang wrote:
> The driver now supports i.MX8MP, so update bindings accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/reset/fsl,imx7-src.txt     |  4 +-
>  include/dt-bindings/reset/imx8mp-reset.h           | 50 ++++++++++++++++++++++
>  2 files changed, 53 insertions(+), 1 deletion(-)
>  create mode 100644 include/dt-bindings/reset/imx8mp-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> index 38ac251..e10502d 100644
> --- a/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> +++ b/Documentation/devicetree/bindings/reset/fsl,imx7-src.txt
> @@ -10,6 +10,7 @@ Required properties:
>  	- For i.MX8MQ SoCs should be "fsl,imx8mq-src", "syscon"
>  	- For i.MX8MM SoCs should be "fsl,imx8mm-src", "fsl,imx8mq-src", "syscon"
>  	- For i.MX8MN SoCs should be "fsl,imx8mn-src", "fsl,imx8mq-src", "syscon"
> +	- For i.MX8MP SoCs should be "fsl,imx8mp-src", "syscon"
>  - reg: should be register base and length as documented in the
>    datasheet
>  - interrupts: Should contain SRC interrupt
> @@ -51,4 +52,5 @@ For list of all valid reset indices see
>  <dt-bindings/reset/imx7-reset.h> for i.MX7,
>  <dt-bindings/reset/imx8mq-reset.h> for i.MX8MQ and
>  <dt-bindings/reset/imx8mq-reset.h> for i.MX8MM and
> -<dt-bindings/reset/imx8mq-reset.h> for i.MX8MN
> +<dt-bindings/reset/imx8mq-reset.h> for i.MX8MN and
> +<dt-bindings/reset/imx8mp-reset.h> for i.MX8MP
> diff --git a/include/dt-bindings/reset/imx8mp-reset.h b/include/dt-bindings/reset/imx8mp-reset.h
> new file mode 100644
> index 0000000..ee37769
> --- /dev/null
> +++ b/include/dt-bindings/reset/imx8mp-reset.h
> @@ -0,0 +1,50 @@
> +// SPDX-License-Identifier: GPL-2.0-only

Thank you, I've changed this to

/* SPDX-License-Identifier: GPL-2.0-only */

and applied patches 1, 2, and 4.

regards
Philipp
