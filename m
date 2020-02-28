Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 736E4C3F2CF
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:09:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DF520732
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 04:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730904AbgB1EJh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 23:09:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53921 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730885AbgB1EJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 23:09:36 -0500
Received: from callcc.thunk.org (guestnat-104-133-8-109.corp.google.com [104.133.8.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 01S49UB5027674
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Feb 2020 23:09:32 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 46D5B421A71; Thu, 27 Feb 2020 23:09:30 -0500 (EST)
Date:   Thu, 27 Feb 2020 23:09:30 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Subject: Re: [PATCH v2] random: always use batched entropy for
 get_random_u{32,64}
Message-ID: <20200228040930.GB101220@mit.edu>
References: <CAHmME9o+Nh0=0QBimOJLXpLitQ9p6rsAut+Zvb4A1-iEjGn3jw@mail.gmail.com>
 <20200221201037.30231-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221201037.30231-1-Jason@zx2c4.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 09:10:37PM +0100, Jason A. Donenfeld wrote:
> It turns out that RDRAND is pretty slow. Comparing these two
> constructions:
> 
>   for (i = 0; i < CHACHA_BLOCK_SIZE; i += sizeof(ret))
>     arch_get_random_long(&ret);
> 
> and
> 
>   long buf[CHACHA_BLOCK_SIZE / sizeof(long)];
>   extract_crng((u8 *)buf);
> 
> it amortizes out to 352 cycles per long for the top one and 107 cycles
> per long for the bottom one, on Coffee Lake Refresh, Intel Core i9-9880H.
> 
> And importantly, the top one has the drawback of not benefiting from the
> real rng, whereas the bottom one has all the nice benefits of using our
> own chacha rng. As get_random_u{32,64} gets used in more places (perhaps
> beyond what it was originally intended for when it was introduced as
> get_random_{int,long} back in the md5 monstrosity era), it seems like it
> might be a good thing to strengthen its posture a tiny bit. Doing this
> should only be stronger and not any weaker because that pool is already
> initialized with a bunch of rdrand data (when available). This way, we
> get the benefits of the hardware rng as well as our own rng.
> 
> Another benefit of this is that we no longer hit pitfalls of the recent
> stream of AMD bugs in RDRAND. One often used code pattern for various
> things is:
> 
>   do {
>   	val = get_random_u32();
>   } while (hash_table_contains_key(val));
> 
> That recent AMD bug rendered that pattern useless, whereas we're really
> very certain that chacha20 output will give pretty distributed numbers,
> no matter what.
> 
> So, this simplification seems better both from a security perspective
> and from a performance perspective.
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks, applied.

						- Ted
