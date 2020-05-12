Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89A91CA90AF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6340D2492B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 19:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rx5iU2PY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbgELTJP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgELTJP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 15:09:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5167DC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 12:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=EkBz8hLKynQENtHUYkQjAAzLTeUzsxCnvhIcGmmRee4=; b=rx5iU2PY27RbyPCEAflfMieaAM
        BbcBjv/8klju+FAKeV624PkopwbgwKm5IBIl8ojnVaawj/9eUD1KQtpuJhg3/GVZWHIdEXnaH/2Gv
        xQEONYoEsXyx+oU32rHBHqgIwex/BMF/MeLTwGrS35W3AaJFe1xWflr3laie6yn8ZMrxKf0hWMjD3
        i04fPm1f2lL8zn5AelIeRmbn+wi52mA6toabAcbn4F+JHKmP8hxiRgwQyM+K/9IwnIDCIxsI6PYUD
        9x0TB0gGtbP+S4XVH4LywCMo22b09ySPn24mYGPwxySCOOJnUinMc/bG0CI0Iyyylt7WhE9f1BSPI
        OWAh+6rQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jYaHA-0001AY-4E; Tue, 12 May 2020 19:09:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8D121304DB2;
        Tue, 12 May 2020 21:09:10 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7E65528B27274; Tue, 12 May 2020 21:09:10 +0200 (CEST)
Date:   Tue, 12 May 2020 21:09:10 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Marco Elver <elver@google.com>
Cc:     linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] READ_ONCE, WRITE_ONCE, kcsan: Perform checks in __*_ONCE
 variants
Message-ID: <20200512190910.GM2957@hirez.programming.kicks-ass.net>
References: <20200512183839.2373-1-elver@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512183839.2373-1-elver@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 12, 2020 at 08:38:39PM +0200, Marco Elver wrote:
> diff --git a/include/linux/compiler.h b/include/linux/compiler.h
> index 741c93c62ecf..e902ca5de811 100644
> --- a/include/linux/compiler.h
> +++ b/include/linux/compiler.h
> @@ -224,13 +224,16 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
>   * atomicity or dependency ordering guarantees. Note that this may result
>   * in tears!
>   */
> -#define __READ_ONCE(x)	(*(const volatile __unqual_scalar_typeof(x) *)&(x))
> +#define __READ_ONCE(x)							\
> +({									\
> +	kcsan_check_atomic_read(&(x), sizeof(x));			\
> +	data_race((*(const volatile __unqual_scalar_typeof(x) *)&(x))); \
> +})

NAK

This will actively insert instrumentation into __READ_ONCE() and I need
it to not have any.


