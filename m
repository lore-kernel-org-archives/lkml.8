Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96BC5C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 742382078E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 07:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588575786;
	bh=K10liEDKvo43/rjRR/x8/2QYEQYOsRSvIGJJty3CdVE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xaN6dxh+Tyq1fN+WMfGhydqeX3gmr3LjFDv6Z3qZIvGqG6Rnfr9T4Sc5dSfMbhqj+
	 2b7eM0XkryKfkNRLg6ZwkL7Q2lpKUKpB/IY2L9FlYWKd3HhzfpJIz90bq2aIzopLQv
	 NbcqlOsIXrl9bykVsSklaIRkE3AdK2tJI1VCghDk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgEDHDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 03:03:05 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35684 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEDHDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 03:03:05 -0400
Received: by mail-wr1-f66.google.com with SMTP id x18so19562674wrq.2;
        Mon, 04 May 2020 00:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jjVK3IGY3lofxgky6MANKIlS/RTE1msGdHN8C79gtRA=;
        b=cDu0EMjdG1BtJjN4HCuS28n3gPTbwkKPK2RIj58kca605qvsMMTY4BhGtTPA9FtIxm
         QYR/YtS5LXlmfivcxJtqOHFnt3i1k8LRh+M5GepZRjjfuaP+1oGi6OssYo92axHFW5AI
         lFC1lN7Bxm88uKyP5duSTRs+jD5sH2aYy7/0B5aRHGPONd+ekGOOuMRZN6OrCPPgwUm3
         KQWl2n1kOzEk88zM2Q/9ls7e1f9RyIwyu7Yu6FPC0tBpWXc90M+59+23ZYQoj0GoyqnC
         ZY2fZLv+76ZFwOMKmniaweuN3p1MB/pqqdD3NR016jHpGL4uIIt/vAb0dbSyEImbGpD1
         CObQ==
X-Gm-Message-State: AGi0PubQOFyxWr5BSJjJtKmkJDzyvUuFSOwwYOFvK0hsaKFfrPLtEXJF
        eBFZTsbnbsKoQLECDYTYdQs=
X-Google-Smtp-Source: APiQypL1DoXx6w0TGJSBvgI/zBJ2RIwW2P/T7NsRocZrPXDloYOn7lqwJM5NQOxDkI/4wpi4dbdQkg==
X-Received: by 2002:adf:f40b:: with SMTP id g11mr18764892wro.178.1588575783322;
        Mon, 04 May 2020 00:03:03 -0700 (PDT)
Received: from localhost (ip-37-188-183-9.eurotel.cz. [37.188.183.9])
        by smtp.gmail.com with ESMTPSA id r3sm18434951wrx.72.2020.05.04.00.03.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 00:03:02 -0700 (PDT)
Date:   Mon, 4 May 2020 09:03:01 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200504070301.GC22838@dhcp22.suse.cz>
References: <20200430182712.237526-1-shakeelb@google.com>
 <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbC4WY00yQ46b8CFqVQ3S=JSJxE2HR00TtMqXOWLRPRZ8w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 01-05-20 09:39:24, Yafang Shao wrote:
> On Fri, May 1, 2020 at 2:27 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > Lowering memory.max can trigger an oom-kill if the reclaim does not
> > succeed. However if oom-killer does not find a process for killing, it
> > dumps a lot of warnings.
> >
> 
> I have been confused by this behavior for several months and I think
> it will confuse more memcg users.

Could you be more specific what has caused the confusion?

> We should keep the memcg oom behavior consistent with system oom - no
> oom kill if no process.

This is not the global mmemcg behavior. We do complain loud on no
eligible tasks and actually panic the system. Memcg cannot simply
do the same by default for obvious reasons.

> What about bellow change ?
>
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index e28098e13f1c..25fbc37a747f 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -6086,6 +6086,9 @@ static ssize_t memory_max_write(struct
> kernfs_open_file *of,
>                         continue;
>                 }
> 
> +               if (!cgroup_is_populated(memcg->css.cgroup))
> +                       break;
> +
>                 memcg_memory_event(memcg, MEMCG_OOM);
>                 if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
>                         break;

I am not a great fan to be honest. The warning might be useful for other
usecases when it is not clear that the memcg is empty.

-- 
Michal Hocko
SUSE Labs
