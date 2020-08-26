Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F13C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:26:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46B2C214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 13:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgHZN00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 09:26:26 -0400
Received: from mx2.suse.de ([195.135.220.15]:48106 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728625AbgHZN0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 09:26:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9535AED6;
        Wed, 26 Aug 2020 13:26:52 +0000 (UTC)
Date:   Wed, 26 Aug 2020 15:26:20 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     xunlei <xlpang@linux.alibaba.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm: memcg: Fix memcg reclaim soft lockup
Message-ID: <20200826132620.GR22869@dhcp22.suse.cz>
References: <1598426822-93737-1-git-send-email-xlpang@linux.alibaba.com>
 <20200826081102.GM22869@dhcp22.suse.cz>
 <99efed0e-050a-e313-46ab-8fe6228839d5@linux.alibaba.com>
 <20200826110015.GO22869@dhcp22.suse.cz>
 <f0122b2d-4740-2caf-3c4f-009a513426e3@linux.alibaba.com>
 <20200826120740.GP22869@dhcp22.suse.cz>
 <19eb48db-7d5e-0f55-5dfc-6a71274fd896@linux.alibaba.com>
 <20200826124810.GQ22869@dhcp22.suse.cz>
 <061e8600-e162-6ac9-2f4f-bf161435a5b2@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061e8600-e162-6ac9-2f4f-bf161435a5b2@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 26-08-20 21:16:28, xunlei wrote:
[...]
> oom_reaper also can't get scheduled because of 1-cpu, and the mutex
> uses might_sleep() which is noop in case of "CONFIG_PREEMPT_VOLUNTARY is
> not set" I mentioned in the commit log.

OK, I see. I have clearly missed the 1cpu configuration. Sorry about
that.

Thanks for bearing with me.
-- 
Michal Hocko
SUSE Labs
