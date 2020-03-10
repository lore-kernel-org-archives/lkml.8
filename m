Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 310EBC3F2D0
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:55:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD9A2253D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YKOsszmC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgCJWzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:55:44 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46638 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgCJWzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:55:44 -0400
Received: by mail-pf1-f196.google.com with SMTP id c19so159511pfo.13
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=9qaiYIGTi5RptJqzXrWrO9DTMLRu6kbwYuAs5GV2464=;
        b=YKOsszmC2lyMA3RjZ0DeD3vNrtWaqlI5vOA3Vfush2fXkbj/yWnZvPTqyRRq4OFqBk
         Rv/Vdwsc1Wi1hgpeXBRq0lNHpClk9Ej1iO85TzlkG5eGGbdFf8jcksXrQYmY849HCDU3
         k437moOl5m9zlJlXvk1AlvmrGfcUUE2oW0RPSovgDH8PneLtaf+HP6zsnwEE7LvaaOuw
         JIRv5jnGANKljukAgZMJ3vLthCTJSGCZ9rmIu59CNZqaC8dPg4QibTmzXADvm5VcwScx
         y6WHqhU0Z8XZG6OzQnoLS8BrOvG87/B7EW09DGWari0G5uaMnyBxjxWwJlj28u2LAB2o
         M9rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=9qaiYIGTi5RptJqzXrWrO9DTMLRu6kbwYuAs5GV2464=;
        b=OV8+l/FRmKKkmCTEvu5uhbtt2R/Fs7gnIjiasouSZiZmhKi9ejOCGEqR7rgl4M4mlQ
         I1BhcTxH1EOz/haRguhAQL7ltwbxlvbYDL286pnTp35SV2poIZWa7LTwlPby4xve4Jga
         8qV7o77vWEHyqCKWkmRYt9MC5/2YLyKL5c1BHW7d9wDjjIuForsdSFprvJcoHwn5Jp19
         /YQRmjYJ/oNDBi21rKukMrCd7tlS5EN+ZlL2/pDnWulKdbfExxN7L+JSxdXfPWVajFC2
         Ismwuf9bWCyt0u6yLhxztNuoCnx5kBY+MNlh2JJ6+oObdTd7ryMQxOkd62KkHdAYOjmx
         CAkQ==
X-Gm-Message-State: ANhLgQ2Yc95pR65JZ7bjI7s1qndAWvyeRwe5kJYk4thkqnFxxRL4DPC3
        3HxWHBCUvCLMOpY3K+qH8P//UAeEybo=
X-Google-Smtp-Source: ADFU+vv589bwmOekLeFvJ2A3E471W+Hy9tFWJzapwNQjUerzRva/3A5PKDrdhsC1FuRrTvjBRlBW3w==
X-Received: by 2002:aa7:82d5:: with SMTP id f21mr24397468pfn.245.1583880943224;
        Tue, 10 Mar 2020 15:55:43 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id h22sm47875432pgn.57.2020.03.10.15.55.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 15:55:42 -0700 (PDT)
Date:   Tue, 10 Mar 2020 15:55:41 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <0e5ca6ee-d460-db8e-aba2-79aa7a66fad1@I-love.SAKURA.ne.jp>
Message-ID: <alpine.DEB.2.21.2003101555050.177273@chino.kir.corp.google.com>
References: <alpine.DEB.2.21.2003101438510.161160@chino.kir.corp.google.com> <0e5ca6ee-d460-db8e-aba2-79aa7a66fad1@I-love.SAKURA.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Mar 2020, Tetsuo Handa wrote:

> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -2637,6 +2637,8 @@ static void shrink_node_memcgs(pg_data_t *pgdat, struct scan_control *sc)
> >  		unsigned long reclaimed;
> >  		unsigned long scanned;
> >  
> > +		cond_resched();
> > +
> 
> Is this safe for CONFIG_PREEMPTION case? If current thread has realtime priority,
> can we guarantee that the OOM victim (well, the OOM reaper kernel thread rather
> than the OOM victim ?) gets scheduled?
> 

I think it's the best we can do that immediately solves the issue unless 
you have another idea in mind?

> >  		switch (mem_cgroup_protected(target_memcg, memcg)) {
> >  		case MEMCG_PROT_MIN:
> >  			/*
> > 
> 
