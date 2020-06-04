Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B98C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4D9820772
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 01:38:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727888AbgFDBih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 21:38:37 -0400
Received: from mga06.intel.com ([134.134.136.31]:27797 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgFDBih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 21:38:37 -0400
IronPort-SDR: YT5SDFUVBIAbLdZ566JyvoBp0QMngt5sE5OnlAvrpA1xAvQINNgYkECVJghnV2wyNxv6eg9S9p
 i6IWNaKNKJbQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 18:38:36 -0700
IronPort-SDR: AMeEWEXdU0inFl0oDvKKYFvVG5qMv7/RoO6AJbLXkzSGLUn61i1MaJwznPHZtvjV2j5969ySAM
 bFeLKhv71VcQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,470,1583222400"; 
   d="scan'208";a="269260744"
Received: from shbuild999.sh.intel.com (HELO localhost) ([10.239.146.107])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 18:38:33 -0700
Date:   Thu, 4 Jun 2020 09:38:32 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Andi Kleen <andi.kleen@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>, Qian Cai <cai@lca.pw>,
        tim.c.chen@intel.com, dave.hansen@intel.com, ying.huang@intel.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/4] mm/util.c: make vm_memory_committed() more
 accurate
Message-ID: <20200604013832.GD89848@shbuild999.sh.intel.com>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
 <1590714370-67182-3-git-send-email-feng.tang@intel.com>
 <20200603142853.GE621576@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603142853.GE621576@tassilo.jf.intel.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 07:28:53AM -0700, Andi Kleen wrote:
> > Its time cost is about 800 nanoseconds on a 2C/4T platform and
> > 2~3 microseconds on a 2S/36C/72T server in normal case, and in
> > worst case where vm_committed_as's spinlock is under severe
> > contention, it costs 30~40 microseconds for the 2S/36C/72T sever,
> 
> This will be likely 40-80us on larger systems, although the overhead
> is often non linear so it might get worse.
> 
> > which should be fine for its only two users: /proc/meminfo and
> > HyperV balloon driver's status trace per second.
> 
> There are some setups who do frequent sampling of /proc/meminfo
> in the background.  Increased overhead could be a problem for them.
> But not proposing a change now. If someone complains have to 
> revisit I guess, perhaps adding a rate limit of some sort.

Agree. Maybe I should also put the time cost info into the code
comments in case someone noticed the slowdown.

Thanks,
Feng

> 
> -Andi
