Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13025C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC73F2053B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgGGEAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:00:15 -0400
Received: from mga01.intel.com ([192.55.52.88]:35696 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbgGGEAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:00:15 -0400
IronPort-SDR: EL5K891okWa3Zw42xw/y3xJysEgvgVn8UL2B/TjGf/YfaVWHEbaPxMGGfq4gMbI/GhY5pU5wNZ
 cnASqNjhwTcw==
X-IronPort-AV: E=McAfee;i="6000,8403,9674"; a="165608383"
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="165608383"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 21:00:15 -0700
IronPort-SDR: Bo/InfGLqN0TlWhfWFo0SsTUfzuJI0eiYj8ODI9GklMTnb4KTuc+eYwfcioPM0FDskXl1dzeXD
 qeheRpxQJIDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,321,1589266800"; 
   d="scan'208";a="266711899"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by fmsmga007.fm.intel.com with ESMTP; 06 Jul 2020 21:00:10 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Feng Tang <feng.tang@intel.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Qian Cai <cai@lca.pw>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Dennis Zhou" <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        kernel test robot <rong.a.chen@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Kees Cook <keescook@chromium.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>, <tim.c.chen@intel.com>,
        <dave.hansen@intel.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <lkp@lists.01.org>
Subject: Re: [mm] 4e2c82a409: ltp.overcommit_memory01.fail
References: <20200705044454.GA90533@shbuild999.sh.intel.com>
        <FAAE2B23-2565-4F36-B278-018A5AD219EE@lca.pw>
        <20200705125854.GA66252@shbuild999.sh.intel.com>
        <20200705155232.GA608@lca.pw>
        <20200706014313.GB66252@shbuild999.sh.intel.com>
        <20200706023614.GA1231@lca.pw>
        <20200706132443.GA34488@shbuild999.sh.intel.com>
        <20200706133434.GA3483883@tassilo.jf.intel.com>
        <20200707023829.GA85993@shbuild999.sh.intel.com>
Date:   Tue, 07 Jul 2020 12:00:09 +0800
In-Reply-To: <20200707023829.GA85993@shbuild999.sh.intel.com> (Feng Tang's
        message of "Tue, 7 Jul 2020 10:38:29 +0800")
Message-ID: <87zh8c7z5i.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Feng Tang <feng.tang@intel.com> writes:

> On Mon, Jul 06, 2020 at 06:34:34AM -0700, Andi Kleen wrote:
>> >  	ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>> > -	if (ret == 0 && write)
>> > +	if (ret == 0 && write) {
>> > +		if (sysctl_overcommit_memory == OVERCOMMIT_NEVER)
>> > +			schedule_on_each_cpu(sync_overcommit_as);
>> 
>> The schedule_on_each_cpu is not atomic, so the problem could still happen
>> in that window.
>> 
>> I think it may be ok if it eventually resolves, but certainly needs
>> a comment explaining it. Can you do some stress testing toggling the
>> policy all the time on different CPUs and running the test on
>> other CPUs and see if the test fails?
>
> For the raw test case reported by 0day, this patch passed in 200 times
> run. And I will read the ltp code and try stress testing it as you
> suggested.
>
>
>> The other alternative would be to define some intermediate state
>> for the sysctl variable and only switch to never once the schedule_on_each_cpu
>> returned. But that's more complexity.
>
> One thought I had is to put this schedule_on_each_cpu() before
> the proc_dointvec_minmax() to do the sync before sysctl_overcommit_memory
> is really changed. But the window still exists, as the batch is
> still the larger one. 

Can we change the batch firstly, then sync the global counter, finally
change the overcommit policy?

Best Regards,
Huang, Ying
