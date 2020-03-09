Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A69C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:38:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C709B21D7E
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 15:38:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCIPid (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 11:38:33 -0400
Received: from mga07.intel.com ([134.134.136.100]:36195 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgCIPid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 11:38:33 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Mar 2020 08:38:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,533,1574150400"; 
   d="scan'208";a="440958564"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 09 Mar 2020 08:38:31 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 764EA301BCC; Mon,  9 Mar 2020 08:38:31 -0700 (PDT)
Date:   Mon, 9 Mar 2020 08:38:31 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        Cannon Matthews <cannonmatthews@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        David Rientjes <rientjes@google.com>,
        Greg Thelen <gthelen@google.com>,
        Salman Qazi <sqazi@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH] mm: clear 1G pages with streaming stores on x86
Message-ID: <20200309153831.GK1454533@tassilo.jf.intel.com>
References: <20200307010353.172991-1-cannonmatthews@google.com>
 <20200309000820.f37opzmppm67g6et@box>
 <20200309090630.GC8447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309090630.GC8447@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Gigantic huge pages are a bit different. They are much less dynamic from
> the usage POV in my experience. Micro-optimizations for the first access
> tends to not matter at all as it is usually pre-allocation scenario. On
> the other hand, speeding up the initialization sounds like a good thing
> in general. It will be a single time benefit but if the additional code
> is not hard to maintain then I would be inclined to take it even with
> "artificial" numbers state above. There really shouldn't be other downsides
> except for the code maintenance, right?

There's a cautious tale of the old crappy RAID5 XOR assembler functions which
were optimized a long time ago for the Pentium1, and stayed around,
even though the compiler could actually do a better job.

String instructions are constantly improving in performance (Broadwell is
very old at this point) Most likely over time (and maybe even today
on newer CPUs) you would need much more sophisticated unrolled MOVNTI variants
(or maybe even AVX-*) to be competitive.

The best clear functions may also be different for different CPU
generations.

Using the string instructions has the advantage that all of this is abstracted
from the kernel.

-Andi
