Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B170FC433EB
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:19:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8709B2080D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 08:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pdutYX4l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbgGUITU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 04:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728023AbgGUITT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 04:19:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3344EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:19:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id 22so1907649wmg.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 01:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:from:to:cc:references:autocrypt:organization:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=50dy6gOy4VnETYBpt8F2LhG5PoN5UG/qdrKpJnuyzBs=;
        b=pdutYX4lmGspkMhGLRn8yWWyyGBmSb/X1IGXUQxF8iy2ShIdUFHvzBzey/uddGGfNX
         TrP4cEbPPkTZvwrZVQzi7ZqvykZMlM0LClu2RUDekxZT1O4KJefW29JkkuaHqLhCu0PJ
         SF6A87sjObqAI7H0WLfvwESy2X7NyIgw7o0qgLQIQmU7YgUUj9F7ALVQbH2WnXuAENKi
         FAsF07DbUaZLTnO+k1L5Rle+9LV7i3O9/trjCRJ293IaF2MbQNAjl2Fh1E4SgeIqG40J
         QiHY33FNM6e1SyqQNlGTNNLwWLrlmv/QPUKB5ioqSzGoY6XdnocfwDrS6a6oep/c1vzs
         nNoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=50dy6gOy4VnETYBpt8F2LhG5PoN5UG/qdrKpJnuyzBs=;
        b=BZNApPCJ+HxqpjR+8d2T7Rcyir3LaNbpbkUHBDOFVXowRYFrnCC5dEFc7ot59grB7I
         XJm8bEqdHVrzsklJRq0RgVMVhj5JM+Tbnoox2/E61VuH0HhuYaAQHAb91Ovu0VmtEiXz
         DgqNbBroK4fINODhVur7rpiPCOhV7vNAQxe57wDWJMIhOlEL7ZU8t1q2jZCSZJnR5UwJ
         VL4b6l7hunpqN9eFwyCGFUvwBni0ITHuuQvbgnWEjNlQaT+stMmUSP+xZ+LOzMFIN7WV
         A6jo7rPhG4CMFAPBBmfzFhYyGsS58quHQidsWi4nnp3yFD1pYPdwLJOx+jvytEPSgN35
         gI0A==
X-Gm-Message-State: AOAM533xCA+NEFrtaVYu1uxxUYn3ZIyfxjIpyiilxPTGrlOrSu1liino
        fv8J1pX05nH5dAXLjlBnroQF455G+KtmGg==
X-Google-Smtp-Source: ABdhPJwycEmheVhvsnSH0lNh4ClggSjaEwGjDk7cnoQcA+khNjoxaB85cyQkeqA0xPq3jV879D0EBw==
X-Received: by 2002:a1c:9914:: with SMTP id b20mr2881250wme.15.1595319557748;
        Tue, 21 Jul 2020 01:19:17 -0700 (PDT)
