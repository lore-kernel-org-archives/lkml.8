Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD48C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01B1320786
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 13:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390698AbgFXNIe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 09:08:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47520 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728843AbgFXNIe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 09:08:34 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C4F51F1;
        Wed, 24 Jun 2020 06:08:33 -0700 (PDT)
Received: from [10.57.9.128] (unknown [10.57.9.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E89FE3F6CF;
        Wed, 24 Jun 2020 06:08:31 -0700 (PDT)
Subject: Re: [RFC PATCH] perf/smmuv3: Fix shared interrupt handling
To:     Will Deacon <will@kernel.org>
Cc:     mark.rutland@arm.com, tuanphan@os.amperecomputing.com,
        john.garry@huawei.com, linux-kernel@vger.kernel.org,
        shameerali.kolothum.thodi@huawei.com, harb@amperecomputing.com,
        linux-arm-kernel@lists.infradead.org
References: <d73dd8c3579fbf713d6215317404549aede8ad2d.1586363449.git.robin.murphy@arm.com>
 <b7d056f7-3a3d-568d-ea6d-24bb30b4761b@arm.com>
 <20200624125045.GC6270@willie-the-truck>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <dfa3fc60-dc6c-4ede-341e-24645e01b722@arm.com>
Date:   Wed, 24 Jun 2020 14:08:30 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200624125045.GC6270@willie-the-truck>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-24 13:50, Will Deacon wrote:
> On Wed, Jun 24, 2020 at 12:48:14PM +0100, Robin Murphy wrote:
>> On 2020-04-08 17:49, Robin Murphy wrote:
>>> IRQF_SHARED is dangerous, since it allows other agents to retarget the
>>> IRQ's affinity without migrating PMU contexts to match, breaking the way
>>> in which perf manages mutual exclusion for accessing events. Although
>>> this means it's not realistically possible to support PMU IRQs being
>>> shared with other drivers, we *can* handle sharing between multiple PMU
>>> instances with some explicit affinity bookkeeping and manual interrupt
>>> multiplexing.
>>>
>>> RCU helps us handle interrupts efficiently without having to worry about
>>> fine-grained locking for relatively-theoretical race conditions with the
>>> probe/remove/CPU hotplug slow paths. The resulting machinery ends up
>>> looking largely generic, so it should be feasible to factor out with a
>>> "system PMU" base class for similar multi-instance drivers.
>>>
>>> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
>>> ---
>>>
>>> RFC because I don't have the means to test it, and if the general
>>> approach passes muster then I'd want to tackle the aforementioned
>>> factoring-out before merging anything anyway.
>>
>> Any comments on whether it's worth pursuing this?
> 
> Sorry, I don't really get the problem that it's solving. Is there a crash
> log somewhere I can look at? If all the users of the IRQ are managed by
> this driver, why is IRQF_SHARED dangerous?

Because as-is, multiple PMU instances may make different choices about 
which CPU they associate with, change the shared IRQ affinity behind 
each others' backs, and break the "IRQ handler runs on event->cpu" 
assumption that perf core relies on for correctness. I'm not sure how 
likely it would be to actually crash rather than just lead to subtle 
nastiness, but wither way it's not good, and since people seem to be 
tempted to wire up system PMU instances this way we could do with a 
general approach for dealing with it.

Robin.
