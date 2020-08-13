Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F163C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1794A2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 08:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iz3onmWG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKvj7mWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726673AbgHMI14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 04:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgHMI1z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 04:27:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C939C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 01:27:55 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597307273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fT7X9ZhAR4IRK5EDGx6IbEbzY/WmsbTkSLcWHW9/fnY=;
        b=Iz3onmWGJ4OjBGECNnPH+/xegNFy5yaOVy7FzXyjfn0B4QyTf28Qu+aMdNSYCUFIdQt+Rv
        W5FwzBnJEBUp098sqqJrz4p49h52Ka08gNzZXc5vDjcGDM97Zpy38IDSQG0kYUOl/G7Qyx
        whRF1xCiLz7jq7ZTIkK6wfuGzpAzs6B8ODbM7nwaiLlmfb3gREpgtcwHKRSURWc7rWc7oB
        e/a7nR6HPfbl5AQC+MRwcdBERa3gv8cPXOceCGlZAoK5JpfgzALvlxVJWamSdrhc3ZCSm6
        3xW/xZgZvtR6Irq3IunOCJf/fG7p2t6VgI166sdt/YlOQftqbP01pdIsHa2nyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597307273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fT7X9ZhAR4IRK5EDGx6IbEbzY/WmsbTkSLcWHW9/fnY=;
        b=uKvj7mWQrokhVZ6JFY8zJ6gQqtJK2m7N0xymYBiYPAwByePPM0GktnURa+KuIWiaVFQGuW
        1BadGoYErg1xJmDQ==
To:     Yunfeng Ye <yeyunfeng@huawei.com>
Cc:     linux-kernel@vger.kernel.org, Shiyuan Hu <hushiyuan@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>
Subject: Re: [PATCH] genirq/proc: Show percpu irq affinity
In-Reply-To: <fcb0ae13-95b0-37d3-c1f9-44727e0f2ce8@huawei.com>
References: <fcb0ae13-95b0-37d3-c1f9-44727e0f2ce8@huawei.com>
Date:   Thu, 13 Aug 2020 10:27:53 +0200
Message-ID: <874kp754s6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yunfeng Ye <yeyunfeng@huawei.com> writes:

> When the "affinity=" cmdline parameter is configured,

There is no such parameter.

> the interrupt affinity displayed in the proc directory does not match
> with that of the the percu interrupt, and the percu interrupt uses
> desc->percu_affinity.

And when the non-existing parameter is not on the command line then
irq->affinity is showing the correct value magically?

Definitely not: It's unconditionally showing irq->affinity and that is
pretty unlikely to match irq->percpu_affinity in any case.

> diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
> index 32c071d7bc03..b9d0fa87b4b4 100644
> --- a/kernel/irq/proc.c
> +++ b/kernel/irq/proc.c
> @@ -52,6 +52,8 @@ static int show_irq_affinity(int type, struct seq_file *m)
>  	case AFFINITY:
>  	case AFFINITY_LIST:
>  		mask = desc->irq_common_data.affinity;
> +		if (irqd_is_per_cpu(&desc->irq_data))
> +			mask = desc->percpu_affinity;

This breaks all architecture which mark interrupts as per CPU without
using the partition mechanism resulting in a NULL pointer dereference.

Thanks,

        tglx
