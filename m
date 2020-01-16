Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8D06C32771
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C28D207E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 01:45:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NUQfXiZb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730370AbgAPBpr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 20:45:47 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42218 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgAPBpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 20:45:47 -0500
Received: by mail-lj1-f193.google.com with SMTP id y4so20751672ljj.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 17:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+RQyzgBTq/ON6P2+wJSZt2wyW+FlNHJHg+NSKeDmFE=;
        b=NUQfXiZb7391JB22uSyaFTtB4xoyTOL60AdEkWdUh9rxn3xgqHIqBIQpQ9yOWzqBXs
         62FYnY/2uSynVunTrZJ8JYuDmTz8jZF6jOn7HOVMhJX3z4m9s9bL73CXe8BKLMOz5YIl
         XdYCgmMNvQZ4n6Byp11D9S9bCCS57BSDMynfZrfNaOJW3E2ExHmELrlRs0lQfUqAN4DL
         dgzBx3qRnlKImZtiOQ+nKIbLa1FIbL49mGsAeLkZYfgs75BdTKc8gPPNQiPaI1v71Lyw
         sBSAjPQWnIw+uXBomVWjbWzV4XSeoiHgMQe1nO0SmAkMDbfva4H1eLJRCVuMFArrQrPI
         dbFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+RQyzgBTq/ON6P2+wJSZt2wyW+FlNHJHg+NSKeDmFE=;
        b=fsPxyRl/HySQ/U+52Yh9zGowtzldQmW3l/jm9GqxDZLZWksifygIy+AN9PE8yD7Nvd
         s2kVur2OkbgHnosbKfPKF0b20oT18JPPmu8sCOUxmwDsdWDy10aPn0wJ8X18EkGbQaQf
         FYc4EKjp6A/ur3IHs9v8bB+uVJKT30baI9vGzVz6f0ETH4IO7c9tANp+80ZcmXsaDFPC
         LN1lxc1WqeCuGJrWBjk7v0hFVFpDG4hveSN43Q0e5+aLbiHKoBhXqudts7fEpQRHrHVN
         qbomFWbTjBIUiyQ5VWkjSVc2y64+E7URHm8KvASsikGf4wGyImOQiU22hWmnRfPyEEuR
         kP+Q==
X-Gm-Message-State: APjAAAVSFLdK9jbhzlX1g8lwoS8AVAV138Od2FL1XoUYtF5YrFV6OnhS
        BD7Jxj8C9ev6YkaSrNN1Kl095Il5lqtxCwkvsPI=
X-Google-Smtp-Source: APXvYqyS0Lev/bxVn6XJvsngSBDaCup/fvOuKS3i1TkfXUrcWrb0SPAGKurZCEgWoS1m5HQmozfoMHG2L6QpgpaGMKY=
X-Received: by 2002:a2e:9d90:: with SMTP id c16mr669463ljj.264.1579139144680;
 Wed, 15 Jan 2020 17:45:44 -0800 (PST)
MIME-Version: 1.0
References: <cover.1572437285.git.vpillai@digitalocean.com>
 <5e3cea14-28d1-bf1e-cabe-fb5b48fdeadc@linux.intel.com> <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <8f9acfb3-28e0-8d3e-08e0-77f04410cf38@linux.intel.com> <1cc62dbe-348e-affa-8740-c162e1454510@linux.intel.com>
In-Reply-To: <1cc62dbe-348e-affa-8740-c162e1454510@linux.intel.com>
From:   Aubrey Li <aubrey.intel@gmail.com>
Date:   Thu, 16 Jan 2020 09:45:29 +0800
Message-ID: <CAERHkrsaXAgE4MyE6ZehZ8cSq0bVrjc5uJnE9GwLCk4dp1hS9g@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Dario Faggioli <dfaggioli@suse.com>,
        =?UTF-8?B?RnLDqWTDqXJpYyBXZWlzYmVja2Vy?= <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 3:33 AM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> On 1/14/20 7:43 PM, Li, Aubrey wrote:
> > On 2020/1/14 23:40, Vineeth Remanan Pillai wrote:
> >> On Mon, Jan 13, 2020 at 8:12 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
> >>
> >>> I also encountered kernel panic with the v4 code when taking cpu offline or online
> >>> when core scheduler is running.  I've refreshed the previous patch, along
> >>> with 3 other patches to fix problems related to CPU online/offline.
> >>>
> >>> As a side effect of the fix, each core can now operate in core-scheduling
> >>> mode or non core-scheduling mode, depending on how many online SMT threads it has.
> >>>
> >>> Vineet, are you guys planning to refresh v4 and update it to v5?  Aubrey posted
> >>> a port to the latest kernel earlier.
> >>>
> >> Thanks for the updated patch Tim.
> >>
> >> We have been testing with v4 rebased on 5.4.8 as RC kernels had given us
> >> trouble in the past. v5 is due soon and we are planning to release v5 when
> >> 5.5 comes out. As of now, v5 has your crash fixes and Aubrey's changes
> >> related to load balancing.
> >
> > It turns out my load balancing related changes need to be refined.
> > For example, we don't migrate task if the task's core cookie does not match
> > with CPU's core cookie, but if the entire core is idle, we should allow task
> > migration, something like the following:
> >
> > I plan to do this after my Chinese New Year holiday(Feb 3rd).
> >
> > Thanks,
> > -Aubrey
> >
>
> Aubrey's attached patch should replace his previous patch
> sched/fair: don't migrate task if cookie not match
>
> I've also added a fix below for Aubrey's patch
> sched/fair: find cookie matched idlest CPU.
>
> Aubrey, can you merge this fix into that patch when you update
> your patches?

Thanks Tim, I'll include your fix when I update my patches.

-Aubrey
