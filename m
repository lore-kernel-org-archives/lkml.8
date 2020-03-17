Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FEFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2737420735
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 18:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584471335;
	bh=sQv/dl/JRKkaXRhQ3OdreZW1FOITzDaU/InTYBd94Uo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DqntlTXiMJN2jKDxDM/+DwAMUNnCtZgMI5ru3TcG341D9DoQTYwQI4gbxKfBqhUxa
	 u/paW1ydFuyg/Iu0S1lLJbBKbXtUDmfAqNG8sMKo8UlGggswcfCEPWVmj0N3DtaSAY
	 XFhvX4zTde8Jileygn46ZoHF9ipBRITnJXRGYRcE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726549AbgCQSze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 14:55:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39405 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726294AbgCQSzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 14:55:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id h6so6780739wrs.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 11:55:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kA35++hY6q6St63mCVJsFqLRQRhSP7DteenkrHTj+MA=;
        b=J9GaOjvCq8T2Z5VaXg6R/Jggna9a5ONeAc/cPw5FIFGasNjqP+CCLMkroRSr5daaKd
         8C2aXPm1w+lL1g5H4EciBBiPaiNotgEgislaVbi7qdOHqrW1QPznTI3zPl+c+xtn/1ak
         0EPWeGacGHmOTT7qytTWUYrjzj21tyraHBOhgP1bQHbDW4Da5c3O0cNVVGugXBw+VYDO
         KgrHpfwbchK2/UVExZLyk0bIObItYivsywyVsddOGZwLpIwEmv/Yq/qvc14GpkeCogV4
         Qi7lYdMAiNZWJjY1V54U/Mu5pO8kXcNfmydcY3VnaTOCD5jU9mYeI0TZ67GifGVcUI09
         k6DA==
X-Gm-Message-State: ANhLgQ2t5jGe1JdozQKxbYaQoIJNOg4c06EbYDSPJGSyXQR4tIQ5kNGp
        U8aux4lSCJpOHz46dpt7QHV1mpbc
X-Google-Smtp-Source: ADFU+vvHda6xA5nFihIzhCAXUiwMj6Pin5FtSn4qO67ev+GZKBdb4CtSolVRWVWnQ6uGx/8j2xdNdA==
X-Received: by 2002:adf:97d0:: with SMTP id t16mr412590wrb.343.1584471331555;
        Tue, 17 Mar 2020 11:55:31 -0700 (PDT)
Received: from localhost (ip-37-188-255-121.eurotel.cz. [37.188.255.121])
        by smtp.gmail.com with ESMTPSA id d15sm5702400wrp.37.2020.03.17.11.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2020 11:55:30 -0700 (PDT)
Date:   Tue, 17 Mar 2020 19:55:29 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: memcg: make memory.oom.group tolerable to task
 migration
Message-ID: <20200317185529.GV26018@dhcp22.suse.cz>
References: <20200316223510.3176148-1-guro@fb.com>
 <20200317075212.GC26018@dhcp22.suse.cz>
 <20200317183836.GA276471@carbon.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317183836.GA276471@carbon.DHCP.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 17-03-20 11:38:36, Roman Gushchin wrote:
> On Tue, Mar 17, 2020 at 08:52:12AM +0100, Michal Hocko wrote:
> > On Mon 16-03-20 15:35:10, Roman Gushchin wrote:
> > > If a task is getting moved out of the OOMing cgroup, it might
> > > result in unexpected OOM killings if memory.oom.group is used
> > > anywhere in the cgroup tree.
> > > 
> > > Imagine the following example:
> > > 
> > >           A (oom.group = 1)
> > >          / \
> > >   (OOM) B   C
> > > 
> > > Let's say B's memory.max is exceeded and it's OOMing. The OOM killer
> > > selects a task in B as a victim, but someone asynchronously moves
> > > the task into C.
> > 
> > I can see Reported-by here, does that mean that the race really happened
> > in real workloads? If yes, I would be really curious. Mostly because
> > moving tasks outside of the oom domain is quite questionable without
> > charge migration.
> 
> Yes, I've got a number of OOM messages where oom_cgroup != task_cgroup.
> The only reasonable explanation is that the task has been moved out after
> being selected as a victim. In my case it resulted in killing all tasks
> in A, and it what hurt the workload.

Is this an expected behavior of the workload or potentially a bug.
Because really, migrating outside of the oom domain is problematic
already. Essentially you are going to kill a wrong task if the largest
memory consumer is migrating before the oom killer manages to find the
task.

> > > mem_cgroup_get_oom_group() will iterate over all
> > > ancestors of C up to the root cgroup. In theory it had to stop
> > > at the oom_domain level - the memory cgroup which is OOMing.
> > > But because B is not an ancestor of C, it's not happening.
> > > Instead it chooses A (because it's oom.group is set), and kills
> > > all tasks in A. This behavior is wrong because the OOM happened in B,
> > > so there is no reason to kill anything outside.
> > > 
> > > Fix this by checking it the memory cgroup to which the task belongs
> > > is a descendant of the oom_domain. If not, memory.oom.group should
> > > be ignored, and the OOM killer should kill only the victim task.
> > 
> > I was about to suggest storing the memcg in oom_evaluate_task but then I
> > have realized that this would be both more complex and I am not yet
> > sure it would be better so much better after all.
> > 
> > The thing is that killing the selected task makes a lot of sense
> > because it was the largest consumer. No matter it has run away. On the
> > other hand if your B was oom.group = 1 then one could expect that any
> > OOM killer event in that group will result in the whole group tear
> > down. This is however a gray zone because we do emit MEMCG_OOM event but
> > MEMCG_OOM_KILL event will go to the victim's at-the-time memcg. So the
> > observer B could think that the oom was resolved without killing while
> > observer C would see a kill event without oom.
> 
> I agree. Killing the task outside of the OOMing cgroup is already strange.

Strange? Maybe but if you think about it, not that much in fact because
you are still killing a task that was in the memcg at the time of the
evaluation. Sure that largest task might not be the biggest contributor
to the charged memory - as mentioned above - but well, this is what you
ask for when migrating over oom domains.

> Should we somehow lock the OOMing cgroup? So that tasks can not escape
> and enter it until the finish of the OOM killing?

I do not think this is going to help all that much. Sure we can note the
memcg at the oom_evaluate_task and use it later for the group oom
handling. But races will always be there. Having oom path to depend on
locks used elsewhere is a can of worms. It would add a very hard to
evaluate dependences.

> It seems to be a better idea, because it will also make the oom.group
> killing less racy: currently a forking app can potentially escape from it.
> 
> And the we can put something like
> 	if (WARN_ON_ONCE(!mem_cgroup_is_descendant(memcg, oom_domain)))
> 		goto out;
> to mem_cgroup_get_oom_group?

This would be a user triggerable warning and that sounds like a bad idea
to me. We should just live with races. The only question I still do not
have a proper answer for is how much we do care. If we do not care all
that much about the original memcg then go with your patch. But if we
want to be slightly more careful then we should note the memcg in
oom_evaluate_task and use it when killing.

-- 
Michal Hocko
SUSE Labs
