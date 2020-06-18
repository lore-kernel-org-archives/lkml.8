Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52736C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0232080D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 16:07:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PA0DSmCS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbgFRQHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 12:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbgFRQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:07:37 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC2FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 09:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ha7fs+QSSRN9/6GlJ/iZ8nziBvAdCL8+tJH7EfoHfsc=; b=PA0DSmCSbCE2zL7zLzxAot1f1b
        40l0H0B2fFBpw6I6+cfF4PBJPKczztvcsYkL3BG7HqGfD2RQSNnx2q43rP0gHO4OLaqTQKNIiIAA0
        nxohwjneA+1O7tZ1AOCosyZRtZuTQH3crQSUBzARS/+7rXn34EqLkROpZUgmuj1RnrXXe1HWYVSUy
        3TV5zFwZftto1hRxx11JVM3Xg/skgIDtErEferse9R5pvcNSiCpxmEKa+Ez7nkARYWpW28DrtEdpB
        86Pe/yz6Gt21GkAh6XJgqXgRwAAveFSZ5dCxT1rPohUUwOWagiIEMCXbG2z0eX0ixopslkTG2JToq
        L9xYFm7g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlx4a-00007z-1P; Thu, 18 Jun 2020 16:07:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 513C3301A32;
        Thu, 18 Jun 2020 18:07:26 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 097DE20C227B5; Thu, 18 Jun 2020 18:07:26 +0200 (CEST)
Date:   Thu, 18 Jun 2020 18:07:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Michel Lespinasse <walken@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched, mm: Optimize current_gfp_context()
Message-ID: <20200618160726.GL576905@hirez.programming.kicks-ass.net>
References: <20200618155847.30975-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200618155847.30975-1-longman@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18, 2020 at 11:58:47AM -0400, Waiman Long wrote:
> The current_gfp_context() converts a number of PF_MEMALLOC_* per-process
> flags into the corresponding GFP_* flags for memory allocation. In
> that function, current->flags is accessed 3 times. That may lead to
> duplicated access of the same memory location.
> 
> This is not usually a problem with minimal debug config options on as the
> compiler can optimize away the duplicated memory accesses.  With most
> of the debug config options on, however, that may not be the case.
> For example, the x86-64 object size of the __need_fs_reclaim() in a
> debug kernel that calls current_gfp_context() was 309 bytes. With this
> patch applied, the object size is reduced to 202 bytes. This is a saving
> of 107 bytes and will probably be slightly faster too.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>
> ---
>  include/linux/sched/mm.h | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index 480a4d1b7dd8..09e01909d192 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -181,18 +181,20 @@ static inline bool in_vfork(struct task_struct *tsk)
>   */
>  static inline gfp_t current_gfp_context(gfp_t flags)
>  {
> -	if (unlikely(current->flags &
> +	unsigned int pflags = current->flags;

Per the above, I would've expected a READ_ONCE() there, otherwise the
compiler can still re-load.
