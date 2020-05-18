Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6CFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61981206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 11:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgERLja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 07:39:30 -0400
Received: from mga04.intel.com ([192.55.52.120]:16323 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726362AbgERLja (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 07:39:30 -0400
IronPort-SDR: 5fhgkOlOrUWTpT7XPwNdpeQ8iUOzdrrw1fJ5OWJjQKRHcfxkchrTuuiZaY028y3Rr55BojBH+j
 S8+iOOg0Qmnw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 04:39:28 -0700
IronPort-SDR: okSFRIVMsoSxIzjGKYjphCgKBJy1oF0hu5qOhb55uD5mIA+RvB3XPP/62fIDUA3B65XpK9N/lJ
 d2vC7LVeQQUg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="253038325"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga007.fm.intel.com with ESMTP; 18 May 2020 04:39:28 -0700
Received: from [10.214.148.4] (vramuthx-MOBL1.gar.corp.intel.com [10.214.148.4])
        by linux.intel.com (Postfix) with ESMTP id 151CE580100;
        Mon, 18 May 2020 04:39:23 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: [PATCH v7 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Arnd Bergmann <arnd@arndb.de>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>, kbuild-all@lists.01.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh R <vigneshr@ti.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        masonccyang@mxic.com.tw
References: <20200515105537.4876-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <202005152142.AWvx4xc5%lkp@intel.com>
 <CAHp75Ven9q-6dDYtP_uXigeS_r2uvpUZVR5Mh0RdEd36MbTG+Q@mail.gmail.com>
 <CAK8P3a3RKJo-C5=19oAppx212s7T8NdnKJVmkj+h=34a8aKMNA@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <5180e734-ff56-db5a-ab49-8a55cfa2f2c0@linux.intel.com>
Date:   Mon, 18 May 2020 19:39:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a3RKJo-C5=19oAppx212s7T8NdnKJVmkj+h=34a8aKMNA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Andy,

On 15/5/2020 10:30 pm, Arnd Bergmann wrote:
> On Fri, May 15, 2020 at 4:25 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>>
>> On Fri, May 15, 2020 at 4:48 PM kbuild test robot <lkp@intel.com> wrote:
>>
>>> sparse warnings: (new ones prefixed by >>)
>>>
>>>>> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
>>>>> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    expected unsigned int val
>>>>> drivers/mtd/nand/raw/intel-nand-controller.c:441:24: sparse:    got restricted __be32 [assigned] [usertype] reg
>>>     drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int val @@    got restricted __be32 [assignedunsigned int val @@
>>>     drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    expected unsigned int val
>>>     drivers/mtd/nand/raw/intel-nand-controller.c:444:24: sparse:    got restricted __be32 [assigned] [usertype] reg
>>>
>>>     440                  reg = cpu_to_be32(*pdata++);
>>>   > 441                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_0);
>>>     442
>>>     443                  reg = cpu_to_be32(*pdata);
>>>     444                  writel(reg, ebu_host->hsnand + HSNAND_CMSG_1);
>>
>> On BE:
>> cpu_to_be32 -> no-op
>> writel() -> converts reg to LE
>>
>> On LE:
>> cpu_to_be32 -> converts to BE
>> writel() -> no-op (in terms of conversion)
>>
>> Seems to me that the proper API (if above is intended) should be swab32().
>> But something tells me that above is broken (or my understanding is wrong).
> 
> iowrite_be32() is the correct way to store word into a big-endian mmio register,
> if that is the intention here.
Thank you for suggestions to use iowrite32be(), it suits exactly.

Regards
Vadivel

> 
>        Arnd
> 
