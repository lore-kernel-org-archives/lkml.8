Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A03C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67B962073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="uuzwPXhv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730038AbgEEP13 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729403AbgEEP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:27:28 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16AA2C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 08:27:28 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id b6so2639261qkh.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 08:27:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r/em/r1WAWdIxfLddFgVdK8/WA54vnvCFmZ5eTaHEGI=;
        b=uuzwPXhvPztMz4zHd3EPswjaU7UzyVLgP82njzHGSMhiwR7satUNP/H9oFmb2zmBl5
         roz08OHw6yDtf5Pytm0tv38O7lGL7Qd2QRHmJugb2TZycLQSah4WdqOk5gw599MivkHp
         RCDAR0ljKALkXIj6099CztWvxNRAyHv7a4ZolmsRwjb61C2Mof0IbYRyxWnMY32Qegcy
         BR6BEgzPa5/wJZzHwWRMvsex+cJAIMBplmh6n+c4XfhSUZwmp7EOJy4Mv3YOLsK3mTcs
         TXxNZEIogoS1EOphfSvEWmBrZbpPpUGSnPwBXhI/r5GnunV7OX6rnQXGolj581CtOEqP
         iECg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/em/r1WAWdIxfLddFgVdK8/WA54vnvCFmZ5eTaHEGI=;
        b=t9qj0aSUSubR1uUqxVyDxFKxYvs6ts9BEkHQ4+/ZZAmB4BZjRfUn2VklWGKhLOhh/n
         P2Fb7vk7na29JvFRVizoNBaOb6v7O5ma8LVU1+UKHgWSvjNpeMR8SgSecuI0DaoBksfJ
         QsKb18DSgj5eLcuiUIm0b3oAdDL5SnEHb1z+amDXfvYY80VhBt9n1iiqhXEpDqER++rO
         YKRkO5tAtGFANA1okOE5/jfBg1mslfLe8oQWudxAt6TXqzLMv+Na8rN143Bz6lGwPyZg
         P5HHZpz2cY92j4IQSFdLRYJEGZg6YEtWc3ivVsBM9XILbx8cOAEECC5O91zQf0ylKn7H
         Pyvw==
X-Gm-Message-State: AGi0PuYBb7bt2JC9+3ykS+g1Z6pcnAS+HNOTC6EoIrZqmKXk9B9G1O5/
        S7yr3d5JS2hQQ2ERNnB5LMXK9Q==
X-Google-Smtp-Source: APiQypLgzOG/9CK0nnQeafYiiDOgvjgM2U0hk8pyzzC6DGfmq/rF3w9aRNq5NZV0ftE4GOXSjn8Oaw==
X-Received: by 2002:a05:620a:13f2:: with SMTP id h18mr3952397qkl.37.1588692447220;
        Tue, 05 May 2020 08:27:27 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id a139sm2050850qkg.107.2020.05.05.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 08:27:26 -0700 (PDT)
Date:   Tue, 5 May 2020 11:27:12 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200505152712.GB58018@cmpxchg.org>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200504065600.GA22838@dhcp22.suse.cz>
 <CALvZod5Ao2PEFPEOckW6URBfxisp9nNpNeon1GuctuHehqk_6Q@mail.gmail.com>
 <20200504141136.GR22838@dhcp22.suse.cz>
 <CALvZod7Ls7rTDOr5vXwEiPneLqbq3JoxfFBxZZ71YWgvLkNr5A@mail.gmail.com>
 <20200504150052.GT22838@dhcp22.suse.cz>
 <CALvZod7EeQm-T4dsBddfMY_szYw3m8gRh5R5GfjQiuQAtCocug@mail.gmail.com>
 <20200504160613.GU22838@dhcp22.suse.cz>
 <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod79hWns9366B+8ZK2Roz8c+vkdA80HqFNMep56_pumdRQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 12:23:51PM -0700, Shakeel Butt wrote:
> On Mon, May 4, 2020 at 9:06 AM Michal Hocko <mhocko@kernel.org> wrote:
> > I really hate to repeat myself but this is no different from a regular
> > oom situation.
> 
> Conceptually yes there is no difference but there is no *divine
> restriction* to not make a difference if there is a real world
> use-case which would benefit from it.

I would wholeheartedly agree with this in general.

However, we're talking about the very semantics that set memory.max
apart from memory.high: triggering OOM kills to enforce the limit.

> > when the kernel cannot act and mentions that along with the
> > oom report so that whoever consumes that information can debug or act on
> > that fact.
> >
> > Silencing the oom report is simply removing a potentially useful
> > aid to debug further a potential problem.
> 
> *Potentially* useful for debugging versus actually beneficial for
> "sweep before tear down" use-case. Also I am not saying to make "no
> dumps for memory.max when no eligible tasks" a set in stone rule. We
> can always reevaluate when such information will actually be useful.
> 
> Johannes/Andrew, what's your opinion?

I still think that if you want to sweep without triggering OOMs,
memory.high has the matching semantics.

As you pointed out, it doesn't work well for foreign charges, but that
is more of a limitation in the implementation than in the semantics:

	/*
	 * If the hierarchy is above the normal consumption range, schedule
	 * reclaim on returning to userland.  We can perform reclaim here
	 * if __GFP_RECLAIM but let's always punt for simplicity and so that
	 * GFP_KERNEL can consistently be used during reclaim.  @memcg is
	 * not recorded as it most likely matches current's and won't
	 * change in the meantime.  As high limit is checked again before
	 * reclaim, the cost of mismatch is negligible.
	 */

Wouldn't it be more useful to fix that instead? It shouldn't be much
of a code change to do sync reclaim in try_charge().

Then you could express all things that you asked for without changing
any user-visible semantics: sweep an empty cgroup as well as possible,
do not oom on remaining charges that continue to be used by processes
outside the cgroup, do trigger oom on new foreign charges appearing
due to a misconfiguration.

	echo 0 > memory.high
	cat memory.current > memory.max

Would this work for you?
