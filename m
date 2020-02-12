Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F400C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:40:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 484F420658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 07:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YZrQmYLV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728369AbgBLHkP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 02:40:15 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25227 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728192AbgBLHkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 02:40:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581493213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xVKePZgaphaDI35OhGGqEmHTyZDPeJtIwjix5bHryQw=;
        b=YZrQmYLVoG/VoAQY9UfFgdJUPLoTlRquGYbLUHrEcZ0+lFt0VlkVVs2DWP39yhMUQdBrN4
        gd+u3XdS15tcWodA0DG+4CbKkRLWlC3/COjjyWoXf5BEG1F2+CXS4jGJdoYoqWjuabR+QC
        ofy5PkQEZvH8fo63ozKB75NWfdiD+38=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-240-QpGK1khxNGiAU5A03joymw-1; Wed, 12 Feb 2020 02:40:09 -0500
X-MC-Unique: QpGK1khxNGiAU5A03joymw-1
Received: by mail-qv1-f70.google.com with SMTP id n11so903576qvp.15
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 23:40:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xVKePZgaphaDI35OhGGqEmHTyZDPeJtIwjix5bHryQw=;
        b=BGkzYBSaTUz6PASdTghyVxBuH22cxBJgVhk3Am9jUa2YxnBgqjAKaZjXr2F/W236Mo
         4fgmQJ/75h1s551QcuUUWzSnk+0YNiGPiOPtImxUwL3rl29kZrdq0nL2MirlHRsl5m0W
         fBwEb4J7evlLSJkT1kdgpuFISxETJHSN+SfcHI01pixd00cNE7FNos2y1K/z4DyCQ0Dr
         yzNrmVwFF1Ref0LtrRuGxanlmSSL/7B4P6zvcaBHezF3JRKk5GS7kiI5iLbV8VUsIMhv
         p+D7jmbZY8y7ha41olVniuT6B2bxKJyBqKM+RJ8ld5t4rG/NeY2pTavUBlo1wb8cFiAI
         aUgg==
X-Gm-Message-State: APjAAAXAI2OMUVOjyyb0o3WN1G6FK+KgpQImMhINyZXDEQE4uT/qwq+u
        tBgKKpgGNiPJmJGvvDCKQe04aqz2aOsxpJmIlf8AwSvL/GS6L/qQ/Ht4EJkvwCALaIc9OWS81hG
        8dsOhqBjFfXftVhPXfo12Ov7Z
X-Received: by 2002:a37:2e44:: with SMTP id u65mr4852226qkh.262.1581493209128;
        Tue, 11 Feb 2020 23:40:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyy+Ry1Zatw1m0sXpMx8HYxWWQ4COR7G3iFEl3z4TO+wr2swYRITwLGNXj+PQF406l4DPKOmQ==
X-Received: by 2002:a37:2e44:: with SMTP id u65mr4852208qkh.262.1581493208834;
        Tue, 11 Feb 2020 23:40:08 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id i28sm3841339qtc.57.2020.02.11.23.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 23:40:08 -0800 (PST)
