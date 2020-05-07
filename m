Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F11AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB86A20A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:55:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727993AbgEGRzi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:55:38 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:42220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726320AbgEGRzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:55:37 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 8625B180184E5;
        Thu,  7 May 2020 17:55:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: army02_139717869533e
X-Filterd-Recvd-Size: 2081
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu,  7 May 2020 17:55:34 +0000 (UTC)
Message-ID: <f0e6f50e910238366b1d8f398c91d3066baac7cf.camel@perches.com>
Subject: Re: [PATCH] sched/fair: Return true,false in
 voluntary_active_balance()
From:   Joe Perches <joe@perches.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Date:   Thu, 07 May 2020 10:55:33 -0700
In-Reply-To: <20200507133024.18dbe349@gandalf.local.home>
References: <20200507110625.37254-1-yanaijie@huawei.com>
         <jhjpnbg6lkf.mognet@arm.com> <20200507132828.1af39b80@gandalf.local.home>
         <20200507133024.18dbe349@gandalf.local.home>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-05-07 at 13:30 -0400, Steven Rostedt wrote:
> On Thu, 7 May 2020 13:28:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > It's perfectly safe to return 0/1 in a boolean function; that said seeing
> > > as this is the second attempt at "fixing" this I'm tempted to say we should
> > > pick it up...
> > >   
> > 
> > Actually, I disagree. We should push back on the check to not warn on 0/1
> > of boolean. Why is this a warning?
> 
> If anything, we can teach people to try to understand their fixes, to see
> if something is really a fix or not. Blindly accepting changes like this,
> is no different than blindly submitting patches because some tool says its
> an issue.

<shrug>

Most people seem to prefer bool returns with apparent bool constants
even though true and false are enumerator constants (int) of 1 and 0
in the kernel.

from include/linux/stddef.h:

enum {
	false	= 0,
	true	= 1
};


