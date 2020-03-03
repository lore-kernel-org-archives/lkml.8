Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36259C3F2D1
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:11:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B82820828
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 16:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvMOlYXW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730152AbgCCQL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 11:11:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:34625 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729384AbgCCQL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 11:11:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id z15so5110852wrl.1;
        Tue, 03 Mar 2020 08:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+SzpTWQT3Ru6kg4f8Uj442Z+FLl17Fjj2BOSrwBP2tA=;
        b=JvMOlYXWMq0Xw1p+AMSLlLQea6qJWe/imSAwECDX0rMvjouX6tXhiTzi6l9PrEOKZH
         mdkAi2TI7TwqRHeOSAeN4q9w+Mfvk/US67aBFw14KS0w9HiygV3cRD7xJ9z5VRS3PXBr
         1jaA30b2hzUR0OE/6lXyX2IVnqwBLNuda+OJC4XozRGsax9OtpUhBPfs8c9xgxYWsIqA
         VuTKw5sjUPmNkpaU06pgtELNoVNP1YKm/LPYmN5gz9+5lVtFmcvVqJxFf5crA986u4HC
         RRz7ZOhDNXYl+enXW+x20gh545dfWhHil10Ywy6BIlDvrtAIwOqafQWOWpl3U18e7JhH
         mXOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+SzpTWQT3Ru6kg4f8Uj442Z+FLl17Fjj2BOSrwBP2tA=;
        b=HFOvzmfMPAd44Y/EP9xF5KFdE4WA+USwNtRHyiKzDfODsEds1EdgXDUvXol3Oye5Wu
         CqZnBHwlyLkWmrgemRW8E+JfBpT9hNpaKITHRqOb376DXcoPIDaEv3yQl7mPSziXhlrt
         cf6jFTQARLQyGIESqNYNqVetT0Q5piJZkFi4jmuKCh7MfXrbvVhO6+mMKTrNzJvu5xXV
         ZhdkXn1Vcr3rFdyP+d0fhNsHclrrG0rDS8rdtRi4b6ZuXP7Jy64PshDHhkkDMMuKjJUj
         PsNCSEpcP4OnFeRphIlkK1Gyx256uEyiiRKmXJzVQrB3dxudqsMJfejxROg7Qn2bhRUx
         5ORQ==
X-Gm-Message-State: ANhLgQ2mYYUxOsQNK5No6A8/+TjgZUCvB0t99Pqd93b+IwPVdk9bseZn
        uM+kUBZ5ZNnr9UGJYYA1ijDwBLcb
X-Google-Smtp-Source: ADFU+vsxfAPm/x+IV3Wuxbup+iavPIjBhYZz58QDdng5ipw9V1mPOt2TMllv6EsxNgKf3ODQBhebjg==
X-Received: by 2002:a5d:5743:: with SMTP id q3mr6227104wrw.135.1583251884664;
        Tue, 03 Mar 2020 08:11:24 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id s5sm32669295wru.39.2020.03.03.08.11.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 08:11:23 -0800 (PST)
Subject: Re: [PATCH v3 2/2] arm64: dts: rockchip: Add initial support for
 Pinebook Pro
From:   Johan Jonker <jbx6244@gmail.com>
To:     Tobias Schramm <t.schramm@manjaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Andy Yan <andy.yan@rock-chips.com>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Alexis Ballier <aballier@gentoo.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Nick Xie <nick@khadas.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        Vivek Unune <npcomplete13@gmail.com>,
        Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Vasily Khoruzhick <anarsoul@gmail.com>
References: <20200229144817.355678-1-t.schramm@manjaro.org>
 <20200229144817.355678-3-t.schramm@manjaro.org>
 <bcc2c8d4-a2cd-58c1-89af-e42439f8f344@gmail.com>
Message-ID: <850e60b0-c260-c184-839f-93b064388e32@gmail.com>
Date:   Tue, 3 Mar 2020 17:11:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <bcc2c8d4-a2cd-58c1-89af-e42439f8f344@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Add more reg = <..>

On 3/3/20 4:37 PM, Johan Jonker wrote:
> Hi Tobias,
> 
> Some minor style issues.
> This dts file contains a partition node.
> Question for the maintainers (Heiko?):
> Should that partition be included or not?

[..]

>> +&i2c4 {
>> +	i2c-scl-falling-time-ns = <20>;
>> +	i2c-scl-rising-time-ns = <600>;
>> +	status = "okay";
>> +
>> +	fusb0: fusb30x@22 {
>> +		compatible = "fcs,fusb302";
>> +		reg = <0x22>;
>> +		fcs,int_n = <&gpio1 RK_PA2 GPIO_ACTIVE_HIGH>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&fusb0_int_gpio>;
> 
>> +		status = "okay";
> 
> Remove or else status below.
> New nodes are already okay I think.
> If insure check compiled flat dts output to see if it is still there.
> 
>> +		vbus-supply = <&vbus_typec>;
>> +
>> +		connector {
>> +			compatible = "usb-c-connector";
>> +			label = "USB-C";
>> +			op-sink-microwatt = <1000000>;
>> +			power-role = "dual";
>> +			sink-pdos =
>> +				<PDO_FIXED(5000, 2500, PDO_FIXED_USB_COMM)>;
>> +			source-pdos =
>> +				<PDO_FIXED(5000, 1400, PDO_FIXED_USB_COMM)>;
>> +			try-power-role = "sink";
>> +
>> +			ports {
>> +				#address-cells = <1>;
>> +				#size-cells = <0>;
>> +
>> +				port@0 {

reg = <0>;

>> +					usbc_hs: endpoint {
>> +						remote-endpoint =
>> +							<&u2phy0_typec_hs>;
>> +					};
>> +				};
>> +
>> +				port@1 {

reg = <1>;

>> +					usbc_ss: endpoint {
>> +						remote-endpoint =
>> +							<&tcphy0_typec_ss>;
>> +					};
>> +				};
>> +
>> +				port@2 {

reg = <2>;

>> +					usbc_dp: endpoint {
>> +						remote-endpoint =
>> +							<&tcphy0_typec_dp>;
>> +					};
>> +				};
>> +			};
>> +		};
>> +	};
>> +};

