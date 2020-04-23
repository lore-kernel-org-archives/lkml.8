Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F30C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:44:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8770D2077D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:44:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N8UD7Kgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgDWNoT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728133AbgDWNoT (ORCPT
        <rfc822;Linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:44:19 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA602C08E934
        for <Linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:44:18 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id q2so2874567qvd.1
        for <Linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KmVsaG7x92cBB75mFOQKbglsK+bUZJMNG4bwSL55FPQ=;
        b=N8UD7KguBo2oS1z29uPKMnmneGvB97ipo1s0urT1I4H7O/Wg5io7pPRVd7Oujpwek7
         z+2AlQnXqU0Dl6ssYy7+hM564A55wbitBYm1Aii8+A9AecpsT0zG3+CkzgawTeqruwk8
         iTlqfeZtQSHZHFX8ksGhpVg/P2U7lO95fUQ3NJHBCHMP7s+5WsAV0hr6G0NmxWQoJAja
         9M0PKBcDiyC112uwbQIQD2/HofCJZo9P7XUb6zymjLXlXnpOHQsM22QFdn8L3sQgJmxm
         p3BEODUiZiwbErcZxygY4i2CQDklDt+w80kCfQBPEckNa0teNyS0CQ6PlCUQXUjq9mro
         Ou+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KmVsaG7x92cBB75mFOQKbglsK+bUZJMNG4bwSL55FPQ=;
        b=eILpPG6LQJPjeCnwjTFE3inr0o0HH5I1JULv6t6fgwLWWRaUTeAEKOuzVwJ0mUO3YP
         envI7BSAT/Pr3ZuuVQHuDf5jX2R43INHx+26cNjLwkVOwvxZOmo1pLNyB0s4GmDAlcaL
         wmhH6v4W2vQyRwi07cfZWUubFV4OYuPIMF5XbWMZZwAxrQImzitT/+kD/GqOVNK4VAYg
         uLTXT+ZVJffdta/fCIoIR5+yaDHA55dSowJIBjvQFmnyk54omG5eVzoEUbkPxrl3lKfg
         7mdf0jsGybMYrExmzA4jCnimmRrenzVhC4F8lcLPq+6q/uYCewI91VgOnj2SNXGPvVnB
         Am4w==
X-Gm-Message-State: AGi0PuZeu9gqW9lcpQl8EJB04QVGzO3KevDKxqzqdBdc2Mu7pkh1JTEy
        BRVsfyaCeQI/g279HZ5FOanCUcqYQXE=
X-Google-Smtp-Source: APiQypL83PDSeiZgDiFq6kTvDIcnAdOwqRpS0N07cxf1mD5RedvB+9LBQYU8cG6h2kGWxK5h7UTQPw==
X-Received: by 2002:a0c:c688:: with SMTP id d8mr4229417qvj.159.1587649457911;
        Thu, 23 Apr 2020 06:44:17 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([179.97.37.151])
        by smtp.gmail.com with ESMTPSA id i6sm1531813qkk.123.2020.04.23.06.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 06:44:17 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6F076409A3; Thu, 23 Apr 2020 10:44:14 -0300 (-03)
Date:   Thu, 23 Apr 2020 10:44:14 -0300
To:     "Jin, Yao" <yao.jin@linux.intel.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        jolsa@kernel.org, peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH v2] perf stat: Improve runtime stat for interval mode
Message-ID: <20200423134414.GE19437@kernel.org>
References: <20200420145417.6864-1-yao.jin@linux.intel.com>
 <20200421135329.GA9110@kernel.org>
 <b5724589-f653-f125-a227-b374ec575688@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b5724589-f653-f125-a227-b374ec575688@linux.intel.com>
