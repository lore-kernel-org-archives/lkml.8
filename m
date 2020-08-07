Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5344C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8323620855
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 10:05:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgHGKFC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 06:05:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:49402 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727820AbgHGKFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 06:05:01 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 625ADAC19;
        Fri,  7 Aug 2020 10:05:17 +0000 (UTC)
Date:   Fri, 7 Aug 2020 12:04:58 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Andi Kleen <ak@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Christopher Lameter <cl@linux.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200807100458.GI32107@kitsune.suse.cz>
References: <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200703091001.GJ21462@kitsune.suse.cz>
 <20200703092414.GR18446@dhcp22.suse.cz>
 <20200703105944.GS18446@dhcp22.suse.cz>
 <20200703125823.GA26243@linux.vnet.ibm.com>
 <20200806213211.6a6a56037fe771836e5abbe9@linux-foundation.org>
 <5688b358-36bc-ccf0-d24b-a65375a9f3c3@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5688b358-36bc-ccf0-d24b-a65375a9f3c3@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 08:58:09AM +0200, David Hildenbrand wrote:
> On 07.08.20 06:32, Andrew Morton wrote:
> > On Fri, 3 Jul 2020 18:28:23 +0530 Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:
> > 
> >>> The memory hotplug changes that somehow because you can hotremove numa
> >>> nodes and therefore make the nodemask sparse but that is not a common
> >>> case. I am not sure what would happen if a completely new node was added
> >>> and its corresponding node was already used by the renumbered one
> >>> though. It would likely conflate the two I am afraid. But I am not sure
> >>> this is really possible with x86 and a lack of a bug report would
> >>> suggest that nobody is doing that at least.
> >>>
> >>
> >> JFYI,
> >> Satheesh copied in this mailchain had opened a bug a year on crash with vcpu
> >> hotplug on memoryless node. 
> >>
> >> https://bugzilla.kernel.org/show_bug.cgi?id=202187
> > 
> > So...  do we merge this patch or not?  Seems that the overall view is
> > "risky but nobody is likely to do anything better any time soon"?
> 
> I recall the issue Michal saw was "fix powerpc" vs. "break other
> architectures". @Michal how should we proceed? At least x86-64 won't be
> affected IIUC.
There is a patch to introduce the node remapping on ppc as well which
should eliminate the empty node 0.

https://patchwork.ozlabs.org/project/linuxppc-dev/patch/20200731111916.243569-1-aneesh.kumar@linux.ibm.com/

Thanks

Michal
