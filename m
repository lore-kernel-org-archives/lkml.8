Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3713FC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 13E9A206D8
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 12:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589632235;
	bh=zW9HKonnsAlZGhZvKDOEYYfWIia43qEPpLdDXghOizs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=v1/RN0HAbvUAgJHUpnFjYysEYEP8zqoP/GBa2NCibNkVcRFFi5rZCaQySUIuCaoM1
	 HqiZ4kApsmFFKX3oyI8QZB1crqZ3kRvrD6BFTscxnMy3iqaNDG9WrTrs1EYcyNATss
	 7x0oXiap9zfVH0ArW7j7F01lsvD0JcKMMEOJ7QrU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726294AbgEPMae (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 08:30:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:53260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726219AbgEPMad (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 08:30:33 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C5AC20671;
        Sat, 16 May 2020 12:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589632233;
        bh=zW9HKonnsAlZGhZvKDOEYYfWIia43qEPpLdDXghOizs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=s1lrSGWVhML01UHJxtpr6Ec5tU/Om73H4jMFAaLIwi8/qo5kyZu6EhL2iCsf2pzwV
         7hS//AVCiodSx6ouASK2GFVPqlSjZ/NF31WoRlwdz5bvVwYWdNXjzdp1eK2A9mc5+v
         jHeyFEaZN8PJY+UqBRADkLadQS5BW1sh/jBkmAJ4=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jZvxX-00CoHk-BM; Sat, 16 May 2020 13:30:31 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Sat, 16 May 2020 13:30:31 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Anup Patel <anup.patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] irqchip/sifive-plic: Set default irq affinity in
 plic_irqdomain_map()
In-Reply-To: <20200516063901.18365-5-anup.patel@wdc.com>
References: <20200516063901.18365-1-anup.patel@wdc.com>
 <20200516063901.18365-5-anup.patel@wdc.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <6e9bf7e1ea3493c63a23c19485f3c644@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: anup.patel@wdc.com, palmer@dabbelt.com, paul.walmsley@sifive.com, tglx@linutronix.de, jason@lakedaemon.net, atish.patra@wdc.com, Alistair.Francis@wdc.com, anup@brainfault.org, linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-16 07:39, Anup Patel wrote:
> For multiple PLIC instances, each PLIC can only target a subset of
> CPUs which is represented by "lmask" in the "struct plic_priv".
> 
> Currently, the default irq affinity for each PLIC interrupt is all
> online CPUs which is illegal value for default irq affinity when we
> have multiple PLIC instances. To fix this, we now set "lmask" as the
> default irq affinity in for each interrupt in plic_irqdomain_map().
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> ---
>  drivers/irqchip/irq-sifive-plic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/irqchip/irq-sifive-plic.c
> b/drivers/irqchip/irq-sifive-plic.c
> index e42fc082ad18..9af5e2fd2574 100644
> --- a/drivers/irqchip/irq-sifive-plic.c
> +++ b/drivers/irqchip/irq-sifive-plic.c
> @@ -174,6 +174,7 @@ static int plic_irqdomain_map(struct irq_domain
> *d, unsigned int irq,
>  	irq_domain_set_info(d, irq, hwirq, &priv->chip, d->host_data,
>  			    handle_fasteoi_irq, NULL, NULL);
>  	irq_set_noprobe(irq);
> +	irq_set_affinity(irq, &priv->lmask);
>  	return 0;
>  }

Isn't that a fix? If so, please add a Fixes: tag, as well as a CC to
stable if you think it should be backported.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
