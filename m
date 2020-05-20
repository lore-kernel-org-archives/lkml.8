Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC85CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD11A20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 03:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbgETDav (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 23:30:51 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:42586 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbgETDau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 23:30:50 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id BF96A762C7016041C142;
        Wed, 20 May 2020 11:30:48 +0800 (CST)
Received: from [127.0.0.1] (10.166.213.90) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Wed, 20 May 2020
 11:30:45 +0800
Subject: Re: [PATCH v7 0/4] support reserving crashkernel above 4G on arm64
 kdump
To:     Arnd Bergmann <arnd@arndb.de>
References: <20191223152349.180172-1-chenzhou10@huawei.com>
 <a57d46bc-881e-3526-91ca-558bf64e2aa8@huawei.com>
 <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Dave Young <dyoung@redhat.com>,
        "Bhupesh Sharma" <bhsharma@redhat.com>,
        <john.p.donnelly@oracle.com>, <pkushwaha@marvell.com>,
        Simon Horman <horms@verge.net.au>, <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
From:   chenzhou <chenzhou10@huawei.com>
Message-ID: <e35e37f2-bcb3-cc19-d506-18f576dcbfb9@huawei.com>
Date:   Wed, 20 May 2020 11:30:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2VrAqefPYF2JqRjwdhgTDtORUgWgVuYxRYWqKxE3+5pA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.213.90]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On 2020/5/19 18:21, Arnd Bergmann wrote:
> On Thu, Mar 26, 2020 at 4:10 AM Chen Zhou <chenzhou10@huawei.com> wrote:
>> Hi all,
>>
>> Friendly ping...
> I was asked about this patch series, and see that you last posted it in
> December. I think you should rebase it to linux-5.7-rc6 and post the
> entire series again to make progress, as it's unlikely that any maintainer
> would pick up the patches from last year.
>
> For the contents, everything seems reasonable to me, but I noticed that
> you are adding a property to the /chosen node without adding the
> corresponding documentation to
> Documentation/devicetree/bindings/chosen.txt
>
> Please add that, and Cc the devicetree maintainers on the updated
> patch.
>
>          Arnd

Thanks for your review and comments, i will rebase it to linux-5.7-rc6 and add the
corresponding documentation.

Thanks,
Chen Zhou

>> On 2019/12/23 23:23, Chen Zhou wrote:
>>> This patch series enable reserving crashkernel above 4G in arm64.
>>>
>>> There are following issues in arm64 kdump:
>>> 1. We use crashkernel=X to reserve crashkernel below 4G, which will fail
>>> when there is no enough low memory.
>>> 2. Currently, crashkernel=Y@X can be used to reserve crashkernel above 4G,
>>> in this case, if swiotlb or DMA buffers are required, crash dump kernel
>>> will boot failure because there is no low memory available for allocation.
>>>
>>> The previous changes and discussions can be retrieved from:
>>>
>>> Changes since [v6]
>>> - Fix build errors reported by kbuild test robot.
> ...
>
> .
>


