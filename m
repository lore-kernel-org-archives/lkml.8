Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33030C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B03120714
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 12:16:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="XWCVr0we"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbgBLMQb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 07:16:31 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35869 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgBLMQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 07:16:31 -0500
Received: by mail-pl1-f193.google.com with SMTP id a6so909076plm.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 04:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=ORoK11ERH5m7YuJvIylQ/MWzmpJfOKr+pxcrwqBrMvQ=;
        b=XWCVr0we/B0Dnr38QeVN0NAFBB7OHmJ6catF4Y/m8KUXV6l1ibCWIyD6aROfJdFo9Q
         ys5FzIM1S4R9WZVpjIF+j0u96+EHCi/Uhcf05fseXW6fudw77tn/uCmRGDs36XDbemzz
         0r6x9Ef6eJ3zC+P5L1ag/zMCrB7t/hSxhwWhM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ORoK11ERH5m7YuJvIylQ/MWzmpJfOKr+pxcrwqBrMvQ=;
        b=maTzdFyOTAYdUoy9kwHFV+K7PJ7R6WZq/tJhxweFh44wmUYrnxWK8ZHY7P4Fw59k/c
         ILZpIu1Xd27+P2T9uhs7bL7a2MJWhXZzdegwBAs3kLbVI98PTD5E29QRX7l+8Zdgy3FH
         Y++5WI/JSAbqwy/Z95HlakxY9ZxsgEd4z1a+rNnTUzgyRZFZNiqpvBB1hopjlmFygMwB
         ury9tHprFU9Y8ZDUqpaxk4/omCP+EhQhGxzZanMMnejRrq/UJ1gYut5luJ3FLWWWOn/S
         /oXIneecWGF73azmFSxixEiMFJxcfLQXqDJqbSIhZdggiqAWHOQNkhx1kPw/3OUG88HK
         ZcQQ==
X-Gm-Message-State: APjAAAVPbzxAR/0ZhsrEE6Txdc5SXEjAWVWp8L0Wl0uhqrSSFl3Tes2u
        tg4ROYDJWGCCP8LAfJhthgcXXA==
X-Google-Smtp-Source: APXvYqzZYTz24FDyHd0eRpGzSXdXy/ZDf7dLI/ImpCx1ChsLkUO9NJ/LKn0a3OCf6UX0E41BiUUemA==
X-Received: by 2002:a17:902:34d:: with SMTP id 71mr7957844pld.140.1581509789395;
        Wed, 12 Feb 2020 04:16:29 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-65dc-9b98-63a7-c7a4.static.ipv6.internode.on.net. [2001:44b8:1113:6700:65dc:9b98:63a7:c7a4])
        by smtp.gmail.com with ESMTPSA id z27sm749357pfj.107.2020.02.12.04.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 04:16:25 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v6 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <5e392944-50ac-ed06-5896-2664894335d9@c-s.fr>
References: <20200212054724.7708-1-dja@axtens.net> <20200212054724.7708-5-dja@axtens.net> <224745f3-db66-fe46-1459-d1d41867b4f3@c-s.fr> <87imkcru6b.fsf@dja-thinkpad.axtens.net> <5e392944-50ac-ed06-5896-2664894335d9@c-s.fr>
Date:   Wed, 12 Feb 2020 23:16:21 +1100
Message-ID: <87ftfgrofe.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 12/02/2020 =C3=A0 11:12, Daniel Axtens a =C3=A9crit=C2=A0:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>=20
>>> Le 12/02/2020 =C3=A0 06:47, Daniel Axtens a =C3=A9crit=C2=A0:
>>>> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/a=
sm/kasan.h
>>>> index fbff9ff9032e..2911fdd3a6a0 100644
>>>> --- a/arch/powerpc/include/asm/kasan.h
>>>> +++ b/arch/powerpc/include/asm/kasan.h
>>>> @@ -2,6 +2,8 @@
>>>>    #ifndef __ASM_KASAN_H
>>>>    #define __ASM_KASAN_H
>>>>=20=20=20=20
>>>> +#include <asm/page.h>
>>>> +
>>>>    #ifdef CONFIG_KASAN
>>>>    #define _GLOBAL_KASAN(fn)	_GLOBAL(__##fn)
>>>>    #define _GLOBAL_TOC_KASAN(fn)	_GLOBAL_TOC(__##fn)
>>>> @@ -14,29 +16,41 @@
>>>>=20=20=20=20
>>>>    #ifndef __ASSEMBLY__
>>>>=20=20=20=20
>>>> -#include <asm/page.h>
>>>> -
>>>>    #define KASAN_SHADOW_SCALE_SHIFT	3
>>>>=20=20=20=20
>>>>    #define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
>>>>    				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
>>>>=20=20=20=20
>>>> +#ifdef CONFIG_KASAN_SHADOW_OFFSET
>>>>    #define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
>>>> +#endif
>>>>=20=20=20=20
>>>> +#ifdef CONFIG_PPC32
>>>>    #define KASAN_SHADOW_END	0UL
>>>>=20=20=20=20
>>>> -#define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
>>>> +#ifdef CONFIG_KASAN
>>>> +void kasan_late_init(void);
>>>> +#else
>>>> +static inline void kasan_late_init(void) { }
>>>> +#endif
>>>> +
>>>> +#endif
>>>> +
>>>> +#ifdef CONFIG_PPC_BOOK3S_64
>>>> +#define KASAN_SHADOW_END	(KASAN_SHADOW_OFFSET + \
>>>> +				 (RADIX_VMEMMAP_END >> KASAN_SHADOW_SCALE_SHIFT))
>>>> +
>>>> +static inline void kasan_late_init(void) { }
>>>> +#endif
>>>>=20=20=20=20
>>>>    #ifdef CONFIG_KASAN
>>>>    void kasan_early_init(void);
>>>>    void kasan_mmu_init(void);
>>>>    void kasan_init(void);
>>>> -void kasan_late_init(void);
>>>>    #else
>>>>    static inline void kasan_init(void) { }
>>>>    static inline void kasan_mmu_init(void) { }
>>>> -static inline void kasan_late_init(void) { }
>>>>    #endif
>>>
>>> Why modify all this kasan_late_init() stuff ?
>>>
>>> This function is only called from kasan init_32.c, it is never called by
>>> PPC64, so you should not need to modify anything at all.
>>=20
>> I got a compile error for a missing symbol. I'll repro it and attach it.
>>=20
>
> Oops, sorry. I looked too quickly. It is defined in kasan_init_32.c and=20
> called from mm/mem.c
>
> We don't have a performance issue here, since this is called only once=20
> during startup. Could you define an empty kasan_late_init() in=20
> init_book3s_64.c instead ?

Yeah, I can do that, will respin tomorrow.

Would you mind having a quick check of the documentation changes in
patches 2 and 4? I just want to confirm I've accurately captured the
state of ppc32 kasan work.

Thanks!
Daniel
>
> Christophe
