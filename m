Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03B2FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D44E820780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 13:32:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="l0MCkVmw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgGBNcZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 09:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729119AbgGBNcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 09:32:24 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBB2C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 06:32:24 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49yJtC3cNTz9sTb;
        Thu,  2 Jul 2020 23:32:19 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1593696740;
        bh=JqsaKRVlWCzam4qhedKHbnSexxiQI2HEvoXSve9jaPQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=l0MCkVmwk66LBjNPWNN/HjHzeTdjJg8FVXUE7JjBev8vXPAdaEBFv+9QAClUghvRx
         I2SAEKRi8dpR5gwGC0pck0QDrQUIIM8me/3dmsR3cO52qPMzQEO7uqi19i8m8VPOmj
         kw3xPTE3Azbhq1eRUCB4qFZ4UlTxxSTEcP1XlAm+NaPyZ/XtgHEHrMMl8clVD8rPel
         csZDqg/ndAhmUitXVKgjQpHbclC8Ihc1avrM6bhNJ4AjvfP94RvRIKAK/h5YD7XgAo
         Vkx8cT4g+sld2CZdr4TNUghpvv73m3O+1ke44dKyVRFQ2e4QD1pba5mdZQHpzyDtRS
         xxv1d3MX/RzLQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: objtool clac/stac handling change..
In-Reply-To: <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
References: <CAHk-=wjc-ktbOr7ZHMY8gfAmHxUK+aMdDsQjeh+BvmQwnQfN_g@mail.gmail.com> <20200701184131.GI2786714@ZenIV.linux.org.uk> <CAHk-=wj_2v9m+yZioE4vOLGW1mc9SBa5+++LdeJ86aEeB5OXcw@mail.gmail.com> <20200701195914.GK2786714@ZenIV.linux.org.uk> <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
Date:   Thu, 02 Jul 2020 23:34:31 +1000
Message-ID: <87lfk26nx4.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Wed, Jul 1, 2020 at 12:59 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>> On Wed, Jul 01, 2020 at 12:04:36PM -0700, Linus Torvalds wrote:
>> >
>> > That's actually for the access granting. Shutting the access down ends
>> > up always doing the same thing anyway..
>>
>> #define user_read_access_end            prevent_current_read_from_user
>> #define user_write_access_end           prevent_current_write_to_user
>> static inline void prevent_current_read_from_user(void)
>> {
>>         prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_READ);
>> }
>>
>> static inline void prevent_current_write_to_user(void)
>> {
>>         prevent_user_access(NULL, NULL, ~0UL, KUAP_CURRENT_WRITE);
>> }
>>
>> and prevent_user_access() has instances that do care about the direction...
>
> Go and look closer.
>
> There are three cases:
>
>  (a) the 32-bit book3s case. It looks like it cares, but when you look
> closer, it ends up not caring about the read side, and saving the
> "which address to I allow user writes to" in current->thread.kuap
>
>  (b) the nohash 32-bit case - doesn't care
>
>  (c) the 64-bit books case - doesn't care
>
> So yes, in the (a) case it does make a difference between reads and
> writes, but at least as far as I can tell, it ignores the read case,
> and has code to avoid the unnecessary "disable user writes" case when
> there was only a read enable done.

Yeah that's my understanding too.

Christophe is the expert on that code so I'll defer to him if I'm wrong.

> Now, it's possible that I'm wrong, but the upshot of that is that even
> on powerpc, I think that if we just made the rule be that "taking a
> user exception should automatically do the 'user_access_end()' for us"
> is trivial.

I think we can do something to make it work.

We don't have an equivalent of x86's ex_handler_uaccess(), so it's not
quite as easy as whacking a user_access_end() in there.

Probably the simplest option for us is to just handle it in our
unsafe_op_wrap(). I'll try and come up with something tomorrow.

cheers
