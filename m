Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1154C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A37A2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 02:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="lyKSy2/l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgHQCRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 22:17:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgHQCRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 22:17:16 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60C41C061786
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:17:16 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n129so13736509qkd.6
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 19:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uqAO2eKY9Y7otrQtCI3kjfvUUTn3TVZjRuRfzj1BvZ0=;
        b=lyKSy2/lHFlddjusFhNKx9OryoOuhL2Je2b1tqGSkEOfuD1pThTA6sYPYf1mWHM8pI
         M7jpkrsC+IhiKm3rSTDN7CQJzv1+ttkD/Uzg/0lPI88SgnzZSvxq+ViEecvvLstA+SGx
         fixz7gsLq7QDYji9+j9++oNS5sSztqQa8y/N8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uqAO2eKY9Y7otrQtCI3kjfvUUTn3TVZjRuRfzj1BvZ0=;
        b=kiXlZz38Cg7yHaHsMUf/U1nyMwPSCeU7V6IJSKXdiB1XojDcgzdq8O3czhjWXElrjM
         KvgPx5tOl8+GNQ+WV96iNC8RRUUiLpno159AxoerUzT2sihA4Zsu6gIin+TUQfLMI0Bg
         OlMvU+FvL33vUtOvXDdWyuRsFOfYqeZ1RGUcavVcntvXw6Aheu+5QYGA7E/fZ9RaHpwU
         i2bn452YZIxXfA1rVuqgXq1p13A9nOCptOp455TGVORNlGjq7wizPizOkTn0pSw0syaV
         ZK+9CxaQkspzMmnrLkfusEkq6Gptg5osJyEtW9XzYh1UxK8qBWNCh01LDVc9wAEqvCo7
         mOHw==
X-Gm-Message-State: AOAM533AMShBDynPyziPZo3zoIfrxCXQhw877DR7vlVJx8Y3eyWE3GlR
        yNWMH3e8UkKA/0H6Q+Fp1waQSw==
X-Google-Smtp-Source: ABdhPJz/Dfe2MXmILgVjSt5js1nMUiY4J6JfopS+pWGxBDyGzd50h882Ib7h995CPs1mn8qlNDkrWw==
X-Received: by 2002:a37:bd8:: with SMTP id 207mr11135792qkl.211.1597630635530;
        Sun, 16 Aug 2020 19:17:15 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id g136sm15865246qke.82.2020.08.16.19.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 19:17:15 -0700 (PDT)
Date:   Sun, 16 Aug 2020 22:17:14 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: Re: [PATCH RFC 02/12] entry/idle: Add a common function for
 activites during idle entry/exit
Message-ID: <20200817021714.GB1492280@google.com>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
 <20200815031908.1015049-3-joel@joelfernandes.org>
 <20200815081441.GG2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815081441.GG2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Peter,

On Sat, Aug 15, 2020 at 10:14:41AM +0200, peterz@infradead.org wrote:
> On Fri, Aug 14, 2020 at 11:18:58PM -0400, Joel Fernandes (Google) wrote:
> > Currently only RCU hooks for idle entry/exit are called. In later
> > patches, kernel-entry protection functionality will be added.
> > 
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> 
> NAK, rcu_idle_enter() is broken where it is now, it needs to be pushed
> in deeper:
> 
> http://lkml.kernel.org/r/20200807193017.962482579@infradead.org

Thank you for pointing it out. Not a huge problem, a couple ways I can do it:
1. Move the calls to sched_core_unsafe_{enter,exit}() deeper into the idle loop.
2. Keep the calls to sched_core_unsafe_{enter,exit}() where they are now as
   in this patch, but leave out the rcu_idle_{enter,exit}() calls alone so
   they can be moved deeper as you mentioned.

#1 is not necessary for these patches to work and might be overkill.

I'll go the #2 route then. Let me know any other ideas you might have.

What I am trying to do here is to handle a case where task is switching to
idle (say it went to sleep) and wakes up later.

usermode -> syscall (kernel mode - so mark unsafe) -> idle (mark safe).

idle -> syscall wakes (kernel mode - so mark unsafe) -> usermode (mark safe).

Thank you,

 - Joel

