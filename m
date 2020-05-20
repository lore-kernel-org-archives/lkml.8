Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA9BBC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:53:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FF4220829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:53:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgETAxk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:53:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:25274 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgETAxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:53:39 -0400
IronPort-SDR: JCF5/Vmu/djLMmOyVS5i9ZyqVWitC4/9DbEGYyhiAwURM0mo8rUMBwU3MlvzwZj5dI2MSl+dGY
 onFRY/SplByA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2020 17:53:39 -0700
IronPort-SDR: tVnx08PHSb6c9NwjAPiU/w/IktCBnbvOga6w7xs9suclrO7oyw5N1TDRAIUVomdAQLYA3wdn1U
 3SEIl+iuUWzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,412,1583222400"; 
   d="scan'208";a="268080225"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2020 17:53:36 -0700
Date:   Wed, 20 May 2020 08:52:18 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Borislav Petkov <bp@alien8.de>, lkp <lkp@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Benjamin Thiel <b.thiel@posteo.de>,
        Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
Message-ID: <20200520005218.GA3101@intel.com>
References: <202005200123.gFjGzJEH%lkp@intel.com>
 <20200519205505.GD444@zn.tnic>
 <20200519212541.GA3580016@ubuntu-s3-xlarge-x86>
 <CAKwvOdk+JwddxLaXc9S7SMMTye8bDaGEckcs7zu5tEMD0G3Yog@mail.gmail.com>
 <831EE4E5E37DCC428EB295A351E6624952648ACF@shsmsx102.ccr.corp.intel.com>
 <CAKwvOdmoA5ZFCiUQ5fVf7+970Y4bxvU=kYWb49NENQzxdm7F1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKwvOdmoA5ZFCiUQ5fVf7+970Y4bxvU=kYWb49NENQzxdm7F1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 05:26:18PM -0700, Nick Desaulniers wrote:
> On Tue, May 19, 2020 at 4:49 PM Li, Philip <philip.li@intel.com> wrote:
> >
> > > Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
> > > prototype for function 'x86_has_pat_wp'
> > >
> > > Masahiro and Philip,
> > > We're seeing a bunch of -Wmissing-prototypes warnings from 0day bot
> > > suddenly today.  Did something change on the Kbuild or 0day bot side?
> > Hi Nick, W=1 was added to make. This leads to extra warnings.
> 
> Ah, ok.  Good to know the change is in 0day bot which rules out
> changes to Kbuild and Clang.
> 
> It might be helpful to note in the email that this is a W=1 build,
> since it's non obvious and cannot be set via config.
thanks for reminding this, we will update the report info to reflect
this, e.g. part of reproduce step.

> 
> Generally, the kernel is not W=1 clean.  I realize that 0day bot can
got it, we have logic to limit that not to report too old error, so
the idea is to scan recent submitted patches.

> filter old vs new.  Why -Wmissing-prototypes is a problem is that:
> 1. there are already many instances of it throughout the kernel;
> references without forward declarations or correct includes.
> 2. it's easy for someone to call a function like code that already
> exists in the translation unit they're touching.
> 
> So by adding another implicit call, they get warned for the whole
> file.  Generally, the fix is trivial; just include the correct header.
> If that leads to tangly-sphagetti-limbo/circular includes, then raw
> forward declarations can be used (though it's easy for those to get
> out of sync, which can lead to spooky bugs).
> 
> I think having in the top of the warning that this is a W=1 build will
> make it more obvious.
> 
> I get that -Wmissing-prototypes can be noisy, but it's trivial to fix.
> I do worry what other warnings lurk in W=1 though...
with some monitoring, so far, issue like unused-but-set-variable is quite
helpful. We will keep monitor for other issues and feedbacks.

