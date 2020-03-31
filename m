Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C642DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:36:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A9A20842
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 22:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFGazVTm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731319AbgCaWgl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 18:36:41 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:36155 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727955AbgCaWgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 18:36:41 -0400
Received: by mail-oi1-f195.google.com with SMTP id k18so20492061oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 15:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=PCkuNYX5Y1DiFeU+I1dLaQDU7lZ3r1TK5BjT1r/iMHA=;
        b=BFGazVTmhE2AtUwT4yvqeN2PkTKCLR16uj8T19NoHr9d3oTOvsU7wd3A3Oz3u1C9Ix
         FsT53ZGHB/wvM0wwzr9e/+TUoJA3769FCKnzYAAZBYjxbwPNbiGkn0cysXs7g66si3WH
         AD3WJXMNbzwMiGkpPiaqKZQ7sM7iwFAPEuzUBwU59jxbPfjo0ocOjCFPyxNWFLtwTlrT
         ldwavlsc3T2IniWNkoL1K+XMc4EyJJeIdyYxxZvPgwzIY+3GKMccNN0D0NwBxrjGtxhl
         vZfTsObBeOcDO/dHIPZitDlhUYRXYgvWYJ9tATUIlojZbBOUsWMYrxBNWq7i0kVnloCj
         QNTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=PCkuNYX5Y1DiFeU+I1dLaQDU7lZ3r1TK5BjT1r/iMHA=;
        b=WwrUvjJ1AS8OzdX8HZaAFeOnjQOYj0hcC+90rr/DyM8I+A3KI8Z28rBwtAZi+r/78s
         H5BtjdDGDiPMlIqhVy+Cant/P6sBB5hbRmDpLr5uwaIu3aGK0zKewTq2x1QanRjW8pWY
         3Whky4j8jqOX5gybacI39dwDaVHRcITnc6103jqYcTdqx8dLKTOiBWNx4ncDPKurOJHV
         5erNvFywsPD+ymJt7+V3rYEuZRZK7sFbjgtupxZsjA8LUbfi8k/vJmrLd2SPESChBv7T
         SngSd+aIA3MofPKxmhglKtgYYItt/X1QDbxKcF49BCPaW6RXN61cdxGnaJCOnkx0umP0
         xwkw==
X-Gm-Message-State: AGi0PuaYgoslRvqtK8gqgutao4bSJbtLm5jlqKOkO7dWiOoWdtZgeGjA
        VlNc0aVBSnjnwqFtbcO9194=
X-Google-Smtp-Source: APiQypI5yR0lu5/DY/5OQ82Zit/b/IP9uRL51fI2TCysehuUvYqw/th0kfqn69TWuUt94WqugMmVNA==
X-Received: by 2002:aca:d68a:: with SMTP id n132mr892459oig.40.1585694200626;
        Tue, 31 Mar 2020 15:36:40 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id o1sm28285otl.49.2020.03.31.15.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 15:36:40 -0700 (PDT)
Date:   Tue, 31 Mar 2020 15:36:38 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Daniel Santos <daniel.santos@pobox.com>
Cc:     Vegard Nossum <vegard.nossum@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Ian Abbott <abbotti@mev.co.uk>
Subject: Re: [PATCH] compiler.h: fix error in BUILD_BUG_ON() reporting
Message-ID: <20200331223638.GA53668@ubuntu-m2-xlarge-x86>
References: <20200331112637.25047-1-vegard.nossum@oracle.com>
 <91730318-da0e-c992-f154-a74044b26650@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91730318-da0e-c992-f154-a74044b26650@pobox.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 05:25:38PM -0500, Daniel Santos wrote:
> On 3/31/20 6:26 AM, Vegard Nossum wrote:
> > compiletime_assert() uses __LINE__ to create a unique function name.
> > This means that if you have more than one BUILD_BUG_ON() in the same
> > source line (which can happen if they appear e.g. in a macro), then
> > the error message from the compiler might output the wrong condition.
> >
> > For this source file:
> >
> > 	#include <linux/build_bug.h>
> >
> > 	#define macro() \
> > 		BUILD_BUG_ON(1); \
> > 		BUILD_BUG_ON(0);
> >
> > 	void foo()
> > 	{
> > 		macro();
> > 	}
> >
> > gcc would output:
> >
> > ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_9’ declared with attribute error: BUILD_BUG_ON failed: 0
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> >
> > However, it was not the BUILD_BUG_ON(0) that failed, so it should say 1
> > instead of 0. With this patch, we use __COUNTER__ instead of __LINE__, so
> > each BUILD_BUG_ON() gets a different function name and the correct
> > condition is printed:
> >
> > ./include/linux/compiler.h:350:38: error: call to ‘__compiletime_assert_0’ declared with attribute error: BUILD_BUG_ON failed: 1
> >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >
> > Cc: Daniel Santos <daniel.santos@pobox.com>
> > Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> > Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> > Cc: Ian Abbott <abbotti@mev.co.uk>
> > Signed-off-by: Vegard Nossum <vegard.nossum@oracle.com>
> > ---
> >  include/linux/compiler.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> > index 5e88e7e33abec..034b0a644efcc 100644
> > --- a/include/linux/compiler.h
> > +++ b/include/linux/compiler.h
> > @@ -347,7 +347,7 @@ static inline void *offset_to_ptr(const int *off)
> >   * compiler has support to do so.
> >   */
> >  #define compiletime_assert(condition, msg) \
> > -	_compiletime_assert(condition, msg, __compiletime_assert_, __LINE__)
> > +	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
> >  
> >  #define compiletime_assert_atomic_type(t)				\
> >  	compiletime_assert(__native_word(t),				\
> 
> This will break builds using gcc 4.2 and earlier and the expectation was
> that you don't put two of them on the same line -- not helpful in macros
> where it all must be on the same line.  Is gcc 4.2 still supported?  If
> so, I recommend using another macro for the unique number that uses
> __COUNTER__ if available and __LINE__ otherwise.  This was the decision
> for using __LINE__ when I wrote the original anyway.
> 
> Also note that this construct:
> 
> BUILD_BUG_ON_MSG(0, "I like chicken"); BUILD_BUG_ON_MSG(1, "I don't like
> chicken");
> 
> will incorrectly claim that I like chicken.  This is because of how
> __attribute__((error)) works -- gcc will use the first declaration to
> define the error message.
> 
> I couple of years ago, I almost wrote a gcc extension to get rid of this
> whole mess and just __builtin_const_assert(cond, msg).  Maybe I'll
> finish that this year.
> 
> Daniel

No, GCC 4.6 is the minimum required version and it is highly likely that
the minimum version of GCC will be raised to 4.8 soon:

https://lore.kernel.org/lkml/20200123153341.19947-10-will@kernel.org/
https://git.kernel.org/peterz/queue/c/0e75b883b400ac4b1dafafe3cbd2e0a39b714232

Cheers,
Nathan
