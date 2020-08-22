Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE86C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16A20207DA
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:13:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I9SPSJpY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbgHVBN1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 21:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgHVBN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:13:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50342C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:13:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 128so1795262pgd.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MkX4C2RcNFAfKMgWs215Q5BrFctUrgWbt3iTbnMo7KE=;
        b=I9SPSJpYdh49jfOJvpgFzHEblfpnU0s44O2Yi49nsji9SIos+0eRBVtQiTrB2zflUA
         bmc4OWF+cPW42TB3X3vStKxrbiWL6H4ThFysoqO3ye12jTgJdWNYj338jIp8WF3daA+z
         B4bx1EedoHNX3ZPywOcvbQKjjA7XQk1M7WfkOVBJzx+WkRwy+QvIjujJhyeeXRBfCeXL
         b+BtRSocjfX34925tw5KGQviXDT0VeomRDOxrKwQ0WhfdirQATbSwSkV0EBofhGtxMgw
         dWZeJovaHcI3EErEMfDzh4WsxFLk4AZT73fJ1U3tJdxbg1wBloaUJFoOkim1TfCA0Rgn
         ManA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MkX4C2RcNFAfKMgWs215Q5BrFctUrgWbt3iTbnMo7KE=;
        b=FH83Ttq4tvdlwqRk6tIxP03eu6CsSZ+DhxV3vfukRs7qqWcV7npdiY2M+Z8Z732Q91
         nzhD2fhMa8ybJdDQFPGiCbT+bQ3m5Dvvw0FeFVC/lX6XXZJ882cLrAxmydcK5vTFhQ48
         DEe2QnCnr5knVJAQcXaINsxbbma4zT+zw2XkfhbaeNKfcU13I0eyIYBOXU23EievIRWA
         5gJP74b5fvaYvHxGkj97Jv7XXKnZ2fF7TvYYoR0nq3Vn2p5hDNkXQOWExH/to6H/PnzL
         HjX+SgXzhPQqVHUTacpYORuItlsNU+lyBJHg3RJQG7lc6bhtQAe7vfuZj6rMJJH3Rcon
         szFQ==
X-Gm-Message-State: AOAM5321uqM9Ud7TYEvbq0z5XxxUlwWiRinqu7yiv9eNdd0L0ORSNz2o
        GMLbRkK5foI5+SssS3vKo1msuSuGXz2sQiv/LmKrMA==
X-Google-Smtp-Source: ABdhPJwGYi7uLhM/0tBvUCmULIidlcwANh/FXAJNGI8ps7hd50W6ehwByWlKM2fc4amEg0YTwE6pJ/0So1ENAAc1uV8=
X-Received: by 2002:a63:a119:: with SMTP id b25mr4036262pgf.10.1598058804641;
 Fri, 21 Aug 2020 18:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <202008201500.aOkzA3ZM%lkp@intel.com>
In-Reply-To: <202008201500.aOkzA3ZM%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Aug 2020 18:13:13 -0700
Message-ID: <CAKwvOdmZSf2zKaqO3ivorYd9D+yALo5-6hctsSuaK6h2Ywwedw@mail.gmail.com>
Subject: Re: arch/s390/include/asm/atomic_ops.h:56:45: error: invalid operand
 for inline asm constraint 'i'
To:     Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 12:35 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Vasily,
>
> FYI, the error/warning still remains.
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   18445bf405cb331117bc98427b1ba6f12418ad17
> commit: f0cbd3b83ed47803df941865f720934c69abb803 s390/atomic: circumvent gcc 10 build regression
> date:   9 days ago
> config: s390-randconfig-r003-20200818 (attached as .config)
> compiler: clang version 12.0.0 (https://github.com/llvm/llvm-project 4deda57106f7c9b982a49cb907c33e3966c8de7f)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install s390 cross compiling tool for clang build
>         # apt-get install binutils-s390x-linux-gnu
>         git checkout f0cbd3b83ed47803df941865f720934c69abb803
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=s390
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>    In file included from drivers/tty/tty_buffer.c:8:
>    In file included from include/linux/tty.h:5:
>    In file included from include/linux/fs.h:6:
>    In file included from include/linux/wait_bit.h:8:
>    In file included from include/linux/wait.h:7:
>    In file included from include/linux/list.h:9:
>    In file included from include/linux/kernel.h:12:
>    In file included from include/linux/bitops.h:29:
>    In file included from arch/s390/include/asm/bitops.h:39:
> >> arch/s390/include/asm/atomic_ops.h:56:45: error: invalid operand for inline asm constraint 'i'
>    __ATOMIC_CONST_OPS(__atomic_add_const, int, "asi")
>                                                ^

It might be interesting to dissect this one.  Likely will break the
build otherwise.

>    1 error generated.
>
> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=f0cbd3b83ed47803df941865f720934c69abb803
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout f0cbd3b83ed47803df941865f720934c69abb803
> vim +/i +56 arch/s390/include/asm/atomic_ops.h
>
> 126b30c3cb476c Martin Schwidefsky 2016-11-11  51
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  52  #define __ATOMIC_CONST_OPS(op_name, op_type, op_string)                       \
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  53        __ATOMIC_CONST_OP(op_name, op_type, op_string, "\n")            \
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  54        __ATOMIC_CONST_OP(op_name##_barrier, op_type, op_string, "bcr 14,0\n")
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  55
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24 @56  __ATOMIC_CONST_OPS(__atomic_add_const, int, "asi")
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  57  __ATOMIC_CONST_OPS(__atomic64_add_const, long, "agsi")
> eb3b7b848fb3dd Martin Schwidefsky 2017-03-24  58
>
> :::::: The code at line 56 was first introduced by commit
> :::::: eb3b7b848fb3dd00f7a57d633d4ae4d194aa7865 s390/rwlock: introduce rwlock wait queueing
>
> :::::: TO: Martin Schwidefsky <schwidefsky@de.ibm.com>
> :::::: CC: Martin Schwidefsky <schwidefsky@de.ibm.com>
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202008201500.aOkzA3ZM%25lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
