Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B59C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 07DCF20717
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 23:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="iBxj6/7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731462AbgGUXyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 19:54:24 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:49956 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726587AbgGUXyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 19:54:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595375662; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=TSLr5DJ8vWH9lpH85efXRGSwl6B01zDDZMo5u74xgNw=;
 b=iBxj6/7KNw2Jl6OJBFP0AjCQ2HYy6KUHWW3Yc94EcDu1p7iw3xLsICMq9pH0uofMZjDrmot7
 8AtgsQXOdOEPAcGpPP5+QVxkIWGMi5KRj6JF/h1sHWxTPbyBaXNBpRupY9o7OZUorFYMrTMd
 sNhu8xeqTqgBTQthpbYrJCmi1wc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f178027f9ca681bd0728fbe (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 21 Jul 2020 23:54:15
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AEC5AC433C6; Tue, 21 Jul 2020 23:54:14 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 18F41C433C9;
        Tue, 21 Jul 2020 23:54:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 22 Jul 2020 07:54:14 +0800
From:   tingwei@codeaurora.org
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] tracing: add trace_export support for event trace
In-Reply-To: <20200721124342.422ee784@oasis.local.home>
References: <20200720022117.9375-1-tingwei@codeaurora.org>
 <20200720022117.9375-3-tingwei@codeaurora.org>
 <20200721123733.1a87568a@oasis.local.home>
 <20200721124342.422ee784@oasis.local.home>
Message-ID: <78e5b0827f8dfea7d315cea09bd6ab17@codeaurora.org>
X-Sender: tingwei@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-22 00:43, Steven Rostedt wrote:
> On Tue, 21 Jul 2020 12:37:33 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
>> On Mon, 20 Jul 2020 10:21:15 +0800
>> Tingwei Zhang <tingwei@codeaurora.org> wrote:
>> 
>> > Only function traces can be exported to other destinations currently.
>> > This patch exports event trace as well.
>> >
>> > Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
>> > ---
>> >  kernel/trace/trace.c | 24 +++++++++++++-----------
>> >  1 file changed, 13 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
>> > index bb62269724d5..aef6330836e2 100644
>> > --- a/kernel/trace/trace.c
>> > +++ b/kernel/trace/trace.c
>> > @@ -2697,17 +2697,6 @@ int tracepoint_printk_sysctl(struct ctl_table
> *table, int write,
>> >  	return ret;
>> >  }
>> >
>> > -void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
>> > -{
>> > -	if (static_key_false(&tracepoint_printk_key.key))
>> > -		output_printk(fbuffer);
>> > -
>> > -	event_trigger_unlock_commit_regs(fbuffer->trace_file,
> fbuffer->buffer,
>> > -				    fbuffer->event, fbuffer->entry,
>> > -				    fbuffer->flags, fbuffer->pc,
> fbuffer->regs);
>> > -}
>> > -EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
>> > -
>> 
>> Please move the ftrace_exports routines up, instead of moving the
>> trace_event_buffer_commit() down. As it fits better where it is (next
>> to the other buffer_commit code).
>> 
>> -- Steve
>> 
>> 
>> >  /*
>> >   * Skip 3:
>> >   *
>> > @@ -2868,6 +2857,19 @@ int unregister_ftrace_export(struct
>> > trace_export *export) }
>> >  EXPORT_SYMBOL_GPL(unregister_ftrace_export);
>> >
>> > +void trace_event_buffer_commit(struct trace_event_buffer *fbuffer)
>> > +{
>> > +	if (static_key_false(&tracepoint_printk_key.key))
>> > +		output_printk(fbuffer);
>> > +
>> > +	if (static_branch_unlikely(&ftrace_exports_enabled))
>> > +		ftrace_exports(fbuffer->event);
> 
> I would also recommend making each static branch a separate variable.
> That way you could pick and choose what you want to enable. If you only
> want events, and functions are being traced, it will add a bit of
> overhead to handle the functions to just ignore them.
> 
> That is:
> 
>  ftrace_exports_enabled, trace_event_exports_enabled,
>  trace_marker_exports_enabled.
> 
> -- Steve
> 
That's a good idea.  Let me add that to next revision.

> 
>> > +	event_trigger_unlock_commit_regs(fbuffer->trace_file,
>> > fbuffer->buffer,
>> > +				    fbuffer->event, fbuffer->entry,
>> > +				    fbuffer->flags, fbuffer->pc,
>> > fbuffer->regs); +}
>> > +EXPORT_SYMBOL_GPL(trace_event_buffer_commit);
>> > +
>> >  void
>> >  trace_function(struct trace_array *tr,
>> >  	       unsigned long ip, unsigned long parent_ip, unsigned
>> > long flags,
>> 
