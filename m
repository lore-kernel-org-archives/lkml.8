Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE98EC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2A5220663
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 15:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZVoh3ZgO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgGMPvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 11:51:37 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:56062 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730084AbgGMPvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 11:51:37 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06DFpTBG020144;
        Mon, 13 Jul 2020 10:51:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594655489;
        bh=Xv2IWcO5scWdcCHAvwCpGK5Ld4tkWYL+Z6X6Ww0o69E=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZVoh3ZgOvq+L0BrFD11SXvDqbxz5oV3WjQ1hkZJILG9Qy0wAV3cy3cftj5xkgoYT7
         kDzwX/gceF95RFM/kXNqvq4nhDrFCu06ZOrrdQr9MMjCZpBhFuyFzVzUCdpy4aJqCY
         mg3zphgQTY6erV5NYHQIYFa9DcU6/RmbD173Z5S4=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 06DFpTVl007979
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 13 Jul 2020 10:51:29 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 13
 Jul 2020 10:51:29 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 13 Jul 2020 10:51:29 -0500
Received: from [10.250.32.229] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06DFpSmf112299;
        Mon, 13 Jul 2020 10:51:28 -0500
Subject: Re: [PATCH net-next v2 2/2] net: phy: DP83822: Add ability to
 advertise Fiber connection
To:     Andrew Lunn <andrew@lunn.ch>
CC:     <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <davem@davemloft.net>, <robh@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
References: <20200710143733.30751-1-dmurphy@ti.com>
 <20200710143733.30751-3-dmurphy@ti.com> <20200711184512.GR1014141@lunn.ch>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <bd3580a2-a603-7d17-692c-2cb353ded865@ti.com>
Date:   Mon, 13 Jul 2020 10:51:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200711184512.GR1014141@lunn.ch>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

On 7/11/20 1:45 PM, Andrew Lunn wrote:
>> +#define MII_DP83822_FIBER_ADVERTISE	(SUPPORTED_AUI | SUPPORTED_FIBRE | \
>> +					 SUPPORTED_BNC | SUPPORTED_Pause | \
>> +					 SUPPORTED_Asym_Pause | \
>> +					 SUPPORTED_100baseT_Full)
>> +
>> +		/* Setup fiber advertisement */
>> +		err = phy_modify_changed(phydev, MII_ADVERTISE,
>> +					 ADVERTISE_1000XFULL |
>> +					 ADVERTISE_1000XPAUSE |
>> +					 ADVERTISE_1000XPSE_ASYM,
>> +					 MII_DP83822_FIBER_ADVERTISE);
> That looks very odd. SUPPORTED_AUI #define has nothing to do with
> MII_ADVERTISE register. It is not a bit you can read/write in that
> register.

ACK removed the SUPPORTED_AUI.

I also going to update the MII_DP83822_FIBER_ADVERTISE defines from 
SUPPORTED_* to ADVERTISED_*

Dan


> 	Andrew
