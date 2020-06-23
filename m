Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1143DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E86AA2070E
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 13:42:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732732AbgFWNmf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 09:42:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:43182 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732631AbgFWNme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 09:42:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-42-tuWEcT22NmmyTjcRjBXV1g-1; Tue, 23 Jun 2020 14:42:31 +0100
X-MC-Unique: tuWEcT22NmmyTjcRjBXV1g-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 23 Jun 2020 14:42:30 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 23 Jun 2020 14:42:30 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Andy Lutomirski" <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Alexander Popov <alex.popov@linux.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jann Horn <jannh@google.com>,
        "kernel-hardening@lists.openwall.com" 
        <kernel-hardening@lists.openwall.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Thread-Topic: [PATCH v4 3/5] stack: Optionally randomize kernel stack offset
 each syscall
Thread-Index: AQHWSPkh/p0bc5D3iUelrjbiR4wWCajmNFDA
Date:   Tue, 23 Jun 2020 13:42:30 +0000
Message-ID: <917458f43d194385a760d75292d4eb47@AcuMS.aculab.com>
References: <20200622193146.2985288-1-keescook@chromium.org>
 <20200622193146.2985288-4-keescook@chromium.org>
 <20200622225615.GA3511702@rani.riverdale.lan>
 <202006221604.871B13DE3@keescook>
 <20200623000510.GA3542245@rani.riverdale.lan>
 <202006221748.DA27A7FFC@keescook>
In-Reply-To: <202006221748.DA27A7FFC@keescook>
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

From: Kees Cook
> Sent: 23 June 2020 01:56
> On Mon, Jun 22, 2020 at 08:05:10PM -0400, Arvind Sankar wrote:
> > But I still don't see anything _stopping_ the compiler from optimizing
> > this better in the future. The "=m" is not a barrier: it just informs
> > the compiler that the asm produces an output value in *ptr (and no other
> > outputs). If nothing can consume that output, it doesn't stop the
> > compiler from freeing the allocation immediately after the asm instead
> > of at the end of the function.
> 
> Ah, yeah, I get what you mean.
> 
> > I'm talking about something like
> > 	asm volatile("" : : "r" (ptr) : "memory");
> > which tells the compiler that the asm may change memory arbitrarily.
> 
> Yeah, I will adjust it.
> 
> > Here, we don't use it really as a barrier, but to tell the compiler that
> > the asm may have stashed the value of ptr somewhere in memory, so it's
> > not free to reuse the space that it pointed to until the function
> > returns (unless it can prove that nothing accesses memory, not just that
> > nothing accesses ptr).

Do you need another asm volatile("" : : "r" (ptr) : "memory");
(or similar) at the bottom of the function - that the compiler thinks
might access the memory whose address it thought got saved earlier?

I wonder if it would be easier to allocate the stack space
in the asm wrapper? At least as an architecture option.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

