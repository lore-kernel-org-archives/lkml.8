Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E874C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 729B8246A2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 17:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgB1RRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 12:17:24 -0500
Received: from lhrrgout.huawei.com ([185.176.76.210]:2481 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725730AbgB1RRX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 12:17:23 -0500
Received: from lhreml705-cah.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3B93C3EC7F4F8817DCB1;
        Fri, 28 Feb 2020 17:17:21 +0000 (GMT)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 lhreml705-cah.china.huawei.com (10.201.108.46) with Microsoft SMTP Server
 (TLS) id 14.3.408.0; Fri, 28 Feb 2020 17:17:20 +0000
Received: from [127.0.0.1] (10.210.169.120) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5; Fri, 28 Feb
 2020 17:17:19 +0000
Subject: Re: [PATCH RFC 3/3] spi: HiSilicon v3xx: Use DMI quirk to set
 controller buswidth override bits
To:     Mark Brown <broonie@kernel.org>
CC:     <linuxarm@huawei.com>, <andriy.shevchenko@linux.intel.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
References: <1582903131-160033-1-git-send-email-john.garry@huawei.com>
 <1582903131-160033-4-git-send-email-john.garry@huawei.com>
 <20200228162057.GC4956@sirena.org.uk>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a3b1711b-ed70-59d0-3326-991f1531db2b@huawei.com>
Date:   Fri, 28 Feb 2020 17:17:18 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200228162057.GC4956@sirena.org.uk>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.120]
X-ClientProxiedBy: lhreml707-chm.china.huawei.com (10.201.108.56) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2020 16:20, Mark Brown wrote:
> On Fri, Feb 28, 2020 at 11:18:51PM +0800, John Garry wrote:
>> The Huawei D06 board (and variants) can support Quad mode of operation.
>>
>> Since we have no current method in ACPI SPI bus device resource description
>> to describe this information, use DMI to detect the board, and set the
>> controller buswidth override bits.
> 
> Hopefully this is something that the ACPI people will be looking to
> address going forwards :/
> 

Yeah, well I did mention the bugzilla [0] I raised for this in the cover 
letter; but I think that the new process workflows to raise feature 
requests in this way still needs to be formalized, so this may be 
blocked for now [1].

And unfortunately I can't actively participate in relevant standards WGs 
either, so if anyone else would like to assist, then that would great...

BTW, I think that it might also be good to request a generic 
jedec-compatible SPI NOR part ACPI HID/CID here also.

Thanks,
John

[0] https://bugzilla.tianocore.org/show_bug.cgi?id=2557
[1] https://edk2.groups.io/g/devel/message/53420

> 
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/
> 

