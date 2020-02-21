Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57ABBC35640
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F2D124650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 10:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582280045;
	bh=nO5MzX5N/JzArtsAYaiCeqGA2+KEQX9ht2RlhkrW54s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=CPF2TO35hHRd2n6xr1kpXkIuhnZM6w6vUfryJHyy4d+lNqpJ+WgwwiSw2C9e6CTXM
	 gnB9wD7FJQBaSMiId6pye2anthYqOUnC2RMFiyZIIHusT4SvnvNIyN9ycWYQ2+AhGL
	 04hG1WjERG5AI/xDtm+vtjmUSaUXi7vX6G6Hh6go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728754AbgBUKOD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 05:14:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727150AbgBUKOB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 05:14:01 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 14A4C20722;
        Fri, 21 Feb 2020 10:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582280041;
        bh=nO5MzX5N/JzArtsAYaiCeqGA2+KEQX9ht2RlhkrW54s=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GeJYVaIKmz6PQk7Ypo8ZZVVod/zsrBbqXb3cv/VBI8N6TjBFUMc9QnnJhMaN3HtrX
         rofkMc88HrtsU2ixHL7y2QBJYavb5B95FhYEkbhb3WYL5SATkPw0Y6TwAk2naiPQY8
         xp08rqmWcWcubPI+AnzmJyCz0fTJ9ueox47B8JS8=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j55Jn-0070UG-3T; Fri, 21 Feb 2020 10:13:59 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 21 Feb 2020 10:13:58 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de,
        wanghaibin.wang@huawei.com
Subject: Re: [PATCH] genirq/irqdomain: Make sure all irq domain flags are
 distinct
In-Reply-To: <20200221020725.2038-1-yuzenghui@huawei.com>
References: <20200221020725.2038-1-yuzenghui@huawei.com>
Message-ID: <7dec8c6eb07f634a4cccec3be5136e2f@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, wanghaibin.wang@huawei.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-21 02:07, Zenghui Yu wrote:
> This was noticed when printing debugfs for MSIs on my ARM64 server.
> The new dstate IRQD_MSI_NOMASK_QUIRK came out surprisingly while it
> should only be the x86 stuff for the time being...
> 
> It's the overlap in irqdomain flags which leads to this confusion.
> (1 << 1) might be a good choice for old IRQ_DOMAIN_NAME_ALLOCATED,
> use it to avoid this overlap.
> 
> Fixes: 6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity 
> race")

To be fair, the real source of the bug is this:

6a6544e520abe ("genirq/irqdomain: Remove auto-recursive hierarchy 
support")

> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  include/linux/irqdomain.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
> index b2d47571ab67..8d062e86d954 100644
> --- a/include/linux/irqdomain.h
> +++ b/include/linux/irqdomain.h
> @@ -192,7 +192,7 @@ enum {
>  	IRQ_DOMAIN_FLAG_HIERARCHY	= (1 << 0),
> 
>  	/* Irq domain name was allocated in __irq_domain_add() */
> -	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 6),
> +	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 1),
> 
>  	/* Irq domain is an IPI domain with virq per cpu */
>  	IRQ_DOMAIN_FLAG_IPI_PER_CPU	= (1 << 2),

Acked-by: Marc Zyngier <maz@kernel.org>

Thomas, do you mind picking this one up, as I don't have anything
else for the time being?


         M.
-- 
Jazz is not dead. It just smells funny...