Received: from [10.1.2.12] (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id g3sm41413909wrb.59.2020.07.21.01.19.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 01:19:17 -0700 (PDT)
Subject: Re: [PATCH 3/3] arm64: dts: meson: add support for the ODROID-N2+
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Christian Hewitt <christianshewitt@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Dongjin Kim <tobetter@hardkernel.com>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
 <20200719141034.8403-4-christianshewitt@gmail.com>
 <90da2697-9dcc-1d75-eded-bf4bdc4b594b@baylibre.com>
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 BSwxi7g3Mu7u5kUByanqHyA=
Organization: Baylibre
Message-ID: <fc679db1-be92-c384-0fe2-3b06c920ea75@baylibre.com>
Date:   Tue, 21 Jul 2020 10:19:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <90da2697-9dcc-1d75-eded-bf4bdc4b594b@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/07/2020 10:10, Neil Armstrong wrote:
> On 19/07/2020 16:10, Christian Hewitt wrote:
>> HardKernel ODROID-N2+ uses an Amlogic S922X rev. C chip capable of higher
>> clock speeds than the original ODROID-N2. Hardkernel supports the big cpu
>> cluster at 2.4GHz and the little cpu cluster at 2.0GHz. Opp points and
>> regulator changess are from the HardKernel Linux kernel sources.
>>
>> Suggested-by: Dongjin Kim <tobetter@hardkernel.com>
>> Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
>> ---
>>  arch/arm64/boot/dts/amlogic/Makefile          |  1 +
>>  .../dts/amlogic/meson-g12b-odroid-n2-plus.dts | 53 +++++++++++++++++++
>>  2 files changed, 54 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>>
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index 5cac4d1d487d..6dc508b80133 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -8,6 +8,7 @@ dtb-$(CONFIG_ARCH_MESON) += meson-g12b-gtking-pro.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-a311d-khadas-vim3.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-s922x-khadas-vim3.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-g12b-odroid-n2-plus.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-g12b-ugoos-am6.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-kii-pro.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-nanopi-k2.dtb
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>> new file mode 100644
>> index 000000000000..99e96be509f8
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2-plus.dts
>> @@ -0,0 +1,53 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2019 BayLibre, SAS
>> + * Author: Neil Armstrong <narmstrong@baylibre.com>
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-g12b-odroid-n2.dtsi"
>> +
>> +/ {
>> +	compatible = "hardkernel,odroid-n2-plus", "amlogic,s922x", "amlogic,g12b";
>> +	model = "Hardkernel ODROID-N2+";
>> +
>> +	vddcpu_a: regulator-vddcpu-a {
>> +		regulator-min-microvolt = <680000>;
>> +		regulator-max-microvolt = <1040000>;
>> +
>> +		pwms = <&pwm_ab 0 1500 0>;
>> +	};
>> +
>> +	vddcpu_b: regulator-vddcpu-b {
>> +		regulator-min-microvolt = <680000>;
>> +		regulator-max-microvolt = <1040000>;
>> +
>> +		pwms = <&pwm_AO_cd 1 1500 0>;
>> +	};
>> +
>> +	cpu_opp_table_0: opp-table-0 {
>> +		opp-1908000000 {
>> +			opp-hz = /bits/ 64 <1908000000>;
>> +			opp-microvolt = <1030000>;
>> +		};
>> +
>> +		opp-2016000000 {
>> +			opp-hz = /bits/ 64 <2016000000>;
>> +			opp-microvolt = <1040000>;
>> +		};
>> +	};
>> +
>> +	cpub_opp_table_1: opp-table-1 {
>> +		opp-2304000000 {
>> +			opp-hz = /bits/ 64 <2304000000>;
>> +			opp-microvolt = <1030000>;
>> +		};
>> +
>> +		opp-2400000000 {
>> +			opp-hz = /bits/ 64 <2400000000>;
>> +			opp-microvolt = <1040000>;
>> +		};
>> +	};
>> +};
>> +
>>
> Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
> 

Wait no, it should be:

/ {
	compatible = "hardkernel,odroid-n2-plus", "amlogic,s922x", "amlogic,g12b";
	model = "Hardkernel ODROID-N2+";
};

&vddcpu_a {
	regulator-min-microvolt = <680000>;
	regulator-max-microvolt = <1040000>;

	pwms = <&pwm_ab 0 1500 0>;
};

&vddcpu_b {
	regulator-min-microvolt = <680000>;
	regulator-max-microvolt = <1040000>;

	pwms = <&pwm_AO_cd 1 1500 0>;
};

&cpu_opp_table_0 {
		opp-1908000000 {
		opp-hz = /bits/ 64 <1908000000>;
		opp-microvolt = <1030000>;
	};

	opp-2016000000 {
		opp-hz = /bits/ 64 <2016000000>;
		opp-microvolt = <1040000>;
	};
};

&cpub_opp_table_1 {
	opp-2304000000 {
		opp-hz = /bits/ 64 <2304000000>;
		opp-microvolt = <1030000>;
	};

	opp-2400000000 {
		opp-hz = /bits/ 64 <2400000000>;
		opp-microvolt = <1040000>;
	};
};

Neil
