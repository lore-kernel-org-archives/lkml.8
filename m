Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AACB0C33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80F7920708
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 06:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="olqhDNMt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbgA2GsE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 01:48:04 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:5368 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726020AbgA2GsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 01:48:03 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e312a940000>; Tue, 28 Jan 2020 22:47:48 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 28 Jan 2020 22:48:02 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 28 Jan 2020 22:48:02 -0800
Received: from [10.19.66.205] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 29 Jan
 2020 06:47:59 +0000
Subject: Re: [Patch V3 12/18] usb: gadget: tegra-xudc: support multiple device
 modes
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <jonathanh@nvidia.com>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <kishon@ti.com>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
 <1577704195-2535-13-git-send-email-nkristam@nvidia.com>
 <20200128181020.GJ2293590@ulmo>
X-Nvconfidentiality: public
From:   Nagarjuna Kristam <nkristam@nvidia.com>
Message-ID: <7478f53a-c236-5442-8abb-7531edb89b29@nvidia.com>
Date:   Wed, 29 Jan 2020 12:20:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200128181020.GJ2293590@ulmo>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1580280468; bh=SxpQ+2UID9jajci3A897vLNxQKnwkVPs/AOSn1AC7/o=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=olqhDNMtxOWOZVnY1KK7ycv1a6jTfzXxFm2/ygjmqqZcuYj+lFqV8zLJREISIUs+W
         aBUmtZYhXoYgGtCCVws/WGPSadaCq0LqfmqQjsd/JS3nNB4hdaVTIP0525ATl7sfzU
         rzyjGSv3riqtIQD3QKjKfo9UHsn+0MKLM+qbWxemszmz1PC0ckJ0NPnbshIHlHv3rZ
         et6CgdTMRLAk6s/3mpWAGwjPfKb3KCLXmqeGRiJCLhQZivDk0Hvfrg/dl4n3XOFqGY
         xfdjoaeXy7zf0ij8XYijjnHNOt+9YL57WYtpFQ1Lbaq4z2T3H/wL8/MpdDwfy3Mda8
         vGDTXXCOV9x4A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28-01-2020 23:40, Thierry Reding wrote:
>>   	struct tegra_xudc_save_regs saved_regs;
>>   	bool suspended;
>>   	bool powergated;
>>   
>> -	struct usb_phy *usbphy;
>> +	struct usb_phy **usbphy;
>> +	int current_phy_index;
> Can be unsigned int. It's also very long. It might be better to choose a
> shorter name so that when you use it, the lines don't get excessively
> long. Alternatively you could keep this field name and instead declare
> local variables to reference the current PHY to make lines shorter.
> 
> Actually, looking at this a bit more, I don't see current_phy_index ever
> used by itself (other than the assignment and one check to see if a PHY
> has been selected). So why not just store a pointer to the current PHY
> and avoid all the dereferencing?
> 
> Thierry

current_phy_index main purpose is to quickly get which index for USB 2 
and 3 phy's to be used. This is used at mulitple functions. Based on 
your comment above, I believe its good to use 2 pointers for UTMI and 
USB 3 phy's, which are points to current phy index. This ensures to keep 
line length as less as possible.

Thanks,
Nagarjuna
