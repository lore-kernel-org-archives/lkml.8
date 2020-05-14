Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30193C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BDCE20659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="GihVdNYT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726032AbgENCqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725895AbgENCqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:46:53 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 776FEC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:46:53 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id z80so1683649qka.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 19:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UJd8WYSDm+/pkRTjF9k0qFTh29qxTEJeyDJBEQQ6wZ8=;
        b=GihVdNYTGc22CmLhrnrKLf+pkiVY92UNrvCjn/Bg7wMbI0xP5zYEBNucYCRB/nT4HW
         sLzAmdCWeWSEel/PYNgdLEG9Ngag802iebKUYuMN2OAnb/axG11cZOqEYc14BqUhhO7c
         37vN2iH22wQSWjAh8EI2dw4wwv2EVyVmyqpQ4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UJd8WYSDm+/pkRTjF9k0qFTh29qxTEJeyDJBEQQ6wZ8=;
        b=bb7hRSZk0WGNplQ/tJplbnDz5lgSG4uprq7QDeM7aTbbG7vk+VTc8msFryiLYINown
         dp2Rg1f4QGf9B5fybL76N/xHtY7N7xqbZ7+ao8RUEX6zA22qvAbplgXkkB6iLNHZqrox
         5Rj1KNsmWfHRijpqNRujuJqdheNTltdpxKlzSWi7cTOXLtFhEvjYQuOHN+xD3WSjB+cx
         OH7Hqf20gPNpSo440TiTbbDu83colQCNTlLH9uZDTnqvAmwcOqvmApMpLrj7BZYHusjw
         /09taDUbsHZb17aZmBFJgYUhm5yns+oJ2s3n/I7yF0Rr95aiqrKzvm2elYO9uHlqRisK
         26Vg==
X-Gm-Message-State: AOAM530GfId4AG0/9/vdami1votEe4y39v4eAxKknk5YMTl+wkmS+8y6
        4+P33lcZfC0fHQX1JmTCWjay1A==
X-Google-Smtp-Source: ABdhPJzDHO3yyRE8WhfFI3XI9eFXJXHPnefbYoPuRENyMzrC2uYIGos0BsAiZjm2AKtXJ4flzEFHQQ==
X-Received: by 2002:a37:9b0c:: with SMTP id d12mr2613176qke.441.1589424412603;
        Wed, 13 May 2020 19:46:52 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id p137sm1518582qke.60.2020.05.13.19.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2020 19:46:52 -0700 (PDT)
Date:   Wed, 13 May 2020 22:46:51 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Subject: Re: [patch V4 part 3 11/29] rcu: Provide rcu_irq_exit_preempt()
Message-ID: <20200514024651.GA252210@google.com>
References: <20200505134354.774943181@linutronix.de>
 <20200505134904.364456424@linutronix.de>
 <20200514024116.GA231286@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514024116.GA231286@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 10:41:16PM -0400, Joel Fernandes wrote:
> Hi Thomas,
> 
> On Tue, May 05, 2020 at 03:44:05PM +0200, Thomas Gleixner wrote:
> 
> Thank you for CC'ing me.
> 
> > Interrupts and exceptions invoke rcu_irq_enter() on entry and need to
> > invoke rcu_irq_exit() before they either return to the interrupted code or
> > invoke the scheduler due to preemption.
> > 
> > The general assumption is that RCU idle code has to have preemption
> > disabled so that a return from interrupt cannot schedule. So the return
> > from interrupt code invokes rcu_irq_exit() and preempt_schedule_irq().
> > 
> > If there is any imbalance in the rcu_irq/nmi* invocations or RCU idle code
> > had preemption enabled then this goes unnoticed until the CPU goes idle or
> > some other RCU check is executed.
> > 
> > Provide rcu_irq_exit_preempt() which can be invoked from the
> > interrupt/exception return code in case that preemption is enabled. It
> > invokes rcu_irq_exit() and contains a few sanity checks in case that
> > CONFIG_PROVE_RCU is enabled to catch such issues directly.
> 
> Could you let me know which patch or part in the multi-part series is using it?

Ah I see its "x86/entry/common: Provide idtentry_enter/exit()" patch. I'll go
read that tomorrow. Thanks!

 - Joel

