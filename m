Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF4BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9665A20786
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 12:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729775AbgHZMIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 08:08:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:47662 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729460AbgHZMHl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 08:07:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 37BC4AF2F;
        Wed, 26 Aug 2020 12:08:12 +0000 (UTC)
Date:   Wed, 26 Aug 2020 14:07:40 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     xunlei <xlpang@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
Message-ID: <20200826120740.GP22869@dhcp22.suse.cz>
References: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826081102.GM22869@dhcp22.suse.cz>
 <99efed0e-050a-e313-46ab-8fe6228839d5@linux.alibaba.com>
 <20200826110015.GO22869@dhcp22.suse.cz>
 <f0122b2d-4740-2caf-3c4f-009a513426e3@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f0122b2d-4740-2caf-3c4f-009a513426e3@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-08-20 20:00:47, xunlei wrote:
> On 2020/8/26 下午7:00, Michal Hocko wrote:
> > On Wed 26-08-20 18:41:18, xunlei wrote:
> >> On 2020/8/26 下午4:11, Michal Hocko wrote:
> >>> On Wed 26-08-20 15:27:02, Xunlei Pang wrote:
> >>>> We've met softlockup with "CONFIG_PREEMPT_NONE=y", when
> >>>> the target memcg doesn't have any reclaimable memory.
> >>>
> >>> Do you have any scenario when this happens or is this some sort of a
> >>> test case?
> >>
> >> It can happen on tiny guest scenarios.
> > 
> > OK, you made me more curious. If this is a tiny guest and this is a hard
> > limit reclaim path then we should trigger an oom killer which should
> > kill the offender and that in turn bail out from the try_charge lopp
> > (see should_force_charge). So how come this repeats enough in your setup
> > that it causes soft lockups?
> > 
> 
> should_force_charge() is false, the current trapped in endless loop is
> not the oom victim.

How is that possible? If the oom killer kills a task and that doesn't
resolve the oom situation then it would go after another one until all
tasks are killed. Or is your task living outside of the memcg it tries
to charge?

-- 
Michal Hocko
SUSE Labs
