Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D98C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F94B2051A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 12:13:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CvHc61oW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728180AbgDHMNW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 08:13:22 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:39413 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgDHMNW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 08:13:22 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 48y38J2kyXz9sRN;
        Wed,  8 Apr 2020 22:13:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1586348000;
        bh=ubGzeXSiVoqtebhTvEZLZD3GVQ6q7AW2piVuB1gAlBA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=CvHc61oW7tA7kZxZgTKRkrr72INdmtZmz5b2cWNfwTinUYYVcvgEHtnajpTiQwaWq
         RInLrTI9uvKzzCpougdbGohfsJjFL9K0UTwXHMbirkCHbfkqJOa8/JN++5teOhXBSi
         ecCRcm7DO8/gqeCaTulSq2i7bmpwZknTMxVoPQIiP0lShZubxMLu2lijoJj9lqco4o
         Y6W0UUEPlPu/GwkcXy4vdaYBunXvXJAF3QG/zXFcmdTK/HY2RGbe2nq+WKeqIZdQAu
         btwyGBcmhkxv9hZHS09dfisn+s8WtiOaESPca0aijOPTVwdEucrjnZ1wDkEHrqXuiy
         L/LyM6dfCLxpg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Leonardo Bras <leonardo@linux.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Enrico Weigelt <info@metux.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Allison Randal <allison@lohutok.net>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Leonardo Bras <leonardo@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] powerpc/crash: Use NMI context for printk after crashing other CPUs
In-Reply-To: <20200406174058.686436-1-leonardo@linux.ibm.com>
References: <20200406174058.686436-1-leonardo@linux.ibm.com>
Date:   Wed, 08 Apr 2020 22:13:31 +1000
Message-ID: <87y2r6jhuc.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Leonardo Bras <leonardo@linux.ibm.com> writes:
> Currently, if printk lock (logbuf_lock) is held by other thread during
> crash, there is a chance of deadlocking the crash on next printk, and
> blocking a possibly desired kdump.
>
> After sending IPI to all other CPUs, make printk enter in NMI context,
> as it will use per-cpu buffers to store the message, and avoid locking
> logbuf_lock.
>
> Signed-off-by: Leonardo Bras <leonardo@linux.ibm.com>
> ---
>  arch/powerpc/kexec/crash.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/powerpc/kexec/crash.c b/arch/powerpc/kexec/crash.c
> index d488311efab1..9b73e3991bf4 100644
> --- a/arch/powerpc/kexec/crash.c
> +++ b/arch/powerpc/kexec/crash.c
> @@ -115,6 +115,7 @@ static void crash_kexec_prepare_cpus(int cpu)

Added context:

	printk(KERN_EMERG "Sending IPI to other CPUs\n");

	if (crash_wake_offline)
		ncpus = num_present_cpus() - 1;

>  
>  	crash_send_ipi(crash_ipi_callback);
>  	smp_wmb();
> +	printk_nmi_enter();
  
Why did you decide to put it there, rather than at the start of
default_machine_crash_shutdown() like I did?

The printk() above could have already deadlocked if another CPU is stuck
with the logbuf lock held.

cheers
