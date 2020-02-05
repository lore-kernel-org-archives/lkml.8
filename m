Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A9CC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C04CC20730
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="nrehUZjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727453AbgBEPmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:42:16 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38660 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:42:16 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so1399333pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=03H9tOU4ZU6Aob62of9ZRzxsUiRGCwWaNgMF+MztT3g=;
        b=nrehUZjzvoVHxS9MBml+qXueEBmbVQVRNi9QBTFlNb4ySXdy6sdRjrcpBdyFw4appf
         EWDFAjrMEGyDLWcSlj+nW93jEfRP7BY22yZ7N4pkGQzq76QczVFRgkYk/iunW/YZ/MDv
         sSH8U0+VX+dp0KjIQosvQElRZXeiN2OumArvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=03H9tOU4ZU6Aob62of9ZRzxsUiRGCwWaNgMF+MztT3g=;
        b=pTUvncCIQKd+d8/Av4hGqrRJ/ZTnWXpxyNRn3Y0rCT54P2KD86I56nz6bwGbfA0DpG
         4SIabniF15UOalJrGVumHVgA6rPdzRidVNO1+7Por6881nKu2q5H41sfwL60fMjMHbCF
         eTBO+Gx9+2A6OBAzMrvhS+VB3n63cY4FqJM3mPeq6S7g1G8FUEhKS/m3IoSFVacWYKGj
         Gt1Y+8M1yx9TBo17lcAJH9Gw4jY4CSJv+h+bA39ltBW/k5VQwmKBKkg38+DDv4w3aWAr
         ZbSSeARo1meIqz6THKQA8EIDlKrsqnQxlLLroU+j8pNG/GgxW420y27LpQvx2bvuYMBC
         wblQ==
X-Gm-Message-State: APjAAAUAJwMxU2YBQFaLMWw6MAA6d2qkoSuZiHyJ5P8RYeopXMi7uIJm
        QIZ+KeG2yPK92WWi9vzVHR7xsw==
X-Google-Smtp-Source: APXvYqyZJS8+VKbJ4mdfBpzG4WiIrsTqm/mT2imB8SMINJ7RnaYxCspLXuTcoiezwUtEjurmcUvWqw==
X-Received: by 2002:a63:a1e:: with SMTP id 30mr28697873pgk.238.1580917334448;
        Wed, 05 Feb 2020 07:42:14 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id l69sm221887pgd.1.2020.02.05.07.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 07:42:13 -0800 (PST)
Date:   Wed, 5 Feb 2020 10:42:12 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@linux.ibm.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Amol Grover <frextrite@gmail.com>
Subject: Re: [for-next][PATCH 4/4] ftrace: Add comment to why
 rcu_dereference_sched() is open coded
Message-ID: <20200205154212.GC142103@google.com>
References: <20200205104929.313040579@goodmis.org>
 <20200205105113.283672584@goodmis.org>
 <20200205063349.4c3df2c0@oasis.local.home>
 <20200205141915.GA194021@google.com>
 <20200205092847.0b650972@oasis.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205092847.0b650972@oasis.local.home>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 05, 2020 at 09:28:47AM -0500, Steven Rostedt wrote:
> On Wed, 5 Feb 2020 09:19:15 -0500
> Joel Fernandes <joel@joelfernandes.org> wrote:
> 
> > Could you paste the stack here when RCU is not watching? In trace event code
> > IIRC we call rcu_enter_irqs_on() to have RCU temporarily watch, since that
> > code can be called from idle loop. Should we doing the same here as well?
> 
> Unfortunately I lost the stack trace. And the last time we tried to use
> rcu_enter_irqs_on() for ftrace, we couldn't find a way to do this
> properly. Ftrace is much more invasive then going into idle. The
> problem is that ftrace traces RCU itself, and calling
> "rcu_enter_irqs_on()" in pretty much any place in the RCU code caused
> lots of bugs ;-)
> 
> This is why we have the schedule_on_each_cpu(ftrace_sync) hack.

The "schedule a task on each CPU" trick works on !PREEMPT though right?

Because it is possible in PREEMPT=y to get preempted in the middle of a
read-side critical section, switch to the worker thread executing the
ftrace_sync() and then switch back. But RCU still has to watch that CPU since
the read-side critical section was not completed.

Or is there a subtlety here with ftrace that I missed?

thanks,

 - Joel


> 
> -- Steve
