Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1333CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:44:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDD5220671
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 09:44:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="UFysw5t4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgENJom (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 05:44:42 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18803 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbgENJol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 05:44:41 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ebd127f0001>; Thu, 14 May 2020 02:42:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 14 May 2020 02:44:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 14 May 2020 02:44:41 -0700
Received: from [10.25.73.206] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 14 May
 2020 09:44:37 +0000
Subject: Re: [PATCH V3 0/8] Tegra XUSB charger detect support
To:     Felipe Balbi <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1589437363-16727-1-git-send-email-nkristam@nvidia.com>
 <87wo5e4zzi.fsf@kernel.org>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <de31ad94-6884-cf83-36c4-0a865bc01753@nvidia.com>
Date:   Thu, 14 May 2020 15:16:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <87wo5e4zzi.fsf@kernel.org>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589449343; bh=IjElWauWpJw92WntPBv2Q9z6+yo5qw4xWM56DjfOXrA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=UFysw5t4oIzHzmyonRYLlW3RfxdrYITKUAEJOaiNz8TXpelUnGolk8wRFclt2gUsp
         milukPQu8fyoz+ySK0BJ6vimiRDpWU2QZidyPER2HDyJP8mkaXRjiUdz84u5lB7Crz
         SDZqkjVEoPM29GeGfEMaA/pVrwn9MPIvqnXeg58cHreZhExEC/JT+ss/Uj9hXwzoPj
         WXmHMAq2reAs0aJoIf6Gl7y1E9P+yvuT9A/az7+svUa+Cy/90YH+SLVLNlTPythwx3
         SfN2TehRuXTXPrMrgduBc3RJnRUWIr2CLMp9eMrFQ8IY4/MSlYdwTOo24z0EcvCLR+
         31RExRP4EVujQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14-05-2020 15:09, Felipe Balbi wrote:
> Nagarjuna Kristam<nkristam@nvidia.com>  writes:
> 
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
>> V3:
>>   - Added ACKed-by details for PHY driver and DT changes.
>>   - Functions and its arguments are aligned.
>>   - Tabs are used for alignment of MACRO's
>>   - For vbus_draw USDC callback, usb_phy set_power error is propogated.
>>   - Fixed various comments given by thierry.
>> V2:
>>   - Added ACKed-by details for DT patches.
>>   - All patches rebased.
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
> Is there a hard-dependency between gadget and phy patches?
> 
> -- balbiNo dependency. They can be merged independently.

- Nagarjuna
