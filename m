Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A51AC83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:31:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3380C20731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgD2Ibp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:31:45 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:17564 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgD2Ibo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:31:44 -0400
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
 <alpine.DEB.2.22.394.2004261959310.80211@chino.kir.corp.google.com>
 <20200427133051.b71f961c1bc53a8e72c4f003@linux-foundation.org>
 <alpine.DEB.2.22.394.2004271558540.248401@chino.kir.corp.google.com>
 <20200427163558.5b08487d63da3cc7a89bf50b@linux-foundation.org>
 <20200428074301.GK28637@dhcp22.suse.cz>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <94f9b716-b251-79d8-2c8c-70d63a255496@sony.com>
Date:   Wed, 29 Apr 2020 10:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200428074301.GK28637@dhcp22.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Nc2YKFL4 c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=nE2D0_TFZUNrBZwinEYA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/28/20 9:43 AM, Michal Hocko wrote:
> On Mon 27-04-20 16:35:58, Andrew Morton wrote:
> [...]
>> No consumer of GFP_ATOMIC memory should consume an unbounded amount of
>> it.
>> Subsystems such as networking will consume a certain amount and
>> will then start recycling it.  The total amount in-flight will vary
>> over the longer term as workloads change.  A dynamically tuning
>> threshold system will need to adapt rapidly enough to sudden load
>> shifts, which might require unreasonable amounts of headroom.
> I do agree. __GFP_HIGH/__GFP_ATOMIC are bound by the size of the
> reserves under memory pressure. Then allocatios start failing very
> quickly and users have to cope with that, usually by deferring to a
> sleepable context. Tuning reserves dynamically for heavy reserves
> consumers would be possible but I am worried that this is far from
> trivial.
>
> We definitely need to understand what is going on here.  Why doesn't
> kswapd + N*direct reclaimers do not provide enough memory to satisfy
> both N threads + reserves consumers? How many times those direct
> reclaimers have to retry?

Was this not supposed to be avoided with PSI, user-space should
a fair change to take actions before it goes bad in user-space?


> We used to have the allocation stall warning as David mentioned in the
> patch description and I have seen it triggering without heavy reserves
> consumers (aka reported free pages corresponded to the min watermark).
> The underlying problem was usually kswapd being stuck on some FS locks,
> direct reclaimers stuck in shrinkers or way too overloaded system with
> dozens if not hundreds of processes stuck in the page allocator each
> racing with the reclaim and betting on luck. The last problem was the
> most annoying because it is really hard to tune for.


