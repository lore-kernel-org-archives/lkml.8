Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BA3C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:14:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97BDA2173E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 11:14:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hzf5IVG6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgBKLOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 06:14:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33772 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727950AbgBKLOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 06:14:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581419691;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i64HviBme2Pz18uHeGw1tj3lHgv6ae4i2ihKiY1Sg+w=;
        b=Hzf5IVG6IGm8rP2M9smA/MgaR79MQSzcLIP9DTpT9Z8Z8dEP9blRA4ftc2nGNxnKeVKPnV
        07N9li4uHQJMPl/jI1sx7tQz8h117PU/DkQaNqaR3AO62PjYjI0EXkHQ9AcWg8ho6SJ+mM
        13CYGBTmWwHsOwhRIc/ZNP5chR2XPxY=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-BWZL5bJEMaSL1fa_ysnj_Q-1; Tue, 11 Feb 2020 06:14:49 -0500
X-MC-Unique: BWZL5bJEMaSL1fa_ysnj_Q-1
Received: by mail-qt1-f198.google.com with SMTP id p12so6346409qtu.6
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 03:14:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=i64HviBme2Pz18uHeGw1tj3lHgv6ae4i2ihKiY1Sg+w=;
        b=il6JtQbfAZWR9mtYaaFJEQxjAx0BCMu8SLH3A5KJsk3jTuxGTvyO7puEiBInaKolnE
         4GdGuKZmbmJLbVKj5PPG46UdgGo4cxp8qm5ZAbb129d5MyHQOsdppJnuDeldcs4GtZjX
         UbPTPyXhGyUWII008REYche8v57JtXoXreFsGrylIFTrs2n0nVPyTzGtxqo6AEFzUU1W
         ln13KQhFenLm0oxNwjRiW35a8K3g6FOQ7G8jSI7b/Jp4oOBq3WtbnfeH9dQ6akJKhfAt
         PbTJKCWxkeaoc9/U19qQhxXpt+5Cma16Mtgf9lSYHg6ArdmGqvXY8c9+KDS61lG1aSdC
         jFwg==
X-Gm-Message-State: APjAAAX5UuwKfkasE71nxCirL5AG22aMADi+O7QPZRauo8oXekXnuJiF
        FArBzQ9ap6+DAhmb/HK6sDZ+9dhxIJR/5RE+J/hHWqiy0a3av8zR2JOcrf/JMuE6yFFCnUkkmYW
        lePfNaN03O7WoluGh08ljMdJ4
X-Received: by 2002:aed:3109:: with SMTP id 9mr14435456qtg.166.1581419689077;
        Tue, 11 Feb 2020 03:14:49 -0800 (PST)
X-Google-Smtp-Source: APXvYqzLxRMntZl/rmTH1PsMTVPwnKKD+vZxzh00c1RAAnvkD1CE3PAe5M25dTlN82sQ46lo8t4E8w==
X-Received: by 2002:aed:3109:: with SMTP id 9mr14435436qtg.166.1581419688863;
        Tue, 11 Feb 2020 03:14:48 -0800 (PST)
Received: from redhat.com (bzq-79-176-41-183.red.bezeqint.net. [79.176.41.183])
        by smtp.gmail.com with ESMTPSA id x41sm1996691qtj.52.2020.02.11.03.14.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 03:14:48 -0800 (PST)
Date:   Tue, 11 Feb 2020 06:14:43 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Zha Bin <zhabin@linux.alibaba.com>
Cc:     linux-kernel@vger.kernel.org, jasowang@redhat.com, slp@redhat.com,
        virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org,
        gerry@linux.alibaba.com, jing2.liu@linux.intel.com,
        chao.p.peng@linux.intel.com
Subject: Re: [PATCH v2 5/5] x86: virtio-mmio: support virtio-mmio with MSI
 for x86
Message-ID: <20200211061148-mutt-send-email-mst@kernel.org>
References: <cover.1581305609.git.zhabin@linux.alibaba.com>
 <946b71e77a34666a9b8c419c5a467d1628b50fa0.1581305609.git.zhabin@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946b71e77a34666a9b8c419c5a467d1628b50fa0.1581305609.git.zhabin@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 05:05:21PM +0800, Zha Bin wrote:
> From: Liu Jiang <gerry@linux.alibaba.com>
> 
> virtio-mmio supports a generic MSI irq domain for all archs. This
> patch adds the x86 architecture support.
> 
> Signed-off-by: Liu Jiang <gerry@linux.alibaba.com>
> Co-developed-by: Zha Bin <zhabin@linux.alibaba.com>
> Signed-off-by: Zha Bin <zhabin@linux.alibaba.com>
> Co-developed-by: Jing Liu <jing2.liu@linux.intel.com>
> Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
> Co-developed-by: Chao Peng <chao.p.peng@linux.intel.com>
> Signed-off-by: Chao Peng <chao.p.peng@linux.intel.com>
> ---
>  arch/x86/kernel/apic/msi.c | 11 ++++++++++-

Patches like this need to CC x86 maintainers.


>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
> index 159bd0c..2fcd602 100644
> --- a/arch/x86/kernel/apic/msi.c
> +++ b/arch/x86/kernel/apic/msi.c
> @@ -45,7 +45,11 @@ static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg)
>  		MSI_DATA_VECTOR(cfg->vector);
>  }
>  
> -static void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
> +/*
> + * x86 PCI-MSI/HPET/DMAR related method.
> + * Also can be used as arch specific method for virtio-mmio MSI.
> + */
> +void irq_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
>  {
>  	__irq_msi_compose_msg(irqd_cfg(data), msg);
>  }
> @@ -166,6 +170,11 @@ static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
>  	return ret;
>  }
>  
> +struct irq_domain *arch_msi_root_irq_domain(void)
> +{
> +	return x86_vector_domain;
> +}
> +
>  /*
>   * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
>   * which implement the MSI or MSI-X Capability Structure.


So there's a new non-static functions with no callers here,
and a previously static irq_msi_compose_msg is not longer
static. No callers so how does this help anyone?
And how does this achieve the goal of enabling virtio mmio?


> -- 
> 1.8.3.1

