Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D130C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9BF82071A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 07:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590390104;
	bh=nCfiHXRReH76qYrZXk2mdKsR7eE52/RgqM4P1THJXjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=dJL7UMusmLxEnStopBg72/M+6AyVJ5mpkwXX6JcyTyNsrdlv6jwR7dVF/n/2sBqlv
	 PgjCQy39+a2rDs09OTxqle5G7zVmKx4jQV8NGkjv5S0LfRmHb4yKo/9r2kmTnNXZhK
	 UMbJaHl0/NmQWS1omEGoor3Fmrdzieiz6ETNmcjU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388944AbgEYHBo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 03:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388385AbgEYHBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 03:01:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F513C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:01:43 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l26so214861wme.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 00:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lZzNqsJGnsh/CdW96KJIXrKNAiVHBcLSWjlO9MoQR0M=;
        b=XeRb5o0FBrCBuiu8PIqtZsvppRM5JzxBJmCsOwXrUMuNq79fXzvyzxC51BVVORg8yH
         4fGmoSfiUK3gTOklqjCsBq44+AUwsEen/wgTF2YmxTmgPJIj66s5QErrHtbGwCL/Wu3j
         rluS4XwZzc/GdanLHefRC9ycslqbFQRgs4Fo/WHHtkeMQh5aGIzNHlopi/auuJAtVpSr
         MDWgnscM2eu/XR4BWkmLq4YB1ooVn6HwFdPRRG2facfrae5d8TOpLSoYIrqGzAx1GJ/6
         d0GkQbW9/bOxHmTe9oitpCN5WSQR4w5IZtkR6VbNBZo1D7y2PJKV4nw8JXws/5G/LzFy
         pSKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lZzNqsJGnsh/CdW96KJIXrKNAiVHBcLSWjlO9MoQR0M=;
        b=fpx0nkkg8DDdbFN8TrHEFGPX0ta5RGCgR0dP/C2K+ksZTqfVCIK4gMOgRr/LYvhmRS
         4O+zxReIW2YpPWtGy0KMeGWV1pHr4KUaHDi00vQJtCvuOxo2jHXa8hK7xoEqkRCglvTj
         ekmlNm+teA37C53joVo268mo3TixGvrbtgBeJPpQGGN7gPhNULMFjzJx2IuEf3tEUiRq
         loZAZ9m+Kut+WhTrkMBv3WmB3F0fKqaCRjwU+ViEa/b876ywYKmy3GNSYUQqKjlPOSxj
         /TYmvmT7Aq/jL0n6BVAPqDxWKltk1kDpWrfT6oa7ujtS1iHVuDs9yDL8NOw1Ih+5eekq
         lsbQ==
X-Gm-Message-State: AOAM531jz/29x9tTcoEm+bu/yy1sHVF4qkA/FaoyPwezW/6lXj/PUD5T
        0VrQc0YlQWEOh47BC1dpuAs9JTOb
X-Google-Smtp-Source: ABdhPJynla8teKvEbsxo4udolvAhgdDcJ7xSdXmjMYF4DH5ncg0ivKhS4C+qVnCPohed8tVHcYlW9w==
X-Received: by 2002:a7b:c086:: with SMTP id r6mr23250197wmh.29.1590390102014;
        Mon, 25 May 2020 00:01:42 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id g187sm17214209wmf.30.2020.05.25.00.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 00:01:41 -0700 (PDT)
Date:   Mon, 25 May 2020 09:01:39 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 1/7] locking: Introduce local_lock()
Message-ID: <20200525070139.GB329373@gmail.com>
References: <20200524215739.551568-1-bigeasy@linutronix.de>
 <20200524215739.551568-2-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200524215739.551568-2-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> From: Thomas Gleixner <tglx@linutronix.de>
> 
> To address this PREEMPT_RT introduced the concept of local_locks which are
> strictly per CPU.

> +++ b/include/linux/locallock_internal.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _LINUX_LOCALLOCK_H
> +# error "Do not include directly, include linux/locallock.h"
> +#endif
> +
> +#include <linux/percpu-defs.h>
> +#include <linux/lockdep.h>
> +
> +struct local_lock {
> +#ifdef CONFIG_DEBUG_LOCK_ALLOC
> +	struct lockdep_map	dep_map;
> +	struct task_struct	*owner;
> +#endif
> +};

This this looks very nice to me, there's a minor data structure 
nomenclature related comment I have:

So local locks were supposed to be a look-alike to all the other 
locking constructs we have, spinlock_t in particular. Why isn't there 
a local_lock_t, instead of requiring 'struct local_lock'?

This abbreviation signals that these are 'small' data structures on 
mainline kernels (zero size in fact), but the other advantage is that 
the shorter name would prevent bloating of previously compact 
structure definitions, such as:

>  struct squashfs_stream {
> -	void		*stream;
> +	void			*stream;
> +	struct local_lock	lock;
>  };

This would become:

>  struct squashfs_stream {
>	void		*stream;
> +	locallock_t	lock;
>  };

( The other departure from spinlocks is that the 'spinlock_t' name, 
  without underscores, while making the API names such as spin_lock() 
  with an underscore, was a conscious didactic choice. Applying that 
  principle to local locks gives us the spinlock_t-equivalent name of 
  'locallock_t' - but the double 'l' reads a bit weirdly in this 
  context. So I think using 'local_lock_t' as the data structure is 
  probably the better approach. )

Thanks,

	Ingo
