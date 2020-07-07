Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0A9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:35:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE91D206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:35:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728006AbgGGMf1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:35:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:20162 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726757AbgGGMf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:35:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-127-DZi8_WbPMySV8HLlQY31ww-1; Tue, 07 Jul 2020 13:35:22 +0100
X-MC-Unique: DZi8_WbPMySV8HLlQY31ww-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 7 Jul 2020 13:35:16 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 7 Jul 2020 13:35:16 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: objtool clac/stac handling change..
Thread-Topic: objtool clac/stac handling change..
Thread-Index: AQHWUaiHCXC7llURSE6cKT9wSRp9Xaj8B+9w
Date:   Tue, 7 Jul 2020 12:35:16 +0000
Message-ID: <b95ffa72db83431b95597a35f63d8e33@AcuMS.aculab.com>
References: <CAHk-=wj-CYhKZR8ZKQgi=VTx=o7n6dtwPXikvgkJ3SdiqRPd8A@mail.gmail.com>
 <87lfk26nx4.fsf@mpe.ellerman.id.au>
 <CAHk-=wicOPQwuDUzFyDTBgr4UvQJHPdCX7_6BLaK6cve6CqBSg@mail.gmail.com>
 <20200702201755.GO2786714@ZenIV.linux.org.uk>
 <CAHk-=whW7qYEK-MJMS9gKf-K4cBNGTq0pv-5wo4bqE_QtUfkDw@mail.gmail.com>
 <20200702205902.GP2786714@ZenIV.linux.org.uk>
 <CAHk-=whm66UhcEQgXHr8hPkzyDTOdbGikLbSg0zJ4-b93aSg8w@mail.gmail.com>
 <20200703013328.GQ2786714@ZenIV.linux.org.uk>
 <20200703210237.GS2786714@ZenIV.linux.org.uk>
 <20200704004959.GY2786714@ZenIV.linux.org.uk>
 <20200704021157.GZ2786714@ZenIV.linux.org.uk>
In-Reply-To: <20200704021157.GZ2786714@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro
> Sent: 04 July 2020 03:12
...
> BTW, looking at csum_and_copy_{to,from}_user() callers (all 3 of them,
> all in lib/iov_iter.c) we have this:
> 	1) len is never 0
> 	2) sum (initial value of csum) is always 0
> 	3) failure (reported via *err_ptr) is always treateds as "discard
> the entire iovec segment (and possibly the entire iovec)".  Exact value
> put into *err_ptr doesn't matter (it's only compared to 0) and in case of
> error the return value is ignored.
> 
> Now, using ~0U instead of 0 for initial sum would yield an equivalent csum
> (comparable modulo 2^16-1) *AND* never yield 0 (recall how csum addition works).
> 
> IOW, we could simply return 0 to indicate an error.  Which gives much saner
> calling conventions:
> __wsum csum_and_copy_from_user(const void __user *src, void *dst, int len)
> copying the damn thing and returning 0 on error or a non-zero value comparable
> to csum of the data modulo 2^16-1 on success.  Same for csum_and_copy_to_user()
> (modulo const and __user being on the other argument).
> 
> For x86 it simplifies the instances (both the inline wrappers and asm parts);
> I hadn't checked the other architectures yet, but it looks like that should
> be doable for all architectures.  And it does simplify the callers...

All the csum functions should let the caller pass in a small value
to be added in (could be over 2^32 on 64 bit systems) since that is
normally 'free' in the algorithm - certainly better than adding it
it at the end - which is what the current x86 code does.
(For 64bit systems the 'small' value can exceed 2^32.)

I also wonder if the csum_and_copy() functions are actually worthwhile on x86.
The csum code can run at 8 bytes/clock on all Intel cpu since ivy bridge.
(It doesn't, it only does 4 bytes/clock until (IIRC) Haswell [1].)
On cpu that support ADCX/ADOX you may do better - probably 12 bytes/clock,
I think 16 bytes/clock is wishful thinking.
But there is no leeway for any extra uops in either case.

However trying to get a memory read, memory write, adc and bits of loop
control scheduled in one clock is probably impossible - even though
it might not exceed the number of uops the execution pipelines can process.
ISTR that just separating the memory read from the adc slows
thing down too much - probably issues with retiring instructions.
So I don't think it can get near 8 bytes/clock.

OTOH a copy operation trivially does 8 bytes/clock.
I even think 'rep movsq' is faster - never mind the fast 'rep movsb'.

So separate copy and checksum passes should easily exceed 4 bytes/clock,
but I suspect that doing them together never does.
(Unless the buffer is too big for the L1 cache.)

[1] The underlying problem is that a uop can only have 2 inputs.
ADC needs three (two values and the carry flag).
So the ADC instruction takes two clocks.
From ivy bridge (sandy?) the carry flag is available early,
so adding to alternate registers lets you do 1 per clock.
So the existing csum function is rather slower than adding
32bit values to a 64bit register on most older cpus.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

