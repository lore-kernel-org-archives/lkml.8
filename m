Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5F49C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8560E206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:03:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730901AbgEKRDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:03:34 -0400
Received: from foss.arm.com ([217.140.110.172]:36284 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730743AbgEKRDa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:03:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C417E30E;
        Mon, 11 May 2020 10:03:29 -0700 (PDT)
Received: from [192.168.0.7] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A84C53F305;
        Mon, 11 May 2020 10:03:28 -0700 (PDT)
Subject: Re: [PATCH v2] sched/fair: Fix enqueue_task_fair warning some more
To:     Tao Zhou <ouwen210@hotmail.com>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Phil Auld <pauld@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
References: <20200506141821.GA9773@lorien.usersys.redhat.com>
 <20200507203612.GF19331@lorien.usersys.redhat.com>
 <20200508151515.GA25974@geo.homenetwork>
 <CAKfTPtCeA1VcEierR5iyQJApU5JMFQqkMSR+2JGU4o5cG76opQ@mail.gmail.com>
 <20200508170213.GA27353@geo.homenetwork>
 <801229de-200d-c9d5-7fd3-8556c5abc064@arm.com>
 <CAKfTPtAq9GDgvok5Z87mHL++ie+tiuyHHnruGea1+jvfffzpvw@mail.gmail.com>
 <b452358a-afca-ce3f-ec56-cf194a0b6a50@arm.com>
 <BL0PR14MB3779ED5E2E5AD157B58D002C9AA10@BL0PR14MB3779.namprd14.prod.outlook.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <8300e553-a90f-3708-8a65-4f906ad5c807@arm.com>
Date:   Mon, 11 May 2020 19:03:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <BL0PR14MB3779ED5E2E5AD157B58D002C9AA10@BL0PR14MB3779.namprd14.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On 11/05/2020 17:44, Tao Zhou wrote:
> Hi Dietmar,

[...]

> On Mon, May 11, 2020 at 12:39:52PM +0200, Dietmar Eggemann wrote:
>> On 11/05/2020 11:36, Vincent Guittot wrote:
>>> On Mon, 11 May 2020 at 10:40, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 08/05/2020 19:02, Tao Zhou wrote:
>>>>> On Fri, May 08, 2020 at 05:27:44PM +0200, Vincent Guittot wrote:
>>>>>> On Fri, 8 May 2020 at 17:12, Tao Zhou <zohooouoto@zoho.com.cn> wrote:
>>>>>>>
>>>>>>> Hi Phil,
>>>>>>>
>>>>>>> On Thu, May 07, 2020 at 04:36:12PM -0400, Phil Auld wrote:
>>>>>>>> sched/fair: Fix enqueue_task_fair warning some more

[...]

>> I don't grasp how can cfs_a->on_list=1, when cfs_a is throttled and
>> cfs_b, cfs_c are in a throttled hierarchy?
> 
> I remember that Vincent explained that in this thread:
> 
> https://lore.kernel.org/lkml/CAKfTPtDxE32RrTusYTBUcwYoJFvadLLaMUp7gOsXdj_zQcaWdA@mail.gmail.com/
> 
> This was what I confused also. When enqueue one task, the throttled
> cfs_rq may be added back to the leaf_cfs_rq list.

As long as we only consider one hierarchy than I can't see how we can
enqueue a task and hit cfs_a->on_list=1 on a throttled cfs_a.

But there might be a cfs_b' (another child of cfs_a) sub hierarchy which
had a task enqueue just before and this set cfs_a->on_list=1.

Tried to read the email you pointed at carefully but can't see it there
... pretty tired right now, maybe tomorrow?
