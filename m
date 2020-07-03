Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E836C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 261CF20BED
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:24:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593768261;
	bh=F7ZKLAGXXjqFEfgr9EsHi/utBqg+Dr9btHj5AhaedJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=L8zHzxLQF+I7PTQofREsFdggMjVvN+YxYDXLr+0x7f9UtXmRRDWQEuWmj8EN3vCrq
	 kIBDkKDu9c6+jHoHSNk0YuK3/PtyfNzOVE+2BavoV+cTQUUfTRPJMsCdn15iy4gSOP
	 FdCbNG9RMhGsLBMjSbazFuGLGY6TPmhsP9caYRGE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGCJYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:24:19 -0400
Received: from mail-ej1-f65.google.com ([209.85.218.65]:38581 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbgGCJYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:24:19 -0400
Received: by mail-ej1-f65.google.com with SMTP id w16so33482007ejj.5
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:24:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iJLZm8Njvb3Yiim6wQvrOQ/ONlV8hDDQOYhn9693iq0=;
        b=QNLoLOWj1EPKkdmc37Aq4PGixhF50bXTW/LZsWrUSBw6ze3u18QduSRnZROxQWRRJU
         cRKzbL6zhmR2t6WCRQmGvTKIsn4Ow9yQ6bD5pBsGoMFkwkguDzrKu8bQidlwhJAucmEU
         r5/XBDinacIjOrZKtZoVwTzEW6//pIvtDzdXYrGWZYSIay47eyJ/gitqowds23DG5DJM
         9/n6qIyLieQ+ZgTbZVNU2DZ35RC7V5ugVSQvFRT9s7Z5Gq/5aIRUsheAWuu2FGb2Pzj5
         BPz1VbkMFcXXIXZ9lIddYH63YbFXlIcD5b+dadzbxqnuUVS+bbemoxrY/WpZ6dTQKl2X
         Tviw==
X-Gm-Message-State: AOAM531TKkN8Wu6rySfPhbtJUv6ejFHI6HiWIws5PZx7M4ZeOFiD8+dq
        1T88WgeN2KY8NjSvnSFzwyY=
X-Google-Smtp-Source: ABdhPJyX1uiNEPa1jrkIIqpxN7mzlISZmIk00tNVQd8wc47hHS0KLZLdKRBE9Qshpnx67YsqYHV2vQ==
X-Received: by 2002:a17:906:19c7:: with SMTP id h7mr30603847ejd.403.1593768257301;
        Fri, 03 Jul 2020 02:24:17 -0700 (PDT)
Received: from localhost (ip-37-188-168-3.eurotel.cz. [37.188.168.3])
        by smtp.gmail.com with ESMTPSA id i10sm11795002edx.42.2020.07.03.02.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2020 02:24:16 -0700 (PDT)
Date:   Fri, 3 Jul 2020 11:24:14 +0200
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
Message-ID: <20200703092414.GR18446@dhcp22.suse.cz>
References: <20200624092846.9194-1-srikar@linux.vnet.ibm.com>
 <20200624092846.9194-4-srikar@linux.vnet.ibm.com>
 <20200701084200.GN2369@dhcp22.suse.cz>
 <20200701100442.GB17918@linux.vnet.ibm.com>
 <184102af-ecf2-c834-db46-173ab2e66f51@redhat.com>
 <20200701110145.GC17918@linux.vnet.ibm.com>
 <0468f965-8762-76a3-93de-3987cf859927@redhat.com>
 <12945273-d788-710d-e8d7-974966529c7d@redhat.com>
 <20200701122110.GT2369@dhcp22.suse.cz>
 <20200703091001.GJ21462@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703091001.GJ21462@kitsune.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc Andi]

On Fri 03-07-20 11:10:01, Michal Suchanek wrote:
> On Wed, Jul 01, 2020 at 02:21:10PM +0200, Michal Hocko wrote:
> > On Wed 01-07-20 13:30:57, David Hildenbrand wrote:
[...]
> > > Yep, looks like it.
> > > 
> > > [    0.009726] SRAT: PXM 1 -> APIC 0x00 -> Node 0
> > > [    0.009727] SRAT: PXM 1 -> APIC 0x01 -> Node 0
> > > [    0.009727] SRAT: PXM 1 -> APIC 0x02 -> Node 0
> > > [    0.009728] SRAT: PXM 1 -> APIC 0x03 -> Node 0
> > > [    0.009731] ACPI: SRAT: Node 0 PXM 1 [mem 0x00000000-0x0009ffff]
> > > [    0.009732] ACPI: SRAT: Node 0 PXM 1 [mem 0x00100000-0xbfffffff]
> > > [    0.009733] ACPI: SRAT: Node 0 PXM 1 [mem 0x100000000-0x13fffffff]
> > 
> > This begs a question whether ppc can do the same thing?
> Or x86 stop doing it so that you can see on what node you are running?
> 
> What's the point of this indirection other than another way of avoiding
> empty node 0?

Honestly, I do not have any idea. I've traced it down to
Author: Andi Kleen <ak@suse.de>
Date:   Tue Jan 11 15:35:48 2005 -0800

    [PATCH] x86_64: Fix ACPI SRAT NUMA parsing

    Fix fallout from the recent nodemask_t changes. The node ids assigned
    in the SRAT parser were off by one.

    I added a new first_unset_node() function to nodemask.h to allocate
    IDs sanely.

    Signed-off-by: Andi Kleen <ak@suse.de>
    Signed-off-by: Linus Torvalds <torvalds@osdl.org>

which doesn't really tell all that much. The historical baggage and a
long term behavior which is not really trivial to fix I suspect.
-- 
Michal Hocko
SUSE Labs
