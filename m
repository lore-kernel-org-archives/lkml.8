Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CB8C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:19:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F6C8206A4
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 03:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbgIHDTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 23:19:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:55430 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728417AbgIHDTz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 23:19:55 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2C1BBABCE4975FAC3F91;
        Tue,  8 Sep 2020 11:19:53 +0800 (CST)
Received: from [127.0.0.1] (10.174.176.220) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.487.0; Tue, 8 Sep 2020
 11:19:44 +0800
Subject: Re: [PATCH v12 1/9] x86: kdump: move CRASH_ALIGN to 2M
To:     Dave Young <dyoung@redhat.com>
References: <20200907134745.25732-1-chenzhou10@huawei.com>
 <20200907134745.25732-2-chenzhou10@huawei.com>
 <20200908012138.GA3058@dhcp-128-65.nay.redhat.com>
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
Message-ID: <c0fc35d0-a9e3-6349-08bc-d2f7a12e3680@huawei.com>
Date:   Tue, 8 Sep 2020 11:19:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200908012138.GA3058@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.176.220]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/9/8 9:21, Dave Young wrote:
> Hi,
>
> On 09/07/20 at 09:47pm, Chen Zhou wrote:
>> CONFIG_PHYSICAL_ALIGN can be selected from 2M to 16M and default
>> value is 2M, so move CRASH_ALIGN to 2M, with smaller value reservation
>> can have more chance to succeed.
> Seems still some misunderstanding about the change :(  I'm sorry if I
> did not explain it clearly.
>
> Previously I missed the PHYSICAL_ALIGN can change according to .config
> I mean we should change the value to CONFIG_PHYSICAL_ALIGN for X86
> And I suggest to move back to keep using 16M.  And do not change it in
> this series.
Hi Dave,

Sorry, i misunderstood about this.

Ok, this patch will keep the value of CRASH_ALIGN as it is,
just move CRASH_ALIGN to header asm/kexec.h and replace the hard-coded alignment
with macro CRASH_ALIGN in function reserve_crashkernel().

Thanks,
Chen Zhou
>
>> And replace the hard-coded alignment with macro CRASH_ALIGN in function
>> reserve_crashkernel().
>>
>> Suggested-by: Dave Young <dyoung@redhat.com>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  arch/x86/include/asm/kexec.h | 3 +++
>>  arch/x86/kernel/setup.c      | 5 +----
>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/kexec.h b/arch/x86/include/asm/kexec.h
>> index 6802c59e8252..83f200dd54a1 100644
>> --- a/arch/x86/include/asm/kexec.h
>> +++ b/arch/x86/include/asm/kexec.h
>> @@ -18,6 +18,9 @@
>>  
>>  # define KEXEC_CONTROL_CODE_MAX_SIZE	2048
>>  
>> +/* 2M alignment for crash kernel regions */
>> +#define CRASH_ALIGN		SZ_2M
>> +
>>  #ifndef __ASSEMBLY__
>>  
>>  #include <linux/string.h>
>> diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
>> index 3511736fbc74..296294ad0dd8 100644
>> --- a/arch/x86/kernel/setup.c
>> +++ b/arch/x86/kernel/setup.c
>> @@ -402,9 +402,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
>>  
>>  #ifdef CONFIG_KEXEC_CORE
>>  
>> -/* 16M alignment for crash kernel regions */
>> -#define CRASH_ALIGN		SZ_16M
>> -
>>  /*
>>   * Keep the crash kernel below this limit.
>>   *
>> @@ -530,7 +527,7 @@ static void __init reserve_crashkernel(void)
>>  
>>  		start = memblock_find_in_range(crash_base,
>>  					       crash_base + crash_size,
>> -					       crash_size, 1 << 20);
>> +					       crash_size, CRASH_ALIGN);
>>  		if (start != crash_base) {
>>  			pr_info("crashkernel reservation failed - memory is in use.\n");
>>  			return;
>> -- 
>> 2.20.1
>>
> Thanks
> Dave
>
>
> .
>


