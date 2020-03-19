Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4121C4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C9820714
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 06:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCSGPE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 02:15:04 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:11719 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725787AbgCSGPE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 02:15:04 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C1409E9F6CAAF9054A0E;
        Thu, 19 Mar 2020 14:15:00 +0800 (CST)
Received: from [127.0.0.1] (10.173.221.207) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Thu, 19 Mar 2020
 14:14:56 +0800
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
To:     Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
 <20200317124323.GA16200@willie-the-truck>
 <20200317135719.GH3971@sirena.org.uk>
 <20200317151813.GA16579@willie-the-truck>
 <20200317163638.GI3971@sirena.org.uk>
 <20200317210154.GA19752@willie-the-truck>
 <20200318113217.GA4553@sirena.org.uk>
 <20200318201259.GA7463@willie-the-truck>
From:   Hongbo Yao <yaohongbo@huawei.com>
Message-ID: <c94aef1e-7ed7-6902-a16c-d64e5280fb01@huawei.com>
Date:   Thu, 19 Mar 2020 14:14:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200318201259.GA7463@willie-the-truck>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.221.207]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/19 4:13, Will Deacon wrote:
> On Wed, Mar 18, 2020 at 11:32:17AM +0000, Mark Brown wrote:
>> On Tue, Mar 17, 2020 at 09:01:54PM +0000, Will Deacon wrote:
>>> On Tue, Mar 17, 2020 at 04:36:38PM +0000, Mark Brown wrote:
>>
>>>> I'd need to go back and retest to confirm but it looks like always had
>>>> the issue that we'd install some nG mappings early even with KPTI
>>>> disabled on the command line so your change is just restoring the
>>>> previous behaviour and we're no worse than we were before.
>>
>>> Urgh, this code brings back really bad memories :( :( :(
>>
>> Tell me about it.
>>
>>> So I've hacked the following, which appears to work but damn I'd like
>>> somebody else to look at this. I also have a nagging feeling that you
>>> implemented it like this at some point, but we tried to consolidate things
>>> during review.
>>
>>> Thoughts?
>>
>> I don't think I did *exactly* this but it's familiar yeah.  It looks
>> sensible and I can't think of any problems but that doesn't mean there
>> aren't any.
> 
> Well, thanks for having a look!
> 
> Hongbo -- please can you confirm that this fixes the problem that you are
> seeing?
Hi, Will,
Sorry for the late response.

This fixes the problem for me.
Tested-by: Hongbo Yao <yaohongbo@huawei.com>

Thanks,
Hongbo.

> Will
> 
> .
> 

