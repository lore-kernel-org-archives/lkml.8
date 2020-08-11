Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C669BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:07:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95C1320756
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:07:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="epOUAdKw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgHKMHI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:07:08 -0400
Received: from ozlabs.org ([203.11.71.1]:34275 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728790AbgHKMHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:07:06 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BQs5M4H6qz9sTR;
        Tue, 11 Aug 2020 22:07:03 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1597147624;
        bh=pb6dXzfa2UA0hCpfDnFm4lqr+4kZIHCcfkntrubsbmM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=epOUAdKw8rGRYYkzHGeceNWOqXrXBOAZUHmg8Du5RAI7CnY0Pce78OEqmsBg00vdF
         hRjoQ3DzthPHf4nGFGSVmAEw2lbBg0cnNiz8CGE1pDhF5PeW9PA6N0aASDF9FEHb+E
         N/wbs+D5YAj66UU0r/b0PXwNVL0jcO7xx2qcPSAdMJErNhr7s9An4+NGcKyuDk0ZJK
         mMkmWrG65+myCZqoqF+CV8K41oEmOFR3OBQZBJm6oY3hQdpQJAl2xrw78TZnFhvYUo
         GTqQYyJhzNRJZD0HchERImxhS7RjF+U6v/dVSEPenRa+qtE5Tr9EvMbZ/XipzTRNUn
         EVxz/T1itG/OQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v1] power: don't manage floating point regs when no FPU
In-Reply-To: <95c00a811897f6d9176d30bf2ac92dab8c9c8e95.1596816789.git.christophe.leroy@csgroup.eu>
References: <95c00a811897f6d9176d30bf2ac92dab8c9c8e95.1596816789.git.christophe.leroy@csgroup.eu>
Date:   Tue, 11 Aug 2020 22:07:02 +1000
Message-ID: <87o8nh9yjd.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Leroy <christophe.leroy@csgroup.eu> writes:
> There is no point in copying floating point regs when there
> is no FPU and MATH_EMULATION is not selected.

Yeah I guess you're right. I've never touched a system with neither, but
if such a thing exists then it does seem silly to copy regs around that
can't be used.

> Create a new CONFIG_PPC_FPU_REGS bool that is selected by
> CONFIG_MATH_EMULATION and CONFIG_PPC_FPU, and use it to
> opt out everything related to fp_state in thread_struct.
>
> The following app runs in approx 10.50 seconds on an 8xx without
> the patch, and in 9.45 seconds with the patch.
>
> 	void sigusr1(int sig) { }
>
> 	int main(int argc, char **argv)
> 	{
> 		int i = 100000;
>
> 		signal(SIGUSR1, sigusr1);
> 		for (;i--;)
> 			raise(SIGUSR1);
> 		exit(0);
> 	}
>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/Kconfig                      |  1 +
>  arch/powerpc/include/asm/processor.h      |  2 ++
>  arch/powerpc/kernel/asm-offsets.c         |  2 ++
>  arch/powerpc/kernel/process.c             |  4 ++++
>  arch/powerpc/kernel/ptrace/ptrace-novsx.c |  8 ++++++++
>  arch/powerpc/kernel/ptrace/ptrace.c       |  4 ++++
>  arch/powerpc/kernel/signal.c              | 12 +++++++++++-
>  arch/powerpc/kernel/signal_32.c           |  4 ++++
>  arch/powerpc/kernel/traps.c               |  4 ++++
>  arch/powerpc/platforms/Kconfig.cputype    |  4 ++++
>  10 files changed, 44 insertions(+), 1 deletion(-)

In general this looks fine.

It's a bit #ifdef heavy. Maybe some of those can be cleaned up a bit
with some wrapper inlines?

> diff --git a/arch/powerpc/kernel/ptrace/ptrace-novsx.c b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
> index b2dc4e92d11a..8f87a11f3f8c 100644
> --- a/arch/powerpc/kernel/ptrace/ptrace-novsx.c
> +++ b/arch/powerpc/kernel/ptrace/ptrace-novsx.c
> @@ -28,6 +29,9 @@ int fpr_get(struct task_struct *target, const struct user_regset *regset,
>  
>  	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
>  				   &target->thread.fp_state, 0, -1);
> +#else
> +	return 0;
> +#endif

Should we return -ENODEV/EIO here? Wonder if another arch can give us a clue.

cheers
