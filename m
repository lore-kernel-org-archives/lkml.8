Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00C9EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBD50207D3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 05:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgE2FhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 01:37:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:50821 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725308AbgE2FhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 01:37:17 -0400
IronPort-SDR: oDqi3RttSbizmzPa9HQPLdFpXI2fgZhHZLMXtk1ZgurikbD7d2E1CRDXyT2BmsPSjRFhY9AsJf
 R6bZG+hICAYg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 22:37:17 -0700
IronPort-SDR: 6ypjrCpGe+u2ZKOsSiOCn+oHK1f4MCoA7qld/0DTbkf5PThk4gEcABNY/WvkBHNGUS/PuTL+S/
 vO8+CcBfH0Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,447,1583222400"; 
   d="scan'208";a="302724034"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by fmsmga002.fm.intel.com with ESMTP; 28 May 2020 22:37:13 -0700
Date:   Fri, 29 May 2020 13:37:13 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, andi.kleen@intel.com,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Konstantin Khlebnikov <koct9i@gmail.com>
Subject: Re: [PATCH v4 3/4] mm/util.c: remove the VM_WARN_ONCE for
 vm_committed_as underflow check
Message-ID: <20200529053713.GH93879@shbuild999.sh.intel.com>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
 <1590714370-67182-4-git-send-email-feng.tang@intel.com>
 <20200529024928.GA4566@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529024928.GA4566@lca.pw>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 28, 2020 at 10:49:28PM -0400, Qian Cai wrote:
> On Fri, May 29, 2020 at 09:06:09AM +0800, Feng Tang wrote:
> > As is explained by Michal Hocko:
> > 
> > : Looking at the history, this has been added by 82f71ae4a2b8
> > : ("mm: catch memory commitment underflow") to have a safety check
> > : for issues which have been fixed. There doesn't seem to be any bug
> > : reports mentioning this splat since then so it is likely just
> > : spending cycles for a hot path (yes many people run with DEBUG_VM)
> > : without a strong reason.
> 
> Hmm, it looks like the warning is still useful to catch issues in,
> 
> https://lore.kernel.org/linux-mm/20140624201606.18273.44270.stgit@zurg
> https://lore.kernel.org/linux-mm/54BB9A32.7080703@oracle.com/
> 
> After read the whole discussion in that thread, I actually disagree with
> Michal. In order to get ride of this existing warning, it is rather
> someone needs a strong reason that could prove the performance hit is
> noticeable with some data.

One problem with current check is percpu_counter_read(&vm_committed_as)
is not accurate, and percpu_counter_sum() is way too heavy.

Thanks,
Feng
