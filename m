Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982CCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A9C020774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 00:08:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="D6RUqChe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHMAIo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 20:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbgHMAIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 20:08:43 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F54C061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:08:43 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id a1so2037571vsp.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ceUtlC6MwMGrTyun60sqF99SKDJbWcXggrKlx7677S4=;
        b=D6RUqChe/YBfnLLPy8n91WVpiwoeMX2S/KZsoS6uhmTVHOWCqH78TLtXUojHwHRONo
         eFshRZnXFOwrUDBMHS4C8vETplXnvtXsbaZifZjYrNAKcHcZ8C3yc2x79D/XZ9CSkgqF
         zeSNgiDAqnjky+Pb6dpc/OLwyXZsgiRBIKD4U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ceUtlC6MwMGrTyun60sqF99SKDJbWcXggrKlx7677S4=;
        b=sChI6F7vzfM6WiYOf0YkEm+QpKJBSKLiEmDWmMM633AeYths2K75hmIOyHrRKiUj2q
         LpQo0FxxwC9bO3p0BrtMUNtWLfSItzJw4NdPRkVoYL2yRM3wlif2t2fTbO7e09voVdrJ
         u11P9jwTplS/ZcrnFrUjnsu6lcN67+dbIdHSu6I3fd/e7L00QgXPYwOaieeHb3TL9Y71
         MtQiCAYTvSfZ0zuTWWdmvGobg2GSkUybuLqHqZCjdcwbNW2tPAbUqCCVbeX7nHiZJV0e
         krrg9hpnd8E+FwlJfKZrxP4pPDW/rqi+fQO5ix4GfY6ah0g3pQ116YcBBXO24GXGUXUX
         KMig==
X-Gm-Message-State: AOAM530v+tP83TuPmVR8U+QEN6xyaC7qJTbF70Btf4nzd26/V8OnKHbl
        Rzq6+dvU9pwbA/jTuawOnEfVE834QRI=
X-Google-Smtp-Source: ABdhPJwhNCcRFdqrSnLXn6cs421X5RtCN45JHgqrcJxD8IXqKOdjxQlPL4lj7g5ofHGrsoRkFNGeBQ==
X-Received: by 2002:a67:3349:: with SMTP id z70mr1282180vsz.93.1597277321754;
        Wed, 12 Aug 2020 17:08:41 -0700 (PDT)
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com. [209.85.222.47])
        by smtp.gmail.com with ESMTPSA id 67sm487650vsl.13.2020.08.12.17.08.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 17:08:40 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id v20so1133553ual.4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 17:08:40 -0700 (PDT)
X-Received: by 2002:a9f:2966:: with SMTP id t93mr1514582uat.90.1597277319479;
 Wed, 12 Aug 2020 17:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <1595333413-30052-1-git-send-email-sumit.garg@linaro.org>
 <CAFA6WYMN=na4Pxnu1LYRVAAZRdV==5EwU-Vcq-QkRb_jaLiPmw@mail.gmail.com>
 <20200811135801.GA416071@kroah.com> <CAFA6WYMN8i96rEZuHLnskB+4k0o=K9vF1_we83P04h2BSoGjmQ@mail.gmail.com>
 <20200811145816.GA424033@kroah.com> <CAD=FV=UD=cTn6jwpYS-C-=1ORd-4azZ8ZiBR6om++2sMS1nmMg@mail.gmail.com>
 <CAFA6WYPBdOiVsKR_hSLpigN_1b9jimXKaqyRZjvKSx3xpAmLjA@mail.gmail.com> <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
In-Reply-To: <CAD=FV=WccmFRkV4UUTLSYR9+7210h00Si=nG4tRs3BBuweA6ng@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 12 Aug 2020 17:08:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
Message-ID: <CAD=FV=V8UhQVQvcAp6XCmT3=6FYM=_zPELy4FTj4kMKUswaR8Q@mail.gmail.com>
Subject: Re: [RFC 0/5] Introduce NMI aware serial drivers
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        linux-serial@vger.kernel.org, kgdb-bugreport@lists.sourceforge.net,
        Jiri Slaby <jslaby@suse.com>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Wed, Aug 12, 2020 at 8:27 AM Doug Anderson <dianders@chromium.org> wrote:
