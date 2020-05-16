Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2BB2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:42:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C038207C3
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 01:42:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="AH0puOca"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgEPBmv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 21:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgEPBmv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 21:42:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14A3C05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 18:42:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so5534810wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 18:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kS8OYMG072jDcI6wkY/z+PD46Du/tMZhKnhnXKRsoeo=;
        b=AH0puOca79INHP4Gyjk8o8AyxnmdUlm/s7CIZkXpa4xvSasJLmdH8L2vWT0y+OPoA2
         I0dBbUpqu90pgUFRkEbf4DKo2KVJwQ7QIFWnpt9s6w4TNSbgkI5skacNqeGVjFYdGK2v
         XfuM/QsPsOjBfWclFvjZVsVcN2YdvdcuqqfPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kS8OYMG072jDcI6wkY/z+PD46Du/tMZhKnhnXKRsoeo=;
        b=kwzN2ucMogYCs8d/uPf/Lv66Wnuz+VhIsJz2xVEDP8YNY+hcbv1Snp0NFVU85yGPr8
         950PonkFBqSgU1CUanKCT+h+pGqDMMzoxxxC1C7gGqb8MgZiqm3b4UhlcSaXJjO7tcsj
         UR7diSNyd6qayx9VEAeEbAa2wDKFrZeBkpWHeCLPbkXRq+sUR+MUk44hnY6tmBo2goHU
         Ac3Zua9vmY4uerIMDXcZ7aO9PcdryUHaK0PV/AtedexJFFlsBebHcx7qfwjMD7EXAVXI
         d2ud5GJRWAqXW1i1sC+cBwqaSbhruMh4G1uNG0yarL8HFxcoNTDMujvIvQ5UGzJ/V10o
         PjXA==
X-Gm-Message-State: AOAM531tfjubSjy98XZKrGrSUq4dJqXuZT+FCZa09RGFAgx8Sp/xCC1D
        4hB0fMB24fHE8UIl70Wibk9SbQ==
X-Google-Smtp-Source: ABdhPJygr4YRwvdn5bQj/+FRk7Jk9MpKoXCmkZ5L4Hgg+hvUMxR3NbMw1h1nDwgPO85GahUNXx18VA==
X-Received: by 2002:adf:9b91:: with SMTP id d17mr6892266wrc.183.1589593368152;
        Fri, 15 May 2020 18:42:48 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:56e1:adff:fe3f:49ed])
        by smtp.gmail.com with ESMTPSA id x5sm6315441wro.12.2020.05.15.18.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 18:42:47 -0700 (PDT)
Date:   Sat, 16 May 2020 02:42:47 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Mel Gorman <mgorman@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Yafang Shao <laoar.shao@gmail.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: expose root cgroup's memory.stat
Message-ID: <20200516014247.GA8578@chrisdown.name>
References: <20200508170630.94406-1-shakeelb@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200508170630.94406-1-shakeelb@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey Shakeel,

Shakeel Butt writes:
>One way to measure the efficiency of memory reclaim is to look at the
>ratio (pgscan+pfrefill)/pgsteal. However at the moment these stats are
>not updated consistently at the system level and the ratio of these are
>not very meaningful. The pgsteal and pgscan are updated for only global
>reclaim while pgrefill gets updated for global as well as cgroup
>reclaim.
>
>Please note that this difference is only for system level vmstats. The
>cgroup stats returned by memory.stat are actually consistent. The
>cgroup's pgsteal contains number of reclaimed pages for global as well
>as cgroup reclaim. So, one way to get the system level stats is to get
>these stats from root's memory.stat, so, expose memory.stat for the root
>cgroup.
>
>	from Johannes Weiner:
>	There are subtle differences between /proc/vmstat and
>	memory.stat, and cgroup-aware code that wants to watch the full
>	hierarchy currently has to know about these intricacies and
>	translate semantics back and forth.
>
>	Generally having the fully recursive memory.stat at the root
>	level could help a broader range of usecases.
>
>Signed-off-by: Shakeel Butt <shakeelb@google.com>
>Suggested-by: Johannes Weiner <hannes@cmpxchg.org>

The patch looks great, thanks. To that extent you can add my ack:

Acked-by: Chris Down <chris@chrisdown.name>

One concern about the API now exposed, though: to a new cgroup v2 user this 
looks fairly dodgy as a sole stat file (except for cgroup.stat) at the root. If 
I used cgroup v2 for the first time and only saw memory.stat and cgroup.stat 
there, but for some reason io.stat and cpu.stat are not available at the root 
but are available everywhere else, I think my first thought would be that the 
cgroup v2 developers must have been on some strong stuff when they came up with 
this ;-)

Even if they're only really duplicating information available elsewhere right 
now, have you considered exposing the rest of the stat files as well so that 
the API maintains a bit more consistency? As a bonus, that also means userspace 
applications can parse in the same way from the root down.
