Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD686C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:23:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 60A0E20721
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 23:23:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="KzR1Fn9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729633AbgEEXXL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 19:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727989AbgEEXXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 19:23:11 -0400
X-Greylist: delayed 1793 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 05 May 2020 16:23:10 PDT
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE0EC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 16:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=Fw7aDfSu8Ev49U5D2tYj2n61oUrGmj01KXcwQiHtfOw=; b=KzR1Fn9yMaNCO6OrbAlStQTrCQ
        M8PJEs62EAYQDNYCKoSgP5/tizMNxmI2+LyE/2WL8MhSEsWEA4QXF2K5oQCyMw+mhtrduovWhPLrT
        R8vflig+4tkhLYP6aiwUIggsphFUOLFchvZgscq0GvDxHwU+lgCO69pMi+wK3lfF7Fdpr2K4wDrXg
        D+NzjWVnDgzqGG8X54XrgdX+TZV3W3e7bvaJ6J0tMLBLtkmF7rnCTVJLPDBeaCXhJYeWEhQZDVzKy
        +zynG2YEh6sAElR2x/Ls9zy/b9lg7Ewi6OWRJPzWwhsdfHJc8RxctIbxTEGnR/9NMarCo/P6Q6UOq
        Rd96FIbw==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1jW6Qo-0008Qi-OU; Wed, 06 May 2020 00:52:54 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.93)
        (envelope-from <aurelien@aurel32.net>)
        id 1jW6Qo-001zlp-3y; Wed, 06 May 2020 00:52:54 +0200
Date:   Wed, 6 May 2020 00:52:54 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        arnd@arndb.de
Subject: Re: [PATCH v4 7/8] powerpc/vdso32: implement clock_getres entirely
Message-ID: <20200505225254.GA471364@aurel32.net>
Mail-Followup-To: Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, arnd@arndb.de
References: <cover.1575273217.git.christophe.leroy@c-s.fr>
 <37f94e47c91070b7606fb3ec3fe6fd2302a475a0.1575273217.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37f94e47c91070b7606fb3ec3fe6fd2302a475a0.1575273217.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2019-12-02 07:57, Christophe Leroy wrote:
> clock_getres returns hrtimer_res for all clocks but coarse ones
> for which it returns KTIME_LOW_RES.
> 
> return EINVAL for unknown clocks.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/kernel/asm-offsets.c         |  3 +++
>  arch/powerpc/kernel/vdso32/gettimeofday.S | 19 +++++++++++--------
>  2 files changed, 14 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 0013197d89a6..90e53d432f2e 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -413,7 +413,10 @@ int main(void)
>  	DEFINE(CLOCK_MONOTONIC, CLOCK_MONOTONIC);
>  	DEFINE(CLOCK_REALTIME_COARSE, CLOCK_REALTIME_COARSE);
>  	DEFINE(CLOCK_MONOTONIC_COARSE, CLOCK_MONOTONIC_COARSE);
> +	DEFINE(CLOCK_MAX, CLOCK_TAI);
>  	DEFINE(NSEC_PER_SEC, NSEC_PER_SEC);
> +	DEFINE(EINVAL, EINVAL);
> +	DEFINE(KTIME_LOW_RES, KTIME_LOW_RES);
>  
>  #ifdef CONFIG_BUG
>  	DEFINE(BUG_ENTRY_SIZE, sizeof(struct bug_entry));
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index 9aafacea9c4a..20ae38f3a5a3 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -196,17 +196,20 @@ V_FUNCTION_END(__kernel_clock_gettime)
>  V_FUNCTION_BEGIN(__kernel_clock_getres)
>    .cfi_startproc
>  	/* Check for supported clock IDs */
> -	cmpwi	cr0,r3,CLOCK_REALTIME
> -	cmpwi	cr1,r3,CLOCK_MONOTONIC
> -	cror	cr0*4+eq,cr0*4+eq,cr1*4+eq
> -	bne	cr0,99f
> +	cmplwi	cr0, r3, CLOCK_MAX
> +	cmpwi	cr1, r3, CLOCK_REALTIME_COARSE
> +	cmpwi	cr7, r3, CLOCK_MONOTONIC_COARSE
> +	bgt	cr0, 99f
> +	LOAD_REG_IMMEDIATE(r5, KTIME_LOW_RES)
> +	beq	cr1, 1f
> +	beq	cr7, 1f
>  
>  	mflr	r12
>    .cfi_register lr,r12
>  	get_datapage	r3, r0
>  	lwz	r5, CLOCK_HRTIMER_RES(r3)
>  	mtlr	r12
> -	li	r3,0
> +1:	li	r3,0
>  	cmpli	cr0,r4,0
>  	crclr	cr0*4+so
>  	beqlr
> @@ -215,11 +218,11 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>  	blr
>  
>  	/*
> -	 * syscall fallback
> +	 * invalid clock
>  	 */
>  99:
> -	li	r0,__NR_clock_getres
> -	sc
> +	li	r3, EINVAL
> +	crset	so
>  	blr
>    .cfi_endproc
>  V_FUNCTION_END(__kernel_clock_getres)

Removing the syscall fallback looks wrong, and broke access to
per-processes clocks. With this change a few glibc tests now fail.

This can be reproduced by the simple code below:

| #include <errno.h>
| #include <stdio.h>
| #include <string.h>
| #include <sys/types.h>
| #include <time.h>
| #include <unistd.h>
| 
| int main()
| {
|     struct timespec res;
|     clockid_t ci;
|     int e;
|
|     e = clock_getcpuclockid(getpid(), &ci);
|     if (e) {
|         printf("clock_getcpuclockid returned %d\n", e);
|         return e;
|     }
|     e = clock_getres (ci, &res);
|     printf("clock_getres returned %d\n", e);
|     if (e) {
|         printf("  errno: %d, %s\n", errno, strerror(errno));
|     }
|
|     return e;
| }

Without this patch or with -m64, it returns:

| clock_getres returned 0

With this patch with -m32 it returns:

| clock_getres returned -1
|   errno: 22, Invalid argument

Regards,
Aurelien

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
