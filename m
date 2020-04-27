Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF31EC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C29462076A
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 17:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dNZ6aoSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgD0RCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0RCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:02:07 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586F2C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:02:07 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id d24so7207367pll.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fz5fzGKUkYrlo1H6ujT5iT4E+OF3TxaMGxP6KIooVcQ=;
        b=dNZ6aoSEy7Lz5a9sDdJ7hoFwM3Ioe/buqvUh/XzcOLY+v/Lj94eIQWHMKCREcj9j0q
         VCEnS2J43l5VzkT6kYl5Lodvz+2yqryKx8JCo2k3IUPXzq9UL6+x1YRvrD55F0DkiUw6
         BWD6qzEghGEYP92HnzMEuDuwjNjpiqR6vQaXrrvJnSsqLbA4PltvdNA/bnVU3ZaxDzsa
         clII1ZYGWxtBmLwk7/Fts+qQwzHD6kf05CCyDbWN3aEoNbULRWN6lTw+CKZbeZCkwewA
         shL7BDdzLmw5o3aYNX8tt+Tr7sx4NJn08ejwFkm18Anpj9zq4Uf4rjnt8W1VFY+TVN0X
         qY9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fz5fzGKUkYrlo1H6ujT5iT4E+OF3TxaMGxP6KIooVcQ=;
        b=Z0LZdljHA1z1BtFmxGuFmZiUXbdFVTMfeBMRVDLZQCk9KaCIBtWgZ0AwTz9MOKnJL2
         Tgw+yLaRxAB4otpS23KESpUSsb49p5N9FatLesZuAI0G2b7xvMfkJJlBI/z/YEZEpmhh
         8Hy1xJLexqCK2HX26LtojI1TbExiezbh8Kpx2tunAxv7eu0z3vXwMVPvpD8px5xPSOzm
         TLBTeFGeFJeSKq+yeOGZ2o4TT4PC48kYFuOZzSiur7QpMnjJU6HlECmignaUBuwI1pVp
         PrwuDpsLJCsP502TQm2BaRweFIgSXIABH8ba7VNq5+RIxQMV1Bqh2VGVfGWP1ZMyoHQS
         eudA==
X-Gm-Message-State: AGi0PuaNQNeLraW/7d3tl81K0B9mPHe5GnTzBDLm/27LUj1ba4amJDr8
        R/iMYYDBAFnI6wElcrYTBNRxfA==
X-Google-Smtp-Source: APiQypKpBJKrBpCU7oIXdhxhHbwoBTjqAi/2yT3gZcDS9xuBm1ijzttixQqfK4ktRUyLkm9P3o0Fcg==
X-Received: by 2002:a17:90a:9b82:: with SMTP id g2mr25145882pjp.72.1588006926605;
        Mon, 27 Apr 2020 10:02:06 -0700 (PDT)
Received: from google.com ([2620:15c:201:2:ce90:ab18:83b0:619])
        by smtp.gmail.com with ESMTPSA id c14sm11299278pgi.54.2020.04.27.10.02.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 10:02:05 -0700 (PDT)
Date:   Mon, 27 Apr 2020 10:01:59 -0700
From:   Sami Tolvanen <samitolvanen@google.com>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v13 01/12] add support for Clang's Shadow Call Stack (SCS)
Message-ID: <20200427170159.GA236495@google.com>
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200427160018.243569-1-samitolvanen@google.com>
 <20200427160018.243569-2-samitolvanen@google.com>
 <CANiq72=vvRcjWCON7zbaCTxLA2wP_-5zrnLyymR4g9b1gwc5kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANiq72=vvRcjWCON7zbaCTxLA2wP_-5zrnLyymR4g9b1gwc5kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 06:48:49PM +0200, Miguel Ojeda wrote:
> On Mon, Apr 27, 2020 at 6:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
> >
> > diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> > index 333a6695a918..18fc4d29ef27 100644
> > --- a/include/linux/compiler-clang.h
> > +++ b/include/linux/compiler-clang.h
> > @@ -42,3 +42,9 @@
> >   * compilers, like ICC.
> >   */
> >  #define barrier() __asm__ __volatile__("" : : : "memory")
> > +
> > +#if __has_feature(shadow_call_stack)
> > +# define __noscs       __attribute__((__no_sanitize__("shadow-call-stack")))
> > +#else
> > +# define __noscs
> > +#endif
> 
> Can we remove the `#else` branch? compiler_types.h [*] has to care
> anyway about that case for other compilers anyway, no?

Yes, it's unnecessary. I'll remove this in the next version. Thanks!

Sami
