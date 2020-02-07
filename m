Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA001C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6D0520720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 21:44:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wXZPnJy8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727175AbgBGVn7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 16:43:59 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:43418 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgBGVn7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 16:43:59 -0500
Received: by mail-qv1-f68.google.com with SMTP id p2so322028qvo.10
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 13:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hGJp/2eTDkoe50FraiPgMuPjomt10Y3UtDIsoXnfl00=;
        b=wXZPnJy8DMyWgRhotieyVkkeyLXHM6To4wupGxuRnlDewsCZqwcgfCGmWMHCgMlG/3
         B6RyjZwIM8G2VkMRwXYu43Ql9cSvgbgIz1ckUfXXQjW2a88bADu6a7BPj/hLE1UHzHFw
         cto6GWBvM5uAMXS88CsZ5zSk34jOn98lCGoX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hGJp/2eTDkoe50FraiPgMuPjomt10Y3UtDIsoXnfl00=;
        b=cTuSke2duWVdtURuzU+Fb2SKFcU+32xPOuVG4mHQvZViHaLp2u/RCY39iqxVt7D1Kt
         qCChC9r8zlaXNV9358dLe450n+Wl8cfkYrR58YiLX+w4ZwgL+Ogo//s9Kry2TyccpiXI
         w1f7eWZ6cZHY2uToe7hpy7SCJdkmT8x07bR1W4FeO6v3hubUlBd8kmKNwIePS3+BNkr3
         PMBr/FuD/++mFkV9d1NB3r4ckFnj4gPr5j9Y6ZiQBdGTcf1wDD3jq+zJWSDoG0yFnrMh
         uLrvirvJjI0RuP8XjR/hxTZTue9KQ3ttd7vJn/D1r5WPlw36NrGIaxY2gg2R3l/1AgY+
         n75A==
X-Gm-Message-State: APjAAAUdyU4JuhoZ27+UrCPFTLDqAsJ3zRovlhjNbKmWwsyu7I8G4KQN
        X6q8m3/0/44oOmXUKEMLdcDpfw==
X-Google-Smtp-Source: APXvYqzkBk8HPlSPDkMR/8we2T4OtrwxMBVmPxJqb48unPbkaWtKidPHtK2Iku8YsVwx2YEz+XQ/+Q==
X-Received: by 2002:a0c:bd20:: with SMTP id m32mr401485qvg.197.1581111838225;
        Fri, 07 Feb 2020 13:43:58 -0800 (PST)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id u76sm1983619qka.21.2020.02.07.13.43.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 13:43:57 -0800 (PST)
Date:   Fri, 7 Feb 2020 16:43:57 -0500
From:   Joel Fernandes <joel@joelfernandes.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Richard Fontana <rfontana@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [RFC 0/3] Revert SRCU from tracepoint infrastructure
Message-ID: <20200207214357.GA75841@google.com>
References: <20200207205656.61938-1-joel@joelfernandes.org>
 <20200207212450.GP2935@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207212450.GP2935@paulmck-ThinkPad-P72>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 01:24:50PM -0800, Paul E. McKenney wrote:
> On Fri, Feb 07, 2020 at 03:56:53PM -0500, Joel Fernandes (Google) wrote:
> > Hi,
> > These patches remove SRCU usage from tracepoints. The reason for proposing the
> > reverts is because the whole point of SRCU was to avoid having to call
> > rcu_irq_enter_irqson(). However this was added back in 865e63b04e9b2 ("tracing:
> > Add back in rcu_irq_enter/exit_irqson() for rcuidle tracepoints") because perf
> > was breaking..
> > 
> > Further it occurs to me that, by using SRCU for tracepoints, we forgot that RCU
> > is not really watching the tracepoint callbacks. This means that anyone doing
> > preempt_disable() in their tracepoint callback, and expecting RCU to listen to
> > them is in for a big surprise. When RCU is not watching, it does not care about
> > preempt-disable sections on CPUs as you can see in the forced-quiescent state loop.
> > 
> > Since SRCU is not providing any benefit because of 865e63b04e9b2 anyway, let us
> > revert SRCU tracepoint code to maintain the sanity of potential
> > tracepoint callback registerers.
> 
> For whatever it is worth, SRCU is the exception to the "RCU needs to
> be watching" rule.  You can have SRCU readers on idle CPUs, offline
> CPUs, CPUs executing in userspace, whatever.

Yes sure. My concern was that callbacks are still using regular RCU somewhere
and RCU isn't watching. I believe BPF is using RCU that way (not sure). But
could be other out-of-tree kernel modules etc.

thanks,

 - Joel

> 
> 							Thanx, Paul
> 
> > Joel Fernandes (Google) (3):
> > Revert "tracepoint: Use __idx instead of idx in DO_TRACE macro to make
> > it unique"
> > Revert "tracing: Add back in rcu_irq_enter/exit_irqson() for rcuidle
> > tracepoints"
> > Revert "tracepoint: Make rcuidle tracepoint callers use SRCU"
> > 
> > include/linux/tracepoint.h | 40 ++++++--------------------------------
> > kernel/tracepoint.c        | 10 +---------
> > 2 files changed, 7 insertions(+), 43 deletions(-)
> > 
> > --
> > 2.25.0.341.g760bfbb309-goog
> > 
