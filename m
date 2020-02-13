Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D965C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:39:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB8ED24671
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 18:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="YBDWZ7Vj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728496AbgBMSjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 13:39:16 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:47082 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgBMSjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 13:39:16 -0500
Received: by mail-qv1-f67.google.com with SMTP id y2so3060141qvu.13
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2020 10:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ckZLVESfEdYWN9scXv4QPDAyT2tf1XCLtTQVFWSOkak=;
        b=YBDWZ7Vjv/V8lXoR2mBZRvRi/ceb+/qigcPTiv0Rc4HmE0bQMoDmskrHRs+kVLHUuK
         WDqVZl8aQ5nbXSYtXpUZq2C26c8sXgjTs/PyMKLoYU1sdLrZ8lxFEUaKWWviQ+QNaGmK
         cSWkcMZSlHZdJZCwZk3OE4E9K68A6yoRpkeEY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ckZLVESfEdYWN9scXv4QPDAyT2tf1XCLtTQVFWSOkak=;
        b=gIrnME/uqtWGg+xrxZ6W5oxLE8B05THPjg7j22mB9P4iR51JnVeWcmXuOPoXo8vnwC
         tfFgZu70igfyYHPMTKJnMbaBgJRzPnFGAsGyNtT5CaAGqfZDHzHjKKRibzmFtHX4t9GQ
         On+dPDLZOLw9SUAOeldq80UTzbhVJbgiROVwY0wQHPjKMZppK6h8hVtb6I/ON9rn4Eyr
         QYnE7ta4tAqZ4vX7n4W2s/itvZBDMJUlgp6d4mmD+OZvsko2N52LQrXdW4D/1w+V4k4D
         /i2Lb22WvC18hEbYWPLx7jV1uMhy9P77mYSE2IVFYSnIJrgD8BxoB8IWM/Focf7iAvuE
         +DYw==
X-Gm-Message-State: APjAAAXj6+1hY+BppEADQrI3rLHQtrBbZFTJCb+oM4EiolyXBhXASTMU
        QhuQinNepvvH2WbHuWYt8QCbkQ==
X-Google-Smtp-Source: APXvYqzHsVALJUWy/T7m4VimAf8+AVDbsjkwQvzvwe13sun3om/9nuVR4fubbIzWUDJvK8agPQGKeg==
X-Received: by 2002:a05:6214:524:: with SMTP id x4mr25320787qvw.4.1581619154824;
        Thu, 13 Feb 2020 10:39:14 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x197sm1768089qkb.28.2020.02.13.10.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 10:39:14 -0800 (PST)
Date:   Thu, 13 Feb 2020 13:39:14 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        rostedt@goodmis.org, mingo@kernel.org, gregkh@linuxfoundation.org,
        gustavo@embeddedor.com, tglx@linutronix.de, paulmck@kernel.org,
        josh@joshtriplett.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com
Subject: Re: [PATCH v2 3/9] rcu,tracing: Create trace_rcu_{enter,exit}()
Message-ID: <20200213183914.GB207225@google.com>
References: <20200212210139.382424693@infradead.org>
 <20200212210749.971717428@infradead.org>
 <20200212232702.GA170680@google.com>
 <20200213082814.GJ14897@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200213082814.GJ14897@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 09:28:14AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 12, 2020 at 06:27:02PM -0500, Joel Fernandes wrote:
> > On Wed, Feb 12, 2020 at 10:01:42PM +0100, Peter Zijlstra wrote:
> 
> > > +#define trace_rcu_enter()					\
> > > +({								\
> > > +	unsigned long state = 0;				\
> > > +	if (!rcu_is_watching())	{				\
> > > +		if (in_nmi()) {					\
> > > +			state = __TR_NMI;			\
> > > +			rcu_nmi_enter();			\
> > > +		} else {					\
> > > +			state = __TR_IRQ;			\
> > > +			rcu_irq_enter_irqsave();		\
> > 
> > Since rcu_irq_enter_irqsave can be called from a tracer context, should those
> > be marked with notrace as well? AFAICS, there's no notrace marking on them.
> 
> It should work, these functions are re-entrant (as are IRQs / NMIs) and
> Steve wants to be able to trace RCU itself.

Hoping there are no recursion scenarios possible, but that sounds good to me. thanks,

 - Joel

