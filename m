Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB59C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 465F421655
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 21:56:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="rVWxHIzD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgEHV4e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 17:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgEHV4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 17:56:34 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03985C061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 14:56:34 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id s186so1545083qkd.4
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 14:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8zne5kD9U815Qp7lQoOfSkfWPnKdq4UH7l4ACZ1laQI=;
        b=rVWxHIzDFvif9rrgKfKEzuzUqpug84jgH+pn6g2K+if7ys4WCpoBTPfsO3vQPvKAhN
         yVfFa2Lp+fBa+5PTkzDejJhE9e4mKzNB4oFie8Fb4O99NmTGN8QvA+xTxmSSZnk3ibBc
         HY2i6VFZUdjANcY0MDN1d4b9v0m8v8op+VhiOv7vwRUaW0FVadyL0QI7pMaOVKtzkkDK
         eICt41IJctDdTY3MUPL17fid7XHKjjKefy0raEReMlnpRuJoXM9b+XyKVFxobwnSPF9F
         Mh/uSrnjUReBhhaHgRTzE7vs/YNfmZ2ip7aKqPqWJrOr4nWGMCvhk2K4BK7cIVcztiM7
         Ocsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8zne5kD9U815Qp7lQoOfSkfWPnKdq4UH7l4ACZ1laQI=;
        b=Rho6/H7Sd+LSlp0LhcJ1Wl0LEZXkuu4O4KTVLO6s3rp93aBEcJ1HuZA9D2lSumKBFY
         iHqVax2iHa73R57dwMEpMKP/rhH3uHWzFKrF1Uo6hQv8SPYoPrEgpaQXANorocnOWhuI
         RDUVF6CdqFyltuI8igUNix0dJA3VVRCgTLOvHCeefuGb4zbC3HzkPJV69QEHLcmyyrsK
         rz1b+XFxbgnRdS1Tuw1vDgB6g4oJtC76KNS4h/DWL39Hs9IZV5LvuxTR/nIF2XQwAfvn
         DJ6RCON+yvd3P7f19rWn9gLzJw9P08jFcWReBKmjb57CVTIkwBG70PE5lRAVItvNJkqZ
         9PsQ==
X-Gm-Message-State: AGi0Pub6O/OQ5ZrHTUT26wjgKY2x7PwWxPq6b5rVFaV9Yc8SM2r8gCIS
        DkqN/HcgLMlUGhRPzqnpu6f2Bg==
X-Google-Smtp-Source: APiQypLlrrLFKBShNnNVF90buqGFklh0fnoXQOu7te0s+VgmO3xy05UxmrY5DdaE5ky534ULac25jA==
X-Received: by 2002:a37:ac08:: with SMTP id e8mr4618592qkm.439.1588974993311;
        Fri, 08 May 2020 14:56:33 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:2627])
        by smtp.gmail.com with ESMTPSA id x8sm2438260qti.51.2020.05.08.14.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 14:56:32 -0700 (PDT)
Date:   Fri, 8 May 2020 17:56:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Roman Gushchin <guro@fb.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] mm: swap: memcg: fix memcg stats for huge pages
Message-ID: <20200508215616.GD226164@cmpxchg.org>
References: <20200508212215.181307-1-shakeelb@google.com>
 <20200508212215.181307-2-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508212215.181307-2-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 02:22:14PM -0700, Shakeel Butt wrote:
> The commit 2262185c5b28 ("mm: per-cgroup memory reclaim stats") added
> PGLAZYFREE, PGACTIVATE & PGDEACTIVATE stats for cgroups but missed
> couple of places and PGLAZYFREE missed huge page handling. Fix that.
> Also for PGLAZYFREE use the irq-unsafe function to update as the irq is
> already disabled.
> 
> Fixes: 2262185c5b28 ("mm: per-cgroup memory reclaim stats")
> Signed-off-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
