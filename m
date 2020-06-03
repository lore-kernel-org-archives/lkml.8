Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E0FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:28:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E170320679
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 14:28:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725961AbgFCO2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 10:28:55 -0400
Received: from mga12.intel.com ([192.55.52.136]:53454 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbgFCO2y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 10:28:54 -0400
IronPort-SDR: WV0zH0s8XSv8BRdyEGxIDsROb4Ce0WdPVLsYjxIA2Vs7lP9WnJJcsAgRXJrk8h+2QQcvgjFjhW
 YqY8fwoDVapw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2020 07:28:53 -0700
IronPort-SDR: XXUouqSJAn1VhHZCiNgfISHb83SMuN06jgxmcHhs3xupN+cDr+gpJegoaUAfhAJZO4c5N3xx7I
 r3jZCOk7K+Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,467,1583222400"; 
   d="scan'208";a="269091278"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by orsmga003.jf.intel.com with ESMTP; 03 Jun 2020 07:28:53 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 8CBF330166D; Wed,  3 Jun 2020 07:28:53 -0700 (PDT)
Date:   Wed, 3 Jun 2020 07:28:53 -0700
From:   Andi Kleen <andi.kleen@intel.com>
To:     Feng Tang <feng.tang@intel.com>
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
Message-ID: <20200603142853.GE621576@tassilo.jf.intel.com>
References: <1590714370-67182-1-git-send-email-feng.tang@intel.com>
 <1590714370-67182-3-git-send-email-feng.tang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1590714370-67182-3-git-send-email-feng.tang@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Its time cost is about 800 nanoseconds on a 2C/4T platform and
> 2~3 microseconds on a 2S/36C/72T server in normal case, and in
> worst case where vm_committed_as's spinlock is under severe
> contention, it costs 30~40 microseconds for the 2S/36C/72T sever,

This will be likely 40-80us on larger systems, although the overhead
is often non linear so it might get worse.

> which should be fine for its only two users: /proc/meminfo and
> HyperV balloon driver's status trace per second.

There are some setups who do frequent sampling of /proc/meminfo
in the background.  Increased overhead could be a problem for them.
But not proposing a change now. If someone complains have to 
revisit I guess, perhaps adding a rate limit of some sort.

-Andi

