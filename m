Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 928E1C83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D31C205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="A0OKwu8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbgD2TM1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726456AbgD2TM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:12:27 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5736C03C1AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:12:26 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ck5so1710274qvb.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PUrBMG4JrKH9eNLOcFyuwpbAs2LJukJ05nwE2n+46mQ=;
        b=A0OKwu8drvTyhlgre6qriR0lY2UD5mtsPhl/RMnN/QchW+SC5qbhaJknuPR3+14NzG
         v0QH//2b+pSlA0goCTmZ4g/xdUyOm58PwlGZPo1XrRZfTcU3YdG0k/KdZuqipu6RE1EK
         rxhpaY/JBjgfT8/rP+QkJq0qBpI9oOHCV1CVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PUrBMG4JrKH9eNLOcFyuwpbAs2LJukJ05nwE2n+46mQ=;
        b=h82NlpKRQzpqlxiNRON0GWamBxsKBZeUsfeNU6u0ec7C7N3p/K9QkBQNxwzHKvTX1g
         xDw50/k4w9nboeYwwuQMQIZpZ2/5NHUHWVeybCeDfzOViMYPm0xmuPphYbQyEMgggS7x
         9yb4AXUwEws8BVYo3CdwAJ+4OR6a92uW01tf2W7teYY4S2yf8BJ1I6Pw5fhjwvgSLuA9
         AonopT6fa9GdQIbWoqXx8aXS6Z8UiESDw4xGr98udxezF4UNEa0OR9FOgqlSyJbiJveP
         d3JYDbj95y5Mzzb72d4Ktxrf/gdPsjrw0U+lnkWQ01t1fxe9O9vIN/cqwKCD5IvxH5UG
         OsFA==
X-Gm-Message-State: AGi0PubKAmf+yywtwtYY6uZnTKBzExC3Aa6QIg8N6PU+lA5BOch7FP79
        l/Uklx9PJoPE1aA3n1KUnequKg==
X-Google-Smtp-Source: APiQypJ8Zv81pXMzK29YnrnefaXJdUNVB+pxh7RSIQ6ULtupWwQN8DSBxa+wpXbbGqmG+J7g/OUKDA==
X-Received: by 2002:a0c:99e9:: with SMTP id y41mr35664750qve.164.1588187545880;
        Wed, 29 Apr 2020 12:12:25 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id q17sm78727qtk.84.2020.04.29.12.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:12:25 -0700 (PDT)
Date:   Wed, 29 Apr 2020 15:12:24 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Xiao Yang <yangx.jy@cn.fujitsu.com>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH] kernel/trace: Stop and wait for kthread on preempt irq
 module unload
Message-ID: <20200429191224.GA75562@google.com>
References: <20200424223630.224895-1-joel@joelfernandes.org>
 <5EA80319.7080005@cn.fujitsu.com>
 <20200428104409.0995ceb0@gandalf.local.home>
 <20200428104543.3926eaaf@gandalf.local.home>
 <5EA96AE8.6000707@cn.fujitsu.com>
 <20200429123141.580f89ce@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429123141.580f89ce@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:31:41PM -0400, Steven Rostedt wrote:
> On Wed, 29 Apr 2020 19:54:16 +0800
> Xiao Yang <yangx.jy@cn.fujitsu.com> wrote:
> 
> > On 2020/4/28 22:45, Steven Rostedt wrote:
> > > diff --git a/kernel/trace/preemptirq_delay_test.c b/kernel/trace/preemptirq_delay_test.c  
> > >>  index 1c28ca20e30b..6d9131ae7e8c 100644
> > >>  --- a/kernel/trace/preemptirq_delay_test.c
> > >>  +++ b/kernel/trace/preemptirq_delay_test.c
> > >>  @@ -113,15 +113,27 @@ static int preemptirq_delay_run(void *data)
> > >>
> > >>    	for (i = 0; i<  s; i++)
> > >>    		(testfuncs[i])(i);
> > >>  +
> > >>  +	while (!kthread_should_stop()) {
> > >>  +		schedule();
> > >>  +		set_current_state(TASK_INTERRUPTIBLE);
> > >>  +	}
> > >>  +
> > >>  +	__set_current_state(TASK_RUNNING);
> > >>  +
> > >>    	return 0;
> > >>    }
> > >>  
> > Hi Steven,
> > 
> > Thanks for your patch.
> > 
> > I also used the following steps to do test and didn't get any 
> > warning/panic after applying your patch.
> > ---------------------------------
> > for i in $(seq 1 100); do modprobe preemptirq_delay_test test_mode=irq 
> > delay=500000; rmmod preemptirq_delay_test; done
> > for i in $(seq 1 100); do modprobe preemptirq_delay_test 
> > test_mode=preempt delay=500000; rmmod preemptirq_delay_test; done
> > ---------------------------------
> > 
> > But I am not sure which fix(from you and Joel) is better.
> 
> Mine ;-)
> 
> The "kthread_should_stop()" is the normal way to end kernel threads. Using
> get/put is not the orthodox way.

Agreed :-) thanks.

 - Joel

