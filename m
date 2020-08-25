Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D754AC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B29C020578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 02:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qx7zECjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHYCFO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 22:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727809AbgHYCFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 22:05:10 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A68FC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:05:10 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id w10so2809442oti.2
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 19:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=xCEzVSHJfiSnfhxabuVNC9t0rkX2zX2AVt5dsDA1M40=;
        b=Qx7zECjPFmyvrTTs8F/ocW7tCcVkTwhnunAlXDXZ02SD4HEo5pHK0qvUZ8cmV197QW
         23MJoL24elKzlrQkZr8Yc7T8ZQWrmKbeOUd4hY5pKufw1Z5VW9CMRTRZfbjXU1Za+2yc
         qRLjAl0KCQd2veC9jbi1F0Watbt0V5rKLyNSxNLUGzhHJw2G/qIDuCpOTi/JiHnQg6Lr
         gSCfATvLRBLoL6yZredvS7LzkNyRekKGV1W4rh92bKf6/LJkuKnmLxgLMp2gUOAexBpV
         MmYNyURSACJ5Zg10joqtevQml+/+IDZ7wYzyaTgpNw8011WUWi4XwnMLAStJVcudiGaV
         qJuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=xCEzVSHJfiSnfhxabuVNC9t0rkX2zX2AVt5dsDA1M40=;
        b=njdZVDmHuHdJ/fVe1XMFVann1SRnL+Q6jfY6IKkdczcoTVB9632m9g989xD+cvvUEo
         DIS0QeQO9sJKSJxV5Im4laZKrzX8GqlwnjE+DFSDoxAKA2+PeRBn0gCrJkLPPyBeGkwd
         HVNEDxg429ZtXagXcBCSSN5MnnJWrp1KQHxfS7aiF8a+iqHD8Gub7DyBePDiG9+A+Cpi
         JqcWz+gCohUyzTuYmAfqDN40pcrod6nE5iB/Gh2E3AV5zWhUdJDxcmNNq4wKg986HlKY
         MPzQTz066DR76yVZbCWycuw/Lw8d+ZUSKDlZTUl8QwhJDSecxXQvtMbTjeWQVZp+hm87
         qJJg==
X-Gm-Message-State: AOAM532k/kkO2cPx+90OVusrfwkMGOXziWfHRzjI1j4RcmK+0ehsGe2y
        yKLf4300S20o7Q6bNiLrL+PLcA==
X-Google-Smtp-Source: ABdhPJxzM2WV+TVOMQL/4Ow6BMstFoj6g+xmPTXBpDKBq7id1uxSEggrr4ObCz8lU1snOf/c5wzcZg==
X-Received: by 2002:a9d:12a9:: with SMTP id g38mr5224481otg.299.1598321107433;
        Mon, 24 Aug 2020 19:05:07 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w62sm2402101otb.52.2020.08.24.19.05.05
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Mon, 24 Aug 2020 19:05:06 -0700 (PDT)
Date:   Mon, 24 Aug 2020 19:04:53 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Alex Shi <alex.shi@linux.alibaba.com>
cc:     Michal Hocko <mhocko@suse.com>, Qian Cai <cai@lca.pw>,
        akpm@linux-foundation.org, Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, nao.horiguchi@gmail.com,
        osalvador@suse.de, mike.kravetz@oracle.com
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
In-Reply-To: <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com>
Message-ID: <alpine.LSU.2.11.2008241849020.1171@eggly.anvils>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com> <20200820145850.GA4622@lca.pw> <20200821080127.GD32537@dhcp22.suse.cz> <20200821123934.GA4314@lca.pw> <20200821134842.GF32537@dhcp22.suse.cz> <20200824151013.GB3415@dhcp22.suse.cz>
 <12425e06-38ce-7ff4-28ce-b0418353fc67@linux.alibaba.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020, Alex Shi wrote:
> reproduce using our linux-mm random bug collection on NUMA systems.
> >>
> >> OK, I must have missed that this was on ppc. The order makes more sense
> >> now. I will have a look at this next week.
> > 
> > OK, so I've had a look and I know what's going on there. The
> > move_pages12 is migrating hugetlb pages. Those are not charged to any
> > memcg. We have completely missed this case. There are two ways going
> > around that. Drop the warning and update the comment so that we do not
> > forget about that or special case hugetlb pages.
> > 
> > I think the first option is better.
> > 
> 
> 
> Hi Michal,
> 
> Compare to ignore the warning which is designed to give, seems addressing
> the hugetlb out of charge issue is a better solution, otherwise the memcg
> memory usage is out of control on hugetlb, is that right?

Please don't suppose that this is peculiar to hugetlb: I'm not
testing hugetlb at all (sorry), but I see the VM_WARN_ON_ONCE from
mem_cgroup_page_lruvec(), and from mem_cgroup_migrate(), and from
mem_cgroup_swapout().

In all cases seen on a PageAnon page (well, in one case PageKsm).
And not related to THP either: seen also on machine incapable of THP.

Maybe there's an independent change in 5.9-rc that's defeating
expectations here, or maybe they were never valid.  Worth
investigating, even though the patch is currently removed,
to find out why expectations were wrong.

You'll ask me for more info, stacktraces etc, and I'll say sorry,
no time today.  Please try the swapping tests I sent before.

And may I say, the comment
/* Readahead page is charged too, to see if other page uncharged */
is nonsensical to me, and much better deleted: maybe it would make
some sense if the reader could see the comment it replaces - as
they can in the patch - but not in the resulting source file.

Hugh
