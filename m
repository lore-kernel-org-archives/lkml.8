Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5CA6C2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:21:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860602063A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 05:21:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgDQFVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 01:21:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:61629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726616AbgDQFVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 01:21:45 -0400
IronPort-SDR: 36IFSQSyo94m9vN0W6f3ojiKkcJNvGC9U7h+cjno4aMfwqgs5yF9OpJg+3rfpRkXhwl9lxm3VE
 QeTdCsPIhQ0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 22:21:44 -0700
IronPort-SDR: IWLWq5/I+DZ3obhuAuh5M/w5s7v9CK98H7ehZi2J+M3Y9scL4D61yFNAkGqs9ArSO8PXYVzxFY
 xTXiixFR09cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; 
   d="scan'208";a="333086319"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 16 Apr 2020 22:21:44 -0700
Received: from [10.255.156.142] (vramuthx-mobl1.gar.corp.intel.com [10.255.156.142])
        by linux.intel.com (Postfix) with ESMTP id 518AC580661;
        Thu, 16 Apr 2020 22:21:40 -0700 (PDT)
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
 <d3e137fa-54a0-b4ec-eb24-3984eab2a247@linux.intel.com>
 <20200416131725.51259573@collabora.com>
 <de9f50b8-9215-d294-9914-e49701552185@linux.intel.com>
 <20200416135711.039ba85c@collabora.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <003fa549-08c5-5867-2b02-54b483c16465@linux.intel.com>
Date:   Fri, 17 Apr 2020 13:21:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200416135711.039ba85c@collabora.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

On 16/4/2020 7:57 pm, Boris Brezillon wrote:
> On Thu, 16 Apr 2020 19:38:03 +0800
> "Ramuthevar, Vadivel MuruganX"
> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>
>> On 16/4/2020 7:17 pm, Boris Brezillon wrote:
>>> On Thu, 16 Apr 2020 18:40:53 +0800
>>> "Ramuthevar, Vadivel MuruganX"
>>> <vadivel.muruganx.ramuthevar@linux.intel.com> wrote:
>>>   
>>>>>>> we'll be happy to have one more of the existing driver converted to
>>>>>>> ->exec_op() ;-).
>>>>>> I have completely adapted to ->exec_op() hook up to replace the legacy
>>>>>> call-back.
>>>>> I suspect porting what you've done to the xway driver shouldn't be too
>>>>> complicated.
>>>> Not ported from xway_nand.c driver , we have developed from the scratch
>>>> to make it work on
>>>> Intel LGM SoC , it's new x86 ATOM based SoC, IP itself completely
>>>> different and most of the registers won't match.
>>>> if we port then it would be ugly and also what are the problem may occur
>>>> we do not know.
>>> Sorry but IMO they look similar enough to try to merge them.
>> Thanks! Boris, need suggestion from you since you are maintainer and
>> also expertise on mtd-subsystem.
> I *was* the maintainer :).
>
>> There are different features involved and lines of code is more, if we
>> add new driver patches over xway-nand driver
> How about retro-fitting the xway logic into your driver then? I mean,
> adding a 100 lines of code to your driver to get rid of the 500+ lines
> we have in xway_nand.c is still a win.
>
>> is completely looks ugly and it may disturb the existing functionality
>> as well since we don't have platform to validate:'(.
> How ugly? Can you show us? Maybe we can come with a solution to make it
> less ugly.
>
> As for the testing part, there are 4 scenarios:
>
> 1/ Your changes work perfectly fine on older platforms. Yay \o/!
> 2/ You break the xway driver and existing users notice it before this
>     series gets merged. Now you found someone to validate your changes.
> 3/ You break the xway driver and none of the existing users notice it
>     before the driver is merged, but they notice it afterwards. Too bad
>     this happened after we've merged the driver, but now you've found
>     someone to help you fix the problem :P.
> 4/ You break things for old platforms but no one ever complains about
>     it, either because there's no users left or because they never
>     update their kernels. In any case, that's no longer your problem.
>     Someone will remove those old platforms one day and get rid of the
>     unneeded code in the NAND driver.
>
> What's more likely to happen is #3 or #4, and I think the NAND
> maintainer would be fine with both.
>
> Note that the NAND subsystem is full of unmaintained legacy drivers, so
> every time we see someone who could help us get rid or update one of
> them we have to take this opportunity.
Agreed!, Thank you very much for the suggestions and clear inputs.
To proceed further, can you please share your inputs to dividing the tasks
and patches to be sent if possible.

Regards
Vadivel
