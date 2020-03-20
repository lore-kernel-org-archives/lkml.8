Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1011C54FCE
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:24:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 716EB2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 14:24:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FXlO3QjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgCTOYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 10:24:07 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:27768 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727440AbgCTOYE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 10:24:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584714243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ChzXaaoXuhc1XP2003YPwEPKXIEY82z0Pz3X4zEVJU0=;
        b=FXlO3QjXpfgPNZohO+4L6wml4AfNk5ieWhZ0bBTWdGqaVvm2pIT9R5emEVrMDYaZ0/fRgV
        ykIS/eLlSgUCgx15DRMOfjZXL8BpUCr3/toI9y+5mlFdj6WsoPQtXaHRhT+9ho/Wk46V57
        DoIHeULMT6ksmZXHXlNVADhpFjauotY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-LVVhRZYhMzqVwGVfnSqSUg-1; Fri, 20 Mar 2020 10:23:57 -0400
X-MC-Unique: LVVhRZYhMzqVwGVfnSqSUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D7E581005510;
        Fri, 20 Mar 2020 14:23:54 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 96AF45C1B3;
        Fri, 20 Mar 2020 14:23:50 +0000 (UTC)
Subject: Re: [PATCH v5 04/23] irqchip/gic-v4.1: Wait for completion of
 redistributor's INVALL operation
To:     Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Robert Richter <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Zenghui Yu <yuzenghui@huawei.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-5-maz@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <60beb328-5249-a79e-eceb-967716a085bc@redhat.com>
Date:   Fri, 20 Mar 2020 15:23:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200304203330.4967-5-maz@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/4/20 9:33 PM, Marc Zyngier wrote:
> From: Zenghui Yu <yuzenghui@huawei.com>
> 
> In GICv4.1, we emulate a guest-issued INVALL command by a direct write
> to GICR_INVALLR.  Before we finish the emulation and go back to guest,
> let's make sure the physical invalidate operation is actually completed
> and no stale data will be left in redistributor. Per the specification,
> this can be achieved by polling the GICR_SYNCR.Busy bit (to zero).
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: https://lore.kernel.org/r/20200302092145.899-1-yuzenghui@huawei.com
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 1af713990123..c84370245bea 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3827,6 +3827,8 @@ static void its_vpe_4_1_invall(struct its_vpe *vpe)
>  	/* Target the redistributor this vPE is currently known on */
>  	rdbase = per_cpu_ptr(gic_rdists->rdist, vpe->col_idx)->rd_base;
>  	gic_write_lpir(val, rdbase + GICR_INVALLR);
> +
> +	wait_for_syncr(rdbase);
>  }
>  
>  static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
> 

