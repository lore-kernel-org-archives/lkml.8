Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99468C11D25
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 680A824650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 00:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582246542;
	bh=vAQyARVfu9oqOzLyqVmfAikW+oYvYjWILRZBPPE0B5Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tYZAEm8nIgcBYoQQtam1axRkZQx7v7lEk9kpZ7NGr6SrlcBsZziKFKanEctNDRJPu
	 jetyBFFBWcXUtBy0qvvPzURl0P8pMWAdqZRhv+0pOm9mHmd+yU/EDx9h76ER+evKSF
	 G4w/AhOdr3UZuZV90BJdmGI7vRGCEbZneI+EKD+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729504AbgBUAzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 19:55:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:50040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729365AbgBUAzk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 19:55:40 -0500
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE1D1206EF;
        Fri, 21 Feb 2020 00:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582246540;
        bh=vAQyARVfu9oqOzLyqVmfAikW+oYvYjWILRZBPPE0B5Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dgccy3Rk/igP1hU3ILpjD5ruzaCS2eOXdWNPdQfYu+xig2CcOl9CHRGvorw3NkwTp
         Gsq9FRE1D0iWE2sJ7Csk4Yc45w8KIV27VNU2m5cajIvERIpfOpZLMlz0NaTsNejmUf
         DUDNXapGVQnks4mRAWFYn8I9tn3sNzHYdYN2WX5A=
Date:   Thu, 20 Feb 2020 16:55:39 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Zi Yan <ziy@nvidia.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: Fix possible PMD dirty bit lost in
 set_pmd_migration_entry()
Message-Id: <20200220165539.5082db4b3e97eee474b0dd5d@linux-foundation.org>
In-Reply-To: <20200220075220.2327056-1-ying.huang@intel.com>
References: <20200220075220.2327056-1-ying.huang@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Feb 2020 15:52:20 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> From: Huang Ying <ying.huang@intel.com>
> 
> In set_pmd_migration_entry(), pmdp_invalidate() is used to change PMD
> atomically.  But the PMD is read before that with an ordinary memory
> reading.  If the THP (transparent huge page) is written between the
> PMD reading and pmdp_invalidate(), the PMD dirty bit may be lost, and
> cause data corruption.  The race window is quite small, but still
> possible in theory, so need to be fixed.
> 
> The race is fixed via using the return value of pmdp_invalidate() to
> get the original content of PMD, which is a read/modify/write atomic
> operation.  So no THP writing can occur in between.
> 
> The race has been introduced when the THP migration support is added
> in the commit 616b8371539a ("mm: thp: enable thp migration in generic
> path").  But this fix depends on the commit d52605d7cb30 ("mm: do not
> lose dirty and accessed bits in pmdp_invalidate()").  So it's easy to
> be backported after v4.16.  But the race window is really small, so it
> may be fine not to backport the fix at all.

Thanks.  I'm inclined to add a cc:stable to this one.  Silent data corruption is
pretty serious.

