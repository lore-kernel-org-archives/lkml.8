Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87EBDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FA732177B
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:11:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727950AbgHXPL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:11:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:39302 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbgHXPKw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:10:52 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E3AABAB8B;
        Mon, 24 Aug 2020 15:11:17 +0000 (UTC)
Date:   Mon, 24 Aug 2020 17:10:45 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>, akpm@linux-foundation.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org
Subject: Re: [Resend PATCH 1/6] mm/memcg: warning on !memcg after readahead
 page charged
Message-ID: <20200824151045.GC3415@dhcp22.suse.cz>
References: <1597144232-11370-1-git-send-email-alex.shi@linux.alibaba.com>
 <20200820145850.GA4622@lca.pw>
 <20200824145201.GB4337@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824145201.GB4337@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 24-08-20 10:52:02, Qian Cai wrote:
> On Thu, Aug 20, 2020 at 10:58:50AM -0400, Qian Cai wrote:
> > On Tue, Aug 11, 2020 at 07:10:27PM +0800, Alex Shi wrote:
> > > Since readahead page is charged on memcg too, in theory we don't have to
> > > check this exception now. Before safely remove them all, add a warning
> > > for the unexpected !memcg.
> > > 
> > > Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
> > > Acked-by: Michal Hocko <mhocko@suse.com>
> > 
> > This will trigger,
> 
> Andrew, Stephen, can you drop this series for now? I did manage to trigger this
> warning on all arches, powerpc, x86 and arm64 (below).

Yes, I do agree. See http://lkml.kernel.org/r/20200824151013.GB3415@dhcp22.suse.cz
-- 
Michal Hocko
SUSE Labs
