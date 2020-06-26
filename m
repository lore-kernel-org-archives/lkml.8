Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5531AC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:42:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393472080C
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 08:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgFZImd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 04:42:33 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:46574 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725841AbgFZImc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 04:42:32 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 9DE972A59A3
Subject: Re: [PATCH 2/2] dt-bindings: mfd: Add DT compatible string
 "google,cros_ec_uart"
To:     Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org, "Lee Jones )" <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Furquan Shaikh <furquan@chromium.org>,
        Duncan Laurie <dlaurie@google.com>,
        Eric Peers <epeers@google.com>, devicetree@vger.kernel.org,
        Bhanu Prakash Maiya <bhanumaiya@google.com>
References: <20200625131432.1.Icb23b633700f1ef4d123e3f21fd26fad21a3f207@changeid>
 <20200625131432.2.Icfeab15fa04daaffc61280faf5a75cd9b23ee822@changeid>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <8ef4bb35-b2c8-ffdf-cefc-38c0d43d89e9@collabora.com>
Date:   Fri, 26 Jun 2020 10:42:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200625131432.2.Icfeab15fa04daaffc61280faf5a75cd9b23ee822@changeid>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bhanu,

Thank you for the patch.

On 25/6/20 23:34, Bhanu Prakash Maiya wrote:
> Add DT compatible string in
> Documentation/devicetree/bindings/mfd/cros_ec.txt
> 
> Signed-off-by: Bhanu Prakash Maiya <bhanumaiya@google.com>
> ---
> 
>  Documentation/devicetree/bindings/mfd/cros-ec.txt | 9 +++++++--

txt bindings are somewhat deprecated now, this specific binding was already
converted to the new json-schema, although didn't land yet, you should base your
changes on that, you can pick the following patch:

https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20200306085513.76024-1-ikjn@chromium.org/

Also, the kernel test robot, reported a build problem, so fix the problems on
the second version.

Thanks,
 Enric


>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> index 4860eabd0f729..ec8c5d7ecc266 100644
> --- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
> +++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> @@ -3,7 +3,7 @@ ChromeOS Embedded Controller
>  Google's ChromeOS EC is a Cortex-M device which talks to the AP and
>  implements various function such as keyboard and battery charging.
>  
> -The EC can be connect through various means (I2C, SPI, LPC, RPMSG) and the
> +The EC can be connect through various means (I2C, SPI, UART, LPC, RPMSG) and the
>  compatible string used depends on the interface. Each connection method has
>  its own driver which connects to the top level interface-agnostic EC driver.
>  Other Linux driver (such as cros-ec-keyb for the matrix keyboard) connect to
> @@ -17,6 +17,10 @@ Required properties (SPI):
>  - compatible: "google,cros-ec-spi"
>  - reg: SPI chip select
>  
> +Required properties (UART):
> +- compatible: "google,cros-ec-uart"
> +- reg: UART baudrate, flowcontrol
> +
>  Required properties (RPMSG):
>  - compatible: "google,cros-ec-rpmsg"
>  
> @@ -72,5 +76,6 @@ spi@131b0000 {
>  	};
>  };
>  
> -
>  Example for LPC is not supplied as it is not yet implemented.
> +
> +Example for UART is not supplied as it is not yet implemented.
> 
