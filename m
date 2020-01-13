Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC5D4C33CA9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0FA2206DA
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 16:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgAMQCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 11:02:15 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40005 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728650AbgAMQCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 11:02:15 -0500
Received: by mail-pj1-f66.google.com with SMTP id bg7so4452519pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jan 2020 08:02:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jPhzziPcXw+kQ4qYAw+8rAi/yrPBcu23BsMPHcjLs80=;
        b=C0Y/LHSSe2TU+4uu9q0rnjwO6ObCBrntnRlBbaSJd7Yr9HoDu5eIwdmXkkOG3ciJCU
         hxLmK+BIiY1WpunxZ7Dqea8iNZlpR6+Wb4pErefbIIJitMvRiFozTYyTKfjUaQCzW/Xs
         al9VGqCuXz3JWyGuzzbzjn7lMZn46i+CtiRwAyQXWsFti9PDenzHEnHeRMXqyR0eWGHP
         dsG1zQAjRPijNyEH1HbhN92PaccVXqDnNEVGyRzuF6s/3TgHU23lLZoHVer3s3/qT8LA
         krTJDc7bPk5MUp8LHIBqJdFgf2mHsCxCvu3/zCsWAZYibax6FzAq+t2i8oM3TPXGnU+r
         SR3w==
X-Gm-Message-State: APjAAAWjj8KHASgjZm16Pc+r5esN5S/nbafdRxu6nfldQygNLKAx4qhS
        UGP5nkxdEWR3CsszsmEMrQRpRtnU
X-Google-Smtp-Source: APXvYqwSkzgTJ3WWc0cSZTc2gfV/cjMZCsY8kvE0jk+bx/pXUcI/idcTd2EFZhl/tpEvWw9i8KurXQ==
X-Received: by 2002:a17:902:7602:: with SMTP id k2mr20931413pll.34.1578931333180;
        Mon, 13 Jan 2020 08:02:13 -0800 (PST)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id 65sm15063826pfu.140.2020.01.13.08.02.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2020 08:02:12 -0800 (PST)
Subject: Re: [PATCH v2 1/6] locking/lockdep: Track number of zapped classes
To:     Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org
References: <20191216151517.7060-1-longman@redhat.com>
 <20191216151517.7060-2-longman@redhat.com>
 <20200113145542.GV2844@hirez.programming.kicks-ass.net>
 <137a3e75-ca3c-2222-d2af-a6b7bb692b66@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2e9d25b1-f61a-2367-36f3-7b39a9cca095@acm.org>
Date:   Mon, 13 Jan 2020 08:02:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <137a3e75-ca3c-2222-d2af-a6b7bb692b66@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/13/20 6:58 AM, Waiman Long wrote:
> On 1/13/20 9:55 AM, Peter Zijlstra wrote:
>> On Mon, Dec 16, 2019 at 10:15:12AM -0500, Waiman Long wrote:
>>> The whole point of the lockdep dynamic key patch is to allow unused
>>> locks to be removed from the lockdep data buffers so that existing
>>> buffer space can be reused. However, there is no way to find out how
>>> many unused locks are zapped and so we don't know if the zapping process
>>> is working properly.
>>>
>>> Add a new nr_zapped_classes variable to track that and show it in
>>> /proc/lockdep_stats if it is non-zero.
>>>
>>> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
>>> index dadb7b7fba37..d98d349bb648 100644
>>> --- a/kernel/locking/lockdep_proc.c
>>> +++ b/kernel/locking/lockdep_proc.c
>>> @@ -336,6 +336,15 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
>>>   	seq_printf(m, " debug_locks:                   %11u\n",
>>>   			debug_locks);
>>>   
>>> +	/*
>>> +	 * Zappped classes and lockdep data buffers reuse statistics.
>>> +	 */
>>> +	if (!nr_zapped_classes)
>>> +		return 0;
>>> +
>>> +	seq_puts(m, "\n");
>>> +	seq_printf(m, " zapped classes:                %11lu\n",
>>> +			nr_zapped_classes);
>>>   	return 0;
>>>   }
>> Why is that conditional?
>>
> Because I thought zapping class doesn't occur that often. Apparently,
> class zapping happens when the system first boots up. I guess that
> conditional check isn't needed. I can remove it in the next version.

Zapping a lock class happens every time a lock key is unregistered. That 
can happen any time as one can see in the following grep output:

$ git grep -lw 'lockdep_unregister_key'
drivers/net/bonding/bond_main.c:4446: 
lockdep_unregister_key(&bond->stats_lock_key);
drivers/net/team/team.c:1676:	lockdep_unregister_key(&team->team_lock_key);
drivers/net/team/team.c:1984:		lockdep_unregister_key(&team->team_lock_key);
include/linux/lockdep.h:294:extern void lockdep_unregister_key(struct 
lock_class_key *key);
include/linux/lockdep.h:464:static inline void 
lockdep_unregister_key(struct lock_class_key *key)
kernel/locking/lockdep.c:5166:void lockdep_unregister_key(struct 
lock_class_key *key)
kernel/locking/lockdep.c:5201:EXPORT_SYMBOL_GPL(lockdep_unregister_key);
kernel/workqueue.c:3456:	lockdep_unregister_key(&wq->key);
net/core/dev.c:9172:	lockdep_unregister_key(&dev->qdisc_tx_busylock_key);
net/core/dev.c:9173:	lockdep_unregister_key(&dev->qdisc_running_key);
net/core/dev.c:9174:	lockdep_unregister_key(&dev->qdisc_xmit_lock_key);
net/core/dev.c:9175:	lockdep_unregister_key(&dev->addr_list_lock_key);
net/core/dev.c:9183:	lockdep_unregister_key(&dev->qdisc_xmit_lock_key);
net/core/dev.c:9184:	lockdep_unregister_key(&dev->addr_list_lock_key);
tools/lib/lockdep/include/liblockdep/common.h:48:void 
lockdep_unregister_key(struct lock_class_key *key);
tools/lib/lockdep/include/liblockdep/mutex.h:58: 
lockdep_unregister_key(&lock->key);

Bart.
