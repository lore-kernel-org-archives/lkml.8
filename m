Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E63C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 424172245C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgHCPHH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:07:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:50020 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726276AbgHCPHH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:07:07 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C6737AB3E;
        Mon,  3 Aug 2020 15:07:20 +0000 (UTC)
Date:   Mon, 3 Aug 2020 17:07:04 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        mgorman@techsingularity.net, tj@kernel.org,
        khlebnikov@yandex-team.ru, daniel.m.jordan@oracle.com,
        yang.shi@linux.alibaba.com, willy@infradead.org,
        hannes@cmpxchg.org, lkp@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        shakeelb@google.com, iamjoonsoo.kim@lge.com,
        richard.weiyang@gmail.com, kirill@shutemov.name,
        alexander.duyck@gmail.com, rong.a.chen@intel.com
Subject: Re: [PATCH v17 00/21] per memcg lru lock
Message-ID: <20200803150704.GV5174@dhcp22.suse.cz>
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <49d4f3bf-ccce-3c97-3a4c-f5cefe2d623a@linux.alibaba.com>
 <c00ac587-7f69-768a-84ea-53cbf7469ae9@linux.alibaba.com>
 <alpine.LSU.2.11.2007291105570.4649@eggly.anvils>
 <08c8797d-1935-7b41-b8db-d22f054912ac@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <08c8797d-1935-7b41-b8db-d22f054912ac@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-07-20 10:16:13, Alex Shi wrote:
> 
> 
> 在 2020/7/30 上午2:06, Hugh Dickins 写道:
> > On Wed, 29 Jul 2020, Alex Shi wrote:
> >>
> >> Is there any comments or suggestion for this patchset?
> >> Any hints will be very appreciated.
> > 
> > Alex: it is now v5.8-rc7, obviously too late for this patchset to make
> > v5.9, so I'm currently concentrated on checking some patches headed for
> > v5.9 (and some bugfix patches of my own that I don't get time to send):
> > I'll get back to responding on lru_lock in a week or two's time.
> 
> Hi Hugh,
> 
> Thanks a lot for response! It's fine to wait longer.
> But thing would be more efficient if review get concentrated...
> I am still too new in mm area.

I am sorry and owe you a review but it is hard to find time for that.
This is a large change and the review will be really far from trivial.
If this version is mostly stable then I would recommend not posting new
versions and simply remind people you expect the review from by a
targeted ping.
-- 
Michal Hocko
SUSE Labs
