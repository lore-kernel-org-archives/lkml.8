Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD3DC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11C6D21D81
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 22:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIIWNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 18:13:52 -0400
Received: from mx2.suse.de ([195.135.220.15]:48672 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726726AbgIIWNu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 18:13:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B20C3ACDF;
        Wed,  9 Sep 2020 22:14:04 +0000 (UTC)
Subject: Re: [PATCH v2] mm/vmscan: fix infinite loop in drop_slab_node
To:     Matthew Wilcox <willy@infradead.org>,
        Chris Down <chris@chrisdown.name>
Cc:     zangchunxin@bytedance.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
References: <20200909152047.27905-1-zangchunxin@bytedance.com>
 <16906d44-9e3c-76a1-f1a9-ced61e865467@suse.cz>
 <20200909214724.GA1577471@chrisdown.name>
 <20200909215209.GP6583@casper.infradead.org>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <4e022a8c-68da-a322-4101-926a0bb9d44b@suse.cz>
Date:   Thu, 10 Sep 2020 00:13:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200909215209.GP6583@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/20 11:52 PM, Matthew Wilcox wrote:
> On Wed, Sep 09, 2020 at 10:47:24PM +0100, Chris Down wrote:
>> Vlastimil Babka writes:
>> > - Exit also on other signals such as SIGABRT, SIGTERM? If I write to drop_caches
>> > and think it's too long, I would prefer to kill it by ctrl-c and not just kill
>> 
>> Oh dear, fatal_signal_pending() doesn't consider cases with no more
>> userspace instructions due to SIG_DFL on TERM/INT etc, that seems misleading
>> :-( I had (naively) believed it internally checks the same set as
>> TASK_KILLABLE.
>> 
>> Chuxin, Muchun, can you please make it work using TASK_KILLABLE in a similar
>> way to how schedule_timeout_killable and friends do it instead, so that
>> other signals will be caught?
> 
> You're mistaken.

Ah actually it was me who thought fatal_signal_pending() was only for SIGKILL,
OOM and whatnot. Sorry for the noise.

>         if (sig_fatal(p, sig) &&
>             !(signal->flags & SIGNAL_GROUP_EXIT) &&
>             !sigismember(&t->real_blocked, sig) &&
>             (sig == SIGKILL || !p->ptrace)) {
> ...
>                                 sigaddset(&t->pending.signal, SIGKILL);
> 
> static inline int __fatal_signal_pending(struct task_struct *p)
> {
>         return unlikely(sigismember(&p->pending.signal, SIGKILL));
> }
> 

