Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 061CBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D263E20737
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 03:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNgWJODn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgFJDXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 23:23:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgFJDXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 23:23:36 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F6FC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 20:23:35 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id i16so697607qtr.7
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 20:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HK9ir5YqLJV5ZUuAryCYskq/ln3yZyDIMSHc1NLebXg=;
        b=mNgWJODnGAFOJr8jjBzMg/pgjvwUpSTYa8yWWLmwL2RF6xCJyqVM38dwoYwwBXtybT
         xlexCTs6kvb0Y1mBI3o+EY9N1BIn4kdPIQJ80DAhUO6JYcBvNAwsRKDucMPoiy7V8G6F
         z+Yb7/i696nor9y1Hfw5V5t1KLoBSvn12Y43vWyNcUnVtO6l7nYkS7z0gtttaEreeEc0
         nd7b2a7QSsS0TaoYoYtC7Nva+gh52slD5wHVfCweLI72wYh70SPZnWAB6JWtrIrxds9D
         OZVzhmJ62/BemwfzC5G1J36B7OSWAF0FlbYbjaGrYscQPgwIjQG7TIlJzsAq9VI0SKGB
         qaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=HK9ir5YqLJV5ZUuAryCYskq/ln3yZyDIMSHc1NLebXg=;
        b=gIruLtRK1d3O/H14ETOfUelbADM44Sqi7xnsLb0yfjUWgrcw8XaorkKKE4JDfayzMo
         83mLffyAEaruJmfQsgNVQ2JzDOz2yMi2rZAIgkdcR1ulQ25eomlqpE3307TNjPQ9DJOP
         cUkeByVPUghQtYEwKLAeTift7tGNWvG1nx+tR1xKvliVThaLseVfGbQYQoOS6S0w7wgt
         cGI1SVamIbqj9dW5fHKNBHpG9adwjy7szAIJD2n3fgCTp258bdZoMoqhAayGMxmCgDUz
         gy2WAQ17LGbVYR+DJLtJ+Kke2+vrM+cl7CcPplbNQXh2zo2FGWgX20RGgMbFC3URLGaV
         YC6Q==
X-Gm-Message-State: AOAM532/M7TUX3yCSpPRKDLNbguc19doHwNffb96mRVt9+gak14UBI6C
        UPlTWpB04Pl9SsKV5FwqCMA=
X-Google-Smtp-Source: ABdhPJwAj5/Q0jNneQ0SG5B0LH6i0xFDcolUf/4TPeBL7yAavSO18ECr9nvS7d87d3Ga0Cv/mYqUzw==
X-Received: by 2002:ac8:f47:: with SMTP id l7mr1137460qtk.292.1591759414495;
        Tue, 09 Jun 2020 20:23:34 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id w3sm11717431qkb.85.2020.06.09.20.23.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 20:23:33 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 9 Jun 2020 23:23:31 -0400
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Rong Chen <rong.a.chen@intel.com>,
        Fangrui Song <maskray@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        kernel test robot <lkp@intel.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        kbuild-all@lists.01.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [kbuild-all] Re: gcc-5: error: -gz is not supported in this
 configuration
Message-ID: <20200610032331.GA1928844@rani.riverdale.lan>
References: <202006092115.nevT7m8D%lkp@intel.com>
 <CAKwvOd=jjFS7XOWyYMZgLTYJtZ7uc=4dP-S4VhuyjNmT=2EcPw@mail.gmail.com>
 <20200609174954.cckelwl6etwztmhv@google.com>
 <05c88916-7d91-ad1a-1ea6-15167a994a0b@intel.com>
 <20200610005830.s6gus7r3umwgzozk@google.com>
 <c2c2c2db-439f-5c60-068d-e53adbe960c1@intel.com>
 <20200610031225.GA1917869@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200610031225.GA1917869@rani.riverdale.lan>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 11:12:25PM -0400, Arvind Sankar wrote:
> On Wed, Jun 10, 2020 at 09:49:01AM +0800, Rong Chen wrote:
> > 
> > 
> > On 6/10/20 8:58 AM, Fangrui Song wrote:
> > > On 2020-06-10, Rong Chen wrote:
> > >>
> > >>
> > >> On 6/10/20 1:49 AM, Fangrui Song wrote:
> > >>> On 2020-06-09, Nick Desaulniers wrote:
> > >>>> On Tue, Jun 9, 2020 at 6:12 AM kernel test robot <lkp@intel.com> 
> > >>>> wrote:
> > >>>>>
> > >>>>> tree: 
> > >>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 
> > >>>>> master
> > >>>>> head:   abfbb29297c27e3f101f348dc9e467b0fe70f919
> > >>>>> commit: 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace Makefile: support 
> > >>>>> compressed debug info
> > >>>>> date:   12 days ago
> > >>>>> config: x86_64-randconfig-r032-20200609 (attached as .config)
> > >>>>> compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
> > >>>>> reproduce (this is a W=1 build):
> > >>>>>         git checkout 10e68b02c861ccf2b3adb59d3f0c10dc6b5e3ace
> > >>>>>         # save the attached .config to linux build tree
> > >>>>>         make W=1 ARCH=x86_64
> > >>>>>
> > >>>>> If you fix the issue, kindly add following tag as appropriate
> > >>>>> Reported-by: kernel test robot <lkp@intel.com>
> > >>>>>
> > >>>>> All errors (new ones prefixed by >>, old ones prefixed by <<):
> > >>>>>
> > >>>>>>> gcc-5: error: -gz is not supported in this configuration
> > >>>>
> > >>>> Hmm...I wonder if the feature detection is incomplete?  I suspect it's
> > >>>> possible to not depend on zlib.
> > >>>>
> > >>>>> make[2]: *** [scripts/Makefile.build:277: scripts/mod/empty.o] 
> > >>>>> Error 1
> > >>>>> make[2]: Target '__build' not remade because of errors.
> > >>>>> make[1]: *** [Makefile:1169: prepare0] Error 2
> > >>>>> make[1]: Target 'prepare' not remade because of errors.
> > >>>>> make: *** [Makefile:185: __sub-make] Error 2
> > >>>
> > >>> The output of gcc-5 -v --version on that machine may help. The
> > >>> convoluted gcc_cv_ld_compress_de logic in gcc/configure.ac may be
> > >>> related, but I can't find any mistake that our
> > >>> CONFIG_DEBUG_INFO_COMPRESSED conditions may make.
> > >>
> 
> The output of gcc-5 -dumpspecs may also be useful.
> 
> The exact Kconfig check should have been
> 	gcc-5 -Werror -gz=zlib -S -x c /dev/null -o /dev/null
> 
> I can't see how that would succeed if the a.c test didn't but maybe just
> in case?

Oh wait, -S instead of -c. Which means it runs neither the assembler nor
the linker, so gcc won't error out. But if that gcc was originally
_configured_ with a version of binutils that doesn't support -gz=zlib,
it will give an error on -c regardless of whether the runtime binutils
would actually support it or not.
