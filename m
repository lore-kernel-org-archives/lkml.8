Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF15DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADC1D2067D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:54:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F7ElWs/X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgGOGyM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbgGOGyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:54:11 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33526C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:54:11 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id p1so2000883pls.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 23:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=17b8hbCm8iAaa62tZL0iIJtXNS59CDTl98QfnYxmWkw=;
        b=F7ElWs/XlZa/5vdvS+xKFxXa36pRykGC5qHshchJ6QlDdy5Y27EQaIMd3fm03nJPUV
         EFUYxxes6TTM+vfRciWbnsoPbZSnivAuHxlW0+tR0/oUtIJ055C3MoHHAWCgf+3lgeP5
         fWIZuILg4sEhAlmMnvE3PY00q4pMilg7GnbId7UEFgsqcS+6LZaeCw+mNnHcWMfvjd7q
         KUGzx/xA39ZHjJgjCT0pWLPIJMJBXfmYIWcfvMkbnR7lHphY0moIT34HmnC+Mx6fLUO0
         d4F1dds1IgkeUzdFlwp/8fOP9A0z+IwWT8ClBYQUxtV6eMrUhpZo3d7QANUtJoq5RFF0
         y6PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=17b8hbCm8iAaa62tZL0iIJtXNS59CDTl98QfnYxmWkw=;
        b=ifGSXax68tvqUipIa5NkxQMsX9Pl2NvAwLaY7k27IFRVcssI7zTFojnvv4AmZ7mjGb
         SIzcPUJiU9FkCs7ULHXfwk0ZK93BmLe+EMUWc7/HSQUwGlhiaYq5jqycQT+/ZIMX3x6M
         DymPdKQLAnKK+GBpHYxzSysITME32h3u2UvCYKqLdEKav/DoMYZY16imjnG2BJnFRDcd
         MDx4lJ/XXZ7ZrQj5aK2RB9jQ72gNMB/i8plSqQll8YqD8jh3JRjwZzNE2aN0wE6VaVIW
         22pkNufxfUkXpMbNVJdBHq/Z/kvLMh7xqDUQBR/sfPR0D6oQBwuKcou94Vn2G5mr7Fww
         c/YQ==
X-Gm-Message-State: AOAM533Dn24oKVu3kLidEBag0fQ+Pkyq/Ot2OFQrLpG4kvD/TrBnSYHs
        SZMywgvmwP7s7AtTeIOUIFtn5Q==
X-Google-Smtp-Source: ABdhPJwJkrF75tMhWncnzHm12LsWV+Bu99s1vPbepGHU5q0a50Bukf/pDGebojbnpubXJ12l6YMkpQ==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr6971459plo.153.1594796050515;
        Tue, 14 Jul 2020 23:54:10 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id k71sm1136416pje.33.2020.07.14.23.54.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Jul 2020 23:54:09 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:54:07 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, jogness@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sched_clock: Expose struct clock_read_data
Message-ID: <20200715065407.GB19269@leoy-ThinkPad-X240s>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-2-leo.yan@linaro.org>
 <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:56:50AM +0200, Ahmed S. Darwish wrote:
> On Wed, Jul 15, 2020 at 10:05:07AM +0800, Leo Yan wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> >
> ...
> >
> > Provide struct clock_read_data and two (seqcount) helpers so that
> > architectures (arm64 in specific) can expose the numbers to userspace.
> >
> ...
> >
> > +struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> > +{
> > +	*seq = raw_read_seqcount(&cd.seq);
> > +	return cd.read_data + (*seq & 1);
> > +}
> > +
> ...
> 
> Hmm, this seqcount_t is actually a latch seqcount. I know the original
> code also used raw_read_seqcount(), but while at it, let's use the
> proper read API for seqcount_t latchers: raw_read_seqcount_latch().

Good point.  To be honest, I think myself cannot give a good judgement
for memory barrier related thing :)

I read a bit the document for the latch technique [1], comparing to
raw_read_seqcount_latch(), the function raw_read_seqcount() contains
smp_rmb(), IIUC, the *read* memory barrier is used to support for
kcsan.

The usage for smp_rmb() and kcsan flow is like below:

  sched_clock_read_begin()
    `-> raw_read_seqcount()
          `-> smp_rmb()
                `-> kcsan_atomic_next(KCSAN_SEQLOCK_REGION_MAX)

  sched_clock_read_retry()
    `-> read_seqcount_retry()
          `-> smp_rmb()
                `-> kcsan_atomic_next(0)

So the question is: should we support kcsan or not in this flow?

> raw_read_seqcount_latch() has no read memory barrier though, and a
> suspicious claim that READ_ONCE() pairs with an smp_wmb() (??). But if
> its implementation is wrong, let's fix it there instead.

I don't think we need pair with smp_wmb(), since it's mainly related
with data reading, so a smp_rmb() would be sufficient [2].

Thanks,
Leo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/seqlock.h?h=v5.8-rc5#n321
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/seqlock.h?h=v5.8-rc5#n373
