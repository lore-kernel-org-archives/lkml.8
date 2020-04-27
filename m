Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E8C81CFF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3CB72074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 22:17:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="R56Sl/G7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgD0WR5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 18:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726224AbgD0WR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 18:17:56 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65095C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:17:55 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mq3so235429pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 15:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PBimLEwchozPela6tJLfbh5qKfAypxdXlYuZ1GDpfOQ=;
        b=R56Sl/G7PTx7+6SlI0DRO5f0Ah9asmUN7kq9UxGrM7D9FxNC3cnzicgZbBZQwchf13
         bpnTl9NrRpvgiJM8JqsRE7uf3uynhZ7lNIXzMi028bi76dOEmHtbR05zwacMMqRxFWLX
         TTTEGoXGxFMG0Fez6VCeHGCwyXZQ1mS5mCL07EcWKqM2i4oxPANp9f0qhflnUEFD5U2A
         f17oiWcIvRV+PJqDtJ4dIK6NH2P8y3m4vg+6Rr6n+JS+fC/SNTj11RZZ/3X7EdaPeidO
         YDjrCqEi/E8kitRDroFDLBnfsZc4Q8luX+skyaYZ662263qfDMdDIlBQOl2BRWN37ijb
         +Opw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PBimLEwchozPela6tJLfbh5qKfAypxdXlYuZ1GDpfOQ=;
        b=RcQgg+Zs6EnsLlAn6bR0mWLCDdYM8sqeNw5FKxrY07CtikFS+sjamuuLxN7kigK0q8
         eGKtHrGyHAEKTEHI+iDQ0U3xgbLwaE1KN4HOSjX27C5Z4YK1gL/6WNfXyK8kz5FHH7F9
         FRIEWnhLwId5p8ak00j3Rk9NezFakZtRLVcZy5LWjF7hAIViRYvtJ0GNpY0t3SE+efOD
         /cDvAFO3XNVJDLMBrR8Ou0UC9445wYnw3ZIBNK5m7Hicw5JvE86bIRdF+3Dx3jF8nmCH
         EO+BgvKFWHqCwVmfVQtUR9T8QOAQZ8csCeQpgq1tUz0aauiFm9Q/27nxtceKjgPpA4y+
         GYOQ==
X-Gm-Message-State: AGi0PuYBxM627Rsv8lowgMGC6pwXAA9FVYXcBfQcQmpRcZmniMalltZy
        HhULf3+PfWmOd8yNbUdz2FTBrA==
X-Google-Smtp-Source: APiQypJRmWyE08l99aE7RMrrsMDgaYHPpzSzFaGCUbxbr8exoprdNn/+F+76NAeFO7HMetfdJ2TqSQ==
X-Received: by 2002:a17:902:aa88:: with SMTP id d8mr26681797plr.213.1588025874662;
        Mon, 27 Apr 2020 15:17:54 -0700 (PDT)
Received: from localhost (c-73-170-36-70.hsd1.ca.comcast.net. [73.170.36.70])
        by smtp.gmail.com with ESMTPSA id g184sm13320823pfb.80.2020.04.27.15.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 15:17:54 -0700 (PDT)
Date:   Mon, 27 Apr 2020 15:17:52 -0700
From:   Sandeep Patil <sspatil@android.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
Message-ID: <20200427221752.GA166576@google.com>
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
 <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org>
 <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
 <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org>
 <CAGETcx9sc6oWSPK=aWJ+39i9eHAyg6iOf+Xf2oVECO+g1pFjtQ@mail.gmail.com>
 <573b7d9e-fb5d-5c81-a981-6d965db933f3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <573b7d9e-fb5d-5c81-a981-6d965db933f3@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Mon, Apr 27, 2020 at 10:50:24PM +0200, Daniel Lezcano wrote:
