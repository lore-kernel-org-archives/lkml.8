Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B16CC43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA36820658
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 20:30:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="FRufedUA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729212AbgICUac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 16:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgICUa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 16:30:29 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF072C061244
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 13:30:28 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id r9so4855882ioa.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 13:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ff1mKe8wkbtuvA1xwHqfQ9HoajECOpK14bs/Jse4OK8=;
        b=FRufedUAqVKfHS6SBEXPpcQ5dN7ppLSyR5Q/GSkrsjd9dxcVKisj2eq7PBEUEvzbRw
         hl8bUWtm6P6lXExDyRQ96cWkQP0wa+WzPIBsVm1Gi9VrGwNR6RFOHoqGIYD/nN2wF/+l
         GuZ87I9hl7nvEEOx/lNGUuqXfGwARJmHn+ykw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ff1mKe8wkbtuvA1xwHqfQ9HoajECOpK14bs/Jse4OK8=;
        b=g+gey107izkgFq9FHZt/QBdrz6BmKneU3HrfIAJdmUGiN+kCK76vxCYUFQTgGbPMFh
         4i0cdHjYfJlD/O61jeXzVv20s2q+k5ANIP50/K05UpHOtSXvSBcESoTn7Ea8OeCsz0IY
         /+hd6On5S5o3xl8fvxoaaLgvg3ke0owpvw1J3O8XrsXNEYwm+XDEc8GHgXU+ohpigwbr
         gk2tcMETmdaAYbtz1ZcLacoZuiKuUVvmv5Hcm5K8D3vqEDJEAkMqlWsm24sR85h/tfRB
         QeUZdlcO0ylKv7uK3A5Nj5+oPMQD6/ifSydXsLkceU07aJ3EipzI+LFZE/zsYuc3iHYW
         OMdA==
X-Gm-Message-State: AOAM530AXEZvYJso37Lybn3c7VIchGo1IEu1r5O/L/WsDXmRDS9PXJCP
        3BUhNNtNeqcqj7UU8fKFjXMRM9cx4kE1bZ9Fv2wG2A==
X-Google-Smtp-Source: ABdhPJwwX7WWSuXXLh6VsWo8yrbQKo6gN2faSS9yV3/MWxif323AtnCct2XXvrYRUskJkoVrKcajUf2CXT2GbTya3C8=
X-Received: by 2002:a6b:6a01:: with SMTP id x1mr4759201iog.1.1599165027835;
 Thu, 03 Sep 2020 13:30:27 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
 <2a4398b55fe258ea53fb1fbc727063298f7eea8f.1598643276.git.jdesfossez@digitalocean.com>
 <87y2lth4qa.fsf@nanos.tec.linutronix.de> <20200901165052.GA1662854@google.com>
 <875z8xl0zh.fsf@nanos.tec.linutronix.de> <20200902012905.GB1703315@google.com>
 <87h7sgk41y.fsf@nanos.tec.linutronix.de> <a80babf130a45841e166fa155f84afc19b4257d3.camel@suse.com>
 <CAEXW_YRQiC_0edO5L2vVmL0NcfeZaRt4WYoyrcKmzbFcQP3PvA@mail.gmail.com> <87wo1buhcs.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87wo1buhcs.fsf@nanos.tec.linutronix.de>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 3 Sep 2020 16:30:14 -0400
Message-ID: <CAEXW_YRJt_W0NNWaj4ejRjyHSOYbsSp8RPJsHL47Dw5x5ndgmA@mail.gmail.com>
Subject: Re: [RFC PATCH v7 17/23] kernel/entry: Add support for core-wide
 protection of kernel-mode
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dario Faggioli <dfaggioli@suse.com>,
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

On Thu, Sep 3, 2020 at 9:20 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Sep 03 2020 at 00:34, Joel Fernandes wrote:
> > On Wed, Sep 2, 2020 at 12:57 PM Dario Faggioli <dfaggioli@suse.com> wrote:
> >> 2) protection of the kernel from the other thread running in userspace
> >> may be achieved in different ways. This is one, sure. ASI will probably
> >> be another. Hence if/when we'll have both, this and ASI, it would be
> >> cool to be able to configure the system in such a way that there is
> >> only one active, to avoid paying the price of both! :-)
> >
> > Actually, no. Part of ASI will involve exactly what this patch does -
> > IPI-pausing siblings but ASI does so when they have no choice but to
> > switch away from the "limited kernel" mapping, into the full host
> > kernel mapping. I am not sure if they have yet implemented that part
> > but they do talk of it in [1] and in their pretty LPC slides.  It is
> > just that ASI tries to avoid that scenario of kicking all siblings out
> > of guest mode.  So, maybe this patch can be a stepping stone to ASI.
> > At least I got the entry hooks right, and the algorithm is efficient
> > IMO (useless IPIs are avoided).  ASI can then come in and avoid
> > sending IPIs even more by doing their limited-kernel-mapping things if
> > needed. So, it does not need to be this vs ASI, both may be needed.
>
> Right. There are different parts which are seperate:
>
> 1) Core scheduling as a best effort feature (performance for certain use
>    cases)
>
> 2) Enforced core scheduling (utilizes #1 basics)
>
> 3) ASI
>
> 4) Kick sibling out of guest/host and wait mechanics
>
> #1, #2, #3 can be used stand alone. #4 is a utility
>
> Then you get combos:
>
> A) #2 + #4:
>
>    core wide protection. i.e. what this series tries to achieve.  #3
>    triggers the kick at the low level VMEXIT or entry from user mode
>    boundary. The wait happens at the same level
>
> B) #3 + #4:
>
>    ASI plus kicking the sibling/wait mechanics independent of what's
>    scheduled. #3 triggers the kick at the ASI switch to full host
>    mapping boundary and the wait is probably the same as in #A
>
> C) #2 + #3 + #4:
>
>    The full concert, but trigger/wait wise the same as #B
>
> So we really want to make at least #4 an independent utility.

Agreed! Thanks for enlisting all the cases so well. I believe this
could be achieved by moving the calls to unsafe_enter() and
unsafe_exit() to when ASI decides it is time to enter the unsafe
kernel context.  I will keep it in mind when sending the next revision
as well.

thanks,

- Joel
