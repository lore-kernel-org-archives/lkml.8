Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF76C47247
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:02:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D436E215A4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 10:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbgEHKCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 06:02:04 -0400
Received: from relay.sw.ru ([185.231.240.75]:59018 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgEHKCD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 06:02:03 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jWzp5-0004Tv-Er; Fri, 08 May 2020 13:01:39 +0300
Subject: Re: [PATCH] ipc/util.c: sysvipc_find_ipc() incorrectly updates
 position index
From:   Vasily Averin <vvs@virtuozzo.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        Andreas Schwab <schwab@suse.de>
References: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
 <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
 <20200507170242.6cbb88ae672deed67152e221@linux-foundation.org>
 <20200508033625.GO16070@bombadil.infradead.org>
 <e25e5a42-159c-6bad-4f14-d70461a78b72@virtuozzo.com>
Message-ID: <c89b587a-b570-2a11-3001-d1c8444f3a2f@virtuozzo.com>
Date:   Fri, 8 May 2020 13:01:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <e25e5a42-159c-6bad-4f14-d70461a78b72@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/8/20 9:07 AM, Vasily Averin wrote:
> On 5/8/20 6:36 AM, Matthew Wilcox wrote:
>> On Thu, May 07, 2020 at 05:02:42PM -0700, Andrew Morton wrote:
>>> Here's how I resolved things.  Please check?
>>>
>>> static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>>> 					      loff_t *new_pos)
>>> {
>>> 	unsigned long index = pos;
>>> 	struct kern_ipc_perm *ipc;
>>>
>>> 	rcu_read_lock();
>>> 	ipc = xa_find(&ids->ipcs, &index, ULONG_MAX, XA_PRESENT);
>>> 	if (ipc)
>>> 		ipc_lock_object(ipc);
>>> 	else
>>> 		rcu_read_unlock();
>>> 	*new_pos = pos + 1;
>>> 	return ipc;
>>> }
>>
>> Surely that should be '*new_pos = index + 1'?  Or did I misunderstand
>> the reasoning behind the other patch?
> 
> I'm not sure however it looks like xa_find() can return index < pos
it seems, I was wrong here.
So I'm agree with Matthew, '*new_pos = index + 1' should be used.

Thank you,
	Vasily Averin
