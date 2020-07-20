Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F049C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:23:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5492C21702
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 23:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595287396;
	bh=CmjiBtNa6KB4IjS9/V99TRrvKhtZXBHGyuXzHFKf9oI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=kiZQLg/7yhZ59SDrZu8sTNjL8BPtX6bbvIO0gpyBIXp8K18ydd4+pc7ySsC2rnGXl
	 Kj0o5SyFRqMJmYzcNZepts3/tCO5D1w+xHbJreoZASAsWK/wSIolmxL8QGPc3KKrjI
	 qI6izkLxzOjw5bpGuuGfx8ss4eDzN8OxZ7O8SqEw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgGTXXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 19:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:50194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgGTXXP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 19:23:15 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 497C32080D;
        Mon, 20 Jul 2020 23:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595287394;
        bh=CmjiBtNa6KB4IjS9/V99TRrvKhtZXBHGyuXzHFKf9oI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jzXMKwtfn5KFI0f04Uvy84IaDuRB8NTrky6Xp9lzKW3GFzqjGlpfUF0RVQRmSEpsD
         d5XeamDDBR0ktCVRI9C11mNj7NVPRE8sOHpSnsydSzAHnoGp+xmt7oEHXw/RG+PXyq
         0SLcONObYH9PwSUwuqyBpGuAtUlwuDiEpghdysNA=
Date:   Mon, 20 Jul 2020 16:23:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     js1304@gmail.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com, Vlastimil Babka <vbabka@suse.cz>,
        Christoph Hellwig <hch@infradead.org>,
        Roman Gushchin <guro@fb.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Michal Hocko <mhocko@suse.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, stable@vger.kernel.org
Subject: Re: [PATCH v2 1/4] mm/page_alloc: fix non cma alloc context
Message-Id: <20200720162313.1381e1ec82daa6a92ae4cda7@linux-foundation.org>
In-Reply-To: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
References: <1595220978-9890-1-git-send-email-iamjoonsoo.kim@lge.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jul 2020 13:56:15 +0900 js1304@gmail.com wrote:

> Currently, preventing cma area in page allocation is implemented by using
> current_gfp_context(). However, there are two problems of this
> implementation.
> 
> First, this doesn't work for allocation fastpath. In the fastpath,
> original gfp_mask is used since current_gfp_context() is introduced in
> order to control reclaim and it is on slowpath.
> Second, clearing __GFP_MOVABLE has a side effect to exclude the memory
> on the ZONE_MOVABLE for allocation target.
> 
> To fix these problems, this patch changes the implementation to exclude
> cma area in page allocation. Main point of this change is using the
> alloc_flags. alloc_flags is mainly used to control allocation so it fits
> for excluding cma area in allocation.
> 
> Fixes: d7fefcc8de91 (mm/cma: add PF flag to force non cma alloc)
> Cc: <stable@vger.kernel.org>

This patch is against linux-next (or -mm) and has a lot of issues
applying to mainline.  If we indeed wish to backport it to -stable, it
should be against mainline, please.
