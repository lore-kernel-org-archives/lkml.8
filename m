Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AABC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D304D20720
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 08:31:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390700AbgFYIbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 04:31:18 -0400
Received: from elvis.franken.de ([193.175.24.41]:36835 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390597AbgFYIbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 04:31:16 -0400
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1joNHt-0001Gi-04; Thu, 25 Jun 2020 10:31:13 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id C8607C06F9; Thu, 25 Jun 2020 10:28:37 +0200 (CEST)
Date:   Thu, 25 Jun 2020 10:28:37 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH 11/26] mm/mips: Use general page fault accounting
Message-ID: <20200625082837.GD6319@alpha.franken.de>
References: <20200619160538.8641-1-peterx@redhat.com>
 <20200619160538.8641-12-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619160538.8641-12-peterx@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 12:05:23PM -0400, Peter Xu wrote:
> Use the general page fault accounting by passing regs into handle_mm_fault().
> It naturally solve the issue of multiple page fault accounting when page fault
> retry happened.
> 
> Fix PERF_COUNT_SW_PAGE_FAULTS perf event manually for page fault retries, by
> moving it before taking mmap_sem.
> 
> CC: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> CC: linux-mips@vger.kernel.org
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  arch/mips/mm/fault.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
