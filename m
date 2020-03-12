Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD72C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:07:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B9EA2071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 18:07:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AncVZ1gc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgCLSHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 14:07:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:32891 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgCLSHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 14:07:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay11so2981626plb.0
        for <linux-kernel@vger.kernel.org>; Thu, 12 Mar 2020 11:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=o5Rs9S0RYunQW4vpCbkDqGUyyhPOaydkpJow5/jb/es=;
        b=AncVZ1gcQLTl82u2dTBzHwOLmeA0NJKMbQrX2PCLBsijaiX2atkSN9hoqI5Qb9Npx3
         8GaIyWKe2T+f3rJk9RzzXQvZCz65ujA0Onk1Krr2sLslYH2+Ej0b5HDR/Z7+nA7cKvv9
         r3niug17WALbTsxFhepXZT41hlg5nsQurA6/uCQTafgAFIH/wehKB6T2dlHwgkWPGauz
         zo75aSP9c7eqrU9821PiMNY5XtBF9RQlmaqAvWKIi1b+8qcXzEDWbArHW/eL6vqrpqpu
         wDzxTcsPCVCzbYiCPYsfZEZD6stNOsNK1RcP4yLw5qLo75IdiEoIsLtKQ1KDcsDH10qc
         9pCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=o5Rs9S0RYunQW4vpCbkDqGUyyhPOaydkpJow5/jb/es=;
        b=lAonWZSkV6bAm69PiMVgioQWhKs0/B88VP8F1urLOWN1q8TQ+tdmwHlYFAtaI2uHEl
         WxdPNZ0EhCJz3d2EZF0OXKCIl2ChsjOjmHueqCx8gF76UQVKeMGIwcH6InuwH9eclTJv
         ifVO495G568aX6esen9gl5m40MofnBugTYSIFZuxpyn1UjuOuHSu5nMd/vLCOA17k7R2
         SQpsx0WjKcafew2E8ThEo0ym+QowRgzhXr+rdfs01X+gMd9By7gqUIXje3LgDCiaWKSc
         btTqqbjxdL3BGe6QYd8BJ5qVZGfOy57fgCpaxHjFWR4Uo1URDxYynAf3RaLiQTzIbkUJ
         ydEA==
X-Gm-Message-State: ANhLgQ3HaTq/8KIHJBRwxLFkqU6DE7W5AH9oRWsFxd4x5C92ap/Ek133
        WPjrIJ9v1kciMGhvThQs/i8k3g==
X-Google-Smtp-Source: ADFU+vsZ2i5IaQQYazSCYmNou7CThfHcLBtO490lloSMclgQlcjk8rpyVT2JOpYqkc4ADG591zTA5A==
X-Received: by 2002:a17:902:db83:: with SMTP id m3mr9039744pld.133.1584036437569;
        Thu, 12 Mar 2020 11:07:17 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id e18sm9603469pjt.41.2020.03.12.11.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 11:07:16 -0700 (PDT)
Date:   Thu, 12 Mar 2020 11:07:15 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP
 systems
In-Reply-To: <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
Message-ID: <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
References: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp> <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com> <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Mar 2020, Tetsuo Handa wrote:

> > On Thu, 12 Mar 2020, Tetsuo Handa wrote:
> > > > If you have an alternate patch to try, we can test it.  But since this 
> > > > cond_resched() is needed anyway, I'm not sure it will change the result.
> > > 
> > > schedule_timeout_killable(1) is an alternate patch to try; I don't think
> > > that this cond_resched() is needed anyway.
> > > 
> > 
> > You are suggesting schedule_timeout_killable(1) in shrink_node_memcgs()?
> > 
> 
> Andrew Morton also mentioned whether cond_resched() in shrink_node_memcgs()
> is enough. But like you mentioned,
> 

It passes our testing because this is where the allocator is looping while 
the victim is trying to exit if only it could be scheduled.

> you can try re-adding sleep outside of oom_lock:
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index d09776cd6e10..3aee7e0eca4e 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1576,6 +1576,7 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 */
>  	ret = should_force_charge() || out_of_memory(&oc);
>  	mutex_unlock(&oom_lock);
> +	schedule_timeout_killable(1);
>  	return ret;
>  }
>  

If current was process chosen for oom kill, this would actually induce the 
problem, not fix it.

> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3c4eb750a199..e80158049651 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3797,7 +3797,6 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	 */
>  	if (!mutex_trylock(&oom_lock)) {
>  		*did_some_progress = 1;
> -		schedule_timeout_uninterruptible(1);
>  		return NULL;
>  	}
>  
> @@ -4590,6 +4589,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
>  
>  	/* Retry as long as the OOM killer is making progress */
>  	if (did_some_progress) {
> +		schedule_timeout_uninterruptible(1);
>  		no_progress_loops = 0;
>  		goto retry;
>  	}
> 
> By the way, will you share the reproducer (and how to use the reproducer) ?
> 

On an UP kernel with swap disabled, you limit a memcg to 100MB and start 
three processes that each fault 40MB attached to it.  Same reproducer as 
the "mm, oom: make a last minute check to prevent unnecessary memcg oom 
kills" patch except in that case there are two cores.
