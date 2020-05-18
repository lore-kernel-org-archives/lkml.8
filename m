Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5233CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:33:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D16E20787
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 12:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wksZWPQz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgERMdZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 08:33:25 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57598 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgERMdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 08:33:25 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04ICXNGI126863;
        Mon, 18 May 2020 07:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1589805203;
        bh=Uj0iQWKwrGFqJF+im6DxPdmW4Sz4gCpfpR62iAKn/bU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=wksZWPQz4vQfucESuu27ANcF3B6XPXLPFvtYTJUD0yGOURf9ZAR74d3U+EIHtmO2E
         dmNPWG0ek99bv2lHsr+YmaF6BccleJYQyPWFPI6+AZFwVE0tz9WMA0GCESWI0YYVrM
         0hHh317OpGcRqGQH67x9zPzxAyfAQamQs3/yO900=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 04ICXNBj096464
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 May 2020 07:33:23 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 18
 May 2020 07:33:22 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 18 May 2020 07:33:23 -0500
Received: from [10.250.233.85] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04ICXKZA033369;
        Mon, 18 May 2020 07:33:21 -0500
Subject: Re: [PATCH 0/2] phy: ti: am654: Add USB super-speed support
To:     Roger Quadros <rogerq@ti.com>
CC:     <vigneshr@ti.com>, <nsekhar@ti.com>,
        <linux-kernel@vger.kernel.org>, Vinod Koul <vkoul@kernel.org>
References: <20200513131254.10497-1-rogerq@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <63756378-164c-930a-5bda-91ab2a80649e@ti.com>
Date:   Mon, 18 May 2020 18:03:20 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200513131254.10497-1-rogerq@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/13/2020 6:42 PM, Roger Quadros wrote:
> Hi Kishon,
> 
> This series adds USB3.0 support to am654-serdes PHY driver.

merged, thanks!

-Kishon
> 
> cheers,
> -roger
> 
> Roger Quadros (2):
>   phy: ti: am654: show up in regmap debugfs
>   phy: ti: am654: add support for USB super-speed
> 
>  drivers/phy/ti/phy-am654-serdes.c | 104 +++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 2 deletions(-)
> 
