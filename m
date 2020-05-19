Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F0B0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:12:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E6E62075F
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 22:12:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeRPaTJ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgESWMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 18:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgESWMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 18:12:37 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434D9C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:12:37 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id n15so562124pfd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 15:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=N4XH541U7UQQpdWsqc6VDr4j78oUO2KTxdnSbF6otX8=;
        b=aeRPaTJ0pWOqy7B9rQlT9Ytvk3L7vQ0tnHXGiI/lZNt/BP9gtOg9vChChdy3fBssJI
         Fwp+ofBzsTZ1epC6CPeK5f7xxG7enltUCpuDA+0JCgt0kUsYpaw62fuGlr55Eq94KKEU
         zdpH2JWPHkIia9Oftg7UjNFfHKgEY7fBJQJGtthGCIb/KHZZxlgOYsljUMbMg3amM6D0
         zevdwyFuk1A+LJcEc7+7dyNNYzMYmRVKxwjAiEsGClRm8XN5giR37BIb6wmmmUzBLFdn
         YpNBHgifYQT79jQ9zYdoJmhtQ2aj5n/UjUInRPOizfqaDxXjTL1g+Nv0Hd9VnK4lofd2
         V33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=N4XH541U7UQQpdWsqc6VDr4j78oUO2KTxdnSbF6otX8=;
        b=S7FPrT5YNDtvqJJv3XwyFHPeDE5OxClvIv3hjDXITirGBB7d8JHlwF1ATn4e+izror
         IQ722rvrutJnPH0vGM+FkwTKPEwOeo3cYS/SXEP9DKDrXAEH5c+7CUjZ1YZp2tjD16Ps
         fx52czZAuwHaXaBcbOOW8KQiwDi3mk7T/le7iHNTxpKfugEpjqPdTjKrdyVUsTM4RFQs
         Zag4iyKZ9RnxWORcOnjHo62yBW8AzI5WzUlHwjlhBjtno2ZyEiNyNr5PnyaCQ+uSAyjx
         mmp01aBNaKricW0x9yE7RWupNRbbtLjP55Zpjmo5bJUfUaiQQEUr7U7St2k9gAVY7tg6
         b/dw==
X-Gm-Message-State: AOAM533+kcF84sOmvpsnBo0t0LgZa99DWR2sQRVZPFXZNp5AM0Saex3V
        9mzFpDEj2MmEWUbBKROEwhhnYmmnSQHYGqYb+Fa4pg==
X-Google-Smtp-Source: ABdhPJwFafNy0ByJNK8kOBKMqVM+tJnjfKsrHY0o5MD7vQl1T98o7jN0rNQLD4sRZFm6TMQN+t1LPdTh05UH7cfnPfs=
X-Received: by 2002:a63:d010:: with SMTP id z16mr1134483pgf.381.1589926356402;
 Tue, 19 May 2020 15:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <202005200123.gFjGzJEH%lkp@intel.com> <20200519205505.GD444@zn.tnic>
 <20200519212541.GA3580016@ubuntu-s3-xlarge-x86>
In-Reply-To: <20200519212541.GA3580016@ubuntu-s3-xlarge-x86>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 May 2020 15:12:24 -0700
Message-ID: <CAKwvOdk+JwddxLaXc9S7SMMTye8bDaGEckcs7zu5tEMD0G3Yog@mail.gmail.com>
Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Philip Li <philip.li@intel.com>
Cc:     Borislav Petkov <bp@alien8.de>, kbuild test robot <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Masahiro and Philip,
We're seeing a bunch of -Wmissing-prototypes warnings from 0day bot
suddenly today.  Did something change on the Kbuild or 0day bot side?

On Tue, May 19, 2020 at 2:25 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Tue, May 19, 2020 at 10:55:05PM +0200, Borislav Petkov wrote:
> > On Wed, May 20, 2020 at 01:51:25AM +0800, kbuild test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x=
86/mm
> > > head:   bd1de2a7aace4d1d312fb1be264b8fafdb706208
> > > commit: 1f6f655e01adebf5bd5e6c3da2e843c104ded051 [1/23] x86/mm: Add a=
 x86_has_pat_wp() helper
> > > config: x86_64-randconfig-r012-20200519 (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project =
135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master=
/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install x86_64 cross compiling tool for clang build
> > >         # apt-get install binutils-x86-64-linux-gnu
> > >         git checkout 1f6f655e01adebf5bd5e6c3da2e843c104ded051
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang make.cros=
s ARCH=3Dx86_64
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > > >> arch/x86/mm/init.c:75:6: warning: no previous prototype for functi=
on 'x86_has_pat_wp' [-Wmissing-prototypes]
> > > bool x86_has_pat_wp(void)
> > > ^
> >
> > Triggers with gcc too:
> >
> > make W=3D1 arch/x86/mm/init.o
> >
> > ...
> >
> > arch/x86/mm/init.c:81:6: warning: no previous prototype for =E2=80=98x8=
6_has_pat_wp=E2=80=99 [-Wmissing-prototypes]
> >    81 | bool x86_has_pat_wp(void)
> >       |      ^~~~~~~~~~~~~~
> >
> >
> > -Wmissing-prototypes is default off, though, dunno why clang 11 has it
> > on.
>
> It doesn't: https://godbolt.org/z/rU5_5H
>
> I assume this is caused by some sort of internal change to the 0day
> infrastructure (testing W=3D1?)
>
> I cannot see this without adding W=3D1 to make at the listed commit with
> the provided config.
>
> Cheers,
> Nathan
>
> > Anyway, something for Benni to fix. CCed and leaving the rest for him a=
s
> > reference.
> >
> > > arch/x86/mm/init.c:75:1: note: declare 'static' if the function is no=
t intended to be used outside of this translation unit
> > > bool x86_has_pat_wp(void)
> > > ^
> > > static
> > > arch/x86/mm/init.c:866:13: warning: no previous prototype for functio=
n 'mem_encrypt_free_decrypted_mem' [-Wmissing-prototypes]
> > > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > > ^
> > > arch/x86/mm/init.c:866:1: note: declare 'static' if the function is n=
ot intended to be used outside of this translation unit
> > > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > > ^
> > > static
> > > 2 warnings generated.
> > >
> > > vim +/x86_has_pat_wp +75 arch/x86/mm/init.c
> > >
> > >     73
> > >     74      /* Check that the write-protect PAT entry is set for writ=
e-protect */
> > >   > 75      bool x86_has_pat_wp(void)
> > >     76      {
> > >     77              return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] =
=3D=3D _PAGE_CACHE_MODE_WP;
> > >     78      }
> > >     79
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> >
> >
> > --
> > Regards/Gruss,
> >     Boris.
> >
> > https://people.kernel.org/tglx/notes-about-netiquette
> >
>
> --
> You received this message because you are subscribed to the Google Groups=
 "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/clang-built-linux/20200519212541.GA3580016%40ubuntu-s3-xlarge-x86.



--=20
Thanks,
~Nick Desaulniers
