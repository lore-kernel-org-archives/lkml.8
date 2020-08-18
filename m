Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A0EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CA85207FB
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 07:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRHhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 03:37:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:48304 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgHRHhO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 03:37:14 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 50B33ABCC;
        Tue, 18 Aug 2020 07:37:38 +0000 (UTC)
Date:   Tue, 18 Aug 2020 09:37:12 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Such?nek <msuchanek@suse.de>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200818073712.GK28270@dhcp22.suse.cz>
References: <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200703091001.GJ21462@kitsune.suse.cz>
 <20200703092414.GR18446@dhcp22.suse.cz>
 <20200703105944.GS18446@dhcp22.suse.cz>
 <20200703125823.GA26243@linux.vnet.ibm.com>
 <20200806213211.6a6a56037fe771836e5abbe9@linux-foundation.org>
 <20200812060101.GB10992@linux.vnet.ibm.com>
 <13a85e52-5caa-24a8-7169-3992b1ad262a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13a85e52-5caa-24a8-7169-3992b1ad262a@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 18-08-20 09:32:52, David Hildenbrand wrote:
> On 12.08.20 08:01, Srikar Dronamraju wrote:
> > Hi Andrew, Michal, David
> > 
> > * Andrew Morton <akpm@linux-foundation.org> [2020-08-06 21:32:11]:
> > 
> >> On Fri, 3 Jul 2020 18:28:23 +0530 Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:
> >>
> >>>> The memory hotplug changes that somehow because you can hotremove numa
> >>>> nodes and therefore make the nodemask sparse but that is not a common
> >>>> case. I am not sure what would happen if a completely new node was added
> >>>> and its corresponding node was already used by the renumbered one
> >>>> though. It would likely conflate the two I am afraid. But I am not sure
> >>>> this is really possible with x86 and a lack of a bug report would
> >>>> suggest that nobody is doing that at least.
> >>>>
> >>>
> >>> JFYI,
> >>> Satheesh copied in this mailchain had opened a bug a year on crash with vcpu
> >>> hotplug on memoryless node. 
> >>>
> >>> https://bugzilla.kernel.org/show_bug.cgi?id=202187
> >>
> >> So...  do we merge this patch or not?  Seems that the overall view is
> >> "risky but nobody is likely to do anything better any time soon"?
> > 
> > Can we decide on this one way or the other?
> 
> Hmm, not sure who's the person to decide. I tend to prefer doing the
> node renaming, handling this in ppc code;

Agreed. That would be a safer option.
-- 
Michal Hocko
SUSE Labs
