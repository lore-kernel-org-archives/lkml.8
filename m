Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C54C433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3258206F4
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 08:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgEPIUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 04:20:47 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49436 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbgEPIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 04:20:46 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C9FD0778710BA671C180;
        Sat, 16 May 2020 16:20:39 +0800 (CST)
Received: from [10.166.215.145] (10.166.215.145) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Sat, 16 May 2020 16:20:36 +0800
Subject: Re: [PATCH 0/4] arm64: kgdb/kdb: Fix single-step debugging issues
To:     Doug Anderson <dianders@chromium.org>
CC:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        David Miller <davem@davemloft.net>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <liwei1412@163.com>
References: <20200509214159.19680-1-liwei391@huawei.com>
 <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
From:   "liwei (GF)" <liwei391@huawei.com>
Message-ID: <a20ee677-495b-9336-a329-eabd50dd1cad@huawei.com>
Date:   Sat, 16 May 2020 16:20:35 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xv6xgj_M9tYjHzmW4UZD2RdH2c5=dagNybSkdfBabYZw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.166.215.145]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Douglas,

On 2020/5/14 8:34, Doug Anderson wrote:
> Hi,
> 
> On Sat, May 9, 2020 at 6:49 AM Wei Li <liwei391@huawei.com> wrote:
>>
>> This patch set is to fix several issues of single-step debugging
>> in kgdb/kdb on arm64.
>>
>> It seems that these issues have been shelved a very long time,
>> but i still hope to solve them, as the single-step debugging
>> is an useful feature.
>>
>> Note:
>> Based on patch "arm64: cacheflush: Fix KGDB trap detection",
>> https://www.spinics.net/lists/arm-kernel/msg803741.html
>>
>> Wei Li (4):
>>   arm64: kgdb: Fix single-step exception handling oops
>>   arm64: Extract kprobes_save_local_irqflag() and
>>     kprobes_restore_local_irqflag()
>>   arm64: kgdb: Fix single-stepping into the irq handler wrongly
>>   arm64: kgdb: Set PSTATE.SS to 1 to reenable single-step
>>
>>  arch/arm64/include/asm/debug-monitors.h |  6 ++++++
>>  arch/arm64/kernel/debug-monitors.c      | 28 ++++++++++++++++++++++++-
>>  arch/arm64/kernel/kgdb.c                | 16 +++++++++++---
>>  arch/arm64/kernel/probes/kprobes.c      | 28 ++-----------------------
>>  4 files changed, 48 insertions(+), 30 deletions(-)
> 
> Just an overall note that I'm very happy that you posted this patch
> series!  It's always been a thorn in my side that stepping and
> breakpoints were so broken on arm64 and I'm really excited that you're
> fixing them.  Now I'll have to get in the habit of using kgdb for more
> than just debugging crashes and maybe I can use it more for exploring
> how functions work more.  :-)
> > I'll also note that with your patch series I'm even seeing the "call"
> feature of gdb working now.  That has always been terribly broken for
> me.
> 
Thanks for reviewing and testing this series.
Enjoy exploring the kernel with kgdb/kdb! :-)

Thanks,
Wei
