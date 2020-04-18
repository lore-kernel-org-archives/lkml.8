Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDEDC2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:48:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D144422202
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 09:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME8UtMFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRJsV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 05:48:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbgDRJsU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 05:48:20 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D0EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:48:20 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k11so5774953wrp.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 02:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to;
        bh=yppnx2RRRH6dXEAoSsBWx8ZDGYXI8EKm8jvsYqKLP1E=;
        b=ME8UtMFWbT941uR7oSocXnBCpbpKwfoPlneWRsX58TC3vJrZ/9VvbpiTseKmNK01vX
         R7lTwAvYFwHCidRBF+U+UGw1fadYUhb1qkRRr7wDWQ0C8Z3A7Vt/gvd8q+j94AhSUFB4
         EdFgcLTPa/aBeW10TQMn803vIgBPf1Eh+yd+lBf9a74n0KCLzbeyPggtMAXbpe+uIn6D
         M/lz9isgvD6P78K4Lce/hoBgODW29Y3gjMpUyAqA37DO/FSv2JthSth81Wz8wQGo9Jzi
         ZeXHCS74SIBJQBvqO/dtHmUdzAxRTlOK2mzdAyz+H4ZoK2+Az1cvAoEAIwxMnS8g+9n9
         24tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to;
        bh=yppnx2RRRH6dXEAoSsBWx8ZDGYXI8EKm8jvsYqKLP1E=;
        b=MRBL4Kr2MjztA6b/A404QRjdzDeBHJgXcUje5O4CQjg/V2+pmQx2aawIyxeEeJ9K7K
         5bCXlFDBq8W0lzMXKt+ut9Ibls7AKyvP5hXE7llACFvxxXFB644cwODVU5rU6kj7uw4Z
         8WfNuUXqg33x8P0gll8vLA9Z73iEpVK0yknwa0Ky9vZR8ijJ2YQkaDKbbHbd4VVcNcTz
         D7CSUfqTBm/fNkB1F344wnnF2kX+dTjY6rGkOhbp3bnyLCMdmhLNupcvl5RkdCptWQ+r
         v7viqwmyRa7FOielOpg+HeyY5YjZsEY6jwgD82ELkbyoLDzs4dp8URirI9pFnLRADwQO
         Q3mg==
X-Gm-Message-State: AGi0PuZVhR3eCRUxR17SWptLTyI6TQT42BVWrlvg+pDCgMzxy4PLcY/Q
        15LbJbdcOcuFlx4m2jbjSlc=
X-Google-Smtp-Source: APiQypJheoymwNGaxz1WvTAhfi+zRIqvQi08HK25/tXlituE/0ujV6q8nWaV2xC0KgcR+k5rtdBlbw==
X-Received: by 2002:a5d:6850:: with SMTP id o16mr8024101wrw.309.1587203298550;
        Sat, 18 Apr 2020 02:48:18 -0700 (PDT)
Received: from localhost.localdomain ([2a02:2450:10d2:194d:d02f:2f6b:b441:f83])
        by smtp.gmail.com with ESMTPSA id p3sm17185593wrx.82.2020.04.18.02.48.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2020 02:48:17 -0700 (PDT)
From:   SeongJae Park <sj38.park@gmail.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     SeongJae Park <sjpark@amazon.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Peter Zijlstra <peterz@infradead.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Aubrey Li <aubrey.li@intel.com>
Subject: Re: Re: Re: Re: Re: [RFC] autonuma: Support to scan page table asynchronously
Date:   Sat, 18 Apr 2020 11:48:11 +0200
Message-Id: <20200418094811.4757-1-sj38.park@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417144626.GA3711@suse.de> (raw)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 17 Apr 2020 15:46:26 +0100 Mel Gorman <mgorman@suse.de> wrote:

