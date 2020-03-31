Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CDDC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:26:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F09C20784
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 16:26:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730464AbgCaQ0z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 12:26:55 -0400
Received: from foss.arm.com ([217.140.110.172]:57190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729682AbgCaQ0y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 12:26:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2BAB330E;
        Tue, 31 Mar 2020 09:26:54 -0700 (PDT)
Received: from C02TD0UTHF1T.local (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E3F903F71E;
        Tue, 31 Mar 2020 09:26:52 -0700 (PDT)
Date:   Tue, 31 Mar 2020 17:26:50 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH v1 44/50] arm64: ptr auth: Use get_random_u64 instead
 of _bytes
Message-ID: <20200331162650.GB4400@C02TD0UTHF1T.local>
References: <202003281643.02SGhOi3016886@sdf.org>
 <20200330105745.GA1309@C02TD0UTHF1T.local>
 <20200330193237.GC9199@SDF.ORG>
 <20200331101412.GA1490@C02TD0UTHF1T.local>
 <20200331144915.GA4303@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331144915.GA4303@SDF.ORG>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 02:49:15PM +0000, George Spelvin wrote:
> On Tue, Mar 31, 2020 at 11:14:12AM +0100, Mark Rutland wrote:
> > On Mon, Mar 30, 2020 at 07:32:37PM +0000, George Spelvin wrote:
> >> On Mon, Mar 30, 2020 at 11:57:45AM +0100, Mark Rutland wrote:
> >> Because get_random_bytes() implements anti-backtracking, it's a minimum 
> >> of one global lock and one ChaCha20 operation per call.  Even though 
> >> chacha_block_generic() returns 64 bytes, for anti-backtracking we use 
> >> 32 of them to generate a new key and discard the remainder.
> >> 
> >> get_random_u64() uses the exact same generator, but amortizes the cost by 
> >> storing the output in a per-CPU buffer which it only has to refill every 
> >> 64 bytes generated.  7/8 of the time, it's just a fetch from a per-CPU 
> >> data structure.
> > 
> > I see; thanks for this explanation. It would be helpful to mention the
> > backtracking distinction explicitly in the commit message, since it
> > currently only alludes to it in the first sentence.
> 
> Easily done, but I need to find a centralized place to say it, or
> I'd be repeating myself a *lot* in the series.

Sure, but in the interests of optimizing for review, it's worth doing a
copy+paste of the key detail into each commit. That way, even if the
reviewer only looks at the patch in isolation they have all the
necessary context, and you don't have to reply to the same question on
each patch.

> > It's worth noting that the key values *can* be exposed to userspace when
> > CONFIG_CHECKPOINT_RESTORE is selected. On such kernels, a user could
> > regenerate and read the keys an arbitrary number of times on a CPU of
> > their choice. From my limited understanding I presume backtracking may
> > be a concern there?
> 
> No.  Backtracking is an issue if the keys must remain secret *after*
> they are wiped from kernel memory.  This applies to session
> *encryption* keys (assuming the plaintext should remain secret
> after the session is over), and to any long-lived keys which are
> stored encrypted or otherwise inaccessible (e.g. in dedicated
> hardware).  The latter includes most asymmetric private keys.

> Basically, do you need to wipe the key (with memzero_explicit) when
> you are done with it?  If that is important, you also want to
> know that the key cannot be reconstructed from the CRNG state.

I see, thanks for the explanation. I had misunderstood the what
backtracking was in this context.

> A modified patch will follow.  Thanks for your patience.

I've given that an Ack as it looked sound to me.

Thanks,
Mark.
