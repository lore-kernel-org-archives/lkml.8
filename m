Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76F0EC55185
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B3C22076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgDVPhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:37:53 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:52667 "EHLO
        mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbgDVPhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 11:37:53 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 496l1q1PrBz1qs3y;
        Wed, 22 Apr 2020 17:37:51 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 496l1q0Hhfz1qqkk;
        Wed, 22 Apr 2020 17:37:51 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id L9jfpJQAEmpH; Wed, 22 Apr 2020 17:37:48 +0200 (CEST)
X-Auth-Info: e0W/HInL22tuuvHdriLQ2n8QzAPQDVvOM5CA7DC8bMM=
Received: from [IPv6:::1] (unknown [195.140.253.167])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Wed, 22 Apr 2020 17:37:47 +0200 (CEST)
Subject: Re: [PATCH v2] mtd: rawnand: denali: add more delays before latching
 incoming data
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org
References: <20200317071821.9916-1-yamada.masahiro@socionext.com>
 <6093dfab-1e9e-824a-b639-33d340b377f9@denx.de>
 <20200422173600.304c7cf2@xps13>
From:   Marek Vasut <marex@denx.de>
Message-ID: <95757315-9cf6-fbd8-af2d-3ac39753a757@denx.de>
Date:   Wed, 22 Apr 2020 17:37:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200422173600.304c7cf2@xps13>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/22/20 5:36 PM, Miquel Raynal wrote:
> Hi Marek,
> 
> Marek Vasut <marex@denx.de> wrote on Wed, 22 Apr 2020 17:29:53 +0200:
> 
>> On 3/17/20 8:18 AM, Masahiro Yamada wrote:
>>> The Denali IP have several registers to specify how many clock cycles
>>> should be waited between falling/rising signals. You can improve the
>>> NAND access performance by programming these registers with optimized
>>> values.
>>>
>>> Because struct nand_sdr_timings represents the device requirement
>>> in pico seconds, denali_setup_data_interface() computes the register
>>> values by dividing the device timings with the clock period.
>>>
>>> Marek Vasut reported this driver in the latest kernel does not work
>>> on his SOCFPGA board. (The on-board NAND chip is mode 5)
>>>
>>> The suspicious parameter is acc_clks, so this commit relaxes it.
>>>
>>> The Denali NAND Flash Memory Controller User's Guide describes this
>>> register as follows:
>>>
>>>   acc_clks
>>>     signifies the number of bus interface clk_x clock cycles,
>>>     controller should wait from read enable going low to sending
>>>     out a strobe of clk_x for capturing of incoming data.
>>>
>>> Currently, acc_clks is calculated only based on tREA, the delay on the
>>> chip side. This does not include additional delays that come from the
>>> data path on the PCB and in the SoC, load capacity of the pins, etc.
>>>
>>> This relatively becomes a big factor on faster timing modes like mode 5.
>>>
>>> Before supporting the ->setup_data_interface() hook (e.g. Linux 4.12),
>>> the Denali driver hacks acc_clks in a couple of ways [1] [2] to support
>>> the timing mode 5.
>>>
>>> We would not go back to the hard-coded acc_clks, but we need to include
>>> this factor into the delay somehow. Let's say the amount of the additional
>>> delay is 10000 pico sec.
>>>
>>> In the new calculation, acc_clks is determined by timings->tREA_max +
>>> data_setup_on_host.
>>>
>>> Also, prolong the RE# low period to make sure the data hold is met.
>>>
>>> Finally, re-center the data latch timing for extra safety.
>>>
>>> [1] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L276
>>> [2] https://github.com/torvalds/linux/blob/v4.12/drivers/mtd/nand/denali.c#L282
>>>
>>> Reported-by: Marek Vasut <marex@denx.de>
>>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>  
>>
>> I tested it on the AV SoCFPGA, this seems to work, so feel free to apply.
> 
> 
> Great! Thanks a lot for testing, would you mind sending your Tested-by?

Lightly
Tested-by: Marek Vasut <marex@denx.de>
