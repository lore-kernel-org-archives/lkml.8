Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0DCC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B993B20882
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 06:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgHRG6T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 02:58:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:47138 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726370AbgHRG6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 02:58:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 03703AD12;
        Tue, 18 Aug 2020 06:58:44 +0000 (UTC)
Date:   Tue, 18 Aug 2020 08:58:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        David Hildenbrand <david@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hotplug: Enumerate memory range offlining failure
 reasons
Message-ID: <20200818065817.GI28270@dhcp22.suse.cz>
References: <1597724522-31545-1-git-send-email-anshuman.khandual@arm.com>
 <20200818060547.GH28270@dhcp22.suse.cz>
 <f178d1f0-af86-6a29-5646-a8f2dc9912f5@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f178d1f0-af86-6a29-5646-a8f2dc9912f5@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-08-20 11:58:49, Anshuman Khandual wrote:
> 
> 
> On 08/18/2020 11:35 AM, Michal Hocko wrote:
> > On Tue 18-08-20 09:52:02, Anshuman Khandual wrote:
> >> Currently a debug message is printed describing the reason for memory range
> >> offline failure. This just enumerates existing reason codes which improves
> >> overall readability and makes it cleaner. This does not add any functional
> >> change.
> > 
> > Wasn't something like that posted already? To be honest I do not think
> 
> There was a similar one regarding bad page reason.
> 
> https://patchwork.kernel.org/patch/11464713/
> 
> > this is worth the additional LOC. We are talking about few strings used
> > at a single place. I really do not see any simplification, constants are
> > sometimes even longer than the strings they are describing.
> 
> I am still trying to understand why enumerating all potential offline
> failure reasons in a single place (i.e via enum) is not a better idea
> than strings scattered across the function. Besides being cleaner, it
> classifies, organizes and provide a structure to the set of reasons.
> It is not just about string replacement with constants.

This is a matter of taste. I would agree that using constants to
reference standardized messages is a good idea but all these reasons
are just an ad-hoc messages that we want to print more or less as a
debugging output. So all the additional LOC don't really seem worth it.
-- 
Michal Hocko
SUSE Labs
