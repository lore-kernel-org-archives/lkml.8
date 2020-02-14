Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9306DC3B19F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1B424696
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581698060;
	bh=TF7nf8htivvgSQBa3WfkCeKmnRr4qYLJB2BHntFpgsg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hKcXFbac99baaMqaLG7Z7TXgaFpPuxRT/3Rnd8m8QVS/HhpN5p3KGRmvH9jcJRKm2
	 caj0nTD6j5cLW3TmgfUHNeRtxyIs18XrecBaXWZrmPRtko6LGY5t2vIJ5IohBuXHWu
	 q4YwPbX/PHwxB3d2GXtONxuutH5goam+zFraVDo0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393379AbgBNQZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:25:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405560AbgBNQXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:23:12 -0500
Received: from localhost (lfbn-ncy-1-985-231.w90-101.abo.wanadoo.fr [90.101.63.231])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E504924770;
        Fri, 14 Feb 2020 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581697392;
        bh=TF7nf8htivvgSQBa3WfkCeKmnRr4qYLJB2BHntFpgsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oOk2fHXEOYyF8ZVHHDptFYkVYiOqO+JumnNM/Ul3W+diwYvXoHi9mO06MBa8STRe/
         FPaoHCKMrZIn640djVle9q48Z+6ZHWmEUvOc/R4wJw4xB+JKSRilEp/SoLMN6Db8Ox
         EiQ7skBhoc+GalmUkl/m+2H+oYblHIie/fK9zpKg=
Date:   Fri, 14 Feb 2020 17:23:09 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCH] sched/vtime: Prevent unstable evaluation of
 WARN(vtime->state)
Message-ID: <20200214162308.GA25496@lenoir>
References: <20200123180849.28486-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123180849.28486-1-frederic@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 23, 2020 at 07:08:49PM +0100, Frederic Weisbecker wrote:
> From: Chris Wilson <chris@chris-wilson.co.uk>
> 
> As the vtime is sampled under loose seqcount protection by kcpustat, the
> vtime fields may change as the code flows. Where logic dictates a field
> has a static value, use a READ_ONCE.
> 
> Fixes: 74722bb223d0 ("sched/vtime: Bring up complete kcpustat accessor")
> Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>

Ping?
