Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB04C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:57:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C17092073E
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 12:57:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="c3WxFLMq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbgCMM5U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 08:57:20 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:61986 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726216AbgCMM5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 08:57:20 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02DClKnA009589;
        Fri, 13 Mar 2020 13:56:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=dFQRbdwT/7f+gBH9+dyOD4FlWJJaQW4FMkJJu11OLHg=;
 b=c3WxFLMqs7WJqsERfVZuitaYbW6YG/rz6Wlt6hpiSsZZnlLZ+JgifiCNHbIprQhserIm
 tP/m9ZjN3RePvwqo8ERFVvpEUpoiHjMIWJOH4pYrCFvpZ2uNclrBkP+UWDbhZrsWgXE5
 eoxjwWwHOoUHpSa/IYt1IKBIeuMQE2Ci/Fklv6OVLafQ3ve1xCOhWyAskkde/1VEVF0a
 759VvPXETdaRqRwBwyNQsCnekzG690v6a5f9IuLc/fkeWKXpvrz2KA0YAGliAj0bEJDp
 kCxTGjTNP4h5JM84p3AqCBHRd7TYQBK3btDtIoI1plr9zojuJqRhqMYOSmrvywUmqZvY 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2yqt838py1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 13:56:56 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8696910003D;
        Fri, 13 Mar 2020 13:56:53 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 58CE72A88E3;
        Fri, 13 Mar 2020 13:56:53 +0100 (CET)
Received: from lmecxl0912.lme.st.com (10.75.127.48) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Fri, 13 Mar
 2020 13:56:52 +0100
Subject: Re: [PATCH v3 0/4] STM32 early console
To:     Erwan Le Ray <erwan.leray@st.com>,
        Russell King <linux@armlinux.org.uk>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Olof Johansson <olof@lixom.net>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Nathan Huckleberry <nhuck15@gmail.com>,
        Gerald Baeza <gerald.baeza@st.com>,
        Clement Peron <peron.clem@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20200203140425.26579-1-erwan.leray@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <a8776663-3951-c06a-8e22-66451c886818@st.com>
Date:   Fri, 13 Mar 2020 13:56:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203140425.26579-1-erwan.leray@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG1NODE2.st.com (10.75.127.2) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-13_04:2020-03-12,2020-03-13 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan

On 2/3/20 3:04 PM, Erwan Le Ray wrote:
> Add UART instance configuration to STM32 F4 and F7 early console.
> Add STM32 H7 and MP1 early console support.
> 
> Changes in v3:
> - fix a missing condition for STM32MP1
>    
> Changes in v2:
> - split "[PATCH] ARM: debug: stm32: add UART early console configuration"
>    into separate patches as suggested by Clement into [1]
> 
> [1] https://lkml.org/lkml/2019/4/10/199
> 
> Erwan Le Ray (4):
>    ARM: debug: stm32: add UART early console configuration for STM32F4
>    ARM: debug: stm32: add UART early console configuration for STM32F7
>    ARM: debug: stm32: add UART early console support for STM32H7
>    ARM: debug: stm32: add UART early console support for STM32MP1
> 
>   arch/arm/Kconfig.debug         | 42 +++++++++++++++++++++++++++++-----
>   arch/arm/include/debug/stm32.S |  9 ++++----
>   2 files changed, 40 insertions(+), 11 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
