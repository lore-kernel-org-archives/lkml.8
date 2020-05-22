Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03510C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D77C62072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 11:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ibYojR7I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgEVLpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 07:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728356AbgEVLps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 07:45:48 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF1DC05BD43
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:45:46 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so9533224wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 04:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ISPO3IWCguXmyabv5FXXISc8kopDXlzx6J+miu4ZHGA=;
        b=ibYojR7IUChRwwkGUFV8Ix7J3R87H9BNieXyiLNiM/Jz7JprAb6YKZQHsaIEWubbA+
         8KftKi894Ums2p9lR0f4LDfzaWCiUTYYYE2BV0WeoplnmONhzmzzbuk+WCmS86LPo7F0
         PnqBigiKz8mhyR1JCC5EWyOY4Av7pNmTwJS+Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ISPO3IWCguXmyabv5FXXISc8kopDXlzx6J+miu4ZHGA=;
        b=sAsL+oQIJ7PewmyhLNSa+OStXRNRuQ0G+qkF9AOty21+x8WO/YFkQTwdDDl4gtaAEM
         uEjJlTOleRzMPLrC83U2CQ13HZugylTzkXdrKXKyAO/ndA3QKTUXepKvbqL2pZm2mXfl
         RPFcxEXjmBWLlz9eYMtO0sluOJVP6HExxkYF0ekws2S9Fm7RhKZaQilXxOWXbBATW1Jm
         0mghtFJ8ZOvLJ+7nxrARnFz0plaQ40E+BvMPI1FBrF62Tvo0gLnjaHx+BST1dtlMbOE/
         hdJOVSPmoa32vUjqypLgfOlmQkg9EsOApdNnC3R6g9RpB4ly4rtyhbk4RtDMnV1VtcxP
         CgKg==
X-Gm-Message-State: AOAM533p6qj6HBDZ3HjtN16wkjYCK6xnnuUHaEBuh5unsz8VAVNQDXWs
        TN/qTYJRzi2gJk7e4z0pNPl/Pml8ubP8dKh8
X-Google-Smtp-Source: ABdhPJxN193yDA7z96NAkCU9aNyUbdslzeeF1KEAL/9qfdMH8sTFVLKpQgswqb3g0DKQMc9H59EaNg==
X-Received: by 2002:a7b:c8d2:: with SMTP id f18mr12755108wml.174.1590147944952;
        Fri, 22 May 2020 04:45:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id 94sm9696290wrf.74.2020.05.22.04.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 04:45:44 -0700 (PDT)
Date:   Fri, 22 May 2020 12:45:44 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, linux-mm <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org
Subject: Re: [PATCH v3 2/2] mm, memcg: Decouple e{low,min} state mutations
 from protection checks
Message-ID: <20200522114544.GA1112005@chrisdown.name>
References: <20200505084127.12923-1-laoar.shao@gmail.com>
 <20200505084127.12923-3-laoar.shao@gmail.com>
 <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CA+G9fYseWc_7yq0M5Onju_HxbFid6DbuuaEFf-KUpqfxdF-QTg@mail.gmail.com>
User-Agent: Mutt/1.14.1 (2020-05-03)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Naresh Kamboju writes:
>This patch is causing oom-killer while running mkfs -t ext4 on i386 kernel
>running on x86_64 machine version linux-next 5.7.0-rc6-next-20200521.

I think I see what's wrong here -- if we bail out early, memory.e{min,low} 
might be uninitialised.

Does this patch fix it, by any chance?

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index d3b23c57bed4..aa902b9cbb79 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -5046,6 +5046,9 @@ mem_cgroup_css_alloc(struct cgroup_subsys_state *parent_css)
  			memory_cgrp_subsys.broken_hierarchy = true;
  	}
  
+	memcg->memory.emin = 0;
+	memcg->memory.elow = 0;
+
  	/* The following stuff does not apply to the root */
  	if (!parent) {
  #ifdef CONFIG_MEMCG_KMEM
-- 
2.26.2

