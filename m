Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36269C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10D84207D3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 17:56:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZIhbg0Ed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729466AbgESR4w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 13:56:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:53706 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726283AbgESR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 13:56:51 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04JHuj47126716;
        Tue, 19 May 2020 12:56:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589911005;
        bh=mZncJCwJdkNq+GLu4yjejDCJIhmYL6I8ymoASj1tNtM=;
        h=Subject:From:To:CC:References:Date:In-Reply-To;
        b=ZIhbg0EdUOYCvXcHuoJFXS8/tTki84yCTmmFgfpWz3UPijQ/PfbufhFTcicDCwyy5
         YWUQILT9xlmHVs0gcvbVuqGrjCd+G4YRuKHfnWAKyU+UYRaTwt+sZapp/l3kw3YfXv
         RgXz5ARUiCHqNHRdlJtwW/Y8b/6xmez0GLzX5T0I=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JHujYd072096;
        Tue, 19 May 2020 12:56:45 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 19
 May 2020 12:56:45 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 19 May 2020 12:56:45 -0500
Received: from [10.250.52.63] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04JHuj3m119856;
        Tue, 19 May 2020 12:56:45 -0500
Subject: Re: [PATCH net-next 2/4] net: phy: dp83869: Set opmode from straps
From:   Dan Murphy <dmurphy@ti.com>
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200519141813.28167-1-dmurphy@ti.com>
 <20200519141813.28167-3-dmurphy@ti.com>
 <20200519095818.425d227b@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <65e1b5ca-680e-f82d-cde4-3d5a3eb40884@ti.com>
Message-ID: <459afc6f-a519-43f5-aeb2-e28c362237b3@ti.com>
Date:   Tue, 19 May 2020 12:56:40 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <65e1b5ca-680e-f82d-cde4-3d5a3eb40884@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakub

On 5/19/20 12:40 PM, Dan Murphy wrote:
> Jakub
>
> On 5/19/20 11:58 AM, Jakub Kicinski wrote:
>> On Tue, 19 May 2020 09:18:11 -0500 Dan Murphy wrote:
>>> If the op-mode for the device is not set in the device tree then set
>>> the strapped op-mode and store it for later configuration.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>> ../drivers/net/phy/dp83869.c: In function0 dp83869_set_strapped_mode:
>> ../drivers/net/phy/dp83869.c:171:10: warning: comparison is always 
>> false due to limited range of data type [-Wtype-limits]
>>    171 |  if (val < 0)
>>        |          ^
>
> This looks to be a false positive.
>
> phy_read_mmd will return an errno or a value from 0->15
>
> So if errno is returned then this will be true.
>
> Unless I have to do IS_ERR.
>
> I did not get that warning.  But I am using 9.2-gcc.
>
> What compiler are you using?
>
I see what the issue is val needs to be an int not a u16

I will fix it

Dan


> Dan
>
