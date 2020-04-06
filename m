Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 910ECC2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:09:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63AAF22240
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 14:09:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eM0qDVJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728629AbgDFOJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 10:09:35 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34072 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbgDFOJe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 10:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Ohj/i/ogLT7GicyCIBoF5EnAvSBG2ciFGJNg8Qu9r/8=; b=eM0qDVJKBgxNmEu5HlJnfeNy5e
        UlumaPrTinMvTgddkfe7mW9Y/ZZ6FJbP+zwMJWO6YWtpI5tFPxG6M3TowfnET9lfRkgcUowWEXISv
        UcJEC+4kxb3hbsMKN1pPl2hJWpewrgsI7bBmf5oJYc0XFkh6JOHepeOIJDOp4HrciPM36PikXbqJL
        O43iywfTgOM3zpGHgBFQdr5lqmwa/mrn1TI9q2nYBlBVZ3CLCNvGlYaDTDpWkI16znEbVKESLafK7
        dTxUQvDNolhLkhgM+w0i0peLkkXLFRa2L3WTC8s8/jqoIo0tDoaglxDrDTCcVpyi5JcJFyxNVQllr
        hJbJYoiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jLSRP-0001tn-N5; Mon, 06 Apr 2020 14:09:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 390CF3010C8;
        Mon,  6 Apr 2020 16:09:30 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 270EC2BAC7486; Mon,  6 Apr 2020 16:09:30 +0200 (CEST)
Date:   Mon, 6 Apr 2020 16:09:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        dbueso@suse.de, juri.lelli@redhat.com,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] locking/percpu-rwsem: fix a task_struct refcount
Message-ID: <20200406140930.GN20730@hirez.programming.kicks-ass.net>
References: <20200330213002.2374-1-cai@lca.pw>
 <C6D137A2-15A9-49BC-BCE2-DA1202B5AC3A@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <C6D137A2-15A9-49BC-BCE2-DA1202B5AC3A@lca.pw>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 09:31:18AM -0400, Qian Cai wrote:
> 
> 
> > On Mar 30, 2020, at 5:30 PM, Qian Cai <cai@lca.pw> wrote:
> > 
> > The commit 7f26482a872c ("locking/percpu-rwsem: Remove the embedded
> > rwsem") introduced some task_struct memory leaks due to messing up with
> > a task_struct refcount. At the beginning of
> > percpu_rwsem_wake_function(), it calls get_task_struct(), but if the
> > trylock failed, it will remain in the waitqueue. However, it will run
> > percpu_rwsem_wake_function() again with get_task_struct() to increase
> > the refcount but then only call put_task_struct() once the trylock
> > succeeded.
> > 
> > Fix it by adjusting percpu_rwsem_wake_function() a bit to guard against
> > when percpu_rwsem_wait() observing !private, terminating the wait and
> > doing a quick exit() while percpu_rwsem_wake_function() then doing
> > wake_up_process(p) as a use-after-free.
> > 
> > Fixes: 7f26482a872c ("locking/percpu-rwsem: Remove the embedded rwsem")
> 
> Peter, Ingo, can you take a look at this patch when you have a chance?

I have it queued for urgent, should probably hit tip soon.
