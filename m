Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D08C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFFA020637
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 23:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbgCMXyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 19:54:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48245 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgCMXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 19:54:22 -0400
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jCu85-0004vk-4n; Sat, 14 Mar 2020 00:54:13 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 97C7E101115; Sat, 14 Mar 2020 00:54:12 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ming Lei <minlei@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] x86/vector: Allow to free vector for managed IRQ
In-Reply-To: <20200313151908.GA95517@xz-x1>
Date:   Sat, 14 Mar 2020 00:54:12 +0100
Message-ID: <87v9n7erq3.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Xu <peterx@redhat.com> writes:
> On Fri, Mar 13, 2020 at 03:24:08PM +0100, Thomas Gleixner wrote:
>> Peter Xu <peterx@redhat.com> writes:
>> What is this backtrace for? It's completly useless as it merily shows
>> that the warning triggers. Also even if it'd be useful then it wants to
>> be trimmed properly.
>
> I thought it was a good habit to keep the facts of issues.  Backtrace
> is one of them so I kept them.  It could, for example, help people who
> spot the same issue in an old/downstream kernel so when they google or
> grepping git-log they know the exact issue has been solved by some
> commit, even without much knowledge on the internals (because they can
> exactly compare the whole dmesg error).

This is not really good habit. Changelogs should contain factual
information which is relevant to understand the problem. Backtraces are
useful when the callchain leading to a bug/warn/oops _is_ relevant for
understanding the issue. For things like this where the backtrace is
completly out of context it's more of an distraction than of value.

Aside of that your 'spot the same issue' argument is wrong in this
context as this does not affect anything old/downstream. The feature was
merged during the 5.6 merge window. So it has not reached anything
downstream which needs backports. If distro people pick out such a
feature and backport it to their frankenkernels before the final release
then I really dont care.

One way to preserve the backtrace for google's sake is to write a cover
letter and stick the back trace there if it is not useful in the
changelog.

Also having 40+ lines of untrimmed backtrace is just a horrible
distraction. The timestamps are completely useless and depending on the
type of problem most of the other gunk which is emitted by a
bug/warn/oops backtrace is useless as well.

Why would you be interested in the register values for this problem or
the code or the interrupt flags tracer state? That thing triggered a
warning and nothing in the backtrace gives any clue about why that
happened, IOW it's pure distraction.

If the call chain is relevant to explain the problem, then a trimmed
down version is really sufficient. Here is an example:

     BUG: unable to handle kernel NULL pointer dereference at 0000000000000078
     RIP: 0010:apic_ack_edge+0x1e/0x40
     Call Trace:
       handle_edge_irq+0x7d/0x1e0
       generic_handle_irq+0x27/0x30
       aer_inject_write+0x53a/0x720

This helps, because it illustrates exactly how this BUG was triggered
and it's reduced to exactly the 6 lines because everything else in the
original 50+ lines is useless.

> However I think I still miss one thing in the puzzle (although it
> turns out that we've agreed on removing the warning already, but just
> in case I missed something important) - do you mean that offlining all
> the non-isolated CPUs in the mask won't trigger this already?  Because
> I also saw some similar comment somewhere else...
>
> Here's my understanding - when offlining, we'll disable the CPU and
> reach:
>
>   - irq_migrate_all_off_this_cpu
>     - migrate_one_irq
>       - irq_do_set_affinity
>         - calculate HK_FLAG_MANAGED_IRQ and so on...
>
> Then we can still trigger this irq move event even before we bring
> another housekeeping cpu online, right?  Or could you guide me on what
> I have missed?

The migration when offlining the CPU to which an interrupt is affine
does not trigger this because that uses a different mechanism.

It clears the vector on the outgoing CPU brute force simply because this
CPU can't handle any interrupts anymore. There is some logic to catch
the device interrupt racing against this, but while careful it's not
perfect. There is a theoretical hole there which probably could be
triggered by carefully orchestrating things, but we can't do anything
about it except disabling CPU unplug :)

So the only two ways to trigger this are the ones I described in the
changelog.

Hope that helps.

Thanks,

        tglx

