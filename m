Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C8B7C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A0D720702
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 13:34:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgGFNep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 09:34:45 -0400
Received: from mga11.intel.com ([192.55.52.93]:22677 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbgGFNef (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 09:34:35 -0400
IronPort-SDR: CNjeike65LN1YpQGTOgmj7GR0lcJuF+1gkluJuSHD4K4WoUjgsBnIWj3TYKPh9fi+5G80Mkbat
 VUHtxHFVjNdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="145520052"
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="145520052"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 06:34:35 -0700
IronPort-SDR: uza9DKlu1Z8lPzS8c68lYnD2oxSCVKGcigfaAZ2U+t+swpOmjFFQIY5mca5nC3svAa256Qkl3u
 CSNECqWL3ImQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,320,1589266800"; 
   d="scan'208";a="483134004"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.21])
  by fmsmga005.fm.intel.com with ESMTP; 06 Jul 2020 06:34:34 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 76DF1301BE3; Mon,  6 Jul 2020 06:34:34 -0700 (PDT)
Date:   Mon, 6 Jul 2020 06:34:34 -0700
From:   Andi Kleen <andi.kleen@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Qian Cai <cai@lca.pw>, Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, tim.c.chen@intel.com,
        dave.hansen@intel.com, ying.huang@intel.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, lkp@lists.01.org
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
Message-ID: <20200706133434.GA3483883@tassilo.jf.intel.com>
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
 <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
 <20200705125854.GA66252@shbuild999.sh.intel.com>
 <20200705155232.GA608@lca.pw>
 <20200706014313.GB66252@shbuild999.sh.intel.com>
 <20200706023614.GA1231@lca.pw>
 <20200706132443.GA34488@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706132443.GA34488@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
> -	if (ret == 0 && write)
> +	if (ret == 0 && write) {
> +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
> +			schedule_on_each_cpu(sync_overcommit_as);

The schedule_on_each_cpu is not atomic, so the problem could still happen
in that window.

I think it may be ok if it eventually resolves, but certainly needs
a comment explaining it. Can you do some stress testing toggling the
policy all the time on different CPUs and running the test on
other CPUs and see if the test fails?

The other alternative would be to define some intermediate state
for the sysctl variable and only switch to never once the schedule_on_each_cpu
returned. But that's more complexity.


-Andi