Date:   Wed, 12 Feb 2020 02:40:03 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 3/5] virtio-mmio: create a generic MSI irq domain
Message-ID: <20200212023540-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4c52548758eefe1fe7078d3b6f10492a001c0636.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:05:19PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
> 
> Create a generic irq domain for all architectures which
> supports virtio-mmio. The device offering VIRTIO_F_MMIO_MSI
> feature bit can use this irq domain.
> 
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  drivers/base/platform-msi.c      |  4 +-
>  drivers/virtio/Kconfig           |  9 ++++
>  drivers/virtio/virtio_mmio_msi.h | 93 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/msi.h              |  1 +
>  4 files changed, 105 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/virtio/virtio_mmio_msi.h
> 
> diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
> index 8da314b..45752f1 100644
> --- a/drivers/base/platform-msi.c
> +++ b/drivers/base/platform-msi.c
> @@ -31,12 +31,11 @@ struct platform_msi_priv_data {
>  /* The devid allocator */
>  static DEFINE_IDA(platform_msi_devid_ida);
>  
> -#ifdef GENERIC_MSI_DOMAIN_OPS
>  /*
>   * Convert an msi_desc to a globaly unique identifier (per-device
>   * devid + msi_desc position in the msi_list).
>   */
> -static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>  {
>  	u32 devid;
>  
> @@ -45,6 +44,7 @@ static irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc)
>  	return (devid << (32 - DEV_ID_SHIFT)) | desc->platform.msi_index;
>  }
>  
> +#ifdef GENERIC_MSI_DOMAIN_OPS
>  static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
>  {
>  	arg->desc = desc;
> diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> index 078615c..551a9f7 100644
> --- a/drivers/virtio/Kconfig
> +++ b/drivers/virtio/Kconfig
> @@ -84,6 +84,15 @@ config VIRTIO_MMIO
>  
>   	 If unsure, say N.
>  
> +config VIRTIO_MMIO_MSI
> +	bool "Memory-mapped virtio device MSI"
> +	depends on VIRTIO_MMIO && GENERIC_MSI_IRQ_DOMAIN && GENERIC_MSI_IRQ
> +	help
> +	 This allows device drivers to support msi interrupt handling for
> +	 virtio-mmio devices. It can improve performance greatly.
> +
> +	 If unsure, say N.
> +
>  config VIRTIO_MMIO_CMDLINE_DEVICES
>  	bool "Memory mapped virtio devices parameter parsing"
>  	depends on VIRTIO_MMIO
> diff --git a/drivers/virtio/virtio_mmio_msi.h b/drivers/virtio/virtio_mmio_msi.h
> new file mode 100644
> index 0000000..27cb2af
> --- /dev/null
> +++ b/drivers/virtio/virtio_mmio_msi.h
> @@ -0,0 +1,93 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#ifndef _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
> +#define _DRIVERS_VIRTIO_VIRTIO_MMIO_MSI_H
> +
> +#ifdef CONFIG_VIRTIO_MMIO_MSI
> +
> +#include <linux/msi.h>
> +#include <linux/irq.h>
> +#include <linux/irqdomain.h>
> +#include <linux/platform_device.h>
> +
> +static irq_hw_number_t mmio_msi_hwirq;
> +static struct irq_domain *mmio_msi_domain;

So each instance of including this header will create its own
copy of the variables. That won't do the right thing.


> +
> +struct irq_domain *__weak arch_msi_root_irq_domain(void)
> +{
> +	return NULL;
> +}
> +
> +void __weak irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +}
> +
> +static void mmio_msi_mask_irq(struct irq_data *data)
> +{
> +}
> +
> +static void mmio_msi_unmask_irq(struct irq_data *data)
> +{
> +}
> +
> +static struct irq_chip mmio_msi_controller = {
> +	.name			= "VIRTIO-MMIO-MSI",
> +	.irq_mask		= mmio_msi_mask_irq,
> +	.irq_unmask		= mmio_msi_unmask_irq,
> +	.irq_ack		= irq_chip_ack_parent,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_compose_msi_msg	= irq_msi_compose_msg,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static int mmio_msi_prepare(struct irq_domain *domain, struct device *dev,
> +				int nvec, msi_alloc_info_t *arg)
> +{
> +	memset(arg, 0, sizeof(*arg));
> +	return 0;
> +}
> +
> +static void mmio_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
> +{
> +	mmio_msi_hwirq = platform_msi_calc_hwirq(desc);
> +}
> +
> +static irq_hw_number_t mmio_msi_get_hwirq(struct msi_domain_info *info,
> +					      msi_alloc_info_t *arg)
> +{
> +	return mmio_msi_hwirq;
> +}
> +
> +static struct msi_domain_ops mmio_msi_domain_ops = {
> +	.msi_prepare	= mmio_msi_prepare,
> +	.set_desc	= mmio_msi_set_desc,
> +	.get_hwirq	= mmio_msi_get_hwirq,
> +};
> +
> +static struct msi_domain_info mmio_msi_domain_info = {
> +	.flags          = MSI_FLAG_USE_DEF_DOM_OPS |
> +			  MSI_FLAG_USE_DEF_CHIP_OPS |
> +			  MSI_FLAG_ACTIVATE_EARLY,
> +	.ops            = &mmio_msi_domain_ops,
> +	.chip           = &mmio_msi_controller,
> +	.handler        = handle_edge_irq,
> +	.handler_name   = "edge",
> +};
> +
> +static inline void mmio_msi_create_irq_domain(void)
> +{
> +	struct fwnode_handle *fn;
> +	struct irq_domain *parent = arch_msi_root_irq_domain();
> +
> +	fn = irq_domain_alloc_named_fwnode("VIRTIO-MMIO-MSI");
> +	if (fn && parent) {
> +		mmio_msi_domain =
> +			platform_msi_create_irq_domain(fn,
> +				&mmio_msi_domain_info, parent);
> +		irq_domain_free_fwnode(fn);
> +	}
> +}

It does not look like anyone cleans up this domain.
So how does this work with a modular virtio mmio?
what happens when you unload the module?


> +#else
> +static inline void mmio_msi_create_irq_domain(void) {}
> +#endif
> +
> +#endif
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8ad679e..ee5f566 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -362,6 +362,7 @@ int platform_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  void platform_msi_domain_free(struct irq_domain *domain, unsigned int virq,
>  			      unsigned int nvec);
>  void *platform_msi_get_host_data(struct irq_domain *domain);
> +irq_hw_number_t platform_msi_calc_hwirq(struct msi_desc *desc);
>  #endif /* CONFIG_GENERIC_MSI_IRQ_DOMAIN */
>  
>  #ifdef CONFIG_PCI_MSI_IRQ_DOMAIN
> -- 
> 1.8.3.1

