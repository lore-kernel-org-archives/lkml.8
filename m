Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B08C7C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:59:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A2720866
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 19:59:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uj+iurUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgCIT7v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 15:59:51 -0400
Received: from mail-pj1-f66.google.com ([209.85.216.66]:40888 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgCIT7v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 15:59:51 -0400
Received: by mail-pj1-f66.google.com with SMTP id gv19so361162pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 12:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ApMKbaT9NZPQVt7nAnTk1K0Wu/E7soJBK3O0vo/SsBI=;
        b=uj+iurUiPPTN/m54RipwDMNCj/ZFTmGmma6tPr5qy7yx1JDe4cH79ULnBnxcPRP/Og
         md7ebg2FJ3cuwjmQnhIv/Chm5i/pDlsGyeVR/4cdgUCTieZxNTxNmWMsYwjopfyj6ukm
         5XnHYgJImG3HTdcqFvQBSgkkfk6IEyD8n3dASgh82mxq0nvLjbn3MID0aa1BJ36a+wR8
         3y48DGUq1LGF7/F1MQzpoj4YhaL3FU3CcUdUfzYn0etFpnwLELdAZLIuHxtNLeI6Lt+W
         KvfbiPZDedzFXvWTY6P2iynfn7wTplBQF+jr0/9/1suEtOx/DaBB/vIbhMGG11HxHPHh
         wJkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ApMKbaT9NZPQVt7nAnTk1K0Wu/E7soJBK3O0vo/SsBI=;
        b=m1nUEx49uJcH0ukpiUso7Fh3I8geCSkNnyi4La6+ekFSCRzb3ZpnvB8vSjngbc13hs
         Rpq2a3AEA14kIMwtQPcHAJ/XOjJcJxHNa1KtLsj8mgyYrfZOqSZ7mBsKsCGVtxeBOb50
         HziZ+lF2wKALVAj4oMB/z5Q2PDptIqa4TExEnt/JID1vSUEhHI/HhX0UMWwDSPQWaCMY
         yzeyoiVAW4kq2lgHNF/MUYie/pZbnX6uqiDb4TIWiJ9JBL5rq3t0ujFwnPV6M8S9DTQs
         XIAf0QUx4DrdZxnQIdLO0++gDOGcSWsymqsqBJYFZzVoUcpaomAJ7R7U7HXTimimXnUd
         XIEA==
X-Gm-Message-State: ANhLgQ0ATnuShnRHjagrdtf+8jMgXBcQP1CkR4wvFPPjjsJe/77bpubs
        80eWzaAQ4PqXhY08SWwMsdcR6kDgzpC70nnz7Fz2lQ==
X-Google-Smtp-Source: ADFU+vtsf1Md+4e2wEt1Zur/kdkx9d2TXsNK4tOYi8XXqHW1aWgk1gYEWEd7EcK3brqq+XCwbnqL8TPLWTz3MXfesjU=
X-Received: by 2002:a17:90a:1f8d:: with SMTP id x13mr999711pja.27.1583783989605;
 Mon, 09 Mar 2020 12:59:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200309023910.25370-1-masahiroy@kernel.org> <202003091801.6KQQKZ1Y%lkp@intel.com>
In-Reply-To: <202003091801.6KQQKZ1Y%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 9 Mar 2020 12:59:37 -0700
Message-ID: <CAKwvOdksxVa=NGtyT3hsuHg6SJG4CbNWAepf+dxwVDC1+36zyw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: link lib-y objects to vmlinux forcibly when CONFIG_MODULES=y
To:     "David S. Miller" <davem@davemloft.net>,
        Masahiro Yamada <masahiroy@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        =?UTF-8?B?Ru+/ve+/ve+/vW5nLXJ177+977+977+9IFPvv73vv73vv71uZw==?= 
        <maskray@google.com>, Ilie Halip <ilie.halip@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Michal Marek <michal.lkml@markovi.net>,
        kbuild test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 3:55 AM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Masahiro,
>
> I love your patch! Yet something to improve:
>
> [auto build test ERROR on kbuild/for-next]
> [also build test ERROR on linux/master linus/master v5.6-rc5 next-20200306]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
>
> url:    https://github.com/0day-ci/linux/commits/Masahiro-Yamada/kbuild-link-lib-y-objects-to-vmlinux-forcibly-when-CONFIG_MODULES-y/20200309-115312
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git for-next
> config: sparc-defconfig (attached as .config)
> compiler: sparc-linux-gcc (GCC) 7.5.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         GCC_VERSION=7.5.0 make.cross ARCH=sparc
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    arch/sparc/lib/strlen.o: In function `strlen':
> >> (.text+0x0): multiple definition of `strlen'
>    lib/string.o:string.c:(.text+0x2b0): first defined here

So this looks like a bug in 32b Sparc, that we should fix first.

arch/sparc/lib/strlen.S provides a definition of strlen, but it does
not define the preprocessor token __HAVE_ARCH_STRLEN to avoid multiple
definitions from producing a link error.

Or rather, __HAVE_ARCH_STRLEN is provided in include/asm/string_64.h,
but not for 32b sparc.  arch/sparc/strlen.o is unconditionally
required in lib-y in arch/sparc/lib/Makefile.

Either:
1. arch/sparc/lib/strlen.S supports 32b sparc, then __HAVE_ARCH_STRLEN
and a forward declaration of strlen should be provided in
arch/sparc/include/asm/string.h rather than
arch/sparc/include/asm/string_64.h, or...
2. arch/sparc/lib/strlen.S does not support 32b sparc, then the
inclusion of strlen.o in arch/sparc/lib/Makefile should be predicated
on CONFIG_SPARC64.

+ Dave who maybe can provide guidance on how to proceed?  The use of
the BRANCH32 macro in arch/sparc/lib/strlen.S seems to have different
definitions based on CONFIG_SPARC64 vs CONFIG_SPARC32, which makes me
thing it's case 1 above, but I'm not familiar with Sparc assembly to
be confident.
-- 
Thanks,
~Nick Desaulniers
