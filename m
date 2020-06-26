Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17190C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE7B620773
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 15:21:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y/biJ5zR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729475AbgFZPVE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 11:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFZPVD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 11:21:03 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25227C03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:21:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u185so2749087pfu.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 08:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=W43mPve1K1gecItiKfJ5kp3y0K64xEFGn1/0oe3m2A0=;
        b=Y/biJ5zRJLKjtaCxmUuQIFAfdTuoyUR6C9crenAiB8bgr3xcyFbAE1UfpTnKvvqOck
         0Z5BQvjGcNgv9SDcThrahKUxunQmKEqexcKXSp51S7oCTvQ8UsqFJWnMyLowvEewYqG2
         TbxyC7R14trZYvKBFS/g++xVREkyW5wEdiK4Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=W43mPve1K1gecItiKfJ5kp3y0K64xEFGn1/0oe3m2A0=;
        b=j3y6RoBJiM1+gD0D9IIVr6cUAOC/hMA80NovYOEStkQ5JuEeZI/+CwcmA9efD3OAxk
         9ggn8vTF92d8AjLG8n1JYeEaROqqtSdeOpNjBqzBdSOCdYgg7XRLEShOzO2bUj3FTFLp
         H2CiNqleQve6Et3cx49to24YtdZV/HVneTdXG0Whg9lGF2O3ABmrh8ej3JGaAN43y9En
         ldP8Asx/WDUG25AHn5mL4KXuhryW63PEKZgPHdGobJ0a+nGX48EZoxgH086bIVPheWkS
         1mAQpaeAowVK50ru/Da6ONs5y7EbZ/mrTUqVckrjeaKaXtsDrNZXaCZidiDnWJdo+pun
         8+PQ==
X-Gm-Message-State: AOAM532od9trfiKiEoRb9kIduOb3aXx8skjEfigR8JiYsl8KaeO2eIGw
        kO12pzqhagbr5Q2eOxUhGhvsNA==
X-Google-Smtp-Source: ABdhPJyaAo/gRdwYJkkzveaMBXTdLm+06FbadeCuW1eS2WfwpnqRLb/QtItwCB6MelWrvMPpZxMV2g==
X-Received: by 2002:a63:1f11:: with SMTP id f17mr3090183pgf.217.1593184862710;
        Fri, 26 Jun 2020 08:21:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i63sm11489726pfc.22.2020.06.26.08.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2020 08:21:01 -0700 (PDT)
Date:   Fri, 26 Jun 2020 08:21:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        mm-commits@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch 10/32] linux/bits.h: fix unsigned less than zero warnings
Message-ID: <202006260817.25D0459@keescook>
References: <20200625202807.b630829d6fa55388148bee7d@linux-foundation.org>
 <20200626032946._LJ_E6G66%akpm@linux-foundation.org>
 <CAHk-=wiZrhVUq3N17=GVzMQNQUKi65x=-djTM2A+fz8UdQxgEg@mail.gmail.com>
 <CADRDgG6SXwngT5gS2EY1Y0xnPdYth-FicQyTnPyqiwpmw52eQg@mail.gmail.com>
 <CAHp75Ve2x9dEqaHSue5UAftsJw+U3n8K9YEXBy5QFGJHgkQ3DA@mail.gmail.com>
 <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com>
 <CAHp75Vfr8sFydbH=G7U+wXoUftT9RnsfSSLi4RXNyR-3sApR3w@mail.gmail.com>
 <CAK8P3a2bCyO6xV+tCynjVXpgH-wkQ7=N5pfa8oax9BKWL+a7ig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2bCyO6xV+tCynjVXpgH-wkQ7=N5pfa8oax9BKWL+a7ig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 04:43:36PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 26, 2020 at 4:09 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Fri, Jun 26, 2020 at 5:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > It would work for me if it had been
> > a) documented (I didn't check if it had been already done, though);
> > b) understood by all CIs in the same way (see a) as well :-).
> 
> I checked the 'make help' output, which describes them as
> 
> make W=n   [targets] Enable extra build checks, n=1,2,3 where
>    1: warnings which may be relevant and do not occur too often
>    2: warnings which occur quite often but may still be relevant
>    3: more obscure warnings, can most likely be ignored
>    Multiple levels can be combined with W=12 or W=123
> 
> which is less specific than the interpretation I had in mind but
> I think still fits a).

How about tweaking this as:

make W=n   [targets] Enable extra build checks, n=1,2,3 where
   1: warnings which may be relevant and do not occur too often
      and can normally be fixed in code. (Reasonable for CIs to
      use without generating too much spam.)
   2: warnings which occur quite often but may still be relevant
      to developers looking for ways to improve compilers or
      looking for very special cases. (Not usually a good idea
      for automated systems.)
   3: more obscure warnings, can most likely be ignored but have
      value to some very narrow areas of code/compiler analysis.
      Very noisy!



-- 
Kees Cook
