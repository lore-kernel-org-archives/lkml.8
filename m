Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF5C3815B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:26:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEE4D214D8
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 02:26:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="V30o8GJZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgDRCZt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 22:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725320AbgDRCZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 22:25:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DD9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 19:25:48 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id z90so3731458qtd.10
        for <linux-kernel@vger.kernel.org>; Fri, 17 Apr 2020 19:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1vnkg1cU3W36p5WpbAUG3mXnEZbIo8zAwLm/aKe5cfs=;
        b=V30o8GJZ8a6+/mF7fcwkclmikrOVAZQZJnWUX/f2+lwCnGgf7YrI7I2vKJ+3uAO1rv
         NfLLeInDgLhyjP93cNVYTX5OaBUW1NKl4uMey4WO6PXzvdMaP4Lyfumo5wsNO7cE8Fc/
         LEaHOklR6iYFQtV9Yz6swgToXKDwQd/7wa+yM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1vnkg1cU3W36p5WpbAUG3mXnEZbIo8zAwLm/aKe5cfs=;
        b=HwRrLC145Q/UDITu281eB+kp6XfEMmBHXocHQO4Xl6Opxg4pnTTfFAQdYqJ2yQtm7P
         vMjsaVA/ajygPlsXTqHXh4jYh7GU6DZ+toQH1PkA1bXtBZeFqQ6/83xH4pABwqMUmJfh
         I+HSSK/RxysSCUDWetGNxr7cNy9ar8WCtpNt5a+7L+agYlRx1O18bXIv/r6P+Kp3Z8Fa
         qVU9/cYAjnc7VQkKGz+VfnvuF7uHWeeMAyuERa6qqAe7JX+8beDZhx7rn3Ye9uSXpbGn
         ePZe3vlmbS09aDcC0mFnQvSGQnhJioNqrfPJGhrSQxiqfKcjgKinu2YiuWQ7149/8dkY
         p5tA==
X-Gm-Message-State: AGi0PuZGe3yoR4nMtxDjWghx93h0ewCSnphxcv4fhtSOfKREn5izyBpa
        PdCrVFzjq2OTVNxTTnH3N9uzkQ==
X-Google-Smtp-Source: APiQypKgGKZIq9mRTJhqkz6pkkM4aAgdCbGBdapHWMrOrBex0Q23674KggLk7vgqycAoTTslPlg24A==
X-Received: by 2002:ac8:1b97:: with SMTP id z23mr6064203qtj.294.1587176747504;
        Fri, 17 Apr 2020 19:25:47 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id v62sm9170644qkb.85.2020.04.17.19.25.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 19:25:46 -0700 (PDT)
Date:   Fri, 17 Apr 2020 22:25:46 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     vpillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>, Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH 00/13] Core scheduling v5
Message-ID: <20200418022546.GB180518@google.com>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <20200414142152.GV20730@hirez.programming.kicks-ass.net>
 <20200415163220.GA180518@google.com>
 <20200417111255.GZ20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417111255.GZ20730@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Fri, Apr 17, 2020 at 01:12:55PM +0200, Peter Zijlstra wrote:
> On Wed, Apr 15, 2020 at 12:32:20PM -0400, Joel Fernandes wrote:
> > On Tue, Apr 14, 2020 at 04:21:52PM +0200, Peter Zijlstra wrote:
> > > On Wed, Mar 04, 2020 at 04:59:50PM +0000, vpillai wrote:
> > > > TODO
> > > > ----
> > > > - Work on merging patches that are ready to be merged
> > > > - Decide on the API for exposing the feature to userland
> > > > - Experiment with adding synchronization points in VMEXIT to mitigate
> > > >   the VM-to-host-kernel leaking
> > > 
> > > VMEXIT is too late, you need to hook irq_enter(), which is what makes
> > > the whole thing so horrible.
> > 
> > We came up with a patch to do this as well. Currently testing it more and it
> > looks clean, will share it soon.
> 
> Thomas said we actually first do VMEXIT, and then enable interrupts. So
> the VMEXIT thing should actually work, and that is indeed much saner
> than sticking it in irq_enter().
> 
> It does however put yet more nails in the out-of-tree hypervisors.

