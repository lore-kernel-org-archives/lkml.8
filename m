Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721A7C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B3102076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgCRIVd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:21:33 -0400
Received: from mo-csw1115.securemx.jp ([210.130.202.157]:46442 "EHLO
        mo-csw.securemx.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgCRIVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:21:32 -0400
Received: by mo-csw.securemx.jp (mx-mo-csw1115) id 02I8L2fm010762; Wed, 18 Mar 2020 17:21:02 +0900
X-Iguazu-Qid: 2wHI1scKEP6Un1aFpV
X-Iguazu-QSIG: v=2; s=0; t=1584519662; q=2wHI1scKEP6Un1aFpV; m=tYEeYQOfbv0NS8WQPefQvNX9sqJ7svQnh+4MDaVVJEk=
Received: from imx2.toshiba.co.jp (imx2.toshiba.co.jp [106.186.93.51])
        by relay.securemx.jp (mx-mr1113) id 02I8L0Dp028359;
        Wed, 18 Mar 2020 17:21:01 +0900
Received: from enc01.localdomain ([106.186.93.100])
        by imx2.toshiba.co.jp  with ESMTP id 02I8bJ4b003726;
        Wed, 18 Mar 2020 17:37:19 +0900 (JST)
Received: from hop001.toshiba.co.jp ([133.199.164.63])
        by enc01.localdomain  with ESMTP id 02I8L0KQ016170;
        Wed, 18 Mar 2020 17:21:00 +0900
Subject: Re: [PATCH v4 0/2] mtd: spinand: toshiba: Support for new Kioxia
 Serial NAND
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     vigneshr@ti.com, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
References: <cover.1583834323.git.ytc-mb-yfuruyama7@kioxia.com>
 <20200311165011.63a3d82e@xps13>
From:   Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com>
X-TSB-HOP: ON
Message-ID: <42e02e2c-ee61-1b0d-5d8e-3a512c042151@kioxia.com>
Date:   Wed, 18 Mar 2020 14:40:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200311165011.63a3d82e@xps13>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2020/03/12 0:50, Miquel Raynal wrote:
> Hi Yoshio,
>
> Yoshio Furuyama <ytc-mb-yfuruyama7@kioxia.com> wrote on Wed, 11 Mar
> 2020 10:47:04 +0900:
>
>> First patch is to rename function name becase of add new device.
>> Second patch is to supprot for new device.
>>
>> Yoshio Furuyama (2):
>>    mtd: spinand: toshiba: Rename function name to change suffix and
>>      prefix (8Gbit)
>>    mtd: spinand: toshiba: Support for new Kioxia Serial NAND
>>
>>   drivers/mtd/nand/spi/toshiba.c | 173 +++++++++++++++++++++++++++++++----------
>>   1 file changed, 130 insertions(+), 43 deletions(-)
>>
> I am very sorry but actually I had issues applying all your patches not
> because they were not based on v5.6-rc1, but because since then I
> applied a patch changing the detection that changed the content of a
> lot of structures (including in Toshiba's driver).
>
> Can you please rebase again on top of the current nand/next? I am very
> sorry for this extra work, this is my mistake.

Thanks comment.         I will revise rev (V5) next week.

BR

> Head should be:
>
> 	a5d53ad26a8b ("mtd: rawnand: brcmnand: Add support for flash-edu for dma transfers")
>
> And the culprit commit is:
>
> 	f1541773af49 ("mtd: spinand: rework detect procedure for different READ_ID operation")
>
> Thanks,
> Miquèl
>
>
>
