Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0D9C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:35:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36C520717
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 23:35:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgGRXfG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 19:35:06 -0400
Received: from mga14.intel.com ([192.55.52.115]:30875 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgGRXfG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 19:35:06 -0400
IronPort-SDR: E1qbDBG4aLpmdMaAzy87gJ/cEvDgZW409L05WxY1Tr+uQ/cMIYRzGtcyIgb8AudIjuXnJb4Egw
 Fhx6n5XBGDjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9686"; a="148930547"
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="scan'208";a="148930547"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2020 16:35:05 -0700
IronPort-SDR: T4jfnmHtDcBqaw9XzeXtvKcAgXHjTNhKj0Ps5MmLSKb/nZiGhSeJdJHi6Pq5xYk7HipOqxLHqe
 f20oxLiVgp+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,368,1589266800"; 
   d="scan'208";a="300925286"
Received: from yyu32-desk.sc.intel.com ([143.183.136.146])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2020 16:35:04 -0700
Message-ID: <14f3bee7569f229541852f61f0a1a88fcdec7249.camel@intel.com>
Subject: Re: Random shadow stack pointer corruption
From:   Yu-cheng Yu <yu-cheng.yu@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>
Date:   Sat, 18 Jul 2020 16:34:05 -0700
In-Reply-To: <d4b9d6a1-d413-b044-1d4a-512bbbf06d78@intel.com>
References: <c2bfe1aa390777b10d810d2b76a35b97fbd32a1c.camel@intel.com>
         <CALCETrUBDUKTcmmYD7BpZkL3869ELvha1PqOcScw4M-B_DQdiA@mail.gmail.com>
         <7653c6c74a4eee18b8bdc8262e0c0b5b95f9d771.camel@intel.com>
         <d4b9d6a1-d413-b044-1d4a-512bbbf06d78@intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-07-18 at 15:41 -0700, Dave Hansen wrote:
> On 7/18/20 11:24 AM, Yu-cheng Yu wrote:
> > On Sat, 2020-07-18 at 11:00 -0700, Andy Lutomirski wrote:
> > > On Sat, Jul 18, 2020 at 10:58 AM Yu-cheng Yu <yu-cheng.yu@intel.com> wrote:
> > > > Hi,
> > > > 
> > > > My shadow stack tests start to have random shadow stack pointer corruption after
> > > > v5.7 (excluding).  The symptom looks like some locking issue or the kernel is
> > > > confused about which CPU a task is on.  In later tip/master, this can be
> > > > triggered by creating two tasks and each does continuous
> > > > pthread_create()/pthread_join().  If the kernel has max_cpus=1, the issue goes
> > > > away.  I also checked XSAVES/XRSTORS, but this does not seem to be an issue
> > > > coming from there.
> > > 
> > > What do you mean "shadow stack pointer corruption"?  Is SSP itself
> > > corrupt while running in the kernel?  Is one of the MSRs getting
> > > corrupted?  Is the memory to which the shadow stack points getting
> > > corrupted? Is the CPU rejecting an attempt to change SSP?
> > 
> > What I see is, a new thread after ret_from_fork() and iret back to ring-3, 
> > its shadow stack pointer (MSR_IA32_PL3_SSP) is corrupted.
> 
> Does corrupt mean random?  Or is it a valid stack address, just not for
> _this_ thread?  Or NULL?  Or is it a kernel address?  Have you tried
> tracing *ALL* the WRMSR's and XRSTOR's that write to the MSR?

When a shadow stack address is changed, the address appears to be other task's. 
I traced all WRMSR's and XRSTOR's.  I also verified there have not been any
XRSTORS from a wrong buffer.  When rc6 is tagged, I will re-base, test, and
share current patches.

