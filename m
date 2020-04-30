Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3FE4C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F08E214D8
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 10:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588241679;
	bh=K4iRN3zCPNFjbTseot6WcbvyRWpaRNNyZ8e0DoLGw0E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rnvhQH/wchGyrLlmIJzUolO9DwUQeXu/68quu904LjF7OEFcLoN01He/c7Cu6iB57
	 0OHcwtSF9Th7NddiN/0cHZ144JZj49/g5n94hB1uJgiMWpcdn3mSA0e0tWQotXG8x1
	 7YVR4Xps09nN+UyYkZQJUXyU1J7dR0jiZ/9J3ZO8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgD3KOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 06:14:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:46132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbgD3KOi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 06:14:38 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 546C52082E;
        Thu, 30 Apr 2020 10:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588241677;
        bh=K4iRN3zCPNFjbTseot6WcbvyRWpaRNNyZ8e0DoLGw0E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JvlDRD0fualhnU0GtkqaCGYeK0Ta5RV7QlJMm+JXxK6sJpn+Ba3M4ZH+1i92mJL0x
         heHHfzv8MWGQl/ku3fbX8+JeRaDczFuoMJh77a7aya9Z2AA2yQdeG6kk2+w4pu21MY
         nx67itkvi/2CXKxGbdHb5la8yWUNEL0Nqkcfe3pc=
Date:   Thu, 30 Apr 2020 11:14:32 +0100
From:   Will Deacon <will@kernel.org>
To:     Srivatsa Vaddagiri <vatsa@codeaurora.org>
Cc:     konrad.wilk@oracle.com, mst@redhat.com, jasowang@redhat.com,
        jan.kiszka@siemens.com, stefano.stabellini@xilinx.com,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org, tsoni@codeaurora.org,
        pratikp@codeaurora.org, christoffer.dall@arm.com,
        alex.bennee@linaro.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC/PATCH 1/1] virtio: Introduce MMIO ops
Message-ID: <20200430101431.GD19932@willie-the-truck>
References: <1588240976-10213-1-git-send-email-vatsa@codeaurora.org>
 <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588240976-10213-2-git-send-email-vatsa@codeaurora.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 03:32:56PM +0530, Srivatsa Vaddagiri wrote:
> Some hypervisors may not support MMIO transport i.e trap config
> space access and have it be handled by backend driver. They may
> allow other ways to interact with backend such as message-queue
> or doorbell API. This patch allows for hypervisor specific
> methods for config space IO.
> 
> Signed-off-by: Srivatsa Vaddagiri <vatsa@codeaurora.org>
> ---
>  drivers/virtio/virtio_mmio.c | 131 ++++++++++++++++++++++++++-----------------
>  include/linux/virtio.h       |  14 +++++
>  2 files changed, 94 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 97d5725..69bfa35 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -100,7 +100,35 @@ struct virtio_mmio_vq_info {
>  	struct list_head node;
>  };
>  
> +#ifdef CONFIG_VIRTIO_MMIO_OPS
>  
> +static struct virtio_mmio_ops *mmio_ops;
> +
> +#define virtio_readb(a)		mmio_ops->mmio_readl((a))
> +#define virtio_readw(a)		mmio_ops->mmio_readl((a))
> +#define virtio_readl(a)		mmio_ops->mmio_readl((a))
> +#define virtio_writeb(val, a)	mmio_ops->mmio_writeb((val), (a))
> +#define virtio_writew(val, a)	mmio_ops->mmio_writew((val), (a))
> +#define virtio_writel(val, a)	mmio_ops->mmio_writel((val), (a))

How exactly are these ops hooked up? I'm envisaging something like:

	ops = spec_compliant_ops;
	[...]
	if (firmware_says_hypervisor_is_buggy())
		ops = magic_qcom_ops;

am I wrong?

> +int register_virtio_mmio_ops(struct virtio_mmio_ops *ops)
> +{
> +	pr_info("Registered %s as mmio ops\n", ops->name);
> +	mmio_ops = ops;

Not looking good, and really defeats the point of standardising this stuff
imo.

Will
