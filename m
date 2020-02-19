Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6ECC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16994208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582140702;
	bh=WFvZa8hDniOG8g1qTenV8AtspoE+3eAninCHZes58LU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=SA3IUpxmz8J96zAvhEXcKl2T8naopA0nEx7fsw0JkyhkOyfBztk0/6kITs2u4Kj6I
	 4Frl+PyRMENtKrSampLZZMDMF7yeiFZt/QnKAQW/yI1GxH8Lont9e7aRK/bvEoxtjJ
	 /pxdlx0GDwW9sFe613ZoCe4UNxPgkD7krsXNsuBQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgBSTbl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:31:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:47170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726634AbgBSTbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:31:40 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F10F6208E4;
        Wed, 19 Feb 2020 19:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582140700;
        bh=WFvZa8hDniOG8g1qTenV8AtspoE+3eAninCHZes58LU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0/Z2qwVUjvEBK9lueZh7pxv8imBgjnkMO9MVu2fV58D6nh1RWpn7VHc0zxzfzsbVd
         k3NwiEWCzkAAatIu4pcPaBY36s/oaD/qjVZML74u8CLJS+JdScIbOuCsQ9x6tv8p70
         +pBJ6402V2bEIvxO3B1PeMhVv6eRF3KfABKD6MYk=
Date:   Wed, 19 Feb 2020 11:31:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
        Roman Gushchin <guro@fb.com>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-Id: <20200219113139.ee60838bc7eb35747eb330fa@linux-foundation.org>
In-Reply-To: <20200219183731.GC11847@dhcp22.suse.cz>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
        <20200219183731.GC11847@dhcp22.suse.cz>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Feb 2020 19:37:31 +0100 Michal Hocko <mhocko@kernel.org> wrote:

> On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
> > We have received regression reports from users whose workloads moved
> > into containers and subsequently encountered new latencies. For some
> > users these were a nuisance, but for some it meant missing their SLA
> > response times. We tracked those delays down to cgroup limits, which
> > inject direct reclaim stalls into the workload where previously all
> > reclaim was handled my kswapd.
> 
> I am curious why is this unexpected when the high limit is explicitly
> documented as a throttling mechanism.

Yes, this sounds like a feature-not-a-bug.

But what was the nature of these stalls?  If they were "stuck in D
state waiting for something" then that's throttling.  If they were
"unexpected bursts of in-kernel CPU activity" then I see a better case.

