Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 027F8C10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3B9206F1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 02:58:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584068332;
	bh=z0VmFDryNsJqsR+Vkt+HiPrOQWgZfMX+En2Wg0OzFic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=cAqvSDRAROv6NIuVX3iG/GZ3N83uUoQcgr/0wlz0BPsjSgDFHHguESdkWkJev/k5j
	 vm4aqY8FhpjK2nRDc5I9UYYa45RTrV38EADzB5luV58Mmewhqtyc2X7GZ41dtsNu+9
	 eYG5w94+wT6DQjIl+VTx7h3VrY2wgZcW4nGDnZWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCMC6v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 22:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:60022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726254AbgCMC6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 22:58:51 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DA68206B1;
        Fri, 13 Mar 2020 02:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584068330;
        bh=z0VmFDryNsJqsR+Vkt+HiPrOQWgZfMX+En2Wg0OzFic=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=raulPw5jVHpAQ3iFgheChtiTXV22pbjaSTA+as9HwVhsuzaUHREPZkp6gHzdYnWEh
         gzITLuVICfqdmffpj9iE8j3amyt8PUwf7siEcs0JVeXls5nCx2g6VrsTEYgg/4heMA
         p9bX2cPx/9oSRKm4O1cyP4NACNpGfWDfgJst+dEc=
Date:   Thu, 12 Mar 2020 19:58:50 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Souptick Joarder <jrdr.linux@gmail.com>
Cc:     jglisse@redhat.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/hmm.c : Remove additional check for
 lockdep_assert_held()
Message-Id: <20200312195850.29693d4e55ec27ae11443c0f@linux-foundation.org>
In-Reply-To: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com>
References: <1584065460-22205-1-git-send-email-jrdr.linux@gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Mar 2020 07:41:00 +0530 Souptick Joarder <jrdr.linux@gmail.com> wrote:

> walk_page_range() already has a check for lockdep_assert_held().
> So additional check for lockdep_assert_held() can be removed from
> hmm_range_fault().
> 
> ...
>
> --- a/mm/hmm.c
> +++ b/mm/hmm.c
> @@ -681,7 +681,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
>  	struct mm_struct *mm = range->notifier->mm;
>  	int ret;
>  
> -	lockdep_assert_held(&mm->mmap_sem);
>  
>  	do {
>  		/* If range is no longer valid force retry. */

It isn't very obvious that hmm_range_fault() is and will only be called
from walk_page_range() (is it?)

