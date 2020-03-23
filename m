Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B794C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CCA420409
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:30:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCWPau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:30:50 -0400
Received: from foss.arm.com ([217.140.110.172]:51102 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727163AbgCWPat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:30:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9FD51FB;
        Mon, 23 Mar 2020 08:30:48 -0700 (PDT)
Received: from e107158-lin.cambridge.arm.com (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 206F43F7C3;
        Mon, 23 Mar 2020 08:30:48 -0700 (PDT)
Date:   Mon, 23 Mar 2020 15:30:45 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: lockdep warning in sys_swapon
Message-ID: <20200323153045.s7ag3lrvfe2cpiiw@e107158-lin.cambridge.arm.com>
References: <20200323151725.gayvs5g6h5adwqkd@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200323151725.gayvs5g6h5adwqkd@e107158-lin.cambridge.arm.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/20 15:17, Qais Yousef wrote:
> Hi
> 
> I hit the following 2 warnings when running with LOCKDEP=y on arm64 platform
> (juno-r2), running on v5.6-rc6
> 
> The 1st one is when I execute `swapon -a`. The 2nd one happens at boot. I have
> /dev/sda2 as my swap in /etc/fstab
> 
> Note that I either hit 1 OR 2, but didn't hit both warnings at the same time,
> yet at least.
> 
> /dev/sda2 is a usb flash drive, in case it matters somehow.

By the way, I noticed that in claim_swapfile() if we fail we don't release the
lock. Shouldn't we release the lock here?

I tried with that FWIW, but it had no effect on the warnings.


diff --git a/mm/swapfile.c b/mm/swapfile.c
index b2a2e45c9a36..0293e8c7b472 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -2900,8 +2900,10 @@ static int claim_swapfile(struct swap_info_struct *p, struct inode *inode)
        }

        inode_lock(inode);
-       if (IS_SWAPFILE(inode))
+       if (IS_SWAPFILE(inode)) {
+               inode_unlock(inode);
                return -EBUSY;
+       }

        return 0;
 }


Thanks

--
Qais Yousef
