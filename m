Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65CEC35242
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C31F520714
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 20:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3vxb9w3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731115AbgBKU0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 15:26:43 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33027 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728918AbgBKU0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 15:26:43 -0500
Received: by mail-oi1-f193.google.com with SMTP id q81so14139748oig.0;
        Tue, 11 Feb 2020 12:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8xXHirnYMsfW42qWffCZKCgeTYoQTR/f/eFrssIvcBc=;
        b=S3vxb9w3RWHDDEzilj4NQtbOUARTaH1lr+ujyEc2cUA4GRiqYAZz+pZX7j7X1TijVP
         aS5OKS/lNuJ4cLs6ntKVetezUVStwUoZW85DrzOMr4WCRRViu/bfQjPjLK6pVtko3xz9
         LitC/zBWxG0mvqvUHY0TLMpzpuPJEZarQpBdE9hdLYBvYD60KoSch9BY/BUBtifH7PJb
         o4soU9961YGI2+DTu2Onfeiwjh5vzuJgpxMwgp3jd+obzcSUaaaLt2y8D0Ehq3lyuRd8
         9b9zgIeA4sN9qNQ/RhFgL/+w0WEeKOl8keMif/a/IT3EWC7kAFtM31ZojwMpez7gTvM7
         6txw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8xXHirnYMsfW42qWffCZKCgeTYoQTR/f/eFrssIvcBc=;
        b=ZgMm1heamQyFs28/zEFiGHXQXGRT4QxWxqLqTpyJrOh8gaLBfR1OK/pXdFxkW4LTPA
         qUwFe6o9F5cjF61pyLpL0g7fVlv9PBsYctiBhm9HXm3bxUmjpIMzeoRahFdnBVfkZ7D7
         A1FYI/QrohwVNrsH6ys4gMXbYRbgyall57FOrHfbqtIQjG0aH3YAniWkDNVY9a6uMw5+
         WpA9WU5z/wwSvpujpsZ2ZmWu43rsJDuFMilAnEcpWbAJmo1HVQQsqQMsIFy8QwCkRAdo
         pZWgpDL1n5NONcJloZovX1Bf+wD+9gVxipPOYH5i+aVbv+Rs6hfcVDxWkLcimrdDMTRe
         VlhQ==
X-Gm-Message-State: APjAAAV7yOG9Ze81QunG1xNsMD60/oRevR3PDqbB8EMnvDoEJzye6dhR
        FaLAYGbDuxeiOQDbkyniVDwlZNYcZtM=
X-Google-Smtp-Source: APXvYqwkLrD/lcZdWyvfZL+xRXLTYRLL+YSpy1Pi9PDEQeB2T6ELFnW6anz5shH/513wcRpK8HEPQg==
X-Received: by 2002:aca:cf12:: with SMTP id f18mr4119986oig.81.1581452802362;
        Tue, 11 Feb 2020 12:26:42 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id 17sm1567260oty.48.2020.02.11.12.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 12:26:41 -0800 (PST)
Date:   Tue, 11 Feb 2020 13:26:40 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Vasily Gorbik <gor@linux.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: -Wtautological-constant-compare in arch/s390/include/asm/page.h
Message-ID: <20200211202640.GA12483@ubuntu-m2-xlarge-x86>
References: <20200208125714.GA9164@ubuntu-x2-xlarge-x86>
 <1f54ae4c-8748-496b-0833-80749d8d4f6c@de.ibm.com>
 <your-ad-here.call-01581426089-ext-6170@work.hours>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <your-ad-here.call-01581426089-ext-6170@work.hours>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 02:01:29PM +0100, Vasily Gorbik wrote:
> On Mon, Feb 10, 2020 at 08:55:46AM +0100, Christian Borntraeger wrote:
> > 
> > 
> > On 08.02.20 13:57, Nathan Chancellor wrote:
> > > Hi all,
> > > 
> > > We noticed that you all added support for building s390 with clang,
> > > which is great! I have noticed a few warnings for which I will send
> > > patches but this one has me stumped.
> > > 
> > > In file included from ../lib/crypto/sha256.c:16:
> > > In file included from ../include/linux/module.h:13:
> > > In file included from ../include/linux/stat.h:19:
> > > In file included from ../include/linux/time.h:6:
> > > In file included from ../include/linux/seqlock.h:36:
> > > In file included from ../include/linux/spinlock.h:51:
> > > In file included from ../include/linux/preempt.h:78:
> > > In file included from ../arch/s390/include/asm/preempt.h:6:
> > > In file included from ../include/linux/thread_info.h:38:
> > > In file included from ../arch/s390/include/asm/thread_info.h:26:
> > > ../arch/s390/include/asm/page.h:45:6: warning: converting the result of '<<' to a boolean always evaluates to false [-Wtautological-constant-compare]
> > >         if (PAGE_DEFAULT_KEY)
> > >             ^
> > > ../arch/s390/include/asm/page.h:23:44: note: expanded from macro 'PAGE_DEFAULT_KEY'
> > > #define PAGE_DEFAULT_KEY        (PAGE_DEFAULT_ACC << 4)
> > >                                                   ^
> > > 1 warning generated.
> 
> This warning only shows up for the decompressor code and purgatory which
> have separate set of build flags not derived from top level KBUILD_CFLAGS.
> For the rest of the code this warning is suppressed by:
> Makefile:
>  740 ifdef CONFIG_CC_IS_CLANG
> ...
>  744 # Quiet clang warning: comparison of unsigned expression < 0 is always false
>  745 KBUILD_CFLAGS += -Wno-tautological-compare
> 
> At the same time both decompressor and purgatory Makefiles include
> CLANG_FLAGS into their CFLAGS. And this -Wno-tautological-compare is
> clang specific. So I believe this option belongs to CLANG_FLAGS
> rather than being included into KBUILD_CFLAGS under ifdef
> CONFIG_CC_IS_CLANG. But this raises question about other clang
> specific options inside that ifdef CONFIG_CC_IS_CLANG. Should they all
> be made part of CLANG_FLAGS?

Hi Vasily,

I am trying to turn on -Wtautological-compare for the kernel as a whole,
hence me trying to deal with this one now :) That flag controls a bunch
of useful subwarnings that can point out potentially problematic code.

I think that it would be worth adding warnings that we want disabled in
all code to CLANG_FLAGS but as of right now, this is the only instance
of this warning that I see within the s390 code so it is probably just
worth silencing with an explicit comparison (!= 0). I will send a patch
for this later.

Cheers,
Nathan
