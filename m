Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCD3C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:08:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4789420736
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 10:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgEIKIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 06:08:39 -0400
Received: from foss.arm.com ([217.140.110.172]:58258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgEIKIj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 06:08:39 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C5C41FB;
        Sat,  9 May 2020 03:08:38 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85CAD3F71F;
        Sat,  9 May 2020 03:08:37 -0700 (PDT)
Date:   Sat, 9 May 2020 10:44:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: Kmemleak infrastructure improvement for task_struct leaks and
 call_rcu()
Message-ID: <20200509094455.GA4351@gaia>
References: <20200507171607.GD3180@gaia>
 <40B2408F-05DD-4A82-BF97-372EA09FA873@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40B2408F-05DD-4A82-BF97-372EA09FA873@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 07, 2020 at 01:29:04PM -0400, Qian Cai wrote:
> On May 7, 2020, at 1:16 PM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > I don't mind adding additional tracking info if it helps with debugging.
> > But if it's for improving false positives, I'd prefer to look deeper
> > into figure out why the pointer reference graph tracking failed.
> 
> No, the task struct leaks are real leaks. It is just painful to figure
> out the missing or misplaced put_task_struct() from the kmemleak
> reports at the moment.

We could log the callers to get_task_struct() and put_task_struct(),
something like __builtin_return_address(0) (how does this work if the
function is inlined?). If it's not the full backtrace, it shouldn't slow
down kmemleak considerably. I don't think it's worth logging only the
first/last calls to get/put. You'd hope that put is called in reverse
order to get.

I think it may be better if this is added as a new allocation pointed to
from kmemleak_object rather than increasing this structure since it will
be added on a case by case basis. When dumping the leak information, it
would also dump the get/put calls, in the order they were called. We
could add some simple refcount tracking (++ for get, -- for put) to
easily notice any imbalance.

I'm pretty busy next week but happy to review if you have a patch ;).

-- 
Catalin
