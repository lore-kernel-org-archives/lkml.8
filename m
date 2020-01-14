Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FE4C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0272467E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 23:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579044629;
	bh=njIt0QYXLBr1W9wgpPzxS+7c8cizvwPCx3Oe3IsRT9M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RqDdyfNvjtFsKRcMfri5qNSILg9NUYxeaAfqgHT1wQshi7u2CSHe2/+whVIVUaOw3
	 +131/nXBFtiVTA3Yo8xz1X4etoam1Gb9GNUIfjuJ7n/aNO9ak/Zgl39Fn9yjiIgQJH
	 acVwkx8fPisanbX4OjZPQ/SeBa80UAw/jHXNrIqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729021AbgANXa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 18:30:28 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:41994 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728759AbgANXa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 18:30:28 -0500
Received: by mail-pg1-f196.google.com with SMTP id s64so7144123pgb.9;
        Tue, 14 Jan 2020 15:30:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=xtay45JSoYDoBInOvIBkON2umcFhUQpYehz+90UqGzQ=;
        b=TjpglJOOlC/4jLwV42ppWnmffTIgwiSgCGYqV636ES1IcvGsUupi4hBriH1agzg3J2
         bdC5qkm1aVR0dWn86nMu2Nank7VGSMm5DQ4GfzxWnNKrVNKm9I2qmbOpu/Ggo419iBAh
         1wgYJA0kkKbbPCWkK2rFIjllOp6s1OpwzLDdAoq7g+Krwn8EsLAibUmCTw0F5f0Up7Zx
         9WIHcBsYRfFFEcE0aL+Rm2iX+tl0wQoISvJzoElVccPoc51HxZ1pI0VqE6Lv7Xgb5NBn
         AKJwrIqlObTns8ph8iHIrxpWA6cNwK6bgYNaFee/A+GtaGCqoXM3DskWog4BkZ4OWXI5
         dR5w==
X-Gm-Message-State: APjAAAXnmuCHwnn7EbdsLQ+0sQjRLjHtRASAornxOPk4rABmqUZ6hx9N
        BcA4cZrV/Z5lyOFLDcSp4MY=
X-Google-Smtp-Source: APXvYqxfDRELNDfkiKLOjOnc8yn+X0p9GiSoBZA2079ouTSIRqhfvb98Ufu56YKWqXMwxsmfg6bA5g==
X-Received: by 2002:a62:486:: with SMTP id 128mr28162928pfe.236.1579044627249;
        Tue, 14 Jan 2020 15:30:27 -0800 (PST)
Received: from localhost (MIPS-TECHNO.ear1.SanJose1.Level3.net. [4.15.122.74])
        by smtp.gmail.com with ESMTPSA id dw10sm14376039pjb.11.2020.01.14.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 15:30:26 -0800 (PST)
Date:   Tue, 14 Jan 2020 15:30:25 -0800
From:   Paul Burton <paulburton@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, chenhc@lemote.com,
        paul.burton@mips.com, tglx@linutronix.de, jason@lakedaemon.net,
        maz@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip: mips-cpu: Remove eoi operation
Message-ID: <20200114233025.y4azwvivqo7kg7i5@pburton-laptop>
References: <20200113101251.37471-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200113101251.37471-1-jiaxun.yang@flygoat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiaxun,

On Mon, Jan 13, 2020 at 06:12:51PM +0800, Jiaxun Yang wrote:
> The eoi opreation in mips_cpu_irq_controller caused chained_irq_enter
> falsely consider CPU IP interrupt as a FastEOI type IRQ. So the interrupt
> won't be masked during in handler. Which might lead to spurious interrupt.
> 
> Thus we simply remove eoi operation for mips_cpu_irq_controller,
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
>  drivers/irqchip/irq-mips-cpu.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-mips-cpu.c b/drivers/irqchip/irq-mips-cpu.c
> index 95d4fd8f7a96..0ad7f1f9a58b 100644
> --- a/drivers/irqchip/irq-mips-cpu.c
> +++ b/drivers/irqchip/irq-mips-cpu.c
> @@ -55,7 +55,6 @@ static struct irq_chip mips_cpu_irq_controller = {
>  	.irq_mask	= mask_mips_irq,
>  	.irq_mask_ack	= mask_mips_irq,
>  	.irq_unmask	= unmask_mips_irq,
> -	.irq_eoi	= unmask_mips_irq,
>  	.irq_disable	= mask_mips_irq,
>  	.irq_enable	= unmask_mips_irq,
>  };

This one scares me; something doesn't seem right. The irq_eoi (née eoi)
callback was first added way back in commit 1417836e81c0 ("[MIPS] use
generic_handle_irq, handle_level_irq, handle_percpu_irq"). The commit
message there states that the motivation was to allow use of
handle_percpu_irq(), and indeed handle_percpu_irq() does:

    irq_ack() (ie. mask)
    invoke the handler(s)
    irq_eoi() (ie. unmask)

By removing the irq_eoi callback I don't see how we'd ever unmask the
interrupt again..?

Thanks,
    Paul
