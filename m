Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF021C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:30:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9413820728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 08:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgD0Iag convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 04:30:36 -0400
Received: from seldsegrel01.sonyericsson.com ([37.139.156.29]:15282 "EHLO
        SELDSEGREL01.sonyericsson.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgD0Iag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 04:30:36 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 27 Apr 2020 04:30:35 EDT
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start failing
 soon
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>
CC:     Vlastimil Babka <vbabka@suse.cz>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
 <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
From:   peter enderborg <peter.enderborg@sony.com>
Message-ID: <7726e8a8-8390-cee8-3480-4e68bf26f08a@sony.com>
Date:   Mon, 27 Apr 2020 10:20:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
Content-Language: en-GB
X-SEG-SpamProfiler-Analysis: v=2.3 cv=Nc2YKFL4 c=1 sm=1 tr=0 a=kIrCkORFHx6JeP9rmF/Kww==:117 a=IkcTkHD0fZMA:10 a=cl8xLZFz6L8A:10 a=1XWaLZrsAAAA:8 a=_KWB5BKwUhRobCCBmOoA:9 a=QEXdDO2ut3YA:10
X-SEG-SpamProfiler-Score: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/20 2:27 AM, Andrew Morton wrote:
> On Fri, 24 Apr 2020 13:48:06 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:
>
>> If GFP_ATOMIC allocations will start failing soon because the amount of
>> free memory is substantially under per-zone min watermarks, it is better
>> to oom kill a process rather than continue to reclaim.
>>
>> This intends to significantly reduce the number of page allocation
>> failures that are encountered when the demands of user and atomic
>> allocations overwhelm the ability of reclaim to keep up.  We can see this
>> with a high ingress of networking traffic where memory allocated in irq
>> context can overwhelm the ability to reclaim fast enough such that user
>> memory consistently loops.  In that case, we have reclaimable memory, and
> "user memory allocation", I assume?  Or maybe "blockable memory
> allocatoins".
>
>> reclaiming is successful, but we've fully depleted memory reserves that
>> are allowed for non-blockable allocations.
>>
>> Commit 400e22499dd9 ("mm: don't warn about allocations which stall for
>> too long") removed evidence of user allocations stalling because of this,
>> but the situation can apply anytime we get "page allocation failures"
>> where reclaim is happening but per-zone min watermarks are starved:
>>
>> Node 0 Normal free:87356kB min:221984kB low:416984kB high:611984kB active_anon:123009936kB inactive_anon:67647652kB active_file:429612kB inactive_file:209980kB unevictable:112348kB writepending:260kB present:198180864kB managed:195027624kB mlocked:81756kB kernel_stack:24040kB pagetables:11460kB bounce:0kB free_pcp:940kB local_pcp:96kB free_cma:0kB
>> lowmem_reserve[]: 0 0 0 0
>> Node 1 Normal free:105616kB min:225568kB low:423716kB high:621864kB active_anon:122124196kB inactive_anon:74112696kB active_file:39172kB inactive_file:103696kB unevictable:204480kB writepending:180kB present:201326592kB managed:198174372kB mlocked:204480kB kernel_stack:11328kB pagetables:3680kB bounce:0kB free_pcp:1140kB local_pcp:0kB free_cma:0kB
>> lowmem_reserve[]: 0 0 0 0
>>
>> Without this patch, there is no guarantee that user memory allocations
>> will ever be successful when non-blockable allocations overwhelm the
>> ability to get above per-zone min watermarks.
>>
>> This doesn't solve page allocation failures entirely since it's a
>> preemptive measure based on watermarks that requires concurrent blockable
>> allocations to trigger the oom kill.  To complete solve page allocation
>> failures, it would be possible to do the same watermark check for non-
>> blockable allocations and then queue a worker to asynchronously oom kill
>> if it finds watermarks to be sufficiently low as well.
>>
> Well, what's really going on here?
>
> Is networking potentially consuming an unbounded amount of memory?  If
> so, then killing a process will just cause networking to consume more
> memory then hit against the same thing.  So presumably the answer is
> "no, the watermarks are inappropriately set for this workload".
>
> So would it not be sensible to dynamically adjust the watermarks in
> response to this condition?  Maintain a larger pool of memory for these
> allocations?  Or possibly push back on networking and tell it to reduce
> its queue sizes?  So that stuff doesn't keep on getting oom-killed?
>
I think I seen similar issues when dma-buf allocate a lot.  But that is on older kernels and out of tree.
So networking is maybe not the only cause. dma-buf are used a lot for camera stuff in android.

