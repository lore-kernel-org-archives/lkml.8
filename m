Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A83DAC35656
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 896FF2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 15:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbgBUPd7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 10:33:59 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:56745 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbgBUPd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 10:33:59 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-214-eMyEWOzeMhKDhmybp4jdXw-1; Fri, 21 Feb 2020 15:33:54 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 21 Feb 2020 15:33:53 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 21 Feb 2020 15:33:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jesse Brandeburg' <jesse.brandeburg@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux@rasmusvillemoes.dk" <linux@rasmusvillemoes.dk>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: RE: [PATCH v3 1/2] x86: fix bitops.h warning with a moved cast
Thread-Topic: [PATCH v3 1/2] x86: fix bitops.h warning with a moved cast
Thread-Index: AQHV6EScwamYP56GlUmFigARI6lhOqglx7RQ
Date:   Fri, 21 Feb 2020 15:33:53 +0000
Message-ID: <ca95b4325c8c44258672b7822ab4d16b@AcuMS.aculab.com>
References: <20200220232155.2123827-1-jesse.brandeburg@intel.com>
In-Reply-To: <20200220232155.2123827-1-jesse.brandeburg@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: eMyEWOzeMhKDhmybp4jdXw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Brandeburg
> Fix many sparse warnings when building with C=1.
> 
> When the kernel is compiled with C=1, there are lots of messages like:
>   arch/x86/include/asm/bitops.h:77:37: warning: cast truncates bits from constant value (ffffff7f
> becomes 7f)
> 
> CONST_MASK() is using a signed integer "1" to create the mask which
> is later cast to (u8) when used. Move the cast to the definition and
> clean up the calling sites to prevent sparse from warning.
> 
> The reason the warning was occurring is because certain bitmasks that
> end with a mask next to a natural boundary like 7, 15, 23, 31, end up
> with a mask like 0x7f, which then results in sign extension when doing
> an invert (but I'm not a compiler expert). It was really only
> "clear_bit" that was having problems, and it was only on bit checks next
> to a byte boundary (top bit).
> 
> Verified with a test module (see next patch) and assembly inspection
> that the patch doesn't introduce any change in generated code.
...
> diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
> index 062cdecb2f24..96ef19dcbde6 100644
> --- a/arch/x86/include/asm/bitops.h
> +++ b/arch/x86/include/asm/bitops.h
...
> @@ -74,7 +74,7 @@ arch_clear_bit(long nr, volatile unsigned long *addr)
>  	if (__builtin_constant_p(nr)) {
>  		asm volatile(LOCK_PREFIX "andb %1,%0"
>  			: CONST_MASK_ADDR(nr, addr)
> -			: "iq" ((u8)~CONST_MASK(nr)));
> +			: "iq" (0xff ^ CONST_MASK(nr)));

IMHO (CONST_MASK(nr) ^ 0xff) is better.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

