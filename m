Return-Path: <SRS0=ne2O=7T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37159C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 23:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2213206A2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Jun 2020 23:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LQY+qCqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbgFFXPe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Jun 2020 19:15:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbgFFXPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Jun 2020 19:15:33 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AE5AC03E96A
        for <linux-kernel@vger.kernel.org>; Sat,  6 Jun 2020 16:15:32 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id p20so14530921iop.11
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jun 2020 16:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8JwwA28kFEr2K+hwz3o2CYavppFRtw92oMBlKZ9y8AI=;
        b=LQY+qCqgDdWGF48D01HaAcNl+szEzhD/WznXKmRktd/679xIRT9UKnJitNpkdGCLoz
         +SHPCuoI4znTJVjEbaF5vDqzr2Nfre8/nWn/SJOT9dBCTLJHp6kCLLPQ2I4ldwvW6rem
         LbxR0EYHErz9/9OvgMaB+4lvUMpPO3AUL47U0cwH+eMzqRkq15/V69bTZpL4dutoB570
         vbc8zBe4gnSE6hx5UwncoZvIXlo+QGxDvEcSu5M1g9/5i9V8GSgb94QhV8RA/gMfd36W
         FhhNnGiPfWioSbqKRYkcL7Sakj88AmyMCMBFDh8K1TmWyVXnbV2XjME3YunH2+8zLvzH
         blKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8JwwA28kFEr2K+hwz3o2CYavppFRtw92oMBlKZ9y8AI=;
        b=PCSnQoCYoSnzCff8wd+YeTUEyPg85xCKf+w7eSim1kVTrSA7s/9dngN8I6siOdy5Gi
         E2pxUqQkHXKghGKAzz2Cdkwaw4JK2EHYKQKLpBlSfqgnONhci+imo32QvXqPguUn3nPJ
         UHlr/P4dKmiKjTvdKfN7526yMYSTgYTZv8CTYo1bNFveeBkJO9RM1P/rarlPs/btjGNM
         ATTIhEZicYQQ+J4fVPLKTvBWXN/02YbJGtmDFaCrd31GbW+uedxCSJodAZNAZr9JUjKw
         GVKK/A2fmffK79lduuvrVg0ovUgbCHnAalo5664jSSqi2L7Z3Psyx4QRy+Vj5aQ5giZM
         QY4A==
X-Gm-Message-State: AOAM530+TppCYSed3ScQyFUtbCNsqlBVPTWrremsrbBUByU6x3wm2C68
        MJgB8M5QBbZ6lIdvNvceBwN1Jw8Czz8x8aCzvHA=
X-Google-Smtp-Source: ABdhPJywFdNHAguqbB6g0aoIh8Y5HlKBy217pJd6EYkPSv5G9eGrwEL6bWP7XkCzdMuMsHLCtVUhY5FIzdYmS+ihntw=
X-Received: by 2002:a02:390b:: with SMTP id l11mr15291247jaa.54.1591485331321;
 Sat, 06 Jun 2020 16:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <042eddd4b87f0db3588a79d829afe6b23fa8365c.1590017578.git.syednwaris@gmail.com>
 <202005310310.EOelU2v3%lkp@intel.com> <CACG_h5oHmkAp68q0EFXZEWhG15EQSHLgx=78gZ72aLShZOztFA@mail.gmail.com>
 <20200605122428.GD2428291@smile.fi.intel.com>
In-Reply-To: <20200605122428.GD2428291@smile.fi.intel.com>
From:   Syed Nayyar Waris <syednwaris@gmail.com>
Date:   Sun, 7 Jun 2020 04:45:19 +0530
Message-ID: <CACG_h5pHC1gQ62zAatUvgHakuGO6P-OLEwMHoU4_ObNDufXFqA@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] lib/test_bitmap.c: Add for_each_set_clump test cases
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kbuild-all@lists.01.org,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 5:54 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Jun 05, 2020 at 02:12:54AM +0530, Syed Nayyar Waris wrote:
> > On Sun, May 31, 2020 at 12:50 AM kbuild test robot <lkp@intel.com> wrote:
>
> > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xe80): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp1
> > > The variable clump_test_data references
> > > the variable __initconst clump_exp1
> > > If the reference is valid then annotate the
> > > variable with or __refdata (see linux/init.h) or name the variable:
> > >
> > > --
> > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xec8): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp2
> > > The variable clump_test_data references
> > > the variable __initconst clump_exp2
> > > If the reference is valid then annotate the
> > > variable with or __refdata (see linux/init.h) or name the variable:
> > >
> > > --
> > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xf10): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp3
> > > The variable clump_test_data references
> > > the variable __initconst clump_exp3
> > > If the reference is valid then annotate the
> > > variable with or __refdata (see linux/init.h) or name the variable:
> > >
> > > --
> > > >> WARNING: modpost: lib/test_bitmap.o(.data+0xf58): Section mismatch in reference from the variable clump_test_data to the variable .init.rodata:clump_exp4
> > > The variable clump_test_data references
> > > the variable __initconst clump_exp4
> > > If the reference is valid then annotate the
> > > variable with or __refdata (see linux/init.h) or name the variable:
>
> > I am unable to reproduce the compilation warning.
>
> You have to enable section mismatch checker.
>
> > I ran the command:
> > make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'  lib/
> >
> > But the compilation warning didn't show up. Can anyone please point to me
> > what I am doing wrong here? How shall I reproduce the warning? Thanks !
>
> You put some data into init section of the object, while you are trying to
> access it from non-init one. It's easy-to-fix issue.
>
> --
> With Best Regards,
> Andy Shevchenko

Thanks! I have made code changes for the above warning. Actually I am
still unable to reproduce the compilation warning. But I believe the
following code fix will fix the compilation warning:

In file lib/test_bitmap.c

@@ -692,7 +692,7 @@ struct clump_test_data_params {
        unsigned long const *exp;
 };

-struct clump_test_data_params clump_test_data[] =
+static struct clump_test_data_params clump_test_data[] __initdata =
                                        { {{0}, 2, 0, 64, 8, clump_exp1},
                                        {{0}, 8, 2, 240, 24, clump_exp2},
                                        {{0}, 8, 10, 240, 30, clump_exp3},



Let me know if I should submit a new patchset (v8) for
'for_each_set_clump' including above code fix.

Just to share how I attempted to reproduce the warning (but unsuccessful):

Step 1: Use the config file in attachment. Download, extract, rename
file to .config at the root of the tree.
Step 2: '$ make lib/'
No warning reproduced after above step 2.
Step 3: '$ make W=1 C=1 ARCH=x86_64 CF='-fdiagnostic-prefix
-D__CHECK_ENDIAN__' lib/'
After step 3 I got error in build:
scripts/kconfig/conf  --syncconfig Kconfig
  CHECK   scripts/mod/empty.c
No such file: asan-globals=1
scripts/Makefile.build:266: recipe for target 'scripts/mod/empty.o' failed
make[1]: *** [scripts/mod/empty.o] Error 1
Makefile:1147: recipe for target 'prepare0' failed
make: *** [prepare0] Error 2

The command in above step 3 was mentioned in the bot mail.

Regards
Syed Nayyar Waris
