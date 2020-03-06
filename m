Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBBD9C10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A437207FD
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 09:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbgCFJHg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 04:07:36 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:36022 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbgCFJHf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 04:07:35 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 47FE8295CCF
Subject: Re: [PATCH] dt-bindings: mfd: cros-ec: Fix indentation in the example
To:     =?UTF-8?Q?Jonathan_Neusch=c3=a4fer?= <j.neuschaefer@gmx.net>,
        devicetree@vger.kernel.org
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        linux-kernel@vger.kernel.org
References: <20200305223631.27550-1-j.neuschaefer@gmx.net>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <32848672-85ab-5ed2-731c-bfd4dfa62760@collabora.com>
Date:   Fri, 6 Mar 2020 10:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200305223631.27550-1-j.neuschaefer@gmx.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jonathan,

On 5/3/20 23:36, Jonathan Neuschäfer wrote:
> Properties get one more level of indentation than the node they are in.
> 
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  Documentation/devicetree/bindings/mfd/cros-ec.txt | 6 +++---

Thanks for sending the patch but the binding is in process to be converted to
json-schema right now [1], and this change will not be needed.

Thanks,
  Enric

[1] https://patchwork.ozlabs.org/patch/1250141/

>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/cros-ec.txt b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> index 4860eabd0f72..3bf9d0868b98 100644
> --- a/Documentation/devicetree/bindings/mfd/cros-ec.txt
> +++ b/Documentation/devicetree/bindings/mfd/cros-ec.txt
> @@ -65,9 +65,9 @@ spi@131b0000 {
>  		wakeup-source;
>  		spi-max-frequency = <5000000>;
>  		controller-data {
> -		cs-gpio = <&gpf0 3 4 3 0>;
> -		samsung,spi-cs;
> -		samsung,spi-feedback-delay = <2>;
> +			cs-gpio = <&gpf0 3 4 3 0>;
> +			samsung,spi-cs;
> +			samsung,spi-feedback-delay = <2>;
>  		};
>  	};
>  };
> --
> 2.20.1
> 
