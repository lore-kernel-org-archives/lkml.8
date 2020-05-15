Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352F1C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:01:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CE982074D
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 13:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbgEONBM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 09:01:12 -0400
Received: from mga04.intel.com ([192.55.52.120]:57469 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726122AbgEONBM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 09:01:12 -0400
IronPort-SDR: iowo3bbAvMwOtBVjIdGGkcX3P8S9OpOl6i6aq4ib09vdyPDf46nsoH6MbWWzeX1i58T/+bIbUR
 JujDjj7QLsYA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2020 06:01:11 -0700
IronPort-SDR: LD0v8IRgyKsI2N0qTF2oCgjqjKSFPz+bmzf9t6tr/E/g16YW+ncniz22UkCOkB7M2ldj3HWkTg
 DmTL9fMWBETw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,395,1583222400"; 
   d="scan'208";a="263183050"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga003.jf.intel.com with ESMTP; 15 May 2020 06:01:07 -0700
Date:   Fri, 15 May 2020 21:01:07 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "Kleen, Andi" <andi.kleen@intel.com>,
        "Chen, Tim C" <tim.c.chen@intel.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] mm/util.c: make vm_memory_committed() more accurate
Message-ID: <20200515130107.GG69177@shbuild999.sh.intel.com>
References: <1588922717-63697-1-git-send-email-feng.tang@intel.com>
 <1588922717-63697-3-git-send-email-feng.tang@intel.com>
 <20200515072307.GG29153@dhcp22.suse.cz>
 <20200515081109.GD69177@shbuild999.sh.intel.com>
 <20200515090440.GN29153@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200515090440.GN29153@dhcp22.suse.cz>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 05:04:40PM +0800, Michal Hocko wrote:
> On Fri 15-05-20 16:11:09, Feng Tang wrote:
> > On Fri, May 15, 2020 at 03:23:07PM +0800, Michal Hocko wrote:
> > > On Fri 08-05-20 15:25:16, Feng Tang wrote:
> > > > percpu_counter_sum_positive() will provide more accurate info.
> > > 
> > > Why do we need that?
> > 
> > This is a preparation for patch 3/3, which will enlarge the batch size
> > of percpu-counter 'vm_committed_as'. Andi Kleen concerned that may
> > hurt the accuracy for those readers (currently only /proc/meminfo
> > and hyperV balloon drivers for status check)
> > 
> > As in worst case, the deviation could be 'batch * nr_cpus', and
> > with patch 3/3, that could be totalram_pages/16.
> 
> This information belongs to the changelog.

Will add it in v3, thanks

- Feng
