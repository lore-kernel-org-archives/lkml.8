Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC1CC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2333020732
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 08:44:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EWG4BCTr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgC3Ion (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 04:44:43 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:5600 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgC3Iol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 04:44:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e81b1190001>; Mon, 30 Mar 2020 01:43:05 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Mar 2020 01:44:40 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Mar 2020 01:44:40 -0700
Received: from [10.19.66.205] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Mar
 2020 08:44:37 +0000
Subject: Re: [PATCH V1 0/8] Tegra XUSB charger detect support
To:     Felipe Balbi <balbi@kernel.org>, <kishon@ti.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <jckuo@nvidia.com>
References: <1584527467-8058-1-git-send-email-nkristam@nvidia.com>
 <87pncve963.fsf@kernel.org>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <48fde9ce-7d40-c2c3-1a9c-994654a02367@nvidia.com>
Date:   Mon, 30 Mar 2020 14:16:42 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87pncve963.fsf@kernel.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1585557785; bh=1dKDEs5gWtkDsylFO2e+kSrsyDzzlh3tTKE9IwHKrPs=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EWG4BCTr1V0RuTNLY0j/gnn3pyoRNc1+vbP86nP6hU6uLUGQ2ClNoxhMvgTaq7Sh2
         UR0fSJ2oRmJm4LSeOj+ktG9cC3XJSqAYzScVgqZ8bacYup4u/TyAmQftR/D6KLxtFK
         EG+1ME9eqGYB/O2FvedQC02e3RGoNMYxM02swps8ryEtdRrkXpFxKtPOoZ8JojUXqq
         Z1Vn0oMTTqhoXiUamkHqWvVwEuajm1EcbY8OGSuLccztgIHbgMQC5p5SvZ2serCSCo
         sBjQhc+3REeI6+7gAKqbJWzYcGez5Z0duKaDjnYgyUXmh1ClkqhXMRJNWldkFWI3cn
         4jjYEMHVNRXRw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29-03-2020 16:10, Felipe Balbi wrote:
>> This patch series adds charger detect support on XUSB hardware used in
>> Tegra210 and Tegra186 SoCs.
>>
>> This patchset is composed with :
>>   - dt bindings of XUSB Pad Controller
>>   - Tegra XUSB device mode driver to add vbus_draw support
>>   - Tegra PHY driver for charger detect support
>>
>> Tests done:
>>   - Connect USB cable from ubuntu host to micro-B port of DUT to detect
>>     SDP_TYPE charger
>>   - Connect USB cable from external powered USB hub(which inturn connects
>>     to ubuntu host) to micro-B port of DUT to detect CDP_TYPE charger.
>>   - Connect USB cable from USB charger to micro-B port of DUT to detect
>>     DCP_TYPE charger.
>> DUT: Jetson-tx1, Jetson tx2.
>>
>> Nagarjuna Kristam (8):
>>    dt-bindings: phy: tegra-xusb: Add charger-detect property
>>    usb: gadget: tegra-xudc: Add vbus_draw support
>>    phy: tegra: xusb: Add support for UTMI pad power control
>>    phy: tegra: xusb: Add USB2 pad power control support for Tegra210
>>    phy: tegra: xusb: Add soc ops API to enable UTMI PAD protection
>>    phy: tegra: xusb: Add support for charger detect
>>    phy: tegra: xusb: Enable charger detect for Tegra186
>>    phy: tegra: xusb: Enable charger detect for Tegra210
> this doesn't apply cleanly. Could you resend after -rc1 is tagged?
> 
> -- balbi

Sure, will send rebased patch once rc1 is available.

Thanks,
Nagarjuna
