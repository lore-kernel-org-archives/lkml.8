Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF1BCC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:17:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 893772467F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 01:17:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AHnBLjn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgB0BRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 20:17:02 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:59846 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727964AbgB0BRC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 20:17:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xzybkCZjTyLb0VqFQbFVRWtDGZw2aWyH8QFRYq4X5ek=; b=AHnBLjn3kbXNGq+iIcAM/IqPeG
        JZYPRLDzH7mPdDTuloPqFSuLzcF3h5TA8TZ4QYrkW8bWechx/eIpBwyF1LJay4svFJHUuFA648xqX
        wXZAFNIqO7iCCPjs+rOzUQb6vxKMzXp1PoZO2AhjwRwn1XeYj0Z6L3t8I4z3UNu9F+P6Nfl85cGmN
        y18ZvmzNBv3xFkEHZADGZ80vlsuzY3W2PuItl54mWN2ZiRqTGmO1a6b3jxPNt+8//WDbPzLS7TWW/
        lKx6yfrVHEpEa0aQKFGmANPhjbIdFBkBprRE9MrPO7uiMyYmJ/L4q26nIRVBhIHudGH8+KBXfyZ/u
        BDF+0EVQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j77nK-0003bv-44; Thu, 27 Feb 2020 01:16:54 +0000
Date:   Wed, 26 Feb 2020 17:16:54 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     Yang Shi <yang.shi@linux.alibaba.com>
Cc:     Hugh Dickins <hughd@google.com>, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH] mm: shmem: allow split THP when truncating THP
 partially
Message-ID: <20200227011654.GF24185@bombadil.infradead.org>
References: <1575420174-19171-1-git-send-email-yang.shi@linux.alibaba.com>
 <alpine.LSU.2.11.1912041601270.12930@eggly.anvils>
 <00f0bb7d-3c25-a65f-ea94-3e2de8e9bcdd@linux.alibaba.com>
 <alpine.LSU.2.11.2002241831060.3084@eggly.anvils>
 <cba16817-8555-f84f-134a-1ff9f168247b@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba16817-8555-f84f-134a-1ff9f168247b@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 09:43:53AM -0800, Yang Shi wrote:
> > No.  The pagevec_lookup_entries() calls from mm/truncate.c prefer the
> > new behavior - evicting the head from page cache removes all the tails
> > along with it, so getting the tails a waste of time there too, just as
> > it was in shmem_undo_range().
> 
> TBH I'm not a fun of this hack. This would bring in other confusion or
> complexity. Pagevec is supposed to count in the number of base page, now it
> would treat THP as one page, and there might be mixed base page and THP in
> one pagevec. But, I tend to agree avoiding getting those 14 extra pins at
> the first place might be a better approach. All the complexity are used to
> release those extra pins.

My long-term goal is to eradicate tail pages entirely, so a pagevec will
end up containing pages of different sizes.  If you want to help move
in this direction, I'd be awfully grateful.  But I wouldn't say that's
in any way a prerequisite for fixing this current problem.