> On 27/04/2020 22:12, Saravana Kannan wrote:
> > On Mon, Apr 27, 2020 at 1:09 PM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 27/04/2020 21:04, Saravana Kannan wrote:
> >>> On Mon, Apr 27, 2020 at 10:13 AM Daniel Lezcano
> >>> <daniel.lezcano@linaro.org> wrote:
> >>>>
> >>>> On 13/04/2020 04:55, Baolin Wang wrote:
> >>>>> Hi Daniel,
> >>>>>
> >>>>> On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >>>>>>
> >>>>>> From: Saravana Kannan <saravanak@google.com>
> >>>>>>
> >>>>>> This allows timer drivers to be compiled as modules.
> >>>>>>
> >>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>>>>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >>>>>
> >>>>> Do you have any comments for this patch set? Thanks.
> >>>>
> >>>> If my understanding is correct, this patch is part of the GKI picture
> >>>> where hardware drivers are converted to modules.
> >>>>
> >>>> But do we really want to convert timer drivers to modules ?
> >>>>
> >>>> Is the core time framework able to support that (eg. load + unload )
> >>>
> >>> So this will mainly be used for secondary timers that the system
> >>> supports. Not for the main one that's set up during early boot for
> >>> sched timer to work. For the primary timer during boot up, we still
> >>> expect that to be the default ARM timer and don't want/expect that to
> >>> be a module (it can't be).
> >>
> >> My question is about clockevents_config_and_register() for instance, is
> >> there a function to unregister in the core framework ?
> > 
> > We can just have these modules be "permanent" modules that can't be
> > unloaded. They just need to not implement module_exit().
> 
> You are right.
> 
> I can understand the goal of making everything as much modular as possible.
> 
> But TBH, I have a bad feeling about this. Sounds like GKI will give the
> opportunity to companies to stop upstreaming their drivers and favoring
> fragmentation like what we had several years ago. Not sure it is a good
> thing, especially for upstream SoC support.

... and that is a very valid concern too IMO.

However, the way we see it, as things stand today, we don't even know what
goes into Linux on all android phones out there. We know what we add, as part
of the AOSP kernel, however, what actually runs on the device is normally
about a million lines of code changes on top of what we do.

So, for the GKI parts, we are doing the following

1. Making the peripheral drivers modules also means the GKI must have all the
core framework changes built-in. This gets us the list of core kernel changes
that ship on Android devices so we can work on upstreaming them OR find the
appropriate alternative. For Android, that answers the canonical
- "Where is the use case?" question coming from anyone.

You can see the list of these out-of-tree changes is growing by the day in
AOSP right now[1]. Its there for everyone to find in exactly *one place*.
Note that, almost all of those patches have been posted on the list already.
That's the first pre-requisite for any change that goes into AOSP kernel[2].

2. Once we have a core kernel that *truly* works on all Android devices, we
will have built up list of changes we want to upstream (or anyone can pick
them from our public tree). Android will still continue to move to newer
kernel versions easily (may be at a difference cadence ..)

3. About the incentive for upstream SoC support: As part of GKI, we are not
promising a forever stable kernel<->module interface. We still change it each
year. The *best way* for anyone to have their SoC / peripheral supported is
_still_ "going upstream". In fact, we advertise it as such[2]. The modularity
aspect just brings a much needed flexibility for execution.  The flexibility
is needed given the number of stakeholders involved just in the kernel as of
today. (Its a mix of Upstream, Google, SoC manufacturer, device maker and
many other small parts).


4. We also haven't been so keen on the "unloading" of a module. We know there
were subsystems where unloading may not work as expected. Then again, to my
knowledge, nobody has been stress testing with 500+ different modules that
register to all core frameworks being loaded and unloaded at random times.
Even if someone did, we just didn't think its worth the hassle or time at
this moment. Unloading the module didn't buy us anything. (Although, I do get
the point about "correctness"  -- so it shouldn't also be obviously broken)

- ssp

1. https://android.googlesource.com/kernel/common-patches/
2. https://android.googlesource.com/kernel/common/+/refs/heads/android-5.4/README.md
