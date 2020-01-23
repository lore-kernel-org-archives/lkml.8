Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F77AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:13:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B712253D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 10:13:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgAWKNJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 05:13:09 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51907 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbgAWKNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 05:13:09 -0500
Received: from lupine.hi.pengutronix.de ([2001:67c:670:100:3ad5:47ff:feaf:1a17] helo=lupine)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iuZU2-0003Pm-G9; Thu, 23 Jan 2020 11:13:06 +0100
Received: from pza by lupine with local (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1iuZU2-0007Ya-4V; Thu, 23 Jan 2020 11:13:06 +0100
Message-ID: <6f661498f58c6a519095d0657413f4b89d3ef21e.camel@pengutronix.de>
Subject: Re: [PATCH] dt-bindings: reset: meson: add gxl internal dac reset
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 23 Jan 2020 11:13:06 +0100
In-Reply-To: <20200122092526.2436421-1-jbrunet@baylibre.com>
References: <20200122092526.2436421-1-jbrunet@baylibre.com>
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

On Wed, 2020-01-22 at 10:25 +0100, Jerome Brunet wrote:
> Add the reset line of the internal DAC found on the amlogic gxl SoC family
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  include/dt-bindings/reset/amlogic,meson-gxbb-reset.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
> index ea5058618863..883bfd3bcbad 100644
> --- a/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
> +++ b/include/dt-bindings/reset/amlogic,meson-gxbb-reset.h
> @@ -69,7 +69,7 @@
>  #define RESET_SYS_CPU_L2		58
>  #define RESET_SYS_CPU_P			59
>  #define RESET_SYS_CPU_MBIST		60
> -/*					61	*/
> +#define RESET_ACODEC			61
>  /*					62	*/
>  /*					63	*/
>  /*	RESET2					*/

Thank you, applied to reset/next.

regards
Philipp
