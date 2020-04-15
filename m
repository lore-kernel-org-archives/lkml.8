Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B3DC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69F102076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:18:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qQQIzeA3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437908AbgDOUSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437811AbgDOUSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:18:04 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1642C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:18:04 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id z17so1170931oto.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 13:18:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goxicvcGvt1hnhiJLQPcjyXzPuCArv3zw/2A/kUglbU=;
        b=qQQIzeA3e9DaFxhtqqxxdOdTh9jpiaeLWZ4nwiU7z0Y2EpbMDOGdP1UAqLSODxRVdm
         GlbL0fQlJYOZ+QtBUGXj8hc2ZNp06T++ozxSQrJyNjIXyDRkFxo1ELaiY0sBz2Yyxn86
         QsrwGpMStWwuwTjo/8XkRswJquNKSX55aRr8fhxxvBBzsVCOAZnBNbUOwfERkzgi9IPT
         bMqkt0Q+aGmcuCvMUT3oePcgnV+mLwSQUg0Fept2eG99Do+RGJrbjJWf1M65klpzHimi
         ropKpmIfTO2RHolxxWJLdNX3P7j2HaTbfys5ip7DDXqdVRgrk1pS3YBWkfgdzyiazSuY
         qJ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goxicvcGvt1hnhiJLQPcjyXzPuCArv3zw/2A/kUglbU=;
        b=SSPYVL980Qrr0XF0XsxcOlANK5l3/khmPrSXZn0wFrs1+2exNf1luKkY201WzXTrjF
         R+ZjgTcaNv7Vg/HibCfNEc+twJpCWTx8TvwYDiLG7rcTF26v3mDy/UNf1BXIJ7eDQiVR
         hf3q9sLmd8LERSLDDwW4U5GEMXOKzW3x2/YBulYd9K+3yLQ+g2I6h9J7BAQ0nbsmRhTW
         wW1tk9Gn6fpsYgyvKQNwy8VzPbm8I6pdURt1yCRaCwj2ktyJr57az8op3szU3WsP3FWf
         Cu63B6VIRqnfRCH4BxlrC/1TuIUPqKi4j2E5C3EfTsIcjYsMU930LfelRTuHxOeo5N8/
         PYWw==
X-Gm-Message-State: AGi0PuaFTn6G9kzN4cjj8iwlB1a3xAE7vwcxZk4COSMpmJOsRoTUOPFY
        dygzUHyQTOZZpAq2LpBQuCyP80fNskC8GbxERqOA5Q==
X-Google-Smtp-Source: APiQypI+fQwZHOUsInz2eVgcf7cnmJjOkUq2dpURwivb8veG0yFdCTPT/Aiiptv0KgobJpd55ZQJkxMoiExj0Y6AxrM=
X-Received: by 2002:a05:6830:22dc:: with SMTP id q28mr2826104otc.221.1586981884157;
 Wed, 15 Apr 2020 13:18:04 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home> <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home>
In-Reply-To: <20200415161424.584d07d3@gandalf.local.home>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Apr 2020 13:17:53 -0700
Message-ID: <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
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

On Wed, Apr 15, 2020 at 1:14 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Apr 2020 12:56:52 -0700
> John Stultz <john.stultz@linaro.org> wrote:
>
> > I'm trying to enable the qcom rpmh driver
> > (drivers/soc/qcom/rpmh-rsc.c) to be a module.  As I mentioned to Paul,
> > it registers a cpu_pm notifier callback, which calls its
> > __tcs_buffer_write() function. The trace in the __tcs_buffer_write()
> > function was just converted to using rcuidle to address bugs seen when
> > it was being called from idle.
> >
> > > Currently, Thomas and Peter are working on removing trace events from
> > > places that don't have RCU enabled, or at least cleaning up the context
> > > switches from user to kernel to interrupt.
> >
> > So does that mean folks would most likely lean to trying to remove the
> > tracepoint rather than reevaluating allowing the rcuidle call to be
> > made from the module?
> >
>
> No. The clean up is to try to make the switch from each context small, fast
> and safe. But what you are describing is the switch to idle, which is a
> different story and something that there's some talk about cleaning up, but
> not at the same level. Especially if there's more complex code that is
> happening with RCU watching.
>
> Looking at the commit that keeps trace_*_rcuidle() code out:
>
>   7ece55a4a3a04a ("trace: Don't declare trace_*_rcuidle functions in modules")
>
> Which was added because the rcuidle variant called RCU code that was not
> exported either. Which would have the same issue now as
> rcu_irq_exit_irqson() is also not exported. Which would be needed.

Right, reverting that change and adding the exports seems like the
most direct solution, but I suspect that wasn't done back in the day
for a good reason. So I'm just trying to better understand that
reason.

> Hmm, isn't module code itself synchronized via RCU. Then having module code
> being called without RCU "watching" could be dangerous?

I'm not sure I'm following you here. Could you explain more?

thanks
-john
