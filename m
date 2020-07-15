Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936A1C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 68D5920657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 08:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbgGOIZI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 04:25:08 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2481 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729792AbgGOIZH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 04:25:07 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 5B634C3BD6AD20BE046F;
        Wed, 15 Jul 2020 09:25:06 +0100 (IST)
Received: from [127.0.0.1] (10.47.6.38) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 15 Jul
 2020 09:25:05 +0100
Subject: Re: [PATCH] drivers/perf: hisi: Add identifier sysfs file
To:     Will Deacon <will@kernel.org>
CC:     <zhangshaokun@hisilicon.com>, <mark.rutland@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <qiangqing.zhang@nxp.com>,
        <jolsa@redhat.com>, <linuxarm@huawei.com>
References: <1592399111-134786-1-git-send-email-john.garry@huawei.com>
 <20200714083216.GD4516@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <67db3c30-5aaf-ac17-0256-950494f5ba88@huawei.com>
Date:   Wed, 15 Jul 2020 09:23:19 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200714083216.GD4516@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.6.38]
X-ClientProxiedBy: lhreml728-chm.china.huawei.com (10.201.108.79) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

> 
> On Wed, Jun 17, 2020 at 09:05:11PM +0800, John Garry wrote:
>> To allow userspace to identify the specific implementation of the device,
>> add an "identifier" sysfs file.
>>
>> Encoding is as follows:
>> hi1620: 0x0	(aka hip08)
>> hi1630: 0x30
>>
>> Signed-off-by: John Garry <john.garry@huawei.com>
> 
> I'm struggling a bit to track this. If you still think it's worth pursuing,
> please could you post a series with a cover-letter describing what this is
> for, a link to the userspace changes and then patches for all the PMU
> drivers that need updating? 

There is no hi1630 userspace support yet.

So what I can do is post updated userspace support (including hi1630), 
and then post kernel parts together for all drivers we could initially 
support.

@Joakim, I'll pick your imx driver changes here, if you don't mind.

There was an RFC from you for the SMMUv3 PMU as
> well, and also some other "arm64" changes.
> 

I hope to drop that RFC if an updated SMMUv3 spec helps us out.

Cheers,
John

