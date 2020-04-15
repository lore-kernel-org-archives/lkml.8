Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43B8C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BF8820768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 19:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynKp2qGN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436778AbgDOT5G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 15:57:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2406322AbgDOT5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 15:57:03 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A461C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:57:03 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m13so1097500otf.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 12:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E7N/+DQkyWiqwxQNccTH6eWsJt9DMfcvRQg/n6t3Ja8=;
        b=ynKp2qGNmiLRebgQ6glvt23ydPIdnpzU4vuQM3TbZpHJdi5grB/Yz4n5w8acKIE5EA
         mpHNee/zhK9zsIFxUytoRXk1OZDXL7p5QJ/b2QQctoIirRA38RyynxYNM+AIJhrkPy6u
         W9wySvMHABrSnvUhHEjQZo9N3p72SSCWjmOJgRmqiSCXweeKMz8dTUCbWu3F4Tbqul5/
         Erm91YVVHDrpvNMOYgVnYVt+lQEW2T9FH9dQPEuxOSfWAXDxMCAoflFGzi0hi3P35KN4
         UyKtRxvuAvaqf1QTqPukQAJtWIHjR5semUJLs/0TsLBLOv1QsLWmjKGtj3cuohKRndab
         /u5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E7N/+DQkyWiqwxQNccTH6eWsJt9DMfcvRQg/n6t3Ja8=;
        b=EcDPRjt3DQy1DZWwh8UrfFTCDu6eHC/XLspENs5bxpnFYWGsyxG0LcZrkK9DusH+7d
         Z/xD2Rn102+mIImTbqpqtywfmDqLJ2iJzWBMRRh/heGUa637m/oE0GTNQ0IKVvksektx
         5rEZ+tfiwVta5Z7kGFVUxsQHb3MTa4lna9rqymaHirH1FpcFucheoZcaKFuPcNwAcHUw
         tlycbFnZmuL1233cZe2fzkUMl+CF/1VclqxcrEzd0GxfuXD6OLFLjHMqdZnIeo9nUrM2
         47DyAHlOkiHn//3CFUEKJozx/4meO83lxkXVFlMcdPqbD+uGy+TVuqNwwhIYt5oyY5Ul
         mgDQ==
X-Gm-Message-State: AGi0PuY9NLTUdsKSKO0w3EA4hUhBRj7QWKArHDuPYDGyLFPKHaCIGD/q
        47UfuyoZF889E8Su+JL0149Vt5hXcMi4ipMd+y8uFA==
X-Google-Smtp-Source: APiQypIigKVoQPIsc8PQgCgpVx3lMNl7uBlbch3FQNtVCqLxr9i2paYqnuYgX3Rl4ZAEBzXgTEXe3a6hPHZ6+NPx89E=
X-Received: by 2002:a05:6830:20c3:: with SMTP id z3mr17902764otq.102.1586980622709;
 Wed, 15 Apr 2020 12:57:02 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home>
In-Reply-To: <20200415085348.5511a5fe@gandalf.local.home>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Apr 2020 12:56:52 -0700
Message-ID: <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
Subject: Re: On trace_*_rcuidle functions in modules
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     paulmck@kernel.org, Josh Triplett <josh@joshtriplett.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 5:53 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> [ +Peter +Thomas ]
>
> On Tue, 14 Apr 2020 19:20:01 -0700
> John Stultz <john.stultz@linaro.org> wrote:
>
> > Hey folks,
> >   So recently I was looking at converting some drivers to be loadable
> > modules instead of built-in only, and one of my patches just landed in
> > -next and started getting build error reports.
> >
> > It ends up, recently in the merge window, the driver I was converting
> > to module switched a trace_*() function to trace_*_rcuidle() to fix a
> > bug.  Now when building as a module, if tracing is configured on, it
> > can't seem to find the trace_*_rcuidle() symbol.
>
> Which modules need this.

Hey Steven!

I'm trying to enable the qcom rpmh driver
(drivers/soc/qcom/rpmh-rsc.c) to be a module.  As I mentioned to Paul,
it registers a cpu_pm notifier callback, which calls its
__tcs_buffer_write() function. The trace in the __tcs_buffer_write()
function was just converted to using rcuidle to address bugs seen when
it was being called from idle.

> Currently, Thomas and Peter are working on removing trace events from
> places that don't have RCU enabled, or at least cleaning up the context
> switches from user to kernel to interrupt.

So does that mean folks would most likely lean to trying to remove the
tracepoint rather than reevaluating allowing the rcuidle call to be
made from the module?

thanks
-john
