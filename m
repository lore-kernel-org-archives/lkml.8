Return-Path: <SRS0=xbEg=53=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7630DC2BA2B
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 431792087E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Apr 2020 10:59:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586602765;
	bh=xk5Kskag+XVsBHxWNEZ7J/RewiRmLUecphBYR2cj9yo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=bQfQ3OT8S/8b5/L6Pt+GWe/MO/j3Xt7/QWdcTA3gJKZIQT30p8PuIIV+pzLbIxlbR
	 jhrAGcP8becFA7+qq4kLGLlhLBeewTnU1jddlMnk93Ti47FsNOLtnOu1OGsDRnPmqT
	 cXtBFjjsUn3lDsWcioukd9qG77JNNDdWJt3NNius=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgDKK7X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Apr 2020 06:59:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgDKK7X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Apr 2020 06:59:23 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 29EB920732;
        Sat, 11 Apr 2020 10:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586602763;
        bh=xk5Kskag+XVsBHxWNEZ7J/RewiRmLUecphBYR2cj9yo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=F8XpckS2+wv/5IBH2mA0/TmqmYb5fbc9QUpEpizKARVx9lzVjoMYoF+UvF/96kpR2
         jiU+pbzEU8VUJyjaAcApFTjRnlLB8kKPvsXLRvb/c64dVwpApQAxvx89C8vlbswjAF
         rLQXPMVcju7hvUXs/Dm/dcDmxPtqKWb7dh/5Y+gg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jNDr7-002MZc-Bt; Sat, 11 Apr 2020 11:59:21 +0100
Date:   Sat, 11 Apr 2020 11:59:19 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Atish Patra <atish.patra@wdc.com>
Cc:     linux-kernel@vger.kernel.org, Anup Patel <anup@brainfault.org>,
        Jason Cooper <jason@lakedaemon.net>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] irqchip/sifive-plic: Fix maximum priority threshold
 value
Message-ID: <20200411115919.32fc0455@why>
In-Reply-To: <20200403014609.71831-1-atish.patra@wdc.com>
References: <20200403014609.71831-1-atish.patra@wdc.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: atish.patra@wdc.com, linux-kernel@vger.kernel.org, anup@brainfault.org, jason@lakedaemon.net, linux-riscv@lists.infradead.org, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  2 Apr 2020 18:46:09 -0700
Atish Patra <atish.patra@wdc.com> wrote:

> As per the PLIC specification, maximum priority threshold value is 0x7
> not 0xF. Even though it doesn't cause any error in qemu/hifive unleashed,
> there may be some implementation which checks the upper bound resulting in
> an illegal access.
> 
> Fixes: ccbe80bad571 (irqchip/sifive-plic: Enable/Disable external
> 		     interrupts upon cpu online/offline)

Small nit: please write the "Fixes:" tag as documented in
process/submitting-patches.rst:

Fixes: ccbe80bad571 ("irqchip/sifive-plic: Enable/Disable external interrupts upon cpu online/offline")

(with quotes, and on a single line), as it otherwise breaks with the
lore-scrapping tooling which a bunch of us are now using.

> Signed-off-by: Atish Patra <atish.patra@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
> index c34fb3ae0ff8..d0a71febdadc 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -56,7 +56,7 @@
>  #define     CONTEXT_THRESHOLD		0x00
>  #define     CONTEXT_CLAIM		0x04
>  
> -#define	PLIC_DISABLE_THRESHOLD		0xf
> +#define	PLIC_DISABLE_THRESHOLD		0x7
>  #define	PLIC_ENABLE_THRESHOLD		0
>  
>  struct plic_priv {

Queued for post -rc1.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
