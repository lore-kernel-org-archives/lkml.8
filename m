Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB887C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:52:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C67FE207F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 07:52:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="qf8BNDne"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731764AbgGaHwT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 03:52:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731644AbgGaHwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 03:52:18 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89F2C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 00:52:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BHzyS4rpHz9sRK;
        Fri, 31 Jul 2020 17:52:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596181937;
        bh=h+eYGxpy9k7opgsvEXnuKKimR5rpSrpAfLVKgl4J9F8=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qf8BNDneKlDM/j4MWdPsD8rtZEHU/G7s9fPBCUqI9zG4jAY9dTYMqMrYVhL87VQmF
         iW2AROq6sfwNoxB0Ps+qLwKclmCmrw/axhXQu1w49bmSsVhXwxDSu0yTbqVAD95o7o
         LsV5pv9XzVeaM6qFIOtIzzDNIu/DeFTyREuwhgXCch5Vfq26UbjbCM4mW3tcYiyg/M
         /pSwqEunBj2dAWeZNtvJJvD1D2AmQsWPImgCNcqQjdv4tjM1qeWkCAprGN4/GhNRTw
         g8TIew0NKoxlAlwn1P+CbHieoB4bS4Y7JJiv9HY7xiddoR/wY/Ts7Gm2/f9FCRcCW3
         mG6+JDYAhH5Cw==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v4 08/10] powerpc/smp: Allocate cpumask only after searching thread group
In-Reply-To: <20200727053230.19753-9-srikar@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com> <20200727053230.19753-9-srikar@linux.vnet.ibm.com>
Date:   Fri, 31 Jul 2020 17:52:15 +1000
Message-ID: <87zh7g3yvk.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> If allocated earlier and the search fails, then cpumask need to be
> freed. However cpu_l1_cache_map can be allocated after we search thread
> group.

It's not freed anywhere AFAICS?

And even after this change there's still an error path that doesn't free
it, isn't there?

cheers

> Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
> Cc: LKML <linux-kernel@vger.kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nicholas Piggin <npiggin@gmail.com>
> Cc: Anton Blanchard <anton@ozlabs.org>
> Cc: Oliver O'Halloran <oohall@gmail.com>
> Cc: Nathan Lynch <nathanl@linux.ibm.com>
> Cc: Michael Neuling <mikey@neuling.org>
> Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Valentin Schneider <valentin.schneider@arm.com>
> Cc: Jordan Niethe <jniethe5@gmail.com>
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 698000c7f76f..dab96a1203ec 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -797,10 +797,6 @@ static int init_cpu_l1_cache_map(int cpu)
>  	if (err)
>  		goto out;
>  
> -	zalloc_cpumask_var_node(&per_cpu(cpu_l1_cache_map, cpu),
> -				GFP_KERNEL,
> -				cpu_to_node(cpu));
> -
>  	cpu_group_start = get_cpu_thread_group_start(cpu, &tg);
>  
>  	if (unlikely(cpu_group_start == -1)) {
> @@ -809,6 +805,9 @@ static int init_cpu_l1_cache_map(int cpu)
>  		goto out;
>  	}
>  
> +	zalloc_cpumask_var_node(&per_cpu(cpu_l1_cache_map, cpu),
> +				GFP_KERNEL, cpu_to_node(cpu));
> +
>  	for (i = first_thread; i < first_thread + threads_per_core; i++) {
>  		int i_group_start = get_cpu_thread_group_start(i, &tg);
>  
> -- 
> 2.17.1
