Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3049C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9FA32187F
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 12:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583151170;
	bh=Lymq4yucP910jG3yAZt3+nbi5KerTQ3U6G6bpUjy4to=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=zvV4nj7d5uR7fO2RpqT0owakJDizZc9HVD5E6Y3yVpWLPRX+Rm6bpAqPzsEBT5BrK
	 8v8pb0JLXX0RqnMHSPBN6HD3E9DRs52EvYbUYfnWVn98QP+4ocHsC1TO1yHlCSaoZH
	 ivdEOApCvZfqqLpyXetv4qzTe68L0QPo1cAsigKo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgCBMMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 07:12:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:60450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726654AbgCBMMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 07:12:49 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AD112173E;
        Mon,  2 Mar 2020 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583151168;
        bh=Lymq4yucP910jG3yAZt3+nbi5KerTQ3U6G6bpUjy4to=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dzgfqg0/uVS23vSco9JoTIf3WbWIp+BhFrKQRBlscAYzmJYe1JdXz3LW0em6JDra0
         tHlUlPG/PDhJIX9GqwoQxKCaqE0RTbt1LDJzflgr3/znEysTywuYph/kfJ5dwTwg0Y
         onrCNZAOCAvxq/Pfy0xNMTkNhDf65AnnCIt5R2bQ=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j8jwE-009N9H-TY; Mon, 02 Mar 2020 12:12:47 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Mar 2020 12:12:46 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Zenghui Yu <yuzenghui@huawei.com>
Cc:     linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu,
        tglx@linutronix.de, jason@lakedaemon.net,
        wanghaibin.wang@huawei.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] irqchip/gic-v4.1: Wait for completion of redistributor's
 INVALL operation
In-Reply-To: <20200302092145.899-1-yuzenghui@huawei.com>
References: <20200302092145.899-1-yuzenghui@huawei.com>
Message-ID: <c46464a4c570e4aa12231bbd5ddefc07@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: yuzenghui@huawei.com, linux-kernel@vger.kernel.org, kvmarm@lists.cs.columbia.edu, tglx@linutronix.de, jason@lakedaemon.net, wanghaibin.wang@huawei.com, linux-arm-kernel@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-03-02 09:21, Zenghui Yu wrote:
> In GICv4.1, we emulate a guest-issued INVALL command by a direct write
> to GICR_INVALLR.  Before we finish the emulation and go back to guest,
> let's make sure the physical invalidate operation is actually completed
> and no stale data will be left in redistributor. Per the specification,
> this can be achieved by polling the GICR_SYNCR.Busy bit (to zero).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c 
> b/drivers/irqchip/irq-gic-v3-its.c
> index 83b1186ffcad..fc8c2970cee4 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3784,6 +3784,8 @@ static void its_vpe_4_1_invall(struct its_vpe 
> *vpe)
>  	/* Target the redistributor this vPE is currently known on */
>  	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
>  	gic_write_lpir(val, rdbase + GICR_INVALLR);
> +
> +	wait_for_syncr(rdbase);
>  }
> 
>  static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void 
> *vcpu_info)

Yup, well spotted. I'll add that to the series.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
