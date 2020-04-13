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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0DFC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AAE2072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 16:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxTrCDfa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731509AbgDMQYO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 12:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731410AbgDMQYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 12:24:13 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AB8EC0A3BDC;
        Mon, 13 Apr 2020 09:24:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d77so9823129wmd.3;
        Mon, 13 Apr 2020 09:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qXtx8pTfrIn1zXbbdxMLKHupYMldDuB/xcfzgVD2/4Y=;
        b=cxTrCDfaNSVq0KbO/slYbodm5PO63GOaSaGZztgQHMlusGJ1U3HDI8tD/veoZUH4qE
         yL/Z6fblhdhVeEl1x0F45BFvkrUr+4hP5qXNd6NRt9HynyYtkfoYeafz/4MA08Co6J/4
         KPE2obMJ51RnPX1/89IZRfApghGoq1QEYJJQWu++VXpMhU0WlZEf2IQ83HqcOzaT8kMe
         fwOC1CTerFYmi93xpDSSxrGaduA5NzlGhv6boSv8q5vmiT7xL5BeHP7eCVDbOFOEnDLc
         0SaNBZEbYQb/LdVbxKRHN5m/657N1/RI0MgQR86iaw53YkO880Lym0IxfPoy92XZQZlW
         mqCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qXtx8pTfrIn1zXbbdxMLKHupYMldDuB/xcfzgVD2/4Y=;
        b=PavAtqy7UYk3MsV/Q3VyEoaHW3RP1m3Uka+U9AJ8PbPB/QaKwdZbAylE+e1TZRYCXe
         cx7ULlvet+risjPcMTZi555O4xFXVOgaqi54FG7WOLpfBtm0AA1pi1bnuqGbpFFlXV4I
         jhpNYBdQJcXa53C4gW3sT9hzRUdWjHhp7nmVlAxD14iCXtEx6NOgIyTjHT6D7w84LKtP
         2LbHNtg7VlFzkQNlAtM576w8yRuFcNsWHn+WxBhbrry5HjFX5NEQlxJ1LVK5UESomID+
         pufTnDBEX+t35biqzi3DBHJKZNW2FVDf4BhUPiGRXjXetfPCIQL9CZ9o3mZmRqHtp2tn
         InGg==
X-Gm-Message-State: AGi0PuaY+yGz4UdNkxcNNfmOP7MQ0lUFZNShUaZgHXjyJd54804PMKgk
        4K8v3ssFx/4xVaVHo+42AZI=
X-Google-Smtp-Source: APiQypIub1H5T2wOlisyD5+cKtMSkwzxwYBxJAfApq0itvUcldvHMbGePzvT4NrF0LKC4F434xY7ZQ==
X-Received: by 2002:a1c:4d18:: with SMTP id o24mr18365679wmh.141.1586795051744;
        Mon, 13 Apr 2020 09:24:11 -0700 (PDT)
Received: from linux-gy6r.site ([213.195.113.243])
        by smtp.gmail.com with ESMTPSA id j68sm15754725wrj.32.2020.04.13.09.24.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2020 09:24:11 -0700 (PDT)
Subject: Re: [PATCH] arm: dts: mt7623: add phy-mode property for gmac2
To:     sean.wang@mediatek.com, robh+dt@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        john@phrozen.org
References: <70e3eff31ecd500ed4862d9de28325a4dbd15105.1583648927.git.sean.wang@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
X-Pep-Version: 2.0
Message-ID: <e53c4dda-411b-4664-a6ab-94d9033d4814@gmail.com>
Date:   Mon, 13 Apr 2020 18:24:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <70e3eff31ecd500ed4862d9de28325a4dbd15105.1583648927.git.sean.wang@mediatek.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/8/20 7:34 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
>=20
> Add phy-mode property required by phylink on gmac2
>=20
> Fixes: b8fc9f30821e ("net: ethernet: mediatek: Add basic PHYLINK suppor=
t")
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Applied to v5.7-next/arm32

Thanks!

> ---
>  arch/arm/boot/dts/mt7623n-rfb-emmc.dts | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts b/arch/arm/boot/dts=
/mt7623n-rfb-emmc.dts
> index b7606130ade9..0447748f9fa0 100644
> --- a/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> +++ b/arch/arm/boot/dts/mt7623n-rfb-emmc.dts
> @@ -138,6 +138,7 @@ fixed-link {
>  	mac@1 {
>  		compatible =3D "mediatek,eth-mac";
>  		reg =3D <1>;
> +		phy-mode =3D "rgmii";
>  		phy-handle =3D <&phy5>;
>  	};
> =20
>=20

