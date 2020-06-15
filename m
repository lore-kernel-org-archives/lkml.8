Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F6C7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72D6E206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:54:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BXZKUDKZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgFORy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:54:57 -0400
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F48EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:54:57 -0700 (PDT)
Received: by mail-yb1-xb43.google.com with SMTP id 187so9442639ybq.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Dk7BygnFYGnzkx1IWPE/dcxGzhkldsM5n8DQWmVEnpQ=;
        b=BXZKUDKZ+FdY1u9DiY8vCq4SXoTi/jPf87ajorWN7GgJBESLuSwhHVibfq0ePdJWNC
         wWbFZzC8SPgu6ear8yczsNS+7nDL0eRUstfQGLsM2N4RiI4qX57blIAOu81O9uSFG04U
         N9mVWQ4hJFsaPcvlV6hYlgqlqb+qzCaM1Ga0q10zhVGIob9ZuPUsmpC17uaP3iiVWNtc
         YtCn13RejSqAIr2HC8la9IDCTfoN4ZwXWV0vJ7XCIPq/xdUNRDz0U8q+95K5rawD2gQy
         LPUtutgbjQ1PHWsWmrUWvEX7ZCDiCI3VRKNfJDQxQKsPfzoRQL6Q5/Lp9kUWmYBZ2J4c
         kQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Dk7BygnFYGnzkx1IWPE/dcxGzhkldsM5n8DQWmVEnpQ=;
        b=JSheLhE77pAet9RAPKBRH7QVZs/4saZgOmFbfMvAmHuAV/q0TimfUVxk78EXEzF2Zp
         Thn05nFJjI90WNaZn2xWFz4mbGJAhZ+bnUukFbfpLiK1Scx3Q7+VCoM5BGRvGZ0giF4G
         l378Jy+tQO0LNplSsc6kLHUgV0+0rAYVtHFDV+vF/DVKvwuWnxpujerT7aQvpC34Dwcq
         cPnzOrdg7IV/z947ZLX9MrfOd8TbkdRjNjShU8eqeqYlDEqorbmut3BHTyeF0pxz5pft
         pEuX7320R0M+CKC5/G99N90E5dVC3x8lPvY3HzTNb2voqSS3Z64/BWD83rfDtLtfrUnh
         S93g==
X-Gm-Message-State: AOAM531byEci5aw5S+3hRqtccAhyPmXHWHMWBnDw4e5BgI2n+3+faEJn
        g3N5ny0XaQr+tc1JSialnQjaUhPVeu5sL/OiHiVxMw==
X-Google-Smtp-Source: ABdhPJxD3gXDRu/pSIAsFwvwh2W7/wJ4rMNdhjPfQri1swBGjCuO+BcaMIBnpIe6X6t1v7QPoJvWZosfnadSmDnYqIo=
X-Received: by 2002:a25:941:: with SMTP id u1mr48736662ybm.274.1592243696339;
 Mon, 15 Jun 2020 10:54:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200615062520.GK12456@shao2-debian> <CANn89i+s=oFTq6KFhT0z1CReQPZCGoEPShEFHVvXAmC9sUDH7g@mail.gmail.com>
 <CAKwvOdkv=L=QKQc7HtOi5ZNdao35m18PMr7ep+4sKv5iogVDLg@mail.gmail.com>
In-Reply-To: <CAKwvOdkv=L=QKQc7HtOi5ZNdao35m18PMr7ep+4sKv5iogVDLg@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Mon, 15 Jun 2020 10:54:45 -0700
Message-ID: <CANn89iJYCHqvCTvzommOL4RHtKLT5wyXMzpWKNfrBFTgs4kNAw@mail.gmail.com>
Subject: Re: net/sched/sch_fq.c:966:12: warning: stack frame size of 1400
 bytes in function 'fq_dump'
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:44 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Mon, Jun 15, 2020 at 9:17 AM 'Eric Dumazet' via Clang Built Linux
> <clang-built-linux@googlegroups.com> wrote:
> >
> > On Sun, Jun 14, 2020 at 11:26 PM kernel test robot <lkp@intel.com> wrote:
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   96144c58abe7ff767e754b5b80995f7b8846d49b
> > > commit: 39d010504e6b4485d7ceee167743620dd33f4417 net_sched: sch_fq: add horizon attribute
> > > date:   6 weeks ago
> > > :::::: branch date: 3 hours ago
> > > :::::: commit date: 6 weeks ago
> > > config: arm-randconfig-r006-20200614 (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project c669a1ed6386d57a75a602b53266466dae1e1d84)
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # install arm cross compiling tool for clang build
> > >         # apt-get install binutils-arm-linux-gnueabi
> > >         git checkout 39d010504e6b4485d7ceee167743620dd33f4417
> > >         # save the attached .config to linux build tree
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> > >
> > > If you fix the issue, kindly add following tag as appropriate
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > >
> > > >> net/sched/sch_fq.c:966:12: warning: stack frame size of 1400 bytes in function 'fq_dump' [-Wframe-larger-than=]
> > > static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
> > > ^
> >
> >
> > This looks like a bug in CLANG on ARM, there is no way fq_dump() could
> > consume so much stack space.
>
> You can use
> https://github.com/ClangBuiltLinux/frame-larger-than
> to help debug these.  You might be surprised who's doing larger stack
> allocations than expected.

What is wrong with scripts/checkstack.pl  ?

