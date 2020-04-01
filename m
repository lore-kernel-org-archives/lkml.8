Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F36FC2D0E7
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24A0A2072E
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 05:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731802AbgDAFXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 01:23:01 -0400
Received: from mx.sdf.org ([205.166.94.20]:64868 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgDAFXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 01:23:00 -0400
Received: from sdf.org (IDENT:lkml@faeroes.freeshell.org [205.166.94.9])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 0315I32g012695
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Wed, 1 Apr 2020 05:18:03 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 0315Hxjv027273;
        Wed, 1 Apr 2020 05:17:59 GMT
Date:   Wed, 1 Apr 2020 05:17:59 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Thomas Garnier <thgarnie@google.com>, lkml@sdf.org
Subject: lib/random32.c security
Message-ID: <20200401051759.GA9616@SDF.ORG>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
 <20200328182817.GE5859@SDF.ORG>
 <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
 <20200329174122.GD4675@SDF.ORG>
 <20200329214214.GB768293@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329214214.GB768293@mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 05:42:14PM -0400, Theodore Y. Ts'o wrote:
> If anyone is trying to rely on prandom_u32() as being "strong" in any
> sense of the word in terms of being reversable by attacker --- they
> shouldn't be using prandom_u32().  That's going to be true no matter
> *what* algorithm we use.
> 
> Better distribution?  Sure.  Making prandom_u32() faster?  Absolutely;
> that's its primary Raison d'Etre.

I'd like your comments on an idea I had to add a second PRNG state
for security-interesting applications.

There are some ASLR tasks, notably slab freelist shuffling and
per-syscall stack offset randomization, which need a Very Fast
source of random numbers.  No crypto-grade generator qualifies,
and both currently use very bad ad-hoc generators.

The per-syscall stack offset code currently uses the lsbits of the
TSC, which is obviously bad as they're observable by the (presumed
malicious) userspace immediately before the call and thus highly
predictable.

Likewise, the slab shuffling currently precomputes a permutation and
just picks a random starting position for every slab.

Both are saved by the fact that their PRNG outputs are mostly
unobservable, so an attacker can't start to predict them.

I was thinking that a second PRNG, identical to the prandom_u32()
one but seeded speartely, could be used for this purpose.  The good
distribution would preclude trivial patterns in their output, which
is about all we can hope for.

The difference is that it would only be used for applications which
both require high speed and are (mostly) unobservable to an attacker.


Any opinions, anyone?
