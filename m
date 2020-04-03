Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 601EDC2BA15
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3794B2073B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 16:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgDCQB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 12:01:59 -0400
Received: from mga03.intel.com ([134.134.136.65]:20821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgDCQB6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 12:01:58 -0400
IronPort-SDR: AW7VDaQyxwa2FRUI1BwQq7jhebS4UJQhk2/G8LrJIDltZCcRT2Ux6/PqQY4n4LJnue8bSGQEto
 GYJPGjcKPmeg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 09:01:57 -0700
IronPort-SDR: ZYF7vSUKoEZ0onMJvLxjxmphdI5P/HoUSBfnGLfHfD50TjfKzPwPB3EtEqkm+P+x5dtQLwdvBs
 RfhgEbzkt37Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="450070894"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 03 Apr 2020 09:01:56 -0700
Date:   Fri, 3 Apr 2020 09:01:56 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        jannh@google.com, keescook@chromium.org
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403160156.GA2701@linux.intel.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
 <20200403143459.GA30424@linux-8ccs>
 <20200403152158.GR20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200403152158.GR20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 05:21:58PM +0200, Peter Zijlstra wrote:
> On Fri, Apr 03, 2020 at 04:35:00PM +0200, Jessica Yu wrote:
> > +++ Rasmus Villemoes [03/04/20 01:42 +0200]:
> > > On 02/04/2020 14.32, Thomas Gleixner wrote:
> > > > From: Peter Zijlstra <peterz@infradead.org>
> > > > 
> > > > It turns out that with Split-Lock-Detect enabled (default) any VMX
> > > > hypervisor needs at least a little modification in order to not blindly
> > > > inject the #AC into the guest without the guest being ready for it.
> > > > 
> > > > Since there is no telling which module implements a hypervisor, scan the
> > > > module text and look for the VMLAUNCH instruction. If found, the module is
> > > > assumed to be a hypervisor of some sort and SLD is disabled.
> > > 
> > > How long does that scan take/add to module load time? Would it make
> > > sense to exempt in-tree modules?
> > > 
> > > Rasmus
> > 
> > I second Rasmus's question. It seems rather unfortunate that we have
> > to do this text scan for every module load on x86, when it doesn't
> > apply to the majority of them, and only to a handful of out-of-tree
> > hypervisor modules (assuming kvm is taken care of already).
> > 
> > I wonder if it would make sense then to limit the text scans to just
> > out-of-tree modules (i.e., missing the intree modinfo flag)?
> 
> It would; didn't know there was one.

Rather than scanning modules at all, what about hooking native_write_cr4()
to kill SLD if CR4.VMXE is toggled on and the caller didn't increment a
"sld safe" counter?

Partially tested patch incoming...
