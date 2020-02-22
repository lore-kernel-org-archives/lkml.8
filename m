Return-Path: <SRS0=8jYG=4K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97747C35641
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:41:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A7220722
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Feb 2020 00:41:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgBVAll (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 19:41:41 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58454 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726697AbgBVAlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 19:41:40 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01M0fXsg017796
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Feb 2020 19:41:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7717F4211EF; Fri, 21 Feb 2020 19:41:33 -0500 (EST)
Date:   Fri, 21 Feb 2020 19:41:33 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Tony Luck <tony.luck@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] random: always use batched entropy for
 get_random_u{32,64}
Message-ID: <20200222004133.GC873427@mit.edu>
References: <20200216161836.1976-1-Jason@zx2c4.com>
 <20200216182319.GA54139@kroah.com>
 <CA+8MBbKScktNPWPgMqexp9gSX+y2FVnXTDJyyEMVsdONPBpFrQ@mail.gmail.com>
 <CA+8MBbKyRhipHsxb0nvV11Bvv8ypQ_gq5JR8ihfuG6JfBTnxZw@mail.gmail.com>
 <CAHmME9q1rnD5z2bENYhqnM5-XCD+E68nm2RrGRWXt8ntpvfezg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9q1rnD5z2bENYhqnM5-XCD+E68nm2RrGRWXt8ntpvfezg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:08:19PM +0100, Jason A. Donenfeld wrote:
> On Thu, Feb 20, 2020 at 11:29 PM Tony Luck <tony.luck@gmail.com> wrote:
> >
> > Also ... what's the deal with a spin_lock on a per-cpu structure?
> >
> >         batch = raw_cpu_ptr(&batched_entropy_u64);
> >         spin_lock_irqsave(&batch->batch_lock, flags);
> >         if (batch->position % ARRAY_SIZE(batch->entropy_u64) == 0) {
> >                 extract_crng((u8 *)batch->entropy_u64);
> >                 batch->position = 0;
> >         }
> >         ret = batch->entropy_u64[batch->position++];
> >         spin_unlock_irqrestore(&batch->batch_lock, flags);
> >
> > Could we just disable interrupts and pre-emption around the entropy extraction?
> 
> Probably, yes... We can address this in a separate patch.

No, we can't; take a look at invalidate_batched_entropy(), where we
need invalidate all of per-cpu batched entropy from a single CPU after
we have initialized the the CRNG.

Since most of the time after CRNG initialization, the spinlock for
each CPU will be on that CPU's cacheline, the time to take and release
the spinlock is not going to be material.

					- Ted

