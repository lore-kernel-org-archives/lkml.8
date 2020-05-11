Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E194AC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92B824962
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 01:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XWwCZN3j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgEKBZA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 21:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727789AbgEKBZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 21:25:00 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FE4C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 18:25:00 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x77so4022245pfc.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 18:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=rrpue9ELDAyjtjXQonJqUPBUAIMsAtBRTq6A+RPQWpw=;
        b=XWwCZN3jW3/5HtRXyFm+DTTr5MV4v9xZjc1MlfUlO//spcTx5rVeX/uovT5jprL0QC
         GQBFO+UtZrdtb4gEq5y1skPW8asQ/rag5f77L0I8AdH/AgEwoX2wDVEK8OLDK0WU4rU4
         JCutFIXlcwaGirD1TnrQ320raqdIyH4ZdVA2bezfFFl98GBrnI+h0FipAMm8s6CCivlm
         JubRMJELEpK6EZOJZ5sw4hB8NTz1mu7rjH69Bb56gDerLBtPO2oFkyx4oGq2WrV7YkG/
         rPExuNrXFDCLfmqSwBwP9MpyZliK9c+xNBOlpLmAerKY0/Pil4n+9Dp9mAXOmzLzyi9Y
         1N+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=rrpue9ELDAyjtjXQonJqUPBUAIMsAtBRTq6A+RPQWpw=;
        b=ExcpItB2uLa4IBE5Gl7Zx3Hpw5TpqSpqTWYYssJ135znZVuqBhkhyqCpb6NKIjKMt0
         gmrQpwLXQXp1yArTA7uZpMUlashFuSb3S5DcMJcE2a9ei4WmxUCOtm4+8p8m6bbYjYhV
         0bzfBJfTo486ySsMqwb5UF46MMDiFSLDYLATpVlz0JXg+Ea+dWYMiMkopScabI8OIIrp
         cYCC82sbcYAHUYtz8+KzCzruNTexKp3qcWMiLDUlicCsjicCkzIvbDbtnxT+5jX+3u+6
         73dE6s1vYClZ6lC2s/Hr8omuoQZt4XtxuSlKAUtzT6Y9NffmcVHXSqgy/S4ypdXdkEUc
         cOKQ==
X-Gm-Message-State: AGi0PuZ9+34L5QMLdxG+9KXrm+3oxS4aJkROZr7GMg7wsHptl+atcD1N
        oGvjSKYUrXpUgsDkrP7dG8k9uQ==
X-Google-Smtp-Source: APiQypJrh7BKHwezP7S81MyJCWTh95bZ2XZG16s2AtPiogeoGAV6AtXRKla8hC6TTMm92E+FhkmvSQ==
X-Received: by 2002:a63:792:: with SMTP id 140mr7940224pgh.65.1589160299547;
        Sun, 10 May 2020 18:24:59 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id z7sm7622992pff.47.2020.05.10.18.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 18:24:58 -0700 (PDT)
Date:   Sun, 10 May 2020 18:24:58 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Guilherme Piccoli <gpiccoli@canonical.com>
cc:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Gavin Guo <gavin.guo@canonical.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH] mm, compaction: Indicate when compaction is manually
 triggered by sysctl
In-Reply-To: <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2005101821160.172131@chino.kir.corp.google.com>
References: <20200507215946.22589-1-gpiccoli@canonical.com> <20200507160438.ed336a1e00c23c6863d75ae5@linux-foundation.org> <CALJn8nNDqWwanhmutCiP-WBLN1eSg2URrG2j5R4kzgHTYObs7Q@mail.gmail.com> <alpine.DEB.2.22.394.2005081129100.236131@chino.kir.corp.google.com>
 <CAHD1Q_wF6Mzf5JipXGZKvn2YDR+FQ6ePuKOe-1W-t_VapxMCxg@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 May 2020, Guilherme Piccoli wrote:

> On Fri, May 8, 2020 at 3:31 PM David Rientjes <rientjes@google.com> wrote:
> > It doesn't make sense because it's only being done here for the entire
> > system, there are also per-node sysfs triggers so you could do something
> > like iterate over the nodemask of all nodes with memory and trigger
> > compaction manually and then nothing is emitted to the kernel log.
> >
> > There is new statsfs support that Red Hat is proposing that can be used
> > for things like this.  It currently only supports KVM statistics but
> > adding MM statistics is something that would be a natural extension and
> > avoids polluting both the kernel log and /proc/vmstat.
> 
> Thanks for the review. Is this what you're talking about [0] ? Very interesting!
> 

Exactly.

> Also, I agree about the per-node compaction, it's a good point. But at
> the same time, having the information on the number of manual
> compaction triggered is interesting, at least for some users. What if
> we add that as a per-node stat in zoneinfo?
> 

The kernel log is not preferred for this (or drop_caches, really) because 
the amount of info can causing important information to be lost.  We don't 
really gain anything by printing that someone manually triggered 
compaction; they could just write to the kernel log themselves if they 
really wanted to.  The reverse is not true: we can't suppress your kernel 
message with this patch.

Instead, a statsfs-like approach could be used to indicate when this has 
happened and there is no chance of losing events because it got scrolled 
off the kernel log.  It has the added benefit of not requiring the entire 
log to be parsed for such events.
