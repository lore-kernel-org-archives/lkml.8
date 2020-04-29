Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D0F7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBBA72076B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 07:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbgD2Hvn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 03:51:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:35452 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726355AbgD2Hvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 03:51:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 486F0ABD7;
        Wed, 29 Apr 2020 07:51:40 +0000 (UTC)
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     David Rientjes <rientjes@google.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <28e35a8b-400e-9320-5a97-accfccf4b9a8@suse.cz>
 <alpine.DEB.2.22.394.2004281436280.131129@chino.kir.corp.google.com>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <31f1f84d-c5fe-824b-3c28-1a9ad69fcae5@suse.cz>
Date:   Wed, 29 Apr 2020 09:51:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2004281436280.131129@chino.kir.corp.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/20 11:48 PM, David Rientjes wrote:
> On Tue, 28 Apr 2020, Vlastimil Babka wrote:
> 
> Yes, order-0 reclaim capture is interesting since the issue being reported 
> here is userspace going out to lunch because it loops for an unbounded 
> amount of time trying to get above a watermark where it's allowed to 
> allocate and other consumers are depleting that resource.
> 
> We actually prefer to oom kill earlier rather than being put in a 
> perpetual state of aggressive reclaim that affects all allocators and the 
> unbounded nature of those allocations leads to very poor results for 
> everybody.

Sure. My vague impression is that your (and similar cloud companies) kind of
workloads are designed to maximize machine utilization, and overshooting and
killing something as a result is no big deal. Then you perhaps have more
probability of hitting this state, and on the other hand, even an occasional
premature oom kill is not a big deal?

My concers are workloads not designed in such a way, where premature oom kill
due to temporary higher reclaim activity together with burst of incoming network
packets will result in e.g. killing an important database. There, the tradeoff
looks different.

> I'm happy to scope this solely to an order-0 reclaim capture.  I'm not 
> sure if I'm clear on whether this has been worked on before and patches 
> existed in the past?

Andrew mentioned some. I don't recall any, so it might have been before my time.

> Somewhat related to what I described in the changelog: we lost the "page 
> allocation stalls" artifacts in the kernel log for 4.15.  The commit 
> description references an asynchronous mechanism for getting this 
> information; I don't know where this mechanism currently lives.
> 

