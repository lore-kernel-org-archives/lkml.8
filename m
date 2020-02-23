Return-Path: <SRS0=SnAt=4L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B82EC35670
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:26:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4107721D56
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Feb 2020 03:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="WrBCbsyr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MxDbz8Mt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbgBWD0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Feb 2020 22:26:33 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:36401 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbgBWD0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Feb 2020 22:26:32 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 1A122218C1;
        Sat, 22 Feb 2020 22:26:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 22 Feb 2020 22:26:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        subject:to:cc:references:from:message-id:date:mime-version
        :in-reply-to:content-type:content-transfer-encoding; s=fm2; bh=F
        q5Pvne5G6qnjZTjneNRiu68lwry5vZNmNqyfbQkjQw=; b=WrBCbsyrPncJazhGd
        RFrLkBgpnZme+BBLjPPxZnmwb6gkKDFTPRbjKCFgDWDKSq/8Dp8MH15qTOq1xA2v
        7WK40fZZJsfXO+8RjGCaTIW/AjTta277InhLQSW2UJ6uAYGps+NX+tz3yxfN2V+N
        OnoYYt7sPmWYCZYFsV705QR4P8y2wpWOI/X7Pp7iLK1g0vPxKK6T/oa2ZTwmdkW1
        Gbq+Dnc0LUw2EhMSQsdI7LS0IL34/BLldhFhEcYoe8aKP++cCKUjMeWBRYySi4T1
        gkfU7n1bPDyQdjq5vDOkLBKpCN08X6J/kHRsudP2wBN6DTLjd1EYERKYzpJXsh21
        ZxesQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=Fq5Pvne5G6qnjZTjneNRiu68lwry5vZNmNqyfbQkj
        Qw=; b=MxDbz8MtvjBLZkouhiXHV0VhDLj+qXp9f9f3QaqRLsNtD7/9RBUHLXFCE
        PwwM/muhJ7nnWsXZlT3D6yevyRolrnnHpRYllWTtGhELiyBbyHrKb6GtG9yoeB45
        ZRYlSB9MSYJNioKXpFYke9aHlAceTmlnYZRuQgqqosbASagu29wPP6zEoOsk00hD
        Kqvgpk2q2tdE/FRy371s4xQgm2XgxcowsvLgMxIV9OzWJMQwdGoqJQEIykHJOfNR
        QU2osY8N5JmnppDG1mFfxQrjmbImF78xjIDOkth16T2gTI0BjhHDYf+dGS3HzczC
        v7OIJw1yprP+MqJupcq4GAWTfVF0A==
X-ME-Sender: <xms:5_BRXnY4iB3lHEO-NYIBXxVc6VOviTaU6HdPyqCCSoZuRw-azHySEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeejgdehiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefuvfhfhffkffgfgggjtgfgsehtjeertddtfeejnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:5_BRXim6JjmIQXBUvawqqipBFfS3Fa7opxNXzPzB13LO_wXOA28nhw>
    <xmx:5_BRXhGAWlH8mhWT3Tycr_xkjzUTDd0MkRBj1bPfsCt1oe9122fjeQ>
    <xmx:5_BRXpMvz66UiGqpTz7F9SdUCkX0KXDvrWpOCnxaovCM2kMA9ycRgA>
    <xmx:6PBRXie4gW5iu5GhKuQMgadwWf_ebG3_uzh2GEtPTXb0Ab6wRfeXWQ>
Received: from [192.168.50.169] (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 123BE328005A;
        Sat, 22 Feb 2020 22:26:31 -0500 (EST)
Subject: Re: [linux-sunxi] [PATCH] arm64: dts: sun50i-h5-orange-pi-pc2: Add
 CPUX voltage regulator
To:     megous@megous.com, linux-sunxi@googlegroups.com
Cc:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20200222214541.210318-1-megous@megous.com>
From:   Samuel Holland <samuel@sholland.org>
Message-ID: <92a2b808-8280-7ad4-cfb4-8ff9488c02c8@sholland.org>
Date:   Sat, 22 Feb 2020 21:26:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200222214541.210318-1-megous@megous.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ondrej,

On 2/22/20 3:45 PM, Ondrej Jirman wrote:
> Orange Pi PC2 features sy8106a regulator just like Orange Pi PC.
> 
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> ---
>  .../dts/allwinner/sun50i-h5-orangepi-pc2.dts  | 29 +++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> index 70b5f09984218..5feedde95b5fc 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h5-orangepi-pc2.dts
> @@ -85,6 +85,10 @@ reg_usb0_vbus: usb0-vbus {
>  	};
>  };
>  
> +&cpu0 {
> +	cpu-supply = <&reg_vdd_cpux>;
> +};
> +

This should go alphabetically after "codec".

>  &codec {
>  	allwinner,audio-routing =
>  		"Line Out", "LINEOUT",
> @@ -180,6 +184,31 @@ flash@0 {
>  	};
>  };
>  
> +&r_i2c {

This should go alphabetically before "spi0".

> +	status = "okay";
> +
> +	reg_vdd_cpux: regulator@65 {
> +		compatible = "silergy,sy8106a";
> +		reg = <0x65>;
> +		regulator-name = "vdd-cpux";
> +		silergy,fixed-microvolt = <1200000>;

The resistors in the datasheet (10k/11.8k) make this 1.1V.

> +		/*
> +		 * The datasheet uses 1.1V as the minimum value of VDD-CPUX,
> +		 * however both the Armbian DVFS table and the official one
> +		 * have operating points with voltage under 1.1V, and both
> +		 * DVFS table are known to work properly at the lowest
> +		 * operating point.
> +		 *
> +		 * Use 1.0V as the minimum voltage instead.
> +		 */

The datasheet I have for H5 has "TBD" for the VDD-CPUX volatage range. I think
this comment only applies to H3 and is not necessary here.

> +		regulator-min-microvolt = <1000000>;
> +		regulator-max-microvolt = <1400000>;
> +		regulator-ramp-delay = <200>;
> +		regulator-boot-on;
> +		regulator-always-on;
> +	};
> +};
> +
>  &uart0 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart0_pa_pins>;
> 

Otherwise,
Reviewed-by: Samuel Holland <samuel@sholland.org>

Regards,
Samuel
