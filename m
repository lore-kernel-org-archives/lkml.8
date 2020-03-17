Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F1DC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:41:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C84BD20679
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 01:41:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbgCQBlb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 21:41:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726597AbgCQBlb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 21:41:31 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 85B2E639728DADF0C2D2;
        Tue, 17 Mar 2020 09:41:29 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Tue, 17 Mar 2020
 09:41:29 +0800
Subject: Re: [locks] 6d390e4b5d: will-it-scale.per_process_ops -96.6%
 regression
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jeff Layton <jlayton@kernel.org>
CC:     NeilBrown <neilb@suse.de>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>,
        Bruce Fields <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <20200308140314.GQ5972@shao2-debian>
 <c4ef31a663fbf7a3de349696e9f00f2f5c4ec89a.camel@kernel.org>
 <875zfbvrbm.fsf@notabene.neil.brown.name>
 <CAHk-=wg8N4fDRC3M21QJokoU+TQrdnv7HqoaFW-Z-ZT8z_Bi7Q@mail.gmail.com>
 <0066a9f150a55c13fcc750f6e657deae4ebdef97.camel@kernel.org>
 <CAHk-=whUgeZGcs5YAfZa07BYKNDCNO=xr4wT6JLATJTpX0bjGg@mail.gmail.com>
 <87v9nattul.fsf@notabene.neil.brown.name>
 <CAHk-=wiNoAk8v3GrbK3=q6KRBrhLrTafTmWmAo6-up6Ce9fp6A@mail.gmail.com>
 <87o8t2tc9s.fsf@notabene.neil.brown.name>
 <CAHk-=wj5jOYxjZSUNu_jdJ0zafRS66wcD-4H0vpQS=a14rS8jw@mail.gmail.com>
 <f000e352d9e103b3ade3506aac225920420d2323.camel@kernel.org>
 <877dznu0pk.fsf@notabene.neil.brown.name>
 <CAHk-=whYQqtW6B7oPmPr9-PXwyqUneF4sSFE+o3=7QcENstE-g@mail.gmail.com>
 <b5a1bb4c4494a370f915af479bcdf8b3b351eb6d.camel@kernel.org>
 <87pndcsxc6.fsf@notabene.neil.brown.name>
 <ce48ed9e48eda3c0f27d2f417314bd00cb1a68db.camel@kernel.org>
 <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <7c8d3752-6573-ab83-d0af-f3dd4fc373f5@huawei.com>
Date:   Tue, 17 Mar 2020 09:41:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <CAHk-=whnqDS0NJtAaArVeYQz3hcU=4Ja3auB1Jvs42eADfUgMQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2020/3/17 1:26, Linus Torvalds wrote:
> On Mon, Mar 16, 2020 at 4:07 AM Jeff Layton <jlayton@kernel.org> wrote:
>>
>>
>> +       /*
>> +        * If fl_blocker is NULL, it won't be set again as this thread "owns"
>> +        * the lock and is the only one that might try to claim the lock.
>> +        * Because fl_blocker is explicitly set last during a delete, it's
>> +        * safe to locklessly test to see if it's NULL. If it is, then we know
>> +        * that no new locks can be inserted into its fl_blocked_requests list,
>> +        * and we can therefore avoid doing anything further as long as that
>> +        * list is empty.
>> +        */
>> +       if (!smp_load_acquire(&waiter->fl_blocker) &&
>> +           list_empty(&waiter->fl_blocked_requests))
>> +               return status;
> 
> Ack. This looks sane to me now.
> 
> yangerkun - how did you find the original problem?\

While try to fix CVE-2019-19769, add some log in __locks_wake_up_blocks 
help me to rebuild the problem soon. This help me to discern the problem 
soon.

> 
> Would you mind using whatever stress test that caused commit
> 6d390e4b5d48 ("locks: fix a potential use-after-free problem when
> wakeup a waiter") with this patch? And if you did it analytically,
> you're a champ and should look at this patch too!

I will try to understand this patch, and if it's looks good to me, will 
do the performance test!

Thanks

