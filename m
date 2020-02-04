Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DATE_IN_PAST_12_24,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7179DC35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:11:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 468A9217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgBEELR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 23:11:17 -0500
Received: from mo-csw1114.securemx.jp ([210.130.202.156]:54104 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727832AbgBEELR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:11:17 -0500
Received: by mo-csw.securemx.jp (mx-mo-csw1114) id 0154AtKH001907; Wed, 5 Feb 2020 13:10:55 +0900
X-Iguazu-Qid: 2wHHtzQN1IJBztet9g
X-Iguazu-QSIG: v=2; s=0; t=1580875855; q=2wHHtzQN1IJBztet9g; m=IQTLn51A8N4XphFMWlu/8Md0Eo6xhWTaA0lOu9rFxI4=
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
        by relay.securemx.jp (mx-mr1111) id 0154AsM7031304;
        Wed, 5 Feb 2020 13:10:54 +0900
Received: from enc02.toshiba.co.jp ([61.202.160.51])
        by imx12.toshiba.co.jp  with ESMTP id 0154AslS010278;
        Wed, 5 Feb 2020 13:10:54 +0900 (JST)
Received: from hop101.toshiba.co.jp ([133.199.85.107])
        by enc02.toshiba.co.jp  with ESMTP id 0154ArdQ009010;
        Wed, 5 Feb 2020 13:10:53 +0900
Subject: Re: [PATCH] mtd: nand: Add comment about Kioxia ID
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <1580783163-5601-1-git-send-email-ytc-mb-yfuruyama7@kioxia.com>
 <20200204095214.666c71fc@xps13>
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
X-TSB-HOP: ON
Message-ID: <73dae14b-5bf0-b909-3229-aab3ed232669@kioxia.com>
Date:   Tue, 4 Feb 2020 19:30:04 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200204095214.666c71fc@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Miquèl,


On 2020/02/04 17:52, Miquel Raynal wrote:
> Hi Yoshio,
>
> Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Tue,  4 Feb
> 2020 11:26:03 +0900:
>
>> Add a comment above NAND_MFR_TOSHIBA and SPINAND_MFR_TOSHIBA definitions
>> that Toshiba and Kioxia ID are the same.
>>
>> Signed-off-by: Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
>> ---
>>   drivers/mtd/nand/raw/internals.h | 1 +
>>   drivers/mtd/nand/spi/toshiba.c   | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/drivers/mtd/nand/raw/internals.h b/drivers/mtd/nand/raw/internals.h
>> index cba6fe7..2918376b 100644
>> --- a/drivers/mtd/nand/raw/internals.h
>> +++ b/drivers/mtd/nand/raw/internals.h
>> @@ -30,6 +30,7 @@
>>   #define NAND_MFR_SAMSUNG	0xec
>>   #define NAND_MFR_SANDISK	0x45
>>   #define NAND_MFR_STMICRO	0x20
>> +/* Toshiba and Kioxia ID are the same. */
>>   #define NAND_MFR_TOSHIBA	0x98
>>   #define NAND_MFR_WINBOND	0xef
>>   
>> diff --git a/drivers/mtd/nand/spi/toshiba.c b/drivers/mtd/nand/spi/toshiba.c
>> index 0db5ee4..a92ecc8 100644
>> --- a/drivers/mtd/nand/spi/toshiba.c
>> +++ b/drivers/mtd/nand/spi/toshiba.c
>> @@ -10,6 +10,7 @@
>>   #include <linux/kernel.h>
>>   #include <linux/mtd/spinand.h>
>>   
>> +/* Toshiba and Kioxia ID are the same. */
>>   #define SPINAND_MFR_TOSHIBA		0x98
>>   #define TOSH_STATUS_ECC_HAS_BITFLIPS_T	(3 << 4)
>>   
>
> "Are the same" is not very descriptive, what about "Kioxia is the new
> name of Toshiba"?


That's a good idea.

Actually ,

Is was changed a company name from Toshiba memory Co to Kioxia Co.     
Since became independent from Toshiba group.

I will update the comment as "Kioxia is new name of Toshiba memory"


Thanks


