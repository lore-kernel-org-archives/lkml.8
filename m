Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A885CC54E49
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:44:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F3982173E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:44:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="BO4e5bD/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgEHVoZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgEHVoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:44:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE12FC05BD09
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:44:23 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id n14so3347219qke.8
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hfgFNTJ/A8Lg7nI9g+Xp3FmILdU0dHMohrFwQmfLQXo=;
        b=BO4e5bD/Q+sMJjS2zPBJ9fA0BfYUE6sPFxYwsNOwSV4A2F0R22Kk02cgB2O7t3YZjN
         WXq235+CpxzxCfyxC4UYLkH/H+vrK1wMRWc3F3A11zVLIM3R2j0B/m2cBQTChZS2n/IP
         ycONKTo/SlL6z7hvTvz8LF/MSBS+pQTo+GfyZVFUF2s22DI7IQqTmOIRk93B6ONU/3d+
         Pq1q9czvaqdabgSzhAER31wB8ODppfSiaxEfMXyIsYMZeQmm7jGvrzMFyqWdkB6tXXwH
         A2Lb4VY/NrvuvTG+OprSMVStvHwAZoJcabj5QflkXcTJuSH6Gb0UOWCFSguBlgr8iiZr
         7VuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hfgFNTJ/A8Lg7nI9g+Xp3FmILdU0dHMohrFwQmfLQXo=;
        b=YpqnpExkNziJ76b/muuWzBmkUzQ/ZIxUADOvl+2rRWelqAYhrotrQr0PiaY/AAf/6h
         fgFHFMJ5HNBYRfi+fUbXQmrduK5zhwlO4HUCmEs5pcabxeB9sR/u4l9D/i1A/JwaObJ4
         kQr4QA5EGkBVzqGwIDrlaiHy1VEUFWc2ivzDafj0EuJ2jf7s1VjnHV6KCX3jIdDWREUN
         n2IxuRGIl2PGop3rSFRxikjCjS/L1JRH8guKbT9Z2/5d1AR0mOBDM00DxUkkbb+wva8j
         xFQ6cRbRZ7DqUp3lGZR3xUy3pb3zu8Y+Wn/5XDdQYp+XYrk2fFJJM4cVu5SC+BDRFiFI
         WlSw==
X-Gm-Message-State: AGi0Pubmc7H2JYFl/4/kPRMUILiU7Pqoehx5DJdsj9KFo94vo4NknV11
        8KCcIsBrhBQzETjlj/xGjPRU2w==
X-Google-Smtp-Source: APiQypIcaFiRBShLfyT2ZablqamrjqanqyX+wOuWHrrB6W4WNcimavEO382WKWr9Frqp3mIoOgsFNg==
X-Received: by 2002:a05:620a:816:: with SMTP id s22mr5051840qks.348.1588974262923;
        Fri, 08 May 2020 14:44:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id x19sm2116487qkh.42.2020.05.08.14.44.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:44:22 -0700 (PDT)
Date:   Fri, 8 May 2020 17:44:05 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
Message-ID: <20200508214405.GA226164@cmpxchg.org>
References: <20200508170630.94406-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508170630.94406-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 10:06:30AM -0700, Shakeel Butt wrote:
> One way to measure the efficiency of memory reclaim is to look at the
> ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
> not updated consistently at the system level and the ratio of these are
> not very meaningful. The pgsteal and pgscan are updated for only global
> reclaim while pgrefill gets updated for global as well as cgroup
> reclaim.
> 
> Please note that this difference is only for system level vmstats. The
> cgroup stats returned by memory.stat are actually consistent. The
> cgroup's pgsteal contains number of reclaimed pages for global as well
> as cgroup reclaim. So, one way to get the system level stats is to get
> these stats from root's memory.stat, so, expose memory.stat for the root
> cgroup.
> 
> 	from Johannes Weiner:
> 	There are subtle differences between /proc/vmstat and
> 	memory.stat, and cgroup-aware code that wants to watch the full
> 	hierarchy currently has to know about these intricacies and
> 	translate semantics back and forth.
> 
> 	Generally having the fully recursive memory.stat at the root
> 	level could help a broader range of usecases.

The changelog begs the question why we don't just "fix" the
system-level stats. It may be useful to include the conclusions from
that discussion, and why there is value in keeping the stats this way.

> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
