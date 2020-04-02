Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91038C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69FD62063A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 16:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389710AbgDBQEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 12:04:47 -0400
Received: from mga01.intel.com ([192.55.52.88]:25129 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389366AbgDBQEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 12:04:46 -0400
IronPort-SDR: G6lCr/ChClYeDwu/UcCfaQXiFIj3jpTKOEkAPmDd6VSHhmkd8cYbylfo7i/htRbHuh6Wli/YfF
 wENCiD0mgw1w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 09:04:45 -0700
IronPort-SDR: xXopAMbwED65cgcHn/XV5riG9MCGiV77AhEOJoUYw/GrgiJObmU7Dj4Vfu5JiSp4A3s8wb7oys
 9giyn2aINrvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="253048381"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by orsmga006.jf.intel.com with ESMTP; 02 Apr 2020 09:04:44 -0700
Date:   Thu, 2 Apr 2020 09:04:43 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch 2/2] x86/kvm/vmx: Prevent split lock detection induced
 #AC wreckage
Message-ID: <20200402160443.GC13879@linux.intel.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.334622628@linutronix.de>
 <20200402153035.GA13879@linux.intel.com>
 <18758F52-BB97-4F47-9481-F66AF4465A06@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18758F52-BB97-4F47-9481-F66AF4465A06@vmware.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 03:44:00PM +0000, Nadav Amit wrote:
> > On Apr 2, 2020, at 8:30 AM, Sean Christopherson <sean.j.christopherson@intel.com> wrote:
> > 
> > On Thu, Apr 02, 2020 at 02:33:00PM +0200, Thomas Gleixner wrote:
> >> Without at least minimal handling for split lock detection induced #AC, VMX
> >> will just run into the same problem as the VMWare hypervisor, which was
> >> reported by Kenneth.
> >> 
> >> It will inject the #AC blindly into the guest whether the guest is prepared
> >> or not.
> >> 
> >> Add the minimal required handling for it:
> >> 
> >>  - Check guest state whether CR0.AM is enabled and EFLAGS.AC is set.  If
> >>    so, then the #AC originated from CPL3 and the guest has is prepared to
> >>    handle it. In this case it does not matter whether the #AC is due to a
> >>    split lock or a regular unaligned check.
> >> 
> >> - Invoke a minimal split lock detection handler. If the host SLD mode is
> >>   sld_warn, then handle it in the same way as user space handling works:
> >>   Emit a warning, disable SLD and mark the current task with TIF_SLD.
> >>   With that resume the guest without injecting #AC.
> >> 
> >>   If the host mode is sld_fatal or sld_off, emit a warning and deliver
> >>   the exception to user space which can crash and burn itself.
> >> 
> >> Mark the module with MOD_INFO(sld_safe, "Y") so the module loader does not
> >> force SLD off.
> > 
> > Some comments below.  But, any objection to taking Xiaoyao's patches that
> > do effectively the same things, minus the MOD_INFO()?  I'll repost them in
> > reply to this thread.
> 
> IIUC they also deal with emulated split-lock accesses in the host, during
> instruction emulation [1]. This seems also to be required, although I am not
> sure the approach that he took once emulation encounters a split-lock is
> robust.

Yep.  It's "robust" in the sense that KVM won't panic the host.  It's not
robust from the perspective that it could possibly hose the guest.  But, no
sane, well-behaved guest should reach that particular emulator path on a
split-lock enabled system.

> [1] https://lore.kernel.org/lkml/20200324151859.31068-5-xiaoyao.li@intel.com/
