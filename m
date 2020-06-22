Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A0BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6844920720
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 14:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LaprxVVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgFVO33 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 10:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728993AbgFVO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:29:28 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E30C061573;
        Mon, 22 Jun 2020 07:29:28 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so16857779wru.12;
        Mon, 22 Jun 2020 07:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YfK6o+tP2PAnzpQlpalhKW9HAdmJlSSM+ezfRGkHYBc=;
        b=LaprxVVP0LoFTFs7valdPFIdTGvx/At2OcvIMxkVsxvlKQb37/FEYr6yKs1J8oQTGK
         AKJqxwX+gaBawZWbj7TUDv7X42E6/0uuKcQtM7n/FSoEUklGr0yywh1NPJHAifSynTH7
         AVMT/zPdaYjTmC9thd73ZFPVQ2AW3RhrNGJyvIUweHAuLat7OgXSLGLKm28rY7fDZnDF
         /Y9KVwvC6hELsJ4jQSDMqVMxrUXy9yYV6lejDjxhsFzN1vOeLyw0MvGxALTlCIYxyP/w
         Kl5cobIMGyz5dn4otRRAXdmr9OwJtx7uMMVwrcqWwXcE4UboEyS2NopC+2EaWbOzq+U6
         S3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=YfK6o+tP2PAnzpQlpalhKW9HAdmJlSSM+ezfRGkHYBc=;
        b=F2No6xECFX/0eHM06g6PqwQHMBYOBT9FXWeB15qMgGo96u5gz5Cafy80JDX9WSXk8x
         HwJ8R+Llbf0E6wAawGJNkSSVaC42lG01En0u8NV+/78aF0okYgRxyg0VJYaw0YBURcWt
         kungli4O8BFU2L4fAdcn/bzxb5643LM3USvJ3ZyJfNhE+c2feFJm+q6iXcbx+JfjBEh+
         zmAjC8e8dUwUr+WkgcWPbqx2CTQ2P61L1Y0vfQyOQObosDLBFetcu7dEfo67OnE7Bra+
         Kepmue4Yiv0q9R1EeJl8LlAEqOXqS9fecCnTT9vKqcMHrE/FPsgk66A5FbjRdkyk51jS
         vHwA==
X-Gm-Message-State: AOAM531j6sJ57KRFM5kdKKd/RycMvE/9z/rxoKAT9BkSHNWBdu6PdrkW
        8MEH/HPEqTWb5T7H/gqHHu7HBhS2
X-Google-Smtp-Source: ABdhPJzvuUStlbU/QhU5/fIGaPySqPAN/Ct9lmP2lkCxMb95evTFqOaV8Dr3DiQfQmptnI8ksTSY+g==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr3019741wru.200.1592836166655;
        Mon, 22 Jun 2020 07:29:26 -0700 (PDT)
Received: from ziggy.stardust ([213.195.114.138])
        by smtp.gmail.com with ESMTPSA id v24sm20834453wrd.92.2020.06.22.07.29.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jun 2020 07:29:25 -0700 (PDT)
Subject: Re: [RESEND v2 4/4] arm64: dts: mt6359: add PMIC MT6359 related nodes
To:     Wen Su <Wen.Su@mediatek.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, wsd_upstream@mediatek.com
References: <1592808050-14260-1-git-send-email-Wen.Su@mediatek.com>
 <1592808050-14260-5-git-send-email-Wen.Su@mediatek.com>
 <16c03b9e-ee74-c080-f2cc-f915ac4a90be@gmail.com>
 <1592826623.17794.9.camel@mtkswgap22>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Autocrypt: addr=matthias.bgg@gmail.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <67aec1a4-b08e-1159-6d35-66932d1971be@gmail.com>
