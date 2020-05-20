Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.2 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17275C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:07:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D78D1207C4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 11:07:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hpsNtx8Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgETLHi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 07:07:38 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55930 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbgETLHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 07:07:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lvAACVRQSpsFS/D+XzPZoadnFcUf0P0/Wc/zx7O+Etc=; b=hpsNtx8Ygc1CilTYuUHEsdRWjo
        pqvXWU9c0dqPu/X81oB+l9IJ/PeRCyk4y5FAEzOPoUU8htcoVdhqWj+VJWMaGeYq3i5hWZo0+9Y5Y
        LY4N2E3zAFHCcyMjibnoT9N7s0RWeh5uXdwb8VozUH62bVXKewTLL3R8dcCjW8UpBGQNFhtDQUTYi
        Dwi7BHO7sDg8CUiq38l51040uMcgkXdXpGAtq0ncheTjmWoSEtXUXgLsArIKsSXUIbV5BJcVeNp3M
        vnu9EcxRv7oek7qU3B90ITocz/iwLHkj9svkOHLUxsES+gW4T21g2DX+aqqKgFKQORUhT2bZUznmE
        ZP6iaAXw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbMYy-0006Dv-OW; Wed, 20 May 2020 11:07:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 50C92306089;
        Wed, 20 May 2020 13:07:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 3817B29D896DA; Wed, 20 May 2020 13:07:03 +0200 (CEST)
Date:   Wed, 20 May 2020 13:07:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Galbraith <umgwanakikbuti@gmail.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Subject: Re: [PATCH 7/8] zram: Use local lock to protect per-CPU data
Message-ID: <20200520110703.GJ317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-8-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-8-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:19:11PM +0200, Sebastian Andrzej Siewior wrote:
> +static DEFINE_LOCAL_LOCK(zcomp_lock);
> +
>  struct zcomp_strm *zcomp_stream_get(struct zcomp *comp)
>  {
> -	return *get_cpu_ptr(comp->stream);
> +	local_lock(zcomp_lock);
> +	return *this_cpu_ptr(comp->stream);
>  }

put it in struct czomp_strm ?
