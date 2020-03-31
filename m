Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC80C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:09:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A39F20838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 15:09:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="NiYS9jB1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730708AbgCaPJS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 11:09:18 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44255 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgCaPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:09:17 -0400
Received: by mail-qk1-f195.google.com with SMTP id j4so23272785qkc.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1I3V/oT2mqbiXfqRekZesope51/Mfc/oSX4BHUhE4J4=;
        b=NiYS9jB1Px4PsqvHN1UGdxUhc5aSF0dRIMU3OzkGIN2lsaRvtJNeeGS/lCoijGJD8c
         HUEvtIRZ4FM+K9NhlEOgcVyaM6o2slWFdcweJX+44idvOFod8i4WlkgkgdujA5HOJYYm
         S3ZN2CWBk+MB57dWvvkZaoL7JXthswf/sVWKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1I3V/oT2mqbiXfqRekZesope51/Mfc/oSX4BHUhE4J4=;
        b=GuLR79PIXtdvNsJGDfQsS6XE6EeLjlKnqHnVR4bP3CXSjYpD4FmdbRph+qMEV7K8Q0
         EYV8C8vJ4Va+7z9O8+W2z/Q8CBGuYgl7hliXASLdPXbkuLqRKnZ9Jr/LC2AK5GQ/eTsa
         7j+DzjkjgZ7PBFWXKuNNNrjssLXQcgCyCrkTP4XrPdCfF4Kn81fG8DWdYL3g/R5vX1v/
         e5nOC+T4PWxqicL6V69ffNzaK0lJudnDIqMGG1XLeqBTC9ofwuG/Nv9ip4VkhdRP+tiW
         Ztd6bblOSYbA84sKwGoS+rs8sfCJwaI2n3ZswVuFU5QLaEu8M/dtNnHnm1OjhMITqSts
         0+2w==
X-Gm-Message-State: ANhLgQ0DQOomv3yn7Qi+KHl0qNpN41glDNT2Yq0/qG+QUGbxegXZkDfD
        R+Xbt0zgLzLgIhuGhZ4Ib/uXs7XBvgo=
X-Google-Smtp-Source: ADFU+vvwg3fjNiVxq1OHVz/lt26BshlSMLdLRgOKuq1vbH2mIwdbY4yegCT9+EC0/Y4lx84auhOHAQ==
X-Received: by 2002:a37:a93:: with SMTP id 141mr5443291qkk.244.1585667352335;
        Tue, 31 Mar 2020 08:09:12 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id g6sm14323892qtc.31.2020.03.31.08.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 08:09:11 -0700 (PDT)
Date:   Tue, 31 Mar 2020 11:09:11 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Uladzislau Rezki <urezki@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        rcu@vger.kernel.org, willy@infradead.org, peterz@infradead.org,
        neilb@suse.com, vbabka@suse.cz, mgorman@suse.de,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH RFC] rcu/tree: Use GFP_MEMALLOC for alloc memory to free
 memory pattern
Message-ID: <20200331150911.GC236678@google.com>
References: <20200331131628.153118-1-joel@joelfernandes.org>
 <20200331140433.GA26498@pc636>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200331140433.GA26498@pc636>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 04:04:33PM +0200, Uladzislau Rezki wrote:
> On Tue, Mar 31, 2020 at 09:16:28AM -0400, Joel Fernandes (Google) wrote:
> > In kfree_rcu() headless implementation (where the caller need not pass
> > an rcu_head, but rather directly pass a pointer to an object), we have
> > a fall-back where we allocate a rcu_head wrapper for the caller (not the
> > common case). This brings the pattern of needing to allocate some memory
> > to free some memory.  Currently we use GFP_ATOMIC flag to try harder for
> > this allocation, however the GFP_MEMALLOC flag is more tailored to this
> > pattern. We need to try harder not only during atomic context, but also
> > during non-atomic context anyway. So use the GFP_MEMALLOC flag instead.
> > 
> > Also remove the __GFP_NOWARN flag simply because although we do have a
> > synchronize_rcu() fallback for absolutely worst case, we still would
> > like to not enter that path and atleast trigger a warning to the user.
> > 
> > Cc: linux-mm@kvack.org
> > Cc: rcu@vger.kernel.org
> > Cc: willy@infradead.org
> > Cc: peterz@infradead.org
> > Cc: neilb@suse.com
> > Cc: vbabka@suse.cz
> > Cc: mgorman@suse.de
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> > 
> > This patch is based on the (not yet upstream) code in:
> > git://git.kernel.org/pub/scm/linux/kernel/git/jfern/linux.git (branch rcu/kfree)
> > 
> > It is a follow-up to the posted series:
> > https://lore.kernel.org/lkml/20200330023248.164994-1-joel@joelfernandes.org/
> > 
> > 
> >  kernel/rcu/tree.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> > index 4be763355c9fb..965deefffdd58 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -3149,7 +3149,7 @@ static inline struct rcu_head *attach_rcu_head_to_object(void *obj)
> >  
> >  	if (!ptr)
> >  		ptr = kmalloc(sizeof(unsigned long *) +
> > -				sizeof(struct rcu_head), GFP_ATOMIC | __GFP_NOWARN);
> > +				sizeof(struct rcu_head), GFP_MEMALLOC);
> >  
> Hello, Joel
> 
> I have some questions regarding improving it, see below them:
> 
> Do you mean __GFP_MEMALLOC? Can that flag be used in atomic context?
> Actually we do allocate there under spin lock. Should be combined with
> GFP_ATOMIC | __GFP_MEMALLOC?

Yes, I mean __GFP_MEMALLOC. Sorry, the patch was just to show the idea and
marked as RFC.

Good point on the atomic aspect of this path, you are right we cannot sleep.
I believe the GFP_NOWAIT I mentioned in my last reply will take care of that?

> As for removing __GFP_NOWARN. Actually it is expectable that an
> allocation can fail, if so we follow last emergency case. You
> can see the trace but what would you do with that information?

Yes, the benefit of the trace/warning is that the user can switch to a
non-headless API and avoid the synchronize_rcu(), that would help them get
faster kfree_rcu() performance instead of having silent slowdowns.

It also tells us whether the headless API is worth it in the long run, I
think it is worth it because we will likely never hit the synchronize_rcu()
failsafe. But if we hit it a lot, at least it wont happen silently.

Paul was concerned about following scenario with hitting synchronize_rcu():
1. Consider a system under memory pressure.
2. Consider some other subsystem X depending on another system Y which uses
   kfree_rcu(). If Y doesn't complete the operation in time, X accumulates
   more memory.
3. Since kfree_rcu() on Y hits synchronize_rcu() a lot, it slows it down.
   This causes X to further allocate memory, further causing a chain
   reaction.
Paul, please correct me if I'm wrong.

thanks,

 - Joel

