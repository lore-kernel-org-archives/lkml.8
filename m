Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA98C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:07:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7523A20738
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbgHRHHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:07:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:47358 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726043AbgHRHHW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:07:22 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 44F63BCD2F157C503327;
        Tue, 18 Aug 2020 15:07:14 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 15:07:05 +0800
Subject: Re: [PATCH v11 5/5] kdump: update Documentation about crashkernel
To:     Dave Young <dyoung@redhat.com>
References: <20200801130856.86625-1-chenzhou10@huawei.com>
 <20200801130856.86625-6-chenzhou10@huawei.com>
 <20200808100239.GB60590@dhcp-128-65.nay.redhat.com>
 <96d0da23-d484-7f66-1680-07b4b5984831@huawei.com>
 <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <james.morse@arm.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
        <bhe@redhat.com>, <corbet@lwn.net>, <John.P.donnelly@oracle.com>,
        <prabhakar.pkin@gmail.com>, <bhsharma@redhat.com>,
        <horms@verge.net.au>, <robh+dt@kernel.org>, <arnd@arndb.de>,
        <nsaenzjulienne@suse.de>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kexec@lists.infradead.org>,
        <linux-doc@vger.kernel.org>, <guohanjun@huawei.com>,
        <xiexiuqi@huawei.com>, <huawei.libin@huawei.com>,
        <wangkefeng.wang@huawei.com>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <2e6aebf9-3765-5d8c-933c-698442db1d52@huawei.com>
Date:   Tue, 18 Aug 2020 15:07:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200810060355.GB6988@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/8/10 14:03, Dave Young wrote:
> Hi,
>
>>> Previously I remember we talked about to use similar logic as X86, but I
>>> remember you mentioned on some arm64 platform there could be no low
>>> memory at all.  Is this not a problem now for the fallback?  Just be
>>> curious, thanks for the update, for the common part looks good.
>> Hi Dave,
>>
>> Did you mean this discuss: https://lkml.org/lkml/2019/12/27/122?
> I meant about this reply instead :)
> https://lkml.org/lkml/2020/1/16/616
Hi Dave,

Sorry for not repley in time, I was on holiday last week.

The platform James mentioned may exist for which have no devices and need no low memory.
For our arm64 server platform, there are some devices and need low memory.

I got it. For the platform with no low memory, reserving crashkernel will  always fail.
How about like this:

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index a8e34d97a894..4df18c7ea438 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -147,7 +147,7 @@ static void __init reserve_crashkernel(void)
        }
        memblock_reserve(crash_base, crash_size);
 
-       if (crash_base >= CRASH_ADDR_LOW_MAX) {
+       if (memstart_addr < CRASH_ADDR_LOW_MAX && crash_base >= CRASH_ADDR_LOW_MAX) {
                const char *rename = "Crash kernel (low)";
 
                if (reserve_crashkernel_low()) {


Thanks,
Chen Zhou

>
> Thanks
> Dave
>
>
> .
>