> 
> >
> > >
> > > On Tue, May 19, 2020 at 2:25 PM Nathan Chancellor
> > > <natechancellor@gmail.com> wrote:
> > > >
> > > > On Tue, May 19, 2020 at 10:55:05PM +0200, Borislav Petkov wrote:
> > > > > On Wed, May 20, 2020 at 01:51:25AM +0800, kbuild test robot wrote:
> > > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
> > > > > > head:   bd1de2a7aace4d1d312fb1be264b8fafdb706208
> > > > > > commit: 1f6f655e01adebf5bd5e6c3da2e843c104ded051 [1/23] x86/mm: Add
> > > a x86_has_pat_wp() helper
> > > > > > config: x86_64-randconfig-r012-20200519 (attached as .config)
> > > > > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project
> > > 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> > > > > > reproduce:
> > > > > >         wget https://raw.githubusercontent.com/intel/lkp-
> > > tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > > >         chmod +x ~/bin/make.cross
> > > > > >         # install x86_64 cross compiling tool for clang build
> > > > > >         # apt-get install binutils-x86-64-linux-gnu
> > > > > >         git checkout 1f6f655e01adebf5bd5e6c3da2e843c104ded051
> > > > > >         # save the attached .config to linux build tree
> > > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang
> > > make.cross ARCH=x86_64
> > > > > >
> > > > > > If you fix the issue, kindly add following tag as appropriate
> > > > > > Reported-by: kbuild test robot <lkp@intel.com>
> > > > > >
> > > > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > > > >
> > > > > > >> arch/x86/mm/init.c:75:6: warning: no previous prototype for function
> > > 'x86_has_pat_wp' [-Wmissing-prototypes]
> > > > > > bool x86_has_pat_wp(void)
> > > > > > ^
> > > > >
> > > > > Triggers with gcc too:
> > > > >
> > > > > make W=1 arch/x86/mm/init.o
> > > > >
> > > > > ...
> > > > >
> > > > > arch/x86/mm/init.c:81:6: warning: no previous prototype for ‘x86_has_pat_wp’
> > > [-Wmissing-prototypes]
> > > > >    81 | bool x86_has_pat_wp(void)
> > > > >       |      ^~~~~~~~~~~~~~
> > > > >
> > > > >
> > > > > -Wmissing-prototypes is default off, though, dunno why clang 11 has it
> > > > > on.
> > > >
> > > > It doesn't: https://godbolt.org/z/rU5_5H
> > > >
> > > > I assume this is caused by some sort of internal change to the 0day
> > > > infrastructure (testing W=1?)
> > > >
> > > > I cannot see this without adding W=1 to make at the listed commit with
> > > > the provided config.
> > > >
> > > > Cheers,
> > > > Nathan
> > > >
> > > > > Anyway, something for Benni to fix. CCed and leaving the rest for him as
> > > > > reference.
> > > > >
> > > > > > arch/x86/mm/init.c:75:1: note: declare 'static' if the function is not intended
> > > to be used outside of this translation unit
> > > > > > bool x86_has_pat_wp(void)
> > > > > > ^
> > > > > > static
> > > > > > arch/x86/mm/init.c:866:13: warning: no previous prototype for function
> > > 'mem_encrypt_free_decrypted_mem' [-Wmissing-prototypes]
> > > > > > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > > > > > ^
> > > > > > arch/x86/mm/init.c:866:1: note: declare 'static' if the function is not intended
> > > to be used outside of this translation unit
> > > > > > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > > > > > ^
> > > > > > static
> > > > > > 2 warnings generated.
> > > > > >
> > > > > > vim +/x86_has_pat_wp +75 arch/x86/mm/init.c
> > > > > >
> > > > > >     73
> > > > > >     74      /* Check that the write-protect PAT entry is set for write-protect */
> > > > > >   > 75      bool x86_has_pat_wp(void)
> > > > > >     76      {
> > > > > >     77              return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] ==
> > > _PAGE_CACHE_MODE_WP;
> > > > > >     78      }
> > > > > >     79
> > > > > >
> > > > > > ---
> > > > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > > >
> > > > >
> > > > >
> > > > > --
> > > > > Regards/Gruss,
> > > > >     Boris.
> > > > >
> > > > > https://people.kernel.org/tglx/notes-about-netiquette
> > > > >
> > > >
> > > > --
> > > > You received this message because you are subscribed to the Google Groups
> > > "Clang Built Linux" group.
> > > > To unsubscribe from this group and stop receiving emails from it, send an email
> > > to clang-built-linux+unsubscribe@googlegroups.com.
> > > > To view this discussion on the web visit
> > > https://groups.google.com/d/msgid/clang-built-
> > > linux/20200519212541.GA3580016%40ubuntu-s3-xlarge-x86.
> > >
> > >
> > >
> > > --
> > > Thanks,
> > > ~Nick Desaulniers
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
