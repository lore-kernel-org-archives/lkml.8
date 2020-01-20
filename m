Return-Path: <SRS0=vnT4=3J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F41C33CA1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:08:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC85B2077C
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jan 2020 08:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579507738;
	bh=YDEovj2cYhnf/FKg78G2sdgiBvpBIIy7DcSgA489aJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=LflBJRJ5VTOH6gYfM2xTf0iTjPPTOXs79cg49JkDyYTDsFwfpajVgBQW/Fuy/fJX5
	 D+iISJab3IaMnJmw8r5vBFSGiB5Nx3DobKmjib/m2ywKoGZp/lXnycJelnV6l32TBw
	 kInOKUwvuWoINlR4d0QqoPRZegkgktXKuMDPpiFA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726626AbgATII6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jan 2020 03:08:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:52708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726421AbgATII5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jan 2020 03:08:57 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C492720684;
        Mon, 20 Jan 2020 08:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579507736;
        bh=YDEovj2cYhnf/FKg78G2sdgiBvpBIIy7DcSgA489aJ8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ko9cei3ZkD4EgsgvmkeI3g06C+BOeL5X/5LOAykUd4Q04Y6f46P/QxseZSo1k81aC
         kKiW+obogUPlWPMbi58LapZ7sJQCHG6isr8Nh7nxxO1j9uPu398CtV4Z9Dulhcgmc3
         l9ur72HQYijEQK9rFVM0H1eEzdk1vxklU2nd5Byg=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1itS7D-000CoA-1l; Mon, 20 Jan 2020 08:08:55 +0000
Date:   Mon, 20 Jan 2020 08:08:53 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Kevin Hao <haokexin@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH] irqdomain: Fix a memory leak in irq_domain_push_irq()
Message-ID: <20200120080853.31f23c98@why>
In-Reply-To: <20200120043547.22271-1-haokexin@gmail.com>
References: <20200120043547.22271-1-haokexin@gmail.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: haokexin@gmail.com, linux-kernel@vger.kernel.org, tglx@linutronix.de, david.daney@cavium.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Jan 2020 12:35:47 +0800
Kevin Hao <haokexin@gmail.com> wrote:

> Fix a memory leak reported by kmemleak:
> unreferenced object 0xffff000bc6f50e80 (size 128):
>   comm "kworker/23:2", pid 201, jiffies 4294894947 (age 942.132s)
>   hex dump (first 32 bytes):
>     00 00 00 00 41 00 00 00 86 c0 03 00 00 00 00 00  ....A...........
>     00 a0 b2 c6 0b 00 ff ff 40 51 fd 10 00 80 ff ff  ........@Q......
>   backtrace:
>     [<00000000e62d2240>] kmem_cache_alloc_trace+0x1a4/0x320
>     [<00000000279143c9>] irq_domain_push_irq+0x7c/0x188
>     [<00000000d9f4c154>] thunderx_gpio_probe+0x3ac/0x438
>     [<00000000fd09ec22>] pci_device_probe+0xe4/0x198
>     [<00000000d43eca75>] really_probe+0xdc/0x320
>     [<00000000d3ebab09>] driver_probe_device+0x5c/0xf0
>     [<000000005b3ecaa0>] __device_attach_driver+0x88/0xc0
>     [<000000004e5915f5>] bus_for_each_drv+0x7c/0xc8
>     [<0000000079d4db41>] __device_attach+0xe4/0x140
>     [<00000000883bbda9>] device_initial_probe+0x18/0x20
>     [<000000003be59ef6>] bus_probe_device+0x98/0xa0
>     [<0000000039b03d3f>] deferred_probe_work_func+0x74/0xa8
>     [<00000000870934ce>] process_one_work+0x1c8/0x470
>     [<00000000e3cce570>] worker_thread+0x1f8/0x428
>     [<000000005d64975e>] kthread+0xfc/0x128
>     [<00000000f0eaa764>] ret_from_fork+0x10/0x18
> 
> Fixes: 495c38d3001f ("irqdomain: Add irq_domain_{push,pop}_irq() functions")
> Cc: stable@vger.kernel.org
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  kernel/irq/irqdomain.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
> index dd822fd8a7d5..480df3659720 100644
> --- a/kernel/irq/irqdomain.c
> +++ b/kernel/irq/irqdomain.c
> @@ -1459,6 +1459,7 @@ int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg)
>  	if (rv) {
>  		/* Restore the original irq_data. */
>  		*root_irq_data = *child_irq_data;
> +		kfree(child_irq_data);
>  		goto error;
>  	}
>  

Nice catch. I'll queue this for 5.6.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
