Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1157AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:12:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A13206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 10:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Qh4w60AD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729034AbgFOKMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 06:12:14 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:22460 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728368AbgFOKMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 06:12:14 -0400
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FA9nop017544;
        Mon, 15 Jun 2020 12:12:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=d3GjQF0BzX+PN+NqBFNl58BCi48VHp5WyEJcoWpGzZE=;
 b=Qh4w60ADIEMTpDsoxohyQ9Ih50clXyZZs9u/+lc0WnUycb7Ig8HgvcIuavp2QzBzto9s
 pmW6O42deSa+OyUIEJwKxCQAROZ0VGg+0just0JmbVu/62FSwt4Q0tIpX7FtW45WENV8
 NlQRnYxPP9yo6PgAxoZUxtKZALY1kNaZVreGndLuxbjFprxzTKbgn2OKSGKrNGuuI7PP
 195FLNG567s+Alro3Cc6ZWB2C185rEBbI8vGh1I0BmBtCGpNrtO6S+DIiauFDVV+dJqT
 Zy/d4GlEPlf4aJ5u/jFASaKo5pIy4za3/CvRlZNzepua/Ziop0gM9nyscvOEZh4u4Pi9 nQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 31mkx915uv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 12:12:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 9D9D5100042;
        Mon, 15 Jun 2020 12:12:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 8845720E2C3;
        Mon, 15 Jun 2020 12:12:01 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.49) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 15 Jun
 2020 12:12:00 +0200
Subject: Re: [PATCH 0/3] STM32 update uart4 pin configuration for low power
To:     Erwan Le Ray <erwan.leray@st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Fabrice Gasnier <fabrice.gasnier@st.com>
References: <20200528073853.24759-1-erwan.leray@st.com>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <751071df-6879-da91-3519-38770971c43f@st.com>
Date:   Mon, 15 Jun 2020 12:12:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200528073853.24759-1-erwan.leray@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_02:2020-06-15,2020-06-15 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Erwan

On 5/28/20 9:38 AM, Erwan Le Ray wrote:
> Update uart4 pin configuration for low power in pinctrl, and for ed/ev
> and dkx boards.
> 
> Erwan Le Ray (3):
>    ARM: dts: stm32: update uart4 pin configuration for low power on
>      stm32mp157
>    ARM: dts: stm32: Update pin states for uart4 on stm32mp157c-ed1
>    ARM: dts: stm32: Update UART4 pin states on stm32mp15xx-dkx
> 
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi | 17 +++++++++++++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts    |  4 +++-
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   |  4 +++-
>   3 files changed, 23 insertions(+), 2 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
