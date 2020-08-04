Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9443C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:38:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A74912065C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 14:38:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729163AbgHDOhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 10:37:20 -0400
Received: from relay.sw.ru ([185.231.240.75]:42122 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729100AbgHDOhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 10:37:02 -0400
Received: from [192.168.15.159]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k2y3L-00062b-9B; Tue, 04 Aug 2020 17:36:31 +0300
Subject: Re: [PATCH 1/8] ns: Add common refcount into ns_common add use it as
 counter for net_ns
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     christian.brauner@ubuntu.com, akpm@linux-foundation.org,
        viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        linux-kernel@vger.kernel.org
References: <159644958332.604812.13004003379291842292.stgit@localhost.localdomain>
 <159644977635.604812.1319877322927063560.stgit@localhost.localdomain>
 <875z9ysit5.fsf@x220.int.ebiederm.org>
 <49106051-be26-7b89-f9e8-7c441dbda18a@virtuozzo.com>
 <87sgd2o6vt.fsf@x220.int.ebiederm.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <6f6f9989-9cde-f93a-ad0a-311f264398f0@virtuozzo.com>
Date:   Tue, 4 Aug 2020 17:36:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <87sgd2o6vt.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04.08.2020 16:52, Eric W. Biederman wrote:
> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
> 
>> On 04.08.2020 15:21, Eric W. Biederman wrote:
>>> Kirill Tkhai <ktkhai@virtuozzo.com> writes:
>>>
>>>> Currently, every type of namespaces has its own counter,
>>>> which is stored in ns-specific part. Say, @net has
>>>> struct net::count, @pid has struct pid_namespace::kref, etc.
>>>>
>>>> This patchset introduces unified counter for all types
>>>> of namespaces, and converts net namespace to use it first.
>>>
>>> And the other refcounts on struct net?
>>>
>>> How do they play into what you are trying to do?
>>
>> I just don't understand you. Different refcounters are related to different
>> problems, they are introduced to solve. This patchset changes only one refcounter,
>> and it does not touch other of them. What do you want to know about others?
>>
> 
> Why net::count not net::passive?  What problem are you trying to solve?

net::count is a counter, which indicates whether net is alive and still
initilized. net::passive does not guarantees that net has not been
deinitialized yet.

The same with another namespaces. All of merged counters indicate
that a namespace is alive and initialized. So, we merge them by this property.

> They both are reference counts on the network namespace.
> 
> I don't understand what you are trying to do, other than take a bunch of
> things that look similar and squash them all together.
> 
> What semantics does this magical common reference count have?
> Why is it better for the count to live in ns_common rather than it
> it's own dedicated field of struct net?

The only visible current effect is better readability and better
debugability with, say, crash on kernel dump.

> Given that decrementing still requires code per namespace to handle
> the count going to zero.  How does this benefit anyone?

Since namespaces are different by type, they require different destructors.
Generic counter can't solve any problem, the namespaces can address.

> Has the effect of cache line placement of the move of the reference
> count been considered?

I don't see any performance impact during namespace creation/destruction
test.

> All I see in the patch in question is switching a location that the
> count lives.  Which does not seem useful to me.
> 
> I am not fundamentally oppossed but I don't see the point.  At this
> point it looks like you are making things harder to maintain by making
> things common that are merely similar
