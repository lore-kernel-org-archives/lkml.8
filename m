Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D0FC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C4AC2075B
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="iUJdiq08"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgH1Jbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:31:40 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:57644 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbgH1JbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:31:22 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07S9RKLH005422;
        Fri, 28 Aug 2020 11:30:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=GZcXYK4IQ/ttyWbgQ2w+8/AUl4mLyk/JntubDt8xpu4=;
 b=iUJdiq08j1aAdX0H//CuLIvKCyuHq+0qo06HR0veCNKqtfts+9GPogoz7knCy4K6H2Tn
 rII6qYVUpDXcqmuN2R0T010lAr8/3hIeUNaCs48mgCAMxjSkLcbuhj168DSlabMBrPB8
 UbzyAqIycsEyWw0NfqB9/v/EohNmJRNe8FH5aK9W+ZOqXrDx0eVzEEcGSxIAiWsM3sB5
 qtjPsBRjuo2xWipwyiMeUAbrQCZF+usgqdzZFm125aVg5bTXq9sbdTojV/8HiF6vfaDn
 HNQgrnRPXS4jTFLUciLAAyKgaiHN3j4tm6bvLLXALI28xEY5BaKPfDGmxatcXU+ux7Bz NQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 332t8g5mm2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Aug 2020 11:30:46 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 753D510002A;
        Fri, 28 Aug 2020 11:30:38 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 547472AD2DE;
        Fri, 28 Aug 2020 11:30:38 +0200 (CEST)
Received: from lmecxl0912.lme.st.com (10.75.127.44) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 28 Aug
 2020 11:30:37 +0200
Subject: Re: [PATCH v7 3/3] ARM: dts: stm32: add initial support for
 stm32mp157-odyssey board
To:     Marcin Sloniewski <marcin.sloniewski@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <robh+dt@kernel.org>, <mcoquelin.stm32@gmail.com>,
        <mani@kernel.org>, <a.fatoum@pengutronix.de>, <sam@ravnborg.org>,
        <linus.walleij@linaro.org>, <arnd@arndb.de>, <broonie@kernel.org>,
        <lkundrak@v3.sk>, <daniel@0x0f.com>,
        <kuninori.morimoto.gx@renesas.com>, <allen.chen@ite.com.tw>,
        <robh@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-kernel@vger.kernel.org>
References: <20200809164450.289731-1-marcin.sloniewski@gmail.com>
 <20200809164450.289731-3-marcin.sloniewski@gmail.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <8a95db7e-865a-db34-ae8a-b2fe3533ab8d@st.com>
Date:   Fri, 28 Aug 2020 11:30:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200809164450.289731-3-marcin.sloniewski@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG8NODE2.st.com (10.75.127.23) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-28_05:2020-08-28,2020-08-28 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcin,

On 8/9/20 6:44 PM, Marcin Sloniewski wrote:
> Add support for Seeed Studio's stm32mp157c odyssey board.
> Board consists of SoM with stm32mp157c with 4GB eMMC and 512 MB DDR3 RAM
> and carrier board with USB and ETH interfaces, SD card connector,
> wifi and BT chip AP6236.
> 
> In this patch only basic kernel boot is supported and interfacing
> SD card and on-board eMMC.
> 
> Signed-off-by: Marcin Sloniewski <marcin.sloniewski@gmail.com>
> ---

Series applied on stm32-next.

Regards
Alex

