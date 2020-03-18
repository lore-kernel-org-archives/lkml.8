Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDABC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4EF22076D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 12:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584534728;
	bh=DcJjQSzUyJS9Umh4i3tdu6eg9mFujh3txrQZyenFHpQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RnChm9y+DWviLhU421iumuIF0WBLp68ikyg5sXi4Js9Wf7Yz4jLkVd0RUjTJ3ET2f
	 P/1XDcyxIazTAik2MfqFxLNQNosoHUjupluaKaz2LDoAnueTgW6Lh349GioQBGoN4d
	 vQZdn/6+VI0VkDxCqi8yVxN9Jed8TmQ6+EmeOJmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgCRMcH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 08:32:07 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35738 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgCRMcG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 08:32:06 -0400
Received: by mail-wm1-f66.google.com with SMTP id m3so3127465wmi.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 05:32:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=K+CS+21zAUZ2xO+PTmoIDEUvzM3H5I3+5QSeJVuTL7A=;
        b=jmDumcedJMfB18TQyqMZ6nv4TKrVMCMV83epaD/JF380LyIVWyTt2lI8KwglvOlj1I
         TN5jJC4nUoR+ESgHctcFjzYkw8tXf5ChJOiTbw5OyaJBZXTXSKIHzK7GdlaGTx/iG9ds
         RiyWUwKgtvJMVGMFpblRzaBhW3gKzG8NISI/8vT1UqEo06fkEdiGtfssPKhfouArudtg
         BzotpM2bOtp5d4Cc10uAEvyU1vyXpjjvSeF1mzZhHHhNrLEJfwfmhrWzJLi9dZ5mkFfR
         yoxRLvDobaaXLlIuQY6rLJfGgaYabysz/TUj0NCOa7JMcCm96676RqoFvHNz3bsIV5MO
         K2kw==
X-Gm-Message-State: ANhLgQ3F8/f4wmIoNUA+UgCPe5Q34zmwOnz1ioNKfvGJTyqK+DoWgXRH
        c3pqljtpNHUR/O7QnXhAJPc=
X-Google-Smtp-Source: ADFU+vuAQsgX66PrkR6JCtqUCcdlrkbBb7+WbC0oVYs93TcsdO4r5YEBTFxFaosH22KxzSgv7jDmXA==
X-Received: by 2002:a1c:68c2:: with SMTP id d185mr5133224wmc.150.1584534724510;
        Wed, 18 Mar 2020 05:32:04 -0700 (PDT)
Received: from localhost (ip-37-188-180-89.eurotel.cz. [37.188.180.89])
        by smtp.gmail.com with ESMTPSA id u17sm9248479wrm.43.2020.03.18.05.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 05:32:03 -0700 (PDT)
Date:   Wed, 18 Mar 2020 13:32:02 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: make memory.oom.group tolerable to task
 migration
Message-ID: <20200318123202.GL21362@dhcp22.suse.cz>
References: <20200316223510.3176148-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200316223510.3176148-1-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 16-03-20 15:35:10, Roman Gushchin wrote:
> If a task is getting moved out of the OOMing cgroup, it might
> result in unexpected OOM killings if memory.oom.group is used
> anywhere in the cgroup tree.
> 
> Imagine the following example:
> 
>           A (oom.group = 1)
>          / \
>   (OOM) B   C
> 
> Let's say B's memory.max is exceeded and it's OOMing. The OOM killer
> selects a task in B as a victim, but someone asynchronously moves
> the task into C. mem_cgroup_get_oom_group() will iterate over all
> ancestors of C up to the root cgroup. In theory it had to stop
> at the oom_domain level - the memory cgroup which is OOMing.
> But because B is not an ancestor of C, it's not happening.
> Instead it chooses A (because it's oom.group is set), and kills
> all tasks in A. This behavior is wrong because the OOM happened in B,
> so there is no reason to kill anything outside.
> 
> Fix this by checking it the memory cgroup to which the task belongs
> is a descendant of the oom_domain. If not, memory.oom.group should
> be ignored, and the OOM killer should kill only the victim task.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reported-by: Dan Schatzberg <dschatzberg@fb.com>

After the follow up discussion I do agree that this should be sufficient
for now.
Acked-by: Michal Hocko <mhocko@suse.com>

> ---
>  mm/memcontrol.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index daa399be4688..d8c4b7aa4e73 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -1930,6 +1930,14 @@ struct mem_cgroup *mem_cgroup_get_oom_group(struct task_struct *victim,
>  	if (memcg == root_mem_cgroup)
>  		goto out;
>  
> +	/*
> +	 * If the victim task has been asynchronously moved to a different
> +	 * memory cgroup, we might end up killing tasks outside oom_domain.
> +	 * In this case it's better to ignore memory.group.oom.
> +	 */
> +	if (unlikely(!mem_cgroup_is_descendant(memcg, oom_domain)))
> +		goto out;
> +
>  	/*
>  	 * Traverse the memory cgroup hierarchy from the victim task's
>  	 * cgroup up to the OOMing cgroup (or root) to find the
> -- 
> 2.24.1

-- 
Michal Hocko
SUSE Labs
