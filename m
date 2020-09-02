Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A34C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6A3E20829
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:58:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728288AbgIBP6q convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:58:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44606 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726966AbgIBP6o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:58:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-Po3PB6J_PqmkV15ZeYhDvA-1; Wed, 02 Sep 2020 16:58:39 +0100
X-MC-Unique: Po3PB6J_PqmkV15ZeYhDvA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 2 Sep 2020 16:58:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 2 Sep 2020 16:58:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Arvind Sankar' <nivedita@alum.mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>
CC:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Ingo Molnar" <mingo@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Will Deacon <will@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: RE: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Thread-Topic: [PATCH v2] x86/asm: Replace __force_order with memory clobber
Thread-Index: AQHWgT6ArcDzK8wpBE22M0o9dUjAEKlVf9pQ
Date:   Wed, 2 Sep 2020 15:58:38 +0000
Message-ID: <55a35a3d8fba417aabe63ad13d519198@AcuMS.aculab.com>
References: <20200823212550.3377591-1-nivedita@alum.mit.edu>
 <20200902153346.3296117-1-nivedita@alum.mit.edu>
In-Reply-To: <20200902153346.3296117-1-nivedita@alum.mit.edu>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arvind Sankar
> Sent: 02 September 2020 16:34
> 
> The CRn accessor functions use __force_order as a dummy operand to
> prevent the compiler from reordering the inline asm.
> 
> The fact that the asm is volatile should be enough to prevent this
> already, however older versions of GCC had a bug that could sometimes
> result in reordering. This was fixed in 8.1, 7.3 and 6.5. Versions prior
> to these, including 5.x and 4.9.x, may reorder volatile asm.
> 
> There are some issues with __force_order as implemented:
> - It is used only as an input operand for the write functions, and hence
>   doesn't do anything additional to prevent reordering writes.
> - It allows memory accesses to be cached/reordered across write
>   functions, but CRn writes affect the semantics of memory accesses, so
>   this could be dangerous.
> - __force_order is not actually defined in the kernel proper, but the
>   LLVM toolchain can in some cases require a definition: LLVM (as well
>   as GCC 4.9) requires it for PIE code, which is why the compressed
>   kernel has a definition, but also the clang integrated assembler may
>   consider the address of __force_order to be significant, resulting in
>   a reference that requires a definition.
> 
> Fix this by:
> - Using a memory clobber for the write functions to additionally prevent
>   caching/reordering memory accesses across CRn writes.
> - Using a dummy input operand with an arbitrary constant address for the
>   read functions, instead of a global variable. This will prevent reads
>   from being reordered across writes, while allowing memory loads to be
>   cached/reordered across CRn reads, which should be safe.

How much does using a full memory clobber for the reads cost?

It would remove any chance that the compiler decides it needs to
get the address of the 'dummy' location into a register so that
it can be used as a memory reference in a generated instruction
(which is probably what was happening for PIE compiles).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

