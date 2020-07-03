Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 762B7C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54C5D20870
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 10:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593773991;
	bh=q3CLpare1UGpseJv5NLoytOKCVO/Mcmr+mmbwWvTlJ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rcjtXN+V6q0ISRh6ddmgO7vFTQbx2zNv8kvmfy5E05Q5+pUoCX9WG2/Scllu6QCBY
	 9bakoTVyVCyy4ZNDxv5T6EOhipXu6c1MdRBppnyYpqUwt+YdxjFh2TLqUAKl0Xx2g0
	 6Ax4cwHhAfNP/UYmyikgHNn2zxhUYvjNVpGMMvo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgGCK7t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 06:59:49 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:37919 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgGCK7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 06:59:49 -0400
Received: by mail-ej1-f65.google.com with SMTP id w16so33743220ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 03:59:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9tKvM8/Cn/mYaxCxuR2xX8QmwiS4Do3drIeD4weqF7o=;
        b=KqVdl9y4NipQkIlKlSvJTYoeMBVd/lOpIvG7BYZSLnTp3skHp/gPE13pCE21XPU/1G
         S2P3xa1XZvLdrm6Lv0yYYVDFnENyyqO7T0SimQXtSi2IbjB7sM+IcHQI3QLSblg2C+Xe
         ThVgcxwtkGTipbgQJTRXqEdr3DF19GGmiJcthMlmqK9AEMygoH6Eu6xPDN4l2bhQDso3
         a0RVNBBF8DOJ2WEIMRplZ1UWDNAPYoUvEp9DfhxvMYGyWbG1ItCd1elSjlgc2YjQHnt9
         H/pP8NjBiNdyeGxmSc2PZD8XBFdUzQJegKMzc1qjX0qtRJmZuulmhr7Qe7LzzMvf1lZP
         ykBQ==
X-Gm-Message-State: AOAM532Zlcy5wHnwAmWhwtL3/A1gv+5eUat8Fm9IyYIj3q5uKiv/uIAg
        TA00dmzi2GldaHC7qMb77zc=
X-Google-Smtp-Source: ABdhPJypIBHztAW8b+oDXuc7i+rhK7i5IE4n3HBr9g6Z6wErcGVZfAUXJOhB8s0xROyaS+ZgyulOcA==
X-Received: by 2002:a17:906:f911:: with SMTP id lc17mr32750815ejb.330.1593773987079;
        Fri, 03 Jul 2020 03:59:47 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id m13sm9140663ejc.1.2020.07.03.03.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 03:59:46 -0700 (PDT)
Date:   Fri, 3 Jul 2020 12:59:44 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
Cc:     David Hildenbrand <david@redhat.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andi Kleen <ak@linux.intel.com>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200703105944.GS18446@dhcp22.suse.cz>
References: <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
 <20200701084200.GN2369@dhcp22.suse.cz>
 <20200701100442.GB17918@linux.vnet.ibm.com>
 <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200703091001.GJ21462@kitsune.suse.cz>
 <20200703092414.GR18446@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703092414.GR18446@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 03-07-20 11:24:17, Michal Hocko wrote:
> [Cc Andi]
> 
> On Fri 03-07-20 11:10:01, Michal Suchanek wrote:
> > On Wed, Jul 01, 2020 at 02:21:10PM +0200, Michal Hocko wrote:
> > > On Wed 01-07-20 13:30:57, David Hildenbrand wrote:
> [...]
> > > > Yep, looks like it.
> > > > 
> > > > [    0.009726] SRAT: PXM 1 -> APIC 0x00 -> Node 0
> > > > [    0.009727] SRAT: PXM 1 -> APIC 0x01 -> Node 0
> > > > [    0.009727] SRAT: PXM 1 -> APIC 0x02 -> Node 0
> > > > [    0.009728] SRAT: PXM 1 -> APIC 0x03 -> Node 0
> > > > [    0.009731] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0x0009ffff]
> > > > [    0.009732] ACPI: SRAT: Node 0 PXM 1 [mem 0x00100000-0xbfffffff]
> > > > [    0.009733] ACPI: SRAT: Node 0 PXM 1 [mem 0x100000000-0x13fffffff]
> > > 
> > > This begs a question whether ppc can do the same thing?
> > Or x86 stop doing it so that you can see on what node you are running?
> > 
> > What's the point of this indirection other than another way of avoiding
> > empty node 0?
> 
> Honestly, I do not have any idea. I've traced it down to
> Author: Andi Kleen <ak@suse.de>
> Date:   Tue Jan 11 15:35:48 2005 -0800
> 
>     [PATCH] x86_64: Fix ACPI SRAT NUMA parsing
> 
>     Fix fallout from the recent nodemask_t changes. The node ids assigned
>     in the SRAT parser were off by one.
> 
>     I added a new first_unset_node() function to nodemask.h to allocate
>     IDs sanely.
> 
>     Signed-off-by: Andi Kleen <ak@suse.de>
>     Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> 
> which doesn't really tell all that much. The historical baggage and a
> long term behavior which is not really trivial to fix I suspect.

Thinking about this some more, this logic makes some sense afterall.
Especially in the world without memory hotplug which was very likely the
case back then. It is much better to have compact node mask rather than
sparse one. After all node numbers shouldn't really matter as long as
you have a clear mapping to the HW. I am not sure we export that
information (except for the kernel ring buffer) though.

The memory hotplug changes that somehow because you can hotremove numa
nodes and therefore make the nodemask sparse but that is not a common
case. I am not sure what would happen if a completely new node was added
and its corresponding node was already used by the renumbered one
though. It would likely conflate the two I am afraid. But I am not sure
this is really possible with x86 and a lack of a bug report would
suggest that nobody is doing that at least.

-- 
Michal Hocko
SUSE Labs
