Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C43DC35240
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61C1320720
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 11:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgA2LDa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 06:03:30 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2328 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726067AbgA2LDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 06:03:30 -0500
Received: from LHREML710-CAH.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id BF4FEE6D71F9D8E74484;
        Wed, 29 Jan 2020 11:03:28 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 LHREML710-CAH.china.huawei.com (10.201.108.33) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Wed, 29 Jan 2020 11:03:28 +0000
Received: from [127.0.0.1] (10.202.226.43) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 29 Jan
 2020 11:03:28 +0000
Subject: Re: [PATCH RFC 1/2] ACPI/PPTT: Add acpi_pptt_get_package_info() API
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     <rjw@rjwysocki.net>, <lenb@kernel.org>, <jeremy.linton@arm.com>,
        <arnd@arndb.de>, <olof@lixom.net>, <linux-kernel@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <guohanjun@huawei.com>,
        <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        wanghuiqiang <wanghuiqiang@huawei.com>
References: <1580210059-199540-1-git-send-email-john.garry@huawei.com>
 <1580210059-199540-2-git-send-email-john.garry@huawei.com>
 <20200128123415.GB36168@bogus>
 <60c79aaa-4c49-71b1-11be-8e41a6bf3c1d@huawei.com>
 <20200128145430.GA47557@bogus>
From:   John Garry <john.garry@huawei.com>
Message-ID: <8c9f68ed-2cc8-ae33-2c6a-8c520511d7c4@huawei.com>
Date:   Wed, 29 Jan 2020 11:03:27 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200128145430.GA47557@bogus>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.43]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/01/2020 14:54, Sudeep Holla wrote:
>>>> https://lore.kernel.org/linux-arm-kernel/1579876505-113251-6-git-send-email-john.garry@huawei.com/
>>>>
>>> Ah, there's already quite a lot of dependency built for this feature:(
>> Not really. It's only an RFC ATM, and my requirement is a sysfs file to read
>> the SoC id(s) (under ACPI FW). So I would still expect to be able to support
>> this from the SMCCC extension method.
>>

Hi Sudeep,

> As mentioned above, yes the driver would remain almost same for SMCCC
> SOC_ID support too. The main point was: do we need to add support to
> PPTT Type 2 entry when we know there is proposal to deprecate it. I
> would at-least wait to see progress on that until I would add this to
> the kernel.

Not having support in the kernel for a feature which may be officially 
deprecated, i.e public knowledge, in future (maybe 1 year) seems harsh. 
Especially when there is no final released alternative.

So do you know if other OSes use it?

Thanks
John
