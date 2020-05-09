Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5357EC47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:36:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29A2224967
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 00:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588984591;
	bh=Q+b8wj5IMigBWbjW6i+jyqgaD1IKhs4HTjZuryGG6LM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1GzqX7Koin+2Zy8XLH4ohnCcfVOY1W0WeukhOKNIBjuojFU1XAY7FaqjQ5sKnsoQd
	 CcibWaPf/JR4De2jrLLcfK+ld3U/66Ub0phmDN+q+qNTOHl9T2Myrh2t5I3ZcAZRAU
	 ZA7A4nQtWzdXJMW16OYN+cjqmW/79msYlMUzrq94=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgEIAga (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 20:36:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:47570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727878AbgEIAga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:36:30 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478F821473;
        Sat,  9 May 2020 00:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588984588;
        bh=Q+b8wj5IMigBWbjW6i+jyqgaD1IKhs4HTjZuryGG6LM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dZp7lwc3gBhD7PG5Kna5Grfef2QfryNCDqvZc034K7yEGdGv9LW4yaKubLNjiP2VA
         KGXcKkuzN3QZd1jbHwpPCSXmqSxCT1DgEhgpT7C6KFrWMTbeBqrQ35DCVjEebF/RWm
         LDsSsPqdijmPRfJxvM6tcISpCwVrMx6NbVkSpO4E=
Date:   Fri, 8 May 2020 17:36:27 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joe Perches <joe@perches.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: linux-next: Signed-off-bys missing for commits in the
 akpm-current tree
Message-Id: <20200508173627.eda3f18b808dd6728a273d8b@linux-foundation.org>
In-Reply-To: <20200509101919.36231cf9@canb.auug.org.au>
References: <20200509101919.36231cf9@canb.auug.org.au>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 9 May 2020 10:19:19 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> Commits
> 
>   a41ffad2df78 ("mm: free_area_init: allow defining max_zone_pfn in descending order")

Look OK to me?

https://ozlabs.org/~akpm/mmotm/broken-out/mm-free_area_init-allow-defining-max_zone_pfn-in-descending-order.patch

>   ed1e07587fb4 ("mm/gup.c: further document vma_permits_fault()")

Yeah, I wasn't sent a signoff.  Miles, please send?

>   da5d272cd01a ("checkpatch: test $GIT_DIR changes")

Yup, that's a play patch which I'm supposed to test.

> are missing a Signed-off-by from their authors (I haven't reported the
> -fix patches).
> 
> I guess the first one is actually a fix patch and will be rolled into
> its parent.
> 
> Also, the Link tag in this last one is invalid :-(

Private email ;).  If my testing is successful I guess we'll get a real
version of this.

