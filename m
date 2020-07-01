Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEEAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86B020780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 16:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732241AbgGAQA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 12:00:58 -0400
Received: from mga12.intel.com ([192.55.52.136]:64042 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728534AbgGAQA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 12:00:57 -0400
IronPort-SDR: T8ZHtw35GvdI14dp48hyA31a631K2YYSNRnpJO8Ms1faCTviPtD/W7bxD4N6dM6/5wQX546+Rh
 xbJBhb/7A6Tg==
X-IronPort-AV: E=McAfee;i="6000,8403,9669"; a="126243326"
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="126243326"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:00:48 -0700
IronPort-SDR: vz7kfNqPAzOP9Ja+liVBuA7NBVbHoPStgbItBpDF7drpSr0G0tkUuRn2+T1KFZoMIIWAB0FdGF
 PH51FTVD7Vnw==
X-IronPort-AV: E=Sophos;i="5.75,300,1589266800"; 
   d="scan'208";a="425636457"
Received: from sadedonx-mobl2.amr.corp.intel.com (HELO intel.com) ([10.252.134.113])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2020 09:00:47 -0700
Date:   Wed, 1 Jul 2020 09:00:46 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
Subject: Re: [PATCH 0/3] [v2] Repair and clean up vm.zone_reclaim_mode sysctl
 ABI
Message-ID: <20200701160046.kvhsq43adcw46fbq@intel.com>
Mail-Followup-To: Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        alex.shi@linux.alibaba.com, dwagner@suse.de, tobin@kernel.org,
        cl@linux.com, akpm@linux-foundation.org, ying.huang@intel.com,
        dan.j.williams@intel.com, cai@lca.pw
References: <20200701152621.D520E62B@viggo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701152621.D520E62B@viggo.jf.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-07-01 08:26:21, Dave Hansen wrote:
> A previous cleanup accidentally changed the vm.zone_reclaim_mode ABI.
> 
> This series restores the ABI and then reorganizes the code to make
> the ABI more obvious.  Since the single-patch v1[1], I've:
> 
>  * Restored the RECLAIM_ZONE naming, comment and Documentation now
>    that the implicit checks for it are known.
>  * Move RECLAIM_* definitions to a uapi header
>  * Add a node_reclaim_enabled() helper
> 
>  Documentation/admin-guide/sysctl/vm.rst |   10 +++++-----
>  include/linux/swap.h                    |    7 +++++++
>  include/uapi/linux/mempolicy.h          |    7 +++++++
>  mm/khugepaged.c                         |    2 +-
>  mm/page_alloc.c                         |    2 +-
>  mm/vmscan.c                             |    3 ---
>  6 files changed, 21 insertions(+), 10 deletions(-)
> 
> 1. https://lore.kernel.org/linux-mm/20200626003459.D8E015CA@viggo.jf.intel.com/
> 
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Alex Shi <alex.shi@linux.alibaba.com>
> Cc: Daniel Wagner <dwagner@suse.de>
> Cc: "Tobin C. Harding" <tobin@kernel.org>
> Cc: Christoph Lameter <cl@linux.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Qian Cai <cai@lca.pw>
> Cc: Daniel Wagner <dwagner@suse.de>

Series is:
Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

I was more thorough this time in checking all uses of node_reclaim_mode :-). I
do think in patch 2/3, using an enum would be a little better, which I've
mentioned there.
