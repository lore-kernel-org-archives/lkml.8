Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43906C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:32:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22A1621744
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 04:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596774765;
	bh=Fz8huZnhhkLwSX05aWzvKoou0vXMR2d8SOky+EI3hfo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=2BR0bDXvjHNqEU0wFOx7RG3U3jjChP+1x5X+qwX2P79zUUZzp0m2dsb0Xr3eeMD7U
	 nGTTRmcd6N1JTdBQojg5JtCW6hXJkhya1IzMb7H9mRo7AEUJbE33bb1FsxDCohXQp6
	 1mHgeb7tt4mnC4qtZ5P2VZVkhr2aTRZwLMeD/UvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgHGEcN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 00:32:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:45298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgHGEcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 00:32:13 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14E3621744;
        Fri,  7 Aug 2020 04:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596774732;
        bh=Fz8huZnhhkLwSX05aWzvKoou0vXMR2d8SOky+EI3hfo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PivBxqhpKW9l29vGnuwJI6ZUtWS9wpMsCHjc3KbEXRi35qRfLW8Eq2I51dbr5v5Vp
         y3VzXxjiHFgoz6S8sgt5uLnP49+A9eUa4zcnMZ/AqMf9nlm3iLtG2OtSbKmVazwCkQ
         qIQ0b2z/plBFKHgHrgl8VXcnraRUyFBRX5ksLUqQ=
Date:   Thu, 6 Aug 2020 21:32:11 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Michal Such?nek <msuchanek@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-Id: <20200806213211.6a6a56037fe771836e5abbe9@linux-foundation.org>
In-Reply-To: <20200703125823.GA26243@linux.vnet.ibm.com>
References: <20200701084200.GN2369@dhcp22.suse.cz>
        <20200701100442.GB17918@linux.vnet.ibm.com>
        <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
        <20200701110145.GC17918@linux.vnet.ibm.com>
        <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
        <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
        <20200701122110.GT2369@dhcp22.suse.cz>
        <20200703091001.GJ21462@kitsune.suse.cz>
        <20200703092414.GR18446@dhcp22.suse.cz>
        <20200703105944.GS18446@dhcp22.suse.cz>
        <20200703125823.GA26243@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 3 Jul 2020 18:28:23 +0530 Srikar Dronamraju <srikar@linux.vnet.ibm.com> wrote:

> > The memory hotplug changes that somehow because you can hotremove numa
> > nodes and therefore make the nodemask sparse but that is not a common
> > case. I am not sure what would happen if a completely new node was added
> > and its corresponding node was already used by the renumbered one
> > though. It would likely conflate the two I am afraid. But I am not sure
> > this is really possible with x86 and a lack of a bug report would
> > suggest that nobody is doing that at least.
> > 
> 
> JFYI,
> Satheesh copied in this mailchain had opened a bug a year on crash with vcpu
> hotplug on memoryless node. 
> 
> https://bugzilla.kernel.org/show_bug.cgi?id=202187

So...  do we merge this patch or not?  Seems that the overall view is
"risky but nobody is likely to do anything better any time soon"?
