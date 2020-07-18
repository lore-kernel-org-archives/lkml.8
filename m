Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43412C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C71420775
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 18:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595096873;
	bh=0/uzVOeqOSkhjD5cKCKfDXwHah7S3/NW8UIwyXORlf0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ULLYn8/unTNOnMpmhD/Q0GnJJCH0fGF6BpMCBPYYum7bM8Szbf+GGosEpC/ULzZKx
	 nPo7iSCaKX/QxegoJESQpoTAENBEVaq/epNt1rmwxTr9F8Ocau24ropJV5NbM0tYlZ
	 RWbwk/bHrBGqvEg9Tl3n6fIOF+MncJELDEYQYKXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728235AbgGRS1v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 14:27:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:59184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726690AbgGRS1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 14:27:51 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5CA362076A
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 18:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595096870;
        bh=0/uzVOeqOSkhjD5cKCKfDXwHah7S3/NW8UIwyXORlf0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Wq+W/AEowqqwk34qKH5Tc2Ck1fZlF2f7ijggRN7hDCCOQ3cIGUGx/E1Yl4F8xWE2o
         XCuS2RJLFY1JmHMLQZxQ3zaToKm+T9QdLQZjkQxl4521xDQktLy9fJhbc0icszRMLj
         mSo6s/OUgDHndawvYZkExWDW7FwT9vnikRTJ3Ggs=
Received: by mail-wm1-f48.google.com with SMTP id o8so18660471wmh.4
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 11:27:50 -0700 (PDT)
X-Gm-Message-State: AOAM5309UB2mZ/hNTf7ob9gpkSXTqaheJwJO7RiEcZ+jbSL0jD9awI27
        CYC4dyCNTu96rnkaHc/fMB4xhzaWJp51pa3rdwKe7w==
X-Google-Smtp-Source: ABdhPJwVZv63dZln+Rm9MH62VSTvOthgBg2koSxQIkQQVO/gMuAvZAuS7phUvCCqB/uuenG1TymaphkefbEiIIcPAy8=
X-Received: by 2002:a7b:c92e:: with SMTP id h14mr14024554wml.36.1595096869015;
 Sat, 18 Jul 2020 11:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <c2bfe1aa390777b10d810d2b76a35b97fbd32a1c.camel@intel.com>
 <CALCETrUBDUKTcmmYD7BpZkL3869ELvha1PqOcScw4M-B_DQdiA@mail.gmail.com> <7653c6c74a4eee18b8bdc8262e0c0b5b95f9d771.camel@intel.com>
In-Reply-To: <7653c6c74a4eee18b8bdc8262e0c0b5b95f9d771.camel@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 18 Jul 2020 11:27:37 -0700
X-Gmail-Original-Message-ID: <CALCETrWkvVKeoapzy6=6NNM9sg7zYV2x3dGivuX5ij8U_KYLzQ@mail.gmail.com>
Message-ID: <CALCETrWkvVKeoapzy6=6NNM9sg7zYV2x3dGivuX5ij8U_KYLzQ@mail.gmail.com>
Subject: Re: Random shadow stack pointer corruption
To:     Yu-cheng Yu <yu-cheng.yu@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 11:25 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
>
> On Sat, 2020-07-18 at 11:00 -0700, Andy Lutomirski wrote:
> > On Sat, Jul 18, 2020 at 10:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > Hi,
> > >
> > > My shadow stack tests start to have random shadow stack pointer corruption after
> > > v5.7 (excluding).  The symptom looks like some locking issue or the kernel is
> > > confused about which CPU a task is on.  In later tip/master, this can be
> > > triggered by creating two tasks and each does continuous
> > > pthread_create()/pthread_join().  If the kernel has max_cpus=1, the issue goes
> > > away.  I also checked XSAVES/XRSTORS, but this does not seem to be an issue
> > > coming from there.
> >
> > What do you mean "shadow stack pointer corruption"?  Is SSP itself
> > corrupt while running in the kernel?  Is one of the MSRs getting
> > corrupted?  Is the memory to which the shadow stack points getting
> > corrupted? Is the CPU rejecting an attempt to change SSP?
>
> What I see is, a new thread after ret_from_fork() and iret back to ring-3,
> its shadow stack pointer (MSR_IA32_PL3_SSP) is corrupted.
>
>
>

This is going to be impossible to diagnose, given that the upstream
kernel doesn't know about these MSRs at all.  If you point to a git
tree, maybe I can spot the issue.
