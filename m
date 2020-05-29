Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FECFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 55C05208B8
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 13:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590757316;
	bh=ya3WKUQiBnZF9OitxPT3nsDyAJDmYqPbNQ5rPFKXdN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=AhhnwSVfFOzbPXFlnB+MBLdyJkaLs8kWS11OB3W2ZgyfTY2EjGjuCaSS/EGXFqf7g
	 jc2FtPqyvx36hekxhMevOevffdn/bHCejsmXkwnkoeuzDz3KVQBrCtxlybVMygoDP5
	 lu8mjD8mbjFozkwJ2szptnbLMyqV1p5kf8F++PCc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbgE2NBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 09:01:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:46278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726467AbgE2NBy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 09:01:54 -0400
Received: from localhost (lfbn-ncy-1-324-171.w83-196.abo.wanadoo.fr [83.196.159.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D8DB2077D;
        Fri, 29 May 2020 13:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590757314;
        bh=ya3WKUQiBnZF9OitxPT3nsDyAJDmYqPbNQ5rPFKXdN8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ux7NHW95q68atjsTXjiRlshaUgxLwTxs1eYSINz9VJ7jc4tf2VpmkyMgNbS94HGiA
         7Sl1tOOr9pMCmgsR+UKvqVHv0+y7liscjjwrjTjNDhjXdG1v9bJwUz1h5IPd8/kWZJ
         GAfToEhoXQYeSDUY58+ot2zadpKDC+KLT9y2KhdU=
Date:   Fri, 29 May 2020 15:01:52 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, linux-kernel@vger.kernel.org, x86@kernel.org,
        cai@lca.pw, mgorman@techsingularity.net
Subject: Re: [RFC][PATCH 4/7] smp: Optimize send_call_function_single_ipi()
Message-ID: <20200529130150.GA19915@lenoir>
References: <20200526161057.531933155@infradead.org>
 <20200526161907.953304789@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526161907.953304789@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 06:11:01PM +0200, Peter Zijlstra wrote:
> +void flush_smp_call_function_from_idle(void)
> +{
> +	unsigned long flags;
> +
> +	if (llist_empty(this_cpu_ptr(&call_single_queue)))
> +		return;

Now it seems weird that sched_ttwu_pending() didn't have that
llist_empty() optimization. The ordering should allow it.

Anyway,

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
