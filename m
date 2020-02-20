Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5022C11D04
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70E2924670
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 12:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="CcFuu6Sz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgBTMdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 07:33:19 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60214 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727705AbgBTMdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 07:33:19 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01KCXIfl021187
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:33:18 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582201998;
        bh=3QjZhVJXywmkkIz5VsnKq4ynXsbpPSzj49Z9+IjI8AM=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=CcFuu6SzQH1BGGTykgNU1O/8jFJlltzyAPxPUF5CYixVW9EY5msArPbCicppStdxJ
         KPiyQz61OnZyl3kW+VRT1D7C4ZuRfw2pEwj/b75d97ZbNLboV5Wkqxtp9a+i8988B3
         fsB9sx1HKlial0K5hfOJLtFJ5eVmSs1Gt1MbqMuw=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01KCXIFE113446
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL)
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:33:18 -0600
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Thu, 20
 Feb 2020 06:33:18 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Thu, 20 Feb 2020 06:33:18 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01KCX14x115841;
        Thu, 20 Feb 2020 06:33:02 -0600
Subject: Re: [PATCH 0/2] phy: ti: gmii-sel: two fixes
To:     Grygorii Strashko <grygorii.strashko@ti.com>,
        <linux-kernel@vger.kernel.org>
CC:     Sekhar Nori <nsekhar@ti.com>
References: <20200214190801.3030-1-grygorii.strashko@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <150d63c7-19d8-6172-89df-e2ebdc1b9d2c@ti.com>
Date:   Thu, 20 Feb 2020 18:06:42 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <20200214190801.3030-1-grygorii.strashko@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 15/02/20 12:37 am, Grygorii Strashko wrote:
> Hi Kishon,
> 
> Here the two minor fixes for TI phy-gmii-sel PHY.
>  - Patch 1: few minor copy-paste errors.
>  - Patch 2: enables back gmii mode (not used now, so no issues reported til now)
> 
> Grygorii Strashko (2):
>   phy: ti: gmii-sel: fix set of copy-paste errors
>   phy: ti: gmii-sel: do not fail in case of gmii

merged, thanks!

-Kishon
> 
>  drivers/phy/ti/phy-gmii-sel.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
