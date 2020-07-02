Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4ED4BC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:57:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2648D207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 15:57:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU0sYnZJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726345AbgGBP5r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 11:57:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55422 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725379AbgGBP5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 11:57:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593705466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7RoOoUA+53noAjeT5ayY4WzjGBDITrX8MYmPSLFhr0w=;
        b=LU0sYnZJFzoMFEVy3QF0xpnMkhAIqWw9CKpXZ51eDkkPL0pzj4hBCIehml3sI1HroYsSRR
        xzUqDpd47gmrd2/1udS1Hzk5gEMrxYOj2kfx/ZA8n6Z2rC7tuxrpzhDOtL1rf8uEejU9AA
        NUr6SbT7TGqKw87jdD0ymyQHcJyfQac=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-bzrv5tg6MtmDsl6nWfQSOQ-1; Thu, 02 Jul 2020 11:57:44 -0400
X-MC-Unique: bzrv5tg6MtmDsl6nWfQSOQ-1
Received: by mail-wr1-f72.google.com with SMTP id a18so26662912wrm.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 08:57:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7RoOoUA+53noAjeT5ayY4WzjGBDITrX8MYmPSLFhr0w=;
        b=Jwrq9UhQLm1M1FTfFjC0f5r4rQ/hrFw89UAOrG19ARXv4PMqY3bN4y97xkJRAI8H4h
         Ub1bSiU7dkWc40h0Vf93OmCDP3AoUWtZrhIeKzFBXfE5MZfnjd6faFAX2W1RJe8F5LLH
         CYooo10QmNBxOIkkt/j5KxrbJ23/BDvufpzZO9gs3IpOD4y5JJrnUGUsc6th+ZPmAlsn
         Bvw8XZyo876J6a1Sd6LJW85nyLOUp6RnsXZGyz8qdewdzTV6FxP8YjCJ6uIDy0HaO8kL
         KbqRAvRVtbjbVLxGMoXcIqRBbT15X0Q2JwUKRNC1pCRMh/X458tPUTqB00XRjSmsqWuf
         uZ1A==
X-Gm-Message-State: AOAM533RfAb/NBQDD5fDPZfvgY7ULcILc8VjwaczQW4OQRrS8VSDAj3/
        9IruDhFHEDsuJocW6zPGeVTjN4vgnGkaO/Y33JuGCZRWh1LIlgLo3wtT8+577RHleq4yVGki7Wr
        DMUEk7LyA9b/XG1vXxT0659LB
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr30971117wrm.379.1593705463189;
        Thu, 02 Jul 2020 08:57:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJymuXk4zbb+5PvJapCFNs7YDJH7liNU74wmElJrm3xRjCtTggVxpPiqmsNDsbHPEb803dg+HQ==
X-Received: by 2002:adf:e3c9:: with SMTP id k9mr30971081wrm.379.1593705462930;
        Thu, 02 Jul 2020 08:57:42 -0700 (PDT)
Received: from localhost.localdomain ([151.29.8.241])
        by smtp.gmail.com with ESMTPSA id 104sm11745747wrl.25.2020.07.02.08.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 08:57:42 -0700 (PDT)
Date:   Thu, 2 Jul 2020 17:57:40 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 01/10] timer: Prevent base->clk from moving backward
Message-ID: <20200702155740.GJ9670@localhost.localdomain>
References: <20200701011030.14324-1-frederic@kernel.org>
 <20200701011030.14324-2-frederic@kernel.org>
 <20200701163504.GD9670@localhost.localdomain>
 <20200701232045.GA17670@lenoir>
 <20200702095959.GG9670@localhost.localdomain>
 <20200702143206.GC27417@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702143206.GC27417@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/20 16:32, Frederic Weisbecker wrote:
> On Thu, Jul 02, 2020 at 11:59:59AM +0200, Juri Lelli wrote:
> > On 02/07/20 01:20, Frederic Weisbecker wrote:
> > > On Wed, Jul 01, 2020 at 06:35:04PM +0200, Juri Lelli wrote:
> > > > Guess you might be faster to understand what I'm missing. :-)
> > > 
> > > So, did you port only this patch or the whole set in order to
> > > trigger this?
> > > 
> > > If it was the whole set, can you try this patch alone?
> > 
> > Whole set. And I can't reproduce if I try with this patch alone.
> > 
> 
> Missing initialization. This should go better after this:
> 
> diff --git a/kernel/time/timer.c b/kernel/time/timer.c
> index 25a55c043297..f36b53219768 100644
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -1969,6 +1969,7 @@ static void __init init_timer_cpu(int cpu)
>  		base->cpu = cpu;
>  		raw_spin_lock_init(&base->lock);
>  		base->clk = jiffies;
> +		base->next_expiry = base->clk + NEXT_TIMER_MAX_DELTA;
>  		timer_base_init_expiry_lock(base);
>  	}
>  }
> 

Yep. Looks like warning is gone.

