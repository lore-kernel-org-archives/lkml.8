Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173F5C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:55:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3D33206EB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 09:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JUY6usis"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390438AbgFYJz2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388485AbgFYJz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 05:55:27 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF181C061573
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:55:25 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so2689347oty.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 02:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4hwCzEKNVVtYUcP9iGUfverr8jzUkSL0upCgG6MPSvQ=;
        b=JUY6usisXccEtte68sxi8hKIMjPYblE14C/rRRT8Hiadjq+cMPZCkvCZe49/ImVY+2
         1yOdAqULER2WtlIzK6PLheZ6rtyVKfwB+9FbZzlM9UeAlWMPOmuPu2jKNSE2FlBxHb44
         f7utQh8M4oKGMWf8huxDnyQEkzPwECZBLYV/gJZIp8RhSvX8bo5VsS2rLSjBskqkQuHo
         vPJCeXYyB1CfoVk41oIHyH5zg92vsarcHrebctOznFWGhkN9AGm5JVNb4xrXCW3Gspfi
         EdLlA8WEFqwEDFjXXZu72kCdLxZsj6Ua9MeVVZSweP5Z2nvmcTwGdb5ZQ6ulIpRD9hR5
         KsfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4hwCzEKNVVtYUcP9iGUfverr8jzUkSL0upCgG6MPSvQ=;
        b=lWVTomguLQjuR/ahHHhxJNlYMrMN5NcKqn5ZgFqNl2vgDJfxGbypI1F/nFC0EpesQl
         K+0LwvWHD6cWOHuDh8XufQ6S4Exdo6Z/gIYDzmRVAZNWKpGzkuZESxkdY8HTR16f0F5B
         7czHsYLQGm95cOWHDXCEqlgPUNDT6KbCI4qozSpkoAnQ3K9qis7z6FBoA49eA0ou/AxE
         w34NBn54qtcHnojInk4DHj09JU4d861T1nVf2NrlMEyczrR/C2PviJqC1q7daphVri4y
         RaAkm60AzbSBMVZygl91t5HIiF24xr/RF7n4v4Tqh6hazYYOKHnvPCI/aOYcKKtXZobU
         /3BA==
X-Gm-Message-State: AOAM533GPCRXSVwyF6f+WIOAIs86lx4ey2mDiv9EbIwCTCfkYtslePtw
        dhE3ypYgZ+jxg4lH6j+jyA+weuLZgbOtw8xj1cBoiTUbbWJbHA==
X-Google-Smtp-Source: ABdhPJx6GnGFVYOamM9NwlIGFzKd16QuJc4tW/BI2VPKycjlroZnGCIHPFz9GodSYI122lEP+jXDwSeq6sy0YHnOmmw=
X-Received: by 2002:a9d:6958:: with SMTP id p24mr27510298oto.17.1593078924923;
 Thu, 25 Jun 2020 02:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <202006250300.ic32FsdY%lkp@intel.com> <20200624203025.GJ9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200624203025.GJ9247@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 25 Jun 2020 11:55:13 +0200
Message-ID: <CANpmjNO5uBSZj0gHy0t+O2VhD+UjG58+zON0AFX8i7MNSO5a6Q@mail.gmail.com>
Subject: Re: [rcu:rcu/next 35/35] kernel/rcu/tree.c:251:8: error: implicit
 declaration of function 'arch_atomic_add_return'; did you mean
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, kbuild-all@lists.01.org,
        LKML <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jun 2020 at 22:30, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Thu, Jun 25, 2020 at 03:38:03AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git rcu/next
> > head:   347acb93a34a6e4f312f8b9ec1afdb86d27858d2
> > commit: 347acb93a34a6e4f312f8b9ec1afdb86d27858d2 [35/35] rcu: Fixup noinstr warnings
> > config: mips-allyesconfig (attached as .config)
> > compiler: mips-linux-gcc (GCC) 9.3.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout 347acb93a34a6e4f312f8b9ec1afdb86d27858d2
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=mips
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_enter':
> > >> kernel/rcu/tree.c:251:8: error: implicit declaration of function 'arch_atomic_add_return'; did you mean 'atomic_add_return'? [-Werror=implicit-function-declaration]
> >      251 |  seq = arch_atomic_add_return(RCU_DYNTICK_CTRL_CTR, &rdp->dynticks);
> >          |        ^~~~~~~~~~~~~~~~~~~~~~
> >          |        atomic_add_return
> >    kernel/rcu/tree.c: In function 'rcu_dynticks_eqs_exit':
> > >> kernel/rcu/tree.c:281:3: error: implicit declaration of function 'arch_atomic_andnot'; did you mean 'atomic_andnot'? [-Werror=implicit-function-declaration]
> >      281 |   arch_atomic_andnot(RCU_DYNTICK_CTRL_MASK, &rdp->dynticks);
> >          |   ^~~~~~~~~~~~~~~~~~
> >          |   atomic_andnot
> >    kernel/rcu/tree.c: In function 'rcu_dynticks_curr_cpu_in_eqs':
> > >> kernel/rcu/tree.c:314:11: error: implicit declaration of function 'arch_atomic_read'; did you mean 'atomic_read'? [-Werror=implicit-function-declaration]
> >      314 |  return !(arch_atomic_read(&rdp->dynticks) & RCU_DYNTICK_CTRL_CTR);
> >          |           ^~~~~~~~~~~~~~~~
> >          |           atomic_read
> >    cc1: some warnings being treated as errors
>
> And architectures using the definitions in include/linux/atomic-fallback.h
> don't like this patch much.  MIPS defines everything in terms of
> atomic_add_return_relaxed(), for which it provides inline assembly for
> SMP-capable builds and a C-language code sequence otherwise.
>
> One way of handling this is as follows:
>
> ------------------------------------------------------------------------
>
> diff --git a/include/linux/atomic-fallback.h b/include/linux/atomic-fallback.h
> index 2c4927b..b7935857 100644
> --- a/include/linux/atomic-fallback.h
> +++ b/include/linux/atomic-fallback.h
> @@ -133,6 +133,7 @@ atomic_add_return(int i, atomic_t *v)
>         return ret;
>  }
>  #define atomic_add_return atomic_add_return
> +#define arch_atomic_add_return atomic_add_return
>  #endif
>
>  #endif /* atomic_add_return_relaxed */
>
> ------------------------------------------------------------------------
>
> And of course similar for arch_atomic_andnot() and arch_atomic_read().
>
> Another way would be to define a noinstr_atomic_add_return() that
> was defined something like this:
>
> ------------------------------------------------------------------------
>
> #ifdef CONFIG_HAVE_ARCH_KCSAN
> # define noinstr_atomic_add_return arch_atomic_add_return
> #else
> # define noinstr_atomic_add_return atomic_add_return
> #endif

noinstr also needs to apply to KASAN & co, so this won't quite work.
Every architecture that defines arch_atomic_* has #define ARCH_ATOMIC,
so that could be used instead.

> ------------------------------------------------------------------------
>
> And again similarly for the others.
>
> Left to myself, I would take the second option just because it provably
> leaves unaltered anything that isn't using the new API.  That said,
> there has to be a better Kconfig option to key this off of.
>
> Thoughts?

I think 'arch_atomic_*' is already the noinstr variant, and your first
suggestion of adding arch-defines to atomic-fallback.h seems cleaner,
as it avoids introducing new interfaces. But that also depends on if
it's a one-off, only for RCU, or if the use of 'arch_atomic'
proliferates outside of arch/. My guess is that, unfortunately, other
places will want 'arch_atomic' as well eventually.

Thanks,
-- Marco
