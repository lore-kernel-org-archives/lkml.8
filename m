Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F40FFC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7F712074B
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 14:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbgG3OMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 10:12:14 -0400
Received: from relay.sw.ru ([185.231.240.75]:33850 "EHLO relay3.sw.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728092AbgG3OMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 10:12:13 -0400
Received: from [192.168.15.64]
        by relay3.sw.ru with esmtp (Exim 4.93)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1k19Hn-0004AI-BI; Thu, 30 Jul 2020 17:11:55 +0300
Subject: Re: [PATCH 09/23] ns: Introduce ns_idr to be able to iterate all
 allocated namespaces in the system
To:     Matthew Wilcox <willy@infradead.org>
Cc:     viro@zeniv.linux.org.uk, adobriyan@gmail.com, davem@davemloft.net,
        ebiederm@xmission.com, akpm@linux-foundation.org,
        christian.brauner@ubuntu.com, areber@redhat.com, serge@hallyn.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <159611007271.535980.15362304262237658692.stgit@localhost.localdomain>
 <159611040870.535980.13460189038999722608.stgit@localhost.localdomain>
 <20200730122319.GC23808@casper.infradead.org>
 <485c01e6-a4ee-5076-878e-6303e6d8d5f3@virtuozzo.com>
 <20200730135640.GE23808@casper.infradead.org>
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
Message-ID: <1e41ae9d-9c3d-1c4a-d49e-b7f660ce99f7@virtuozzo.com>
Date:   Thu, 30 Jul 2020 17:12:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730135640.GE23808@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.07.2020 16:56, Matthew Wilcox wrote:
> On Thu, Jul 30, 2020 at 04:32:22PM +0300, Kirill Tkhai wrote:
>> On 30.07.2020 15:23, Matthew Wilcox wrote:
>>> xa_erase_irqsave();
>>
>> static inline void *xa_erase_irqsave(struct xarray *xa, unsigned long index)
>> {
>> 	unsigned long flags;
>>         void *entry;
>>
>>         xa_lock_irqsave(xa, flags);
>>         entry = __xa_erase(xa, index);
>>         xa_unlock_irqrestore(xa, flags);
>>
>>         return entry;
>> }
> 
> was there a question here?

No, I just I will add this in separate patch.
 
>>>> +struct ns_common *ns_get_next(unsigned int *id)
>>>> +{
>>>> +	struct ns_common *ns;
>>>> +
>>>> +	if (*id < PROC_NS_MIN_INO - 1)
>>>> +		*id = PROC_NS_MIN_INO - 1;
>>>> +
>>>> +	*id += 1;
>>>> +	*id -= PROC_NS_MIN_INO;
>>>> +
>>>> +	rcu_read_lock();
>>>> +	do {
>>>> +		ns = idr_get_next(&ns_idr, id);
>>>> +		if (!ns)
>>>> +			break;
>>>
>>> xa_find_after();
>>>
>>> You'll want a temporary unsigned long to work with ...
>>>
>>>> +		if (!refcount_inc_not_zero(&ns->count)) {
>>>> +			ns = NULL;
>>>> +			*id += 1;
>>>
>>> you won't need this increment.
>>
>> Why? I don't see a way xarray allows to avoid this.
> 
> It's embedded in xa_find_after().
 
How is it embedded to check ns->count that it knows nothing?
