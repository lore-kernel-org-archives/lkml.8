Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A91BC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE9422076E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 19:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="VBQLhkMm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgHRTHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 15:07:02 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49516 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHRTHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 15:07:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 07IJ6teI012213;
        Tue, 18 Aug 2020 14:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1597777615;
        bh=ATT9YzBtFfOv6tpYe6xqvgONf4ZLmPGq3Z7H+UA4wq8=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=VBQLhkMmzhTnD3FER2HDMQbJDIv+qAZi+y0679ddInmb8qZF2jnzHs1cCw4G6bc7t
         00aFty27gkNRGCbW+lXZCCaF8XiSRVv7kU3jRcSLiVYkLEcxCWCJFBp0eEaHYNjJXi
         8HypjwHbTUTO+20io0KUxNaB5N2rF4pfa5twIz4E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IJ6tCl079230;
        Tue, 18 Aug 2020 14:06:55 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 18
 Aug 2020 14:06:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 18 Aug 2020 14:06:54 -0500
Received: from [10.250.38.37] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 07IJ6sbK107852;
        Tue, 18 Aug 2020 14:06:54 -0500
Subject: Re: [PATCH] dt: bindings: lp55xx: Updte yaml examples with new color
 ID
To:     <pavel@ucw.cz>, <robh@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-leds@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20200812193248.11325-1-dmurphy@ti.com>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <df82c0f7-8ea6-04f6-6da1-018dac7e4c6b@ti.com>
Date:   Tue, 18 Aug 2020 14:06:54 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200812193248.11325-1-dmurphy@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel

On 8/12/20 2:32 PM, Dan Murphy wrote:
> Update the binding examples for the color ID to LED_COLOR_ID_RGB
>
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
>   Documentation/devicetree/bindings/leds/leds-lp55xx.yaml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> index b1bb3feb0f4d..89f69d62493e 100644
> --- a/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> +++ b/Documentation/devicetree/bindings/leds/leds-lp55xx.yaml
> @@ -189,7 +189,7 @@ examples:
>                  #address-cells = <1>;
>                  #size-cells = <0>;
>                  reg = <0x2>;
> -               color = <LED_COLOR_ID_MULTI>;
> +               color = <LED_COLOR_ID_RGB>;
>                  function = LED_FUNCTION_STANDBY;
>                  linux,default-trigger = "heartbeat";
>   

Don't forget this simple update to the LP55xx yaml file.

Dan

