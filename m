Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFEFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5291120708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D6Rs2jxx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgETA0c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726178AbgETA0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:26:32 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC161C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:26:30 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l73so1704632pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PcTvrq/9OvFVVXtSSqrU+vrsIEd2UIjFZopOje8k1ZI=;
        b=D6Rs2jxxy9aew4qUIfw7KSr6JxPR6jhqayGsoWBlup9XaA/10R3jtep/QYqYt+cbxa
         wwDLCOUtcZRHXOZ4cC2dVtiP1clAGM9ok1BZLhEj+sXZQA3/D9lTAKs7tlOv+7/IaVU7
         67i93+xi0+V1Xfn8sRc7CUFNWnCl5qiXTKcPebbyWqibqX9iuJdaJB8MDufYgxZH323G
         IvhbvM5Z9U5z/+yEVVQe1JrKg+Wyf1zQh7lvejuxVS8yIbMNk8aRdU7OBZv+5N5NJ/xH
         SREogvMJLoiy5us5H8ZpRaohVf0A7x6UQSbwdyk5se2UI9Ly62jbzHDPs2VzrrGCdHIp
         4ijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PcTvrq/9OvFVVXtSSqrU+vrsIEd2UIjFZopOje8k1ZI=;
        b=jAPJwK3W9b4jklNbYl1k2M1KjHTvkpUfNT+rrH6BMjXYnTiY3u5IWKGs14FrbUyvuv
         6NDGPi6Y6ZJ47C/YsWpe4xd/O3FgzLq5B/wbBHftVsRM6nXdc8Z+6B75AQx+v97dZ67B
         +Wr+JHPH7WsJ2jrFGJl1cDRuxqWs88dg8mDLnjUr7K1O0XVI/gUBUl+P+hoZCV3nIa+X
         5yaKzV76NBBZC2J97kwU8AlYsvJn/1rHHW0mD3gzqFLsYfiJ7/VUeyvGvuMxVEReoBqR
         MUpNG0ZLpdneXjuJI+jtGUiO2ODI8YPl/uwsbnn9XxeIv8DO7FCfPETkwgjXVcKtRj2e
         dGww==
X-Gm-Message-State: AOAM532WyZRUjTfuXXS0rdhC4+y5gAKrP8cFMpHPFu4u/tdXXHjBGJ9J
        /avZ8arwZzkzl6EMltYIHzvP9mh9MPdDZywNDDUA8A==
X-Google-Smtp-Source: ABdhPJzaA5MzhuhYBQt3c5HTYLEBUDr+w1kRKzJBnfNaJcZpbp2MAMgC42MG8vvK2qyIEuWO3dsayHt/D1Ckbx4NXis=
X-Received: by 2002:a17:902:341:: with SMTP id 59mr1857733pld.119.1589934389684;
 Tue, 19 May 2020 17:26:29 -0700 (PDT)
MIME-Version: 1.0
References: <202005200123.gFjGzJEH%lkp@intel.com> <20200519205505.GD444@zn.tnic>
 <20200519212541.GA3580016@ubuntu-s3-xlarge-x86> <CAKwvOdk+JwddxLaXc9S7SMMTye8bDaGEckcs7zu5tEMD0G3Yog@mail.gmail.com>
 <831EE4E5E37DCC428EB295A351E6624952648ACF@shsmsx102.ccr.corp.intel.com>
In-Reply-To: <831EE4E5E37DCC428EB295A351E6624952648ACF@shsmsx102.ccr.corp.intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 May 2020 17:26:18 -0700
Message-ID: <CAKwvOdmoA5ZFCiUQ5fVf7+970Y4bxvU=kYWb49NENQzxdm7F1Q@mail.gmail.com>
Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
To:     "Li, Philip" <philip.li@intel.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>, lkp <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
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

On Tue, May 19, 2020 at 4:49 PM Li, Philip <philip.li@intel.com> wrote:
>
> > Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no pre=
vious
> > prototype for function 'x86_has_pat_wp'
> >
> > Masahiro and Philip,
> > We're seeing a bunch of -Wmissing-prototypes warnings from 0day bot
> > suddenly today.  Did something change on the Kbuild or 0day bot side?
> Hi Nick, W=3D1 was added to make. This leads to extra warnings.

Ah, ok.  Good to know the change is in 0day bot which rules out
changes to Kbuild and Clang.

It might be helpful to note in the email that this is a W=3D1 build,
since it's non obvious and cannot be set via config.

Generally, the kernel is not W=3D1 clean.  I realize that 0day bot can
filter old vs new.  Why -Wmissing-prototypes is a problem is that:
1. there are already many instances of it throughout the kernel;
references without forward declarations or correct includes.
2. it's easy for someone to call a function like code that already
exists in the translation unit they're touching.

So by adding another implicit call, they get warned for the whole
file.  Generally, the fix is trivial; just include the correct header.
If that leads to tangly-sphagetti-limbo/circular includes, then raw
forward declarations can be used (though it's easy for those to get
out of sync, which can lead to spooky bugs).

