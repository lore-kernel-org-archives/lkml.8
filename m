Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47AAC2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:38:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B6A520656
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 11:38:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506484AbgDPLhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 07:37:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:19921 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505999AbgDPLCu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 07:02:50 -0400
IronPort-SDR: lcxxE+nfGBsZftEHNYwjeoggejy1kV4+AiHRPj3qB6/101S9K7a0STQqYA1Hntk2/OGMsxUYkv
 uGHtRfNp6fjg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 03:40:59 -0700
IronPort-SDR: 1wg/ODuGBi06D2wIst8A75fcWOrchCyh2F+4Utprzj+/NzuIiYQxmuD3T45hQ2lYlnQkbDVcxb
 5dyTobpPsHAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; 
   d="scan'208";a="455224018"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga006.fm.intel.com with ESMTP; 16 Apr 2020 03:40:59 -0700
Received: from [10.255.154.239] (vramuthx-MOBL1.gar.corp.intel.com [10.255.154.239])
        by linux.intel.com (Postfix) with ESMTP id 084F558045A;
        Thu, 16 Apr 2020 03:40:54 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        anders.roxell@linaro.org, andriy.shevchenko@intel.com,
        arnd@arndb.de, brendanhiggins@google.com, cheol.yong.kim@intel.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, masonccyang@mxic.com.tw,
        miquel.raynal@bootlin.com, piotrs@cadence.com,
        qi-ming.wu@intel.com, richard@nod.at, robh+dt@kernel.org,
        tglx@linutronix.de, vigneshr@ti.com
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
 <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
 <20200416122619.2c481792@collabora.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
Date:   Thu, 16 Apr 2020 18:40:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416122619.2c481792@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/4/2020 6:26 pm, Boris Brezillon wrote:
> On Thu, 16 Apr 2020 17:45:49 +0800
> "Ramuthevar, Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
>>>>>> From: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
>>>>>>
>>>>>> This patch adds the new IP of Nand Flash Controller(NFC) support
>>>>>> on Intel's Lightning Mountain(LGM) SoC.
>>>>>>
>>>>>> DMA is used for burst data transfer operation, also DMA HW supports
>>>>>> aligned 32bit memory address and aligned data access by default.
>>>>>> DMA burst of 8 supported. Data register used to support the read/write
>>>>>> operation from/to device.
>>>>> I am wondering how this new hardware is different from the Lantiq NAND
>>>>> controller IP - for which there is already a driver in mainline (it's
>>>>> in drivers/mtd/nand/raw/xway_nand.c).
>>>>> The CON and WAIT registers look suspiciously similar.
>>>>>
>>>>> As far as I understand the "old" SoCs (VRX200 and earlier) don't have
>>>>> a built-in ECC engine. This seems to have changed with ARX300 though
>>>>> (again, AFAIK).
>>>>>
>>>>> A bit of lineage on these SoCs (initially these were developed by
>>>>> Infineon. Lantiq then started as an Infineon spin-off in 2009 and
>>>>> was then acquired by Intel in 2015):
>>>>> - Danube
>>>>> - ARX100 from 2008/2009
>>>>> - VRX200 from 2009/2010
>>>>> - ARX300 from 2014
>>>>> - GRX350 from 2015/2016
>>>>> - GRX550 from 2017
>>>>> - and now finally: LGM from 2020 (est.)
>>>>>
>>>>> The existing xway_nand driver supports the Danube, ARX100 and VRX200
>>>>> SoCs.
>>>> Lantiq upstreamed a driver for an older version of this IP core 8 years
>>>> ago, see here:
>>>> https://elixir.bootlin.com/linux/v5.5.6/source/drivers/mtd/nand/raw/xway_nand.c
>>>> It does not support DMA and ECC.
>>> Then let's just extend this driver to support the new features. Plus,
>> We do not have the platform to test also it's very old legacy driver .
> Well, if it's similar enough, we want to have one driver.

Thank you very much for the time and suggestions...

This in-review driver is written for a new nand flash controller IP 
which is used in LGM.

>>> we'll be happy to have one more of the existing driver converted to
>>> ->exec_op() ;-).
>> I have completely adapted to ->exec_op() hook up to replace the legacy
>> call-back.
> I suspect porting what you've done to the xway driver shouldn't be too
> complicated.
Not ported from xway_nand.c driver , we have developed from the scratch 
to make it work on
Intel LGM SoC , it's new x86 ATOM based SoC, IP itself completely 
different and most of the registers won't match.
if we port then it would be ugly and also what are the problem may occur 
we do not know.

Regards
Vadivel
