Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23036C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA25320704
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 07:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ZeCnUn20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbgGQHTN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 03:19:13 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40902 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgGQHTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 03:19:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 06H7J8eZ013216;
        Fri, 17 Jul 2020 02:19:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1594970348;
        bh=cG1RaHNH6FaDqi7bHr3eyQGPbFid++mTRFNpK9tuZgY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZeCnUn20r2r/aTe++/lGe5HUqu4uFwgszZCRdX/+yvF5u9kDk/1+vtsEIT6kTAhMx
         ddPviIPIx90rRqiFWlysyO/EuIdaU4NBAnREmW4LK1Y48LqUbqrNRjbpl0kBfePA9I
         /im2XqOeCOcejZn3WwaOLP7AbXlvpNMea5N/Ic8o=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7J8cA038979;
        Fri, 17 Jul 2020 02:19:08 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 17
 Jul 2020 02:19:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 17 Jul 2020 02:19:08 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 06H7J57R119593;
        Fri, 17 Jul 2020 02:19:06 -0500
Subject: Re: [PATCH v2 0/2] arm64: dts: ti: k3-j721e-common-proc-board: Enable
 audio support
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>, <nm@ti.com>
CC:     <devicetree@vger.kernel.org>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <vigneshr@ti.com>
References: <20200703074443.27142-1-peter.ujfalusi@ti.com>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <da690771-ce68-0de8-8729-64b5e33ab67f@ti.com>
Date:   Fri, 17 Jul 2020 10:19:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200703074443.27142-1-peter.ujfalusi@ti.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2020 10:44, Peter Ujfalusi wrote:
> Hi,
> 
> Change since v1:
> - not including dt-bindings/sound/ti-mcasp.h as it is not needed
> 
> the DT binding document and the driver is now in linux-next:
> https://lore.kernel.org/lkml/159364215574.10630.2058528286314798186.b4-ty@kernel.org/
> 
> Before adding the audio support, first fix up the DTS file by removing the
> duplicated main_i2c1_exp4_pins_default.
> 
> Regards,
> Peter

Queued up for 5.9, thanks.

-Tero

> ---
> Peter Ujfalusi (2):
>    arm64: dts: ti: k3-j721e-common-proc-board: Remove duplicated
>      main_i2c1_exp4_pins_default
>    arm64: dts: ti: j721e-common-proc-board: Analog audio support
> 
>   .../dts/ti/k3-j721e-common-proc-board.dts     | 136 +++++++++++++++++-
>   1 file changed, 133 insertions(+), 3 deletions(-)
> 

--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
