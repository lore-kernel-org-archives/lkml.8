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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B76C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:57:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD61220739
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:57:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrQL6k8m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbgDMQ5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732216AbgDMQ5S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:57:18 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C97C0A3BDC;
        Mon, 13 Apr 2020 09:57:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a81so10629061wmf.5;
        Mon, 13 Apr 2020 09:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=mTpx6Z0OKTLIJPkJ7Yh8VEwdZmjdLhJUA6nbN5ppiEE=;
        b=qrQL6k8mIe333DRTkKehUyZNRhe3bactg8WMTrWAfRvbP9QXHYBQF1uyMNdWpG+bVV
         ZR5Bs42ZB6+oSnMcb7XSrmTQpKGnGE1dpZWnCdHUSs1NBLf5ndfJ+ohDrH2lfsAamHnY
         fO3ZiFKvnxsLB7k1GpL5jaNOSi/J5g8pdwgUke0/5hoRF26lhNlTiMzOxQAY5he8iSKJ
         dIn7wC1nBq66L3GRt9gjXr0/9kUopyHeWuvItyJV4zlpgXPIG6Vk3+7yRepRxyNti6K+
         Z+uYLO94LvBbLYfgU/H9GJHsxuVZA/W1MkxTelwZalDFsCe9N6SouzjA98nGAPPsJGnC
         2EbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=mTpx6Z0OKTLIJPkJ7Yh8VEwdZmjdLhJUA6nbN5ppiEE=;
        b=Ogp2VED1WK28f3o9cG47zfpjdX49txNHxio1MempLqIB6QZJmJygS5SJysNXc1Rlk/
         gAcoOHZqhkJCkaphx69eq2sg+GqDj6Ygrtr6At84vzyRZIWSABTIZG5wWaZC+IHUGIpB
         5Cqn+BNrcdiP8W1H7epEvlhqc65E4jFbQ1wcwNYcXAg5dyouCuSWankxQHWL3Oaniqqg
         Ok7jrAPaoY9YNj3dK5Hj4103gdC1L5/X/vLg4j25joB5Yw8d6Ful5j1u+BQ3wCC2H6Q3
         ssBacQ/onD4t24HQfz/Sz8eiux5UEEhGL2BX3/xVFjPmKEsaT+Iz48azegrbMyZksQbS
         hxUQ==
X-Gm-Message-State: AGi0PuYEnEAWRtn+0H9rMcEB2jTBDEiuM9UZ76XX92YjV/vSFFv85+KY
        gMaA6AJ7rqsuYqPkiD0/XJw=
X-Google-Smtp-Source: APiQypLcKYqiy17tJMR9wM00PZxGuCAJar8Ngo68RhBhAo1IY9kUsqEObXdIXuwbnnwkQCLa37T8aw==
X-Received: by 2002:a1c:ba09:: with SMTP id k9mr19020911wmf.176.1586797036339;
        Mon, 13 Apr 2020 09:57:16 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id g186sm16227344wmg.36.2020.04.13.09.57.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:57:15 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: mt8183: adjust cpuidle target residency
To:     Ikjoon Jang <ikjn@chromium.org>,
        linux-mediatek@lists.infradead.org,
        James Liao <jamesjj.liao@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hsinyi@chromium.org, drinkcat@chromium.org
References: <20200225080752.200952-1-ikjn@chromium.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <e8c4314a-466e-8ba4-d5ea-d50eab7a709b@gmail.com>
Date:   Mon, 13 Apr 2020 18:57:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200225080752.200952-1-ikjn@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/25/20 9:07 AM, Ikjoon Jang wrote:
> Split a cluster level cpuidle state into two, so mt8183 variant
> boards can adjust parameters for each cluster, and reduce cluster0's
> default target residency to 1000us as power measurements showed that
> its minimum residency is slightly less than cluster1's 1300us.
>=20
> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>

Applied to v5.7-next/dts64

Thanks!

> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 26 ++++++++++++++++--------=

>  1 file changed, 17 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot=
/dts/mediatek/mt8183.dtsi
> index f1381e77918b..5c7dd262eaf3 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -74,7 +74,7 @@ cpu0: cpu@0 {
>  			reg =3D <0x000>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <741>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
>  		};
> =20
>  		cpu1: cpu@1 {
> @@ -83,7 +83,7 @@ cpu1: cpu@1 {
>  			reg =3D <0x001>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <741>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
>  		};
> =20
>  		cpu2: cpu@2 {
> @@ -92,7 +92,7 @@ cpu2: cpu@2 {
>  			reg =3D <0x002>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <741>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
>  		};
> =20
>  		cpu3: cpu@3 {
> @@ -101,7 +101,7 @@ cpu3: cpu@3 {
>  			reg =3D <0x003>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <741>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP0>;
>  		};
> =20
>  		cpu4: cpu@100 {
> @@ -110,7 +110,7 @@ cpu4: cpu@100 {
>  			reg =3D <0x100>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <1024>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
>  		};
> =20
>  		cpu5: cpu@101 {
> @@ -119,7 +119,7 @@ cpu5: cpu@101 {
>  			reg =3D <0x101>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <1024>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
>  		};
> =20
>  		cpu6: cpu@102 {
> @@ -128,7 +128,7 @@ cpu6: cpu@102 {
>  			reg =3D <0x102>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <1024>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
>  		};
> =20
>  		cpu7: cpu@103 {
> @@ -137,7 +137,7 @@ cpu7: cpu@103 {
>  			reg =3D <0x103>;
>  			enable-method =3D "psci";
>  			capacity-dmips-mhz =3D <1024>;
> -			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP>;
> +			cpu-idle-states =3D <&CPU_SLEEP &CLUSTER_SLEEP1>;
>  		};
> =20
>  		idle-states {
> @@ -152,7 +152,15 @@ CPU_SLEEP: cpu-sleep {
>  				min-residency-us =3D <800>;
>  			};
> =20
> -			CLUSTER_SLEEP: cluster-sleep {
> +			CLUSTER_SLEEP0: cluster-sleep@0 {
> +				compatible =3D "arm,idle-state";
> +				local-timer-stop;
> +				arm,psci-suspend-param =3D <0x01010001>;
> +				entry-latency-us =3D <250>;
> +				exit-latency-us =3D <400>;
> +				min-residency-us =3D <1000>;
> +			};
> +			CLUSTER_SLEEP1: cluster-sleep@1 {
>  				compatible =3D "arm,idle-state";
>  				local-timer-stop;
>  				arm,psci-suspend-param =3D <0x01010001>;
>=20

