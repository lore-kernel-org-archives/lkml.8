Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235B7C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F255E206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 17:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hv+m/2Ja"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732591AbgDMROm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 13:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732565AbgDMROj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 13:14:39 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D8C0A3BDC;
        Mon, 13 Apr 2020 10:14:38 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id u13so10436440wrp.3;
        Mon, 13 Apr 2020 10:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KTfRhFc0H+kwv+SD3/E8dVwgkvnGDmoa9n2LhteLqK8=;
        b=Hv+m/2JavdLZC293G9KifdKah3AYNEZYIE1vcKJ3g1CCQBv2OFkC3ZSogiZ/CflIg8
         nNt3Ke3VYIuairoz1ErUHFlxrKdGHiNNYzENUNEx5SadGfltsOH9cfuDTgYGEAnv98S0
         0duzNFa/lSw71JrxMVgTD9Mvcb7o3u18N+BXzZ4hctvcjh+n/JivY75cl5QPyFrfCzTR
         p3XAq08YVrKvrDKMHsqPJ+l3qb4+FbaGpmB9R3/s8TUAlR7mK6iaF9M6y1EDpqbdl/Ac
         0U3X8Cnzv0IXlDP7RIBZP6HlZ8V//OyMXaxclpN7QyQsQDmL7qvDVogGG9Y0IT4nU4oU
         7Daw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KTfRhFc0H+kwv+SD3/E8dVwgkvnGDmoa9n2LhteLqK8=;
        b=bkaS3Blb4kkETSjShQanPTYJGhZPBphRJKT0neeT0bYHefQVpWhjHeq+QytfGkq5xt
         MAtXAkn6k0wwL0PWw9GMtnGalQUJwVKcL80D3Xv7NaOIlvjzZsiLLmvZF0Dfe2ITObPA
         Pswur9pQA1WcBGTn+GN36Hc6ydJoOz+cG/u5SdlaQzORpdBvr0vLFOrSST8SRPoTFq8P
         gcvXROjcqMZlA3znZZAPyhQII9+3tEZegaasbZV05UAJsGdrRKF4Pe83LBtUNVahY4lF
         yYbDsQQymtW93Ddrce91i6r37NxT6MyYm7SMTs1K2BuEJK0AyuX4ABdlFyM/mU14HNB5
         ZVLg==
X-Gm-Message-State: AGi0PubzNi4+MMH9iW1rXd0GNwS7BvaIF+QLWaSk1Y/XJAWv0+LPn9ij
        iC7A9/9Ypd1iRI4anQ9mnYshpmlSQXA=
X-Google-Smtp-Source: APiQypJ5JyYNAXadCRRdF5BJaWU4Cr3xvLV8/O1bH5UUY8++hTGNSd+4NyqT9hhkUwHE6cOgpVzDOQ==
X-Received: by 2002:a05:6000:10:: with SMTP id h16mr18705412wrx.295.1586798076857;
        Mon, 13 Apr 2020 10:14:36 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id f79sm14085568wme.32.2020.04.13.10.14.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 10:14:36 -0700 (PDT)
Subject: Re: [PATCH v7 2/5] arm64: dts: mt8173: add uart aliases
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
 <20200210063523.133333-3-hsinyi@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <7c5c7e2e-88e5-439a-fcaa-d5f64cbc1d0d@gmail.com>
Date:   Mon, 13 Apr 2020 19:14:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200210063523.133333-3-hsinyi@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/10/20 7:35 AM, Hsin-Yi Wang wrote:
> Add serial as uart aliases in mt8173.
>=20
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Applied to v5.7-next/dts64

Thanks!

> ---
>  arch/arm64/boot/dts/mediatek/mt8173.dtsi | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8173.dtsi
> index 8b4e806d5119..790cd64aa447 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
> @@ -50,6 +50,10 @@ aliases {
>  		mdp_wdma0 =3D &mdp_wdma0;
>  		mdp_wrot0 =3D &mdp_wrot0;
>  		mdp_wrot1 =3D &mdp_wrot1;
> +		serial0 =3D &uart0;
> +		serial1 =3D &uart1;
> +		serial2 =3D &uart2;
> +		serial3 =3D &uart3;
>  	};
> =20
>  	cluster0_opp: opp_table0 {
>=20

