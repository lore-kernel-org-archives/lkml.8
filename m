Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36FFDC54E4A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1694720644
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 03:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EjLINloi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbgEKDRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 23:17:53 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:4435 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgEKDRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 23:17:53 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eb8c3d30001>; Sun, 10 May 2020 20:17:39 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 10 May 2020 20:17:52 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 10 May 2020 20:17:52 -0700
Received: from [10.19.66.205] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 May
 2020 03:17:49 +0000
Subject: Re: [PATCH V2 6/8] phy: tegra: xusb: Add support for charger detect
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-7-git-send-email-nkristam@nvidia.com>
 <20200428105510.GH3592148@ulmo>
 <ea0f5906-4681-8b84-a55a-e959ce40aece@nvidia.com>
 <20200504155029.GB614153@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <229333de-8dd6-2d09-c8ad-99afdcec703f@nvidia.com>
Date:   Mon, 11 May 2020 08:49:37 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200504155029.GB614153@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1589167059; bh=dhOCrrvTkzHB+DWGZHHMWxRBnVmIB3xIwhi9oro8Ae4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=EjLINloir2HvrF0Xcs//fNNihRZi7fY12ShF48GOmR2ek7FpdH28Fd56VuOqH90Ea
         eMgsFlP41Y3N4fqJBLDkoL/tOZiTQtp2RAYh1WXI5DZD5GnI6TH6P0HUH8j9QcTEui
         uZgYjpVwQDhYs2dC/KOyG9pIgErQaf4Wj3moctX+6r+GWdo8yeIghs+CR56oKe4mgI
         LvwhEC6Ox9J0FS58SL4NFlyEQ988BzhxYj3012lFzQkHdWN3UpKvrQjxA3EPrd1pNR
         PpwckUh4jC8DUv7pSArMHGjGtTMOUv7H9uFVzsML82zs3J7hd+dQQ0yoS9SMRUEcIv
         GUmi4oW+StK/Q==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04-05-2020 21:20, Thierry Reding wrote:
> 
> On Mon, May 04, 2020 at 02:32:51PM +0530, Nagarjuna Kristam wrote:
>>> On 28-04-2020 16:25, Thierry Reding wrote:
>>>> On Wed, Apr 15, 2020 at 01:55:06PM +0530, Nagarjuna Kristam wrote:
> [...]
>>>> diff --git a/drivers/phy/tegra/xusb-tegra-cd.c b/drivers/phy/tegra/xusb-tegra-cd.c
>>>> +static void tegra_xusb_padctl_utmi_pad_dcd(struct tegra_xusb_padctl *padctl,
>>>> +					      u32 index)
>>>> +{
>>>> +	u32 value;
>>>> +	int dcd_timeout_ms = 0;
>>>> +	bool ret = false;
>>>> +
>>>> +	/* Turn on IDP_SRC */
>>>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>>>> +	value |= OP_I_SRC_EN;
>>>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL0(index));
>>>> +
>>>> +	/* Turn on D- pull-down resistor */
>>>> +	value = padctl_readl(padctl, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>>>> +	value |= USBON_RPD_OVRD_VAL;
>>>> +	padctl_writel(padctl, value, USB2_BATTERY_CHRG_OTGPADX_CTL1(index));
>>>> +
>>>> +	/* Wait for TDCD_DBNC */
>>>> +	usleep_range(10000, 120000);
>>>   From the comment this looks like we're waiting for some hardware
>>> condition. Can we somehow obtain this rather than implementing a fixed
>>> sleep? Especially since the range here is so large.
>>>
>> As per data sheet we need to wait for 10 micro seconds as settle time.
> Okay, so TDCD_DBNC is a value that comes from a timing diagram in a
> datasheet? Seems fine to leave it as-is then. Perhaps add parentheses
> and mention which exact datasheet that's from, and perhaps which figure
> so that people can more easily reference it. Provided there is a
> publicly available datasheet, of course.
> 
Will update reference to table in the data sheet where these values are 
recommended. ITs part of BC 1.2 spec from USB.

> Actually, one other thing: If the data sheet says to wait 10 us, why do
> you use an upper range of 120 us? Shouldn't a range of 10-20 us be good
> enough?
> Yes, will reduce it to 20ms.

-Nagarjuna
