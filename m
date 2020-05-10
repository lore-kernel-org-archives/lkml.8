Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4D0FC38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9981520708
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 22:15:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aurel32.net header.i=@aurel32.net header.b="qp2gTY/i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729428AbgEJWP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 18:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729028AbgEJWP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 18:15:28 -0400
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 523C8C061A0C
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=In-Reply-To:Content-Type:MIME-Version:References:
        Message-ID:Subject:Cc:To:From:Date:Content-Transfer-Encoding:From:Reply-To:
        Subject:Content-ID:Content-Description:X-Debbugs-Cc;
        bh=QKrWCglmHIrEA/5Wh30xZ0GDeAJVKrUmaLXkngIVFqs=; b=qp2gTY/iNJC4C/0ds+1pG5wvqE
        eA53LGYAFSOmxYJErvvhm17yNKHzYGTzmRyIpn3TwRhzZ+86TAgYB5YTzkG2YsR0EZaZvul8ctnpP
        dhzsKADwzMi07dghTVKouwrozJ/2CcEjtmNreXA6IXGnM43hV4d9CRVrkVurBHE8eiJL38CO1JFoq
        sdpJXEt3RkUzy/ZSVTVSGFYgcp6zx+BVddWxECY+fNYZ8gEkkyedv/rPlkih1mG5wXDj98r5QPTdv
        vvgtHgd9zByjW0hugh5SUjkdFwcpVdbyWY3iRssr0JdSNAkgfWTzOWa+B48bMAsaxVTIL0qbc+sCY
        35i/lE8w==;
Received: from [2a01:e35:2fdd:a4e1:fe91:fc89:bc43:b814] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1jXuE3-0003Ep-8w; Mon, 11 May 2020 00:15:11 +0200
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.93)
        (envelope-from <aurelien@aurel32.net>)
        id 1jXuE2-003yoD-Ej; Mon, 11 May 2020 00:15:10 +0200
Date:   Mon, 11 May 2020 00:15:10 +0200
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH fixes] powerpc/vdso32: Fallback on getres syscall when
 clock is unknown
Message-ID: <20200510221510.GA948665@aurel32.net>
Mail-Followup-To: Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <7316a9e2c0c2517923eb4b0411c4a08d15e675a4.1589017281.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7316a9e2c0c2517923eb4b0411c4a08d15e675a4.1589017281.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2020-05-09 09:42, Christophe Leroy wrote:
> There are other clocks than the standard ones, for instance
> per process clocks. Therefore, being above the last standard clock
> doesn't mean it is a bad clock. So, fallback to syscall instead
> of returning -EINVAL inconditionaly.
> 
> Fixes: e33ffc956b08 ("powerpc/vdso32: implement clock_getres entirely")
> Cc: stable@vger.kernel.org
> Reported-by: Aurelien Jarno <aurelien@aurel32.net>
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> ---
>  arch/powerpc/kernel/vdso32/gettimeofday.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/powerpc/kernel/vdso32/gettimeofday.S b/arch/powerpc/kernel/vdso32/gettimeofday.S
> index a3951567118a..e7f8f9f1b3f4 100644
> --- a/arch/powerpc/kernel/vdso32/gettimeofday.S
> +++ b/arch/powerpc/kernel/vdso32/gettimeofday.S
> @@ -218,11 +218,11 @@ V_FUNCTION_BEGIN(__kernel_clock_getres)
>  	blr
>  
>  	/*
> -	 * invalid clock
> +	 * syscall fallback
>  	 */
>  99:
> -	li	r3, EINVAL
> -	crset	so
> +	li	r0,__NR_clock_getres
> +	sc
>  	blr
>    .cfi_endproc
>  V_FUNCTION_END(__kernel_clock_getres)

Thanks a lot for the fast answer. I have just tested this patch and I
confirm it fixes the issue.

Tested-by: Aurelien Jarno <aurelien@aurel32.net>

-- 
Aurelien Jarno                          GPG: 4096R/1DDD8C9B
aurelien@aurel32.net                 http://www.aurel32.net
