Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62897C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F05F21835
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 17:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAVReh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 12:34:37 -0500
Received: from foss.arm.com ([217.140.110.172]:58924 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727816AbgAVReh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 12:34:37 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C97D21FB;
        Wed, 22 Jan 2020 09:34:36 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1D233F6C4;
        Wed, 22 Jan 2020 09:34:35 -0800 (PST)
Subject: Re: [Patch v3 2/3] iommu: optimize iova_magazine_free_pfns()
To:     Cong Wang <xiyou.wangcong@gmail.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        John Garry <john.garry@huawei.com>
References: <20191218043951.10534-1-xiyou.wangcong@gmail.com>
 <20191218043951.10534-3-xiyou.wangcong@gmail.com>
 <8ce2f5b6-74e1-9a74-fd80-9ad688beb9b2@arm.com>
 <CAM_iQpXbjf8MuL17kZhxawXYBJm6t5-ho77F_VWR30L-9FS4Kg@mail.gmail.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <e8789016-858a-b354-aa98-637e1d453fc3@arm.com>
Date:   Wed, 22 Jan 2020 17:34:31 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CAM_iQpXbjf8MuL17kZhxawXYBJm6t5-ho77F_VWR30L-9FS4Kg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/2020 5:29 pm, Cong Wang wrote:
> On Tue, Jan 21, 2020 at 1:52 AM Robin Murphy <robin.murphy@arm.com> wrote:
>>
>> On 18/12/2019 4:39 am, Cong Wang wrote:
>>> If the magazine is empty, iova_magazine_free_pfns() should
>>> be a nop, however it misses the case of mag->size==0. So we
>>> should just call iova_magazine_empty().
>>>
>>> This should reduce the contention on iovad->iova_rbtree_lock
>>> a little bit, not much at all.
>>
>> Have you measured that in any way? AFAICS the only time this can get
>> called with a non-full magazine is in the CPU hotplug callback, where
>> the impact of taking the rbtree lock and immediately releasing it seems
>> unlikely to be significant on top of everything else involved in that
>> operation.
> 
> This patchset is only tested as a whole, it is not easy to deploy
> each to production and test it separately.
> 
> Is there anything wrong to optimize a CPU hotplug path? :) And,
> it is called in alloc_iova_fast() too when, for example, over-cached.

And if the IOVA space is consumed to the point that we've fallen back to 
that desperate last resort, what do you think the chances are that a 
significant number of percpu magazines will be *empty*? Also bear in 
mind that in that case we've already walked the rbtree once, so any 
notion of still being fast is long, long gone.

As for CPU hotplug, it's a comparatively rare event involving all manner 
of system-wide synchronisation, and the "optimisation" of shaving a few 
dozen CPU cycles off at one point *if* things happen to line up 
correctly is taking a cup of water out of a lake. If the domain is busy 
at the time, then once again chances are the magazines aren't empty and 
having an extra check redundant with the loop condition simply adds 
(trivial, but nonzero) overhead to every call. And if the domain isn't 
busy, then the lock is unlikely to be contended anyway.

Sorry, but without convincing evidence, this change just looks like 
churn for the sake of it.

Robin.
