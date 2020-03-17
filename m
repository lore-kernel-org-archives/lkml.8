Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59D9EC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EA7420714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 10:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nc8IM5/p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgCQKfY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 06:35:24 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:25214 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725730AbgCQKfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 06:35:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584441322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PDF9KX2gWP/KQxi7FPC/r6zYWiKxTIB+y9Tt6qr75x0=;
        b=Nc8IM5/p2kEfKVbONuOE93Zu4S3yzZEIiJuyDCGm/rqb3To/HfiqeAfooJESHWvvrjLo/U
        Jgo8DPC+SLDsQjkOIds6hZIrkZ1GEP0mvRpjfxUsQbbHw8/VDGoTFiF5MjxuRo0U4dk5eE
        TCJj9G2PW2jRGUJg0zZGiWtHaROSYBM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-MHeVK9nTPLqv1JiyvpOjEw-1; Tue, 17 Mar 2020 06:35:18 -0400
X-MC-Unique: MHeVK9nTPLqv1JiyvpOjEw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0656118A551B;
        Tue, 17 Mar 2020 10:35:16 +0000 (UTC)
Received: from [10.36.113.142] (ovpn-113-142.ams2.redhat.com [10.36.113.142])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F33D75C1C3;
        Tue, 17 Mar 2020 10:35:12 +0000 (UTC)
Subject: Re: [PATCH v5 12/23] irqchip/gic-v4.1: Plumb set_vcpu_affinity SGI
 callbacks
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
 <20200304203330.4967-13-maz@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <2f981328-92e8-7554-ccf7-962c79add0c3@redhat.com>
Date:   Tue, 17 Mar 2020 11:35:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200304203330.4967-13-maz@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 3/4/20 9:33 PM, Marc Zyngier wrote:
> Just like for vLPIs, there is some configuration information that cannot
> be directly communicated through the normal irqchip API, and we have to
> use our good old friend set_vcpu_affinity as a side-band communication
> mechanism.
> 
> This is used to configure group and priority for a given vSGI.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c   | 18 ++++++++++++++++++
>  include/linux/irqchip/arm-gic-v4.h |  5 +++++
>  2 files changed, 23 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index fb2b836c31ff..effb0e0b0c9d 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -4033,6 +4033,23 @@ static int its_sgi_get_irqchip_state(struct irq_data *d,
>  	return 0;
>  }
>  
> +static int its_sgi_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
> +{
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +	struct its_cmd_info *info = vcpu_info;
> +
> +	switch (info->cmd_type) {
> +	case PROP_UPDATE_SGI:
PROP_UPDATE_VSGI directly?
> +		vpe->sgi_config[d->hwirq].priority = info->priority;
> +		vpe->sgi_config[d->hwirq].group = info->group;
> +		its_configure_sgi(d, false);
> +		return 0;
> +
extra line
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
>  static struct irq_chip its_sgi_irq_chip = {
>  	.name			= "GICv4.1-sgi",
>  	.irq_mask		= its_sgi_mask_irq,
> @@ -4040,6 +4057,7 @@ static struct irq_chip its_sgi_irq_chip = {
>  	.irq_set_affinity	= its_sgi_set_affinity,
>  	.irq_set_irqchip_state	= its_sgi_set_irqchip_state,
>  	.irq_get_irqchip_state	= its_sgi_get_irqchip_state,
> +	.irq_set_vcpu_affinity	= its_sgi_set_vcpu_affinity,
>  };
>  
>  static int its_sgi_irq_domain_alloc(struct irq_domain *domain,
> diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
> index 44e8c19e3d56..b4dbf899460b 100644
> --- a/include/linux/irqchip/arm-gic-v4.h
> +++ b/include/linux/irqchip/arm-gic-v4.h
> @@ -103,6 +103,7 @@ enum its_vcpu_info_cmd_type {
>  	SCHEDULE_VPE,
>  	DESCHEDULE_VPE,
>  	INVALL_VPE,
> +	PROP_UPDATE_SGI,
>  };
>  
>  struct its_cmd_info {
> @@ -115,6 +116,10 @@ struct its_cmd_info {
>  			bool		g0en;
>  			bool		g1en;
>  		};
> +		struct {
> +			u8		priority;
> +			bool		group;
> +		};
>  	};
>  };
>  
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric

