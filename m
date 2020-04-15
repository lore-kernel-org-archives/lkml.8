Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DFB3C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AAFD2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 21:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z3He7Hy0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438737AbgDOVCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 17:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438334AbgDOVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 17:02:16 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C72C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:02:16 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id k9so14745417oia.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 14:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=N2S2rvnMUv9EkeNc34T2xFMYxr/qxEfAFfVcqbGmQws=;
        b=z3He7Hy0epqDTOkSXK64WVlICvSnCcFHqsCYx/uvNSAbmtTkmCsUWNLV19wMHEgF2m
         ZO8aR0VI3mv6ysj8ZeCUBW2XsCOtwIE9u7tp3Ra3SeNpWtFy2tcsRR+GDnVrIDf5B3xb
         k31K4FR6UdMcRk5Wf3LTLkAXxo+Lwb4j/Gb2UiHNXTqgFnARQF2eMS2PQxV56Inh/JY0
         gRW9Gjligh7X9oBNxz88d+bjHoTHwmeKY/3Jk5J5qUyjbxBOjKz5nHsu3FExcFxyQNAQ
         LuB7Z0IlZYLz8Y1sWaxEvwKwadCasaCgLnF3fnIIPykEZVkVrRC2NnZ/bX1H5pcP3Ndt
         fe5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=N2S2rvnMUv9EkeNc34T2xFMYxr/qxEfAFfVcqbGmQws=;
        b=LyLE7ym5b6/kBRF8g7y1rpz4Aj5Ed+lzPNsNEmhSfgUbaxHoTPnZaHGGsKCTe+sUpz
         2T433uAxWcPBaoWnJPqDq0QEQeKfTomyrrjwek2wtS4+rou7F6CrPyE19BZzP16fOeKr
         jdH1XtBGyrZ5ufr6oG6fADNLAuhrsmvQ0CARldkL3uTK7rHcPelstFud2GIFh1QcW9r2
         Q6Gzp0rC7gH+kfc2m7vfKTxQew7whKvXDZ9AAsGZs0mq7wgQkGlsPcp7x5L0ZEYjObJS
         GVvRXyoWoSP7zW038mfvCZLiSf0Lb0iPZOHfGDBaRtbKUMktOJRQrWb6kRiI4wiz/PJ4
         kuwA==
X-Gm-Message-State: AGi0PuYByaNZYf84Xml7/2mGyee67n4Q2d7Gyg0rTpYuS8RU9X3SNcPf
        8oyV0/GQDky1AJmTSlED7iBm3mjxvmPBv054klOoIw==
X-Google-Smtp-Source: APiQypJzDy/lBs3s6hv5KNbEpCSLKC9tjMLP2UUce9WjeV9r/+KCrswmwuW6eufyQ6Omj+bNLNGrmEffcdkBU9Ft51k=
X-Received: by 2002:a05:6808:a0a:: with SMTP id n10mr915668oij.10.1586984535153;
 Wed, 15 Apr 2020 14:02:15 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home> <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home> <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
 <20200415164116.40564f2c@gandalf.local.home>
In-Reply-To: <20200415164116.40564f2c@gandalf.local.home>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Apr 2020 14:02:04 -0700
Message-ID: <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
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

On Wed, Apr 15, 2020 at 1:41 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Apr 2020 13:17:53 -0700
> John Stultz <john.stultz@linaro.org> wrote:
>
> > > Hmm, isn't module code itself synchronized via RCU. Then having module code
> > > being called without RCU "watching" could be dangerous?
> >
> > I'm not sure I'm following you here. Could you explain more?
>
> So how does this code get registered to be called as a module?

The driver is registered via standard platform_driver_register()
called via module_initcall. The callback is then registered via
cpu_pm_register_notifier() in the driver's probe function.

> And if it is
> registered, I'm guessing it needs to be unregistered too. How would that be
> synchronized? Usually, calling synchronize_rcu() is done after
> unregistering, but if that code is called without RCU watching, it is
> possible synchronize_rcu() can finish before that code is released.

So I'm actually trying to enable the driver to be loaded as a
permanent module, so there's no remove hook (so much depends on the
driver that you couldn't remove it and have anything work - we just
want it to be modularly loaded so all devices don't have to pay the
cost of including the driver).

So in my case your concerns may not be a problem, but I guess
generally it might. Though I'd hope the callback would be unregistered
(and whatever waiting for the grace period to complete be done) before
the module removal is complete. But maybe I'm still missing your
point?

thanks
-john
