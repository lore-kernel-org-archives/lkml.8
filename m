Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768D6C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 03:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 516B42081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 03:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593229627;
	bh=7M/aFJ4oCOEcKIXVhUAL7PKvd2xl0X++eFKfo6b95LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=oJKIjXiPX1DILR3UDFsYum39nhp2Mpk2egzVCbUbkTv63yYcQ0+RJ6P04L7u+yJAG
	 14kgBqcBwrqpDJ2leN2pUzSRqhu+PNcFhXakJGTyVRyzyMBcF+B/rrtRKAO2/i3ed4
	 rHIkd7dUHy52DHAXqg9WTQL/z5w211bn32VGSrkI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgF0DrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 23:47:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:47322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbgF0DrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 23:47:05 -0400
Received: from X1 (nat-ab2241.sltdut.senawave.net [162.218.216.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E39712073E;
        Sat, 27 Jun 2020 03:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593229625;
        bh=7M/aFJ4oCOEcKIXVhUAL7PKvd2xl0X++eFKfo6b95LY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bUr8sMsxHrVrBaccYyd85cCqLAtEnJmUNoxmm8PZWhwZHcc1jK7BN4eRWytH9bhos
         OmlGTTxNjjajBsmYLsSq7wQIeFy3Q+XzmFVun188tt8rZHUzX0XziHzXUHD6TPRkYX
         9Lv0CH1dAtiKWACeliqstPy+PlbMQcAC2ldm8GnQ=
Date:   Fri, 26 Jun 2020 20:47:04 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        Vladimir Davydov <vdavydov@virtuozzo.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.cz>,
        Dave Hansen <dave.hansen@intel.com>,
        Ying Huang <ying.huang@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [Patch] mm: Increase pagevec size on large system
Message-Id: <20200626204704.f023988699421db00e9bdab7@linux-foundation.org>
In-Reply-To: <20200627031304.GC25039@casper.infradead.org>
References: <d1cc9f12a8ad6c2a52cb600d93b06b064f2bbc57.1593205965.git.tim.c.chen@linux.intel.com>
        <20200627031304.GC25039@casper.infradead.org>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Jun 2020 04:13:04 +0100 Matthew Wilcox <willy@infradead.org> wrote:

> On Fri, Jun 26, 2020 at 02:23:03PM -0700, Tim Chen wrote:
> > Enlarge the pagevec size to 31 to reduce LRU lock contention for
> > large systems.
> > 
> > The LRU lock contention is reduced from 8.9% of total CPU cycles
> > to 2.2% of CPU cyles.  And the pmbench throughput increases
> > from 88.8 Mpages/sec to 95.1 Mpages/sec.
> 
> The downside here is that pagevecs are often stored on the stack (eg
> truncate_inode_pages_range()) as well as being used for the LRU list.
> On a 64-bit system, this increases the stack usage from 128 to 256 bytes
> for this array.
> 
> I wonder if we could do something where we transform the ones on the
> stack to DECLARE_STACK_PAGEVEC(pvec), and similarly DECLARE_LRU_PAGEVEC
> the ones used for the LRUs.  There's plenty of space in the header to
> add an unsigned char sz, delete PAGEVEC_SIZE and make it an variable
> length struct.
> 
> Or maybe our stacks are now big enough that we just don't care.
> What do you think?

And I wonder how useful CONFIG_NR_CPUS is for making this decision. 
Presumably a lot of general-purpose kernel builds have CONFIG_NR_CPUS
much larger than the actual number of CPUs.

I can't think of much of a fix for this, apart from making it larger on
all kernels, Is there a downside to this?

