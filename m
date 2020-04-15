Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4275C2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7930206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 02:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392840AbgDOCCD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 22:02:03 -0400
Received: from mga05.intel.com ([192.55.52.43]:40304 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392789AbgDOCB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 22:01:57 -0400
IronPort-SDR: TxEr8Kj0dMWMhLLIKlDjaSS4qPK087B27BYnFZWOjdjpvpI9IKiTGeZcY5r9wv5AhGFbs9VBri
 nGLDtsaQNoVA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2020 19:01:56 -0700
IronPort-SDR: Hmt0b3bWk3FGU0LKmcKgQ0wNl3GKIVKo4Fb+10Tv+bsqQf9j0sO0wYR8CZxlB27WI+ElswuQJu
 QGh6XA0w7J5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; 
   d="scan'208";a="242172668"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga007.jf.intel.com with ESMTP; 14 Apr 2020 19:01:54 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Linux-MM <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        Minchan Kim <minchan@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: linux-next: not-present page at swap_vma_readahead()
References: <62A0ACFC-E023-4269-8121-F96B879A8C51@lca.pw>
        <81F06AA9-F25B-4342-9CF7-2763AC394A18@lca.pw>
Date:   Wed, 15 Apr 2020 10:01:53 +0800
In-Reply-To: <81F06AA9-F25B-4342-9CF7-2763AC394A18@lca.pw> (Qian Cai's message
        of "Tue, 14 Apr 2020 17:22:54 -0400")
Message-ID: <874ktl1p7y.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Qian Cai <cai@lca.pw> writes:

>> On Apr 14, 2020, at 10:32 AM, Qian Cai <cai@lca.pw> wrote:
>> 
>> Fuzzers are unhappy. Thoughts?
>
> This is rather to reproduce. All the traces so far are from copy_from_user() to trigger a page fault,
> and then it dereferences a bad pte in swap_vma_readahead(),
>
> 	for (i = 0, pte = ra_info.ptes; i < ra_info.nr_pte;
> 	     i++, pte++) {
> 		pentry = *pte;   <— crashed here.
> 		if (pte_none(pentry))

Is it possible to bisect this?

Because the crash point is identified, it may be helpful to collect and
analyze the status of the faulting page table and readahead ptes.  But I
am not familiar with the ARM64 architecture.  So I cannot help much
here.

Best Regards,
Huang, Ying
