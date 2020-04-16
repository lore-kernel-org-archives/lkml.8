Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5695DC2BA19
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DD862078B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 00:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="wlTvb45C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391003AbgDPACq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730983AbgDPACm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 20:02:42 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5876C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:02:38 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l78so3880117qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 17:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X6Mgw1nun/Uy4a+IPSrxBx2LY1+xrpHKaA4zi6L+JLQ=;
        b=wlTvb45CffggOZUiA2YX0BJzHY0Y+vT7fwA78EoFTbc+3f3+3rLQ2AY2kK4MYR8RyD
         UmqAsBbarIU+pg4GnT71VBsriKivmOVDIEKHlMC0mbvNIR7SLexkeg+kBIkULlDxAJTr
         ghuksWcv8gH4N/nKbtuy1gLDp2Qf0MCNRQy4o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X6Mgw1nun/Uy4a+IPSrxBx2LY1+xrpHKaA4zi6L+JLQ=;
        b=QMDwR/NsKsa1ehrrUWXsGUT4i6faf7YzEnOc0qSPe7izmxbGvBhV1fwAeLzqdgBQX0
         Zh91GXrzo/fxkk5qS5Fj4u/i1+TyKMRJACzkw+TWD/CAF6p3bGx0jIVjuQ8hSeGwoLZy
         wTB/OyykXwxkl4Cv3z6UIoA8Pgsg3jE9wtga8heyRUERL0PbFxjeHObZ1Ub9Mxqh8fLt
         6jK37l7hY2ILwQ+dlhPxHGCFKZUpSvwJT25e0d8BOUmWaenVI2I8afDi/WGJQAiBwZzP
         aZDLIUsrWhAy6XRN2ASq2G3Ew9PzSj73JjOvvYhHdb7fvQn3wkkTaRWbFL11JxNKpskg
         cmoQ==
X-Gm-Message-State: AGi0PuY3XQyQ9f8m5buC71XtUHy00NJTo3+4DQ6xR22mpLIkFftrbjZX
        IwNiDijrAXicK7YjMvDC8pxyBA==
X-Google-Smtp-Source: APiQypIbxc8jo4K13VEY2oIrO9aS6ndUQFg674L5mw7lqTQJWvJmBKuHi5gEAokl3owq+1tfBgo7Jw==
X-Received: by 2002:a37:5004:: with SMTP id e4mr28829285qkb.18.1586995357890;
        Wed, 15 Apr 2020 17:02:37 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id x55sm4705228qtk.3.2020.04.15.17.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:02:36 -0700 (PDT)
Date:   Wed, 15 Apr 2020 20:02:35 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
Message-ID: <20200416000235.GA211099@google.com>
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <20190905111346.2w6kuqrdvaqvgilu@e107158-lin.cambridge.arm.com>
 <20190905113002.GK2349@hirez.programming.kicks-ass.net>
 <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190905114725.ehi5ea6qg3rychlz@e107158-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 05, 2019 at 12:47:26PM +0100, Qais Yousef wrote:
> On 09/05/19 13:30, Peter Zijlstra wrote:
> > On Thu, Sep 05, 2019 at 12:13:47PM +0100, Qais Yousef wrote:
> > > On 09/05/19 12:46, Peter Zijlstra wrote:
> > 
> > > > This is important because we want to be able to bias towards less
> > > > importance to (tail) latency as well as more importantance to (tail)
> > > > latency.
> > > > 
> > > > Specifically, Oracle wants to sacrifice (some) latency for throughput.
> > > > Facebook OTOH seems to want to sacrifice (some) throughput for latency.
> > > 
> > > Another use case I'm considering is using latency-nice to prefer an idle CPU if
> > > latency-nice is set otherwise go for the most energy efficient CPU.
> > > 
> > > Ie: sacrifice (some) energy for latency.
> > > 
> > > The way I see interpreting latency-nice here as a binary switch. But
> > > maybe we can use the range to select what (some) energy to sacrifice
> > > mean here. Hmmm.
> > 
> > It cannot be binary, per definition is must be ternary, that is, <0, ==0
> > and >0 (or middle value if you're of that persuasion).
> 
> I meant I want to use it as a binary.
> 
> > 
> > In your case, I'm thinking you mean >0, we want to lower the latency.
> 
> Yes. As long as there's an easy way to say: does this task care about latency
> or not I'm good.

Qais, Peter, all,

For ChromeOS (my team), we are planning to use the upstream uclamp mechanism
instead of the out-of-tree schedtune mechanism to provide EAS with the
latency-sensitivity (binary/ternary) hint. ChromeOS is thankfully quite a bit
upstream focussed :)

However, uclamp is missing an attribute to provide this biasing to EAS as we
know.

What was the consensus on adding a per-task attribute to uclamp for providing
this? Happy to collaborate on this front.

thanks,

 - Joel


> > Anyway; there were a number of things mentioned at OSPM that we could
> > tie into this thing and finding sensible mappings is going to be a bit
> > of trial and error I suppose.
> > 
> > But as patrick said; we're very much exporting a BIAS knob, not a set of
> > behaviours.
> 
> Agreed. I just wanted to say that the way this range is going to be
> interpreted will differ from path to path and we need to consider that in the
> final mapping. Especially from the final user's perspective of what setting
> this value ultimately means to them.
> 
> --
> Qais Yousef
