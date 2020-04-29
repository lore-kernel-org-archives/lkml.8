Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF35C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:45:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 926242072A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726760AbgD2Kpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:45:40 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:64558 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbgD2Kpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:45:40 -0400
Received: from fsav404.sakura.ne.jp (fsav404.sakura.ne.jp [133.242.250.103])
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 03TAjHEc016517;
        Wed, 29 Apr 2020 19:45:17 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav404.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp);
 Wed, 29 Apr 2020 19:45:17 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav404.sakura.ne.jp)
Received: from [192.168.1.9] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
        (authenticated bits=0)
        by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 03TAjAE5016499
        (version=TLSv1.2 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 29 Apr 2020 19:45:16 +0900 (JST)
        (envelope-from penguin-kernel@i-love.sakura.ne.jp)
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <28e35a8b-400e-9320-5a97-accfccf4b9a8@suse.cz>
 <alpine.DEB.2.22.394.2004281436280.131129@chino.kir.corp.google.com>
 <31f1f84d-c5fe-824b-3c28-1a9ad69fcae5@suse.cz>
 <20200429090437.GX28637@dhcp22.suse.cz>
From:   Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Message-ID: <bcf6d15f-cbdb-8c45-6087-a0f2aab737c6@i-love.sakura.ne.jp>
Date:   Wed, 29 Apr 2020 19:45:07 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429090437.GX28637@dhcp22.suse.cz>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/04/29 18:04, Michal Hocko wrote:
> Completely agreed! The in kernel OOM killer is to deal with situations
> when memory is desperately depleted without any sign of a forward
> progress. If there is a reclaimable memory then we are not there yet.
> If a workload can benefit from early oom killing based on response time
> then we have facilities to achieve that (e.g. PSI).

Can PSI work even if userspace process cannot avoid reclaimable memory
allocations (e.g. page fault, file read) is already stalling? I'm not sure
whether PSI allows responding quickly enough to "keep reclaimable memory
allocations not to reclaim" despite there is still reclaimable memory...

