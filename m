Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F11BFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D074F2072C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Eec5LrVP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731399AbgEVO5c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:57:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731255AbgEVO50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:57:26 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 226C2C061A0E
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=erZ/JA17BuAFrecl0xoMrH0KQGWniu40sT1NX+tkDYE=; b=Eec5LrVPlqVvxH6htP3R0e0xB9
        7pG1vNWYg54p64n9nca55RF2BVyBOwA5sHYwPXEKo36ykTKfXwf5tioO2WUxCPJqNKl8uT5N71sTv
        uNQM2qdNnAS0s0ADwlNTW6X56QEJPO+3aSEej5KQ1wrs46H7ntjUp2ntygdLQJNhD8Z6O42ZdCitH
        M5T0h3tsDqfO/IMqjxddRk9oEN7U+mgsrXjlSWBGuGwI/X8WPulK3s2T8oeNXNvWOSL7Vp+chP5eK
        g7yrELWQpTGzXeRslYDNyi6BAVxrCPLbUD2wSmdFyLz+yDVvXc894Pl2Sua0xhN8v3bi6XY2tHlQi
        VkOaX62g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jc96k-00024S-C3; Fri, 22 May 2020 14:57:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2CBE2307881;
        Fri, 22 May 2020 16:57:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id D6C532B236866; Fri, 22 May 2020 16:57:07 +0200 (CEST)
Date:   Fri, 22 May 2020 16:57:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-mm@kvack.org
Subject: Re: [PATCH v1 02/25] mm/swap: Don't abuse the seqcount latching API
Message-ID: <20200522145707.GO325280@hirez.programming.kicks-ass.net>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200519214547.352050-3-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200519214547.352050-3-a.darwish@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 11:45:24PM +0200, Ahmed S. Darwish wrote:
> @@ -713,10 +713,20 @@ static void lru_add_drain_per_cpu(struct work_struct *dummy)
>   */
>  void lru_add_drain_all(void)
>  {

> +	static unsigned int lru_drain_gen;
>  	static struct cpumask has_work;
> +	static DEFINE_MUTEX(lock);
> +	int cpu, this_gen;
>  
>  	/*
>  	 * Make sure nobody triggers this path before mm_percpu_wq is fully
> @@ -725,21 +735,48 @@ void lru_add_drain_all(void)
>  	if (WARN_ON(!mm_percpu_wq))
>  		return;
>  

> +	this_gen = READ_ONCE(lru_drain_gen);
> +	smp_rmb();

	this_gen = smp_load_acquire(&lru_drain_gen);
>  
>  	mutex_lock(&lock);
>  
>  	/*
> +	 * (C) Exit the draining operation if a newer generation, from another
> +	 * lru_add_drain_all(), was already scheduled for draining. Check (A).
>  	 */
> +	if (unlikely(this_gen != lru_drain_gen))
>  		goto done;
>  

> +	WRITE_ONCE(lru_drain_gen, lru_drain_gen + 1);
> +	smp_wmb();

You can leave this smp_wmb() out and rely on the smp_mb() implied by
queue_work_on()'s test_and_set_bit().

>  	cpumask_clear(&has_work);
> -
>  	for_each_online_cpu(cpu) {
>  		struct work_struct *work = &per_cpu(lru_add_drain_work, cpu);
>  

While you're here, do:

	s/cpumask_set_cpu/__&/

> @@ -766,7 +803,7 @@ void lru_add_drain_all(void)
>  {
>  	lru_add_drain();
>  }
> -#endif
> +#endif /* CONFIG_SMP */
>  
>  /**
>   * release_pages - batched put_page()