>
> Hi,
>
> On Wed, Aug 12, 2020 at 7:53 AM Sumit Garg <sumit.garg@linaro.org> wrote:
> >
> > Hi Doug,
> >
> > On Tue, 11 Aug 2020 at 22:46, Doug Anderson <dianders@chromium.org> wrote:
> > >
> > > Hi,
> > >
> > > On Tue, Aug 11, 2020 at 7:58 AM Greg Kroah-Hartman
> > > <gregkh@linuxfoundation.org> wrote:
> > > >
> > > > On Tue, Aug 11, 2020 at 07:59:24PM +0530, Sumit Garg wrote:
> > > > > Hi Greg,
> > > > >
> > > > > Thanks for your comments.
> > > > >
> > > > > On Tue, 11 Aug 2020 at 19:27, Greg Kroah-Hartman
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > >
> > > > > > On Tue, Aug 11, 2020 at 07:20:26PM +0530, Sumit Garg wrote:
> > > > > > > On Tue, 21 Jul 2020 at 17:40, Sumit Garg <sumit.garg@linaro.org> wrote:
> > > > > > > >
> > > > > > > > Make it possible for UARTs to trigger magic sysrq from an NMI. With the
> > > > > > > > advent of pseudo NMIs on arm64 it became quite generic to request serial
> > > > > > > > device interrupt as an NMI rather than IRQ. And having NMI driven serial
> > > > > > > > RX will allow us to trigger magic sysrq as an NMI and hence drop into
> > > > > > > > kernel debugger in NMI context.
> > > > > > > >
> > > > > > > > The major use-case is to add NMI debugging capabilities to the kernel
> > > > > > > > in order to debug scenarios such as:
> > > > > > > > - Primary CPU is stuck in deadlock with interrupts disabled and hence
> > > > > > > >   doesn't honor serial device interrupt. So having magic sysrq triggered
> > > > > > > >   as an NMI is helpful for debugging.
> > > > > > > > - Always enabled NMI based magic sysrq irrespective of whether the serial
> > > > > > > >   TTY port is active or not.
> > > > > > > >
> > > > > > > > Currently there is an existing kgdb NMI serial driver which provides
> > > > > > > > partial implementation in upstream to have a separate ttyNMI0 port but
> > > > > > > > that remained in silos with the serial core/drivers which made it a bit
> > > > > > > > odd to enable using serial device interrupt and hence remained unused. It
> > > > > > > > seems to be clearly intended to avoid almost all custom NMI changes to
> > > > > > > > the UART driver.
> > > > > > > >
> > > > > > > > But this patch-set allows the serial core/drivers to be NMI aware which
> > > > > > > > in turn provides NMI debugging capabilities via magic sysrq and hence
> > > > > > > > there is no specific reason to keep this special driver. So remove it
> > > > > > > > instead.
> > > > > > > >
> > > > > > > > Approach:
> > > > > > > > ---------
> > > > > > > >
> > > > > > > > The overall idea is to intercept serial RX characters in NMI context, if
> > > > > > > > those are specific to magic sysrq then allow corresponding handler to run
> > > > > > > > in NMI context. Otherwise, defer all other RX and TX operations onto IRQ
> > > > > > > > work queue in order to run those in normal interrupt context.
> > > > > > > >
> > > > > > > > This approach is demonstrated using amba-pl011 driver.
> > > > > > > >
> > > > > > > > Patch-wise description:
> > > > > > > > -----------------------
> > > > > > > >
> > > > > > > > Patch #1 prepares magic sysrq handler to be NMI aware.
> > > > > > > > Patch #2 adds NMI framework to serial core.
> > > > > > > > Patch #3 and #4 demonstrates NMI aware uart port using amba-pl011 driver.
> > > > > > > > Patch #5 removes kgdb NMI serial driver.
> > > > > > > >
> > > > > > > > Goal of this RFC:
> > > > > > > > -----------------
> > > > > > > >
> > > > > > > > My main reason for sharing this as an RFC is to help decide whether or
> > > > > > > > not to continue with this approach. The next step for me would to port
> > > > > > > > the work to a system with an 8250 UART.
> > > > > > > >
> > > > > > >
> > > > > > > A gentle reminder to seek feedback on this series.
> > >
> > > It's been on my list for a while.  I started it Friday but ran out of
> > > time.  This week hasn't been going as smoothly as I hoped but I'll
> > > prioritize this since it's been too long.
> > >
> >
> > No worries and thanks for your feedback.
> >
> > >
> > > > > > It's the middle of the merge window, and I can't do anything.
> > > > > >
> > > > > > Also, I almost never review RFC patches as I have have way too many
> > > > > > patches that people think are "right" to review first...
> > > > > >
> > > > >
> > > > > Okay, I understand and I can definitely wait for your feedback.
> > > >
> > > > My feedback here is this:
> > > >
> > > > > > I suggest you work to flesh this out first and submit something that you
> > > > > > feels works properly.
> > > >
> > > > :)
> > > >
> > > > > IIUC, in order to make this approach substantial I need to make it
> > > > > work with 8250 UART (major serial driver), correct? As currently it
> > > > > works properly for amba-pl011 driver.
> > > >
> > > > Yes, try to do that, or better yet, make it work with all serial drivers
> > > > automatically.
> > >
> > > A bit of early feedback...
> > >
> > > Although I'm not sure we can do Greg's "make it work everywhere
> > > automatically", it's possible you could get half of your patch done
> > > automatically.  Specifically, your patch really does two things:
> > >
> > > a) It leaves the serial port "active" all the time to look for sysrq.
> > > In other words even if there is no serial client it's always reading
> > > the port looking for characters.  IMO this concept should be separated
> > > out from the NMI concept and _could_ automatically work for all serial
> > > drivers.  You'd just need something in the serial core that acted like
> > > a default client if nobody else opened the serial port.  The nice
> > > thing here is that we go through all the normal code paths and don't
> > > need special cases in the driver.
> >
> > Okay, will try to explore this option to have default serial port
> > client. Would this client be active in normal serial operation or only
> > active when we have kgdb active? One drawback I see for normal
> > operation could be power management as if user is not using serial
> > port and would like to disable corresponding clock in order to reduce
> > power consumption.
>
> If I could pick the ideal, I'd say we'd do it any time the console is
> configured for that port and magic sysrq is enabled.  Presumably if
> they're already choosing to output kernel log messages to the serial
> port and they've enabled magic sysrq they're in a state where they'd
> be OK with the extra power of also listening for characters?
>
>
> > > b) It enables NMI for your particular serial driver.  This seems like
> > > it'd be hard to do automatically because you can't do the same things
> > > at NMI that you could do in a normal interrupt handler.
> >
> > Agree.
> >
> > >
> > > NOTE: to me, a) is more important than b) (though it'd be nice to have
> > > both).  This would be especially true the earlier you could make a)
> > > work since the main time when an "agetty" isn't running on my serial
> > > port to read characters is during bootup.
> > >
> > > Why is b) less important to me? Sure, it would let you drop into the
> > > debugger in the case where the CPU handling serial port interrupts is
> > > hung with IRQs disabled, but it _woudln't_ let you drop into the
> > > debugger in the case where a different CPU is hung with IRQs disabled.
> > > To get that we need NMI roundup (which, I know, you are also working
> > > on for arm64).  ...and, if we've got NMI roundup, presumably we can
> > > find our way into the debugger by either moving the serial interrupt
> > > to a different CPU ahead of time or using some type of lockup detector
> > > (which I know you are also working on for arm64).
> > >
> >
> > Thanks for sharing your preferences. I will try to get a) sorted out first.
> >
> > Overall I agree with your approaches to debug hard-lockup scenarios
> > but they might not be so trivial for kernel engineers who doesn't
> > posses kernel debugging experience as you do. :)
> >
> > And I still think NMI aware magic sysrq is useful for scenarios such as:
> > - Try to get system information during hard-lockup rather than just
> > panic via hard-lockup detection.
> > - Do normal start/stop debugger activity on a core which was stuck in
> > hard-lockup.
> > - Random boot freezes which are not easily reproducible.
>
> Don't get me wrong.  Having sysrq from NMI seems like a good feature
> to me.  That being said, it will require non-trivial changes to each
> serial driver to support it and that means that not all serial drivers
> will support it.  It also starts requiring knowledge of how NMIs work
> (what's allowed in NMI mode / not allowed / how to avoid races) for
> authors of serial drivers.  I have a bit of a worry that the benefit
> won't outweigh the extra complexity, but I guess time will tell.  One
> last worry is that I assume that most people testing (and even
> automated testing labs) will either always enable NMI or won't enable
> NMI.  That means that everyone will be only testing one codepath or
> the other and (given the complexity) the non-tested codepath will
> break.
>
> Hrm.  Along the lines of the above, though: almost no modern systems
> are uniprocessor.  That means that even if one CPU is stuck with IRQs
> off it's fairly likely that some other CPU is OK.  Presumably you'd
> get almost as much benefit as your patch but with more done
> automatically if you could figure out how to detect that the serial
> interrupt isn't being serviced and re-route it to a different CPU.
> ...or possibly you could use some variant of the hard lockup detector
> and move all interrupts off a locked up CPU?  You could make this an
> option that's "default Y" when kgdb is turned on or something?

One other idea occurred to me that's maybe simpler.  You could in
theory just poll the serial port periodically to accomplish.  It would
actually probably even work to call the normal serial port interrupt
routine from any random CPU.  On many serial drivers the entire
interrupt handler is wrapped with:

spin_lock_irqsave(&uap->port.lock, flags);
...
spin_unlock_irqrestore(&uap->port.lock, flags);

And a few (the ones I was involved in fixing) have the similar pattern
of using uart_unlock_and_check_sysrq().

Any serial drivers following this pattern could have their interrupt
routine called periodically just to poll for characters and it'd be
fine, right?  ...and having it take a second before a sysrq comes in
this case is probably not the end of the world?


One nice benefit of this is that it would actually work _better_ on
SMP systems for any sysrqs that aren't NMI safe.  Specifically with
your patch series those would be queued with irq_work_queue() which
means they'd be blocked if the CPU processing the NMI is stuck with
IRQs disabled.  With the polling mechanism they'd nicely just run on a
different CPU.


> > > One last bit of feedback is that I noticed that you didn't try to
> > > implement the old "knock" functionality of the old NMI driver that's
> > > being deleted.  That is: your new patches don't provide an alternate
> > > way to drop into the debugger for systems where BREAK isn't hooked up.
> > > That's not a hard requirement, but I was kinda hoping for it since I
> > > have some systems that haven't routed BREAK properly.  ;-)
> > >
> >
> > Yeah, this is on my TODO list to have a kgdb "knock" functionality to
> > be implemented via a common hook in serial core.
> >
> > >
> > > I'll try to get some more detailed feedback in the next few days.
> >
> > Thanks. I do look forward to your feedback.
> >
> > -Sumit
> >
> > >
> > > -Doug
