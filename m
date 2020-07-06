Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80416C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5288F20723
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 16:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729525AbgGFQIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 12:08:18 -0400
Received: from mga07.intel.com ([134.134.136.100]:43194 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729367AbgGFQIQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 12:08:16 -0400
IronPort-SDR: Fq0Gl326DhhEvEwNPi7Q9mKiAFlbAcbBL6nVWsoX4GIbcsz1nZcCfVhJl3uNtrSbSltIwig42T
 5tQEjryc1iUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="212424256"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="212424256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 09:08:15 -0700
IronPort-SDR: hK09vW0VonTkhD7BVOoLSdCW4JvdYOMoUpm0jfintgXtC4zW+ojUN4hpZsl+Osr/7ovFMiRFj8
 fLSTzBceebiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="279318902"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 06 Jul 2020 09:08:15 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 726CF30119A; Mon,  6 Jul 2020 09:08:15 -0700 (PDT)
Date:   Mon, 6 Jul 2020 09:08:15 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>,
        David Hildenbrand <david@redhat.com>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v5 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
Message-ID: <20200706160815.GH3448022@tassilo.jf.intel.com>
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

> > What's the point of this indirection other than another way of avoiding
> > empty node 0?
> 
> Honestly, I do not have any idea. I've traced it down to
> Author: Andi Kleen <ak@suse.de>
> Date:   Tue Jan 11 15:35:48 2005 -0800

I don't remember all the details, and I can't even find the commit
(is it in linux-historic?).

But AFAIK there's no guarantee PXMs are small and continuous, so it
seemed better to have a clean zero based space.

Back then we had a lot of problems with buggy SRAT tables in BIOS,
so we really tried to avoid trusting the BIOS as much as possible.

-Andi

