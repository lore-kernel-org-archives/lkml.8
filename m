Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A1BFC10F25
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 521472072A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="gDWywhmb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgCFNJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:09:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46158 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgCFNJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:09:24 -0500
Received: by mail-pf1-f195.google.com with SMTP id o24so1084852pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QwvL99c3sTAWScS17ZDj22BvXW0QqQWIhRt4cYTFYXI=;
        b=gDWywhmbdzL/1mNf8BQtKOQQExNz+wqF3qt0L2eaCPZbG2Lj6B7bL8WZg+7u0K5wes
         7pVDP7QvRuKySmNNFafef4bDzshFV/CT33oXdQ+tiARnCAzwniqXtfPzWNYFvlYn8K9m
         KMzZFJKAxHpogMkKBks+kigB6njnZ3FSc9GT4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=QwvL99c3sTAWScS17ZDj22BvXW0QqQWIhRt4cYTFYXI=;
        b=RKNYbHtigw28E+k6yv5KqqKX+0+7OqqfEECyVTiboeHCeIGMPFjOqqpKhITBFwEymR
         PUeqcYfc2Luy59xXUlO4+85otn6DGvppW3EHVOhYOjfkGdlU1GcLZNjK2rQ8oH4jqEu3
         v5aNHL/rlCj/5G5qH5wg+km2VncMptuGn5q2UJ3jLj3CMLJfv/HBGSaMK15sA4A5CAZa
         aGJcUgDNrZ70C8d+iuGQmXXdv+H0xW5odCT6ViZGUEHvuFE+gX64sIahQNOapr/hjIys
         cOHtfZz69VERqTBkYOSNjF8BbUTV4F5X+xLNnYrvPi5KENwCqZvZxNkLlW58rmKcjxP3
         unLg==
X-Gm-Message-State: ANhLgQ07uVR9iiJLuOoqaQR15yUtTla+tw58yZIErR/sqqjLnV5gHdV9
        uyJjnBEVNQ6UsU9b6ZxlJjnCdQ==
X-Google-Smtp-Source: ADFU+vv7MeaUlbRH0dd28x9kTKqYJIqOlQ7piuYzJGALMuTyWBBErd/77e69xbBepw42k+51RfRhkg==
X-Received: by 2002:a63:a351:: with SMTP id v17mr3195903pgn.319.1583500163031;
        Fri, 06 Mar 2020 05:09:23 -0800 (PST)
Received: from localhost (2001-44b8-111e-5c00-b120-f113-a8cb-35fd.static.ipv6.internode.on.net. [2001:44b8:111e:5c00:b120:f113:a8cb:35fd])
        by smtp.gmail.com with ESMTPSA id k5sm9354724pju.29.2020.03.06.05.09.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:09:21 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        aneesh.kumar@linux.ibm.com, bsingharora@gmail.com
Cc:     Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v7 4/4] powerpc: Book3S 64-bit "heavyweight" KASAN support
In-Reply-To: <abcc9f7d-995d-e06e-ef04-1dbd144a38e0@c-s.fr>
References: <20200213004752.11019-1-dja@axtens.net> <20200213004752.11019-5-dja@axtens.net> <abcc9f7d-995d-e06e-ef04-1dbd144a38e0@c-s.fr>
Date:   Sat, 07 Mar 2020 00:09:17 +1100
Message-ID: <87wo7xpr42.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Le 13/02/2020 =C3=A0 01:47, Daniel Axtens a =C3=A9crit=C2=A0:
>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>> index 497b7d0b2d7e..f1c54c08a88e 100644
>> --- a/arch/powerpc/Kconfig
>> +++ b/arch/powerpc/Kconfig
>> @@ -169,7 +169,9 @@ config PPC
>>   	select HAVE_ARCH_HUGE_VMAP		if PPC_BOOK3S_64 && PPC_RADIX_MMU
>>   	select HAVE_ARCH_JUMP_LABEL
>>   	select HAVE_ARCH_KASAN			if PPC32
>> +	select HAVE_ARCH_KASAN			if PPC_BOOK3S_64 && PPC_RADIX_MMU
>
> That's probably detail, but as it is necessary to deeply define the HW=20
> when selecting that (I mean giving the exact amount of memory and with=20
> restrictions like having a wholeblock memory), should it also depend of=20
> EXPERT ?

If it weren't a debug feature I would definitely agree with you, but I
think being a debug feature it's not so necessary. Also anything with
more memory than the config option specifies will still boot - it's just
less memory that won't boot. I've set the default to 1024MB: I know
that's a lot of memory for an embedded system but I think for anything
with the Radix MMU it's an OK default.

I'm sure if mpe disagrees he can add EXPERT when he's merging :)

> Maybe we could have
>
> -  	select HAVE_ARCH_KASAN_VMALLOC		if PPC32
> +	select HAVE_ARCH_KASAN_VMALLOC		if HAVE_ARCH_KASAN

That's a good idea. Done.

Thanks for the review!

Regards,
Daniel

>
>>   	select HAVE_ARCH_KGDB
>>   	select HAVE_ARCH_MMAP_RND_BITS
>>   	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
>
>
> Christophe
