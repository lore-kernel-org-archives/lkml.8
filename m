Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 421FDC47258
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2308120714
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="dDaNLch6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbgEFJRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:17:15 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4952 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728385AbgEFJRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:17:14 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04697PPv015737;
        Wed, 6 May 2020 11:17:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=VqFBe3qF20cGOA89aBohpMcGBG6ZZWxJV16qNY9PmWo=;
 b=dDaNLch6Ij6B7YztMRN7x8yS+n+gqvuruXugu/ZEwu3IFMX0KXLTyoIxK9sTCUSxM5cS
 vdWZdsVrlDYFpgkn3uDbh6byBdO8nhSyeHaAlEm7i4YUoOrGxmpn7OjmFWggLX76/tfC
 8pTFBysQpGf+PQZB9nS1HONCBE1kxYEfHaEM15qI2DIxFjuCM6YkVqigngdoFndGDHEP
 G6JgunUGZv5zfF9NdqLhj8tvFFNCMxfLhIB7GZpWFUsIfl12ltMRfb7jmaPVWoLwz4+B
 YG6Jo+hlb2tYCLXdLITJ+tiIKjPMjQpsvRfmEkG8v5HZTXYSW81t5UEjxqpaoKjp3yaF MA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxmvn3gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 11:17:02 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B75BA100034;
        Wed,  6 May 2020 11:17:01 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 957AE2AB47F;
        Wed,  6 May 2020 11:17:01 +0200 (CEST)
Received: from [10.211.5.75] (10.75.127.49) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 May
 2020 11:17:00 +0200
Subject: Re: [PATCH v3 00/10] add STM32 FMC2 EBI controller driver
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <gregkh@linuxfoundation.org>, <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1588698668-25288-1-git-send-email-christophe.kerello@st.com>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <dd56b6cb-3e99-0365-b1e6-211549e0ef21@st.com>
Date:   Wed, 6 May 2020 11:16:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1588698668-25288-1-git-send-email-christophe.kerello@st.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.49]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_03:2020-05-04,2020-05-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Please do not spend time to review v3.
V4 has been pushed to fix an issue in YAML bindings.

Regards,
Christophe Kerello.

On 5/5/20 7:10 PM, Christophe Kerello wrote:
> The FMC2 functional block makes the interface with: synchronous and
> asynchronous static devices (such as PSNOR, PSRAM or other memory-mapped
> peripherals) and NAND flash memories.
> Its main purposes are:
>    - to translate AXI transactions into the appropriate external device
>      protocol
>    - to meet the access time requirements of the external devices
> All external devices share the addresses, data and control signals with the
> controller. Each external device is accessed by means of a unique Chip
> Select. The FMC2 performs only one access at a time to an external device.
> 
> Changes in v3:
>   - NAND:
>     - rename labels used on errors
>     - add in the commit log the reason to increase FMC2_TIMEOUT_MS (patch 3)
>     - add Miquel reviewed-by tag (patches 2/4/5/9)
>   - EBI:
>     - move in memory folder
>     - merge MFD and BUS drivers to avoid a MFD driver
>   - bindings:
>     - pattern name has been modified
>     - vendor properties have been modified
>       - s/_/-/
>       - add unit suffix (-ns) on timing properties
> 
> Christophe Kerello (10):
>    mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
>    mtd: rawnand: stm32_fmc2: remove useless inline comments
>    mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
>    mtd: rawnand: stm32_fmc2: cleanup
>    mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros
>    dt-bindings: mtd: update STM32 FMC2 NAND controller documentation
>    dt-bindings: memory-controller: add STM32 FMC2 EBI controller
>      documentation
>    memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
>    mtd: rawnand: stm32_fmc2: use regmap APIs
>    mtd: rawnand: stm32_fmc2: get resources from parent node
> 
>   .../memory-controllers/st,stm32-fmc2-ebi.yaml      |  261 +++++
>   .../bindings/mtd/st,stm32-fmc2-nand.yaml           |   19 +-
>   drivers/memory/Kconfig                             |   10 +
>   drivers/memory/Makefile                            |    1 +
>   drivers/memory/stm32-fmc2-ebi.c                    | 1206 ++++++++++++++++++++
>   drivers/mtd/nand/raw/Kconfig                       |    1 +
>   drivers/mtd/nand/raw/stm32_fmc2_nand.c             | 1176 ++++++++++---------
>   7 files changed, 2061 insertions(+), 613 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>   create mode 100644 drivers/memory/stm32-fmc2-ebi.c
> 
