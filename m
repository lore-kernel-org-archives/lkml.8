Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D592C11D05
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CA5A2068F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 14:42:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdAg/woS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgBTOm5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 09:42:57 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38169 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728051AbgBTOm4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 09:42:56 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so975728pjz.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 06:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RxnSL1NXcKi7I7bNcJCdW9on2O0BYdTsZJtPIT2pvYw=;
        b=KdAg/woSNMrUJKRcLFFlI+Q+hVITLMcpG7XScyuKG/rch8DT0ixv0D566k0F6Otle5
         cwUJ9HRiFzGxwadC2OGhYKlbi8DY37VVlVByUznCM/ePQqloA5GZa8o7dH6LoSlCXELI
         xHiS0Znal9Y94kgjTYg3T4vhf7VfZdwXuuPNSPTmiXi4+qhzVsVlHLDZkmlgCghwM4Qa
         v/WrYtjYP4COBB8qs8urercROMOjnOGNsoVyT/j5NP0Fb21SDV41DG9fE+HNMOMetTAQ
         XgnS9s+qEWkZbksqv0i8KVXCGOJjkUmEpAupdro45WGRn4iCF6kChpGXyfcBCSocK02A
         s3bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RxnSL1NXcKi7I7bNcJCdW9on2O0BYdTsZJtPIT2pvYw=;
        b=HmNyh+r24fZ9RSh8WlBS40g+zFzZrQ2IUYJn+iJbq4RbLPchNGuf8kH1qBj0hpHxcg
         sJqOgrk1635PLppXaDsWYLI7pNPv+tnw+nBWaSTzwpsQI43Se3ggktQdxVNoUmQsCvug
         zPkiT0teiRoRVtVgDJaL+x+zQRt3FCHii+3TImZkww9BYryoNd529W8w/LtVNh9wTkiw
         50K+MONTFqxt48EYvKSDma22TsCFUYcRz3Ahdsokrr7zwqqUTD8+OCrecjyEKUrss4B/
         voDDd2EDGIbOrGuNL8GtGTAMnSzOIqBTMWOhLKlRtRSHtlHEnN3c9YSM9BabB6vVUXN2
         g9EA==
X-Gm-Message-State: APjAAAVSTf32Quh+NFLzHUPLnB0+1kaluaypx4EpQo7oHmSQwpUdvHP7
        i3Onc+FpB03/Ph+bwfTnJlw=
X-Google-Smtp-Source: APXvYqz3wBILWTKaw7OWLHGCjDgI2EKdZTlM2RKtM4tMDi6g9DoPS8Zonk8MclzuCyaioif8icLXpA==
X-Received: by 2002:a17:90a:a385:: with SMTP id x5mr4099539pjp.102.1582209774753;
        Thu, 20 Feb 2020 06:42:54 -0800 (PST)
Received: from localhost ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id b5sm3770299pfb.179.2020.02.20.06.42.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 20 Feb 2020 06:42:54 -0800 (PST)
Date:   Thu, 20 Feb 2020 22:42:51 +0800
From:   chenqiwu <qiwuchen55@gmail.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chenqiwu <chenqiwu@xiaomi.com>
Subject: Re: [PATCH] sched/fair: add !se->on_rq check before dequeue entity
Message-ID: <20200220144251.GA15604@cqw-OptiPlex-7050>
References: <1582183784-13502-1-git-send-email-qiwuchen55@gmail.com>
 <CAKfTPtDzb9XD5wrMhcvGn+dz27nh58taDrdp36YHKNusp739Og@mail.gmail.com>
 <20200220100915.GA14721@cqw-OptiPlex-7050>
 <CAKfTPtCm-Vn1YAC8j-XFLritQxQ-B7d=pqO9U6=c2vCuTNUpsg@mail.gmail.com>
 <CAKfTPtBS=HhBvp2ps1SZXc--WoXO_ZOY=+5o7RJ9vDgi9eLAqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtBS=HhBvp2ps1SZXc--WoXO_ZOY=+5o7RJ9vDgi9eLAqA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Hmm i have been too quick in my reply. I wanted to say:
> AFAICT, there is no other way to dequeue a task from a cfs_rq for
> which the group entity is not enqueued

But we should notice the potential racy pathes called by deactivate_task().
For example:
One path is dequeue a task from its cfs_rq called by schedule():
__schedule
	deactivate_task
		dequeue_task
			dequeue_task_fair

Another path is trying to migrate the same task to a CPU on the preferred node:
numa_migrate_preferred
	task_numa_migrate	
		migrate_swap
			stop_two_cpus
				migrate_swap_stop
					__migrate_swap_task
						deactivate_task
							dequeue_task_fair

There could be a racy if the task is dequeued form its cfs_rq in parallel.
