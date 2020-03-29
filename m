Return-Path: <SRS0=I467=5O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 246FDC43331
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5F2A2076A
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Mar 2020 17:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728364AbgC2RqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Mar 2020 13:46:12 -0400
Received: from mx.sdf.org ([205.166.94.20]:56177 "EHLO mx.sdf.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728065AbgC2RqM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Mar 2020 13:46:12 -0400
Received: from sdf.org (IDENT:lkml@sdf.lonestar.org [205.166.94.16])
        by mx.sdf.org (8.15.2/8.14.5) with ESMTPS id 02THfOue005744
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits) verified NO);
        Sun, 29 Mar 2020 17:41:25 GMT
Received: (from lkml@localhost)
        by sdf.org (8.15.2/8.12.8/Submit) id 02THfMtT011769;
        Sun, 29 Mar 2020 17:41:22 GMT
Date:   Sun, 29 Mar 2020 17:41:22 +0000
From:   George Spelvin <lkml@SDF.ORG>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Qian Cai <cai@lca.pw>, Kees Cook <keescook@chromium.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>, lkml@sdf.org
Subject: Re: [RFC PATCH v1 00/52] Audit kernel random number use
Message-ID: <20200329174122.GD4675@SDF.ORG>
References: <202003281643.02SGhPmY017434@sdf.org>
 <CAPcyv4iagZy5m3FpMrQqyOi=_uCzqh5MjbW+J_xiHU1Z1BmF=g@mail.gmail.com>
 <20200328182817.GE5859@SDF.ORG>
 <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98bd30f23b374ccbb61dd46125dc9669@AcuMS.aculab.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 29, 2020 at 12:21:46PM +0000, David Laight wrote:
>From: George Spelvin
>> Sent: 28 March 2020 18:28
>...
>> 20..23: Changes to the prandom_u32() generator itself.  Including
>>     switching to a stronger & faster PRNG.
>
> Does this remove the code that used 'xor' to combine the output
> of (about) 5 LFSR?
> Or is that somewhere else?
> I didn't spot it in the patches - so it might already have gone.

Yes, Patch #21 ("lib/random32.c: Change to SFC32 PRNG") changes
out the generator.  I kept the same 128-bit (per CPU) state size.

The previous degree-113 LFSR was okay, but not great.
(It was factored into degree-31, -29, -28 and -25 components,
so there were four subgenerators.)

(If people are willing to spend the additional state size on 64-bit
machines, there are lots of good 64-bit generators with 256 bits of state.
Just remember that we have one state per possible CPU, so that's
a jump from 2KB to 4KB with the default NR_CPUS = 64.)

> Using xor was particularly stupid.
> The whole generator was then linear and trivially reversable.
> Just using addition would have made it much stronger.

I considered changing it to addition (actually, add pairs and XOR the 
sums), but that would break its self-test.  And once I'd done that,
there are much better possibilities.

Actually, addition doesn't make it *much* stronger.  To start
with, addition and xor are the same thing at the lsbit, so
observing 113 lsbits gives you a linear decoding problem.
