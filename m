Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C7DC33CB2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEA2C2187F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 06:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbgAOGu7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 01:50:59 -0500
Received: from verein.lst.de ([213.95.11.211]:49204 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726018AbgAOGu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 01:50:59 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0255C68AFE; Wed, 15 Jan 2020 07:50:56 +0100 (CET)
Date:   Wed, 15 Jan 2020 07:50:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        stable@vger.kernel.org
Subject: Re: [PATCH] locking/rwsem: Fix kernel crash when spinning on
 RWSEM_OWNER_UNKNOWN
Message-ID: <20200115065055.GA21219@lst.de>
References: <20200114190303.5778-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114190303.5778-1-longman@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 14, 2020 at 02:03:03PM -0500, Waiman Long wrote:
> The commit 91d2a812dfb9 ("locking/rwsem: Make handoff writer
> optimistically spin on owner") will allow a recently woken up waiting
> writer to spin on the owner. Unfortunately, if the owner happens to be
> RWSEM_OWNER_UNKNOWN, the code will incorrectly spin on it leading to a
> kernel crash. This is fixed by passing the proper non-spinnable bits
> to rwsem_spin_on_owner() so that RWSEM_OWNER_UNKNOWN will be treated
> as a non-spinnable target.
> 
> Fixes: 91d2a812dfb9 ("locking/rwsem: Make handoff writer optimistically spin on owner")
> 
> Reported-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Waiman Long <longman@redhat.com>

This survives all the tests that showed the problems with the original
code:

Tested-by: Christoph Hellwig <hch@lst.de>

>  		if ((wstate == WRITER_HANDOFF) &&
> -		    (rwsem_spin_on_owner(sem, 0) == OWNER_NULL))
> +		    rwsem_spin_on_owner(sem, RWSEM_NONSPINNABLE) == OWNER_NULL)

Nit: the inner braces in the first half of the conditional aren't required
either.
