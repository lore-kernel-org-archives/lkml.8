Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0804AC433E8
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB3B6207DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595558164;
	bh=223v+GvHabeD9/eJz4SlfQmngb87VspYTvdYp60L5p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xJRHx49mb5kUIQMGm1SW4nXo8qqIen9PJ4NqDAbs7dcHws/Qg1R3ughdAbkQOZ44y
	 OPpv7Szqa3k0qZSjfZykKeEEXtae3YPYfdgR5WXR8x2QIqURVPwUTXMF6a4wbpYZ1n
	 NklpJXLjYjFtYHp22jNXEInsrcVPslzgm/uebiAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbgGXCgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:36:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:35310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726437AbgGXCgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:36:01 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92AD62065E;
        Fri, 24 Jul 2020 02:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595558161;
        bh=223v+GvHabeD9/eJz4SlfQmngb87VspYTvdYp60L5p0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PRGZ/sQaneFPcE/dr8WewYV92zNf0JrkuKmUby4KKmxYk5Wk3t9fyobEZhizw2ZGE
         nUNrYrJ7SEy0F0/pBhR6kbH1cstLZq2zsDNLMSP34YP/le01QpVCwXnH8pPM5Xw0Cx
         ThElvUD47Ez0n09WQ9SFdlnXfRGIcsFlsJEaiDN0=
Date:   Thu, 23 Jul 2020 19:36:00 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joonsoo Kim <js1304@gmail.com>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team@lge.com,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2] mm/page_alloc: fix memalloc_nocma_{save/restore}
 APIs
Message-Id: <20200723193600.28e3eedd00925b22f7ca9780@linux-foundation.org>
In-Reply-To: <CAAmzW4N9Y4W7CHenWA=TYu9tttgpYR=ZN+ky1vmXPgUJcjitAw@mail.gmail.com>
References: <1595468942-29687-1-git-send-email-iamjoonsoo.kim@lge.com>
        <20200723180814.acde28b92ce6adc785a79120@linux-foundation.org>
        <CAAmzW4N9Y4W7CHenWA=TYu9tttgpYR=ZN+ky1vmXPgUJcjitAw@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Jul 2020 11:23:52 +0900 Joonsoo Kim <js1304@gmail.com> wrote:

> > > Second, clearing __GFP_MOVABLE in current_gfp_context() has a side effect
> > > to exclude the memory on the ZONE_MOVABLE for allocation target.
> >
> > More whoops.
> >
> > Could we please have a description of the end-user-visible effects of
> > this change?  Very much needed when proposing a -stable backport, I think.
> 
> In fact, there is no noticeable end-user-visible effect since the fallback would
> cover the problematic case. It's mentioned in the commit description. Perhap,
> performance would be improved due to reduced retry and more available memory
> (we can use ZONE_MOVABLE with this patch) but it would be neglectable.
> 
> > d7fefcc8de9147c is over a year old.  Why did we only just discover
> > this?  This makes one wonder how serious those end-user-visible effects
> > are?
> 
> As mentioned above, there is no visible problem to the end-user.

OK, thanks.  In that case, I don't believe that a stable backport is
appropriate?

(Documentation/process/stable-kernel-rules.rst)
