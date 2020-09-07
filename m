Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAC9EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 02:34:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7281D2151B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 02:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="hCxQVefu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIGCev (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 22:34:51 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16197 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbgIGCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 22:34:50 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f559c3c0000>; Sun, 06 Sep 2020 19:34:36 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 06 Sep 2020 19:34:50 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 06 Sep 2020 19:34:50 -0700
Received: from [10.19.100.119] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 7 Sep
 2020 02:34:44 +0000
Subject: Re: [PATCH v2 05/12] phy: tegra: xusb: add sleepwalk and
 suspend/resume
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <gregkh@linuxfoundation.org>, <robh@kernel.org>,
        <jonathanh@nvidia.com>, <kishon@ti.com>,
        <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>
References: <20200831044043.1561074-1-jckuo@nvidia.com>
 <20200831044043.1561074-6-jckuo@nvidia.com> <20200831115857.GC1689119@ulmo>
X-Nvconfidentiality: public
From:   JC Kuo <jckuo@nvidia.com>
Message-ID: <24571c2d-0386-2b49-419d-4eada7a73f8e@nvidia.com>
Date:   Mon, 7 Sep 2020 10:34:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200831115857.GC1689119@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1599446076; bh=fjuOyfcejLoiM91svaHTJ5EfrAsTKXbximdPX5XFq3M=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=hCxQVefuT7GT2kpLYwrZDveJQvY83sqYvTVGgkIWr2VsAzGuD+At0uS5Vcq1riwiC
         cUQVRjF8o1ZtgKoyzMLfUMNxUixcFiZ6o833Mg9fGVJnyI5Upr2Rv9A1hqARJsw2W4
         bObZ3wJXSU/+jk1j1IWi8OgcCilL7Iz19SFxDS9tSjxACYMbywpWm7BxCDKPEIzf95
         qVTzKVIxvTQvlNZMfvOhF7FDgkCFo4sKM5EjmPyy/wpHpgodCuM6eufsq7EhzI8h17
         D+v2KS+K8p65w3k8J7Gcff+ekafrOiTlxJ9aGVfynOQfYMuCvdXQwMpqudW5Da8vMM
         3zTCPTpM1aQjw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,
Thanks for review. I will amend accordingly and submit a new patch.

JC

On 8/31/20 7:58 PM, Thierry Reding wrote:
> Again, use a capital letter to start the subject after the prefix.
> 
> On Mon, Aug 31, 2020 at 12:40:36PM +0800, JC Kuo wrote:
>> This commit adds sleepwalk/wake and suspend/resume interfaces
>> to Tegra XUSB PHY driver.
>>
>> Tegra XUSB host controller driver makes use of sleepwalk functions
>> to enable/disable sleepwalk circuit which is in always-on partition
>> can respond to USB resume signals when controller is not powered.
> 
> "and can respond to ..."?
> 
>> Sleepwalk can be enabled/disabled for any USB phy individually.
> 
> "USB PHY"
> 
>>
>>   - tegra_xusb_padctl_enable_phy_sleepwalk()
>>   - tegra_xusb_padctl_disable_phy_sleepwalk()
>>
>> Tegra XUSB host controller driver makes use of wake functions to
>> enable/disable/query wake circuit which is in always-on partition
>> can wake system up when USB resume happens.
>> Wake circuit can be enabled/disabled for any USB phy individually.
> 
> "USB PHY"
> 
> Thierry
> 
