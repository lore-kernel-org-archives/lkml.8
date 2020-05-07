Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B50CBC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CD6820643
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:52:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgEGRwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:52:11 -0400
Received: from foss.arm.com ([217.140.110.172]:36626 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726863AbgEGRwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:52:11 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5AF730E;
        Thu,  7 May 2020 10:52:10 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 91C913F305;
        Thu,  7 May 2020 10:52:09 -0700 (PDT)
References: <20200507110625.37254-1-yanaijie@huawei.com> <jhjpnbg6lkf.mognet@arm.com> <20200507132828.1af39b80@gandalf.local.home> <20200507133024.18dbe349@gandalf.local.home>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Jason Yan <yanaijie@huawei.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: Return true,false in voluntary_active_balance()
In-reply-to: <20200507133024.18dbe349@gandalf.local.home>
Date:   Thu, 07 May 2020 18:52:03 +0100
Message-ID: <jhjimh7tyyk.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 07/05/20 18:30, Steven Rostedt wrote:
> On Thu, 7 May 2020 13:28:28 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
>> > It's perfectly safe to return 0/1 in a boolean function; that said seeing
>> > as this is the second attempt at "fixing" this I'm tempted to say we should
>> > pick it up...
>> >
>>
>> Actually, I disagree. We should push back on the check to not warn on 0/1
>> of boolean. Why is this a warning?
>
> If anything, we can teach people to try to understand their fixes, to see
> if something is really a fix or not. Blindly accepting changes like this,
> is no different than blindly submitting patches because some tool says its
> an issue.
>

I don't disagree. To play devil's advocate, AFAICT that one coccinelle script
is part of the kernel tree, so some folks may think it worth to reduce the
warnings we get from those.

To give my side of things, this one felt a bit like the
"s/borked/broken/" patches that folks send out because they have a
spellcheck linter, i.e. the change is purely cosmetic. But yeah, I suppose
less gunk to go through via git blame is preferable.

> -- Steve
