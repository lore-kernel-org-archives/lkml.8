Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B5C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:09:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AF6D2076D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 22:09:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NWwrkLgQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731026AbgDOWJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 18:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727993AbgDOWHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 18:07:54 -0400
Received: from mail-oo1-xc41.google.com (mail-yw1-xc41.google.com [IPv6:2607:f8b0:4864:20::c41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8700BC061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:07:54 -0700 (PDT)
Received: by mail-oo1-xc41.google.com with SMTP id x17so228991ooa.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 15:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AO8FQcIBS/InzSZoeDG5+CPMG3oUisZA/X5pOuP5vKs=;
        b=NWwrkLgQP+I0zsUOocKLhWk4/pd13XLNZZo4NAu1rj4CpSl2oULy3J5lL+MuKsMfi8
         okI6YaIF50qSPE0pvu3keBgsqlpZufgrH0zsZo5+wSDnF7/7C01jRta8EtEmv112+oSX
         KBkKlexajWQaQiuluOMmBlZ11aoSFMFRsoNhO8D7Id9L69oaVg2FrLMMX/vnG56eexc7
         NMulOCOVt36rLyeqoYhrGO6KES0n1PSZeQ/NVN/1UOlhOrGzQzO3UWEDdy5y1tNmuSWv
         hYYJYI4JaB6sbkqnpJGzHH4PtohC3bYq+lBw0GxnAfAuz3h8e0V3LGz3ByPDRfkaMVAz
         Q44w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AO8FQcIBS/InzSZoeDG5+CPMG3oUisZA/X5pOuP5vKs=;
        b=IPu6Np1iX93ks7V8aEnL7/tKMiDdg7dCcuxNS9hWiJ3Zx3/Aookj8OebZ+6lUlFURS
         lauWUfl04VJSnGGc81UN9q78z5ef+Qn2BGCgNviNnyZeDTgmrXB0pD6fKeKl/Jk+hbUF
         PT7IDZv10BDLv7MowYdheZeFQQ5sx04HxKUCAhXqOu76Ii2PPneEtP0K0EEDFzMMzmoQ
         OZhVBWJdDy6Lz3fxA0KKOp47eGydVvRnOos7cAnarXSS4rIxdz7p/Mna9NeOknnJUoRZ
         zMO+ljfyQ7Q0XdSbxwE1zxP6/rKUYufLbWWWHMFngfsuP0eD8yiCvT4Xif8k7iCZvmw/
         mBiQ==
X-Gm-Message-State: AGi0Pub/z85IIZ45h8ej3CDU/g+FBh4jBmveTVMPAWdHZKQ72KGT7BG8
        I3odozKSMlkTlk5HD4ikYDOb9n77FkE6JfhV3opDSQ==
X-Google-Smtp-Source: APiQypJPHRBWQswBCsfIxkxlXFaBUB4SFmPRN+miP1DTmokHqJMRVTUBdHdwPOglEoy0vy+uFKvVltmuJeTU3BdAdUE=
X-Received: by 2002:a4a:df05:: with SMTP id i5mr24869527oou.9.1586988473299;
 Wed, 15 Apr 2020 15:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLV4rM74wuzuZ+BkUi+keccxkAxv30N4vrFO7CVQ5vnT1A@mail.gmail.com>
 <20200415085348.5511a5fe@gandalf.local.home> <CALAqxLV1A6sOC1GWpFYXeBoDff0+AJgoOYK7NktcTdvX3kvAeg@mail.gmail.com>
 <20200415161424.584d07d3@gandalf.local.home> <CALAqxLU26PVFPSza5GceSF6gTVdzo_2D3G0dBp0KZXvAWFUktA@mail.gmail.com>
 <20200415164116.40564f2c@gandalf.local.home> <CALAqxLW6jqr38bk8pp-Hom2=MLm3coTmzCP8MMfrDvMfx388=Q@mail.gmail.com>
 <20200415174918.154a86d0@gandalf.local.home>
In-Reply-To: <20200415174918.154a86d0@gandalf.local.home>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 15 Apr 2020 15:07:42 -0700
Message-ID: <CALAqxLUMnjAYdnTBNHmzjw3L8qfeZb8UVVaenzxtwN3UxNcWJg@mail.gmail.com>
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

On Wed, Apr 15, 2020 at 2:49 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 15 Apr 2020 14:02:04 -0700
> John Stultz <john.stultz@linaro.org> wrote:
>
> >
> > So in my case your concerns may not be a problem, but I guess
> > generally it might. Though I'd hope the callback would be unregistered
> > (and whatever waiting for the grace period to complete be done) before
> > the module removal is complete. But maybe I'm still missing your
> > point?
>
> Hmm, you may have just brought up a problem here...
>
> You're saying that cpu_pm_register_notifier() callers are called from non
> RCU watching context? If that's the case, we have this:

Wait? what? I don't think I'm saying that.  :) I'm just trying to fix
a build issue that prevents a driver from being a module since it has
a trace_*_rcuidle call in it.

Honestly, I really don't know much about how the cpu pm notifiers
interact with rcu.  It's just this recent change, which seems
necessary, now seemingly prevents the driver from being built as a
module:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=efde2659b0fe835732047357b2902cca14f054d9

Maybe there's a better solution than using trace_*_rcuidle?

thanks
-john
