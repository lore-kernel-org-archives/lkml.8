Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5218C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A286A20771
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 11:23:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbgCYLXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 07:23:14 -0400
Received: from foss.arm.com ([217.140.110.172]:46892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727082AbgCYLXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 07:23:14 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD5D931B;
        Wed, 25 Mar 2020 04:23:13 -0700 (PDT)
Received: from mbp (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E68463F71F;
        Wed, 25 Mar 2020 04:23:12 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:23:10 +0000
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-team@android.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm/mremap: Add comment explaining the untagging
 behaviour of mremap()
Message-ID: <20200325112309.GM3901@mbp>
References: <20200325111347.32553-1-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325111347.32553-1-will@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 11:13:46AM +0000, Will Deacon wrote:
> Commit dcde237319e6 ("mm: Avoid creating virtual address aliases in
> brk()/mmap()/mremap()") changed mremap() so that only the 'old' address
> is untagged, leaving the 'new' address in the form it was passed from
> userspace. This prevents the unexpected creation of aliasing virtual
> mappings in userspace, but looks a bit odd when you read the code.
> 
> Add a comment justifying the untagging behaviour in mremap().
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
