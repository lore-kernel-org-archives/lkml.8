Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FAAC43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:05:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 686542166E
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 17:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgIIRE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 13:04:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:53026 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730432AbgIIPnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:43:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E6EF7AD18;
        Wed,  9 Sep 2020 12:45:40 +0000 (UTC)
Date:   Wed, 9 Sep 2020 14:45:24 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laurent Dufour <ldufour@linux.ibm.com>,
        akpm@linux-foundation.org, Oscar Salvador <osalvador@suse.de>,
        rafael@kernel.org, nathanl@linux.ibm.com, cheloha@linux.ibm.com,
        stable@vger.kernel.org, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: don't rely on system state to detect hot-plug
 operations
Message-ID: <20200909124524.GJ7348@dhcp22.suse.cz>
References: <5cbd92e1-c00a-4253-0119-c872bfa0f2bc@redhat.com>
 <20200908170835.85440-1-ldufour@linux.ibm.com>
 <20200909074011.GD7348@dhcp22.suse.cz>
 <9faac1ce-c02d-7dbc-f79a-4aaaa5a73d28@linux.ibm.com>
 <20200909090953.GE7348@dhcp22.suse.cz>
 <4cdb54be-1a92-4ba4-6fee-3b415f3468a9@linux.ibm.com>
 <9ad553f2-ebbf-cae5-5570-f60d2c965c41@redhat.com>
 <20200909123001.GA670250@kroah.com>
 <e3ea2aab-70d5-0da4-7e72-c02051854497@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ea2aab-70d5-0da4-7e72-c02051854497@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 09-09-20 14:32:57, David Hildenbrand wrote:
> On 09.09.20 14:30, Greg Kroah-Hartman wrote:
> > On Wed, Sep 09, 2020 at 11:24:24AM +0200, David Hildenbrand wrote:
> >>>> I am not sure an enum is going to make the existing situation less
> >>>> messy. Sure we somehow have to distinguish boot init and runtime hotplug
> >>>> because they have different constrains. I am arguing that a) we should
> >>>> have a consistent way to check for those and b) we shouldn't blow up
> >>>> easily just because sysfs infrastructure has failed to initialize.
> >>>
> >>> For the point a, using the enum allows to know in register_mem_sect_under_node() 
> >>> if the link operation is due to a hotplug operation or done at boot time.
> >>>
> >>> For the point b, one option would be ignore the link error in the case the link 
> >>> is already existing, but that BUG_ON() had the benefit to highlight the root issue.
> >>>
> >>
> >> WARN_ON_ONCE() would be preferred  - not crash the system but still
> >> highlight the issue.
> > 
> > Many many systems now run with 'panic on warn' enabled, so that wouldn't
> > change much :(
> > 
> > If you can warn, you can properly just print an error message and
> > recover from the problem.
> 
> Maybe VM_WARN_ON_ONCE() then to detect this during testing?
> 
> (we basically turned WARN_ON_ONCE() useless with 'panic on warn' getting
> used in production - behaves like BUG_ON and BUG_ON is frowned upon)

VM_WARN* is not that much different from panic on warn. Still one can
argue that many workloads enable it just because. And I would disagree
that we should care much about those because those are debugging
features and everybody has to take consequences.

On the other hand the question is whether WARN is giving us much. So
what is the advantage over a simple pr_err? We will get a backtrace.
Interesting but not really that useful because there are only few code
paths this can trigger from. Registers dump? Not really useful here.
Taint flag, probably useful because follow up problems might give us a
hint that this might be related. People tend to pay more attention to
WARN splat than a single line error. Well, not really a strong reason, I
would say.

So while I wouldn't argue against WARN* in general (just because somebody
might be setting the system to panic), I would also think of how much
useful the splat is.

-- 
Michal Hocko
SUSE Labs
