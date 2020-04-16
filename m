Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB90C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDB772076C
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ocH153bK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391223AbgDPAGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729647AbgDPAGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:06:38 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0F3C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:06:36 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id b13so1644823oti.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qos28LA3on13Mb6DCgYfi/34B7cwVyoTIvoHbG1lrjU=;
        b=ocH153bKjZVEyX2nyrgcctLt6dl13sLTtiTH82ZvA8xrlqqL9ynNr0pLMx3RXnewnE
         p23k+yuVm9QOYn36WZTuD+zirhHVi9EZIwmScB+yf9LftFA3ZFzEDP/idZgxxBWbiEJF
         e1M11TNp1i2IgLZIdbeXtLz6Kv6qhqbk1LsQ8CzSTQmwzZJAvk1Ad1+VwyUf1PjY1Kem
         gdu7brc6bYddxJWyA8LmgUz9OxW8JobDzQwjtczcLMOJ8speNyv8IydTwpMACHSGLEdL
         r875OQZE/Pgni75dmTJnIHsGVYgH6XRJlisX/Sx+UgK2dHmlCeYe/nKV33gOb4a9wuKD
         tpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qos28LA3on13Mb6DCgYfi/34B7cwVyoTIvoHbG1lrjU=;
        b=Bi3mcakkXCJ603ZUy3I7ejTfdOOB44Efb4PW1LsD+e3iSeYDLs4c1MAB1Br4fk3BUl
         1lUUQvkUNrIScHiMF9av1a4eCFh3Mwoyo4Zy93Iid+xn2ar8jo7U2RGGfnHMTY9DJHGe
         EDnmzyJbtILO0cQJ6k/edhyj0SkVGUeNAXE/4m8aIBucCst/cb0YxOTTt0z7Y/ecRVW/
         Lf1cgReS6ojuf2iEUiJ7wq93nibMJKxIM/DXeVh+P6G8+yb3o4Oamt91w0f9GYZyRoKr
         ni5aWR25LRdT52gp6+gS9SqFuY6yQScUBd+ZJnKhiRvVvkAFvm5fcP+DcQc7SFoP24sJ
         EjKw==
X-Gm-Message-State: AGi0PubSx+1WEl6hUsitX8Er1/fpuM8l/FUX1FTDXiAF5ckk/RNlCg3b
        hjOulXEyhtTvv8o8dYRO/xnpjyAVw3zpFvBQwi8LDQ==
X-Google-Smtp-Source: APiQypIJMrl4iVbSnTQs52d04zCKLLpXN3SgUoNWZHs/s0e7OkCr4T77ZnR9N40RqQwHv33zAnLFQkVOhqBJ6CegVx0=
X-Received: by 2002:a9d:3988:: with SMTP id y8mr14712321otb.352.1586995596022;
 Wed, 15 Apr 2020 17:06:36 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home> <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home> <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
 <20200415164116.40564f2c@gandalf.local.home> <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
 <20200415174918.154a86d0@gandalf.local.home> <20200415220459.GE17661@paulmck-ThinkPad-P72>
 <20200415185121.381a4bc3@gandalf.local.home>
In-Reply-To: <20200415185121.381a4bc3@gandalf.local.home>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Apr 2020 17:06:24 -0700
Message-ID: <CALAqxLX2UDQ7=dvzMoP6g-rYzw9dBebrynMfo4Gnv=SzaqhE=g@mail.gmail.com>
Subject: Re: On trace_*_rcuidle functions in modules
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
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

On Wed, Apr 15, 2020 at 3:51 PM Steven Rostedt <rostedt@goodmis.org> wrote:
> I was about to suggest a patch, but that has already been written...
>
> 313c8c16ee62b ("PM / CPU: replace raw_notifier with atomic_notifier")
>
> Which surrounds the notifier callbacks with rcu_irq_enter_irqson()
>
> Which means that if John moves the code to use the notifier, then he could
> also remove the _rcuidle(), because RCU will be watching.

So you're saying the recent change to move to using trace_*_rcuidle()
was unnecessary?

Or is there a different notifier then cpu_pm_register_notifier() that
the driver should be using (that one seems to be using
atomic_notifier_chain_register())?

thanks
-john
