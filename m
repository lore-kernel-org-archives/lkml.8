Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBB0EC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:53:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB19C20707
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 15:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="svvnXsQE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgH2Pwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 11:52:55 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:60342 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728310AbgH2Pwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 11:52:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598716365; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=w+hd4TjghSShhgFkfzUSoPKt3rG3sRSmRVLXY4b56fM=;
 b=svvnXsQET404vEZtvWLZWBorjLnemIUWUSmoBDND4/5wda26Da6v8fVz+wpXzaFlV+EmXFew
 2Kl0AsK8URHZRXMT/qVOnA2W6GwiJGetp89fAOJbxbWQmHOR+MpwpN9aZDia8EnkX+lohiKY
 jIDG1PVSNClfi2hwci5Xh8tRIkE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5f4a79c1bdef49b8a8bf93ef (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 29 Aug 2020 15:52:33
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E4566C433A0; Sat, 29 Aug 2020 15:52:32 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24B5CC433CA;
        Sat, 29 Aug 2020 15:52:32 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Aug 2020 23:52:32 +0800
From:   Wen Gong <wgong@codeaurora.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-kernel-owner@vger.kernel.org, ath10k@lists.infradead.org,
        ath11k@lists.infradead.org, abhishekpandit@google.com,
        briannorris@google.com, drinkcat@google.com, tientzu@google.com
Subject: Re: [for-next][PATCH 2/2] tracing: Use temp buffer when filtering
 events
In-Reply-To: <20200828185538.1761f93d@oasis.local.home>
References: <20160504135202.422290539@goodmis.org>
 <20160504135241.308454993@goodmis.org>
 <b504b3d7e989cae108669a0cd3072454@codeaurora.org>
 <20200828184955.6de9b54e@oasis.local.home>
 <20200828185450.101ebd09@oasis.local.home>
 <20200828185538.1761f93d@oasis.local.home>
Message-ID: <f16b14066317f6a926b6636df6974966@codeaurora.org>
X-Sender: wgong@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-29 06:55, Steven Rostedt wrote:
> On Fri, 28 Aug 2020 18:54:50 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Fri, 28 Aug 2020 18:49:55 -0400
>> Steven Rostedt <rostedt@goodmis.org> wrote:
>> 
>> > On Fri, 28 Aug 2020 15:53:06 +0800
>> > Wen Gong <wgong@codeaurora.org> wrote:
>> >
>> > > this patch commit id is : 0fc1b09ff1ff404ddf753f5ffa5cd0adc8fdcdc9 which
>> > > has upstream.
>> > >
>> > > how much size is the per cpu buffer?
>> > > seems it is initilized in trace_buffered_event_enable,
>> > > it is only 1 page size as below:
>> > > void trace_buffered_event_enable(void)
>> > > {
>> > > ...
>> > > 	for_each_tracing_cpu(cpu) {
>> > > 		page = alloc_pages_node(cpu_to_node(cpu),
>> > > 					GFP_KERNEL | __GFP_NORETRY, 0);
>> > > If the size of buffer to trace is more than 1 page, such as 46680, then
>> > > it trigger kernel crash/panic in my case while run trace-cmd.
>> > > After debugging, the trace_file->flags in
>> > > trace_event_buffer_lock_reserve is 0x40b while run trace-cmd, and it is
>> > > 0x403 while collecting ftrace log.
>> > >
>> > > Is it have any operation to disable this patch dynamically?
>> >
>> > It shouldn't be disabled, this is a bug that needs to be fixed.
>> >
>> > Also, if an event is more than a page, it wont be saved in the ftrace
>> > ring buffer, as events are limited by page size minus the headers.
>> >
>> 
>> Untested (not even compiled, as I'm now on PTO) but does this patch
>> work for you?
>> 
>> -- Steve
>> 
>> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> index f40d850ebabc..3a9b4422e7fc 100644
>> --- a/kernel/trace/trace.c
>> +++ b/kernel/trace/trace.c
>> @@ -2598,7 +2598,7 @@ trace_event_buffer_lock_reserve(struct 
>> trace_buffer **current_rb,
>>  	    (entry = this_cpu_read(trace_buffered_event))) {
>>  		/* Try to use the per cpu buffer first */
>>  		val = this_cpu_inc_return(trace_buffered_event_cnt);
>> -		if (val == 1) {
>> +		if (val == 1 || (len > (PAGE_SIZE - 8))) {
> 
> That was suppose to be:
> 
> 		if (val == 1 && (len < (PAGE_SIZE - 8))) {
> 
> -- Steve
Thanks Steve!

If change like this, I think it will fix my issue of crash.
Will you commit this change?
> 
>>  			trace_event_setup(entry, type, flags, pc);
>>  			entry->array[0] = len;
>>  			return entry;
