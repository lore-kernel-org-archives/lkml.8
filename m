Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC246C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:07:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96CB5208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 04:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rCcTUY3b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbgGaEHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 00:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgGaEHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 00:07:12 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F02B9C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:07:11 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so27750294qka.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 21:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=mYWpP6aK/ldCf40apNtXCnGd6yexdgynubGjVo7Bfc0=;
        b=rCcTUY3bGoSbaXPfkkI8cQEkGpV8mm9TAojYFnlSDFFQxMdNrvbPZIfcFchMNbearV
         7ZaSEeAGxFkDmwMHmRyrNn9es5QiySm5OOJwdjUM40gdNTQjVJ68rgfr2cRyQ3BaEl0O
         iE9sQQGEqNMkUF+ThPF64r8sPM/NtfQBt0JDfBDXj2BuNweOJoypQ1K4xJAZu4QNpeg0
         iH/5qAMqtqSEtP6Imn0QR9X4bO1l0d9WZs68paIcsH1plhLY1wUAgaNVx4RnKQY5B7x0
         Yp+K4hAV+abg1Og1kMAMRgGO4NDVNugoG/43m5+ybhzRYvTO/daSECZm1lZbnvGl3NtD
         k0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=mYWpP6aK/ldCf40apNtXCnGd6yexdgynubGjVo7Bfc0=;
        b=M/wFvMXVkzm4Z8xcWPSGyY9mfxhTE1VbULK79n+84Tmuq8ovq1N9Itq5R2L11qdnGH
         tygHw9b+u5fJ9Bra5QyVzBuxm7zqjf7kCOAlYPb7cQrH/3dN/CBrtDCuaXDTI19SsmKv
         vBDx9J5k5FLwLgnF5ICkZovBjv+5FNjU53X6twi7eps4nmUcmVgUrVWULwkbcn41dX8g
         EF6j4KD3j2BsEnuFbQb1CKKaV8cg76HBzzOlDmnqvRC1nvkRvpcV/ZYyP/dG75O9t0S2
         mqSp4iMgd5JRv85VMtJBgIJKcpqtWEhza3epwD+HDl05isJynntGQzIZALjysURA+1WS
         ngyA==
X-Gm-Message-State: AOAM531eVg9+nj3YdgegbPFWYujRTircTCFfCnEpDedAoK373qakf6pH
        KMrMMo37yTeefiqGyiZdidci5w==
X-Google-Smtp-Source: ABdhPJyOoiZqlslLxA2ujG8dzjeJ5f5ctoJKJhUF/McMDPx+qqBiHnt4YRdGIA05rif77obkniedSw==
X-Received: by 2002:a05:620a:2231:: with SMTP id n17mr2202771qkh.37.1596168430402;
        Thu, 30 Jul 2020 21:07:10 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 71sm6518634qkk.125.2020.07.30.21.07.07
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 30 Jul 2020 21:07:08 -0700 (PDT)
Date:   Thu, 30 Jul 2020 21:06:55 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2007302018350.2410@eggly.anvils>
References: <20200714173920.3319063-1-guro@fb.com> <alpine.LSU.2.11.2007291902340.6363@eggly.anvils> <20200730162348.GA679955@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jul 2020, Roman Gushchin wrote:
> On Wed, Jul 29, 2020 at 08:45:47PM -0700, Hugh Dickins wrote:
> > 
> > But a better idea is perhaps to redefine the behavior of
> > "echo >/proc/sys/vm/stat_refresh".  What if
> > "echo someparticularstring >/proc/sys/vm/stat_refresh" were to
> > disable or enable the warning (permanently? or just that time?):
> > disable would be more "back-compatible", but I think it's okay
> > if you prefer enable.  Or "someparticularstring" could actually
> > specify the warning threshold you want to use - you might echo
> > 125 or 16000, I might echo 0.  We can haggle over the default.
> 
> May I ask you, what kind of problems you have in your in mind,
> which can be revealed by these warnings? Or maybe there is some
> history attached?

Yes: 52b6f46bc163 mentions finding a bug of mine in NR_ISOLATED_FILE
accounting, but IIRC (though I might be making this up) there was
also a bug in the NR_ACTIVE or NR_INACTIVE FILE or ANON accounting.

When one of the stats used for balancing or limiting in vmscan.c
trends increasingly negative, it becomes increasingly difficult
for those heuristics (adding on to others, comparing with others)
to do what they're intended to do: they behave increasingly weirdly.

Now the same (or the opposite) is true if one of those stats trends
increasingly positive: but if it leaks positive, it's visible in
/proc/vmstat; whereas if it leaks negative, it's presented there as 0.

And most of the time (when unsynchronized) showing 0 is much better
than showing a transient negative.  But to help fix bugs, we do need
some way of seeing the negatives, and vm/stat_refresh provides an
opportunity to do so, when it synchronizes.

I'd be glad not to show the transients if I knew them: set a flag
on any that go negative, and only show if negative twice or more
in a row?  Perhaps, but I don't relish adding that, and think it
would be over-engineering.

It does sound to me like echoing the warning threshold into
/proc/sys/vm/stat_refresh is the best way to satisfy us both.

Though another alternative did occur to me overnight: we could
scrap the logged warning, and show "nr_whatever -53" as output
from /proc/sys/vm/stat_refresh: that too would be acceptable
to me, and you redirect to /dev/null.

(Why did I choose -53 in my example?  An in-joke: when I looked
through our machines for these warnings, on old kernels with my
old shmem hugepage implementation, there were a striking number
with "nr_shmem_freeholes -53"; but I'm a few years too late to
investigate what was going on there.)

> 
> If it's all about some particular counters, which are known to be
> strictly positive, maybe we should do the opposite, and check only
> those counters? Because in general it's not an indication of a problem.

Yet it's very curious how few stats ever generate such warnings:
you're convinced they're just transient noise, and you're probably right;
but I am a little suspicious of whether they are accounted correctly.

Hugh
