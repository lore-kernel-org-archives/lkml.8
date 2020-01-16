Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DC3C33CB3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5333206E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 05:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="ZgcbuRsf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728898AbgAPFe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 00:34:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42061 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPFe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 00:34:28 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so9648401pfz.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 21:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=axtens.net; s=google;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=OjhLrwSUixWKfHPYVjag4pJ4Twky6Gk6dHImQohRolQ=;
        b=ZgcbuRsf2JHWAKem4b8L9QCIstpEILQ+LtgpSvVyEIFmuJkHkq4wV3UhW+NB3I/p7L
         g8PhhD9MkXc8GNcgMLwPiGkXbVvTxOXXqfpvUxWGjbrkeerRAqqt7CgHVi3clSMsX94r
         2eu6s/C0/gJJDbr9MjhIhO6KsPExdslbKPn1s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=OjhLrwSUixWKfHPYVjag4pJ4Twky6Gk6dHImQohRolQ=;
        b=LX4If+iq320QcGq751gOgYkUcQNAdeqd8H7ls4djDnZP/2wU6ZAPO55EGpN722b9P3
         qDc1U7V2dELSGMnSp5rJHke3IWxToo1ETaZZc7A+DKCPyJXg/YPy+8S9XDcPTfzKw1uw
         PevVih2yahiT+cX7Bnbsroy43ZCav/Xst/2zj6lSAHSqwPTBY/vYxg3uCPidvxqh1t1T
         UhmZ1Mx41ZYFEYAKbF48wHRkOlar44PSRxGyysZWyS/q7Y5dMHJAD4w3DPBnQIsd9cbH
         /uHEXzvwUkblOnBLd3tC1AW+4gsoavdjCTuPUGrUG2i8gP7jHtLisSrKD+bN/a7ntspw
         m1EQ==
X-Gm-Message-State: APjAAAV8jrsWTBrTBeAexKttm+pKouHPNs4AZLqdJboLBXJRlJazfBs5
        ou5abTXgLv/POafABSnvh1RaBQ==
X-Google-Smtp-Source: APXvYqxrN0+qBEVUpua94Qb8xZteFhv2nkLn9S7EhrqzK/2c5Vhq+y51pzR4+MJYtOWvoNtguucHYw==
X-Received: by 2002:aa7:98d0:: with SMTP id e16mr34318946pfm.77.1579152866617;
        Wed, 15 Jan 2020 21:34:26 -0800 (PST)
Received: from localhost (2001-44b8-1113-6700-097c-7eed-afd4-cd15.static.ipv6.internode.on.net. [2001:44b8:1113:6700:97c:7eed:afd4:cd15])
        by smtp.gmail.com with ESMTPSA id p16sm24333466pfq.184.2020.01.15.21.34.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 21:34:25 -0800 (PST)
From:   Daniel Axtens <dja@axtens.net>
To:     Dmitry Vyukov <dvyukov@google.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] kasan: stop tests being eliminated as dead code with FORTIFY_SOURCE
In-Reply-To: <CACT4Y+Y-qPLzn2sur5QnS2h4=Qb2B_5rFxwMKuzhe-hwsReGqg@mail.gmail.com>
References: <20200115063710.15796-1-dja@axtens.net> <20200115063710.15796-2-dja@axtens.net> <CACT4Y+bAuaeHOcTHqp-=ckOb58fRajpGYk4khNzpS7_OyBDQYQ@mail.gmail.com> <917cc571-a25c-3d3e-547c-c537149834d6@c-s.fr> <CACT4Y+Y-qPLzn2sur5QnS2h4=Qb2B_5rFxwMKuzhe-hwsReGqg@mail.gmail.com>
Date:   Thu, 16 Jan 2020 16:34:23 +1100
Message-ID: <87zheoj76o.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> >> +/*
>> >> + * We assign some test results to these globals to make sure the tests
>> >> + * are not eliminated as dead code.
>> >> + */
>> >> +
>> >> +int int_result;
>> >> +void *ptr_result;
>> >
>> > These are globals, but are not static and don't have kasan_ prefix.
>> > But I guess this does not matter for modules?
>> > Otherwise:
>> >
>> > Reviewed-by: Dmitry Vyukov <dvyukov@google.com>
>> >
>>
>> I think if you make them static, GCC will see they aren't used and will
>> eliminate everything still ?
>
> static volatile? :)

Yeah so these are module globals. They'd be accessible from any other
files you linked into the module (currently there are no such
files). They're not visible outside the module because they're not
EXPORTed.

Making them static does lead to them getting eliminated, and 'static
volatile' seems both gross and like something checkpatch would complain
about. I'll leave them as they are but stick a kasan_ prefix on them
just for the additional tidiness.

Regards,
Daniel
