Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A4FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74EA520739
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 17:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uBOxov/3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729926AbgFORoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 13:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgFORoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 13:44:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6CAC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:44:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i4so165849pjd.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 10:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wgm7Ev6xOl2QQEot2mfMM1wpkg4lvJ2QLEiwDn/B3jI=;
        b=uBOxov/32G6M+WzbbeeKoJJRPHqhIqhI72gZIkbTttHOpwKq/GjzubnKAFIoRFNjjO
         NIGrAoRhEVOwI32t+Aa8mdf6esTVi2AMqe0Xfv3M3qPr2k/jZw2hXRsbHjh0dpg0IVhD
         RqyAGi5/lwH9zc9F3WDF8bWyJGXEzUSOigA7Zj1buqVJDBPhQmOvAI5PE8hMjvC3syn6
         cItyXXxz+MiVmp5/9ATbddtf7EOCc1gwHEwtWEgPJOM0fAnaCr6Cem1OrYICAKrhBXOy
         dFxPlS+kCN5+cAGZufkvOHq8S28HQcU7IUmduqNw/SjajG5/RccDQBCcddpAkhrlsS9o
         3MVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wgm7Ev6xOl2QQEot2mfMM1wpkg4lvJ2QLEiwDn/B3jI=;
        b=kLdSYA/1pSr1hEEG/ArdhRwSEVQY/n7WXlbJb5HRIqm9pxFmUVrVDUNY7zvFSHFwOW
         QeCAzHbX0oFxyNZloWCbpkWNysZdADwq4VGKCwmlZ66gl+Kv4crVlj5PU/zaYSSYZaA8
         Lo1remnxRnWpRnVigDssAdL2LmJPMEzcVavVSf6C7RFyn423DW34FTVi2HwEhQqJjXYP
         6nRna49WrUMt+4TN9a3W4VvRoteg742Degxouc6ehm1gtg2cHOZCieFK/m+s5HWSBFjV
         Fnd+34TyPftOO8gkEkTvZBuo1zO3jAmoftu2PgdDT7fBeNARXm0iji9DhUzFWKl0TLkE
         1KPg==
X-Gm-Message-State: AOAM532SpXIxScQ8ZlZocOMBg4MFkCD3y3QTWdxlVLImFjyo6UiJj2hy
        D+c5LHFTEzAKwPRJMre69sFiblmBhV91hHBNAjK6YQ==
X-Google-Smtp-Source: ABdhPJxKx2HsQOIrpuCT7RS7IzMjTGDuXnl7gxqU+7RJWT8N0ZfcpVdmJ3KVWmKcg9dsjwwH10xrTU+mUtyP82Vnm3o=
X-Received: by 2002:a17:902:fe8b:: with SMTP id x11mr23019349plm.179.1592243047470;
 Mon, 15 Jun 2020 10:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200615062520.GK12456@shao2-debian> <CANn89i+s=oFTq6KFhT0z1CReQPZCGoEPShEFHVvXAmC9sUDH7g@mail.gmail.com>
In-Reply-To: <CANn89i+s=oFTq6KFhT0z1CReQPZCGoEPShEFHVvXAmC9sUDH7g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 15 Jun 2020 10:43:56 -0700
Message-ID: <CAKwvOdkv=L=QKQc7HtOi5ZNdao35m18PMr7ep+4sKv5iogVDLg@mail.gmail.com>
Subject: Re: net/sched/sch_fq.c:966:12: warning: stack frame size of 1400
 bytes in function 'fq_dump'
To:     Eric Dumazet <edumazet@google.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 9:17 AM 'Eric Dumazet' via Clang Built Linux
<clang-built-linux@googlegroups.com> wrote:
>
> On Sun, Jun 14, 2020 at 11:26 PM kernel test robot <lkp@intel.com> wrote:
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   96144c58abe7ff767e754b5b80995f7b8846d49b
> > commit: 39d010504e6b4485d7ceee167743620dd33f4417 net_sched: sch_fq: add horizon attribute
> > date:   6 weeks ago
> > :::::: branch date: 3 hours ago
> > :::::: commit date: 6 weeks ago
> > config: arm-randconfig-r006-20200614 (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project c669a1ed6386d57a75a602b53266466dae1e1d84)
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install arm cross compiling tool for clang build
> >         # apt-get install binutils-arm-linux-gnueabi
> >         git checkout 39d010504e6b4485d7ceee167743620dd33f4417
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> >
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> >
> > >> net/sched/sch_fq.c:966:12: warning: stack frame size of 1400 bytes in function 'fq_dump' [-Wframe-larger-than=]
> > static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
> > ^
>
>
> This looks like a bug in CLANG on ARM, there is no way fq_dump() could
> consume so much stack space.

You can use
https://github.com/ClangBuiltLinux/frame-larger-than
to help debug these.  You might be surprised who's doing larger stack
allocations than expected.

