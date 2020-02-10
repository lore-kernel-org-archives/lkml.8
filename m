Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A057AC3B187
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:10:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67E18208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 23:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581376212;
	bh=GMlSyHOD9QLT8UtIuAMumsi1lPOatE/UQFlvjrcLBdQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=RVO2itVJdTCJA5Nt3lXMxYmrgouhfqz04YPLI8CpvCUdlnY+jbpGwtgMXcyH3iCln
	 FlqhZqQijwadezqnxIko5BeUXJ4sTUG7Bqco0mNEFdfw/SOVo+WLCr+V/j1wjtwtJ7
	 R1XX+j8EgubXVxN2MXYna/YmCdmVkik5Vgn5fvoE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgBJXKL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 18:10:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727522AbgBJXKL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 18:10:11 -0500
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DAE4D20733;
        Mon, 10 Feb 2020 23:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581376209;
        bh=GMlSyHOD9QLT8UtIuAMumsi1lPOatE/UQFlvjrcLBdQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mAwYbuB0fxDpY6hWRyFk6mzgJwOhPIBS1bGX40vUR46kPE1EX9KaVm0PjAReNflFB
         JBl+V6qC/DECA9RTqup2bPFbOKdYx7mMYtnOpQ7XsaF8CGdxACfA6KTd4oBPgj6K8E
         TKP7lWTJTGrUzdfoIrSXgP99z/EAmpA6asQgR070=
Date:   Mon, 10 Feb 2020 15:10:08 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 3/3] mm/slub: Fix potential deadlock problem in
 slab_attr_store()
Message-Id: <20200210151008.1c1d74c1876e363b729f5b1c@linux-foundation.org>
In-Reply-To: <0cb70f4a-7fa0-5567-02fc-955e0406a4e7@redhat.com>
References: <20200210204651.21674-1-longman@redhat.com>
        <20200210204651.21674-4-longman@redhat.com>
        <20200210140343.09ac0f5d841a0c9ed5034107@linux-foundation.org>
        <0cb70f4a-7fa0-5567-02fc-955e0406a4e7@redhat.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Feb 2020 17:14:31 -0500 Waiman Long <longman@redhat.com> wrote:

> >> --- a/mm/slub.c
> >> +++ b/mm/slub.c
> >> @@ -5536,7 +5536,12 @@ static ssize_t slab_attr_store(struct kobject *kobj,
> >>  	if (slab_state >= FULL && err >= 0 && is_root_cache(s)) {
> >>  		struct kmem_cache *c;
> >>  
> >> -		mutex_lock(&slab_mutex);
> >> +		/*
> >> +		 * Timeout after 100ms
> >> +		 */
> >> +		if (mutex_timed_lock(&slab_mutex, 100) < 0)
> >> +			return -EBUSY;
> >> +
> > Oh dear.  Surely there's a better fix here.  Does slab really need to
> > hold slab_mutex while creating that sysfs file?  Why?
> >
> > If the issue is two threads trying to create the same sysfs file
> > (unlikely, given that both will need to have created the same cache)
> > then can we add a new mutex specifically for this purpose?
> >
> > Or something else.
> >
> Well, the current code iterates all the memory cgroups to set the same
> value in all of them. I believe the reason for holding the slab mutex is
> to make sure that memcg hierarchy is stable during this iteration
> process.

But that is unrelated to creation of the sysfs file?
