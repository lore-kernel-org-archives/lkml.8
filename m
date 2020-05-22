Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB7DC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3C7207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 09:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728489AbgEVJnl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 05:43:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:46410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728210AbgEVJnk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 05:43:40 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id CA04AC95D7E41B77ACF4;
        Fri, 22 May 2020 17:43:38 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.93) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Fri, 22 May 2020
 17:43:37 +0800
Subject: Re: arm64/acpi: NULL dereference reports from UBSAN at boot
From:   Hanjun Guo <guohanjun@huawei.com>
To:     Will Deacon <will@kernel.org>, <lorenzo.pieralisi@arm.com>
CC:     <rjw@rjwysocki.net>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <mark.rutland@arm.com>
References: <20200521100952.GA5360@willie-the-truck>
 <ad521a36-c080-f761-e91b-dc38b8af08ee@huawei.com>
Message-ID: <381deefd-db48-7884-8335-fb9e8f5c96dd@huawei.com>
Date:   Fri, 22 May 2020 17:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <ad521a36-c080-f761-e91b-dc38b8af08ee@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.93]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/5/22 16:07, Hanjun Guo wrote:
> Hi Will,
> 
> On 2020/5/21 18:09, Will Deacon wrote:
>> Hi folks,
>>
>> I just tried booting the arm64 for-kernelci branch under QEMU (version
>> 4.2.50 (v4.2.0-779-g4354edb6dcc7)) with UBSAN enabled, and I see a couple
>> of NULL pointer dereferences reported at boot. I think they're both GIC
>> related (log below). I don't see a panic with UBSAN disabled, so 
>> something's
>> fishy here.
>>
>> Please can you take a look when you get a chance? I haven't had time 
>> to see
>> if this is a regression or not, but I don't think it's particularly 
>> serious
>> as I have all sorts of horrible stuff enabled in my .config, since I'm
>> trying to chase down another bug:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/mark/linux.git/plain/arch/arm64/configs/fuzzing.config?h=fuzzing/arm64-kernelci-20200519&id=c149cf6a51aa4f72d53fc681c6661094e93ef660 
>>
>>
>> (on top of defconfig)
>>
>> CONFIG_FAIL_PAGE_ALLOC may be to blame.
> 
> I enabled UBSAN and CONFIG_FAIL_PAGE_ALLOC on top of defconfig,
> testing against the for-kernelci branch on the D06 board, I
> can see some UBSAN warnings from megaraid_sas driver [0], but not
> from any other subsystem including ACPI, I will try all your
> configs above to see if I can get more warnings.

Enabled all the configs except "CONFIG_MODULES=n" and
"CONFIG_SHADOW_CALL_STACK=y" (can't do that via make menuconfig,
do it manually?) in the link, but still got the same warnings and
no other warnings as before, the system is in good function, please
let me know I can do anything more to help the debug.

Thanks
Hanjun


