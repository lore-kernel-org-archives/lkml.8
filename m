Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD2C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96FD020838
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 17:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIPvIFNW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727589AbgBGRim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 12:38:42 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:40440 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbgBGRim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 12:38:42 -0500
Received: by mail-pj1-f67.google.com with SMTP id 12so1176701pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 09:38:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OiMCk3HNlA+VYlmzK8C7KfB3ijS3pxsMTQRh/DwJS98=;
        b=DIPvIFNWz82jW5jdNCN7WS3F+SQ26RG5xOeXI72hbKx5hdyOiREZSJbZJRFbzMxP5z
         GcPlR/hwSDEjldjA28tMgKQ+vWpcgcf8pVsbeIQ+lgQCNhQy1Sgh8lMRAlYe6EcURoCb
         ONgSclgsXPB3wV2jCGTyUfNmcfqD3NohxJmKTRdEtZMUrkvI5CZwetjarcHTaMN0pMpk
         Z9r98dl5GyAkmFMCPcSz9LXz5BziHAoGsg0BVyc5hubYQdGwgic0CCLiLEdS1T56j9LL
         p2YHC+NTZWs/HWexwfDLFRad9gpJSqs/egEMNOU6MiEMULrKumUZknJBBNr3ZfSJMeLS
         s3rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OiMCk3HNlA+VYlmzK8C7KfB3ijS3pxsMTQRh/DwJS98=;
        b=PQO+M1sP6kt+s4aJVR069dbAnTJ3iIKfqkUDtxSbQjYg2ouSknBle8XG6rFlfuzoCU
         JUFHdJ/rSMsUx5S6Ty2+FU4Vf0xlo4e7QsxYzDR9cUHrzqQD53Ekv/m5PLn5Y/oCZv2o
         pyExjbdng0q/ETd/ZpTCMCfZGIsYory6Y+Wh0IUlE92PEW64QMK9aII4r+5m1rRIF6Pm
         fSEpj2zyM+5D623sCk/6jUCOc4YJmm2k8pFdKZlLvafU4aINLIbmMpk+VcBLuwJ1TJr7
         1o2xnuYbE4a7sSFlrO4o9+mIEOO2u1Iy4QftiWKEmOn4ztW74dsMdxRP22VCdXd9dngO
         64Rg==
X-Gm-Message-State: APjAAAXLWCK0plvcN3KdUilS977TE36K0XtK8OrNurS60vK8s5RkZ6zq
        jVBs+xP7Zz4NBiho48zgjrY=
X-Google-Smtp-Source: APXvYqwp1PutHtvP0hC+zOIRQmLP5aOwlkctuCUXhYERECa9pdF/NW68x0lKYXiMUZqTtWJAUoo97w==
X-Received: by 2002:a17:90a:26e1:: with SMTP id m88mr5108116pje.101.1581097120913;
        Fri, 07 Feb 2020 09:38:40 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c19sm3803503pgh.8.2020.02.07.09.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2020 09:38:40 -0800 (PST)
Date:   Fri, 7 Feb 2020 09:38:39 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: Fix CONFIG_TRACE_IRQFLAGS with CONFIG_VMAP_STACK
Message-ID: <20200207173839.GA8313@roeck-us.net>
References: <daeacdc0dec0416d1c587cc9f9e7191ad3068dc0.1581095957.git.christophe.leroy@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daeacdc0dec0416d1c587cc9f9e7191ad3068dc0.1581095957.git.christophe.leroy@c-s.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 07, 2020 at 05:20:57PM +0000, Christophe Leroy wrote:
> When CONFIG_PROVE_LOCKING is selected together with (now default)
> CONFIG_VMAP_STACK, kernel enter deadlock during boot.
> 
> At the point of checking whether interrupts are enabled or not, the
> value of MSR saved on stack is read using the physical address of the
> stack. But at this point, when using VMAP stack the DATA MMU
> translation has already been re-enabled, leading to deadlock.
> 
> Don't use the physical address of the stack when
> CONFIG_VMAP_STACK is set.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 028474876f47 ("powerpc/32: prepare for CONFIG_VMAP_STACK")

Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/powerpc/kernel/entry_32.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
> index 77abbc34bbe0..0713daa651d9 100644
> --- a/arch/powerpc/kernel/entry_32.S
> +++ b/arch/powerpc/kernel/entry_32.S
> @@ -214,7 +214,7 @@ transfer_to_handler_cont:
>  	 * To speed up the syscall path where interrupts stay on, let's check
>  	 * first if we are changing the MSR value at all.
>  	 */
> -	tophys(r12, r1)
> +	tophys_novmstack r12, r1
>  	lwz	r12,_MSR(r12)
>  	andi.	r12,r12,MSR_EE
>  	bne	1f
> -- 
> 2.25.0
> 
