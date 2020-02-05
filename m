Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43930C33CA1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16EE5217BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 09:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QH9Z7+Vg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728184AbgBEJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 04:42:03 -0500
Received: from merlin.infradead.org ([205.233.59.134]:54632 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgBEJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 04:42:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=P9m/ElKBYHsznJFkHg/eA1I/ZIQ4f8/M8mbLexB2h7I=; b=QH9Z7+Vgrbwc3s22hS23UyZLm9
        Fjie6Lbqjmf8sUX5tIUtotLgejsVubirCO5dB4u1oDsmKNDP9Ttvmfzh30as2EilOKkcf52yRZE9e
        ajky2m0lqQwA+YrkM761mSa4bF2+QgbqqHPUWZnJpAS0lajder9mCaxdsS979w/+zY7JUjP7yBOfY
        Owh06IHikJ1v0g0Urjsy2QyM0A65BEU66y/mn8AC+lmV5BVX5TyB2A5boF4RQnURG3GeEyyt5jlTO
        T5tOVHmKKipFjNCNUtMEm78AcdmfJgxJAjJWGIH3BRlxTenwVRc4OF3m+tPfITft/c4RuesOmH+bC
        70kLJWdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1izHBz-0007HK-U3; Wed, 05 Feb 2020 09:41:56 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 78A7C3011C6;
        Wed,  5 Feb 2020 10:40:07 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 46C772B76AF47; Wed,  5 Feb 2020 10:41:53 +0100 (CET)
Date:   Wed, 5 Feb 2020 10:41:53 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 6/7] locking/lockdep: Reuse freed chain_hlocks entries
Message-ID: <20200205094153.GH14879@hirez.programming.kicks-ass.net>
References: <20200203164147.17990-1-longman@redhat.com>
 <20200203164147.17990-7-longman@redhat.com>
 <20200204123629.GO14914@hirez.programming.kicks-ass.net>
 <8fd7ce61-d8eb-6bde-7d41-54b9920e3e39@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8fd7ce61-d8eb-6bde-7d41-54b9920e3e39@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 04, 2020 at 11:45:15AM -0500, Waiman Long wrote:
> On 2/4/20 7:36 AM, Peter Zijlstra wrote:
> > --- a/kernel/locking/lockdep_proc.c
> > +++ b/kernel/locking/lockdep_proc.c
> > @@ -278,9 +278,11 @@ static int lockdep_stats_show(struct seq
> >  #ifdef CONFIG_PROVE_LOCKING
> >  	seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
> >  			lock_chain_count(), MAX_LOCKDEP_CHAINS);
> > -	seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
> > -			MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks,
> > +	seq_printf(m, " dependency chain hlocks used:  %11lu [max: %lu]\n",
> > +			MAX_LOCKDEP_CHAIN_HLOCKS - (nr_free_chain_hlocks - nr_lost_chain_hlocks),
> >  			MAX_LOCKDEP_CHAIN_HLOCKS);
> > +	seq_printf(m, " dependency chain hlocks free:  %11lu\n", nr_free_chain_hlocks);
> > +	seq_printf(m, " dependency chain hlocks lost:  %11lu\n", nr_lost_chain_hlocks);
> 
> I do have some comments on this. There are three buckets now - free,
> lost, used. They add up to MAX_LOCKDEP_CHAIN_HLOCKS. I don't think we
> need to list all three. We can compute the third one by subtracting max
> from the other two.
> 
> Something like:
> 
> diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> index 14932ea50317..6fe6a21c58d3 100644
> --- a/kernel/locking/lockdep_proc.c
> +++ b/kernel/locking/lockdep_proc.c
> @@ -278,9 +278,12 @@ static int lockdep_stats_show(struct seq_file *m,
> void *v)
>  #ifdef CONFIG_PROVE_LOCKING
>         seq_printf(m, " dependency chains:             %11lu [max: %lu]\n",
>                         lock_chain_count(), MAX_LOCKDEP_CHAINS);
> -       seq_printf(m, " dependency chain hlocks:       %11lu [max: %lu]\n",
> -                       MAX_LOCKDEP_CHAIN_HLOCKS - nr_free_chain_hlocks,
> +       seq_printf(m, " dependency chain hlocks used:  %11lu [max: %lu]\n",
> +                       MAX_LOCKDEP_CHAIN_HLOCKS -
> +                       (nr_free_chain_hlocks + nr_lost_chain_hlocks),
>                         MAX_LOCKDEP_CHAIN_HLOCKS);
> +       seq_printf(m, " dependency chain hlocks lost:  %11lu\n",
> +                       nr_lost_chain_hlocks);
>  #endif
>  

Sure, also I tihnk the compiler is unhappy about %lu vs 'unsigned int'
for some of them.
