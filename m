Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 529B0C1975A
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2556020738
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 01:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mKYR/Iex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbgCRBDK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 21:03:10 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:45687 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727210AbgCRBDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 21:03:10 -0400
Received: by mail-qv1-f65.google.com with SMTP id h20so8107789qvr.12
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 18:03:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/UM91m3H9SucrrzE6InBosgNbwLVjkfbWviiKx3hOw=;
        b=mKYR/IexVgIIHRle+DSeYJI0sWzJl1m36ntdDhMhJ1Cu2Wn6OqoIxTGSLNFUl1+QAP
         Rv5iJhlrVramUD9FEix15VU+i5XA0LsR+bnIh0Q7us3Pq6gp0Jp6iWrUM6pUsB77lq/2
         juE/yVK2+agU+VkY6Aopcq1NfwOLCxuMyXU6I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/UM91m3H9SucrrzE6InBosgNbwLVjkfbWviiKx3hOw=;
        b=Ks8jI6vbrlSaSW7ljmxyJ2Zh/EAE3DyZ6ibcl+Xk+byrSf1frl6k0HslW/xAnlj3QY
         MAz/+lPfeNXz9LEYXHsESJ0x7QnCZcQRf/NoFMylG3jxZmCgi/bNr7vJ/tSFdY43VhDY
         y9vkaiPq2vr6LxEQWFGMXeMakTIFkGVlxakzhHyAc9wCJyJCxblDYH/qeo6iaQdTGvcB
         2a/9bKYDURzH4f81vcx8vw84hTJij9MEfdl4feIjrymEG6gLAMsSvxrp7kaO6Gwy5pxO
         CnfGUUM6irx6e0SL8U3GzdxZSOnxsIu2hv+kMzjO+OHm4LDW13y83gGCuB4I1ZqgGH1V
         7eFQ==
X-Gm-Message-State: ANhLgQ3ZdoyClqY+NGg395nBYsYhtqVGKU3MzpDmGLB4ewrdNVedxKA4
        ltIteh8KLyftsEJxono3RUFNoA==
X-Google-Smtp-Source: ADFU+vsy6tLwx+Ms3AQwy+0A7XGYVzY50FMYxfraV5Sm5L2i3l68cs6sOV0P2MKaH+mdbj9BohjGYA==
X-Received: by 2002:ad4:5401:: with SMTP id f1mr1828266qvt.209.1584493389098;
        Tue, 17 Mar 2020 18:03:09 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id t71sm3169655qke.55.2020.03.17.18.03.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 18:03:08 -0700 (PDT)
Date:   Tue, 17 Mar 2020 21:03:07 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
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
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Luck, Tony" <tony.luck@intel.com>
Subject: Re: [RFC PATCH v4 00/19] Core scheduling v4
Message-ID: <20200318010307.GA111608@google.com>
References: <20200212230705.GA25315@sinkpad>
 <29d43466-1e18-6b42-d4d0-20ccde20ff07@linux.intel.com>
 <CAERHkruG4y8si9FrBp7cZNEdfP7EzxbmYwvdF2EvHLf=mU1mgg@mail.gmail.com>
 <CANaguZC40mDHfL1H_9AA7H8cyd028t9PQVRqQ3kB4ha8R7hhqg@mail.gmail.com>
 <CAERHkruPUrOzDjEp1FV3KY20p9CxLAVzKrZNe5QXsCFZdGskzA@mail.gmail.com>
 <CANaguZBj_x_2+9KwbHCQScsmraC_mHdQB6uRqMTYMmvhBYfv2Q@mail.gmail.com>
 <20200221232057.GA19671@sinkpad>
 <20200317005521.GA8244@google.com>
 <ee268494-c35e-422f-1aaf-baab12191c38@linux.intel.com>
 <87imj2bs04.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87imj2bs04.fsf@nanos.tec.linutronix.de>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

Thanks for the detailed email. I am on the same page with all your points, I
had a question on one of the points below (which I agree with as well) but
just to confirm,

On Tue, Mar 17, 2020 at 10:17:47PM +0100, Thomas Gleixner wrote:
[..] 
> >> 4. HT1 is idle, and HT2 is running a victim process. Now HT1 starts running
> >>    hostile code on guest or host. HT2 is being forced idle. However, there is
> >>    an overlap between HT1 starting to execute hostile code and HT2's victim
> >>    process getting scheduled out.
> >>    Speaking to Vineeth, we discussed an idea to monitor the core_sched_seq
> >>    counter of the sibling being idled to detect that it is now idle.
> >>    However we discussed today that looking at this data, it is not really an
> >>    issue since it is such a small window.
> 
> If the victim HT is kicked out of execution with an IPI then the overlap
> depends on the contexts:
> 
>         HT1 (attack)		HT2 (victim)
> 
>  A      idle -> user space      user space -> idle
> 
>  B      idle -> user space      guest -> idle
> 
>  C      idle -> guest           user space -> idle
> 
>  D      idle -> guest           guest -> idle
> 
> The IPI from HT1 brings HT2 immediately into the kernel when HT2 is in
> host user mode or brings it immediately into VMEXIT when HT2 is in guest
> mode.
> 
> #A On return from handling the IPI HT2 immediately reschedules to idle.
>    To have an overlap the return to user space on HT1 must be faster.
> 
> #B Coming back from VEMXIT into schedule/idle might take slightly longer
>    than #A.
> 
> #C Similar to #A, but reentering guest mode in HT1 after sending the IPI
>    will probably take longer.
> 
> #D Similar to #C if you make the assumption that VMEXIT on HT2 and
>    rescheduling into idle is not significantly slower than reaching
>    VMENTER after sending the IPI.
> 
> In all cases the data exposed by a potential overlap shouldn't be that
> interesting (e.g. scheduler state), but that obviously depends on what
> the attacker is looking for.

About the "shouldn't be that interesting" part, you are saying, the overlap
should not be that interesting because the act of one sibling IPI'ing the
other implies the sibling HT immediately entering kernel mode, right?

Thanks, your email really helped!!!

 - Joel


