Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CD01C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:41:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53217206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 01:41:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgHRBlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 21:41:13 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:49702 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbgHRBlM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 21:41:12 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D5BE16434618C83809CA;
        Tue, 18 Aug 2020 09:41:06 +0800 (CST)
Received: from [10.174.187.22] (10.174.187.22) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.487.0; Tue, 18 Aug 2020 09:40:56 +0800
Subject: Re: [PATCH 1/2] clocksource: arm_arch_timer: Simplify and fix count
 reader code logic
To:     Marc Zyngier <maz@kernel.org>
References: <20200817122415.6568-1-zhukeqian1@huawei.com>
 <20200817122415.6568-2-zhukeqian1@huawei.com>
 <267c5f9151c39fd2dcd0ce0b09d96545@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
        Steven Price <steven.price@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <wanghaibin.wang@huawei.com>
From:   zhukeqian <zhukeqian1@huawei.com>
Message-ID: <2093b7c1-6ef4-c0ff-e9df-1f493fccdda8@huawei.com>
Date:   Tue, 18 Aug 2020 09:40:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <267c5f9151c39fd2dcd0ce0b09d96545@kernel.org>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.187.22]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/8/17 20:52, Marc Zyngier wrote:
> On 2020-08-17 13:24, Keqian Zhu wrote:
>> In commit 0ea415390cd3 (clocksource/arm_arch_timer: Use arch_timer_read_counter
>> to access stable counters), we separate stable and normal count reader. Actually
>> the stable reader can correctly lead us to normal reader if we has no
>> workaround.
> 
> Resulting in an unnecessary overhead on non-broken systems that can run
> without CONFIG_ARM_ARCH_TIMER_OOL_WORKAROUND. Not happening.
OK, so I got the purpose of that patch wrong.
> 
>> Besides, in erratum_set_next_event_tval_generic(), we use normal reader, it is
>> obviously wrong, so just revert this commit to solve this problem by the way.
> 
> If you want to fix something, post a patch that does exactly that.
> 
I will.

Thanks,
Keqian
>         M.
