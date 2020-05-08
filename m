Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A064C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:24:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F79C208CA
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 09:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEHJYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 05:24:54 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:16648 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725710AbgEHJYy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 05:24:54 -0400
X-IronPort-AV: E=Sophos;i="5.73,367,1583190000"; 
   d="scan'208";a="448801829"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 May 2020 11:24:30 +0200
Date:   Fri, 8 May 2020 11:24:30 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org,
        linux@rasmusvillemoes.dk, Julia.Lawall@lip6.fr
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
In-Reply-To: <20200508081629.GN5298@hirez.programming.kicks-ass.net>
Message-ID: <alpine.DEB.2.21.2005081120510.5307@hadrien>
References: <20200507110625.37254-1-yanaijie@huawei.com> <20200508081629.GN5298@hirez.programming.kicks-ass.net>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 May 2020, Peter Zijlstra wrote:

> On Thu, May 07, 2020 at 07:06:25PM +0800, Jason Yan wrote:
> > Fix the following coccicheck warning:
> >
> > kernel/sched/fair.c:9375:9-10: WARNING: return of 0/1 in function
> > 'voluntary_active_balance' with return type bool
>
> That's not a warning, that's a broken cocinelle script, which if these
> stupid patches don't stop, I'm going to delete myself!

Peter,

If you don't like the script, please feel free to delete it.

Currently, no one is really maintaining (ie pushing patches to Linus) the
scripts directory.  Masahiro Yamada was doing it but has expressed several
times that he doesn't want to.  I got a kernel.org account, but clearly
haven't had time to figure out how to use it appropriately.  But simply
deleting a file is simple and risk free, so if you want to make the
change please go ahead.

julia
