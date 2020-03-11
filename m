Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58BD1C18E5A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 277FB2146E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 12:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="aTpp+PrQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgCKMzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 08:55:43 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:43928 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbgCKMzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 08:55:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02BCtHkD007419;
        Wed, 11 Mar 2020 07:55:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583931317;
        bh=48Zh5AGbANDxkAALhrTBL8IRtDqvahqwmRcvUOxVdiU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=aTpp+PrQ4Oar5nf76xssq6nNaaL6C9ffrxSfPVSyJ+RAzXqqzmAD/cx1bnMP4AAC7
         lYnP0+PKHn0kDttEDJLAZ0wVVyTZB0Xh6FZASv/2V8jaEaj9gilHyd7bPEwLUccZD1
         VSM5Fu8bnBZqYWjEPMkgRFU6wn65cYxOB97CuMB8=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02BCtH0a113914
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 11 Mar 2020 07:55:17 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 11
 Mar 2020 07:55:16 -0500
Received: from localhost.localdomain (10.64.41.19) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 11 Mar 2020 07:55:17 -0500
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by localhost.localdomain (8.15.2/8.15.2) with ESMTP id 02BCtFIT120884;
        Wed, 11 Mar 2020 07:55:15 -0500
Subject: Re: [PATCH 2/3] dt-bindings: leds: Add binding for sgm3140
To:     Luca Weiss <luca@z3ntu.xyz>, <linux-leds@vger.kernel.org>
CC:     Heiko Stuebner <heiko@sntech.de>, Icenowy Zheng <icenowy@aosc.io>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Pavel Machek <pavel@ucw.cz>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>
References: <20200309203558.305725-1-luca@z3ntu.xyz>
 <20200309203558.305725-3-luca@z3ntu.xyz>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <4f848ab3-0e76-ae63-0771-758b1eaa0660@ti.com>
Date:   Wed, 11 Mar 2020 07:49:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200309203558.305725-3-luca@z3ntu.xyz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Luca

On 3/9/20 3:35 PM, Luca Weiss wrote:
> Add YAML devicetree binding for SGMICRO SGM3140 charge pump used for
> camera flash LEDs.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes since RFC:
> - new patch
>
> I'm not sure about the completeness of this binding as it doesn't
> mention the led subnode at all.
> The only existing led yaml binding is leds/leds-max77650.yaml which
> mentions the subnode but duplicates properties from documented in
> leds/common.txt.
>
>   .../bindings/leds/leds-sgm3140.yaml           | 53 +++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
>
> diff --git a/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> new file mode 100644
> index 000000000000..be9384573d02
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/leds-sgm3140.yaml
> @@ -0,0 +1,53 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/leds-sgm3140.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SGMICRO SGM3140 500mA Buck/Boost Charge Pump LED Driver
> +
> +maintainers:
> +  - Luca Weiss <luca@z3ntu.xyz>
> +
> +description: |
> +  The SGM3140 is a current-regulated charge pump which can regulate two current
> +  levels for Flash and Torch modes.
> +
> +  It is controlled with two GPIO pins.
Please define "It".  Not sure what is controlled here.


Dan

