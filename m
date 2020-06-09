Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34E6C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 600F12072F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:06:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbeeYQqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728315AbgFIWGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:06:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726992AbgFIWGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:06:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45ECBC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 15:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7/lG44ARFf8GNQeKBoTl0nMlFTL5GoW7edGGZcQSk8w=; b=gbeeYQqhs01bJJA37dQ/DZIQ/Y
        d/cuFHSH34cU716BNtIfrY8UWBOCrqU8LqxO443u7OyeYsWrkx75EwmhlmkZE4H/BjfVG6l1Rsie/
        LuiyUqgjPMTKizAt2G/aW3bCxGG4jIFOLbzUiQ27eucimK3tZt2ppcI7SQPjawafjRrhAB9GxfdDZ
        fuCu5mxX4BMX6Y3UZRwQRW6BSA61CCmn1H1APa7c+jnJPX7Ytbp0Lt312cCMgQrCbTR5A0qd5MTN4
        WRiGCY8ZVMM7TbMzb8CutopYKYx59JH6gH/Xkbn6+7fApp7SECVzAb/pDONtySF94bMtY3TrJ/hcR
        DfBySkBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jimNg-0007sb-M7; Tue, 09 Jun 2020 22:06:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D98A73019CE;
        Wed, 10 Jun 2020 00:06:01 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id CBADE2038F8AB; Wed, 10 Jun 2020 00:06:01 +0200 (CEST)
Date:   Wed, 10 Jun 2020 00:06:01 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, tglx@linutronix.de,
        frederic@kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 7/7] sched: Replace rq::wake_list
Message-ID: <20200609220601.GD2514@hirez.programming.kicks-ass.net>
References: <20200526161057.531933155@infradead.org>
 <20200526161908.129371594@infradead.org>
 <20200604141837.GA179816@roeck-us.net>
 <20200605002433.GA148196@sol.localdomain>
 <20200605074154.GB2750@hirez.programming.kicks-ass.net>
 <20200605161532.GD1373@sol.localdomain>
 <53318971-561c-b445-0408-530b3d3ba44e@roeck-us.net>
 <20200609202134.GA1105@sol.localdomain>
 <20200609212509.GA239889@roeck-us.net>
 <20200609213829.GA789@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609213829.GA789@sol.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 02:38:29PM -0700, Eric Biggers wrote:
> Does the struct actually have to be named?  How about:
> 
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index c5d96e3e7fff42..14ca25cda19150 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -653,8 +653,14 @@ struct task_struct {
>  	unsigned int			ptrace;
>  
>  #ifdef CONFIG_SMP
> -	struct llist_node		wake_entry;
> -	unsigned int			wake_entry_type;
> +	/*
> +	 * wake_entry_type must follow wake_entry, even when
> +	 * CONFIG_GCC_PLUGIN_RANDSTRUCT=y.
> +	 */
> +	struct {
> +		struct llist_node	wake_entry;
> +		unsigned int		wake_entry_type;
> +	};
>  	int				on_cpu;
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
>  	/* Current CPU: */
> 
> 
> However, it would be preferable to not rely on different structs sharing the
> same field order, but rather write proper C code that uses the same struct
> everywhere to encapsulate these 2 fields...

https://lkml.kernel.org/r/20200605093704.GB2948@hirez.programming.kicks-ass.net

And I have more patches on top to clean up some of the anonymous union
stuff, that that's quite a lot of frobbing.


