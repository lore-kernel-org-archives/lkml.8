Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E45C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:20:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F44020757
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:20:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbgEVWU4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:20:56 -0400
Received: from mga07.intel.com ([134.134.136.100]:10343 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731117AbgEVWU4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:20:56 -0400
IronPort-SDR: JT1EjmXoZX7i3KQr4AMz3khO5nf8k48sKOuJCqsiVkZP6pjmO7D1PRaKi8+13Hv/xiKi6YE+96
 WIxQ5XL3TClA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2020 15:20:55 -0700
IronPort-SDR: z63+64e3RqoyP/cB1ZU63XoHj3mn7H9ffeDUndTqcCXJkjxXi42qTdysLI/kBuObKpUHpHXYU/
 d8F/I/Ytuo3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,423,1583222400"; 
   d="scan'208";a="300801599"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.152])
  by fmsmga002.fm.intel.com with ESMTP; 22 May 2020 15:20:55 -0700
Date:   Fri, 22 May 2020 15:20:55 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
Message-ID: <20200522222055.GE25128@linux.intel.com>
References: <20200522204738.645043059@infradead.org>
 <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 03:13:57PM -0700, Andy Lutomirski wrote:
> On Fri, May 22, 2020 at 1:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Hai, this kills #DB during NMI/#MC and with that allows removing all the nasty
> > IST rewrite crud.
> >
> 
> This is great, except that the unconditional DR7 write is going to
> seriously hurt perf performance.  Fortunately, no one cares about
> perf, right? :)  Even just reading first won't help enough because DR7
> reads are likely to be VM exits.  Can we have a percpu dr7 shadow
> (with careful ordering) or even just a percpu count of dr7 users so we
> can skip this if there are no breakpoints?

Hmm, I believe hw_breakpoint_active() is what you're looking for, KVM uses
it to avoid unnecessary restoration of host DR7 after VM-Exit.

Amusingly, checking that in the NMI handler could give a false positive if
an NMI occurs in guest as DR7 is cleared on exit and KVM invokes the NMI
handler prior to restoring host DR7.  I doubt that's common enough to care
about though.
