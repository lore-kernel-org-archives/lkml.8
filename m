Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC41C352A4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A8DD217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 23:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="sxuyQmGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgBLX2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 18:28:44 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43353 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbgBLX2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 18:28:44 -0500
Received: by mail-qk1-f194.google.com with SMTP id p7so3887073qkh.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 15:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fYuqkm3Om1sqZwRi3Fq5WUa7PQ8WgfNshBVo9cj4H40=;
        b=sxuyQmGOizY2EQbmpzNJJACGJLi5ux1yhvSrNAVDmPYY9CSCCK7T0Zpu39Y7UQpKyj
         P4rI6Trf3FmihIsEQRk0ObZbCBkbKxRS7X5mMaAIQcm7rdhzTr+lQ4feSfy/We15KIB9
         A/tVydjW/MtCP+mTi6RT8ye8Z61SmUuibMqXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fYuqkm3Om1sqZwRi3Fq5WUa7PQ8WgfNshBVo9cj4H40=;
        b=WZMPYLGXnaEyUY5+V+Sym3S0MzzoYNPqk5rl81hVTu9OGKpckuNQOccxqAYsmBLa6j
         jZy5ssZW1WsgYC4OQkibuPLqD4BaXP9V12sz0xbo8iRK3vu+9NbZ1fShJTIoQ3JG/Qj7
         23fSY0BqN8WHq6Nplq43kTcYqJng1iFS9y4pYSIUax8WVgVDAbqDcjLmrLBCjeparRRK
         wwKgnsPkBKRPml9peQJeHlv07fmWgqQeyhu7gMBdzCMyBFxy9ymUPO8YX6jrfOu6O5NQ
         7d8jqDgGUj+urlgTQGyYqpjxE9nYol5RQ8FBLeYlqBMYnPFN/fHw2OIqD15hbizy7shU
         WzwA==
X-Gm-Message-State: APjAAAVYbY8u2fsttSAxLKZQa2iwLP7WLxj/t1TPBg7uvvuM9dKxi8md
        QY0SFRWdIZHk8fCZp/4Yu3cjEg==
X-Google-Smtp-Source: APXvYqxHHxiD+zW4lcdfx2K3IYuaYzDj7OaOEwM4KOg9c7GQz/OUqUp4o9KRtnh/azJZ07LcffaqUA==
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr9755316qki.478.1581550123076;
        Wed, 12 Feb 2020 15:28:43 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t7sm240428qkm.136.2020.02.12.15.28.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:28:30 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:28:30 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com,
        "Steven Rostedt (VMware)" <rosted@goodmis.org>
Subject: Re: [PATCH v2 6/9] perf,tracing: Prepare the perf-trace interface
 for RCU changes
Message-ID: <20200212232830.GB170680@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210750.142334759@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200212210750.142334759@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2020 at 10:01:45PM +0100, Peter Zijlstra wrote:
> The tracepoint interface will stop providing regular RCU context; make
> sure we do it ourselves, since perf makes use of regular RCU protected
> data.
> 
> Suggested-by: Steven Rostedt (VMware) <rosted@goodmis.org>
> Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/events/core.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -8950,6 +8950,7 @@ void perf_tp_event(u16 event_type, u64 c
>  {
>  	struct perf_sample_data data;
>  	struct perf_event *event;
> +	unsigned long rcu_flags;

The flags are not needed I guess, if you agree on not using in_nmi() in
trace_rcu_enter().

thanks,

 - Joel


>  	struct perf_raw_record raw = {
>  		.frag = {
> @@ -8961,6 +8962,8 @@ void perf_tp_event(u16 event_type, u64 c
>  	perf_sample_data_init(&data, 0, 0);
>  	data.raw = &raw;
>  
> +	rcu_flags = trace_rcu_enter();
> +
>  	perf_trace_buf_update(record, event_type);
>  
>  	hlist_for_each_entry_rcu(event, head, hlist_entry) {
> @@ -8996,6 +8999,8 @@ void perf_tp_event(u16 event_type, u64 c
>  	}
>  
>  	perf_swevent_put_recursion_context(rctx);
> +
> +	trace_rcu_exit(rcu_flags);
>  }
>  EXPORT_SYMBOL_GPL(perf_tp_event);
>  
> 
> 
