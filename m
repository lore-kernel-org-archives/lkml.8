Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E25CC33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E292F20730
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgAPPRx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:17:53 -0500
Received: from foss.arm.com ([217.140.110.172]:50862 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726812AbgAPPRw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:17:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C26F61396;
        Thu, 16 Jan 2020 07:17:51 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E74B3F68E;
        Thu, 16 Jan 2020 07:17:49 -0800 (PST)
Subject: Re: [PATCH v7 1/4] x86: kdump: move reserve_crashkernel_low() into
 crash_core.c
To:     Dave Young <dyoung@redhat.com>, Chen Zhou <chenzhou10@huawei.com>
Cc:     tglx@linutronix.de, mingo@redhat.com, catalin.marinas@arm.com,
        will@kernel.org, bhsharma@redhat.com, horms@verge.net.au,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        xiexiuqi@huawei.com, kbuild test robot <lkp@intel.com>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <20191223152349.180172-2-chenzhou10@huawei.com>
 <20191227055458.GA14893@dhcp-128-65.nay.redhat.com>
 <09d42854-461b-e85c-ba3f-0e1173dc95b5@huawei.com>
 <20191228093227.GA19720@dhcp-128-65.nay.redhat.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <77c971a4-608f-ee35-40cb-77186a2ddbd1@arm.com>
Date:   Thu, 16 Jan 2020 15:17:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191228093227.GA19720@dhcp-128-65.nay.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys,

On 28/12/2019 09:32, Dave Young wrote:
> On 12/27/19 at 07:04pm, Chen Zhou wrote:
>> On 2019/12/27 13:54, Dave Young wrote:
>>> On 12/23/19 at 11:23pm, Chen Zhou wrote:
>>>> In preparation for supporting reserve_crashkernel_low in arm64 as
>>>> x86_64 does, move reserve_crashkernel_low() into kernel/crash_core.c.
>>>>
>>>> Note, in arm64, we reserve low memory if and only if crashkernel=X,low
>>>> is specified. Different with x86_64, don't set low memory automatically.
>>>
>>> Do you have any reason for the difference?  I'd expect we have same
>>> logic if possible and remove some of the ifdefs.
>>
>> In x86_64, if we reserve crashkernel above 4G, then we call reserve_crashkernel_low()
>> to reserve low memory.
>>
>> In arm64, to simplify, we call reserve_crashkernel_low() at the beginning of reserve_crashkernel()
>> and then relax the arm64_dma32_phys_limit if reserve_crashkernel_low() allocated something.
>> In this case, if reserve crashkernel below 4G there will be 256M low memory set automatically
>> and this needs extra considerations.

> Sorry that I did not read the old thread details and thought that is
> arch dependent.  But rethink about that, it would be better that we can
> have same semantic about crashkernel parameters across arches.  If we
> make them different then it causes confusion, especially for
> distributions.

Surely distros also want one crashkernel* string they can use on all platforms without
having to detect the kernel version, platform or changeable memory layout...


> OTOH, I thought if we reserve high memory then the low memory should be
> needed.  There might be some exceptions, but I do not know the exact
> one,

> can we make the behavior same, and special case those systems which
> do not need low memory reservation.

Its tricky to work out which systems are the 'normal' ones.

We don't have a fixed memory layout for arm64. Some systems have no memory below 4G.
Others have no memory above 4G.

Chen Zhou's machine has some memory below 4G, but its too precious to reserve a large
chunk for kdump. Without any memory below 4G some of the drivers won't work.

I don't see what distros can set as their default for all platforms if high/low are
mutually exclusive with the 'crashkernel=' in use today. How did x86 navigate this, ... or
was it so long ago?

No one else has reported a problem with the existing placement logic, hence treating this
'low' thing as the 'in addition' special case.


>> previous discusses:
>> 	https://lkml.org/lkml/2019/6/5/670
>> 	https://lkml.org/lkml/2019/6/13/229
> 
> Another concern from James:
> "
> With both crashk_low_res and crashk_res, we end up with two entries in /proc/iomem called
> "Crash kernel". Because its sorted by address, and kexec-tools stops searching when it
> find "Crash kernel", you are always going to get the kernel placed in the lower portion.
> "
> 
> The kexec-tools code is iterating all "Crash kernel" ranges and add them
> in an array.  In X86 code, it uses the higher range to locate memory.

Then my hurried reading of what the user-space code does was wrong!

If kexec-tools places the kernel in the low region, there may not be enough memory left
for whatever purpose it was reserved for. This was the motivation for giving it a
different name.


Thanks,

James
