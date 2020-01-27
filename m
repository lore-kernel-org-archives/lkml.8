Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31707C32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F39CA208CD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 10:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="bxObGFiN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729810AbgA0Kbq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 05:31:46 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:50868 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727985AbgA0Kbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 05:31:45 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 00RAVSlH043859;
        Mon, 27 Jan 2020 04:31:28 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1580121088;
        bh=3h8f4XbI491JsEjdTtwjglxtDcunKaSoHjicJCKo/ZU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=bxObGFiN/208eM+ZN8Zk7SjwcV122LbY+xkUxj+XFtdvp3cJjmWG3w6uluPp5PV7r
         9BHr1Yd9byuu/qgSnfypN7VwX7UaM6th4kemgebDBhkeF2imXuABaJ78DaUv9YmxQn
         aXzDDdi+rsYNOKnG8Zd38RIjcS1rY1E2D/ZXCa0w=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RAVSDY015973;
        Mon, 27 Jan 2020 04:31:28 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 27
 Jan 2020 04:31:27 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 27 Jan 2020 04:31:27 -0600
Received: from [192.168.2.6] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 00RAVOSB111634;
        Mon, 27 Jan 2020 04:31:25 -0600
Subject: Re: [PATCH] arm64: defconfig: Enable Texas Instruments UDMA driver
To:     Olof Johansson <olof@lixom.net>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <t-kristo@ti.com>,
        <vkoul@kernel.org>, <alexandre.belloni@bootlin.com>,
        <arnd@arndb.de>, <soc@kernel.org>
References: <20200124092359.12429-1-peter.ujfalusi@ti.com>
 <20200124200811.ytgs66cg5qpugi5c@localhost>
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <12f40648-fec6-9179-1f62-0a648996ed20@ti.com>
Date:   Mon, 27 Jan 2020 12:32:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200124200811.ytgs66cg5qpugi5c@localhost>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olof,

On 24/01/2020 22.08, Olof Johansson wrote:
> On Fri, Jan 24, 2020 at 11:23:59AM +0200, Peter Ujfalusi wrote:
>> The UDMA driver is used on K3 platforms (am654 and j721e).
>>
>> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
>> ---
>> Hi,
>>
>> The drivers for UDMA are already in linu-next and the DT patches are going to be
>> also heading for 5.6.
>> The only missing piece is to enable the drivers in defconfig so clients can use
>> the DMA.
> 
> Hi Peter,
> 
> We normally like to see new options turned on after the driver/option has been
> merged, so send this during or right after the merge window when that happens,
> please.

Sure, I'll post it later.

> I also see that this is statically enabling this driver -- we try to keep as
> many drivers as possible as modules to avoid the static kernel from growing too
> large. Would that be a suitable approach here, or is the driver needed to reach
> rootfs for further module loading?

We would need built in DMA for nfs rootfs, SD/MMC has it's own buit-in
ADMA. We do not have network drivers upstream as they depend on the DMA.

Imho module would be fine for the DMA stack, but neither ringacc or the
UDMA driver can be built as module atm until the following patches got
merged:
https://lore.kernel.org/lkml/20200122104723.16955-1-peter.ujfalusi@ti.com/
https://lore.kernel.org/lkml/20200122104031.15733-1-peter.ujfalusi@ti.com/

I have the patches to add back module support, but waiting on these
currently.

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
