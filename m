Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F23BEC35240
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55842082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QNT9rjeI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgAaSjc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:39:32 -0500
Received: from lelv0142.ext.ti.com ([198.47.23.249]:34396 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaSjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:39:32 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00VIdRs5103479;
        Fri, 31 Jan 2020 12:39:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580495967;
        bh=C2OoElTb/xW5zZLPQjBxo7wY426iSsHo1LeUV6VejFE=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QNT9rjeIO//1kMCfVIaZE0is8gn/smizq4jY0KflSLx9isqwzKZMCwOcpNQ20aIDq
         l/5Lq9eUW/rAWfpAB5pPb682ov3Rj9qhx2vahzPUPXpGgMcDe3eSdFWRCcsX9geFB6
         kHPlaX3Z6j3TmaKvX+1OAu0DWmC8/oQtwNmnRdlA=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00VIdRPf104721
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 31 Jan 2020 12:39:27 -0600
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 31
 Jan 2020 12:39:27 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 31 Jan 2020 12:39:27 -0600
Received: from [10.250.65.13] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00VIdR2P059261;
        Fri, 31 Jan 2020 12:39:27 -0600
Subject: Re: [PATCH net-master 1/1] net: phy: dp83867: Add speed optimization
 feature
To:     Jakub Kicinski <kuba@kernel.org>
CC:     <andrew@lunn.ch>, <f.fainelli@gmail.com>, <hkallweit1@gmail.com>,
        <bunk@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <grygorii.strashko@ti.com>
References: <20200131151110.31642-1-dmurphy@ti.com>
 <20200131151110.31642-2-dmurphy@ti.com>
 <20200131091004.18d54183@cakuba.hsd1.ca.comcast.net>
 <6b4bb017-de97-0688-47c5-723ec4c3a339@ti.com>
 <20200131101130.1b265526@cakuba.hsd1.ca.comcast.net>
From:   Dan Murphy <dmurphy@ti.com>
Message-ID: <90266d62-11bf-ca61-179e-ac38e41e3bb2@ti.com>
Date:   Fri, 31 Jan 2020 12:36:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200131101130.1b265526@cakuba.hsd1.ca.comcast.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jakob

On 1/31/20 12:11 PM, Jakub Kicinski wrote:
> On Fri, 31 Jan 2020 11:14:05 -0600, Dan Murphy wrote:
>> On 1/31/20 11:10 AM, Jakub Kicinski wrote:
>>> While we wait for the PHY folk to take a look, could you please
>>> provide a Fixes tag?
>> Hmm. This is not a bug fix though this is a new feature being added.
>>
>> Not sure what it would be fixing.
> I see, you target the patch at net which is for fixes, so I
> misinterpreted this:

My fault I will have a v2 so I will rebase on top of net-next.

>> This feature can also be strapped on the 64 pin PHY devices
>> but the 48 pin devices do not have the strap pin available to enable
>> this feature in the hardware.
> as you fixing 48 devices or such.


Not really fixing them just enabling them to use this feature.

Dan

