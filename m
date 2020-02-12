Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCBB2C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADDD12073C
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="l9MckMLM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727756AbgBLKMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:12:18 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34923 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgBLKMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:12:17 -0500
Received: by mail-pf1-f193.google.com with SMTP id y73so1019558pfg.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 02:12:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KF/rQa9b+YDdw75c1nDcpos7LuX+EOPNM62K9KllEpE=;
        b=l9MckMLM6VWO1ur/vOxwH7Ki/VdQKc3ohUWRt7Z+z5CEQdKhRYppYU0suH5JuIRRlW
         zMhhtPNhmyl6LV8NVVEBOxpA493MJxADljyEKDs7i7DResuH38OdDodI3gJp2XbHbmzF
         pl4+t+bEOXPrykcn67P2WFq+uELfWizH8f2Yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=KF/rQa9b+YDdw75c1nDcpos7LuX+EOPNM62K9KllEpE=;
        b=Y+JbzucXaC5OeCltyffgw+tCeCNVDw6qHAkhjyP53XwP14Y50e9ti+FCuGUlqSuny/
         yy/VKTvliqdFy9czY++DFnC/tPektLyvxHxUPorC+hwCGZZzvDxqYg7ffTVR9K6GX8Eq
         Uy+/pmuPa/bNKUq22j/RM2QaT/BtKpmSRcXEqsf5m+sFCkF86BKosHRA3IDP/rpfBtKg
         NA50wmbWKNEBpTRnksdyxjCgEFw8f6PQ1IoRmlQZL7F4lZ+loQ64F7LO1286wdOTAXMo
         5x7CPbyIapwmGgjvqkj1w4z3brX/vJ0Z4RdVTW0Bg4yFROYq3TKfGgh9KUV/fYvAQFRy
         LZkw==
X-Gm-Message-State: APjAAAUkl0wW0MUwpGs/BMLxHgFEdqxMkW41ctMlJDFg1K6RcQyeTPCB
        UeY4ypWkTPcmcywQmDL54D92/w==
X-Google-Smtp-Source: APXvYqx8As5sCy+kyC1OBVsfxJsYqEDJa2CntdnKeubs3WgKdDjGAI/TLJdKgvADeZfCHkDrxyuXxQ==
X-Received: by 2002:a63:d44e:: with SMTP id i14mr7939813pgj.417.1581502336089;
        Wed, 12 Feb 2020 02:12:16 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-65dc-9b98-63a7-c7a4.static.ipv6.internode.on.net. [2001:44b8:1113:6700:65dc:9b98:63a7:c7a4])
        by smtp.gmail.com with ESMTPSA id e7sm190440pfj.114.2020.02.12.02.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 02:12:15 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <224745f3-db66-fe46-1459-d1d41867b4f3@c-s.fr>
References: <20200212054724.7708-1-dja@axtens.net> <20200212054724.7708-5-dja@axtens.net> <224745f3-db66-fe46-1459-d1d41867b4f3@c-s.fr>
Date:   Wed, 12 Feb 2020 21:12:12 +1100
Message-ID: <87imkcru6b.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 12/02/2020 =C3=A0 06:47, Daniel Axtens a =C3=A9crit=C2=A0:
>> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm=
/kasan.h
>> index fbff9ff9032e..2911fdd3a6a0 100644
>> --- a/arch/powerpc/include/asm/kasan.h
>> +++ b/arch/powerpc/include/asm/kasan.h
>> @@ -2,6 +2,8 @@
>>   #ifndef __ASM_KASAN_H
>>   #define __ASM_KASAN_H
>>=20=20=20
>> +#include <asm/page.h>
>> +
>>   #ifdef CONFIG_KASAN
>>   #define _GLOBAL_KASAN(fn)	_GLOBAL(__##fn)
>>   #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(__##fn)
>> @@ -14,29 +16,41 @@
>>=20=20=20
>>   #ifndef __ASSEMBLY__
>>=20=20=20
>> -#include <asm/page.h>
>> -
>>   #define KASAN_SHADOW_SCALE_SHIFT	3
>>=20=20=20
>>   #define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
>>   				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
>>=20=20=20
>> +#ifdef CONFIG_KASAN_SHADOW_OFFSET
>>   #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
>> +#endif
>>=20=20=20
>> +#ifdef CONFIG_PPC32
>>   #define KASAN_SHADOW_END	0UL
>>=20=20=20
>> -#define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
>> +#ifdef CONFIG_KASAN
>> +void kasan_late_init(void);
>> +#else
>> +static inline void kasan_late_init(void) { }
>> +#endif
>> +
>> +#endif
>> +
>> +#ifdef CONFIG_PPC_BOOK3S_64
>> +#define KASAN_SHADOW_END	(KASAN_SHADOW_OFFSET + \
>> +				 (RADIX_VMEMMAP_END >> KASAN_SHADOW_SCALE_SHIFT))
>> +
>> +static inline void kasan_late_init(void) { }
>> +#endif
>>=20=20=20
>>   #ifdef CONFIG_KASAN
>>   void kasan_early_init(void);
>>   void kasan_mmu_init(void);
>>   void kasan_init(void);
>> -void kasan_late_init(void);
>>   #else
>>   static inline void kasan_init(void) { }
>>   static inline void kasan_mmu_init(void) { }
>> -static inline void kasan_late_init(void) { }
>>   #endif
>
> Why modify all this kasan_late_init() stuff ?
>
> This function is only called from kasan init_32.c, it is never called by=
=20
> PPC64, so you should not need to modify anything at all.

I got a compile error for a missing symbol. I'll repro it and attach it.

Regards,
Daniel

>
> Christophe