>
> >
> >
> >
> > > 1 warning generated.
> > >
> > > # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39d010504e6b4485d7ceee167743620dd33f4417
> > > git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > > git remote update linus
> > > git checkout 39d010504e6b4485d7ceee167743620dd33f4417
> > > vim +/fq_dump +966 net/sched/sch_fq.c
> > >
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   965
> > > afe4fd062416b1 Eric Dumazet   2013-08-29  @966  static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   967  {
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   968          struct fq_sched_data *q = qdisc_priv(sch);
> > > 48872c11b77271 Eric Dumazet   2018-11-11   969          u64 ce_threshold = q->ce_threshold;
> > > 39d010504e6b44 Eric Dumazet   2020-05-01   970          u64 horizon = q->horizon;
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   971          struct nlattr *opts;
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   972
> > > ae0be8de9a53cd Michal Kubecek 2019-04-26   973          opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   974          if (opts == NULL)
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   975                  goto nla_put_failure;
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   976
> > > 65c5189a2b57b9 Eric Dumazet   2013-11-15   977          /* TCA_FQ_FLOW_DEFAULT_RATE is not used anymore */
> > > 65c5189a2b57b9 Eric Dumazet   2013-11-15   978
> > > 48872c11b77271 Eric Dumazet   2018-11-11   979          do_div(ce_threshold, NSEC_PER_USEC);
> > > 39d010504e6b44 Eric Dumazet   2020-05-01   980          do_div(horizon, NSEC_PER_USEC);
> > > 48872c11b77271 Eric Dumazet   2018-11-11   981
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   982          if (nla_put_u32(skb, TCA_FQ_PLIMIT, sch->limit) ||
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   983              nla_put_u32(skb, TCA_FQ_FLOW_PLIMIT, q->flow_plimit) ||
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   984              nla_put_u32(skb, TCA_FQ_QUANTUM, q->quantum) ||
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   985              nla_put_u32(skb, TCA_FQ_INITIAL_QUANTUM, q->initial_quantum) ||
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   986              nla_put_u32(skb, TCA_FQ_RATE_ENABLE, q->rate_enable) ||
> > > 76a9ebe811fb3d Eric Dumazet   2018-10-15   987              nla_put_u32(skb, TCA_FQ_FLOW_MAX_RATE,
> > > 76a9ebe811fb3d Eric Dumazet   2018-10-15   988                          min_t(unsigned long, q->flow_max_rate, ~0U)) ||
> > > f52ed89971adbe Eric Dumazet   2013-11-15   989              nla_put_u32(skb, TCA_FQ_FLOW_REFILL_DELAY,
> > > f52ed89971adbe Eric Dumazet   2013-11-15   990                          jiffies_to_usecs(q->flow_refill_delay)) ||
> > > 06eb395fa9856b Eric Dumazet   2015-02-04   991              nla_put_u32(skb, TCA_FQ_ORPHAN_MASK, q->orphan_mask) ||
> > > 77879147a3481b Eric Dumazet   2016-09-19   992              nla_put_u32(skb, TCA_FQ_LOW_RATE_THRESHOLD,
> > > 77879147a3481b Eric Dumazet   2016-09-19   993                          q->low_rate_threshold) ||
> > > 48872c11b77271 Eric Dumazet   2018-11-11   994              nla_put_u32(skb, TCA_FQ_CE_THRESHOLD, (u32)ce_threshold) ||
> > > 583396f4ca4d6e Eric Dumazet   2020-03-16   995              nla_put_u32(skb, TCA_FQ_BUCKETS_LOG, q->fq_trees_log) ||
> > > 39d010504e6b44 Eric Dumazet   2020-05-01   996              nla_put_u32(skb, TCA_FQ_TIMER_SLACK, q->timer_slack) ||
> > > 39d010504e6b44 Eric Dumazet   2020-05-01   997              nla_put_u32(skb, TCA_FQ_HORIZON, (u32)horizon) ||
> > > 39d010504e6b44 Eric Dumazet   2020-05-01   998              nla_put_u8(skb, TCA_FQ_HORIZON_DROP, q->horizon_drop))
> > > afe4fd062416b1 Eric Dumazet   2013-08-29   999                  goto nla_put_failure;
> > > afe4fd062416b1 Eric Dumazet   2013-08-29  1000
> > > d59b7d8059ddc4 Yang Yingliang 2014-03-12  1001          return nla_nest_end(skb, opts);
> > > afe4fd062416b1 Eric Dumazet   2013-08-29  1002
> > > afe4fd062416b1 Eric Dumazet   2013-08-29  1003  nla_put_failure:
> > > afe4fd062416b1 Eric Dumazet   2013-08-29  1004          return -1;
> > > afe4fd062416b1 Eric Dumazet   2013-08-29  1005  }
> > > afe4fd062416b1 Eric Dumazet   2013-08-29  1006
> > >
> > > :::::: The code at line 966 was first introduced by commit
> > > :::::: afe4fd062416b158a8a8538b23adc1930a9b88dc pkt_sched: fq: Fair Queue packet scheduler
> > >
> > > :::::: TO: Eric Dumazet <edumazet@google.com>
> > > :::::: CC: David S. Miller <davem@davemloft.net>
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > _______________________________________________
> > > kbuild mailing list -- kbuild@lists.01.org
> > > To unsubscribe send an email to kbuild-leave@lists.01.org
> >
> > --
> > You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CANn89i%2Bs%3DoFTq6KFhT0z1CReQPZCGoEPShEFHVvXAmC9sUDH7g%40mail.gmail.com.
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
