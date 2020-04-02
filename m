Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEEEC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44C4020857
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 20:23:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389475AbgDBUXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 16:23:23 -0400
Received: from mga04.intel.com ([192.55.52.120]:5932 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389346AbgDBUXW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 16:23:22 -0400
IronPort-SDR: 5nwEN14NT9HmGHE88iK6Ryl617VZ4KoUediYIXQSnajn+c/oEldRTqT5a7l4KEwREcfig/Ceqw
 pYbiK2m7744w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2020 13:23:22 -0700
IronPort-SDR: n/l1aennqb4MnuHqZrcmZbZt1UqGcxHReyElOaCBGCVzw218WLfCFq/TSGZ0TJr5WM+Td7ECqr
 GhINnGPyCVbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,336,1580803200"; 
   d="scan'208";a="449771833"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.202])
  by fmsmga005.fm.intel.com with ESMTP; 02 Apr 2020 13:23:21 -0700
Date:   Thu, 2 Apr 2020 13:23:21 -0700
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable
 Split-Lock-Detect
Message-ID: <20200402202321.GL13879@linux.intel.com>
References: <20200402123258.895628824@linutronix.de>
 <20200402124205.242674296@linutronix.de>
 <20200402152340.GL20713@hirez.programming.kicks-ass.net>
 <725ca48f-8194-658e-0296-65d4368803b5@intel.com>
 <20200402162548.GH20730@hirez.programming.kicks-ass.net>
 <2d2140c4-712a-2f8d-cde7-b3e64c28b204@intel.com>
 <87pncpn650.fsf@nanos.tec.linutronix.de>
 <20200402175127.GJ13879@linux.intel.com>
 <20200402185148.GL20730@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200402185148.GL20730@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 02, 2020 at 08:51:48PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 02, 2020 at 10:51:28AM -0700, Sean Christopherson wrote:
> > On Thu, Apr 02, 2020 at 07:34:35PM +0200, Thomas Gleixner wrote:
> > > Aside of that I'm still against the attempt of proliferating crap,
> > > i.e. disabling it because the host is triggering it and then exposing it
> > > to guests. The above does not change my mind in any way. This proposal
> > > is still wrong.
> > 
> > Eh, I still think the "off in host, on in guest" is a legit scenario for
> > debug/development/testing, but I agree that the added complexity doesn't
> > justify the minimal benefits versus sld_warn.
> 
> Off in host on in guest seems utterly insane to me. Why do you care
> about that?

For development/debug/testing.  Ignoring the core-scope stupidity of split
lock, the _functional_ behavior of the host kernel and guest kernel are
completely separate.  The host can generate split locks all it wants, but
other than performance, its bad behavior has no impact on the guest.

For example, all of the debug that was done to eliminate split locks in the
kernel could have been done in a KVM guest, even though the host kernel
would not have yet been split-lock free.

It's somewhat of a moot point now that the kernel is split-lock free.  But,
if I encountered a split lock panic on my system, the first thing I would
do (after rebooting) would be to fire up a VM to try and reproduce and
debug the issue.

Oftentimes it's significantly easier to "enable" a feature in KVM, i.e.
expose a feature to the guest, than it is to actually enable it in the
kernel.  Enabling KVM first doesn't work if there are hard dependencies on
kernel enabling, e.g. most things that have an XSAVE component, but for a
lot of features it's a viable strategy to enable KVM first, and then do all
testing and debug inside a KVM guest.
