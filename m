Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8769FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EDD20722
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 12:39:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="qPxbDB2j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgENMjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 08:39:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:30316 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726232AbgENMjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 08:39:06 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04ECWRpb031347;
        Thu, 14 May 2020 14:38:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=gK4gRac8zCJ49BVWhgCYszm1HwapCUJoPR2k/1pndPk=;
 b=qPxbDB2jBqpiVaEwpezjOHZi/uxRnvCZ6Exwe+7WK52uI0EdKnWpTbUqyUuiZPXCnxJ4
 Do6vdK1vZ0BxbplxQakO7YP4qQZWe06PIx/FpH1gIMcKGPzyorjE+R6N4d64sBoQYGFp
 6XO7K2XAzNc3Z7GAh/KLe7Mvzt1CrlA+Sfk7Nw+jVvL318TTMhJ4u+i4zo6wiH69qmza
 OKPCF+Htv29t+IyHli1feCCpVLZJGh0yYtHEWLOOzm08UKgOsA2t3tMOXT/ZnjgJDPpd
 UNX2aYKc3WJbUEPgHfToOJA+AmAwRIjoU0NPtm6/GAGnGRvPxTKb/D3g7lAKGvY+CXG8 Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3100vqk4kq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 14:38:55 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8996610002A;
        Thu, 14 May 2020 14:38:55 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node2.st.com [10.75.127.8])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 786702B8A1F;
        Thu, 14 May 2020 14:38:55 +0200 (CEST)
Received: from lmecxl0912.tpe.st.com (10.75.127.46) by SFHDAG3NODE2.st.com
 (10.75.127.8) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Thu, 14 May
 2020 14:38:51 +0200
Subject: Re: [PATCH v2 0/6] Add Stinger96 and IoT Box board support
To:     <mani@kernel.org>, <robh+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20200503154215.23654-1-mani@kernel.org>
From:   Alexandre Torgue <alexandre.torgue@st.com>
Message-ID: <abbd6fd1-ec74-3ae5-b041-d31dfc5ded82@st.com>
Date:   Thu, 14 May 2020 14:38:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503154215.23654-1-mani@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG3NODE2.st.com
 (10.75.127.8)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-14_03:2020-05-14,2020-05-14 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani

On 5/3/20 5:42 PM, mani@kernel.org wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> Hello,
> 
> This series adds Stinger96 and IoT Box board support. These boards are
> based on STM32MP157A SoC, designed and manufactured by Shiratech solutions.
> 
> The Stinger96 is a base board (96Boards IoT Extended edition) while IoT Box
> adds one mezzanine on top of it and sold as a gateway device.
> 
> This series depends on below patchsets already submitted and gone through
> reviews:
> 
> [PATCH v3 0/3] Add Reset and Wakeup support for CCS811
> [PATCH v3 0/2] Add CTS/RTS gpio support to STM32 UART
> 
> More information about these boards can be found in below links:
> 
> https://www.shiratech-solutions.com/products/stinger96/
> https://www.shiratech-solutions.com/products/iot-box/
> 
> Thanks,
> Mani
> 

Series applied on stm32-next.

Regards
Alex

> Changes in v2:
> 
> * Used "stm32" prefix for all DT commits
> * Dropped custom sdmmc2 pinctrl node since existing node itself has pullup
>    enabled and works fine.
> 
> Manivannan Sadhasivam (6):
>    dt-bindings: Add vendor prefix for Shiratech Solutions
>    ARM: dts: stm32: Add missing pinctrl entries for STM32MP15
>    dt-bindings: arm: stm32: Document Stinger96 compatible
>    ARM: dts: stm32: Add Stinger96 board support
>    dt-bindings: arm: stm32: Document IoT Box compatible
>    ARM: dts: stm32: Add IoT Box board support
> 
>   .../devicetree/bindings/arm/stm32/stm32.yaml  |   2 +
>   .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
>   arch/arm/boot/dts/Makefile                    |   2 +
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi      |  64 ++++
>   arch/arm/boot/dts/stm32mp157a-iot-box.dts     |  68 ++++
>   arch/arm/boot/dts/stm32mp157a-stinger96.dts   |  12 +
>   arch/arm/boot/dts/stm32mp157a-stinger96.dtsi  | 342 ++++++++++++++++++
>   7 files changed, 492 insertions(+)
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-iot-box.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dts
>   create mode 100644 arch/arm/boot/dts/stm32mp157a-stinger96.dtsi
> 