Date:   Mon, 22 Jun 2020 16:29:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <1592826623.17794.9.camel@mtkswgap22>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/06/2020 13:50, Wen Su wrote:
> Hi Matthias,
> 
> On Mon, 2020-06-22 at 12:12 +0200, Matthias Brugger wrote:
>>
>> On 22/06/2020 08:40, Wen Su wrote:
>>> From: "Wen Su" <wen.su@mediatek.com>
>>>
>>> add PMIC MT6359 related nodes which is for MT6779 platform
>>>
>>> Signed-off-by: Wen Su <wen.su@mediatek.com>
>>> ---
>>>  arch/arm64/boot/dts/mediatek/mt6359.dtsi | 306 +++++++++++++++++++++++++++++++
>>>  1 file changed, 306 insertions(+)
>>>  create mode 100644 arch/arm64/boot/dts/mediatek/mt6359.dtsi
>>>
>>> diff --git a/arch/arm64/boot/dts/mediatek/mt6359.dtsi b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
>>> new file mode 100644
>>> index 0000000..4cafe1f
>>> --- /dev/null
>>> +++ b/arch/arm64/boot/dts/mediatek/mt6359.dtsi
>>> @@ -0,0 +1,306 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/*
>>> + * Copyright (c) 2019 MediaTek Inc.
>>> + */
>>> +
>>> +&pwrap {
>>> +	pmic: pmic {
>>> +		mt6359regulator: mt6359regulator {
>>
>> you are missing:
>> compatible = "mediatek,mt6359";
>> don't you?
> 
> I think this compatible string is for MFD driver.
> And the MFD instantiate the regulator driver when it probes.
> So this regulator patch set remove this compatible string.
> Is it better to add this compatible string in this patch set ?
> Thanks for your suggestion.
> 

Did you test the patch, does the regulator get's initialized? From what I
understand pmic wrapper is looking for a compatible string of the PMIC to get
the pwrap_slv_type.

If this is not the case, then please fix the binding documentation.

Regards,
Matthias

>>
>> Regards,
>> Matthias
>>
>>> +			compatible = "mediatek,mt6359-regulator";
>>> +			mt6359_vs1_buck_reg: buck_vs1 {
>>> +				regulator-name = "vs1";
>>> +				regulator-min-microvolt = <800000>;
>>> +				regulator-max-microvolt = <2200000>;
>>> +				regulator-enable-ramp-delay = <0>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vgpu11_buck_reg: buck_vgpu11 {
>>> +				regulator-name = "vgpu11";
>>> +				regulator-min-microvolt = <400000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <5000>;
>>> +				regulator-enable-ramp-delay = <200>;
>>> +				regulator-always-on;
>>> +				regulator-allowed-modes = <0 1 2>;
>>> +			};
>>> +			mt6359_vmodem_buck_reg: buck_vmodem {
>>> +				regulator-name = "vmodem";
>>> +				regulator-min-microvolt = <400000>;
>>> +				regulator-max-microvolt = <1100000>;
>>> +				regulator-ramp-delay = <10760>;
>>> +				regulator-enable-ramp-delay = <200>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vpu_buck_reg: buck_vpu {
>>> +				regulator-name = "vpu";
>>> +				regulator-min-microvolt = <400000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <5000>;
>>> +				regulator-enable-ramp-delay = <200>;
>>> +				regulator-allowed-modes = <0 1 2>;
>>> +			};
>>> +			mt6359_vcore_buck_reg: buck_vcore {
>>> +				regulator-name = "vcore";
>>> +				regulator-min-microvolt = <400000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <5000>;
>>> +				regulator-enable-ramp-delay = <200>;
>>> +				regulator-always-on;
>>> +				regulator-allowed-modes = <0 1 2>;
>>> +			};
>>> +			mt6359_vs2_buck_reg: buck_vs2 {
>>> +				regulator-name = "vs2";
>>> +				regulator-min-microvolt = <800000>;
>>> +				regulator-max-microvolt = <1600000>;
>>> +				regulator-enable-ramp-delay = <0>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vpa_buck_reg: buck_vpa {
>>> +				regulator-name = "vpa";
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <3650000>;
>>> +				regulator-enable-ramp-delay = <300>;
>>> +			};
>>> +			mt6359_vproc2_buck_reg: buck_vproc2 {
>>> +				regulator-name = "vproc2";
>>> +				regulator-min-microvolt = <400000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <7500>;
>>> +				regulator-enable-ramp-delay = <200>;
>>> +				regulator-always-on;
>>> +				regulator-allowed-modes = <0 1 2>;
>>> +			};
>>> +			mt6359_vproc1_buck_reg: buck_vproc1 {
>>> +				regulator-name = "vproc1";
>>> +				regulator-min-microvolt = <400000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <7500>;
>>> +				regulator-enable-ramp-delay = <200>;
>>> +				regulator-always-on;
>>> +				regulator-allowed-modes = <0 1 2>;
>>> +			};
>>> +			mt6359_vcore_sshub_buck_reg: buck_vcore_sshub {
>>> +				regulator-name = "vcore_sshub";
>>> +				regulator-min-microvolt = <400000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +			};
>>> +			mt6359_vaud18_ldo_reg: ldo_vaud18 {
>>> +				regulator-name = "vaud18";
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <1800000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vsim1_ldo_reg: ldo_vsim1 {
>>> +				regulator-name = "vsim1";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <3100000>;
>>> +				regulator-enable-ramp-delay = <480>;
>>> +			};
>>> +			mt6359_vibr_ldo_reg: ldo_vibr {
>>> +				regulator-name = "vibr";
>>> +				regulator-min-microvolt = <1200000>;
>>> +				regulator-max-microvolt = <3300000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vrf12_ldo_reg: ldo_vrf12 {
>>> +				regulator-name = "vrf12";
>>> +				regulator-min-microvolt = <1100000>;
>>> +				regulator-max-microvolt = <1300000>;
>>> +				regulator-enable-ramp-delay = <120>;
>>> +			};
>>> +			mt6359_vusb_ldo_reg: ldo_vusb {
>>> +				regulator-name = "vusb";
>>> +				regulator-min-microvolt = <3000000>;
>>> +				regulator-max-microvolt = <3000000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vsram_proc2_ldo_reg: ldo_vsram_proc2 {
>>> +				regulator-name = "vsram_proc2";
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <7500>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vio18_ldo_reg: ldo_vio18 {
>>> +				regulator-name = "vio18";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <1900000>;
>>> +				regulator-enable-ramp-delay = <960>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vcamio_ldo_reg: ldo_vcamio {
>>> +				regulator-name = "vcamio";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <1900000>;
>>> +				regulator-enable-ramp-delay = <1920>;
>>> +			};
>>> +			mt6359_vcn18_ldo_reg: ldo_vcn18 {
>>> +				regulator-name = "vcn18";
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <1800000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vfe28_ldo_reg: ldo_vfe28 {
>>> +				regulator-name = "vfe28";
>>> +				regulator-min-microvolt = <2800000>;
>>> +				regulator-max-microvolt = <2800000>;
>>> +				regulator-enable-ramp-delay = <120>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vcn13_ldo_reg: ldo_vcn13 {
>>> +				regulator-name = "vcn13";
>>> +				regulator-min-microvolt = <900000>;
>>> +				regulator-max-microvolt = <1300000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vcn33_1_bt_ldo_reg: ldo_vcn33_1_bt {
>>> +				regulator-name = "vcn33_1_bt";
>>> +				regulator-min-microvolt = <2800000>;
>>> +				regulator-max-microvolt = <3500000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vcn33_1_wifi_ldo_reg: ldo_vcn33_1_wifi {
>>> +				regulator-name = "vcn33_1_wifi";
>>> +				regulator-min-microvolt = <2800000>;
>>> +				regulator-max-microvolt = <3500000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vaux18_ldo_reg: ldo_vaux18 {
>>> +				regulator-name = "vaux18";
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <1800000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vsram_others_ldo_reg: ldo_vsram_others {
>>> +				regulator-name = "vsram_others";
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <5000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vefuse_ldo_reg: ldo_vefuse {
>>> +				regulator-name = "vefuse";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <2000000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vxo22_ldo_reg: ldo_vxo22 {
>>> +				regulator-name = "vxo22";
>>> +				regulator-min-microvolt = <1800000>;
>>> +				regulator-max-microvolt = <2200000>;
>>> +				regulator-enable-ramp-delay = <120>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vrfck_ldo_reg: ldo_vrfck {
>>> +				regulator-name = "vrfck";
>>> +				regulator-min-microvolt = <1500000>;
>>> +				regulator-max-microvolt = <1700000>;
>>> +				regulator-enable-ramp-delay = <480>;
>>> +			};
>>> +			mt6359_vbif28_ldo_reg: ldo_vbif28 {
>>> +				regulator-name = "vbif28";
>>> +				regulator-min-microvolt = <2800000>;
>>> +				regulator-max-microvolt = <2800000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vio28_ldo_reg: ldo_vio28 {
>>> +				regulator-name = "vio28";
>>> +				regulator-min-microvolt = <2800000>;
>>> +				regulator-max-microvolt = <3300000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vemc_ldo_reg: ldo_vemc {
>>> +				regulator-name = "vemc";
>>> +				regulator-min-microvolt = <2900000>;
>>> +				regulator-max-microvolt = <3300000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vcn33_2_bt_ldo_reg: ldo_vcn33_2_bt {
>>> +				regulator-name = "vcn33_2_bt";
>>> +				regulator-min-microvolt = <2800000>;
>>> +				regulator-max-microvolt = <3500000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vcn33_2_wifi_ldo_reg: ldo_vcn33_2_wifi {
>>> +				regulator-name = "vcn33_2_wifi";
>>> +				regulator-min-microvolt = <2800000>;
>>> +				regulator-max-microvolt = <3500000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_va12_ldo_reg: ldo_va12 {
>>> +				regulator-name = "va12";
>>> +				regulator-min-microvolt = <1200000>;
>>> +				regulator-max-microvolt = <1300000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_va09_ldo_reg: ldo_va09 {
>>> +				regulator-name = "va09";
>>> +				regulator-min-microvolt = <800000>;
>>> +				regulator-max-microvolt = <1200000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vrf18_ldo_reg: ldo_vrf18 {
>>> +				regulator-name = "vrf18";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <1810000>;
>>> +				regulator-enable-ramp-delay = <120>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vsram_md_ldo_reg: ldo_vsram_md {
>>> +				regulator-name = "vsram_md";
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1100000>;
>>> +				regulator-ramp-delay = <10760>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vufs_ldo_reg: ldo_vufs {
>>> +				regulator-name = "vufs";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <1900000>;
>>> +				regulator-enable-ramp-delay = <1920>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vm18_ldo_reg: ldo_vm18 {
>>> +				regulator-name = "vm18";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <1900000>;
>>> +				regulator-enable-ramp-delay = <1920>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vbbck_ldo_reg: ldo_vbbck {
>>> +				regulator-name = "vbbck";
>>> +				regulator-min-microvolt = <1100000>;
>>> +				regulator-max-microvolt = <1200000>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +			};
>>> +			mt6359_vsram_proc1_ldo_reg: ldo_vsram_proc1 {
>>> +				regulator-name = "vsram_proc1";
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +				regulator-ramp-delay = <7500>;
>>> +				regulator-enable-ramp-delay = <240>;
>>> +				regulator-always-on;
>>> +			};
>>> +			mt6359_vsim2_ldo_reg: ldo_vsim2 {
>>> +				regulator-name = "vsim2";
>>> +				regulator-min-microvolt = <1700000>;
>>> +				regulator-max-microvolt = <3100000>;
>>> +				regulator-enable-ramp-delay = <480>;
>>> +			};
>>> +			mt6359_vsram_others_sshub_ldo: ldo_vsram_others_sshub {
>>> +				regulator-name = "vsram_others_sshub";
>>> +				regulator-min-microvolt = <500000>;
>>> +				regulator-max-microvolt = <1193750>;
>>> +			};
>>> +		};
>>> +	};
>>> +};
>>>
> 
