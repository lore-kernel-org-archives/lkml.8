Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E34BC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB13F20748
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 03:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEVDYZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 23:24:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5272 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727024AbgEVDYY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 23:24:24 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 51717A9057906BA0EFA3;
        Fri, 22 May 2020 11:24:22 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.90) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Fri, 22 May 2020
 11:24:12 +0800
Subject: Re: [PATCH v8 5/5] dt-bindings: chosen: Document
 linux,low-memory-range for arm64 kdump
To:     Rob Herring <robh+dt@kernel.org>
References: <20200521093805.64398-1-chenzhou10@huawei.com>
 <20200521093805.64398-6-chenzhou10@huawei.com>
 <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        <John.p.donnelly@oracle.com>, <pkushwaha@marvell.com>,
        "Simon Horman" <horms@verge.net.au>,
        Hanjun Guo <guohanjun@huawei.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        "Linux Doc Mailing List" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <kexec@lists.infradead.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <a419602e-6a85-ca35-39de-b3c26d433199@huawei.com>
Date:   Fri, 22 May 2020 11:24:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+EV02YBqEGoJrsJW8Y+g_GkB_LkTwWCxNCb3F+8MSdyw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 2020/5/21 21:29, Rob Herring wrote:
> On Thu, May 21, 2020 at 3:35 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>> Add documentation for DT property used by arm64 kdump:
>> linux,low-memory-range.
>> "linux,low-memory-range" is an another memory region used for crash
>> dump kernel devices.
>>
>> Signed-off-by: Chen Zhou <chenzhou10@huawei.com>
>> ---
>>  Documentation/devicetree/bindings/chosen.txt | 25 ++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
> chosen is now a schema documented here[1].
Ok, that is, i don't need to modify the doc in kernel, just create a pull request in github [1]?

>
>> diff --git a/Documentation/devicetree/bindings/chosen.txt b/Documentation/devicetree/bindings/chosen.txt
>> index 45e79172a646..bfe6fb6976e6 100644
>> --- a/Documentation/devicetree/bindings/chosen.txt
>> +++ b/Documentation/devicetree/bindings/chosen.txt
>> @@ -103,6 +103,31 @@ While this property does not represent a real hardware, the address
>>  and the size are expressed in #address-cells and #size-cells,
>>  respectively, of the root node.
>>
>> +linux,low-memory-range
>> +----------------------
>> +This property (arm64 only) holds a base address and size, describing a
>> +limited region below 4G. Similar to "linux,usable-memory-range", it is
>> +an another memory range which may be considered available for use by the
>> +kernel.
> Why can't you just add a range to "linux,usable-memory-range"? It
> shouldn't be hard to figure out which part is below 4G.
I did like this in my previous version, such as v5. After discussed with James, i modified it to the current way.

We think the existing behavior should be unchanged, which helps with keeping compatibility with existing
user-space and older kdump kernels.

The comments from James:
> linux,usable-memory-range = <BASE1 SIZE1 [BASE2 SIZE2]>.
Won't this break if your kdump kernel doesn't know what the extra parameters are?
Or if it expects two ranges, but only gets one? These DT properties should be treated as
ABI between kernel versions, we can't really change it like this.

I think the 'low' region is an optional-extra, that is never mapped by the first kernel. I
think the simplest thing to do is to add an 'linux,low-memory-range' that we
memblock_add() after memblock_cap_memory_range() has been called.
If its missing, or the new kernel doesn't know what its for, everything keeps working.

previous discusses:
https://lkml.org/lkml/2019/6/5/674
https://lkml.org/lkml/2019/6/13/229

Thanks,
Chen Zhou

>
> Rob
>
> [1] https://github.com/devicetree-org/dt-schema/blob/master/schemas/chosen.yaml
>
> .
>


