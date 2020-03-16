Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC669C18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEFFA20658
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584351118;
	bh=DxJdBm7JzgmwEdXyNYzruCyx/B+uGLyGyP2Jf9wSNDM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fG2NKlcyUo/9Hp6HDmvjamonPwgyRRQaxvYZrVcPs9pj+JDxZHmvRt8BfbecYBR0N
	 JtV+GDB+pwKmmd2wGXHLoWb5odTdAmJtl1J7vmhz9azbMasXqyIqeEVEgFGvuWAdlI
	 WYQkJQ/Ixd9tDwqRtPg2LUYakSDykshbq6KR602s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgCPJb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:31:57 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33079 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgCPJb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:31:57 -0400
Received: by mail-wm1-f66.google.com with SMTP id r7so12850974wmg.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:31:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ph+Lpxd0P8ykJk38qY3p4Me0iTKehJecocwBUyoICdw=;
        b=enpOwdSvWvEc2AC8JGVPJGx1IPYRVUlnRn3NS7TPXV7GSXN7eJFh8KTT7X93soOP50
         j42jkJdNapt4OEcvYZceibH8YMjRw9+eD+sgiwWBpfeGy3YVXfLWu1k4UXhaNM5dkprf
         NFZZy210TBLNSAQ0sJtrmhKHFV94C/rVJK39cIvzyJ29NEqn8lC+PqNGz8WkIlwviAZR
         5TsECY4hZfdYKVVeMBAxr+4ZluC+W9V845D5lzP+OO4gOkGb2xHR6mhkVwQLZAQbW/1A
         ySZa8tlkcZ5B8BGwL6I0ptgE2jqayHa+gLvySHccSF398VY7MAch9dcGfHbVM3z6xpw6
         8EoQ==
X-Gm-Message-State: ANhLgQ0OGSH+1hiWSXNxf0daKO4t7GnZUjZ9IGXVq6aDb9ZgrZe/alAy
        UftRdx0cazA2/N19PyB4kQ8=
X-Google-Smtp-Source: ADFU+vuzMY/bxgQVAYh9LRNLpKp+57RbLaL/bDaeNyCIhcyn7QrUEk5CpP5iqMFCd2M73sePPJWAyA==
X-Received: by 2002:a05:600c:2244:: with SMTP id a4mr25638104wmm.147.1584351114379;
        Mon, 16 Mar 2020 02:31:54 -0700 (PDT)
Received: from localhost (ip-37-188-254-25.eurotel.cz. [37.188.254.25])
        by smtp.gmail.com with ESMTPSA id d7sm20150724wrc.25.2020.03.16.02.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:31:53 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:31:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [patch] mm, oom: prevent soft lockup on memcg oom for UP systems
Message-ID: <20200316093152.GE11482@dhcp22.suse.cz>
References: <993e7783-60e9-ba03-b512-c829b9e833fd@i-love.sakura.ne.jp>
 <alpine.DEB.2.21.2003111513180.195367@chino.kir.corp.google.com>
 <202003120012.02C0CEUB043533@www262.sakura.ne.jp>
 <alpine.DEB.2.21.2003121101030.158939@chino.kir.corp.google.com>
 <20200312153238.c8d25ea6994b54a2c4d5ae1f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200312153238.c8d25ea6994b54a2c4d5ae1f@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 15:32:38, Andrew Morton wrote:
> On Thu, 12 Mar 2020 11:07:15 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
> 
> > On Thu, 12 Mar 2020, Tetsuo Handa wrote:
> > 
> > > > On Thu, 12 Mar 2020, Tetsuo Handa wrote:
> > > > > > If you have an alternate patch to try, we can test it.  But since this 
> > > > > > cond_resched() is needed anyway, I'm not sure it will change the result.
> > > > > 
> > > > > schedule_timeout_killable(1) is an alternate patch to try; I don't think
> > > > > that this cond_resched() is needed anyway.
> > > > > 
> > > > 
> > > > You are suggesting schedule_timeout_killable(1) in shrink_node_memcgs()?
> > > > 
> > > 
> > > Andrew Morton also mentioned whether cond_resched() in shrink_node_memcgs()
> > > is enough. But like you mentioned,
> > > 
> > 
> > It passes our testing because this is where the allocator is looping while 
> > the victim is trying to exit if only it could be scheduled.
> 
> What happens if the allocator has SCHED_FIFO?

The same thing as a SCHED_FIFO running in a tight loop in the userspace.

As long as a high priority context depends on a resource held by a low
priority task then we have a priority inversion problem and the page
allocator is no real exception here. But I do not see the allocator
is much different from any other code in the kernel. We do not add
random sleeps here and there to push a high priority FIFO or RT tasks
out of the execution context. We do cond_resched to help !PREEMPT
kernels but priority related issues are really out of scope of that
facility.
-- 
Michal Hocko
SUSE Labs
