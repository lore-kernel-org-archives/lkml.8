Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B900AC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81CFB2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 06:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590388201;
	bh=/7u0JlGO19CDrgYVE50aYd+t2XIk2ks8EzS8IPtHRzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Zu7NVkVnPlEGSPpZ6WHK/m5P6Flnq5iPKfYQ2husJ2zi6neEO8KRldrH/ftY8nZNf
	 YkqOpFUWnTKVM6GnAN45TPxzxhiNulWiB92HMxFquoirUxmnAxifmtHgGeuZaqvIq6
	 T2HcxQJKFNqj5aZXG8/VNVngvZ2rJ4XvT6VksGqU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388861AbgEYGaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 02:30:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388631AbgEYG37 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 02:29:59 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4D4C061A0E;
        Sun, 24 May 2020 23:29:58 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id n5so15655705wmd.0;
        Sun, 24 May 2020 23:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MVopmvtYGB1b9bHkVcbXJiWcVuB0dUcjUj4cs56wKkU=;
        b=hDh+S6QCdSehPj95aKmKTm3I0VeYiGFY7sz5xSscxAXDgFi8cy9Ztci24OWDBOojka
         BQhik6IbopRus9Ayb9yYmYdzkWYIobUYMPR2uZ+AvCHONF3dzowrnMV6sh/YJ37jrHGf
         MkBE5VjZopbnzRSi8EMpAEpF6DKSLxu55g6aLKzk+ejNa9QU5aL70lsREMz5AXQjD4Qa
         kAeJyo7Io9FvhhiG0/STpno/7u2o/kyWwlXHZKKvZ0vIzsPgKZxj+hpGtGK6ClQ+b40u
         pgDh3GiOr2PYmbo/hpOUGBiizF8iHLO9PGhsWCvWxW49Harvcv6pNXw3Tw2ZoILtvRpO
         sGxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=MVopmvtYGB1b9bHkVcbXJiWcVuB0dUcjUj4cs56wKkU=;
        b=I23DGAcBybnkl2KKBzEXWQc2BmQKP+o7SAVP2yCnJRfAowJEC1i3kwe+dV0TnKIzsL
         NG7vm5QV66oXGhb+o+M72BHsNIoHWX5BKyl10bMRsfbHGsKhg12F/ILiW27I29IAOhKs
         VsMddfOiufSKjcyUj9g+GJsKizojS+7mvYK10/C7qqp+VXGSHVo/nv88UOtUMFIKFVow
         NI8ITjEBsktwEjoCtNYIjNE+aSJ7NRj2vDJy+6SpS7WhR12cFNtCfgqH2CFzbUo0+G+6
         9ZoiC6+KrQIodNyjE0JY6+52l1vApHFqh+j/b6SzWctE+U841xpZE0YT31hqLJofZbap
         YQcQ==
X-Gm-Message-State: AOAM530hlCQ8PFEhLqpkm/IWdIteTp3KwYCYMRtT+SLFgF/44RspLHR9
        QtfUbMQno3wwTEmpT2YFMIdS2kDz
X-Google-Smtp-Source: ABdhPJzLCZqwaeNvaz4N1oysLtto8Mit3Fzp4ZptAX7WA44IG4WKWggtVPXRuIX/ovFe5NT0SB/DEA==
X-Received: by 2002:a1c:cc1a:: with SMTP id h26mr22697452wmb.127.1590388197706;
        Sun, 24 May 2020 23:29:57 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id w10sm5986380wrp.16.2020.05.24.23.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2020 23:29:56 -0700 (PDT)
Date:   Mon, 25 May 2020 08:29:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] radix-tree: Use local_lock for protection
Message-ID: <20200525062954.GA3180782@gmail.com>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524215739.551568-3-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> The radix-tree and idr preload mechanisms use preempt_disable() to protect
> the complete operation between xxx_preload() and xxx_preload_end().
> 
> As the code inside the preempt disabled section acquires regular spinlocks,
> which are converted to 'sleeping' spinlocks on a PREEMPT_RT kernel and
> eventually calls into a memory allocator, this conflicts with the RT
> semantics.
> 
> Convert it to a local_lock which allows RT kernels to substitute them with
> a real per CPU lock. On non RT kernels this maps to preempt_disable() as
> before, but provides also lockdep coverage of the critical region.
> No functional change.
> 
> Cc: Matthew Wilcox <willy@infradead.org>
> Cc: linux-fsdevel@vger.kernel.org
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/idr.h        |  5 +----
>  include/linux/radix-tree.h |  6 +-----
>  lib/radix-tree.c           | 29 ++++++++++++++++++++++-------
>  3 files changed, 24 insertions(+), 16 deletions(-)

> -static inline void idr_preload_end(void)
> -{
> -	preempt_enable();
> -}
> +void idr_preload_end(void);

> +void idr_preload_end(void)
> +{
> +	local_unlock(&radix_tree_preloads.lock);
> +}
> +EXPORT_SYMBOL(idr_preload_end);

> +void radix_tree_preload_end(void);

> -static inline void radix_tree_preload_end(void)
> -{
> -	preempt_enable();
> -}

> +void radix_tree_preload_end(void)
> +{
> +	local_unlock(&radix_tree_preloads.lock);
> +}
> +EXPORT_SYMBOL(radix_tree_preload_end);

Since upstream we are still mapping the local_lock primitives to
preempt_disable()/preempt_enable(), I believe these uninlining changes should not be done
in this patch, i.e. idr_preload_end() and radix_tree_preload_end() should stay inline.

Thanks,

	Ingo
