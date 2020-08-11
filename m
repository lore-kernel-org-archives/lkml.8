Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F05BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B1AF20781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHKHYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:24:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:48722 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgHKHYP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:24:15 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5F0C7AC7D;
        Tue, 11 Aug 2020 07:24:34 +0000 (UTC)
Date:   Tue, 11 Aug 2020 09:24:11 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Baoquan He <bhe@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, david@redhat.com,
        akpm@linux-foundation.org
Subject: Re: [PATCH v2 4/4] mm/hugetl.c: warn out if expected count of huge
 pages adjustment is not achieved
Message-ID: <20200811072212.GD4793@dhcp22.suse.cz>
References: <20200723032248.24772-1-bhe@redhat.com>
 <20200723032248.24772-5-bhe@redhat.com>
 <62c8ce6c-fe98-f371-99b6-cfdb96d1c2fd@arm.com>
 <20200723091142.GR32539@MiWiFi-R3L-srv>
 <b94f4dc1-5c53-68ca-2023-0aa4de4df8b7@oracle.com>
 <20200811021152.GW14854@MiWiFi-R3L-srv>
 <f659959f-47c5-93f0-ad84-48e53561b1e2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f659959f-47c5-93f0-ad84-48e53561b1e2@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 10-08-20 20:35:25, Mike Kravetz wrote:
> Cc: Michal
> 
> On 8/10/20 7:11 PM, Baoquan He wrote:
> > Hi Mike,
> > 
> > On 07/23/20 at 11:21am, Mike Kravetz wrote:
> >> On 7/23/20 2:11 AM, Baoquan He wrote:
> > ...
> >>>> But is kernel expected to warn for all such situations where the user
> >>>> requested resources could not be allocated completely ? Otherwise, it
> >>>> does not make sense to add an warning for just one such situation.
> >>>
> >>> It's not for just one such situation, we have already had one to warn
> >>> out in mm/hugetlb.c, please check hugetlb_hstate_alloc_pages().
> >>
> >> Those are a little different in that they are warnings based on kernel
> >> command line parameters.
> >>
> >>> As Mike said, in one time of persistent huge page number setting,
> >>> comparing the old value with the new vlaue is good enough for customer
> >>> to get the information. However, if customer want to detect and analyze
> >>> previous setting failure, logging message will be helpful. So I think
> >>> logging the failure or partial success makes sense.
> >>
> >> I can understand the argument against adding a new warning for this.
> >> You could even argue that this condition has existed since the time
> >> hugetlb was added to the kernel which was long ago.  And, nobody has
> >> complained enough to add a warning.  I have even heard of a sysadmin
> >> practice of asking for a ridiculously large amount of hugetlb pages
> >> just so that the kernel will allocate as many as possible.  They do
> >> not 'expect' to get the ridiculous amount they asked for.  In such
> >> cases, this will be a new warning in their log.
> >>
> >> As mentioned in a previous e-mail, when one sets nr_hugepages by writing
> >> to the sysfs or proc file, one needs to read the file to determine if the
> >> number of requested pages were actually allocated.  Anyone who does not
> >> do this is just asking for trouble.  Yet, I imagine that it may happen.
> >>
> >> To be honest, I do not see this log message as something that would be
> >> helpful to end users.  Rather, I could see this as being useful to support
> >> people.  Support always asks for system logs and this could point out a
> >> possible issue with hugetlb usage.
> >>
> >> I do not feel strongly one way or another about adding the warning.  Since
> >> it is fairly trivial and could help diagnose issues I am in favor of adding
> >> it.  If people feel strongly that it should not be added, I am open to
> >> those arguments.
> > 
> > Ping!
> > 
> > It's been a while, seems no objection to log the message. Do you
> > consider accepting this patch or offering an Ack?
> > 
> > Thanks
> > Baoquan
> 
> Adding Michal as he has had opinions about hugetlbfs log messages in the past.

My opinion is that the warning is too late to add at this stage. It
would have been much better if the user interface has provided a
reasonable feedback on how much the request was sucessful. But this
is not the case (except for few error cases) and we have to live with
the interface where the caller has to read the value after writing to
it. Lame but a reality.

I have heard about people making an opportunistic attempt to grab as
many hugetlb pages as possible and they do expect the failure and scale
the request size down. I do not think those would appreciate warnings.

That being said I would rather keep the existing behavior even though it
is suboptimal. It is just trivial to add the check in the userspace
without risking complains by other users. Besides the warning is not
really telling us much more than a subsequent read anyway. You are not
going to learn why the allocation has failed because that one is done
(intentionaly) as __GFP_NOWARN.
-- 
Michal Hocko
SUSE Labs
