Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16FDBC18E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0C7420719
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 18:21:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrgpYio4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732325AbgCPSVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 14:21:49 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:29176 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731967AbgCPSVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 14:21:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584382907;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VJKpl0rDZzg6gkXBWfuB1lB9uS4rYX4lRTgcaLzb37w=;
        b=QrgpYio40KFqlMQUCEjrLcUlUoGlDVaVCdOU1FwIbUI4E4UCk0MMj13sBjC2ZNOn2Xzbmb
        E/xzeS1IKsElj098dVwARMYnJ6DJsbO5RH/NlcgO+5xJAEw1QOIrYejMp7LuDVzO3xOUsi
        F1aohfnLVoQNyX2gvZV42zqK4gMxnQE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-JPjx595BP4a7LmyWorbVlg-1; Mon, 16 Mar 2020 14:21:44 -0400
X-MC-Unique: JPjx595BP4a7LmyWorbVlg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4624914ECEB;
        Mon, 16 Mar 2020 18:15:58 +0000 (UTC)
Received: from [10.36.118.12] (ovpn-118-12.ams2.redhat.com [10.36.118.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0147810027A7;
        Mon, 16 Mar 2020 18:15:52 +0000 (UTC)
Subject: Re: [PATCH v5 10/23] irqchip/gic-v4.1: Plumb mask/unmask SGI
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
 <20200304203330.4967-11-maz@kernel.org>
From:   Auger Eric <eric.auger@redhat.com>
Message-ID: <c6bfa8bb-d311-153f-ef72-b1f9759ccf6e@redhat.com>
Date:   Mon, 16 Mar 2020 19:15:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20200304203330.4967-11-maz@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/4/20 9:33 PM, Marc Zyngier wrote:
> Implement mask/unmask for virtual SGIs by calling into the
> configuration helper.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index e0db3f906f87..c93f178914ee 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3939,6 +3939,22 @@ static void its_configure_sgi(struct irq_data *d, bool clear)
>  	its_send_single_vcommand(find_4_1_its(), its_build_vsgi_cmd, &desc);
>  }
>  
> +static void its_sgi_mask_irq(struct irq_data *d)
> +{
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +
> +	vpe->sgi_config[d->hwirq].enabled = false;
> +	its_configure_sgi(d, false);
> +}
> +
> +static void its_sgi_unmask_irq(struct irq_data *d)
> +{
> +	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
> +
> +	vpe->sgi_config[d->hwirq].enabled = true;
> +	its_configure_sgi(d, false);
> +}
> +
>  static int its_sgi_set_affinity(struct irq_data *d,
>  				const struct cpumask *mask_val,
>  				bool force)
> @@ -3948,6 +3964,8 @@ static int its_sgi_set_affinity(struct irq_data *d,
>  
>  static struct irq_chip its_sgi_irq_chip = {
>  	.name			= "GICv4.1-sgi",
> +	.irq_mask		= its_sgi_mask_irq,
> +	.irq_unmask		= its_sgi_unmask_irq,
>  	.irq_set_affinity	= its_sgi_set_affinity,
>  };
>  
> 
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Thanks

Eric

