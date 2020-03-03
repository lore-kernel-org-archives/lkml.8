Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EFBC3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA72A208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 09:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbgCCJmt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 04:42:49 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2500 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725932AbgCCJmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 04:42:49 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 17437D1B0E2FDFC47141;
        Tue,  3 Mar 2020 09:42:47 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Tue, 3 Mar 2020 09:42:46 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Tue, 3 Mar 2020
 09:42:46 +0000
Subject: Re: [PATCH RFC 1/3] spi: Allow SPI controller override device
 buswidth
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     Mark Brown <broonie@kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-2-git-send-email-john.garry@huawei.com>
 <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <f6f21e75-7cee-89da-bb87-95327a4ec2cc@huawei.com>
Date:   Tue, 3 Mar 2020 09:42:45 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAMuHMdW7Xu6EzfmVFx1+i1byy3KOS5A+h2GuMb8nkZ+-jD1=BA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml725-chm.china.huawei.com (10.201.108.76) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Geert,

> 
> On Fri, Feb 28, 2020 at 4:23 PM John Garry <john.garry@huawei.com> wrote:
>> Currently ACPI firmware description for a SPI device does not have any
>> method to describe the data buswidth on the board.
>>
>> So even through the controller and device may support higher modes than
>> standard SPI, it cannot be assumed that the board does - as such, that
>> device is limited to standard SPI in such a circumstance.
>>
>> As a workaround, allow the controller driver supply buswidth override bits,
>> which are used inform the core code that the controller driver knows the
>> buswidth supported on that board for that device.
> 
> Just wondering: can't the controller just override this (e.g. in the .setuup()
> callback) without having to touch the generic code?

I think that this is a good idea.

However, where we call .setup() in spi_setup() looks a little too late - 
at the point we call .setup(), most of the work on vetting/fixing the 
mode bits is complete. And I would not want the SPI controller driver 
just to disregard this work and overwrite the bits (in this way).

And if we wanted to move the .setup callback earlier, then I would be 
worried here with 2 things:
1. Some SPI controller drivers may rely on spi->mode being set finally 
when .setup() is called
2. We may need to undo the work of .setup() if we later error in 
spi_setup(), like for invalid mode bits

However, maybe another callback could be introduced, .early_setup().

Thanks,
John
