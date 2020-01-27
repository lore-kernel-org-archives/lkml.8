Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EFAC32771
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:51:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD16520702
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 08:51:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nUysRZ2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbgA0Iv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 03:51:26 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45758 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgA0IvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 03:51:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Yn/GTpCb0OIBfMv2AkCMyf0VwdmRzxwDf4wufMVGzYU=; b=nUysRZ2NHJGcmddL6fOmwfs/E
        Eh59jnwBl/tTr7E09nYdGIVbWyCSgx3gX4L8g6eMCW8rlCFY0N5p6kRFEm9ZuU6xOwam3YxZfhloE
        VCmqTnHASglkO06swZwvrIuoGdxXi5uVOIf4BlSvlS/XImwoWhXH/HjdudwEBTym1rM9mUYYOevLo
        iaEmJukP1k6G8vGHfqwvSu1JJHOb5h/ENIP6VGg8/EyN84peuOccvZbhFRX9DBVQ6J51kn8w54jWE
        y9RI0VGN+1q6o27CdQ5uYziqccrROjcvr55drac9hEkggA6zkDF2L1fTs1FrQAnKJWyFTyXRSmmDK
        PYFcGzXDQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iw076-0002M7-9i; Mon, 27 Jan 2020 08:51:22 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EE10302C0F;
        Mon, 27 Jan 2020 09:49:36 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5C806203D0DC8; Mon, 27 Jan 2020 09:51:18 +0100 (CET)
Date:   Mon, 27 Jan 2020 09:51:18 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mutex: Add missing annotations
Message-ID: <20200127085118.GJ14914@hirez.programming.kicks-ass.net>
References: <0/3>
 <cover.1579893447.git.jbi.octave@gmail.com>
 <8e8d93ee2125c739caabe5986f40fa2156c8b4ce.1579893447.git.jbi.octave@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e8d93ee2125c739caabe5986f40fa2156c8b4ce.1579893447.git.jbi.octave@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 08:12:20PM +0000, Jules Irenge wrote:
> Sparse reports false warnings and hide real warnings
> where mutex_lock() and mutex_unlock() are used within the kernel
> An example is within the kernel cgroup files
> where the below warnings are found
> |warning: context imbalance in cgroup_lock_and_drain_offline()
> | - wrong count at exit
> |warning: context imbalance in cgroup_procs_write_finish()
> |- wrong count at exit
> |warning: context imbalance in cgroup_procs_write_start()
> |- wrong count at exit.
> 
> To fix these,
> an __acquires(lock) is added to mutex_lock() declaration
> a __releases(lock) to mutex_unlock() declaration
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  include/linux/mutex.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index aca8f36dfac9..a8ab4029913e 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -162,7 +162,7 @@ do {									\
>  } while (0)
>  
>  #else
> -extern void mutex_lock(struct mutex *lock);
> +extern void mutex_lock(struct mutex *lock) __acquires(lock);
>  extern int __must_check mutex_lock_interruptible(struct mutex *lock);
>  extern int __must_check mutex_lock_killable(struct mutex *lock);
>  extern void mutex_lock_io(struct mutex *lock);
> @@ -181,7 +181,7 @@ extern void mutex_lock_io(struct mutex *lock);
>   * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
>   */
>  extern int mutex_trylock(struct mutex *lock);
> -extern void mutex_unlock(struct mutex *lock);
> +extern void mutex_unlock(struct mutex *lock) __releases(lock);
>  
>  extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);

*groan*, I despise these sparse things.

The proposed patch only annotates a tiny part of the mutex interface,
and will thereby generate a flood of new (pointless) warnings. Worse,
annotating them all properly will require that __cond_lock() trainwreck.

