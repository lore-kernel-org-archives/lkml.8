Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5F9C10F25
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E5792073D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 23:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583623029;
	bh=PQ1dJmyPmP9RuAp0Y48k7+4kdZe3kgJZTmHXrX4URZs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=GYyUzDIzHy6LAH057ALMGH2zdlxtgblqLo/7ZCpghaM4/iC7YwbpIWX61fx2FRLvr
	 R7PWx1uHiSvlSCbhBq9Ye5pXDL+D1fHCM21r5RnlyILI3wBv+HeLm7Y9dbajD5Uh0P
	 vkSFhYlvkvJ95YGHMxQs7SxiajABbE8jACPjAi80=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgCGXPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 18:15:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:40358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726138AbgCGXPo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 18:15:44 -0500
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 842FC20684;
        Sat,  7 Mar 2020 23:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583622942;
        bh=PQ1dJmyPmP9RuAp0Y48k7+4kdZe3kgJZTmHXrX4URZs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HDOFwUXDbu8m0PLMB596Ay74/Ju7AWtDzQ0JdQ/Lqnx264Rn/A2EvFZ0x+BTsNdrG
         U2mGGNQPx6Yl81L33rYIWiMiHKqPMlhPPFVR9z043LhQh0l1sfpvJ8a5vDuah7U8DD
         xXcRq6rVD0n5pO19BFgHhizEb2rXOtlr1M6Ts3IA=
Date:   Sat, 7 Mar 2020 15:15:42 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     mateusznosek0@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] mm/page_alloc.c: Micro-optimisation Remove
 unnecessary branch
Message-Id: <20200307151542.b14131037dc44a8edcb22cad@linux-foundation.org>
In-Reply-To: <20200307225335.31300-1-mateusznosek0@gmail.com>
References: <20200307225335.31300-1-mateusznosek0@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  7 Mar 2020 23:53:35 +0100 mateusznosek0@gmail.com wrote:

> From: Mateusz Nosek <mateusznosek0@gmail.com>
> 
> Previously if branch condition was false, the assignment was not executed.
> The assignment can be safely executed even when the condition is false and
> it is not incorrect as it assigns the value of 'nodemask' to 'ac.nodemask'
> which already has the same value.
> 
> So as the assignment can be executed unconditionally, the branch can be
> removed.
> 
> ...
>
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -4819,8 +4819,7 @@ __alloc_pages_nodemask(gfp_t gfp_mask, unsigned int order, int preferred_nid,
>  	 * Restore the original nodemask if it was potentially replaced with
>  	 * &cpuset_current_mems_allowed to optimize the fast-path attempt.
>  	 */
> -	if (unlikely(ac.nodemask != nodemask))
> -		ac.nodemask = nodemask;
> +	ac.nodemask = nodemask;
>  

This will now unconditionally dirty the ac.nodemask cacheline, which
means that cacheline will need to be written back.  If it is truly
unlikely that the write was needed then the thinking goes that the
test-and-branch is worthwhile, by saving on memory traffic.

At least, I assume that's why the code is the way it is.

I don't know whether this optimisation is valid on a majority of modern
platforms.  But that's the thinking!

