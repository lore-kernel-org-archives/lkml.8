Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 365A4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:09:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1040920838
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:09:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728529AbgAJQJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:09:42 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2256 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728320AbgAJQJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:09:42 -0500
Received: from LHREML712-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id CF4D7A976DFC985B08FF;
        Fri, 10 Jan 2020 16:09:40 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML712-CAH.china.huawei.com (10.201.108.35) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 10 Jan 2020 16:09:40 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 10 Jan
 2020 16:09:40 +0000
Subject: Re: [PATCH v2 2/3] spi: Add HiSilicon v3xx SPI NOR flash controller
 driver
To:     Mark Brown <broonie@kernel.org>
CC:     <tudor.ambarus@microchip.com>, <linux-kernel@vger.kernel.org>,
        <chenxiang66@hisilicon.com>, <linuxarm@huawei.com>,
        <linux-spi@vger.kernel.org>, <marek.vasut@gmail.com>,
        <linux-mtd@lists.infradead.org>, <xuejiancheng@hisilicon.com>,
        <fengsheng5@huawei.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>, <liusimin4@huawei.com>
References: <1575900490-74467-1-git-send-email-john.garry@huawei.com>
 <1575900490-74467-3-git-send-email-john.garry@huawei.com>
 <0dc5cb2e-b765-9e13-b05e-9e3c835c5985@huawei.com>
 <20200109212842.GK3702@sirena.org.uk>
 <df67b562-7d82-19f6-7581-680190a7772d@huawei.com>
 <20200110140726.GB5889@sirena.org.uk>
 <6db83881-927c-d11c-9c77-23a45892ddab@huawei.com>
 <20200110151220.GC5889@sirena.org.uk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <876fdbb7-1e2f-13a6-ea8b-48b0470136c1@huawei.com>
Date:   Fri, 10 Jan 2020 16:09:39 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200110151220.GC5889@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml729-chm.china.huawei.com (10.201.108.80) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2020 15:12, Mark Brown wrote:
> On Fri, Jan 10, 2020 at 02:58:54PM +0000, John Garry wrote:
>> On 10/01/2020 14:07, Mark Brown wrote:
>>> On Fri, Jan 10, 2020 at 11:55:37AM +0000, John Garry wrote: >
> 

Hi Mark,

>>> OK, so that's just reusing the DT binding in which case everything
>>> that's valid for the DT binding should also be valid for ACPI - I
>>> thought that actually worked automatically without you having to do
>>> anything in the code but ICBW.
> 
>> I thought that it would be improper as we could be mixing ACPI methods to
>> describe the serial bus (SPI Serial Bus Connection Resource Descriptor) and
>> also DT properties which could conflict, like CS active high.
> 
> Yes, that's one of the issues with importing bits of DT into ACPI
> unfortunately - you will get conflicts, it's not clear it's a good idea
> to be using PRP0001 for SPI stuff given that there's bus level bindings
> for both ACPI and SPI and they don't line up exactly.

Yeah, I'm not entirely comfortable with this yet.

> 
>> However I do see extra properties than "compatible" being added in DSD for
>> PRP0001:
>> https://patchwork.ozlabs.org/patch/662813/ (see EEPROM part)
> 
>> And if we were to do this, I think that we would need to add some
>> device_property_read_u32("spi-rx-bus-width", ...), etc calls in the SPI FW
>> parsing for ACPI path - I couldn't see that.
> 
> You'd need parsing code, yes.
> 

I'll continue to check the options.

Thanks,
john
