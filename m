Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00CE8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3C720897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 00:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438223AbgE2Anm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 20:43:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:8370 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438025AbgE2Ank (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 20:43:40 -0400
IronPort-SDR: GcVXFS4kucwKukI5Ciby9x4neJHbIgwJLUaXYoLUctImvMGEkXlTdMDofNf2VA2Z63XYjfRgEz
 1JuYeQ7OxMXw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2020 17:43:38 -0700
IronPort-SDR: PqaarzZX7Yi1osYCcs7IgzXMAASpDZMBRF6CNogT0QED7yi3P//iQycjIXikmyhqIMDmyw6MDZ
 fv1uywGLbzLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,446,1583222400"; 
   d="scan'208";a="256344144"
Received: from yhuang-dev.sh.intel.com (HELO yhuang-dev) ([10.239.159.23])
  by orsmga007.jf.intel.com with ESMTP; 28 May 2020 17:43:35 -0700
From:   "Huang\, Ying" <ying.huang@intel.com>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH -V3] swap: Reduce lock contention on swap cache from swap slots allocation
References: <20200525002648.336325-1-ying.huang@intel.com>
        <20200528013724.flx6pwcmaazpek32@ca-dmjordan1.us.oracle.com>
        <87h7w0hbev.fsf@yhuang-dev.intel.com>
        <20200528171141.k3lc3mf7taqadv3v@ca-dmjordan1.us.oracle.com>
Date:   Fri, 29 May 2020 08:43:35 +0800
In-Reply-To: <20200528171141.k3lc3mf7taqadv3v@ca-dmjordan1.us.oracle.com>
        (Daniel Jordan's message of "Thu, 28 May 2020 13:11:41 -0400")
Message-ID: <87d06nh8p4.fsf@yhuang-dev.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Jordan <daniel.m.jordan@oracle.com> writes:

> On Thu, May 28, 2020 at 01:32:40PM +0800, Huang, Ying wrote:
>> Daniel Jordan <daniel.m.jordan@oracle.com> writes:
>> 
>> > On Mon, May 25, 2020 at 08:26:48AM +0800, Huang Ying wrote:
>> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
>> >> index 423c234aca15..0abd93d2a4fc 100644
>> >> --- a/mm/swapfile.c
>> >> +++ b/mm/swapfile.c
>> >> @@ -615,7 +615,8 @@ static bool scan_swap_map_try_ssd_cluster(struct swap_info_struct *si,
>> >>  			 * discarding, do discard now and reclaim them
>> >>  			 */
>> >>  			swap_do_scheduled_discard(si);
>> >> -			*scan_base = *offset = si->cluster_next;
>> >> +			*scan_base = this_cpu_read(*si->cluster_next_cpu);
>> >> +			*offset = *scan_base;
>> >>  			goto new_cluster;
>> >
>> > Why is this done?  As far as I can tell, the values always get overwritten at
>> > the end of the function with tmp and tmp isn't derived from them.  Seems
>> > ebc2a1a69111 moved some logic that used to make sense but doesn't have any
>> > effect now.
>> 
>> If we fail to allocate from cluster, "scan_base" and "offset" will not
>> be overridden.
>
> Ok, if another task races to allocate the clusters the first just discarded.
>
>> And "cluster_next" or "cluster_next_cpu" may be changed
>> in swap_do_scheduled_discard(), because the lock is released and
>> re-acquired there.
>
> I see, by another task on the same cpu for cluster_next_cpu.
>
> Both probably unlikely, but at least it tries to pick up where the racing task
> left off.  You might tack this onto the comment:
>
> 		 * discarding, do discard now and reclaim them, then reread
>                  * cluster_next_cpu since we dropped si->lock
>                 /*

Sure.  Will add this in the next version.

>> The code may not have much value.
>
> No, it makes sense.
>
>> > These aside, patch looks good to me.
>> 
>> Thanks for your review!  It really help me to improve the quality of the
>> patch.  Can I add your "Reviewed-by" in the next version?
>
> Sure,
> Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Thanks!

Best Regards,
Huang, Ying
