Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1F5C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:14:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E50208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:14:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="PiZsXOsY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733053AbgGaMOR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:14:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732784AbgGaMOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:14:17 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 05:14:17 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BJ5ml2LN3z9s1x;
        Fri, 31 Jul 2020 22:14:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596197655;
        bh=zl7Kp+BGNFfBts1EjllIogLiwRs96Vwctn66ZH8tpps=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=PiZsXOsYAL7n272reYQOMNJhDNwWpssZqR1XrI9PcXNOm9miwoQzY7vkbAczMA2mR
         veL4hHCGhckOA1fppwEAIThEN3r5XfV4NKi5jqtuCxcXEIxIe9pvKsKKxYq5TQe8Xv
         gjklhM/2lahd6X83wJ+VLZPJYw8K5WkT4DUqsLFY8YYoTtVt7Vp/g/8EIRDb09/oxS
         ACMesE+gaswVgRyyeOEGG4wYa7xYeQ0gMtl6v+ciaHNN2k1GHilVClzDvKlJDScYOF
         0HiZvfLU7BLTB2wHqH5Pt1uGqRFGNrlMbYn7gLYoIVJdrwm3ZVZxuqh5H53tWqjmQz
         hvqP6f482dgkQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
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
In-Reply-To: <20200731094938.GA18776@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com> <20200727053230.19753-9-srikar@linux.vnet.ibm.com> <87zh7g3yvk.fsf@mpe.ellerman.id.au> <20200731094938.GA18776@linux.vnet.ibm.com>
Date:   Fri, 31 Jul 2020 22:14:11 +1000
Message-ID: <87o8nv51bg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2020-07-31 17:52:15]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > If allocated earlier and the search fails, then cpumask need to be
>> > freed. However cpu_l1_cache_map can be allocated after we search thread
>> > group.
>> 
>> It's not freed anywhere AFAICS?
>
> Yes, its never freed. Infact we are never checking if
> zalloc_cpumask_var_node fails. Its not just this cpumask, but historically
> all the other existing cpumasks in arch/powerpc/kernel/smp.c are never
> freed/checked. I did dig into this a bit and it appears that ..
> (Please do correct me if I am wrong!! )

That's correct.

> Powerpc using cpumask_var_t for all of the percpu variables. And it dont seem
> to enable CONFIG_CPUMASK_OFFSTACK even from the MAXSMP config.

I remember Rusty adding that code, but I don't know if we ever
considered enabling CPUMASK_OFFSTACK.

Probably we meant to but never got around to doing it.

> So from include/linux/cpumask.h
>
> typedef struct cpumask cpumask_var_t[1];
> and
> zalloc_cpumask_var_node ends up being cpumask_clear
>
> So I think we are historically we seem to assume we are always
> !CPUMASK_OFFSTACK and hence we dont need to check for return as well as
> free..

Right.

> I would look forward to your comments on how we should handle this going
> forward. But I would keep this the same for this patchset.

Agreed, just clarify in the change log that it's not freed at the moment
because of CPU_MASK_OFFSTACK=n

> One of the questions that I have is if we most likely are to be in
> !CONFIG_CPUMASK_OFFSTACK, then should be migrate to cpumask_t for percpu
> variables. 

I don't think so, cpumask_t is semi-deprecated AIUI.
  
> The reason being we end up using NR_CPU cpumask for each percpu cpumask
> variable instead of using NR_CPU cpumask_t pointer.

Our current defconfigs have NR_CPUS=2048, which is probably just small
enough to continue using OFFSTACK=n.

But we allow configuring NR_CPUS up to 8192, which surely would need
OFFSTACK=y in order to work.

So I think we need to stick with cpumask_var_t, but we should test with
OFFSTACK=y, and should probably be a bit more careful with checking the
allocations succeed.

And then we should select OFFSTACK=y for NR_CPUS above some threshold.

cheers
