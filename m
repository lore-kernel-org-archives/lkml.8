Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4572C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 771BC207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 10:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fQ1ScCce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726693AbgETK4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 06:56:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA32C061A0E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 03:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=htag33BNmHLqpnBmRbGpqytDzAiAVxpqSCxB59eltGE=; b=fQ1ScCceNEmhTtWqRe/juWMRCz
        U5Hf+US9g1wEJGVAfrNnUreAlZZiIr8jovhc3aiCdsLvVG9hTynjDBZ8NPG47KRiC4PH50X0o7wTd
        EWauJ4Y1XRjqcV9vGs7vLt1eq03btGpqwAW+30OxUHYmwUxnK99RjlTxrqgF02qNcBzp1kYYxK/1v
        8WxhadaGYZUmBeBMni22Scr3WG+eyKNTpG5xk7x6TvvmuK8kxCGHQa+40S+1FK9vUqQrQHU1kbD65
        KPynr4UgwhJYrtcpXDExP+OToC9YVgxyjUFWurvQHGrS1PfjLWuM1sjIUqAIYSFdgf2UBv/wVjc/f
        X8EIKwWA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jbMOl-0000E7-Hn; Wed, 20 May 2020 10:56:31 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B18A330015A;
        Wed, 20 May 2020 12:56:29 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9D76E29D896D4; Wed, 20 May 2020 12:56:29 +0200 (CEST)
Date:   Wed, 20 May 2020 12:56:29 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Julia Cartwright <julia@ni.com>,
        Phillip Lougher <phillip@squashfs.org.uk>,
        Alexander Stein <alexander.stein@systec-electronic.com>
Subject: Re: [PATCH 5/8] squashfs: make use of local lock in multi_cpu
 decompressor
Message-ID: <20200520105629.GH317569@hirez.programming.kicks-ass.net>
References: <20200519201912.1564477-1-bigeasy@linutronix.de>
 <20200519201912.1564477-6-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519201912.1564477-6-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:19:09PM +0200, Sebastian Andrzej Siewior wrote:
> diff --git a/fs/squashfs/decompressor_multi_percpu.c b/fs/squashfs/decompressor_multi_percpu.c
> index 2a2a2d106440e..8a77a2741c176 100644
> --- a/fs/squashfs/decompressor_multi_percpu.c
> +++ b/fs/squashfs/decompressor_multi_percpu.c
> @@ -8,6 +8,7 @@
>  #include <linux/slab.h>
>  #include <linux/percpu.h>
>  #include <linux/buffer_head.h>
> +#include <linux/locallock.h>
>  
>  #include "squashfs_fs.h"
>  #include "squashfs_fs_sb.h"
> @@ -23,6 +24,8 @@ struct squashfs_stream {
>  	void		*stream;
>  };
>  
> +static DEFINE_LOCAL_LOCK(stream_lock);

As per the others, you can stick it in struct squashfs_stream.