>
>
>
> > 1 warning generated.
> >
> > # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=39d010504e6b4485d7ceee167743620dd33f4417
> > git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> > git remote update linus
> > git checkout 39d010504e6b4485d7ceee167743620dd33f4417
> > vim +/fq_dump +966 net/sched/sch_fq.c
> >
> > afe4fd062416b1 Eric Dumazet   2013-08-29   965
> > afe4fd062416b1 Eric Dumazet   2013-08-29  @966  static int fq_dump(struct Qdisc *sch, struct sk_buff *skb)
> > afe4fd062416b1 Eric Dumazet   2013-08-29   967  {
> > afe4fd062416b1 Eric Dumazet   2013-08-29   968          struct fq_sched_data *q = qdisc_priv(sch);
> > 48872c11b77271 Eric Dumazet   2018-11-11   969          u64 ce_threshold = q->ce_threshold;
> > 39d010504e6b44 Eric Dumazet   2020-05-01   970          u64 horizon = q->horizon;
> > afe4fd062416b1 Eric Dumazet   2013-08-29   971          struct nlattr *opts;
> > afe4fd062416b1 Eric Dumazet   2013-08-29   972
> > ae0be8de9a53cd Michal Kubecek 2019-04-26   973          opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
> > afe4fd062416b1 Eric Dumazet   2013-08-29   974          if (opts == NULL)
> > afe4fd062416b1 Eric Dumazet   2013-08-29   975                  goto nla_put_failure;
> > afe4fd062416b1 Eric Dumazet   2013-08-29   976
> > 65c5189a2b57b9 Eric Dumazet   2013-11-15   977          /* TCA_FQ_FLOW_DEFAULT_RATE is not used anymore */
> > 65c5189a2b57b9 Eric Dumazet   2013-11-15   978
> > 48872c11b77271 Eric Dumazet   2018-11-11   979          do_div(ce_threshold, NSEC_PER_USEC);
> > 39d010504e6b44 Eric Dumazet   2020-05-01   980          do_div(horizon, NSEC_PER_USEC);
> > 48872c11b77271 Eric Dumazet   2018-11-11   981
> > afe4fd062416b1 Eric Dumazet   2013-08-29   982          if (nla_put_u32(skb, TCA_FQ_PLIMIT, sch->limit) ||
> > afe4fd062416b1 Eric Dumazet   2013-08-29   983              nla_put_u32(skb, TCA_FQ_FLOW_PLIMIT, q->flow_plimit) ||
> > afe4fd062416b1 Eric Dumazet   2013-08-29   984              nla_put_u32(skb, TCA_FQ_QUANTUM, q->quantum) ||
> > afe4fd062416b1 Eric Dumazet   2013-08-29   985              nla_put_u32(skb, TCA_FQ_INITIAL_QUANTUM, q->initial_quantum) ||
> > afe4fd062416b1 Eric Dumazet   2013-08-29   986              nla_put_u32(skb, TCA_FQ_RATE_ENABLE, q->rate_enable) ||
> > 76a9ebe811fb3d Eric Dumazet   2018-10-15   987              nla_put_u32(skb, TCA_FQ_FLOW_MAX_RATE,
> > 76a9ebe811fb3d Eric Dumazet   2018-10-15   988                          min_t(unsigned long, q->flow_max_rate, ~0U)) ||
> > f52ed89971adbe Eric Dumazet   2013-11-15   989              nla_put_u32(skb, TCA_FQ_FLOW_REFILL_DELAY,
> > f52ed89971adbe Eric Dumazet   2013-11-15   990                          jiffies_to_usecs(q->flow_refill_delay)) ||
> > 06eb395fa9856b Eric Dumazet   2015-02-04   991              nla_put_u32(skb, TCA_FQ_ORPHAN_MASK, q->orphan_mask) ||
> > 77879147a3481b Eric Dumazet   2016-09-19   992              nla_put_u32(skb, TCA_FQ_LOW_RATE_THRESHOLD,
> > 77879147a3481b Eric Dumazet   2016-09-19   993                          q->low_rate_threshold) ||
> > 48872c11b77271 Eric Dumazet   2018-11-11   994              nla_put_u32(skb, TCA_FQ_CE_THRESHOLD, (u32)ce_threshold) ||
> > 583396f4ca4d6e Eric Dumazet   2020-03-16   995              nla_put_u32(skb, TCA_FQ_BUCKETS_LOG, q->fq_trees_log) ||
> > 39d010504e6b44 Eric Dumazet   2020-05-01   996              nla_put_u32(skb, TCA_FQ_TIMER_SLACK, q->timer_slack) ||
> > 39d010504e6b44 Eric Dumazet   2020-05-01   997              nla_put_u32(skb, TCA_FQ_HORIZON, (u32)horizon) ||
> > 39d010504e6b44 Eric Dumazet   2020-05-01   998              nla_put_u8(skb, TCA_FQ_HORIZON_DROP, q->horizon_drop))
> > afe4fd062416b1 Eric Dumazet   2013-08-29   999                  goto nla_put_failure;
> > afe4fd062416b1 Eric Dumazet   2013-08-29  1000
> > d59b7d8059ddc4 Yang Yingliang 2014-03-12  1001          return nla_nest_end(skb, opts);
> > afe4fd062416b1 Eric Dumazet   2013-08-29  1002
> > afe4fd062416b1 Eric Dumazet   2013-08-29  1003  nla_put_failure:
> > afe4fd062416b1 Eric Dumazet   2013-08-29  1004          return -1;
> > afe4fd062416b1 Eric Dumazet   2013-08-29  1005  }
> > afe4fd062416b1 Eric Dumazet   2013-08-29  1006
> >
> > :::::: The code at line 966 was first introduced by commit
> > :::::: afe4fd062416b158a8a8538b23adc1930a9b88dc pkt_sched: fq: Fair Queue packet scheduler
> >
> > :::::: TO: Eric Dumazet <edumazet@google.com>
> > :::::: CC: David S. Miller <davem@davemloft.net>
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > _______________________________________________
> > kbuild mailing list -- kbuild@lists.01.org
> > To unsubscribe send an email to kbuild-leave@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/CANn89i%2Bs%3DoFTq6KFhT0z1CReQPZCGoEPShEFHVvXAmC9sUDH7g%40mail.gmail.com.



-- 
Thanks,
~Nick Desaulniers
