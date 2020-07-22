Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFCBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:10:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D51020674
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 12:10:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="eVIhmJTF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732156AbgGVMKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 08:10:31 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:1821 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726462AbgGVMKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 08:10:30 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06MC2OTE002090;
        Wed, 22 Jul 2020 14:09:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=vmdNwJ2HewNJLb/ngps5jILq7qbplk1hGoHXd/4wx9c=;
 b=eVIhmJTFr0bJmK4xQaclpzupG/RzTS98PjSvZWg1AYKan2EwyZHAKFAUT64zwIq1v7+Y
 fRhyDNJjSSbzUCTsDVyvqv6G46Ad9m1r2BYKO45XWiB4qQ8JswNJxbreqBCRXRH0IL8D
 H7emYCy1txezRsja1aQ+XNgXqgmL8ju+eeKe+viEO927B4/YrudVtC/V8lhkOAIEZ73d
 3FGHuRqsdpP7oww5oaevtuPtWNuvL5fX23UY7f2XPqWLqzs3iAoy9135b3Mv9hcCZCEf
 GLGosXeitedlugT4a9E7rlB1vHTWAl25OUPtDfi3Nn2DHOjh54+RbyW4bHRhWstt9iOU 9w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 32cux0ejnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 14:09:57 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1DE34100034;
        Wed, 22 Jul 2020 14:09:53 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D95252AF323;
        Wed, 22 Jul 2020 14:09:52 +0200 (CEST)
Received: from [10.48.0.224] (10.75.127.46) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Jul
 2020 14:09:52 +0200
Subject: Re: [Linux-stm32] [PATCH v3 3/3] ARM: dts: stm32: add initial support
 for stm32mp157-odyssey board
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Rob Herring <robh@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-kernel@vger.kernel.org>, Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Sam Ravnborg <sam@ravnborg.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20200721185317.208722-1-marcin.sloniewski@gmail.com>
 <20200721185317.208722-3-marcin.sloniewski@gmail.com>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <73077407-e008-1ae2-266d-1045a73620ba@st.com>
Date:   Wed, 22 Jul 2020 14:09:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200721185317.208722-3-marcin.sloniewski@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_05:2020-07-22,2020-07-22 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Marcin,

On 7/21/20 8:53 PM, Marcin Sloniewski wrote:
> +&sdmmc2 {
> +	pinctrl-names = "default", "opendrain", "sleep";
> +	pinctrl-0 = <&sdmmc2_b4_pins_a &sdmmc2_d47_pins_a>;
> +	pinctrl-1 = <&sdmmc2_b4_od_pins_a &sdmmc2_d47_pins_a>;
> +	pinctrl-2 = <&sdmmc2_b4_sleep_pins_a &sdmmc2_d47_sleep_pins_a>;
> +	non-removable;
> +	no-sd;
> +	no-sdio;
> +	st,neg-edge;
> +	bus-width = <4>;
> +	vmmc-supply = <&v3v3>;
> +	vqmmc-supply = <&v3v3>;
> +	mmc-ddr-3_3v;
> +	status = "okay";
> +};

Based on the pins muxed, 8 data lines are configured, but the bus width 
is set to 4. What is the reason of not setting this property to 8?

Regards,
Christophe Kerello.