> On Fri, Apr 17, 2020 at 02:44:37PM +0200, SeongJae Park wrote:
> > On Fri, 17 Apr 2020 13:16:29 +0100 Mel Gorman <mgorman@techsingularity.net> wrote:
> > 
> > > On Fri, Apr 17, 2020 at 12:21:29PM +0200, SeongJae Park wrote:
> > > > On Fri, 17 Apr 2020 12:04:17 +0200 Peter Zijlstra <peterz@infradead.org> wrote:
> > > > 
> > > > > On Fri, Apr 17, 2020 at 09:05:08AM +0200, SeongJae Park wrote:
> > > > > > I think the main idea of DAMON[1] might be able to applied here.  Have you
> > > > > > considered it?
> > > > > > 
> > > > > > [1] https://lore.kernel.org/linux-mm/20200406130938.14066-1-sjpark@amazon.com/
> > > > > 
> > > > > I've ignored that entire thing after you said the information it
> > > > > provides was already available through the PMU.
> > > > 
> > > > Sorry if my answer made you confused.  What I wanted to say was that the
> > > > fundamental access checking mechanism that DAMON depends on is PTE Accessed bit
> > > > for now, but it could be modified to use PMU or other features instead. 
> > > 
> > > I would not be inclined to lean towards either approach for NUMA
> > > balancing. Fiddling with the accessed bit can have consequences for page
> > > aging and residency -- fine for debugging a problem, not to fine for
> > > normal usage. I would expect the PMU approach would have high overhead
> > > as well as taking over a PMU counter that userspace debugging may expect
> > > to be available.
> > 
> > Good point.  But, isn't it ok to use Accessed bit as long as PG_Idle and
> > PG_Young is adjusted properly?  Current DAMON implementation does so, as
> > idle_page_tracking also does.
> > 
> 
> PG_idle and PG_young are page flags that are used by idle tracking. The
> accessed bit I'm thinking of is in the PTE bit and it's the PTE that
> is changed by page_referenced() during reclaim. So it's not clear how
> adjusting the page bits help avoid page aging problems during reclaim.

The idle tracking reads and updates not only PG_idle and PG_young, but also the
accessed bit.  So idle tacking was also required to deal with the interference
of the reclaimer logic and thus it introduced PG_young.  The commit
33c3fc71c8cf ("mm: introduce idle page tracking") explains this as below:

    The Young page flag is used to avoid interference with the memory
    reclaimer.  A page's Young flag is set whenever the Access bit of a page
    table entry pointing to the page is cleared by writing to the bitmap file.
    If page_referenced() is called on a Young page, it will add 1 to its
    return value, therefore concealing the fact that the Access bit was
    cleared.

DAMON adjusts PG_young in similar way to avoid the interference.  DAMON further
adjusts PG_idle so that it does not interfere to page idle tracking mechanism.
I think I made you confused by unnecessarily mentioning PG_idle, sorry.

> 
> Maybe your suggestion was to move NUMA balancing to use the PG_idle and
> PG_young bits from idle tracking but I'm not sure what that gains us.
> This may be because I did not look too closely at DAMON as for debugging
> and analysis, the PMU sounded more suitable.
> 
> It's not clear to me how looking at the page or pte bit handling of
> DAMON helps us reduce the scanning cost of numa balancing. There may
> be some benefit in splitting the address space and rescanning sections
> that were referenced but it has similar pitfalls to simply tracking the
> highest/lowest address that trapped a NUMA hinting fault.

DAMON allows users to know which address ranges have which access frequency.
Thus, I think DAMON could be used for detection of hot pages, which will be
good migration candidates, instead of the NUMA hinting fault based referenced
pages detection.

The benefits I expect from this change are better accuracy and less overhead.
As we can know not only referenced pages but hot pages, migration will be more
effective.

In terms of the overhead, DAMON allows users to set the upperbound of the
monitoring overhead regardless of the size of the targe address space, unlike
the page scanning based mechanisms.  Thus, the overhead could be reduced,
especially if the target process has large memory footprint.

As I'm not deeply understanding AutoNUMA, I might saying something unrealistic
or missing some important points.


Thanks,
SeongJae Park

> 
> -- 
> Mel Gorman
> SUSE Labs
