Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD74BC33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA52721734
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 07:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QYfqIJHL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgAUHcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 02:32:33 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43984 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgAUHcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 02:32:32 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00L7WSDP052734;
        Tue, 21 Jan 2020 01:32:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1579591948;
        bh=zyYz9WtYHcpixb588DFaQSsXroYHYr6CD4WeLA1r+Jw=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QYfqIJHL1WcBU9sSCHw1JOpblG2sYCKwQBk9ljdB9EBJMuqytjDRTgdChowPuGior
         W7FvtgFDOGsCfIP0iPRcDgpY+DQVBVqwort8aS7irCUUVfomBxD1hhBx74dEY5LgkY
         EssnJxXWDDW/s7lv5LSL6CmqV/g1G4oAIIoEDZ8E=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 00L7WSHm098956
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Jan 2020 01:32:28 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 21
 Jan 2020 01:32:28 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 21 Jan 2020 01:32:28 -0600
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00L7WPH0054877;
        Tue, 21 Jan 2020 01:32:26 -0600
Subject: Re: [Patch v5 1/3] clk: ti: dra7: add vpe clkctrl data
To:     Stephen Boyd <sboyd@kernel.org>, Benoit Parrot <bparrot@ti.com>,
        Tony Lindgren <tony@atomide.com>, <linux-clk@vger.kernel.org>,
        <linux-omap@vger.kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20191211140810.10657-1-bparrot@ti.com>
 <20191211140810.10657-2-bparrot@ti.com>
 <20191230195812.0356A206CB@mail.kernel.org>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <33a9848a-04c4-6545-f477-d6510faceb51@ti.com>
Date:   Tue, 21 Jan 2020 09:32:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191230195812.0356A206CB@mail.kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/12/2019 21:58, Stephen Boyd wrote:
> Quoting Benoit Parrot (2019-12-11 06:08:08)
>> Add clkctrl data for VPE.
>>
>> Signed-off-by: Benoit Parrot <bparrot@ti.com>
>> Acked-by: Tony Lindgren <tony@atomide.com>
>> Acked-by: Rob Herring <robh@kernel.org>
>> ---
> 
> Acked-by: Stephen Boyd <sboyd@kernel.org>
> 

Queued this patch towards 5.6, thanks.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
