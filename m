Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFAAC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FB1420735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726951AbgEGM3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:29:55 -0400
Received: from relay.sw.ru ([185.231.240.75]:45614 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725923AbgEGM3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:29:55 -0400
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1jWfek-0004GV-RM; Thu, 07 May 2020 15:29:38 +0300
Subject: Re: [PATCH] ipc/util.c: sysvipc_find_ipc() incorrectly updates
 position index
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        Andreas Schwab <schwab@suse.de>
References: <ad24ee52-21a8-3ff0-e968-63d315472b91@virtuozzo.com>
 <4921fe9b-9385-a2b4-1dc4-1099be6d2e39@virtuozzo.com>
 <8e04d756-29f5-9aff-2f0b-61663ecff649@redhat.com>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <5b1a3ac4-13f5-9a54-d62c-a1010d96056b@virtuozzo.com>
Date:   Thu, 7 May 2020 15:29:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <8e04d756-29f5-9aff-2f0b-61663ecff649@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Andrew,
could you please handle it,
it fixes broken ipcs in last mainline and stable kernels,
and on all its derivatives.

Thank you,
	Vasily Averin

On 5/6/20 6:59 PM, Waiman Long wrote:
> On 5/6/20 2:25 AM, Vasily Averin wrote:
>> new_pos should jump through hole of unused ids,
>> pos can be updated inside "for" cycle.
>>
>> Cc: stable@vger.kernel.org
>> Fixes: 89163f93c6f9 ("ipc/util.c: sysvipc_find_ipc() should increase position index")
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>   ipc/util.c | 12 ++++++------
>>   1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/ipc/util.c b/ipc/util.c
>> index 7acccfd..cfa0045 100644
>> --- a/ipc/util.c
>> +++ b/ipc/util.c
>> @@ -764,21 +764,21 @@ static struct kern_ipc_perm *sysvipc_find_ipc(struct ipc_ids *ids, loff_t pos,
>>               total++;
>>       }
>>   -    *new_pos = pos + 1;
>> +    ipc = NULL;
>>       if (total >= ids->in_use)
>> -        return NULL;
>> +        goto out;
>>         for (; pos < ipc_mni; pos++) {
>>           ipc = idr_find(&ids->ipcs_idr, pos);
>>           if (ipc != NULL) {
>>               rcu_read_lock();
>>               ipc_lock_object(ipc);
>> -            return ipc;
>> +            break;
>>           }
>>       }
>> -
>> -    /* Out of range - return NULL to terminate iteration */
>> -    return NULL;
>> +out:
>> +    *new_pos = pos + 1;
>> +    return ipc;
>>   }
>>     static void *sysvipc_proc_next(struct seq_file *s, void *it, loff_t *pos)
> 
> Acked-by: Waiman Long <longman@redhat.com>
> 
