Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45100C433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 120FA207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="oI+Xm2ET"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgH0WaF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726289AbgH0WaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:30:05 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9852C061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:30:04 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id s16so5989880qtn.7
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 15:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fJ9qJt6OX2+WeqcsogZiCHLA68aY3qughbK/gCdupAY=;
        b=oI+Xm2ETkWYOHEctXypXfT7xmzm3loPC9+zkZyJ1x8N7QeG6teMe1pDHazuXxRcTFY
         ZYxjJz39+DhuZnbhle0KciuXBsib5qGiX3vNJsVIhF8tE251m/BMEX7hxm8zamg0nunl
         SRsL7DL+qNDgmBpxdsibHt83qbee+fKlFWZ2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fJ9qJt6OX2+WeqcsogZiCHLA68aY3qughbK/gCdupAY=;
        b=H8w76H1xyee2xmqC9dt0L261fz3x2tbu5CeMbDiylOKUM7qMsaUK5ZtGicnLlkCdZR
         tjOCpWCr6bmMlFDck2fXhpUjvOchiLVR0S09gQ3ptwUAy42JZfwI7qJyFZ9Tdyh709xW
         aWOV1sJ4l/OBQAwUPdP+ZFqlQkciJpEJPEPEBEHAtrdBWcqeNLvkinGxApZ8klYjF39o
         KtNNhZ0zNpb64cPRgWGNxbVuhbRyXGBkSlEq96+4g2JdJCs44sasFwVz1fovIUwyGNzx
         51ELAxsd/Qn28vgsSQ3f9G/efqO2nTuJnylXqDr/NpJnShBG7qT4+eaxu1NxYVj31mXJ
         Oa2w==
X-Gm-Message-State: AOAM532j8Y7M64HlE19BCYZQYoCgD96fPMtvK5vn6gX8Cq/4tvxQNkRq
        ogljLgIXUSQumyxT6a6h8Vyjog==
X-Google-Smtp-Source: ABdhPJzknUmF89nKZjOODh71AjWBA600WSf08aGsbIH/xZS7FAnrQFFr6PUQfEuSfSii63BnCttvbg==
X-Received: by 2002:ac8:7698:: with SMTP id g24mr20968039qtr.217.1598567402879;
        Thu, 27 Aug 2020 15:30:02 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id w44sm3178673qtj.86.2020.08.27.15.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 15:30:02 -0700 (PDT)
Date:   Thu, 27 Aug 2020 18:30:01 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org, will@kernel.org,
        npiggin@gmail.com, elver@google.com, jgross@suse.com,
        paulmck@kernel.org, rostedt@goodmis.org, rjw@rjwysocki.net,
        svens@linux.ibm.com, tglx@linutronix.de,
        mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2 03/11] sched,idle,rcu: Push rcu_idle deeper into the
 idle path
Message-ID: <20200827223001.GA3821640@google.com>
References: <20200821084738.508092956@infradead.org>
 <20200821085348.310943801@infradead.org>
 <20200827011826.GA1942571@google.com>
 <20200827012419.GB1942571@google.com>
 <20200827074748.GY2674@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827074748.GY2674@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 09:47:48AM +0200, peterz@infradead.org wrote:
> On Wed, Aug 26, 2020 at 09:24:19PM -0400, Joel Fernandes wrote:
> > On Wed, Aug 26, 2020 at 09:18:26PM -0400, Joel Fernandes wrote:
> > > On Fri, Aug 21, 2020 at 10:47:41AM +0200, Peter Zijlstra wrote:
> > > > Lots of things take locks, due to a wee bug, rcu_lockdep didn't notice
> > > > that the locking tracepoints were using RCU.
> > > > 
> > > > Push rcu_idle_{enter,exit}() as deep as possible into the idle paths,
> > > > this also resolves a lot of _rcuidle()/RCU_NONIDLE() usage.
> > > > 
> > > > Specifically, sched_clock_idle_wakeup_event() will use ktime which
> > > > will use seqlocks which will tickle lockdep, and
> > > > stop_critical_timings() uses lock.
> > > 
> > > I was wondering if those tracepoints should just use _rcuidle variant of the
> > > trace call. But that's a terrible idea considering that would add unwanted
> > > overhead I think.
> > > 
> > > Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > 
> > BTW, if tracepoint is converted to use RCU-trace flavor, then these kinds of
> > issues go away, no? That RCU flavor is always watching.
> 
> All trace_*_rcuidle() and RCU_NONIDLE() usage is a bug IMO.
> 
> Ideally RCU-trace goes away too.

I was thinking that unless the rcu_idle_enter/exit calls coincide with points
in the kernel where instrumentation is not allowed, there is always a chance
somebody wants to use tracepoints after rcu_idle_enter or before exit. In
this case, trace_*_rcuidle() is unavoidable unless you can move the
rcu_idle_enter/exit calls deeper as you are doing.

Maybe objtool can help with that?

The other solution is RCU-trace if you can't push the rcu_idle_enter/exit
calls any deeper and still want to get rid of trace_*_rcuidle thingies. Me
and Mathieu were talking at LPC about tracepoint conversion to RCU-trace and
we can work on it if that's the right direction.

thanks,

 - Joel

