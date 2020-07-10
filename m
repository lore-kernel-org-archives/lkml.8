Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38094C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1702120708
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 01:11:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgGJBLW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 21:11:22 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:52183 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726265AbgGJBLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 21:11:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0U2EumTu_1594343479;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U2EumTu_1594343479)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 10 Jul 2020 09:11:20 +0800
Date:   Fri, 10 Jul 2020 09:11:19 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Wei Yang <richard.weiyang@linux.alibaba.com>, mingo@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] tracing: toplevel d_entry already initialized
Message-ID: <20200710011119.GB51939@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200703020612.12930-1-richard.weiyang@linux.alibaba.com>
 <20200703020612.12930-5-richard.weiyang@linux.alibaba.com>
 <20200709181359.42b4e61e@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709181359.42b4e61e@oasis.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 09, 2020 at 06:13:59PM -0400, Steven Rostedt wrote:
>On Fri,  3 Jul 2020 10:06:12 +0800
>Wei Yang <richard.weiyang@linux.alibaba.com> wrote:
>
>> Currently we have following call flow:
>> 
>>     tracer_init_tracefs()
>>         tracing_init_dentry()
>>         event_trace_init()
>>             tracing_init_dentry()
>> 
>> This shows tracing_init_dentry() is called twice in this flow and this
>> is not necessary.
>
>There's no reason to have patch 4 and 5 separate. Fold the two together.
>

Yep, if you think there is no need.

Do you want me to send v2 based on you comments?

>If you want, you can create another patch that changes
>tracing_init_dentry() to return a integer, as you point out, it never
>returns an actual dentry. No reason for having it return a pointer then.
>
>-- Steve
>
>
>> 
>> Let's remove the second one when it is for sure be properly initialized.
>> 
>> Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>> ---
>>  kernel/trace/trace_events.c | 5 -----
>>  1 file changed, 5 deletions(-)
>> 
>> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
>> index 8b3aa57dcea6..76879b29cf33 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -3434,7 +3434,6 @@ early_initcall(event_trace_enable_again);
>>  __init int event_trace_init(void)
>>  {
>>  	struct trace_array *tr;
>> -	struct dentry *d_tracer;
>>  	struct dentry *entry;
>>  	int ret;
>>  
>> @@ -3442,10 +3441,6 @@ __init int event_trace_init(void)
>>  	if (!tr)
>>  		return -ENODEV;
>>  
>> -	d_tracer = tracing_init_dentry();
>> -	if (IS_ERR(d_tracer))
>> -		return 0;
>> -
>>  	entry = tracefs_create_file("available_events", 0444, NULL,
>>  				    tr, &ftrace_avail_fops);
>>  	if (!entry)

-- 
Wei Yang
Help you, Help me
