Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB79DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:50:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 907B52078B
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 14:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730682AbgCaOuB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 10:50:01 -0400
Received: from mx.sdf.org ([205.166.94.20]:53379 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726595AbgCaOuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 10:50:01 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02VEnFEj010261
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Tue, 31 Mar 2020 14:49:16 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02VEnFfb002103;
        Tue, 31 Mar 2020 14:49:15 GMT
Date:   Tue, 31 Mar 2020 14:49:15 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, lkml@sdf.org
Subject: Re: [RFC PATCH v1 44/50] arm64: ptr auth: Use get_random_u64 instead
 of _bytes
Message-ID: <20200331144915.GA4303@SDF.ORG>
References: <202003281643.02SGhOi3016886@sdf.org>
 <20200330105745.GA1309@C02TD0UTHF1T.local>
 <20200330193237.GC9199@SDF.ORG>
 <20200331101412.GA1490@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331101412.GA1490@C02TD0UTHF1T.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:14:12AM +0100, Mark Rutland wrote:
> On Mon, Mar 30, 2020 at 07:32:37PM +0000, George Spelvin wrote:
>> On Mon, Mar 30, 2020 at 11:57:45AM +0100, Mark Rutland wrote:
>>> As I am unaware, how does the cost of get_random_bytes() compare to the
>>> cost of get_random_u64()?
>> 
>> It's approximately 8 times the cost.  [Of *one* get_random_u64()
>> call; 4x the cost of the two needed to generate a 128-bit key.]
>> 
>> Because get_random_bytes() implements anti-backtracking, it's a minimum 
>> of one global lock and one ChaCha20 operation per call.  Even though 
>> chacha_block_generic() returns 64 bytes, for anti-backtracking we use 
>> 32 of them to generate a new key and discard the remainder.
>> 
>> get_random_u64() uses the exact same generator, but amortizes the cost by 
>> storing the output in a per-CPU buffer which it only has to refill every 
>> 64 bytes generated.  7/8 of the time, it's just a fetch from a per-CPU 
>> data structure.
> 
> I see; thanks for this explanation. It would be helpful to mention the
> backtracking distinction explicitly in the commit message, since it
> currently only alludes to it in the first sentence.

Easily done, but I need to find a centralized place to say it, or
I'd be repeating myself a *lot* in the series.

That said, thanks for prompting me to quantify the cost ratio.
I knew it, but never actually wrote it down.

> It's worth noting that the key values *can* be exposed to userspace when
> CONFIG_CHECKPOINT_RESTORE is selected. On such kernels, a user could
> regenerate and read the keys an arbitrary number of times on a CPU of
> their choice. From my limited understanding I presume backtracking may
> be a concern there?

No.  Backtracking is an issue if the keys must remain secret *after*
they are wiped from kernel memory.  This applies to session
*encryption* keys (assuming the plaintext should remain secret
after the session is over), and to any long-lived keys which are
stored encrypted or otherwise inaccessible (e.g. in dedicated
hardware).  The latter includes most asymmetric private keys.

Since the pointer authentication keys are authentication keys,
and valueless to an attacker once the kernel is done using them,
there is no need for backtracking protetion.

Basically, do you need to wipe the key (with memzero_explicit) when
you are done with it?  If that is important, you also want to
know that the key cannot be reconstructed from the CRNG state.

>> Yes, I went overboard, and your proposed change below is perfectly
>> fine with me.
> 
> Great. That's what I'd prefer due to clarity of the code, and I'm not
> too concerned by the figures below given it only adds 12 bytes to the
> contemporary text size.

A modified patch will follow.  Thanks for your patience.
