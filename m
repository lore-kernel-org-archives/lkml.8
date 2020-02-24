Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24352C35679
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3C5620732
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 10:03:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgBXKD1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 05:03:27 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2455 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726509AbgBXKD1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 05:03:27 -0500
Received: from lhreml707-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 181C7ED5757C216E6D05;
        Mon, 24 Feb 2020 10:03:26 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml707-cah.china.huawei.com (10.201.108.48) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Mon, 24 Feb 2020 10:03:25 +0000
Received: from [127.0.0.1] (10.202.226.45) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Mon, 24 Feb
 2020 10:03:25 +0000
Subject: Re: Query on device links
To:     Saravana Kannan <saravanak@google.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <7f7d9b37-3f10-fefb-db23-86c8f83e8885@huawei.com>
 <CAGETcx_eHbVLmfYy5ggMKgXR1MQosLarrfpJA8j65krbvAzEbg@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <e9b404b4-a7bf-71ba-203c-adde0e334d56@huawei.com>
Date:   Mon, 24 Feb 2020 10:03:24 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAGETcx_eHbVLmfYy5ggMKgXR1MQosLarrfpJA8j65krbvAzEbg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.45]
X-ClientProxiedBy: lhreml708-chm.china.huawei.com (10.201.108.57) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2020 06:55, Saravana Kannan wrote:
> On Thu, Feb 6, 2020 at 2:32 AM John Garry <john.garry@huawei.com> wrote:
>>
>> Hi guys,
> 
> Sorry it took a while to get back.

no worries, it may have seemed a daft question

> 
>>
>> According to "Limitations" section @
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/driver-api/device_link.rst#n110,
>> for a managed link, lack of the supplier driver may cause indefinite
>> delay in probing of the consumer. Is there any way around this?
> 
> Currently, no. There's no way to guarantee ordering AND ignore
> supplier failures.
> 
>> So I just want the probe order attempt of the supplier and consumer to
>> be guaranteed, but the supplier probe may not be successful, i.e. does
>> not actually bind.
>>
>> In my case, I would like to use device_link_add(supplier, consumer,
>> DL_FLAG_AUTOPROBE_CONSUMER), but I find the supplier probe may fail (and
>> not due to -EPROBE_DEFER), and my consumer remains in limbo.
> 
> The requirements seem to contradict each other. If you depend on the
> supplier, how can you probe the consumer if the supplier fails?

In fact, I now consider what I was attempting to be a hack and not the 
proper solution to the problem.

So we assign an IOMMU group to a device in the really_probe() dma 
configure, which I required to be in order.

However the proper approach may now be to take the device iommu group 
assignment outside the device driver probe path, and not consider device 
links as the solution or any such device driver probe ordering.

> 
>> You may ask my I want this ordering at all - it is because in
>> really_probe(), we do the device DMA configure before the actual device
>> driver probe, and I just need that ordering to be ensured between devices.
> 
> I'm assuming the supplier in your case is the "dma device" (is it an
> iommu?)?

No, just 2 PCI devices, the port and an end device.

  So if it fails, how is your consumer probing without the
> supplier? I'd think something like a DMA would be fundamental?
> 
> Why can't this logic be handled in your consumer driver instead of
> using device links? 

Yes, I did try something like this, but, again, it just looks like the 
IOMMU group device assignment needs rework.

Why can't your consumer driver return
> -EPROBE_DEFER if the dma ops are not set up correctly until some point
> after which (after late_initcall?) the consumer will continue probing
> without returning -EPROBE_DEFER even if the supplier isn't there/dma
> ops aren't set up? >
> Can you give a more concrete example of your devices? Or why the
> suggestion above might not work?

As above.

Please note that we still may want to use device links for ensuring 
probe ordering of the DMA device and the IOMMU, but this is not a 
specifically related issue.

Much appreciated,
john
