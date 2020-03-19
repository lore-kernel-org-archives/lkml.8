Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B08C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF5920724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 07:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584601758;
	bh=IbJUY0dKnqFpXE+UCqZekrCggkw4tLbIu2upEZr15mE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=bmEyQPflkBVIn0YzOPF5TCNzgpVCIZMfiZMQZVB8MQS5o9tK642nrQTlzcV0U84Zl
	 blz7Ub1FDFSsYVpsiF5M/ol+xU2Y00sZ0AFwjXtLGojBw0r2jvq5TjY7oKnbN64MS2
	 EYoPYFw7x3oPPnCjEupSoPhGyii13TplVJXT6xLo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727218AbgCSHJQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 03:09:16 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44332 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgCSHJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 03:09:16 -0400
Received: by mail-wr1-f67.google.com with SMTP id o12so797670wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 00:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5EdXwbHlmoDhjXzrHF/yteEF/2NqvDtwOOg1hPGy1hY=;
        b=SZkBNmuKbrkF/LPOHOqA32KPwbfgFDO1Dd3gB1/sK0sGP3hHIx8GkgHQRadgMDiFrd
         1P21NpLIpNmIT/k4MjeWBctz3HeKs7yofkQ9oUZvFPbHT8P2nHxNS5f/qpdV0gj7csqm
         GPnFEyQ781HWOxERZx7BgDOX8W+uuLHk0uFpxv/rBF20dB5OaEUhzsp2ufWPKxVY/Ri8
         z2c04j5nCFHPIwNUGX0tvplHTp30E9j+BFQtQ0p81wGqLJcHtykkJ9BAkc9/gtlP4iD1
         pqmLpUiH38gMOe7PD0hSW94PLAuuEQQGnr3Kr5WfoL43tbRFuh0g8hHj/2kFRkM+Lbdl
         0Xog==
X-Gm-Message-State: ANhLgQ3b0KELeNvMYuBUCuXVnTCVdJ/AfGWyHgVtzfuruoY5Z6lvzW0a
        gM7Il73FZvpWIZ5uuQGfhmbCMbAU
X-Google-Smtp-Source: ADFU+vuMB+9CO0Bl+u+dYlKaD0f4Vcgw8SbDFNPTXAMPt8ki60UKv2knVQgWQ58kmN0nw3+McZJ+HA==
X-Received: by 2002:a5d:6ca7:: with SMTP id a7mr2398248wra.157.1584601754367;
        Thu, 19 Mar 2020 00:09:14 -0700 (PDT)
Received: from localhost (ip-37-188-140-107.eurotel.cz. [37.188.140.107])
        by smtp.gmail.com with ESMTPSA id a184sm1820443wmf.29.2020.03.19.00.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 00:09:12 -0700 (PDT)
Date:   Thu, 19 Mar 2020 08:09:11 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>,
        Robert Kolchmeyer <rkolchmeyer@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch v3] mm, oom: prevent soft lockup on memcg oom for UP
 systems
Message-ID: <20200319070911.GU21362@dhcp22.suse.cz>
References: <8395df04-9b7a-0084-4bb5-e430efe18b97@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2003161648370.47327@chino.kir.corp.google.com>
 <202003170318.02H3IpSx047471@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003162107580.97351@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003171752030.115787@chino.kir.corp.google.com>
 <20200318094219.GE21362@dhcp22.suse.cz>
 <alpine.DEB.2.21.2003181437270.70237@chino.kir.corp.google.com>
 <alpine.DEB.2.21.2003181458100.70237@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2003181458100.70237@chino.kir.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 18-03-20 15:03:52, David Rientjes wrote:
> When a process is oom killed as a result of memcg limits and the victim
> is waiting to exit, nothing ends up actually yielding the processor back
> to the victim on UP systems with preemption disabled.  Instead, the
> charging process simply loops in memcg reclaim and eventually soft
> lockups.
> 
> For example, on an UP system with a memcg limited to 100MB, if three 
> processes each charge 40MB of heap with swap disabled, one of the charging 
> processes can loop endlessly trying to charge memory which starves the oom 
> victim.

This only happens if there is no reclaimable memory in the hierarchy.
That is a very specific condition. I do not see any other way than
having a misconfigured system with min protection preventing any
reclaim. Otherwise we have cond_resched both in slab shrinking code
(do_shrink_slab) and LRU shrinking shrink_lruvec. If I am wrong and
those are insufficient then please be explicit about the scenario.

This is a very important information to have in the changelog!

[...]

> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1576,6 +1576,12 @@ static bool mem_cgroup_out_of_memory(struct mem_cgroup *memcg, gfp_t gfp_mask,
>  	 */
>  	ret = should_force_charge() || out_of_memory(&oc);
>  	mutex_unlock(&oom_lock);
> +        /*
> +         * Give a killed process a good chance to exit before trying to
> +         * charge memory again.
> +         */
> +	if (ret)
> +		schedule_timeout_killable(1);

Why are you making this conditional? Say that there is no victim to
kill. The charge path would simply bail out and it would really depend
on the call chain whether there is a scheduling point or not. Isn't it
simply safer to call schedule_timeout_killable unconditioanlly at this
stage?

>  	return ret;
>  }
>  
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3861,6 +3861,12 @@ __alloc_pages_may_oom(gfp_t gfp_mask, unsigned int order,
>  	}
>  out:
>  	mutex_unlock(&oom_lock);
> +	/*
> +	 * Give a killed process a good chance to exit before trying to
> +	 * allocate memory again.
> +	 */
> +	if (*did_some_progress)
> +		schedule_timeout_killable(1);

This doesn't make much sense either. Please remember that the primary
reason you are adding this schedule_timeout_killable in this path is
because you want to somehow reduce the priority inversion problem
mentioned by Tetsuo. Because the page allocator path doesn't lack
regular scheduling points - compaction, reclaim and should_reclaim_retry
etc have them.

>  	return page;
>  }
>  

-- 
Michal Hocko
SUSE Labs
