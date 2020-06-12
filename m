Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8AB9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A915207ED
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 16:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EIqDGtX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFLQeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 12:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726112AbgFLQeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 12:34:03 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2960CC03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 09:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=m/JSRr/nFiYtLRndyGO1Ndt2WQLnMAvoHzIfrNhUs68=; b=EIqDGtX3r7UiOAPU2+dmyLHeLL
        tt4cXsmHA2uQtpRQtXDAacphKQbJXKd87UdLGda4VdD4sbwE8ZJMGP+NkGft4XXymxLBPWe5Hx79c
        JYEsNknqmsXLDCK0crfjHCDNA2Vm3LLulS7pIQ7nto4lZu2lwZj9UGFVRIGU3MD94CSevI1MBY3uR
        fdTl8bG3yi9AaiSN9iQZjB7rB4ViC1M+7rYjp+04Y41g4ieIS/twQ4ig/N8pq+PqZL+POTzlrQ9hn
        3f8WR2AOy0Sef8SuXUkO/+Zuaf0E9WCUWw6x1GGBo5lidcirrlhmkYCfP3YpDujlylZATfCFgMMNK
        Khmb/2gQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jjmcl-0003Pk-Rn; Fri, 12 Jun 2020 16:33:48 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8DF0E3003E4;
        Fri, 12 Jun 2020 18:33:45 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 698EE213CEB1E; Fri, 12 Jun 2020 18:33:45 +0200 (CEST)
Date:   Fri, 12 Jun 2020 18:33:45 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Xiaoming Ni <nixiaoming@huawei.com>
Cc:     paul@paul-moore.com, edumazet@google.com, paulmck@kernel.org,
        dhowells@redhat.com, keescook@chromium.org, shakeelb@google.com,
        jamorris@linux.microsoft.com, alex.huangjianhui@huawei.com,
        dylix.dailei@huawei.com, chenzefeng2@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] cred: Add WARN to detect wrong use of get/put_cred
Message-ID: <20200612163345.GF2497@hirez.programming.kicks-ass.net>
References: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591957695-118312-1-git-send-email-nixiaoming@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 06:28:15PM +0800, Xiaoming Ni wrote:
> Cred release and usage check code flow:
> 	1. put_cred()
> 		if (atomic_dec_and_test(&(cred)->usage))
> 			__put_cred(cred);
> 
> 	2. __put_cred()
> 		BUG_ON(atomic_read(&cred->usage) != 0);
> 		call_rcu(&cred->rcu, put_cred_rcu);
> 
> 	3. put_cred_rcu()
> 		if (atomic_read(&cred->usage) != 0)
> 			panic("CRED: put_cred_rcu() sees %p with usage %d\n",
> 			       cred, atomic_read(&cred->usage));
> 		kmem_cache_free(cred_jar, cred);
> 
> If panic is triggered on put_cred_rcu(), there are two possibilities
> 	1. Call get_cred() after __put_cred(), usage > 0
> 	2. Call put_cred() after __put_cred(), usage < 0
> Since put_cred_rcu is an asynchronous behavior, it is no longer the first
> scene when panic, there is no information about the murderer in the panic
> call stack...
> 
> So, add WARN() in get_cred()/put_cred(), and pray to catch the murderer
> at the first scene.

Why not not use refcount_t? It has all that goodness and more.
