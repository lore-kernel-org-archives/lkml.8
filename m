Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAFD0C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:04:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 84D202064A
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 21:04:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389842AbgDBVEW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 17:04:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39027 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727412AbgDBVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 17:04:22 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jK70Q-0003L9-Do; Thu, 02 Apr 2020 23:04:06 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id B0789100D52; Thu,  2 Apr 2020 23:04:05 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Xiaoyao Li <xiaoyao.li@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        "Kenneth R. Crudup" <kenny@panix.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jessica Yu <jeyu@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Nadav Amit <namit@vmware.com>,
        Thomas Hellstrom <thellstrom@vmware.com>,
        Tony Luck <tony.luck@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [patch v2 1/2] x86,module: Detect VMX modules and disable Split-Lock-Detect
In-Reply-To: <20200402202321.GL13879@linux.intel.com>
References: <20200402123258.895628824@linutronix.de> <20200402124205.242674296@linutronix.de> <20200402152340.GL20713@hirez.programming.kicks-ass.net> <725ca48f-8194-658e-0296-65d4368803b5@intel.com> <20200402162548.GH20730@hirez.programming.kicks-ass.net> <2d2140c4-712a-2f8d-cde7-b3e64c28b204@intel.com> <87pncpn650.fsf@nanos.tec.linutronix.de> <20200402175127.GJ13879@linux.intel.com> <20200402185148.GL20730@hirez.programming.kicks-ass.net> <20200402202321.GL13879@linux.intel.com>
Date:   Thu, 02 Apr 2020 23:04:05 +0200
Message-ID: <87blo9mwfu.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:
> On Thu, Apr 02, 2020 at 08:51:48PM +0200, Peter Zijlstra wrote:
>> On Thu, Apr 02, 2020 at 10:51:28AM -0700, Sean Christopherson wrote:
>> > On Thu, Apr 02, 2020 at 07:34:35PM +0200, Thomas Gleixner wrote:
>> > > Aside of that I'm still against the attempt of proliferating crap,
>> > > i.e. disabling it because the host is triggering it and then exposing it
>> > > to guests. The above does not change my mind in any way. This proposal
>> > > is still wrong.
>> > 
>> > Eh, I still think the "off in host, on in guest" is a legit scenario for
>> > debug/development/testing, but I agree that the added complexity doesn't
>> > justify the minimal benefits versus sld_warn.
>> 
>> Off in host on in guest seems utterly insane to me. Why do you care
>> about that?
>
> For development/debug/testing.  Ignoring the core-scope stupidity of split
> lock, the _functional_ behavior of the host kernel and guest kernel are
> completely separate.  The host can generate split locks all it wants, but
> other than performance, its bad behavior has no impact on the guest.
>
> For example, all of the debug that was done to eliminate split locks in the
> kernel could have been done in a KVM guest, even though the host kernel
> would not have yet been split-lock free.
>
> It's somewhat of a moot point now that the kernel is split-lock free.  But,
> if I encountered a split lock panic on my system, the first thing I would
> do (after rebooting) would be to fire up a VM to try and reproduce and
> debug the issue.
>
> Oftentimes it's significantly easier to "enable" a feature in KVM, i.e.
> expose a feature to the guest, than it is to actually enable it in the
> kernel.  Enabling KVM first doesn't work if there are hard dependencies on
> kernel enabling, e.g. most things that have an XSAVE component, but for a
> lot of features it's a viable strategy to enable KVM first, and then do all
> testing and debug inside a KVM guest.

I can see that aspect, but there were pretty clear messages in one of
the other threads:

 "It's not about whether or not host is clean. It's for the cases that
  users just don't want it enabled on host, to not break the
  applications or drivers that do have split lock issue."

 "My thought is for CSPs that they might not turn on SLD on their
  product environment. Any split lock in kernel or drivers may break
  their service for tenants."

which I back then called out as proliferating crap and ensuring that
this stuff never gets fixed.

I still call it out as exactly that and you know as well as I do that
this is the reality.

For people like you who actually want to debug stuff in a guest, the
extra 10 lines of hack on top of the other 1000 lines of hacks you
already have are not really something which justifies to give hardware
and OS/application vendors the easy way out to avoid fixing their broken
crap.

Thanks,

        tglx
