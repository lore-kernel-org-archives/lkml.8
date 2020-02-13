Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7512C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1103206ED
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 17:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NlLALCUK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgBMRhz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:37:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35552 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728186AbgBMRhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 12:37:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581615473;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkLHneclbeHCST7fASewwtHTBnTmgy0d+6MGvsQvuck=;
        b=NlLALCUKbnCQ+y2Z1ZdEY7E1zG1jJwLPCGO4ym1aAUUpjPjptFf8meEOC6qoRWEUgKe8Ys
        qkb+6usXsw+JvNwlLCuSreQjPV3sRXwJzOP006zhlI7GvzhWR/jocohEzGolxoodKbdlSI
        75QhUBShn1M0XEZ3WTcHbMyLZjKd7D0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-327-1EeHWuRaNJymRz7915BeVA-1; Thu, 13 Feb 2020 12:37:44 -0500
X-MC-Unique: 1EeHWuRaNJymRz7915BeVA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1458801E72;
        Thu, 13 Feb 2020 17:37:42 +0000 (UTC)
Received: from ovpn-123-34.rdu2.redhat.com (ovpn-123-34.rdu2.redhat.com [10.10.123.34])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 404515C100;
        Thu, 13 Feb 2020 17:37:41 +0000 (UTC)
Message-ID: <48174ba52460d317a630df1389fbb76f5a733250.camel@redhat.com>
Subject: Re: [PATCH 03/18] c6x: replace setup_irq() by request_irq()
From:   Mark Salter <msalter@redhat.com>
To:     afzal mohammed <afzal.mohd.ma@gmail.com>,
        linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org
Cc:     Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Enrico Weigelt <info@metux.net>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Allison Randal <allison@lohutok.net>
Date:   Thu, 13 Feb 2020 12:37:40 -0500
In-Reply-To: <11cbe657937077b56bd28d277c9b9455a6985501.1581478324.git.afzal.mohd.ma@gmail.com>
References: <cover.1581478323.git.afzal.mohd.ma@gmail.com>
         <11cbe657937077b56bd28d277c9b9455a6985501.1581478324.git.afzal.mohd.ma@gmail.com>
Organization: Red Hat, Inc
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-02-12 at 13:32 +0530, afzal mohammed wrote:
> request_irq() is preferred over setup_irq(). Existing callers of
> setup_irq() reached mostly via 'init_IRQ()' & 'time_init()', while
> memory allocators are ready by 'mm_init()'.
> 
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
> 
> Hence replace setup_irq() by request_irq().
> 
> Seldom remove_irq() usage has been observed coupled with setup_irq(),
> wherever that has been found, it too has been replaced by free_irq().
> 
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
> 
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> 
> Since cc'ing cover letter to all maintainers/reviewers would be too
> many, refer for cover letter,
>  https://lkml.kernel.org/r/cover.1581478323.git.afzal.mohd.ma@gmail.com
> 
>  arch/c6x/platforms/timer64.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/c6x/platforms/timer64.c b/arch/c6x/platforms/timer64.c
> index d98d94303498..ceee34c51d4b 100644
> --- a/arch/c6x/platforms/timer64.c
> +++ b/arch/c6x/platforms/timer64.c
> @@ -165,13 +165,6 @@ static irqreturn_t timer_interrupt(int irq, void *dev_id)
>  	return IRQ_HANDLED;
>  }
>  
> -static struct irqaction timer_iact = {
> -	.name		= "timer",
> -	.flags		= IRQF_TIMER,
> -	.handler	= timer_interrupt,
> -	.dev_id		= &t64_clockevent_device,
> -};
> -
>  void __init timer64_init(void)
>  {
>  	struct clock_event_device *cd = &t64_clockevent_device;
> @@ -238,7 +231,9 @@ void __init timer64_init(void)
>  	cd->cpumask		= cpumask_of(smp_processor_id());
>  
>  	clockevents_register_device(cd);
> -	setup_irq(cd->irq, &timer_iact);
> +	if (request_irq(cd->irq, timer_interrupt, IRQF_TIMER, "timer",
> +			&t64_clockevent_device))
> +		pr_err("request_irq() on %s failed\n", "timer");
>  
>  out:
>  	of_node_put(np);

Acked-by: Mark Salter <msalter@redhat.com>


