Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27425C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E96242187F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 06:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ttCnz5S7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728740AbgBNGqb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 01:46:31 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44805 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgBNGqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 01:46:31 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so8140396otj.11;
        Thu, 13 Feb 2020 22:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RKB2u4zCoEkjwdZrkIjqRIz/kGGuU98/UeeGnME5DaU=;
        b=ttCnz5S7kxwNor+Pg9JqXzpmTLKABDEHvB7sGge2iEYkklLODvA9iLE16n0zCr0md5
         LeKRss6HpKBr36JLi8jhVz9ViNQIYqZyGE4wpLx82HCrThF5XBPY01BUY0TySsuWtiX7
         rBwqw+4xI6lw1sUiH+5YlYeRK3aOPhms+VSGSgl6748lUDIgwRJ0DGHWYTWgExt6EUlP
         1zjlhXi6eqJSdUliR4iBiefnczuQX3DEUtEffTFeWf0dFW084tA2boUDhTYlpKqrnSA8
         4H/JWoQZhQvVtd7tO98D0weOOZ1Z4313MtBmtKd1xIbo02a3icnu8ZC3zA+0zRY+h8Gq
         BUFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RKB2u4zCoEkjwdZrkIjqRIz/kGGuU98/UeeGnME5DaU=;
        b=EoeNREgU4mEe5aeQAifVsfUHjplk2we95vMwhfbzItN+hiJntNJJwdb5QjOjVqBvHm
         ODb74B/Zv49jRuMP9KvBbJO9jZ/HXPaNKZAjE01A3QsybPC8ZZd795gZ5jxkQy8hJrJs
         /fyNVE+WJ9teloYP2kwWAjp6g5nHCgBFzmyEbNizdpxPwMPrbOVVWHW52JKJZj80cLqd
         EgbixJK8GX/BBAVSkhJ6ICnUchaKhZiEBpeWlLR9mzOb3IGePVECw9EX8YW0zx8axJRn
         yb+5+ilPFi88cnKLuw0bX66Zt5gFiULyGbxLKcb4i9clV/SqYJXwZPzYDHu0JHIHm/LG
         Ec1g==
X-Gm-Message-State: APjAAAWYQCsHJS1uxFUiND4lStilHSN65svfre0lFMTdMLw28KujHhAg
        xCnQBbmW3JolbdeUP4w2By0=
X-Google-Smtp-Source: APXvYqxitUmGPjrOI8tNqeeGYBJnMjQ984lWNAoWDD0tVEQdx5xYbkwh5EjRMoQiZimnWfEESY1pHw==
X-Received: by 2002:a9d:6f85:: with SMTP id h5mr1082932otq.19.1581662790329;
        Thu, 13 Feb 2020 22:46:30 -0800 (PST)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id r2sm1676849otk.22.2020.02.13.22.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2020 22:46:29 -0800 (PST)
Date:   Thu, 13 Feb 2020 23:46:28 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] s390/kaslr: Fix casts in get_random
Message-ID: <20200214064628.GA14336@ubuntu-m2-xlarge-x86>
References: <20200208141052.48476-1-natechancellor@gmail.com>
 <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba371a74412c07c30eeb26fa25c94c25468599a9.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 08, 2020 at 12:17:20PM -0800, Joe Perches wrote:
> On Sat, 2020-02-08 at 07:10 -0700, Nathan Chancellor wrote:
> > Clang warns:
> > 
> > ../arch/s390/boot/kaslr.c:78:25: warning: passing 'char *' to parameter
> > of type 'const u8 *' (aka 'const unsigned char *') converts between
> > pointers to integer
> > types with different sign [-Wpointer-sign]
> >                                   (char *) entropy, (char *) entropy,
> >                                                     ^~~~~~~~~~~~~~~~
> > ../arch/s390/include/asm/cpacf.h:280:28: note: passing argument to
> > parameter 'src' here
> >                             u8 *dest, const u8 *src, long src_len)
> >                                                 ^
> > 2 warnings generated.
> > 
> > Fix the cast to match what else is done in this function.
> > 
> > Fixes: b2d24b97b2a9 ("s390/kernel: add support for kernel address space layout randomization (KASLR)")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/862
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  arch/s390/boot/kaslr.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/boot/kaslr.c b/arch/s390/boot/kaslr.c
> > index 5d12352545c5..5591243d673e 100644
> > --- a/arch/s390/boot/kaslr.c
> > +++ b/arch/s390/boot/kaslr.c
> > @@ -75,7 +75,7 @@ static unsigned long get_random(unsigned long limit)
> >  		*(unsigned long *) prng.parm_block ^= seed;
> >  		for (i = 0; i < 16; i++) {
> >  			cpacf_kmc(CPACF_KMC_PRNG, prng.parm_block,
> > -				  (char *) entropy, (char *) entropy,
> > +				  (u8 *) entropy, (u8 *) entropy,
> 
> Why not change the function to take void *?
> 
> static inline int cpacf_kmc(unsigned long func, void *param,
> 			    u8 *dest, const u8 *src, long src_len)
> 
> vs:
> 
> static inline int cpacf_kmc(unsigned long func, void *param,
> 			    void *dest, const void *src, long src_len)
> 
> and remove the casts?

I can certainly do that if the maintainers prefer it.

Cheers,
Nathan
