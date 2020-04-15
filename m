Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA1A3C2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6BE320784
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 04:08:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JOOYZSN7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDOEIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 00:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725294AbgDOEH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 00:07:56 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23F7C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:07:56 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t16so773364plo.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 21:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P/x4L+SeT8ElE32bCzooXY6c+8iN2r/PRC+OApz3e6s=;
        b=JOOYZSN7byQHG9TgGjwZn5q5vbOmSD6V3sXgzmFVPLnu1wlA1zQcTNYdVeYBQn0L+U
         g33RgjQI5GbDeuJcyf1Seo2YgdtYJcEs+69kk2yhgYosx1/E4fW5hxleOKPJylRT7Vbn
         keMerWSGs2+etHHPUxXfvy9Gx3LcE0TTre/HKE3lFSnb6bWu5B2flPQe+/ys8h6WUxDP
         APnQuvup5PvMOMPUvkfOtvBoVI2IrdWUaTe8zEb8w+694Pkyd9PAWVkTXwYgu0/IRL7d
         j3gDN3LVS73nSqe3+NSJ+iDAwFWlmEvygCuPa3ukCqjeajGhS6ZPmS6JBVg357fwdumG
         S7Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P/x4L+SeT8ElE32bCzooXY6c+8iN2r/PRC+OApz3e6s=;
        b=ugoDB8JBGdi4SN6acTViZJUJiRVyczOyaUONWJiAPoxwmyNJ7OWDRjCErf87f4Kjln
         sRfu99mx7aMLDJKbUANj1gyuLhQiiVYTwvL6Fzvt2pn63GfkaNGWZ2skycqrHEN/CYAp
         7UHDyg5u18EmpSelaMhNjdnhNZlQYJ3CcC67EuqVBd3FoaEM/7yhzaPTYlqPy/rOcBqj
         UMsVDxi9VTKO8hvxzCTpHR4lJtxk/MxQRX3XyTWwnNdpXogaNxYRPg7kDnPc0OyxWqSR
         L2f5xT1VUrH6CVM0wKOoiu2I8Jy+AYpqPMdbCrgknwcz3AWxnggFbQoAOuO3EXTxuEWB
         U8nw==
X-Gm-Message-State: AGi0PuYlhqyrRKzEd2mJY7sUt/QEvUabvC1r95iBjwObsXd95Xdexr3E
        ZF+hbnkKhQMV2hZHZbD6w3c=
X-Google-Smtp-Source: APiQypI+Lrr+0zV7t4mHNigKi7EkiNGkJnZcywNjAJh/q2aMQR39DTWKaN8V4xwud7k2Pi1MSZapFQ==
X-Received: by 2002:a17:90a:9742:: with SMTP id i2mr4053877pjw.194.1586923676115;
        Tue, 14 Apr 2020 21:07:56 -0700 (PDT)
Received: from ziqianlu-desktop.localdomain ([47.89.83.64])
        by smtp.gmail.com with ESMTPSA id c125sm12338540pfa.142.2020.04.14.21.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 21:07:55 -0700 (PDT)
Date:   Wed, 15 Apr 2020 12:07:41 +0800
From:   Aaron Lu <aaron.lwe@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Remanan Pillai <vpillai@digitalocean.com>
Cc:     Nishanth Aravamudan <naravamudan@digitalocean.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, mingo@kernel.org,
        tglx@linutronix.de, pjt@google.com, torvalds@linux-foundation.org,
        Aaron Lu <aaron.lu@linux.alibaba.com>,
        linux-kernel@vger.kernel.org, fweisbec@gmail.com,
        keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Aubrey Li <aubrey.intel@gmail.com>, aubrey.li@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Joel Fernandes <joelaf@google.com>, joel@joelfernandes.org
Subject: Re: [RFC PATCH 09/13] sched/fair: core wide vruntime comparison
Message-ID: <20200415040741.GA169001@ziqianlu-desktop.localdomain>
References: <cover.1583332764.git.vpillai@digitalocean.com>
 <2f83d888890cec14be3a7aead0859dceebb4012f.1583332765.git.vpillai@digitalocean.com>
 <20200414135624.GU20730@hirez.programming.kicks-ass.net>
 <20200415033408.GA168322@ziqianlu-desktop.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415033408.GA168322@ziqianlu-desktop.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:34:08AM +0800, Aaron Lu wrote:
> On Tue, Apr 14, 2020 at 03:56:24PM +0200, Peter Zijlstra wrote:
> > On Wed, Mar 04, 2020 at 04:59:59PM +0000, vpillai wrote:
> > > From: Aaron Lu <aaron.lu@linux.alibaba.com>
> > > 
> > > This patch provides a vruntime based way to compare two cfs task's
> > > priority, be it on the same cpu or different threads of the same core.
> > > 
> > > When the two tasks are on the same CPU, we just need to find a common
> > > cfs_rq both sched_entities are on and then do the comparison.
> > > 
> > > When the two tasks are on differen threads of the same core, the root
> > > level sched_entities to which the two tasks belong will be used to do
> > > the comparison.
> > > 
> > > An ugly illustration for the cross CPU case:
> > > 
> > >    cpu0         cpu1
> > >  /   |  \     /   |  \
> > > se1 se2 se3  se4 se5 se6
> > >     /  \            /   \
> > >   se21 se22       se61  se62
> > > 
> > > Assume CPU0 and CPU1 are smt siblings and task A's se is se21 while
> > > task B's se is se61. To compare priority of task A and B, we compare
> > > priority of se2 and se6. Whose vruntime is smaller, who wins.
> > > 
> > > To make this work, the root level se should have a common cfs_rq min
> > > vuntime, which I call it the core cfs_rq min vruntime.
> > > 
> > > When we adjust the min_vruntime of rq->core, we need to propgate
> > > that down the tree so as to not cause starvation of existing tasks
> > > based on previous vruntime.
> > 
> > You forgot the time complexity analysis.
> 
> This is a mistake and the adjust should be needed only once when core
> scheduling is initially enabled. It is an initialization thing and there
> is no reason to do it in every invocation of coresched_adjust_vruntime().

Correction...
I meant there is no need to call coresched_adjust_vruntime() in every
invocation of update_core_cfs_rq_min_vruntime().
