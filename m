Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C2AC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:12:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E342C208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 05:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Sn134irH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbgCEFMr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 00:12:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:58452 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgCEFMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 00:12:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0255Chf1128361;
        Wed, 4 Mar 2020 23:12:43 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1583385163;
        bh=2wLXvsqxTDgfkA3zw0daMAZF2o7HoT+D11pKqsJa+YA=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Sn134irHiE3HqcRItkf7IM1qrb2x8IHjj2Hh+/lUqIWD/xOzaWacWkwux11MmCZ8c
         SbLZSzGFGM7hz8QRT2r/i2JBYMULtksHg6XprKgzEvCdk+ebU1JsYq925sOb3KIxvO
         iwoTRfPqlW5JKZGWZx9EI0rdaaO7rfqk/rXXwPU4=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0255Chsn082261;
        Wed, 4 Mar 2020 23:12:43 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 4 Mar
 2020 23:12:43 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 4 Mar 2020 23:12:42 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0255Cd7x124563;
        Wed, 4 Mar 2020 23:12:40 -0600
Subject: Re: [for-next PATCH v2 0/5] phy: ti: gmii-sel: add support for
 am654x/j721e soc
To:     David Miller <davem@davemloft.net>, <grygorii.strashko@ti.com>
CC:     <m-karicheri2@ti.com>, <t-kristo@ti.com>, <nsekhar@ti.com>,
        <robh+dt@kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200303160029.345-1-grygorii.strashko@ti.com>
 <20200304.143951.1102411401290807167.davem@davemloft.net>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <71a6fea9-65c1-3a3c-a35b-9432208b3ee5@ti.com>
Date:   Thu, 5 Mar 2020 10:47:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200304.143951.1102411401290807167.davem@davemloft.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 05/03/20 4:09 am, David Miller wrote:
> From: Grygorii Strashko <grygorii.strashko@ti.com>
> Date: Tue, 3 Mar 2020 18:00:24 +0200
> 
>> Hi Kishon,
>>
>> This series adds support for TI K3 AM654x/J721E SoCs in TI phy-gmii-sel PHY
>> driver, which is required for future adding networking support.
>>
>> depends on:
>>  [PATCH 0/2] phy: ti: gmii-sel: two fixes
>>  https://lkml.org/lkml/2020/2/14/2510
>>
>> Changes in v2:
>>  - fixed comments
>>
>> v1: https://lkml.org/lkml/2020/2/22/100
> 
> This is mostly DT updates and not much networking code changes, will some other
> tree take this?

I can take the phy related changes. Grygorii, can you split the dt
patches into a separate series?

Thanks
Kishon
