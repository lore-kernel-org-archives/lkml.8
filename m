Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF531C55192
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:38:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D08D020728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 02:38:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="Ddtvcj1n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDXCi6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 22:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgDXCiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 22:38:55 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F65C09B044
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:38:55 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id w29so6813057qtv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 19:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ldECbwkx2KzC+gjraTT+5K+gEB5icL0nRQIC9XPuGkU=;
        b=Ddtvcj1n3A2iRjbjaGXKb42PeJjcfV41WkfP5jznQsOoAXtq4Aq0YAI+jC0sCsKnvx
         3ZUlrZSEr3HUWZp9NZZUR0WJE+gtm9Uewof/FeE8jRb+3r2wee/XOWlmOAmQMF85e2cW
         QBsM3r65qePLq09dyRU//VQ1HxsdWxOOkQ5hV/kB6m09C/86n/XsphQWiUecxZrtcy5j
         EFolcHbY7QejWuMaqC22oW+PcDruwHWEGwRIKo9ovvU5K4MZuxo++hLjAlegnyZ2T3hU
         mBUEvRefs3krgdLJT5E4/GkLAylz+osjnZ55rZwa2wXOUEN0L6QFj3VRgJErkjjZe4Gy
         UfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ldECbwkx2KzC+gjraTT+5K+gEB5icL0nRQIC9XPuGkU=;
        b=fOG9egSqRKfFJmEA8CgK7k/2uQiwKzWtybPWhf6TqSlNKc5dSTPj3ajYZeQhqGPNna
         Tz397xiyz8TjmjBHT6x01P3H57RYVK0l3zcv9ZMhPNL2wSWQ4v12+yEwNSJ6wYyevWRh
         FUMfpJPb4KQx3mZhYmkcynboHeuuWs2HWPv9JUPi+ggrYIgcIMLtwK+5MYoP8Jif6J6o
         abzWBGz3oR83ohA2SroWHOsmqiwAZ8bGa3dyWg4thd+1pdAQK1o69U6j0o/Fm/xHCu/k
         2RRvxlXe19I1ERdEzql+OayF1oL237FRMnxeR2d/FZLjMrqMXtOSefs1V/YUKffTrQwP
         n2ig==
X-Gm-Message-State: AGi0PuYjJf6HvGndifa+jfeeDaxUpdJxMv7mZWunRs3glPXmIg9Bx2fz
        orbdqQvB7dOSyor2hcPcPb8S5w==
X-Google-Smtp-Source: APiQypJF/lU+gP1rF4zPkq/e1xGtqTYkCAApZ1rxn1wi2o2lKf14w530nRIMlfW+DykVCLSYhsCYQw==
X-Received: by 2002:ac8:7552:: with SMTP id b18mr6922401qtr.312.1587695934661;
        Thu, 23 Apr 2020 19:38:54 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id g92sm3250225qtd.42.2020.04.23.19.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2020 19:38:54 -0700 (PDT)
Date:   Thu, 23 Apr 2020 22:38:52 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shakeel Butt <shakeelb@google.com>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: optimize memory.numa_stat like memory.stat
Message-ID: <20200424023852.GA464082@cmpxchg.org>
References: <20200304022058.248270-1-shakeelb@google.com>
 <20200305204109.be23f5053e2368d3b8ccaa06@linux-foundation.org>
 <CALvZod7W-Qwa4BRKW0_Ts5f68fwkcqD72SF_4NqZRgEMgA_1-g@mail.gmail.com>
 <CALvZod4R68wNgzOF9dN=i6LwyUYMBhvM7SXaRJGW9Wn_SmeGGA@mail.gmail.com>
 <20200423161009.973c645420a4d17ded2a67ee@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423161009.973c645420a4d17ded2a67ee@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 04:10:09PM -0700, Andrew Morton wrote:
> From: Shakeel Butt <shakeelb@google.com>
> Subject: mm/memcg: optimize memory.numa_stat like memory.stat
> 
> Currently reading memory.numa_stat traverses the underlying memcg tree
> multiple times to accumulate the stats to present the hierarchical view of
> the memcg tree.  However the kernel already maintains the hierarchical
> view of the stats and use it in memory.stat.  Just use the same mechanism
> in memory.numa_stat as well.
> 
> I ran a simple benchmark which reads root_mem_cgroup's memory.numa_stat
> file in the presense of 10000 memcgs.  The results are:
> 
> Without the patch:
> $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> 
> real    0m0.700s
> user    0m0.001s
> sys     0m0.697s
> 
> With the patch:
> $ time cat /dev/cgroup/memory/memory.numa_stat > /dev/null
> 
> real    0m0.001s
> user    0m0.001s
> sys     0m0.000s
> 
> [akpm@linux-foundation.org: avoid forcing out-of-line code generation]
> Link: http://lkml.kernel.org/r/20200304022058.248270-1-shakeelb@google.com
> Signed-off-by: Shakeel Butt <shakeelb@google.com>
> Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Ouch, yes. That makes sense.

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