I think having in the top of the warning that this is a W=3D1 build will
make it more obvious.

I get that -Wmissing-prototypes can be noisy, but it's trivial to fix.
I do worry what other warnings lurk in W=3D1 though...

>
> >
> > On Tue, May 19, 2020 at 2:25 PM Nathan Chancellor
> > <natechancellor@gmail.com> wrote:
> > >
> > > On Tue, May 19, 2020 at 10:55:05PM +0200, Borislav Petkov wrote:
> > > > On Wed, May 20, 2020 at 01:51:25AM +0800, kbuild test robot wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.g=
it x86/mm
> > > > > head:   bd1de2a7aace4d1d312fb1be264b8fafdb706208
> > > > > commit: 1f6f655e01adebf5bd5e6c3da2e843c104ded051 [1/23] x86/mm: A=
dd
> > a x86_has_pat_wp() helper
> > > > > config: x86_64-randconfig-r012-20200519 (attached as .config)
> > > > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-proj=
ect
> > 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> > > > > reproduce:
> > > > >         wget https://raw.githubusercontent.com/intel/lkp-
> > tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > >         chmod +x ~/bin/make.cross
> > > > >         # install x86_64 cross compiling tool for clang build
> > > > >         # apt-get install binutils-x86-64-linux-gnu
> > > > >         git checkout 1f6f655e01adebf5bd5e6c3da2e843c104ded051
> > > > >         # save the attached .config to linux build tree
> > > > >         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dclang
> > make.cross ARCH=3Dx86_64
> > > > >
> > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > >
> > > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > > >
> > > > > >> arch/x86/mm/init.c:75:6: warning: no previous prototype for fu=
nction
> > 'x86_has_pat_wp' [-Wmissing-prototypes]
> > > > > bool x86_has_pat_wp(void)
> > > > > ^
> > > >
> > > > Triggers with gcc too:
> > > >
> > > > make W=3D1 arch/x86/mm/init.o
> > > >
> > > > ...
> > > >
> > > > arch/x86/mm/init.c:81:6: warning: no previous prototype for =E2=80=
=98x86_has_pat_wp=E2=80=99
> > [-Wmissing-prototypes]
> > > >    81 | bool x86_has_pat_wp(void)
> > > >       |      ^~~~~~~~~~~~~~
> > > >
> > > >
> > > > -Wmissing-prototypes is default off, though, dunno why clang 11 has=
 it
> > > > on.
> > >
> > > It doesn't: https://godbolt.org/z/rU5_5H
> > >
> > > I assume this is caused by some sort of internal change to the 0day
> > > infrastructure (testing W=3D1?)
> > >
> > > I cannot see this without adding W=3D1 to make at the listed commit w=
ith
> > > the provided config.
> > >
> > > Cheers,
> > > Nathan
> > >
> > > > Anyway, something for Benni to fix. CCed and leaving the rest for h=
im as
> > > > reference.
> > > >
> > > > > arch/x86/mm/init.c:75:1: note: declare 'static' if the function i=
s not intended
> > to be used outside of this translation unit
> > > > > bool x86_has_pat_wp(void)
> > > > > ^
> > > > > static
> > > > > arch/x86/mm/init.c:866:13: warning: no previous prototype for fun=
ction
> > 'mem_encrypt_free_decrypted_mem' [-Wmissing-prototypes]
> > > > > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > > > > ^
> > > > > arch/x86/mm/init.c:866:1: note: declare 'static' if the function =
is not intended
> > to be used outside of this translation unit
> > > > > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > > > > ^
> > > > > static
> > > > > 2 warnings generated.
> > > > >
> > > > > vim +/x86_has_pat_wp +75 arch/x86/mm/init.c
> > > > >
> > > > >     73
> > > > >     74      /* Check that the write-protect PAT entry is set for =
write-protect */
> > > > >   > 75      bool x86_has_pat_wp(void)
> > > > >     76      {
> > > > >     77              return __pte2cachemode_tbl[_PAGE_CACHE_MODE_W=
P] =3D=3D
> > _PAGE_CACHE_MODE_WP;
> > > > >     78      }
> > > > >     79
> > > > >
> > > > > ---
> > > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > >
> > > >
> > > >
> > > > --
> > > > Regards/Gruss,
> > > >     Boris.
> > > >
> > > > https://people.kernel.org/tglx/notes-about-netiquette
> > > >
> > >
> > > --
> > > You received this message because you are subscribed to the Google Gr=
oups
> > "Clang Built Linux" group.
> > > To unsubscribe from this group and stop receiving emails from it, sen=
d an email
> > to clang-built-linux+unsubscribe@googlegroups.com.
> > > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/clang-built-
> > linux/20200519212541.GA3580016%40ubuntu-s3-xlarge-x86.
> >
> >
> >
> > --
> > Thanks,
> > ~Nick Desaulniers



--=20
Thanks,
~Nick Desaulniers
