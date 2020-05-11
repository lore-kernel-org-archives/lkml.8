Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDC5C54E8E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:26:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE2B62080C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 10:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="fj7kvXnF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729046AbgEKK0p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 06:26:45 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:52781 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727093AbgEKK0o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 06:26:44 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04BAM2Jo011706;
        Mon, 11 May 2020 12:26:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=JOxfg+//EIzdyPpoUcRNv9cDiNoXOl/xkAO+PVn8Imc=;
 b=fj7kvXnFADhcqBRN+KrUKDKMGuiC8N+nrLc5oFawoXZb1SnLBUqKOJfmI/u9KUveYsgs
 p1R/lLegovExqm3p6WaLVcUMWaH4srKLQDZXtfN8P3yDDwVT4xQ4nQyRLP1wHSc0rDUy
 NWp3s/bP1l+jgeTLmAW+Z+1ECKcZd4SVX/ODmhN8xaHuxz66MwFNy26uVXZ04AYdKfYN
 +3b2mySARnFy/1ghBhqusnDGYSFOau0bEK2cCJt93bWZOohjB75oU6lUOZAZG6UE1mU3
 AyQ9P4SI4zJDi8H59bITDmSB1abLg5UW8LqVn43DYuYTmN80J8pSWPUcCSnU37SMrolI ww== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30wj9w9vek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 May 2020 12:26:16 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 8130C100038;
        Mon, 11 May 2020 12:26:15 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C36C2C38C2;
        Mon, 11 May 2020 12:26:15 +0200 (CEST)
Received: from [10.211.5.64] (10.75.127.51) by SFHDAG6NODE2.st.com
 (10.75.127.17) with Microsoft SMTP Server (TLS) id 15.0.1347.2; Mon, 11 May
 2020 12:26:08 +0200
Subject: Re: [PATCH v4 00/10] add STM32 FMC2 EBI controller driver
To:     Miquel Raynal <miquel.raynal@bootlin.com>
CC:     <richard@nod.at>, <vigneshr@ti.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <boris.brezillon@collabora.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
 <20200511112237.20751831@xps13>
From:   Christophe Kerello <christophe.kerello@st.com>
Message-ID: <a805b5c6-e465-c980-d716-29a655e63b0c@st.com>
Date:   Mon, 11 May 2020 12:26:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200511112237.20751831@xps13>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG6NODE3.st.com (10.75.127.18) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-11_04:2020-05-11,2020-05-11 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,

On 5/11/20 11:22 AM, Miquel Raynal wrote:
> Hi Christophe,
> 
> Christophe Kerello <christophe.kerello@st.com> wrote on Wed, 6 May 2020
> 11:11:09 +0200:
> 
>> The FMC2 functional block makes the interface with: synchronous and
>> asynchronous static devices (such as PSNOR, PSRAM or other memory-mapped
>> peripherals) and NAND flash memories.
>> Its main purposes are:
>>    - to translate AXI transactions into the appropriate external device
>>      protocol
>>    - to meet the access time requirements of the external devices
>> All external devices share the addresses, data and control signals with the
>> controller. Each external device is accessed by means of a unique Chip
>> Select. The FMC2 performs only one access at a time to an external device.
>>
>> Changes in v4:
>>   - bindings:
>>     - fix filename: st,stm32-fmc2-ebi.yaml
>>
>> Changes in v3:
>>   - NAND:
>>     - rename labels used on errors
>>     - add in the commit log the reason to increase FMC2_TIMEOUT_MS (patch 3)
>>     - add Miquel reviewed-by tag (patches 2/4/5/9)
>>   - EBI:
>>     - move in memory folder
>>     - merge MFD and BUS drivers to avoid a MFD driver
>>   - bindings:
>>     - pattern name has been modified
>>     - vendor properties have been modified
>>       - s/_/-/
>>       - add unit suffix (-ns) on timing properties
>>
>> Christophe Kerello (10):
>>    mtd: rawnand: stm32_fmc2: manage all errors cases at probe time
>>    mtd: rawnand: stm32_fmc2: remove useless inline comments
>>    mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
>>    mtd: rawnand: stm32_fmc2: cleanup
>>    mtd: rawnand: stm32_fmc2: use FIELD_PREP/FIELD_GET macros
>>    dt-bindings: mtd: update STM32 FMC2 NAND controller documentation
>>    dt-bindings: memory-controller: add STM32 FMC2 EBI controller
>>      documentation
>>    memory: stm32-fmc2-ebi: add STM32 FMC2 EBI controller driver
>>    mtd: rawnand: stm32_fmc2: use regmap APIs
>>    mtd: rawnand: stm32_fmc2: get resources from parent node
>>
>>   .../memory-controllers/st,stm32-fmc2-ebi.yaml      |  261 +++++
>>   .../bindings/mtd/st,stm32-fmc2-nand.yaml           |   19 +-
>>   drivers/memory/Kconfig                             |   10 +
>>   drivers/memory/Makefile                            |    1 +
>>   drivers/memory/stm32-fmc2-ebi.c                    | 1206 ++++++++++++++++++++
>>   drivers/mtd/nand/raw/Kconfig                       |    1 +
>>   drivers/mtd/nand/raw/stm32_fmc2_nand.c             | 1176 ++++++++++---------
>>   7 files changed, 2061 insertions(+), 613 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/memory-controllers/st,stm32-fmc2-ebi.yaml
>>   create mode 100644 drivers/memory/stm32-fmc2-ebi.c
>>
> 
> I'm fine with the preparation patches 1-5 but the other patches need
> Rob's hack and probably more changes. If it's fine with you I can apply
> these patches for the next merge window and let more time to work on
> the last 5.
> 

I am fine with your proposal.

Regards,
Christophe Kerello.

> Thanks,
> Miquèl
> 
