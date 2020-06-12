Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99857C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:06:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F0020801
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 14:06:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591970793;
	bh=K18l24DjovwEYHOQ7k+M0/KaNKer8w4ba5zMXo429sQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U7GggGV49FMmhh5/l1O5E/eZjCJtzP076b1CTdFB55vkBRgANiIVTq7IlcCJPf7EI
	 EdZ6ValrIGBZTIudKb0nMCjf+zVl1vwNnWkEHc6r3ptizak26m7ha0V4rpI7OUvvFJ
	 nzYjr04H3IeiHGdAEv35WvXxLaFaElVHVCzXMtpg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgFLOGb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:06:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:36150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgFLOGb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 10:06:31 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A47A32074B;
        Fri, 12 Jun 2020 14:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591970790;
        bh=K18l24DjovwEYHOQ7k+M0/KaNKer8w4ba5zMXo429sQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sZNeKKbaFCkzh0sVwnu9L6NEeK7rsl/cYeBGCZDvl8Uf8kWQBOqc+zeACzfSy8RDd
         xtuVe1d6VozAs99+I9ZCpB+9zDdmTw0i1KHUgWeRAZhdF04zF3RM32RgyLZoJ5Fzk2
         eh54rqt6O9LOhFARvsciOsT5exE+dceTq1UF69Es=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jjkKD-002Q27-4o; Fri, 12 Jun 2020 15:06:29 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 12 Jun 2020 15:06:29 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Anup Patel <Anup.Patel@wdc.com>, tglx@linutronix.de,
        jason@lakedaemon.net, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kernel-team@android.com,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH] irqchip: riscv-intc: Fix a typo in a pr_warn()
In-Reply-To: <20200611175302.253540-1-palmer@dabbelt.com>
References: <20200611175302.253540-1-palmer@dabbelt.com>
User-Agent: Roundcube Webmail/1.4.4
Message-ID: <edd04e6af3c16eabc83f28fe650a36f0@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: palmer@dabbelt.com, Anup.Patel@wdc.com, tglx@linutronix.de, jason@lakedaemon.net, paul.walmsley@sifive.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, kernel-team@android.com, palmerdabbelt@google.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-11 18:53, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmerdabbelt@google.com>
> 
> Anup originally re-spun his patch set to include this fix, but it was a 
> bit too
> late for my PR so I've split it out.
> 
> Signed-off-by: Palmer Dabbelt <palmerdabbelt@google.com>
> ---
>  drivers/irqchip/irq-riscv-intc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-riscv-intc.c 
> b/drivers/irqchip/irq-riscv-intc.c
> index a6f97fa6ff69..8017f6d32d52 100644
> --- a/drivers/irqchip/irq-riscv-intc.c
> +++ b/drivers/irqchip/irq-riscv-intc.c
> @@ -99,7 +99,7 @@ static int __init riscv_intc_init(struct device_node 
> *node,
> 
>  	hartid = riscv_of_parent_hartid(node);
>  	if (hartid < 0) {
> -		pr_warn("unable to fine hart id for %pOF\n", node);
> +		pr_warn("unable to find hart id for %pOF\n", node);
>  		return 0;
>  	}

I'll pick it post -rc1, once I merge Linus' tree into mine.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
