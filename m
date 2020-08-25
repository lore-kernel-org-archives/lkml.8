Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467C9C433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:23:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4F62068F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598351010;
	bh=WU+mGmScM+KTchWYV1WrFBKWAUkI2r33YjP7QBPUq8M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=FQJDxtuc+/roCIMbHaKu2Oo6DJZazefBWaefskVikf9aRZGbglBzSPr3Z4btEM/v3
	 BWwK8017ynYDA5Iyh+vwSL9iSKlzKx9ku4yTwmqQBTbQQVuKGaQbbQZBlgk/mzuqv7
	 MGJRpvYGe/Ue9YFycImdnPHt7LWCwCTOrsPN1rPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729852AbgHYKX2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:23:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:38286 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgHYKX1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:23:27 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 032C32068F;
        Tue, 25 Aug 2020 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598351007;
        bh=WU+mGmScM+KTchWYV1WrFBKWAUkI2r33YjP7QBPUq8M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rgn2lR8OxDaT/IYv5es2b+fvo1X5jHqA3g/Va87OW/sNoujlpEUpaKhpuSMsSrgpK
         8yBQz7r6PYRyU/q0uyfix7+/n2/ZsQ/wwSCpE3QBTO+YGEgFyllJBBBeAdI3i2KI9f
         n0r8PdrXwszXXu/BoB+kJDW6WdW1JDuOloi6y0UY=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kAW6v-006VGJ-4W; Tue, 25 Aug 2020 11:23:25 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 25 Aug 2020 11:23:25 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Raphael Norwitz <raphael.norwitz@nutanix.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        raphael.s.norwitz@gmail.com, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] Fix typo in irq_domain documentation
In-Reply-To: <1597873980-204052-1-git-send-email-raphael.norwitz@nutanix.com>
References: <1597873980-204052-1-git-send-email-raphael.norwitz@nutanix.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <d81c567970db5aefcc59d6f967c82f17@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: raphael.norwitz@nutanix.com, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, raphael.s.norwitz@gmail.com, corbet@lwn.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-19 22:53, Raphael Norwitz wrote:
> The irq_domain documentation states that "Here the interrupt number
> loose all kind of correspondence to hardware interrupt numbers:...".
> It's clear from the context that the author means to use "loses" 
> instead
> of "loose". To avoid future confusion, this change fixes the
> aforementioned wording.
> 
> Signed-off-by: Raphael Norwitz <raphael.norwitz@nutanix.com>
> ---
>  Documentation/core-api/irq/irq-domain.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/irq/irq-domain.rst
> b/Documentation/core-api/irq/irq-domain.rst
> index 096db12..eba5e41 100644
> --- a/Documentation/core-api/irq/irq-domain.rst
> +++ b/Documentation/core-api/irq/irq-domain.rst
> @@ -15,7 +15,7 @@ such as GPIO controllers avoid reimplementing
> identical callback
>  mechanisms as the IRQ core system by modelling their interrupt
>  handlers as irqchips, i.e. in effect cascading interrupt controllers.
> 
> -Here the interrupt number loose all kind of correspondence to
> +Here the interrupt number loses all kind of correspondence to
>  hardware interrupt numbers: whereas in the past, IRQ numbers could
>  be chosen so they matched the hardware IRQ line into the root
>  interrupt controller (i.e. the component actually fireing the

Acked-by: Marc Zyngier <maz@kernel.org>

         M.
-- 
Jazz is not dead. It just smells funny...
