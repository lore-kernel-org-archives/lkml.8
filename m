Return-Path: <SRS0=eufF=BE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0F0DC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15E7206C1
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jul 2020 05:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgGYFXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 01:23:30 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:50262 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725874AbgGYFX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 01:23:29 -0400
Received: from fsav109.sakura.ne.jp (fsav109.sakura.ne.jp [27.133.134.236])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 06P5NR7e089533;
        Sat, 25 Jul 2020 14:23:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav109.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp);
 Sat, 25 Jul 2020 14:23:27 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav109.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 06P5NRmR089529
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Sat, 25 Jul 2020 14:23:27 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [PATCH] lockdep: Introduce CONFIG_LOCKDEP_LARGE
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+62ebe501c1ce9a91f68c@syzkaller.appspotmail.com>,
        syzbot <syzbot+91fd909b6e62ebe06131@syzkaller.appspotmail.com>,
        syzbot <syzbot+cd0ec5211ac07c18c049@syzkaller.appspotmail.com>
References: <1595640639-9310-1-git-send-email-penguin-kernel@I-love.SAKURA.ne.jp>
 <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <46674d71-1e41-cb68-ed99-72c25a73dfef@i-love.sakura.ne.jp>
Date:   Sat, 25 Jul 2020 14:23:25 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+YXT9iLij-AbrUwj=yPq-YNFw=Au9g0LQJCKwYonaHCDQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/07/25 13:48, Dmitry Vyukov wrote:
>> diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
>> index 29a8de4..85ba7eb 100644
>> --- a/kernel/locking/lockdep.c
>> +++ b/kernel/locking/lockdep.c
>> @@ -1349,7 +1349,11 @@ static int add_lock_to_list(struct lock_class *this,
>>  /*
>>   * For good efficiency of modular, we use power of 2
>>   */
>> +#ifdef CONFIG_LOCKDEP_LARGE
>> +#define MAX_CIRCULAR_QUEUE_SIZE                8192UL
>> +#else
>>  #define MAX_CIRCULAR_QUEUE_SIZE                4096UL
> 
> Maybe this number should be the config value? So that we don't ever
> return here to introduce "VERY_LARGE" :)

They can be "tiny, small, medium, compact, large and huge". Yeah, it's a joke. :-)

> Also somebody may use it to _reduce_ size of the table for a smaller kernel.

Maybe. But my feeling is that it is very rare that the kernel actually deadlocks
as soon as lockdep warned the possibility of deadlock.

Since syzbot runs many instances in parallel, a lot of CPU resource is spent for
checking the same dependency tree. However, the possibility of deadlock can be
warned for only locks held within each kernel boot, and it is impossible to hold
all locks with one kernel boot.

Then, it might be nice if lockdep can audit only "which lock was held from which
context and what backtrace" and export that log like KCOV data (instead of evaluating
the possibility of deadlock), and rebuild the whole dependency (and evaluate the
possibility of deadlock) across multiple kernel boots in userspace.

> 
>> +#endif
>>  #define CQ_MASK                                (MAX_CIRCULAR_QUEUE_SIZE-1)

