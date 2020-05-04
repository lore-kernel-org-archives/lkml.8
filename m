Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A3FFC47254
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:09:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E10FC20661
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 04:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cZhxQs0B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgEDEJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 00:09:00 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:17434 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725770AbgEDEI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 00:08:59 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5eaf954e0000>; Sun, 03 May 2020 21:08:47 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 03 May 2020 21:08:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 03 May 2020 21:08:59 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May
 2020 04:08:58 +0000
Received: from [10.19.66.205] (10.124.1.5) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 4 May 2020
 04:08:55 +0000
Subject: Re: [PATCH V2 2/8] usb: gadget: tegra-xudc: Add vbus_draw support
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1586939108-10075-1-git-send-email-nkristam@nvidia.com>
 <1586939108-10075-3-git-send-email-nkristam@nvidia.com>
 <20200428095956.GB3592148@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <b22b696b-69db-a680-f3c6-a54ec6c7acad@nvidia.com>
Date:   Mon, 4 May 2020 09:40:48 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200428095956.GB3592148@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1588565327; bh=68fwostdTEIu4e1eYM/xozH9ML01bWeSStjD0PufGGA=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cZhxQs0Bnq4E1UPuXHP+ngvhGzFdSmgUjfPs5pn6DuizxrrzDEzLje6RUejp54E6+
         yPy30jRk/x24CioXuqDwN0qH1dXjk0YSBN2DkrkKXorEwcotngSAALc147BWmLglTD
         cPFEVtztCWGJOvrIx4Wt1fE8dz79NO5zqXPjS4JRmbPHtxzM95KB57j6JSsmPkkTAz
         oLYr1WZggv1TpAkq7lTPLCasKT8DytlS4gx+mP+GKv3HYtYyt48FXvxiFBXC0laiq4
         PHRzCYrVpma5zRHHPHaNHmEBs07xMYvH6lKYPUR36WipwdsIFmjY4vNklFi7rDvU9b
         J35MvePpyLqOQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-04-2020 15:29, Thierry Reding wrote:
>> @@ -2042,6 +2044,19 @@ static int tegra_xudc_gadget_stop(struct usb_gadget *gadget)
>>   	return 0;
>>   }
>>   
>> +static int tegra_xudc_gadget_vbus_draw(struct usb_gadget *gadget,
>> +						unsigned int m_a)
>> +{
>> +	struct tegra_xudc *xudc = to_xudc(gadget);
>> +
>> +	dev_dbg(xudc->dev, "%s: %u mA\n", __func__, m_a);
>> +
>> +	if (xudc->curr_usbphy->chg_type == SDP_TYPE)
>> +		usb_phy_set_power(xudc->curr_usbphy, m_a);
> Do we need to propagate the error code here in case the USB PHY for some
> reason doesn't support the given current? Or is it guaranteed that we
> always do support whatever is passed in here?
> 
> Regardless of whether we support it or not, it might still be useful to
> add proper handling, if for nothing else but to set a good example.
> 
> Thierry
Will update accordingly, propagate the return the code to caller.
