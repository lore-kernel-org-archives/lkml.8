Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E88C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:14:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22CB20578
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZf3KhdY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732589AbgDMRO3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732565AbgDMROX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:14:23 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49173C0A3BDC;
        Mon, 13 Apr 2020 10:14:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id i10so10891241wrv.10;
        Mon, 13 Apr 2020 10:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=NCloB/ogzJdXAIh9tkhxO1+IyWpGxa0FMmYj1590ZJk=;
        b=OZf3KhdYgA5GM+fEitWdpnlSiJ2vDS8L0Y4nBAvQ6ZFEQotkmBnNIAJzs5WOYVseB7
         lRMP7tSBp0lZQfq3TKTCL9m9rCKt9HyT3bJJeCQ0qiOfFsCVRCzaTEZ3f/6h9Sf+SZE4
         vtw3h2bcuu/VGEbUDMNlgL0K5ofgF10NmP7ztEkJYHzvh1CmAIAi/ldnFNTkw0dV+Kdv
         5UZqpXOpO/zzCxYlN2+Sr/segF/fjjkmoib0/E3dnHSI0SsYSwdPRQ4tD3giOg2d6hje
         co9onkLfZ0gOmn9hS/e2s/7g56V43MDpPhDwtP/tEEBe1rNR/dC9brfGpcjyVsUSbDXE
         cc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=NCloB/ogzJdXAIh9tkhxO1+IyWpGxa0FMmYj1590ZJk=;
        b=YjIr0lkX3EDgzKAsPjQuohc66tNa4ZlURg3W4N4Goz5AHpZigsizwSzCTbEQlEebrI
         PqLwRciszQtxOza3kJmHps+4ylFQMnwN+qUlk/3L+RCrnGY3ouZFuCMBn0wSPNBgF6AR
         IcSU8qQYG3dTYm2vF7q0q77Nx6yLGENzcqm0A1Soihcxm2WEWC6ds6e36AH+ur7EYZSC
         vYGew55a3IBNeswP6NuYWzxpWlFPOtGXsOBtSx3zUqvJ6UTNW0rZ9Hr3LaxOLNYqePaV
         qNVRQ5gJyLyjed+Ey/NREmZfuGCvqhWsqMXsjz8RHRqi0MrbdL3SjbWO/xDQJkN1iqe4
         GXRA==
X-Gm-Message-State: AGi0PuYC+hSzqjYbMpDeyiuHKO6eC5d4y7KcuH9R12B+YYo6nYfiIDQj
        dMQiuGHHbbbxJ2dRvsZSkbDk7YWWmM8=
X-Google-Smtp-Source: APiQypJNWzMbdOu+UjgqIt+HASwu4uE8Q9/xNGWNMGLnYPc83wWmOXZG4+pKQ8LwKjoAL1knRePmqA==
X-Received: by 2002:a5d:4012:: with SMTP id n18mr17131148wrp.387.1586798062068;
        Mon, 13 Apr 2020 10:14:22 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id h17sm3957607wmm.6.2020.04.13.10.14.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:14:21 -0700 (PDT)
Subject: Re: [PATCH v7 1/5] dt-bindings: arm64: dts: mediatek: Add mt8173 elm
 and hana
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Daniel Kurtz <djkurtz@chromium.org>
References: <20200210063523.133333-1-hsinyi@chromium.org>
 <20200210063523.133333-2-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <ec131e02-1556-d986-3628-ab1e00060643@gmail.com>
Date:   Mon, 13 Apr 2020 19:14:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200210063523.133333-2-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 7:35 AM, Hsin-Yi Wang wrote:
> Elm is Acer Chromebook R13. Hana is Lenovo Chromebook. Both uses mt8173=

> SoC.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

Applied to v5.7-next/dts64

Thanks!

> ---
>  .../devicetree/bindings/arm/mediatek.yaml     | 22 +++++++++++++++++++=

>  1 file changed, 22 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/arm/mediatek.yaml b/Docu=
mentation/devicetree/bindings/arm/mediatek.yaml
> index 4043c5046441..abc544dde692 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek.yaml
> +++ b/Documentation/devicetree/bindings/arm/mediatek.yaml
> @@ -84,6 +84,28 @@ properties:
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
> +          - const: google,elm
> +          - const: mediatek,mt8173
> +      - description: Google Hana (Lenovo Chromebook N23 Yoga, C330, 30=
0e,...)
> +        items:
> +          - const: google,hana-rev6
> +          - const: google,hana-rev5
> +          - const: google,hana-rev4
> +          - const: google,hana-rev3
> +          - const: google,hana
> +          - const: mediatek,mt8173
> +      - description: Google Hana rev7 (Poin2 Chromebook 11C)
> +        items:
> +          - const: google,hana-rev7
> +          - const: mediatek,mt8173
>        - items:
>            - enum:
>                - mediatek,mt8173-evb
>=20

