Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3552C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:02:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AE7B2076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 05:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584507762;
	bh=2ai/f+HExg/ApogpjE3zkT/L3aUSunYoWnzd+8Jg+RI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=y8KEhynonk7pCS7m66NBPbYwxNrgJM0cl1msIzsJgPz3XmNYmf+55UWfc92CkPAsN
	 5wkwsq787yLR1bNHkEDMfOq+DK3Bq4Q0u6bODunR+UFs9J9VVwXCE0fn9//bPYIRF5
	 +uCfnIw6ADxoDwD9DiOQ6R/CpjVpeYLSdhJYiC/4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgCRFCk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 01:02:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726227AbgCRFCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 01:02:40 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DC6920753;
        Wed, 18 Mar 2020 05:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584507759;
        bh=2ai/f+HExg/ApogpjE3zkT/L3aUSunYoWnzd+8Jg+RI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CyUKijURxIrw7Y5hqK8b4MyGIuvBKQqzc0ShkeQnzfNeUP+XVtWHVxC/N+AMH+Nn4
         GrLlIg00R1sq2wptyRayLS6n0qP5J/MrmjaDlNXo63NeqLC558t0oP3tzKGcAbGiYX
         kd4pXRH6BdsYja5CQLpelJmQ4875uf4js+qHEwBc=
Date:   Tue, 17 Mar 2020 22:02:38 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Nishanth Aravamudan <nacc@us.ibm.com>,
        Nick Piggin <npiggin@suse.de>, Adam Litke <agl@us.ibm.com>,
        Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
Subject: Re: [PATCH] mm/hugetlb: Fix build failure with HUGETLB_PAGE but not
 HUGEBTLBFS
Message-Id: <20200317220238.8344f8423327c8ae178fc63a@linux-foundation.org>
In-Reply-To: <7e8c3a3c9a587b9cd8a2f146df32a421b961f3a2.1584432148.git.christophe.leroy@c-s.fr>
References: <7e8c3a3c9a587b9cd8a2f146df32a421b961f3a2.1584432148.git.christophe.leroy@c-s.fr>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Mar 2020 08:04:14 +0000 (UTC) Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> When CONFIG_HUGETLB_PAGE is set but not CONFIG_HUGETLBFS, the
> following build failure is encoutered:
> 
> In file included from arch/powerpc/mm/fault.c:33:0:
> ./include/linux/hugetlb.h: In function 'hstate_inode':
> ./include/linux/hugetlb.h:477:9: error: implicit declaration of function 'HUGETLBFS_SB' [-Werror=implicit-function-declaration]
>   return HUGETLBFS_SB(i->i_sb)->hstate;
>          ^
> ./include/linux/hugetlb.h:477:30: error: invalid type argument of '->' (have 'int')
>   return HUGETLBFS_SB(i->i_sb)->hstate;
>                               ^
> 
> Gate hstate_inode() with CONFIG_HUGETLBFS instead of CONFIG_HUGETLB_PAGE.
> 
> Reported-by: kbuild test robot <lkp@intel.com>
> Link: https://patchwork.ozlabs.org/patch/1255548/#2386036
> Fixes: a137e1cc6d6e ("hugetlbfs: per mount huge page sizes")

A 12 year old build error?  If accurate, that has to be a world record.

> Cc: stable@vger.kernel.org

I think I'll remove this.  Obviously nobody is suffering from this problem!


