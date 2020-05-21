Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21B0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1B3F20748
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729662AbgEUOBQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:01:16 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729532AbgEUOBQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:01:16 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 3CC2F38420F11539B82D;
        Thu, 21 May 2020 15:01:14 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.132) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 21 May
 2020 15:01:13 +0100
Subject: Re: [PATCH V1 RESEND 1/3] perf/imx_ddr: Add system PMU identifier for
 userspace
To:     Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>
CC:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20200512073115.14177-1-qiangqing.zhang@nxp.com>
 <20200512073115.14177-2-qiangqing.zhang@nxp.com>
 <20200519185125.GB453195@bogus> <20200520073304.GA23534@willie-the-truck>
 <CAL_JsqJfQ0PFy5mmwSG4aM91ghq5xiAEPR2YZOymws+BfGa+uA@mail.gmail.com>
 <20200521130415.GB5949@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <c3be06c5-781f-384f-768b-d809da99b7e0@huawei.com>
Date:   Thu, 21 May 2020 15:00:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200521130415.GB5949@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.132]
X-ClientProxiedBy: lhreml715-chm.china.huawei.com (10.201.108.66) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2020 14:04, Will Deacon wrote:
> On Wed, May 20, 2020 at 09:23:41AM -0600, Rob Herring wrote:
>> On Wed, May 20, 2020 at 1:33 AM Will Deacon <will@kernel.org> wrote:
>>>
>>> On Tue, May 19, 2020 at 12:51:25PM -0600, Rob Herring wrote:
>>>> On Tue, May 12, 2020 at 03:31:13PM +0800, Joakim Zhang wrote:
>>>>> +static ssize_t ddr_perf_identifier_show(struct device *dev,
>>>>> +                                   struct device_attribute *attr,
>>>>> +                                   char *page)
>>>>> +{
>>>>> +   struct ddr_pmu *pmu = dev_get_drvdata(dev);
>>>>> +
>>>>> +   return sprintf(page, "%s\n", pmu->devtype_data->identifier);
>>>>
>>>> Why do we need yet another way to identify the SoC from userspace?
>>>
>>> I also really dislike this. What's the preferred way to identify the SoC
>>> from userspace?
>>
>> /proc/cpuinfo? ;)
> 
> The *SoC*!
> 
>> For an non-firmware specific case, I'd say soc_device should be. I'd
>> guess ACPI systems don't use it and for them it's dmidecode typically.
>> The other problem I have with soc_device is it is optional.
> 

Hi Will,

> John -- what do you think about using soc_device to expose this information,
> with ACPI systems using DMI data instead?

Generally I don't think that DMI is reliable, and I saw this as the 
least preferred choice. I'm looking at the sysfs DMI info for my dev 
board, and I don't even see anything like a SoC identifier.

As for the event_source device sysfs identifier file, it would not 
always contain effectively the same as the SoC ID.

Certain PMUs which I'm interested in plan to have probe-able 
identification info available in future.

Thanks,
John



