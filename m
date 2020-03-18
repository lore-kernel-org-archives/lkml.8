Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADD6C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EAC3206EC
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 02:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="bSq+MvkG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCRCa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 22:30:56 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:34528 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbgCRCa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 22:30:56 -0400
Received: by mail-io1-f65.google.com with SMTP id h131so23422665iof.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 19:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5oye20MCxRmnUT0eOUPv5vlxHxUcabu0iBJYepsiWW8=;
        b=bSq+MvkGcpZ8+OqcY98WFYnTk4SLVtQJpleMXCowybtz67hdO2MrS/6LP8vEzxOWsH
         sLz7xnqXTUkf+akjUsvVvApqBtnj4eoDj/PgfbXcRI/9i9eFrZyz7rriOUetQTmC7tGv
         JXTpllKl4L5Hzo7tM8gvi4W7cHZDAKyZuNZcA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5oye20MCxRmnUT0eOUPv5vlxHxUcabu0iBJYepsiWW8=;
        b=rjQQVK1akDBmyL/sUUPiiMP+3dXe6jm5FXcXS72FD59B00UIRkLfHIUgieynuGdbu/
         6g1d+vE5SSJKsr/VCzxqaIfOCLrIVd6lVa6SpUpFhSscPh+lZfGbPczzOhaFUvtBHljM
         WESGNwmvd3VqJIdmgLdnG/d5DVSEdrBbQJjZ9Z3saFe5Sk3nifO71Iho9PK0mITJ8ldv
         1X2gQVrJe8byVjKYZHybjhw0BeyJZsZ8JXS54dBRUtF5gL5Wf0X3dMWJK5E9cnTZ/rw5
         udCHj/pjvmxBEYhEb7Imbdcykez06vOX3EYOz5Lu2t50a+WxYnvmqpKRRK1tNPq1RWBZ
         t7iw==
X-Gm-Message-State: ANhLgQ2fHaKi6hNyzOaX6bRh2k3pqfs6MST/j/Tg8tHnIN6Wnfa3XHLd
        MpFUFnCeY1umEUoEQN3yo3LOJkKOij2MWA1K8AUw4g==
X-Google-Smtp-Source: ADFU+vuB42nhnTS0/DYMx9nhfIE/i914XA1+SoNt2D0oWnry7X7Uq2lAzBFOse2nnaMlgTL91mnfc5npmO8Kq5xECa0=
X-Received: by 2002:a5d:93d3:: with SMTP id j19mr1675276ioo.75.1584498654904;
 Tue, 17 Mar 2020 19:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200212230705.GA25315@sinkpad> <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad> <20200317005521.GA8244@google.com>
 <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com> <87imj2bs04.fsf@nanos.tec.linutronix.de>
 <20200318010307.GA111608@google.com>
In-Reply-To: <20200318010307.GA111608@google.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 17 Mar 2020 22:30:43 -0400
Message-ID: <CAEXW_YT9QfbpnJLr+_fa8wiP7J=j6sXf3exquj5PVpnQreZoqA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Ingo Molnar <mingo@kernel.org>, Paul Turner <pjt@google.com>,
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

> On Tue, Mar 17, 2020 at 10:17:47PM +0100, Thomas Gleixner wrote:
> [..]
> > >> 4. HT1 is idle, and HT2 is running a victim process. Now HT1 starts running
> > >>    hostile code on guest or host. HT2 is being forced idle. However, there is
> > >>    an overlap between HT1 starting to execute hostile code and HT2's victim
> > >>    process getting scheduled out.
> > >>    Speaking to Vineeth, we discussed an idea to monitor the core_sched_seq
> > >>    counter of the sibling being idled to detect that it is now idle.
> > >>    However we discussed today that looking at this data, it is not really an
> > >>    issue since it is such a small window.
> >
> > If the victim HT is kicked out of execution with an IPI then the overlap
> > depends on the contexts:
> >
> >         HT1 (attack)          HT2 (victim)
> >
> >  A      idle -> user space      user space -> idle
> >
> >  B      idle -> user space      guest -> idle
> >
> >  C      idle -> guest           user space -> idle
> >
> >  D      idle -> guest           guest -> idle
> >
> > The IPI from HT1 brings HT2 immediately into the kernel when HT2 is in
> > host user mode or brings it immediately into VMEXIT when HT2 is in guest
> > mode.
> >
> > #A On return from handling the IPI HT2 immediately reschedules to idle.
> >    To have an overlap the return to user space on HT1 must be faster.
> >
> > #B Coming back from VEMXIT into schedule/idle might take slightly longer
> >    than #A.
> >
> > #C Similar to #A, but reentering guest mode in HT1 after sending the IPI
> >    will probably take longer.
> >
> > #D Similar to #C if you make the assumption that VMEXIT on HT2 and
> >    rescheduling into idle is not significantly slower than reaching
> >    VMENTER after sending the IPI.
> >
> > In all cases the data exposed by a potential overlap shouldn't be that
> > interesting (e.g. scheduler state), but that obviously depends on what
> > the attacker is looking for.
>
> About the "shouldn't be that interesting" part, you are saying, the overlap
> should not be that interesting because the act of one sibling IPI'ing the
> other implies the sibling HT immediately entering kernel mode, right?

Hi Thomas,

I see what you mean now. Basically after the IPI is sent, the HT
sending the IPI would have buffers cleared before the attacker gets a
chance to run on it. Because the victim HT enters into the IPI
handler, all the attacker will get to see is possibly uninteresting
data (e.g. scheduler state) as you mentioned.

Thanks!

- Joel