Just to clarify what we're talking about here. The condition we are trying to
protect against:

1. VM is malicious.
2. Sibling of VM is entering an interrupt on the host.
3. When we enter the interrupt, we send an IPI to force the VM into waiting.
4. The VM on the sibling enters VMEXIT.

In step 4, we have to synchronize. Is this the scenario we are discussing?

> > > > - Investigate the source of the overhead even when no tasks are tagged:
> > > >   https://lkml.org/lkml/2019/10/29/242
> > > 
> > >  - explain why we're all still doing this ....
> > > 
> > > Seriously, what actual problems does it solve? The patch-set still isn't
> > > L1TF complete and afaict it does exactly nothing for MDS.
> > 
> > The L1TF incompleteness is because of cross-HT attack from Guest vCPU
> > attacker to an interrupt/softirq executing on the other sibling correct? The
> > IRQ enter pausing the other sibling should fix that (which we will share in
> > a future series revision after adequate testing).
> 
> Correct, the vCPU still running can glean host (kernel) state from the
> sibling handling the interrupt in the host kernel.

Right. This is what we're handling.

> > > Like I've written many times now, back when the world was simpler and
> > > all we had to worry about was L1TF, core-scheduling made some sense, but
> > > how does it make sense today?
> > 
> > For ChromeOS we're planning to tag each and every task seperately except for
> > trusted processes, so we are isolating untrusted tasks even from each other.
> > 
> > Sorry if this sounds like pushing my usecase, but we do get parallelism
> > advantage for the trusted tasks while still solving all security issues (for
> > ChromeOS). I agree that cross-HT user <-> kernel MDS is still an issue if
> > untrusted (tagged) tasks execute together on same core, but we are not
> > planning to do that on our setup at least.
> 
> That doesn't completely solve things I think. Even if you run all
> untrusted tasks as core exclusive, you still have a problem of them vs
> interrupts on the other sibling.
> 
> You need to somehow arrange all interrupts to the core happen on the
> same sibling that runs your untrusted task, such that the VERW on
> return-to-userspace works as intended.
> 
> I suppose you can try and play funny games with interrupt routing tied
> to the force-idle state, but I'm dreading what that'll look like. Or
> were you going to handle this from your irq_enter() thing too?

Yes, even when host interrupt is on one sibling and the untrusted host
process is on the other sibling, we would be handling it the same way we
handle it for host interrupts vs untrusted guests. Perhaps we could optimize
pausing of the guest. But Vineeth tested and found that the same code that
pauses hosts also works for guests.

> Can someone go write up a document that very clearly states all the
> problems and clearly explains how to use this feature?

A document would make sense on how to use the feature. Maybe we can add it as
a documentation patch to the series?

Basically, from my notes the following are the problems:

Core-scheduling will help with cross-HT MDS and L1TF attacks. The following
are the scenarios (borrowed from an email from Thomas -- thanks!):

        HT1 (attack)            HT2 (victim)

 A      idle -> user space      user space -> idle

 B      idle -> user space      guest -> idle

 C      idle -> guest           user space -> idle

 D      idle -> guest           guest -> idle
 
All of them suffer from MDS. #C and #D suffer from L1TF.

All of these scenarios result in the victim getting idled to prevent any
leakage. However, this does not address the case where victim is an
interrupt handler or softirq. So we need to either route interrupts to run on
the attacker CPU, or have the irq_enter() send IPIs to pause the sibling
which is what we prototyped. Another approach to solve this is to force
interrupts into threaded mode as Thomas suggested.

The problematic usecase then left (if we ignore IRQ troubles), is MDS issues
between user <-> kernel simultaneous execution on both siblings. This does
not become an issue on ChromeOS where everything untrusted has its own tag.
For Vineeth's VM workloads also this isn't a problem from my discussions with
him, as he mentioned hyperthreads are both running guests and 2 vCPU threads
that belong to different VMs will not execute on the same core (though I'm
not sure whether hypercalls from a vCPU when the sibling is running another
vCPU of the same VM, is a concern here).

Any other case that needs to be considered?

thanks,

 - Joel

