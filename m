Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8D3C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66DFE207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:14:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgCaKOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:14:19 -0400
Received: from foss.arm.com ([217.140.110.172]:50130 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727655AbgCaKOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:14:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A29BB30E;
        Tue, 31 Mar 2020 03:14:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6855D3F52E;
        Tue, 31 Mar 2020 03:14:17 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:14:12 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 44/50] arm64: ptr auth: Use get_random_u64 instead
 of _bytes
Message-ID: <20200331101412.GA1490@C02TD0UTHF1T.local>
References: <202003281643.02SGhOi3016886@sdf.org>
 <20200330105745.GA1309@C02TD0UTHF1T.local>
 <20200330193237.GC9199@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330193237.GC9199@SDF.ORG>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 07:32:37PM +0000, George Spelvin wrote:
> Sorry for the delay responding; I had to re-set-up my arm64
> cross-compilation environment.
> 
> On Mon, Mar 30, 2020 at 11:57:45AM +0100, Mark Rutland wrote:
> > On Tue, Dec 10, 2019 at 07:15:55AM -0500, George Spelvin wrote:
> >> Since these are authentication keys, stored in the kernel as long
> >> as they're important, get_random_u64 is fine.  In particular,
> >> get_random_bytes has significant per-call overhead, so five
> >> separate calls is painful.
> > 
> > As I am unaware, how does the cost of get_random_bytes() compare to the
> > cost of get_random_u64()?
> 
> It's approximately 8 times the cost.
> 
> Because get_random_bytes() implements anti-backtracking, it's a minimum 
> of one global lock and one ChaCha20 operation per call.  Even though 
> chacha_block_generic() returns 64 bytes, for anti-backtracking we use 
> 32 of them to generate a new key and discard the remainder.
> 
> get_random_u64() uses the exact same generator, but amortizes the cost by 
> storing the output in a per-CPU buffer which it only has to refill every 
> 64 bytes generated.  7/8 of the time, it's just a fetch from a per-CPU 
> data structure.

I see; thanks for this explanation. It would be helpful to mention the
backtracking distinction explicitly in the commit message, since it
currently only alludes to it in the first sentence.

It's worth noting that the key values *can* be exposed to userspace when
CONFIG_CHECKPOINT_RESTORE is selected. On such kernels, a user could
regenerate and read the keys an arbitrary number of times on a CPU of
their choice. From my limited understanding I presume backtracking may
be a concern there?

> >> This ended up being a more extensive change, since the previous
> >> code was unrolled and 10 calls to get_random_u64() seems excessive.
> >> So the code was rearranged to have smaller object size.
> > 
> > It's not really "unrolled", but rather "not a loop", so I'd prefer to
> > not artifially make it look like one.
> 
> I intended that to mean "not in a loop, but could be".  I guess
> this entire exchange is about the distinction between "could be"
> and "should be".  ;-)
> 
> Yes, I went overboard, and your proposed change below is perfectly
> fine with me.

Great. That's what I'd prefer due to clarity of the code, and I'm not
too concerned by the figures below given it only adds 12 bytes to the
contemporary text size.

Thanks,
Mark.

> > Could you please quantify the size difference when going from
> > get_random_bytes() to get_random_u64(), if that is excessive enough to
> > warrant changing the structure of the code? Otherwise please leave the
> > structure as-is as given it is much easier to reason about -- suggestion
> > below on how to do that neatly.
> 
> Here are the various code sizes:
>    text    data     bss     dec     hex filename
>    1480       0       0    1480     5c8 arch/arm64/kernel/pointer_auth.o.old
>     862       0       0     862     35e arch/arm64/kernel/pointer_auth.o.new
>    1492       0       0    1492     5d4 arch/arm64/kernel/pointer_auth.o.new2
>    1560       0       0    1560     618 arch/arm64/kernel/pointer_auth.o.new3
> 
> "old" is the existing code.  "new" is my restructured code.
> "new2" is your simple change with a __ptrauth_key_init() helper.
> "new3" is with the helper forced noinline.
> 
> I shrank the code significantly, but deciding whether that's a net
> improvement is your perogative.
> 
> I should mention that at the end of my patch series, I added a function 
> (currently called get_random_nonce(), but that's subject to revision) 
> which uses the get_random_u64 internals with the same interface as 
> get_random_bytes().  We could postpone this whole thing until that gets
> a final name and merged.
> 
> 
> (BTW, somehow in my patch a "#include <linux/prctl.h>" needed in the 
> revised <asm/pointer_auth.h> got omitted.  I probably did something stupid 
> like added it in my cross-compilation tree but didn't push it back to my 
> main development tree.  Sorry.)
