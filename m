Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7776C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8909020724
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 00:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="TXeagcuv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCRAwv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 20:52:51 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:36706 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbgCRAwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 20:52:51 -0400
Received: by mail-io1-f68.google.com with SMTP id d15so23195368iog.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 17:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0pviT+saHNFb6GStvZc+BnSpPWtHJjl67+d9zne4+Q=;
        b=TXeagcuvI67YJ7BHqnPkM7lPun1ec/ejfepBsnzGKaZdiOOtTF1CQwDcO/J6lObXqG
         IHeixhD39kz6hpJSdzSisES4Hy+69BNjXR/ZcHddL6L6h/KEFXKA+vBWNTMy2cvoCyPH
         TAQZ+/dibGkcf69HegI9RPecgZdQEd43192Vg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0pviT+saHNFb6GStvZc+BnSpPWtHJjl67+d9zne4+Q=;
        b=OW18ZD1D85DPtG+aMuLxlcO1p0lIV6xs7+orcF1bekuLrYnDRTxESRHRipPXTThp8v
         9rbTOPaB1dOlC4/RFAxxGx5d0Hj+okDNPHPfBSKmkP2c7j8oX0HIQi+Hlbi6iUXKNjiO
         U+tx31AeJiAa+ngXpkrkdE76+qSj/vLOG9AgY3FeQHgSboKMLVfuKWuKBTfqKT0R0ges
         Zzi8Sq3d3s88tmmyjyGLh5dIJHOSnrgsif9Y1rbH2Nr6o5peOl4G6udusrPgPuvXV5uj
         xan6785T+fl67H7muKdcz9q4AcTHGkKGt47XmyMcCq6ueDx/eTyWN54biUDI793GNBpg
         yiuQ==
X-Gm-Message-State: ANhLgQ2YFIKlwkjAjTOu0mf8GK3th433Jmyg93BfdkdR94fW7K/DV8DJ
        9jLNNkzpg0knHreZTjTSyPKaYUKXohXpqqlNmXPguw==
X-Google-Smtp-Source: ADFU+vv7dhG4pSGOtXjLLJKkqizdIVTD3D9y1fulW22UxohMDYKq54LmjGLHssmUViK9cFO05RyucarPxm1I4GBExSc=
X-Received: by 2002:a02:a78c:: with SMTP id e12mr2043593jaj.42.1584492768383;
 Tue, 17 Mar 2020 17:52:48 -0700 (PDT)
MIME-Version: 1.0
References: <3c3c56c1-b8dc-652c-535e-74f6dcf45560@linux.intel.com>
 <CANaguZAz+mw1Oi8ecZt+JuCWbf=g5UvKrdSvAeM82Z1c+9oWAw@mail.gmail.com>
 <e322a252-f983-e3f3-f823-16d0c16b2867@linux.intel.com> <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com> <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad> <20200317005521.GA8244@google.com> <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
In-Reply-To: <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Mar 2020 20:52:37 -0400
Message-ID: <CAEXW_YS927Tc3sPHeK9wW7nL=qvqFDoCX23xxtbMZmVhtbO1xw@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
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
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 3:07 PM Tim Chen <tim.c.chen@linux.intel.com> wrote:
>
> Joel,
>
> >
> > Looks quite interesting. We are trying apply this work to ChromeOS. What we
> > want to do is selectively marking tasks, instead of grouping sets of trusted
> > tasks. I have a patch that adds a prctl which a task can call, and it works
> > well (task calls prctl and gets a cookie which gives it a dedicated core).
> >
> > However, I have the following questions, in particular there are 4 scenarios
> > where I feel the current patches do not resolve MDS/L1TF, would you guys
> > please share your thoughts?
> >
> > 1. HT1 is running either hostile guest or host code.
> >    HT2 is running an interrupt handler (victim).
> >
> >    In this case I see there is a possible MDS issue between HT1 and HT2.
>
> Core scheduling mitigates the userspace to userspace attacks via MDS between the HT.
> It does not prevent the userspace to kernel space attack.  That will
> have to be mitigated via other means, e.g. redirecting interrupts to a core
> that don't run potentially unsafe code.

We have only 2 cores (4 HT) on many devices. It is not an option to
dedicate a core to only running trusted code, that would kill
performance. Another option is to designate a single HT of a
particular core to run both untrusted code and an interrupt handler --
but as Thomas pointed out, this does not work for per-CPU interrupts
or managed interrupts, and the softirqs that they trigger. But if we
just consider interrupts for which we can control the affinities (and
assuming that most interrupts can be controlled like that), then maybe
it will work? In the ChromeOS model, each untrusted task is in its own
domain (cookie). So untrusted tasks cannot benefit from parallelism
(in our case) anyway -- so it seems reasonable to run an affinable
interrupt and an untrusted task, on a particular designated core.

(Just thinking out loud...).  Another option could be a patch that
Vineeth shared with me (that Peter experimentally wrote) where he
sends IPI from an interrupt handler to a sibling running untrusted
guest code which would result in it getting paused. I am hoping
something like this could work on the host side as well (not just for
guests). We could also set per-core state from the interrupted HT,
possibly IPI'ing the untrusted sibling if we have to. If sibling runs
untrusted code *after* the other's siblings interrupt already started,
then the schedule() loop on the untrusted sibling would spin knowing
the other sibling has an interrupt in progress. The softirq is a real
problem though. Perhaps it can also set similar per-core state.
Thoughts?

> > 2. HT1 is executing hostile host code, and gets interrupted by a victim
> >    interrupt. HT2 is idle.
> >    In this case, I see there is a possible MDS issue between interrupt and
> >    the host code on the same HT1.
>
> The cpu buffers are cleared before return to the hostile host code.  So
> MDS shouldn't be an issue if interrupt handler and hostile code
> runs on the same HT thread.

Got it, agreed this is not an issue.

> > 3. HT1 is executing hostile guest code, HT2 is executing a victim interrupt
> >    handler on the host.
> >
> >    In this case, I see there is a possible L1TF issue between HT1 and HT2.
> >    This issue does not happen if HT1 is running host code, since the host
> >    kernel takes care of inverting PTE bits.
>
> The interrupt handler will be run with PTE inverted.  So I don't think
> there's a leak via L1TF in this scenario.

As Thomas and you later pointed out, this is still an issue and will
require a similar solution as described above.

thanks,

- Joel
