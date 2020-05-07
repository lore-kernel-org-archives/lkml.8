Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D885C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A7E620A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEGR2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:28:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726222AbgEGR2a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:28:30 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A01E6216FD;
        Thu,  7 May 2020 17:28:29 +0000 (UTC)
Date:   Thu, 7 May 2020 13:28:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
Message-ID: <20200507132828.1af39b80@gandalf.local.home>
In-Reply-To: <jhjpnbg6lkf.mognet@arm.com>
References: <20200507110625.37254-1-yanaijie@huawei.com>
        <jhjpnbg6lkf.mognet@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 07 May 2020 12:17:36 +0100
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 07/05/20 12:06, Jason Yan wrote:
> > Fix the following coccicheck warning:
> >
> > kernel/sched/fair.c:9375:9-10: WARNING: return of 0/1 in function
> > 'voluntary_active_balance' with return type bool
> >  
> 
> It's perfectly safe to return 0/1 in a boolean function; that said seeing
> as this is the second attempt at "fixing" this I'm tempted to say we should
> pick it up...
> 

Actually, I disagree. We should push back on the check to not warn on 0/1
of boolean. Why is this a warning?

Fixes like this just add noise to the git history.

-- Steve
