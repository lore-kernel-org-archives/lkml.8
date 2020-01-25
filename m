Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0B41C35241
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 08:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7D872071A
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 08:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729094AbgAYI1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 03:27:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:51044 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgAYI1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 03:27:54 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ivGmu-0006Pc-Mj; Sat, 25 Jan 2020 11:27:28 +0300
Subject: Re: [PATCH 0/7] seq_file .next functions should increase position
 index
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <244674e5-760c-86bd-d08a-047042881748@virtuozzo.com>
 <20200124105024.18d24572@gandalf.local.home>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <e6a8e2e5-55f4-af10-8a1a-9eba44c24645@virtuozzo.com>
Date:   Sat, 25 Jan 2020 11:27:27 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200124105024.18d24572@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/20 6:50 PM, Steven Rostedt wrote:
> On Fri, 24 Jan 2020 10:02:36 +0300
> Vasily Averin <vvs@virtuozzo.com> wrote:
> 
>>
>> I've sent patches into maillists of affected subsystems already,
>> this patch-set fixes the problem in files related to 
>> pstore, tracing, gcov, sysvipc  and other subsystems processed 
>> via linux-kernel@ mailing list directly
> 
> Since you sent the patches out individually, and not as the usually way
> of replying to the 0/7 patch (this email), do you expect the patches to
> just be accepted by the individual maintainers, and not as a series?

Yes, you are right, I've missed it.
Could you please review tracing-related patches of this patch set?

>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>>
>> Vasily Averin (7):
>>   pstore_ftrace_seq_next should increase position index
>>   gcov_seq_next should increase position index
>>   t_next should increase position index
>>   fpid_next should increase position index
>>   eval_map_next should increase position index
>>   trigger_next should increase position index
>>   sysvipc_find_ipc should increase position index
>>
>>  fs/pstore/inode.c                   | 2 +-
>>  ipc/util.c                          | 2 +-
>>  kernel/gcov/fs.c                    | 2 +-
>>  kernel/trace/ftrace.c               | 9 ++++++---
>>  kernel/trace/trace.c                | 4 +---
>>  kernel/trace/trace_events_trigger.c | 5 +++--
>>  6 files changed, 13 insertions(+), 11 deletions(-)
>>
> 
