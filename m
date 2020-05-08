Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2A5C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5B7207DD
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 12:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y4rGUFQc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEHMfI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726616AbgEHMfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 08:35:08 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181BCC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 05:35:08 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id fu13so4197834pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kreOYKVsIzAvkcbQdsTFY9ySc69oBnN2FD6hCydX61g=;
        b=Y4rGUFQcqxXiIDwR/XcZi4P4JsTupK4Q2qDAhNaWB+CtPyDJIIb+BB8PastI322cqi
         84+OQFdxHLvjq6CHPm3O5/UrTrKcOpUsNEl3Md18SVjUIMJ8+Q0tOO7vLsQ2oDKWLyzL
         HXxlbCliHLNAdnLXsLueMxjEvQjeKEGACqCg4YH5A0jtJ863WVr16sTgntez0q2aykR2
         AldsHUmv2dEMosy2UGBMyGdIyzq8O1oDXR30c7BIv6BRcJUXbQAR93rPafj/Lh7pU8rj
         cvSwfD9H1vAjGcKmkXy4HKyAGehNvgw44OnIzmSE8JY7isatMgGH9QfxUA7G95Kom7DH
         r0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kreOYKVsIzAvkcbQdsTFY9ySc69oBnN2FD6hCydX61g=;
        b=c0jBjctcGaws1SnU2RVf8EFOqwyC4I7Az4xZJbwSJ9MAhSv7pNrhUTa+Mxg+OZ5k6I
         PBLvH5xc3QQNWtSUHrXEDxOXZhhnZXAZ3WDreXL3eKw7RWDMy6fn/BTFl8ujFTUTjquo
         ziDqedUEbqdejsbpnCE95ZaGWn00uWmWuo5zBFMSwLljIrKGe+Y5kfI6isa/GFcJ8J9g
         mtCt0qjCJzeSm4D1sVSkdyuJ1VCwNPGIqRsKq2z2Xy/+jLoG3zDN4KsciJss2QU7ov2r
         tk4y1mjeMd3gQ5zZVHaw1WpxS/JE7NFfSazBc/DCS+9TmFH45155/7NCpz7FJW1PkKtf
         it5Q==
X-Gm-Message-State: AGi0PuaKfhyPDUWmamhC2MTvImp+Adcpj5XcYe+dylwTZYQkY+m/Jg9N
        VI52yyYskVD/7D6Dgg5EgNlQlXsPhoY=
X-Google-Smtp-Source: APiQypKqV3dq+hdRND1CsU/0vGtZOsRMqvCxNumbMDakeQHU39yq6+23AG3x9vDPebuovIU4kSj0oQ==
X-Received: by 2002:a17:90a:2709:: with SMTP id o9mr5499773pje.168.1588941307612;
        Fri, 08 May 2020 05:35:07 -0700 (PDT)
Received: from aaronlu-desktop ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id m3sm2329490pjs.17.2020.05.08.05.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 05:35:06 -0700 (PDT)
Date:   Fri, 8 May 2020 20:34:57 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vineeth Remanan Pillai <vpillai@digitalocean.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Turner <pjt@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kerr <kerrnel@google.com>, Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        "Li, Aubrey" <aubrey.li@linux.intel.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH updated v2] sched/fair: core wide cfs task priority
 comparison
Message-ID: <20200508123457.GA122180@aaronlu-desktop>
References: <20200415040741.GA169001@ziqianlu-desktop.localdomain>
 <CANaguZAXsjD=X-bB7dvQZ3FSqLioiZU=YREHH_7JqiFsZCTxHA@mail.gmail.com>
 <20200417094045.GA197704@ziqianlu-desktop.localdomain>
 <20200420080759.GA224731@ziqianlu-desktop.localdomain>
 <CANaguZDP3nyBdjLeeCZGoUoYk6Lf0HUv19N2Qxo4CpZfrjPZHA@mail.gmail.com>
 <20200421025131.GA227300@aaronlu-desktop>
 <20200424142443.GA263207@aaronlu-desktop>
 <20200506143506.GH5298@hirez.programming.kicks-ass.net>
 <20200508084419.GA120223@aaronlu-desktop>
 <20200508090925.GV5298@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508090925.GV5298@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 11:09:25AM +0200, Peter Zijlstra wrote:
> On Fri, May 08, 2020 at 04:44:19PM +0800, Aaron Lu wrote:
> > On Wed, May 06, 2020 at 04:35:06PM +0200, Peter Zijlstra wrote:
> 
> > > Aside from this being way to complicated for what it does -- you
> > > could've saved the min_vruntime for each rq and compared them with
> > > subtraction -- it is also terminally broken afaict.
> > >
> > > Consider any infeasible weight scenario. Take for instance two tasks,
> > > each bound to their respective sibling, one with weight 1 and one with
> > > weight 2. Then the lower weight task will run ahead of the higher weight
> > > task without bound.
> > 
> > I don't follow how this could happen. Even the lower weight task runs
> > first, after some time, the higher weight task will get its turn and
> > from then on, the higher weight task will get more chance to run(due to
> > its higher weight and thus, slower accumulation of vruntime).
> 
> That seems to assume they're mutually exclusive. In that case, as I
> argued, we only have a single runqueue and then yes it works. But if
> they're not exclusive, and can run concurrently, it comes apart.

Ah right, now I see what you mean. Sorry for misunderstanding.

And yes, that 'utterly destroys the concept of a shared time base' and
then bad things can happen:
1) two same tagged tasks(t1 and t2) running on two siblings, with t1's
   weight lower than t2's;
2) both tasks are cpu intensive;
3) over time, the lower weight task(t1)'s vruntime becomes bigger and
   bigger than t2's vruntime and the core wide min_vruntime is the
   same as t1's vruntime per this patch;
4) a new task enqueued on the same sibling as t1, if the new task has
   an incompatible tag, it will be starved by t2 because t2's vruntime
   is way smaller than the core wide min_vruntime.

With this said, I realized a workaround for the issue described above:
when the core went from 'compatible mode'(step 1-3) to 'incompatible
mode'(step 4), reset all root level sched entities' vruntime to be the
same as the core wide min_vruntime. After all, the core is transforming
from two runqueue mode to single runqueue mode... I think this can solve
the issue to some extent but I may miss other scenarios.

I'll also re-read your last email about the 'lag' idea.
