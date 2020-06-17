Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22AA7C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:39:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8077212CC
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 20:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592426392;
	bh=pK1mzARWf4Nl6s78YpjDTnD1PnO5Gw2Lb/zccvL5xXw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=uqauurswJHmcLNqosmlW9Bid1gnNsowNdihEbBl1d3POfvK4DM0pZHiHSWTRx/sAB
	 DFuq8O68pBbIVLrvQvNjLy7NffQvV75eGKcaUT1Mz6rKVT/UTFyJ2vfg5686A3N4CI
	 unXSoTdOJdA1SeIcAMg36DubL9gWOr1Hto5CRncM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFQUju (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 16:39:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:34410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726496AbgFQUju (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 16:39:50 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF3B021556;
        Wed, 17 Jun 2020 20:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592426390;
        bh=pK1mzARWf4Nl6s78YpjDTnD1PnO5Gw2Lb/zccvL5xXw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bOjainAh5Cxf1QrNOOlPABfTDAJGOovpKxQBQfOP3MHB7YSurlyAmejA1jz+tXzQC
         5dBCS6CG9UILiYPhhNez4ByufLV6+7RzhW65Bp7bDpVarw/ODUltGRCbBsMqCY72ti
         ujkLyz97dEx4fhHa/DtvMjDKgk0vMVzA5ADvycg4=
Date:   Wed, 17 Jun 2020 13:39:49 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Dennis Zhou <dennis@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>, <linux-mm@kvack.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [Potential Spoof] [PATCH v2 0/5] mm: memcg accounting of percpu
 memory
Message-Id: <20200617133949.148aff08300e24a084f9bb18@linux-foundation.org>
In-Reply-To: <20200616211728.GA7652@carbon.lan>
References: <20200608230819.832349-1-guro@fb.com>
        <20200616211728.GA7652@carbon.lan>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 14:19:01 -0700 Roman Gushchin <guro@fb.com> wrote:

> > 
> > This version is based on top of v6 of the new slab controller
> > patchset. The following patches are actually required by this series:
> >   mm: memcg: factor out memcg- and lruvec-level changes out of __mod_lruvec_state()
> >   mm: memcg: prepare for byte-sized vmstat items
> >   mm: memcg: convert vmstat slab counters to bytes
> >   mm: slub: implement SLUB version of obj_to_index()
> >   mm: memcontrol: decouple reference counting from page accounting
> >   mm: memcg/slab: obj_cgroup API
> 
> Hello, Andrew!
> 
> How this patchset should be routed: through the mm or percpu tree?
> 
> It has been acked by Dennis (the percpu maintainer), but it does depend
> on first several patches from the slab controller rework patchset.

I can grab both.

> The slab controller rework is ready to be merged: as in v6 most patches
> in the series were acked by Johannes and/or Vlastimil and no questions
> or concerns were raised after v6.
> 
> Please, let me know if you want me to resend both patchsets.

There was quite a bit of valuable discussion in response to [0/n] which
really should have been in the changelog[s] from day one. 
slab-vs-slub, performance testing, etc.

So, umm, I'll take a look at both series now but I do think an enhanced
[0/n] description is warranted?

