Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38660C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 086132084D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 00:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586393255;
	bh=2nhQyL/DP2Bqtl9oIGFAy7+8v5UeTnbKXjY+RkRbpl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=B0cztJZ4JykBxgAbaQ9ZM+78mpcKBXxMS1d80AGDpbmyYrxiXyac3V+gxKugSSQrJ
	 eUCe2S3OmGnspjGzVfT9PcCENNAyAzMBcYLr7J7erZLE9YlE7tht3i44m4hNKOnBF/
	 XcMqKqKaomBvpcHxLKKTaSlUdYnoExXpdSHCQx2w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgDIArd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 20:47:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726536AbgDIArd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 20:47:33 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0133720757;
        Thu,  9 Apr 2020 00:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586393253;
        bh=2nhQyL/DP2Bqtl9oIGFAy7+8v5UeTnbKXjY+RkRbpl8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=roVYxbKcHEORNwh41+mXf7j9wcK3jwv5iCNCc4AcMn2EHwtixACSDrRFahGBlKntG
         rvYwNqbwPt1aTZjAhJZFhzyytVcw10rC202Fnp4zLWhoxet3CAm2GACn5DRJzqfUCC
         T7UUxAg7xl1/HwHQXBJ8b3OSLZ460IPHgiOYVQMg=
Date:   Wed, 8 Apr 2020 17:47:32 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: [PATCH 0/2] mm: Two small fixes for recent syzbot reports
Message-Id: <20200408174732.bc448bbe41d190bfe5cc252e@linux-foundation.org>
In-Reply-To: <20200408014010.80428-1-peterx@redhat.com>
References: <20200408014010.80428-1-peterx@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  7 Apr 2020 21:40:08 -0400 Peter Xu <peterx@redhat.com> wrote:

> The two patches should fix below syzbot reports:
> 
>   BUG: unable to handle kernel paging request in kernel_get_mempolicy
>   https://lore.kernel.org/lkml/0000000000002b25f105a2a3434d@google.com/
> 
>   WARNING: bad unlock balance in __get_user_pages_remote
>   https://lore.kernel.org/lkml/00000000000005c65d05a2b90e70@google.com/

(Is there an email address for the syzbot operators?)

sysbot does test linux-next, yet these patches sat in linux-next for a
month without a peep, but all hell broke loose when they hit Linus's
tree.  How could this have happened?

Possibly I've been carrying a later patch which fixed all this up, but
I'm not seeing anything like that.  Nothing at all against mm/gup.c.

