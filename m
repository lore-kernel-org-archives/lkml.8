Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDCCC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 04:35:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62A3320716
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 04:35:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="I9KVZ5eJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbgICEfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 00:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbgICEfB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 00:35:01 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5722FC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 21:35:01 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id t4so1333697iln.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 21:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVv8DE6SdOtxfDyEUh3/sagSCnIfWw44Yhch2xusBWw=;
        b=I9KVZ5eJM8+v7YILLP6lV1HYxv97kj0FoCOypE/HmxwRPsUss17kom8Ro+/pwLI4Cp
         jVWj7k0wtMO1Am/PAzO4VTg7TZg8jC1XZKZ777+YWBWSa2zeL3EL4X+9lLKvY3ypk+Td
         8YJYJLCcbkl1kDtAkSut7JqahLA+UHCFWcOGo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVv8DE6SdOtxfDyEUh3/sagSCnIfWw44Yhch2xusBWw=;
        b=DTpWh1mR9dQhwBD1Hae2gux7Vb+n23mvElrXzdWII8Dqy8SmfMKObaDfDF7Boq85Yo
         reS9N9ddqFOeOYE/FPOJHqKYts44lJkDzPWQe5GnMoz1/pIhHH3zCaSHkV5a1ONmtgww
         kaJUXICkbe+lU7Jhm74yk4m9I9IENrMcQrwEppMam38xI++vJdvQHa1JsF/HVVCqNSpR
         sTeaLQ15jOqLkNXWBldadnCS2lCVMXzAeavDw9qKMLIfOAuLtYKPRGpOnHaKuz1qi1kq
         vTfNVBj0S7zocEVBEYFNZaKHX+Dm4TMU/REQ1/f3zBpSrtlGYf7+/YYQAE4F/U6dDbWe
         l1bw==
X-Gm-Message-State: AOAM533No84W4c9+mVaZ5/Zt96AcIRGycl6Iapszbv7FRTtd5NNFo4H3
        oQdlq6cL7i7v5n7cjpBoM5a5DxiyKS/e+/BtVIG4bC2Bq1V1cA==
X-Google-Smtp-Source: ABdhPJx2KtRzkTO5/wanYvrqJ9e4W6Nu6gXKCTinJAsh4vkwDNi/B+6+60EgDvvxdvOw5nSkO8xVyhlcpb/79aCX2s4=
X-Received: by 2002:a92:48da:: with SMTP id j87mr1650473ilg.78.1599107699373;
 Wed, 02 Sep 2020 21:34:59 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
 <87y2lth4qa.fsf@nanos.tec.linutronix.de> <20200901165052.GA1662854@google.com>
 <875z8xl0zh.fsf@nanos.tec.linutronix.de> <20200902012905.GB1703315@google.com>
 <87h7sgk41y.fsf@nanos.tec.linutronix.de> <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com>
In-Reply-To: <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 3 Sep 2020 00:34:48 -0400
Message-ID: <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
To:     Dario Faggioli <dfaggioli@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, vineeth@bitbyteword.org,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com,
        Steven Rostedt <rostedt@goodmis.org>,
        Patrick Bellasi <derkling@google.com>,
        =?UTF-8?B?YmVuYmppYW5nKOiSi+W9qik=?= <benbjiang@tencent.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 12:57 PM Dario Faggioli <dfaggioli@suse.com> wrote:
>
> On Wed, 2020-09-02 at 09:53 +0200, Thomas Gleixner wrote:
> > On Tue, Sep 01 2020 at 21:29, Joel Fernandes wrote:
> > > On Tue, Sep 01, 2020 at 10:02:10PM +0200, Thomas Gleixner wrote:
> > > >
> > > Or, are you saying users may want 'core scheduling' enabled but may
> > > want to
> > > leave out the kernel protection?
> >
> > Core scheduling per se without all the protection muck, i.e. a
> > relaxed
> > version which tries to gang schedule threads of a process on a core
> > if
> > feasible has advantages to some workloads.
> >
> Indeed! For at least two reasons, IMO:
>
> 1) what Thomas is saying already. I.e., even on a CPU which has HT but
> is not affected by any of the (known!) speculation issues, one may want
> to use Core Scheduling _as_a_feature_. For instance, for avoiding
> threads from different processes, or vCPUs from different VMs, sharing
> cores (e.g., for better managing their behavior/performance, or for
> improved fairness of billing/accounting). And in this case, this
> mechanism for protecting the kernel from the userspace on the other
> thread may not be necessary or interesting;

Agreed. So then I should really make this configurable and behind a
sysctl then. I'll do that.

> 2) protection of the kernel from the other thread running in userspace
> may be achieved in different ways. This is one, sure. ASI will probably
> be another. Hence if/when we'll have both, this and ASI, it would be
> cool to be able to configure the system in such a way that there is
> only one active, to avoid paying the price of both! :-)

Actually, no. Part of ASI will involve exactly what this patch does -
IPI-pausing siblings but ASI does so when they have no choice but to
switch away from the "limited kernel" mapping, into the full host
kernel mapping. I am not sure if they have yet implemented that part
but they do talk of it in [1] and in their pretty LPC slides.  It is
just that ASI tries to avoid that scenario of kicking all siblings out
of guest mode.  So, maybe this patch can be a stepping stone to ASI.
At least I got the entry hooks right, and the algorithm is efficient
IMO (useless IPIs are avoided).  ASI can then come in and avoid
sending IPIs even more by doing their limited-kernel-mapping things if
needed. So, it does not need to be this vs ASI, both may be needed.

Why do you feel that ASI on its own offers some magical protection
that eliminates the need for this patch?

 thanks,

 - Joel

[1]  The link https://lkml.org/lkml/2019/5/13/515 mentions "note that
kicking all sibling hyperthreads is not implemented in this serie"
