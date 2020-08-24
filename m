Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 688C0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:15:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D76B2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHXPPj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 11:15:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:42298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgHXPOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 11:14:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AA00AABCC;
        Mon, 24 Aug 2020 15:14:53 +0000 (UTC)
Date:   Mon, 24 Aug 2020 17:14:25 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Feng Tang <feng.tang@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        Mel Gorman <mgorman@suse.com>
Subject: Re: [LKP] Re: [x86/mce] 1de08dccd3: will-it-scale.per_process_ops
 -14.1% regression
Message-ID: <20200824151425.GF4794@zn.tnic>
References: <20200425114414.GU26573@shao2-debian>
 <20200425130136.GA28245@zn.tnic>
 <20200818082943.GA65567@shbuild999.sh.intel.com>
 <20200818200654.GA21494@agluck-desk2.amr.corp.intel.com>
 <20200819020437.GA2605@shbuild999.sh.intel.com>
 <20200821020259.GA90000@shbuild999.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200821020259.GA90000@shbuild999.sh.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 10:02:59AM +0800, Feng Tang wrote:
>   1de08dccd383 x86/mce: Add a struct mce.kflags field
>   9554bfe403bd x86/mce: Convert the CEC to use the MCE notifier
> 
> And strange thing is after using gcc9 and debian10 rootfs, with same commits
> the regression turns to a improvement,

How so?

> though the trend keeps, that if we
> changes the kflags from __u64 to __u32, the performance will be no change.
> 
> Following is the comparing of regression, I also attached the perf-profile
> for old and new commit (let me know if you need more data)
> 
> 
> 9554bfe403bdfc08 1de08dccd383482a3e88845d355 
> ---------------- --------------------------- 
>          %stddev     %change         %stddev
>              \          |                \  
>     192362           -15.1%     163343        will-it-scale.287.processes
>       0.91            +0.2%       0.92        will-it-scale.287.processes_idle
>     669.67           -15.1%     568.50        will-it-scale.per_process_ops

This is the data from your previous measurement:

9554bfe403bdfc08 1de08dccd383482a3e88845d355
---------------- ---------------------------
         %stddev     %change         %stddev
             \          |                \
    668.00           -14.1%     573.75        will-it-scale.per_process_ops

If I'm reading it correctly, commit

1de08dccd383 ("x86/mce: Add a struct mce.kflags field")

is still the slower one vs

9554bfe403bd ("x86/mce: Convert the CEC to use the MCE notifier")

Or am I misreading it?

In any case, this really looks like what Tony said: this enlargement of
struct mce pushes some variable into a cacheline-misaligned placement,
causing it to bounce.

The $ 10^6 question is, which variable is that...

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH, GF: Felix Imendörffer, HRB 36809, AG Nürnberg
