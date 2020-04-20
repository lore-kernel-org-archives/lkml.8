Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66B1C54FC9
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:09:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE057214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 01:09:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726105AbgDTBJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 21:09:12 -0400
Received: from mga14.intel.com ([192.55.52.115]:51128 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgDTBJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 21:09:11 -0400
IronPort-SDR: BsfHN7imppNWeZj1zbkFWllzHay2Svf4LAm56fA3oFca4IU79nCZA2kbCCX2rtG6hJjHeFOX4s
 j9d4GSdU/1EQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2020 18:09:10 -0700
IronPort-SDR: X/D7cYW06a74LaCV/tT7wdGmh7ZQaZiVr4CoTiBaLe6FPhwwMJIRiRFxkeKQ/8L4MtZN+VyGiS
 keNyESwRE5vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,405,1580803200"; 
   d="scan'208";a="333759978"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 19 Apr 2020 18:09:09 -0700
Received: from [10.249.68.96] (unknown [10.249.68.96])
        by linux.intel.com (Postfix) with ESMTP id C7E275802C9;
        Sun, 19 Apr 2020 18:09:02 -0700 (PDT)
Subject: Re: [PATCH v1 2/2] mtd: rawnand: Add NAND controller support on Intel
 LGM SoC
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@collabora.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Andriy Shevchenko <andriy.shevchenko@intel.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        cheol.yong.kim@intel.com, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        masonccyang@mxic.com.tw, Miquel Raynal <miquel.raynal@bootlin.com>,
        Piotr Sroka <piotrs@cadence.com>, qi-ming.wu@intel.com,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>, Vignesh R <vigneshr@ti.com>,
        Songjun Wu <songjun.wu@linux.intel.com>,
        yixin.zhu@linux.intel.com, chuanhua.lei@linux.intel.com,
        John Crispin <john@phrozen.org>
References: <20200414022433.36622-3-vadivel.muruganx.ramuthevar@linux.intel.com>
 <20200415220533.733834-1-martin.blumenstingl@googlemail.com>
 <c33c8653-16a2-5bcd-97a9-511d958b755a@linux.intel.com>
 <20200416113822.2ef326cb@collabora.com>
 <18568cf6-2955-472e-7b68-eb35e654a906@linux.intel.com>
 <20200416122619.2c481792@collabora.com>
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
 <20200416131725.51259573@collabora.com>
 <de9f50b8-9215-d294-9914-e49701552185@linux.intel.com>
 <20200416135711.039ba85c@collabora.com>
 <CAHp75Vcpb-556imBuhsY-asrKqx7LjvQbq+P-ysK-+ii91YpWQ@mail.gmail.com>
 <20200416144036.3ce8432f@collabora.com>
 <CAK8P3a1rYDfTW60eY3RiiSOeT9EsNxw2rxMuQ9UjaS+JDiHy3Q@mail.gmail.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <fababbbf-c520-3c03-356a-77846076151f@linux.intel.com>
Date:   Mon, 20 Apr 2020 09:09:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a1rYDfTW60eY3RiiSOeT9EsNxw2rxMuQ9UjaS+JDiHy3Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 16/4/2020 9:20 pm, Arnd Bergmann wrote:
> On Thu, Apr 16, 2020 at 2:40 PM Boris Brezillon
> <boris.brezillon@collabora.com> wrote:
>> On Thu, 16 Apr 2020 15:26:51 +0300
>> Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
>>> On Thu, Apr 16, 2020 at 3:03 PM Boris Brezillon
>>> <boris.brezillon@collabora.com> wrote:
>>>> On Thu, 16 Apr 2020 19:38:03 +0800
>>>> Note that the NAND subsystem is full of unmaintained legacy drivers, so
>>>> every time we see someone who could help us get rid or update one of
>>>> them we have to take this opportunity.
>>> Don't we rather insist to have a MAINTAINERS record for new code to
>>> avoid (or delay at least) the fate of the legacy drivers?
>>>
>> Well, that's what we do for new drivers, but the xway driver has been
>> added in 2012 and the policy was not enforced at that time. BTW, that
>> goes for most of the legacy drivers in have in the NAND subsystems
>> (some of them even predate the git era).
>>
>> To be clear, I just checked and there's no official maintainer for this
>> driver. Best option would be to Cc the original author and contributors
>> who proposed functional changes to the code, as well as the MIPS
>> maintainers (Xway is a MIPS platform).
> A lot of the pre-acquisition code for lantiq was contributed by Hauke
> Mehrtens and John Crispin. There was an intermediate generation of
> MIPS SoCs with patches posted for review  by Intel in 2018 (presumably
> by the same organizatiob), but those were never resubmitted after v2
> and never merged:
>
> https://lore.kernel.org/linux-mips/20180803030237.3366-1-songjun.wu@linux.intel.com/
Thank you for reviewing our patches and your time...
The above patches for different SoC which is MIPS based, but whatever 
the patch is sent by me is Intel X86 ATOM based LGM SoC.

Regards
Vadivel
>
>          Arnd