X-Url:  http://acmel.wordpress.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Apr 22, 2020 at 08:53:41AM +0800, Jin, Yao escreveu:
> Hi Arnaldo,
> 
> On 4/21/2020 9:53 PM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Apr 20, 2020 at 10:54:17PM +0800, Jin Yao escreveu:
> > > For interval mode, the metric is printed after # if it exists. But
> > > it's not calculated by the counts generated in this interval. See
> > > following examples,
> > > 
> > >   root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
> > >   #           time             counts unit events
> > >        1.000422803            764,809      inst_retired.any          #      2.9 CPI
> > >        1.000422803          2,234,932      cycles
> > >        2.001464585          1,960,061      inst_retired.any          #      1.6 CPI
> > >        2.001464585          4,022,591      cycles
> > > 
> > > The second CPI should not be 1.6 (4,022,591/1,960,061 is 2.1)
> > > 
> > >   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
> > >   #           time             counts unit events
> > >        1.000429493          2,869,311      cycles
> > >        1.000429493            816,875      instructions              #    0.28  insn per cycle
> > >        2.001516426          9,260,973      cycles
> > >        2.001516426          5,250,634      instructions              #    0.87  insn per cycle
> > > 
> > > The second 'insn per cycle' should not be 0.87 (5,250,634/9,260,973 is 0.57).
> > > 
> > > The current code uses a global variable rt_stat for tracking and
> > > updating the std dev of runtime stat. Unlike the counts, rt_stat is
> > > not reset for interval. While the counts are reset for interval.
> > > 
> > > perf_stat_process_counter()
> > > {
> > >          if (config->interval)
> > >                  init_stats(ps->res_stats);
> > > }
> > > 
> > > So for interval, the rt_stat should be reset either.
> > 
> >                                s/either/too/g right?
> > 
> 
> Yes, should use "too" here. :)
> 
> > And please try and find what was the cset that introduced the problem,
> > so that we can have a Fixes: line and the stable series can pick it, ok?
> >
> > - Arnaldo
> > 
> 
> I have tried to find the patch which introduced this issue.
> 
> 51fd2df1e882 ("perf stat: Fix interval output values").
> 
> This patch zeros stats for interval mode. I just think it should reset
> rt_stat too.

> But I really don't know if it's fair to this patch so I don't add it in my
> patch description.

I think you are right that 51fd2df1e882 patch missed the fix you're
providing now, so I think it is fair to say that your current patch
fixes 51fd2df1e882, so I added it in the Fixes tag for the patch
discussed in this message, thanks.

- Arnaldo
 
> Thanks
> Jin Yao
> 
> > > This patch resets rt_stat before read_counters, so the runtime
> > > stat is only calculated by the counts generated in this interval.
> > > 
> > > With this patch,
> > > 
> > >   root@kbl-ppc:~# perf stat -M CPI -I1000 --interval-count 2
> > >   #           time             counts unit events
> > >        1.000420924          2,408,818      inst_retired.any          #      2.1 CPI
> > >        1.000420924          5,010,111      cycles
> > >        2.001448579          2,798,407      inst_retired.any          #      1.6 CPI
> > >        2.001448579          4,599,861      cycles
> > > 
> > >   root@kbl-ppc:~# perf stat -e cycles,instructions -I1000 --interval-count 2
> > >   #           time             counts unit events
> > >        1.000428555          2,769,714      cycles
> > >        1.000428555            774,462      instructions              #    0.28  insn per cycle
> > >        2.001471562          3,595,904      cycles
> > >        2.001471562          1,243,703      instructions              #    0.35  insn per cycle
> > > 
> > > Now the second 'insn per cycle' and CPI are calculated by the counts
> > > generated in this interval.
> > > 
> > >   v2:
> > >   ---
> > >   Use just existing perf_stat__reset_shadow_per_stat(&rt_stat).
> > >   We don't need to define new function perf_stat__reset_rt_stat.
> > > 
> > > Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
> > > ---
> > >   tools/perf/Documentation/perf-stat.txt | 2 ++
> > >   tools/perf/builtin-stat.c              | 1 +
> > >   2 files changed, 3 insertions(+)
> > > 
> > > diff --git a/tools/perf/Documentation/perf-stat.txt b/tools/perf/Documentation/perf-stat.txt
> > > index 4d56586b2fb9..3fb5028aef08 100644
> > > --- a/tools/perf/Documentation/perf-stat.txt
> > > +++ b/tools/perf/Documentation/perf-stat.txt
> > > @@ -176,6 +176,8 @@ Print count deltas every N milliseconds (minimum: 1ms)
> > >   The overhead percentage could be high in some cases, for instance with small, sub 100ms intervals.  Use with caution.
> > >   	example: 'perf stat -I 1000 -e cycles -a sleep 5'
> > > +If the metric exists, it is calculated by the counts generated in this interval and the metric is printed after #.
> > > +
> > >   --interval-count times::
> > >   Print count deltas for fixed number of times.
> > >   This option should be used together with "-I" option.
> > > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > > index 9207b6c45475..3f050d85c277 100644
> > > --- a/tools/perf/builtin-stat.c
> > > +++ b/tools/perf/builtin-stat.c
> > > @@ -359,6 +359,7 @@ static void process_interval(void)
> > >   	clock_gettime(CLOCK_MONOTONIC, &ts);
> > >   	diff_timespec(&rs, &ts, &ref_time);
> > > +	perf_stat__reset_shadow_per_stat(&rt_stat);
> > >   	read_counters(&rs);
> > >   	if (STAT_RECORD) {
> > > -- 
> > > 2.17.1
> > > 
> > 

-- 

- Arnaldo
