Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D92C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 490DE20674
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597693113;
	bh=Pzsot6q3dgWfHBZvvoYCwTxZohnjcMafvwd+AYasv8c=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xMqdqI8uR8n+T8uQNqO7yQ/aR5t581mhJO+pu52m+QbjiOG1e8EIXQDNZppPY22FJ
	 dqRgfvg9bu0fJzl8IngaFQCzk4ztuh+UaVM2mYC5ocC59ZwPa57mCB934IfLtPh4mW
	 vh67mdwwJhJGpgD1Ip9wJn5EMFbpQtWOZI06bA+c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732457AbgHQTi1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:38:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37684 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729458AbgHQP1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 11:27:08 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DC5323B31;
        Mon, 17 Aug 2020 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597678027;
        bh=Pzsot6q3dgWfHBZvvoYCwTxZohnjcMafvwd+AYasv8c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TKpmuevWf/H7VG7jRpvc30/GfAIYWsNtzFm4xo4LUrsczSuZmUNbu5EuHyt+jDmci
         sTHooQocRBBliQwj0h6zf9EnJXpTgx95e0xl08MFqeUwrFx5XC7hyfQhi+QDPOggUM
         vCvK6JyHwgPBhk6JlesuA645jbqAsvDaYcM2GkKo=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1k7h2P-003bML-ME; Mon, 17 Aug 2020 16:27:05 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 17 Aug 2020 16:27:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Frank Wunderlich <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Revert "irqchip/mtk-sysirq: Convert to a platform driver"
In-Reply-To: <20200817145738.986999-1-linux@fw-web.de>
References: <20200817145738.986999-1-linux@fw-web.de>
User-Agent: Roundcube Webmail/1.4.7
Message-ID: <7b9c3ee73faeaf8d2e64c228047438f1@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: linux@fw-web.de, linux-mediatek@lists.infradead.org, frank-w@public-files.de, tglx@linutronix.de, jason@lakedaemon.net, matthias.bgg@gmail.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-17 15:57, Frank Wunderlich wrote:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This reverts commit f97dbf48ca43009e8b8bcdf07f47fc9f06149b36 which
> breaks bootup of arm/arm64 devices like bananapi-r2/mt7623 and
> bananapi-r64/mt7622
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> ---
>  drivers/irqchip/irq-mtk-sysirq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-mtk-sysirq.c 
> b/drivers/irqchip/irq-mtk-sysirq.c
> index 7299c5ab4d10..6ff98b87e5c0 100644
> --- a/drivers/irqchip/irq-mtk-sysirq.c
> +++ b/drivers/irqchip/irq-mtk-sysirq.c
> @@ -231,6 +231,4 @@ static int __init mtk_sysirq_of_init(struct
> device_node *node,
>  	kfree(chip_data);
>  	return ret;
>  }
> -IRQCHIP_PLATFORM_DRIVER_BEGIN(mtk_sysirq)
> -IRQCHIP_MATCH("mediatek,mt6577-sysirq", mtk_sysirq_of_init)
> -IRQCHIP_PLATFORM_DRIVER_END(mtk_sysirq)
> +IRQCHIP_DECLARE(mtk_sysirq, "mediatek,mt6577-sysirq", 
> mtk_sysirq_of_init);

There is already a fix queued for this.

        M.
-- 
Jazz is not dead. It just smells funny...
