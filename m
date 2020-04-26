Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81F1FC55186
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 522D92071E
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 00:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587860829;
	bh=38m9QbQ29W8cxPKCyfwNPKHx2orqrhU9h1meg+rxbrI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CC8Iyi9MHf+Lx0lLvZyoVCmMk0xp+Eh4wqSQwc9XHbsEzWs3ViDQKHekM6OE8bsXR
	 Iw1MgjBtsH0uZyxKtybBcQ1175uKYYyKjde7VjES9he3PsBPBBzpcgepW/CtLpROGU
	 XY2aNO8aZ4kAOZC7+Jrp3lfRGQHy8hGgqsjEzyQ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgDZA1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 20:27:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43076 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725962AbgDZA1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 20:27:08 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EA7D0206DD;
        Sun, 26 Apr 2020 00:27:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587860827;
        bh=38m9QbQ29W8cxPKCyfwNPKHx2orqrhU9h1meg+rxbrI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VJ5jshIg0z9Jvys8Zu9kJNoqX/1glzhTUOjXYMtiOQVGKM1R5N0ZKMwwjtfXOeOQr
         AOUdUd1D8crHJ1QUVSTIaOo9QxV5hNi5CsJlPc0g3OqzwTr2ow+Zg/hwO/pALATSs1
         sUccODQic2ONGGNQd/Th0vhOsZJP3FIXkCWCgshA=
Date:   Sat, 25 Apr 2020 17:27:06 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     David Rientjes <rientjes@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] mm, oom: stop reclaiming if GFP_ATOMIC will start
 failing soon
Message-Id: <20200425172706.26b5011293e8dc77b1dccaf3@linux-foundation.org>
In-Reply-To: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
References: <alpine.DEB.2.22.394.2004241347310.70176@chino.kir.corp.google.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 13:48:06 -0700 (PDT) David Rientjes <rientjes@google.com> wrote:

> If GFP_ATOMIC allocations will start failing soon because the amount of
> free memory is substantially under per-zone min watermarks, it is better
> to oom kill a process rather than continue to reclaim.
> 
> This intends to significantly reduce the number of page allocation
> failures that are encountered when the demands of user and atomic
> allocations overwhelm the ability of reclaim to keep up.  We can see this
> with a high ingress of networking traffic where memory allocated in irq
> context can overwhelm the ability to reclaim fast enough such that user
> memory consistently loops.  In that case, we have reclaimable memory, and

"user memory allocation", I assume?  Or maybe "blockable memory
allocatoins".

> reclaiming is successful, but we've fully depleted memory reserves that
> are allowed for non-blockable allocations.
> 
> Commit 400e22499dd9 ("mm: don't warn about allocations which stall for
> too long") removed evidence of user allocations stalling because of this,
> but the situation can apply anytime we get "page allocation failures"
> where reclaim is happening but per-zone min watermarks are starved:
> 
> Node 0 Normal free:87356kB min:221984kB low:416984kB high:611984kB active_anon:123009936kB inactive_anon:67647652kB active_file:429612kB inactive_file:209980kB unevictable:112348kB writepending:260kB present:198180864kB managed:195027624kB mlocked:81756kB kernel_stack:24040kB pagetables:11460kB bounce:0kB free_pcp:940kB local_pcp:96kB free_cma:0kB
> lowmem_reserve[]: 0 0 0 0
> Node 1 Normal free:105616kB min:225568kB low:423716kB high:621864kB active_anon:122124196kB inactive_anon:74112696kB active_file:39172kB inactive_file:103696kB unevictable:204480kB writepending:180kB present:201326592kB managed:198174372kB mlocked:204480kB kernel_stack:11328kB pagetables:3680kB bounce:0kB free_pcp:1140kB local_pcp:0kB free_cma:0kB
> lowmem_reserve[]: 0 0 0 0
> 
> Without this patch, there is no guarantee that user memory allocations
> will ever be successful when non-blockable allocations overwhelm the
> ability to get above per-zone min watermarks.
> 
> This doesn't solve page allocation failures entirely since it's a
> preemptive measure based on watermarks that requires concurrent blockable
> allocations to trigger the oom kill.  To complete solve page allocation
> failures, it would be possible to do the same watermark check for non-
> blockable allocations and then queue a worker to asynchronously oom kill
> if it finds watermarks to be sufficiently low as well.
> 

Well, what's really going on here?

Is networking potentially consuming an unbounded amount of memory?  If
so, then killing a process will just cause networking to consume more
memory then hit against the same thing.  So presumably the answer is
"no, the watermarks are inappropriately set for this workload".

So would it not be sensible to dynamically adjust the watermarks in
response to this condition?  Maintain a larger pool of memory for these
allocations?  Or possibly push back on networking and tell it to reduce
its queue sizes?  So that stuff doesn't keep on getting oom-killed?

