Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD553C4BA35
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5511208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:47:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WipzyxYr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbgB0Bre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:47:34 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39127 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728091AbgB0Brd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:47:33 -0500
Received: by mail-pj1-f67.google.com with SMTP id e9so441419pjr.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 17:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=AE6889q2qb8rpie85RPam0pI5EqkhHNnHAqyKfAYF6g=;
        b=WipzyxYr6BpGAd3Fs5g7ugMep4T529oPKLg3EHu7DidhKJzzpQyR7O6iM3OuPa1P1Q
         4vufBh0VEUSWsF6Nm0B049A+EKJ1ek3nyzvIFDyrsaxcahNuLUQUgymD3lVotHe1C4ij
         21wZlxLBJNWqrW6ajkLFAe+GhCxdvgT1ljLxyz1iNrTLaZGgQS1DaQY/EYbdXPYzEZEb
         cvHpnSGrZ4ABTn1EkmtHbqzi6y+ermUVTHPjIo7NH3Os6a3UCfgNnApIXHPrFUcr3ZYg
         h1+gESfWpcGIxn/VLhppFZmTxXpxF1DuLI+vF6As93owBNIboO0EKGt7GRwrSgZZallJ
         vLGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=AE6889q2qb8rpie85RPam0pI5EqkhHNnHAqyKfAYF6g=;
        b=bMy1VDWnhsS7BKiySmOTDeFQshLLjTLMLcRnCVjiG2ouK0F8IppuaVBylRzIu1vLSm
         2yVy71T9s/4KgK/ffMDN+wUckS7Er9lWQBXXdGyRymf88g5uQCSqTU2LKVU6BQATawfx
         4zLnfLXj/Ly5PGmsEe8tkVnb3wE9Q+GTEIWQuik4D/GkugwVUQ9Vzq+2hurJYbR1KcCV
         NbCgyVMBEgwv0PdXFV6zKIQOqeoY7x/hgG6XtnNy+5Cifb8JFl6TQ5M5xbaRJEOUILOt
         bTnalngLSGrzs9M6aUgL0n8SCPouFPZfvrJFk+N4DpSmZkl08fHc5WDD2uygmh0TzD+q
         x9UQ==
X-Gm-Message-State: APjAAAX7tFhvtzie6+RlGTSJVQ08HKMYgwSiLblMCb3ZpUHUfmFmnzNB
        jRW9TE3VFwqwyWH1x8y30ePM7Q==
X-Google-Smtp-Source: APXvYqzsL2huyAGMkpt+mb/l/fm0hl5JvyoDs1hla941bElVQ8Uin2dKH9hhhnr2w8Wq8KTtHlxCsQ==
X-Received: by 2002:a17:902:c509:: with SMTP id o9mr2160608plx.112.1582768052287;
        Wed, 26 Feb 2020 17:47:32 -0800 (PST)
Received: from [100.112.92.218] ([104.133.9.106])
        by smtp.gmail.com with ESMTPSA id l12sm3983547pgj.16.2020.02.26.17.47.31
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 26 Feb 2020 17:47:31 -0800 (PST)
Date:   Wed, 26 Feb 2020 17:47:16 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Matthew Wilcox <willy@infradead.org>
cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
In-Reply-To: <20200227011654.GF24185@bombadil.infradead.org>
Message-ID: <alpine.LSU.2.11.2002261741340.1640@eggly.anvils>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com> <alpine.LSU.2.11.1912041601270.12930@eggly.anvils> <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com> <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
 <cba16817-8555-f84f-134a-1ff9f168247b@linux.alibaba.com> <20200227011654.GF24185@bombadil.infradead.org>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Feb 2020, Matthew Wilcox wrote:
> On Wed, Feb 26, 2020 at 09:43:53AM -0800, Yang Shi wrote:
> > > No.  The pagevec_lookup_entries() calls from mm/truncate.c prefer the
> > > new behavior - evicting the head from page cache removes all the tails
> > > along with it, so getting the tails a waste of time there too, just as
> > > it was in shmem_undo_range().
> > 
> > TBH I'm not a fun of this hack. This would bring in other confusion or
> > complexity. Pagevec is supposed to count in the number of base page, now it
> > would treat THP as one page, and there might be mixed base page and THP in
> > one pagevec. But, I tend to agree avoiding getting those 14 extra pins at
> > the first place might be a better approach. All the complexity are used to
> > release those extra pins.
> 
> My long-term goal is to eradicate tail pages entirely, so a pagevec will
> end up containing pages of different sizes.  If you want to help move
> in this direction, I'd be awfully grateful.  But I wouldn't say that's
> in any way a prerequisite for fixing this current problem.

You're right to be moving in that direction, but yes, that is a larger
task, and I think both Yang and I have to decline your awful gratitude :)

Hugh
