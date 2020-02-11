Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FEEBC352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:16:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B1A020848
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:16:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DxPu2Fum"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728555AbgBKLQz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:16:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46282 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727950AbgBKLQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:16:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581419812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vKGNGn2it1JwwsYxCfUMczjolXl+hAYY/ftpLhJ2kO0=;
        b=DxPu2FumFFjgpDy1JlA8dKXqH3TrBq+rBbN47JPKlMOecORTdnOzGlRQxsPkLriLWFbA95
        uIj1xyPqYNOHmTQtP+S7yLf/PQSlzCwOd9If8j+ylpSx0xl1sDHmLzJuI2jYZs/8Q0SIBc
        p46IC8fCf5ycEkhGyXq4W8m/0zqT1JU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-32-D5glyEqIPUSLs47xim0anw-1; Tue, 11 Feb 2020 06:16:51 -0500
X-MC-Unique: D5glyEqIPUSLs47xim0anw-1
Received: by mail-qk1-f200.google.com with SMTP id b23so6811889qkg.17
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:16:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vKGNGn2it1JwwsYxCfUMczjolXl+hAYY/ftpLhJ2kO0=;
        b=f1M14gA+VeU9qmS/SYcjvEYz7ljqST8BAa0xLPe0KakEVE/MDjDH7wbFWjieW5rIZl
         2m7vtUQHnzoTQwDf8ZjD5weAE8+QUQncOVS0j/6PErdlwqsxykVVPQF6BJbQ9x0jLh9i
         qGg8Qp9i/4Im0eoI4CoWRTcM4zyQrhIpsW0fDxS6V5hskadmPf6Dwu2mU6djHjWvlc6s
         cqpf4xShj3kknJOayzp7oGTq05HXukF3Q8qMksxCHSRh0hwgdnOssZ5Glzl8gLEvb7V3
         uJZgGZSrS3YibcY+4h1ISEUM69l5Rl2UhH0Sl9IvH8kWt9ysRq1YPwXbiAgARC+XXaII
         asBA==
X-Gm-Message-State: APjAAAX/18suSyOS8rWeWH/5pJjS8fTjiS1Nr1T78W8Px+n8RMEla55W
        ZGogiqGxLF3h3OIKG+dc6bl3Zt9+pEsbSBBUbXrhoKDJjWlQEBBL9W8S4nmrWplT4EAXfrH2mvL
        qO6h2MtY41fdxw4fXXCvVNjH4
X-Received: by 2002:a37:8683:: with SMTP id i125mr2161814qkd.491.1581419811124;
        Tue, 11 Feb 2020 03:16:51 -0800 (PST)
X-Google-Smtp-Source: APXvYqzpubveRI33Yzc0hGrHTQqqdWpmrDXHJXaUUgY3HWWAVkliyxjcqXfwsVPK/NbnSdEAahm0Yw==
X-Received: by 2002:a37:8683:: with SMTP id i125mr2161788qkd.491.1581419810854;
        Tue, 11 Feb 2020 03:16:50 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id d25sm1788100qka.39.2020.02.11.03.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:16:50 -0800 (PST)
Date:   Tue, 11 Feb 2020 06:16:45 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 3/5] virtio-mmio: create a generic MSI irq domain
Message-ID: <20200211061503-mutt-send-email-mst@kernel.org>
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


This patch needs to copy maintainers for drivers/base/platform-msi.c and
include/linux/msi.h

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


This call isn't exported to modules. How will it work when virtio is
modular?

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

