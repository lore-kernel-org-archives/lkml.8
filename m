Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1221DC35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:53:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6E51217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 12:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728005AbgBEMxW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 07:53:22 -0500
Received: from gate.crashing.org ([63.228.1.57]:42729 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgBEMxV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 07:53:21 -0500
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 015CppFf030570;
        Wed, 5 Feb 2020 06:51:51 -0600
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 015Cpn3x030569;
        Wed, 5 Feb 2020 06:51:49 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 5 Feb 2020 06:51:49 -0600
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Oscar Salvador <osalvador@suse.de>, linux-s390@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, linux-ia64@vger.kernel.org,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        linux-sh@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Wei Yang <richardw.yang@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v6 10/10] mm/memory_hotplug: Cleanup __remove_pages()
Message-ID: <20200205125149.GS22482@gate.crashing.org>
References: <20191006085646.5768-1-david@redhat.com> <20191006085646.5768-11-david@redhat.com> <20200204094652.GE6494@linux> <5d698f94-af18-0714-bc97-14b6c520572c@redhat.com> <20200204131353.GJ22482@gate.crashing.org> <0e2f700c-b01b-8c16-99c2-2648967fc203@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e2f700c-b01b-8c16-99c2-2648967fc203@redhat.com>
User-Agent: Mutt/1.4.2.3i
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 02:38:51PM +0100, David Hildenbrand wrote:
> On 04.02.20 14:13, Segher Boessenkool wrote:
> > On Tue, Feb 04, 2020 at 01:41:06PM +0100, David Hildenbrand wrote:
> >> It's a pattern commonly used in compilers and emulators to calculate the
> >> number of bytes to the next block/alignment. (we're missing a macro
> >> (like we have ALIGN_UP/IS_ALIGNED) for that - but it's hard to come up
> >> with a good name (e.g., SIZE_TO_NEXT_ALIGN) .

> > You can just write the easy to understand
> > 
> >   ...  ALIGN_UP(x) - x  ...
> 
> you mean
> 
> ALIGN_UP(x, PAGES_PER_SECTION) - x
> 
> but ...
> 
> > which is better *without* having a separate name.  Does that not
> > generate good machine code for you?
> 
> 1. There is no ALIGN_UP. "SECTION_ALIGN_UP(x) - x" would be possible

Erm, you started it ;-)

> 2. It would be wrong if x is already aligned.
> 
> e.g., let's use 4096 for simplicity as we all know that value by heart
> (for both x and the block size).
> 
> a) -(4096 | -4096) -> 4096
> 
> b) #define ALIGN_UP(x, a) ((x + a - 1) & -(a))
> 
> ALIGN_UP(4096, 4096) - 4096 -> 0
> 
> Not as easy as it seems ...

If you always want to return a number >= 1, it it simply
  ALIGN_UP(x + 1) - x
(and replace 1 by any other minimum size required).  This *also* is
easy to read, without having to have any details (and quirks :-/ )
of those utility functions memorised.


Segher
