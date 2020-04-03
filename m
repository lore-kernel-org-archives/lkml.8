Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C28C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:21:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F472206F5
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 17:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404367AbgDCRVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 13:21:30 -0400
Received: from mga05.intel.com ([192.55.52.43]:43136 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbgDCRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 13:21:29 -0400
IronPort-SDR: fjEhpCPcyAdxUQARVqP1s0WxMK+ndckAzcxa5q5ytgqf4m1qVX+UWht5ATTuz1EBZlZoqaF0tN
 wZKABqg8jeAA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2020 10:21:29 -0700
IronPort-SDR: EC4hJqgWCgeSPdQln89njVGtlG/mPy3BJRJGwOAC97Oaga7gQcH6kLrT2irhhGcfkUHziSiEGv
 U8d7vxVtZ5Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; 
   d="scan'208";a="243509627"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga008.jf.intel.com with ESMTP; 03 Apr 2020 10:21:29 -0700
Date:   Fri, 3 Apr 2020 10:21:29 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>
Subject: Re: [patch 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200403172129.GE2701@linux.intel.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <bc9a0c9a-7bd0-c85d-4795-ae0b4faa5e84@prevas.dk>
 <20200403143459.GA30424@linux-8ccs>
 <20200403152158.GR20730@hirez.programming.kicks-ass.net>
 <20200403160156.GA2701@linux.intel.com>
 <20200403161205.GT20730@hirez.programming.kicks-ass.net>
 <20200403162555.GB2701@linux.intel.com>
 <20200403164058.GX20730@hirez.programming.kicks-ass.net>
 <FF9F1233-1312-4B98-A476-0C20D92200E3@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF9F1233-1312-4B98-A476-0C20D92200E3@vmware.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 04:48:35PM +0000, Nadav Amit wrote:
> > On Apr 3, 2020, at 9:40 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> > 
> > On Fri, Apr 03, 2020 at 09:25:55AM -0700, Sean Christopherson wrote:
> >> On Fri, Apr 03, 2020 at 06:12:05PM +0200, Peter Zijlstra wrote:
> >>> On Fri, Apr 03, 2020 at 09:01:56AM -0700, Sean Christopherson wrote:
> >>>> On Fri, Apr 03, 2020 at 05:21:58PM +0200, Peter Zijlstra wrote:
> >>>>> On Fri, Apr 03, 2020 at 04:35:00PM +0200, Jessica Yu wrote:
> >>> 
> >>>>>> I wonder if it would make sense then to limit the text scans to just
> >>>>>> out-of-tree modules (i.e., missing the intree modinfo flag)?
> >>>>> 
> >>>>> It would; didn't know there was one.
> >>>> 
> >>>> Rather than scanning modules at all, what about hooking native_write_cr4()
> >>>> to kill SLD if CR4.VMXE is toggled on and the caller didn't increment a
> >>>> "sld safe" counter?
> >>> 
> >>> And then you're hoping that the module uses that and not:
> >>> 
> >>>  asm volatile ("mov %0, cr4" :: "r" (val));
> >>> 
> >>> I think I feel safer with the scanning to be fair. Also with the intree
> >>> hint on, we can extend the scanning for out-of-tree modules for more
> >>> dodgy crap we really don't want modules to do, like for example the
> >>> above.
> >> 
> >> Ya, that's the big uknown.  But wouldn't they'd already be broken in the
> >> sense that they'd corrupt the CR4 shadow?  E.g. setting VMXE without
> >> updating cpu_tlbstate.cr4 would result in future in-kernel writes to CR4
> >> attempting to clear CR4.VMXE post-VMXON, which would #GP.
> > 
> > Sadly the CR4 shadow is exported, so they can actually fix that up :/
> 
> I do not think that Sean’s idea would work for VMware.

Well phooey.
