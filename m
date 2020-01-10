Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA98C3F68F
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:38:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BA612077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 11:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbgAJLiO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 06:38:14 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:52246 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727840AbgAJLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 06:38:14 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 08AD7293976
Subject: Re: [PATCH v2 1/2] dt-bindings: arm64: dts: mediatek: Add mt8173 elm
 and hana
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <20200110073730.213789-1-hsinyi@chromium.org>
 <20200110073730.213789-2-hsinyi@chromium.org>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <dec0aab5-8610-9b7c-1ba1-8ac05f700b3f@collabora.com>
Date:   Fri, 10 Jan 2020 12:38:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200110073730.213789-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Yi,

Just a nit that is most a decision of the maintainer ...

On 10/1/20 8:37, Hsin-Yi Wang wrote:
> Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173
> SoC.
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Tested with patch 2 applied and saw that there is no errors with dtbs_check.

Tested-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

> ---
> Changes in v2:
> - fix dtbs_check errors, use const instead of enum
> ---
>  .../devicetree/bindings/arm/mediatek.yaml     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Documentation/devicetree/bindings/arm/mediatek.yaml
> index 4043c5046441..5272899b08fa 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -84,6 +84,33 @@ properties:
>            - enum:
>                - mediatek,mt8135-evbp1
>            - const: mediatek,mt8135
> +      - description: Google Elm (Acer Chromebook R13)
> +        items:
> +          - const: google,elm-rev8
> +          - const: google,elm-rev7
> +          - const: google,elm-rev6
> +          - const: google,elm-rev5
> +          - const: google,elm-rev4
> +          - const: google,elm-rev3
> +          - const: google,elm-rev2
> +          - const: google,elm-rev1
> +          - const: google,elm
> +          - const: mediatek,mt8173
> +      - description: Google Hana (Lenovo Chromebook and more)

nit: and more? How many? I'd expect the commercial model names here

Lenovo Chromebook C330?

Thanks,
 Enric

> +        items:
> +          - const: google,hana-rev6
> +          - const: google,hana-rev5
> +          - const: google,hana-rev4
> +          - const: google,hana-rev3
> +          - const: google,hana-rev2
> +          - const: google,hana-rev1
> +          - const: google,hana-rev0
> +          - const: google,hana
> +          - const: mediatek,mt8173
> +      - description: Google Hana rev7 (Poin2 Chromebook 11C)
> +        items:
> +          - const: google,hana-rev7
> +          - const: mediatek,mt8173
>        - items:
>            - enum:
>                - mediatek,mt8173-evb
> 
