Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D085C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8F7A20780
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 00:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593563237;
	bh=s51hg7DVq4LITz9OJ0nBaJQcRxH37RA3OJVW6egZ62c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZkUMu7z/+ME9aTdqn0gWBpiaaTO8q16MtTJZ0chP5Etbv3YPyVIyyMeaRug5JGyqj
	 nBvWbrnzIZ+j0WPN63XRwodNEBuuDtauWgXgzF9khAkC36eUO8qBeM5gLitEZ8w8mf
	 C1Sb60xQPa/5cBfvZPy7Y+xmL8nJvofERUrt1SoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgGAA1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 20:27:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgGAA1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 20:27:15 -0400
Received: from X1 (071-093-078-081.res.spectrum.com [71.93.78.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF28D20771;
        Wed,  1 Jul 2020 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593563235;
        bh=s51hg7DVq4LITz9OJ0nBaJQcRxH37RA3OJVW6egZ62c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=adfbTt1JnkZmsaJpyxYWFFC5TwNnaUvfrvC/ABvv5qMkUC4i7a3g1wvXmJFM5qlp7
         qArBvp0Mu8FyTup6cc60fTTKzi3+HSd9ZNxhMZwg2AQEzIHKh4tHYpXvQ1djrqF/s7
         UqtRysuPnKOuUz5MTb8NTphpaFd/iZk0KRtRHYO4=
Date:   Tue, 30 Jun 2020 17:27:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] mm: Increase pagevec size on large system
Message-Id: <20200630172713.496590a923744c0e0160d36b@linux-foundation.org>
In-Reply-To: <6260c66e-68a3-ab3e-4bd9-4a290d068e1f@linux.intel.com>
References: <d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com>
        <20200627031304.GC25039@casper.infradead.org>
        <20200626204704.f023988699421db00e9bdab7@linux-foundation.org>
        <6260c66e-68a3-ab3e-4bd9-4a290d068e1f@linux.intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 09:57:42 -0700 Tim Chen <tim.c.chen@linux.intel.com> wrote:

> 
> 
> I am okay with Matthew's suggestion of keeping the stack pagevec size unchanged.
> Andrew, do you have a preference?
> 
> I was assuming that for people who really care about saving the kernel memory
> usage, they would make CONFIG_NR_CPUS small. I also have a hard time coming
> up with a better scheme.
> 
> Otherwise, we will have to adjust the pagevec size when we actually 
> found out how many CPUs we have brought online.  It seems like a lot
> of added complexity for going that route.

Even if we were to do this, the worst-case stack usage on the largest
systems might be an issue.  If it isn't then we might as well hard-wire
it to 31 elements anyway,

I dunno.  An extra 128 bytes of stack doesn't sound toooo bad, and the
performance benefit is significant.  Perhaps we just go with the
original patch.  If there are any on-stack pagevecs in the page reclaim
path then perhaps we could create a new mini-pagevec for just those.  or
look at simply removing the pagevec optimization in there altogether.
