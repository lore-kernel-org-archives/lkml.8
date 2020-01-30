Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 375B7C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:18:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1464920702
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 07:18:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgA3HSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 02:18:25 -0500
Received: from relay.sw.ru ([185.231.240.75]:43846 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbgA3HSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 02:18:24 -0500
Received: from vvs-ws.sw.ru ([172.16.24.21])
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <vvs@virtuozzo.com>)
        id 1ix45K-0002T0-CB; Thu, 30 Jan 2020 10:17:54 +0300
Subject: Re: [PATCH 3/7] t_next should increase position index
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        NeilBrown <neilb@suse.com>, Waiman Long <longman@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>
References: <8681248a-da16-5448-31fe-26df9e7cfc25@virtuozzo.com>
 <20200129121257.3cf9c2d6@gandalf.local.home>
From:   Vasily Averin <vvs@virtuozzo.com>
Message-ID: <61c69254-2743-16ab-ea7d-ce110fb20cd5@virtuozzo.com>
Date:   Thu, 30 Jan 2020 10:17:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200129121257.3cf9c2d6@gandalf.local.home>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/29/20 8:12 PM, Steven Rostedt wrote:
> On Fri, 24 Jan 2020 10:02:51 +0300
> Vasily Averin <vvs@virtuozzo.com> wrote:
> 
>> if seq_file .next fuction does not change position index,
>> read after some lseek can generate unexpected output.
>>
>> https://bugzilla.kernel.org/show_bug.cgi?id=206283
>> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
>> ---
>>  kernel/trace/ftrace.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 9bf1f2c..ca25210 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -3442,8 +3442,10 @@ static void *t_mod_start(struct seq_file *m, loff_t *pos)
>>  	loff_t l = *pos; /* t_probe_start() must use original pos */
>>  	void *ret;
>>  
>> -	if (unlikely(ftrace_disabled))
>> +	if (unlikely(ftrace_disabled)) {
>> +		(*pos)++;
>>  		return NULL;
>> +	}
> 
> This isn't needed. If ftrace_disabled is set, we shouldn't be printing
> anything. This case isn't the same as the report in the bugzilla.

I'm agree, thank you, let's drop this patch.

Vasily Averin
