Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAAC4C2D0EC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:09:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81ACB2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AEsPeebD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbgC3PJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:09:12 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40138 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726114AbgC3PJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585580950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+kYWet4bixbZbPNRdWuq5DEiauOXhGbRO6V2Oqjfd2E=;
        b=AEsPeebDzZaXGbX6KOmegelNtl3ZCANUg9FoUJDsBSKPN0Gl3/kN2E6FGdkaqVPiPQeife
        rHfYwtOK9xd9qE8UiuJTcnyvGFMXNd0E787N74ZA2ksdtv88lswBqZRS4D5DrskH2xlzAa
        NYqjUn7sABZUt2mLbNUpim16y+kszB0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-siq7RG0lM86jkZ9ApFcDlA-1; Mon, 30 Mar 2020 11:09:09 -0400
X-MC-Unique: siq7RG0lM86jkZ9ApFcDlA-1
Received: by mail-wm1-f70.google.com with SMTP id f8so8886264wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 08:09:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=+kYWet4bixbZbPNRdWuq5DEiauOXhGbRO6V2Oqjfd2E=;
        b=rNMoGdXrYswkgqYdzho6R+sn6B410agLUm+sbkx18cV1tAthOD0SLGhbrHgDJfJ5Yj
         U+hL1nBCjn5xnSudQanymakhB0ui45ysW7bSyXIXt/CrBZDBEbVIhptxAi/ZoOOnYO7z
         Bw2ZwvHQYXbDaKW23r36IsbvIlbSxViZKVDBScB5qZiP0PC51FRIUFgAaSTyele2Ffsb
         xf0WjW5/FrBCbWIXkwLslq3YqLQpiC0rzPuMHdCE78NVVhxyDuTKrSI66jnVLV7D1yEh
         zqd0T6ln2ezjLqNTfD0XiVKv/IswoBAvH6tMA7rfLxT/sJRYVqFzwf/sHx8PFJx7jbb8
         HXJg==
X-Gm-Message-State: ANhLgQ2DEY9sesWiau3caG3SLkFIqVaTDojpLjZy0vGtw6eKuB/q+Pa6
        9Nm1W8rGDPI9fz65yyihOzS7XS+1DYMYvQssqAYnqSOBfQzasF8yk1r+QBta13pmRDVkWIx+Q+T
        IbJCAmicYJ7E9xc9krYGivYHh
X-Received: by 2002:a5d:6a82:: with SMTP id s2mr15825821wru.205.1585580944003;
        Mon, 30 Mar 2020 08:09:04 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuK8fcHl6Eny3iPtQKj+itNFU3owKwmKMTZmJFabvEZvt/zBN1Zam2KGqhvau5vjZNoeoFTjg==
X-Received: by 2002:a5d:6a82:: with SMTP id s2mr15825786wru.205.1585580943712;
        Mon, 30 Mar 2020 08:09:03 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id o145sm10142606wme.42.2020.03.30.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 08:09:03 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     ltykernel@gmail.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        devel@linuxdriverproject.org, linux-kernel@vger.kernel.org,
        kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        x86@kernel.org, michael.h.kelley@microsoft.com, wei.liu@kernel.org
Subject: Re: [Update PATCH] x86/Hyper-V: Initialize Syn timer clock when it's
In-Reply-To: <20200330141708.12822-1-Tianyu.Lan@microsoft.com>
References: <20200330141708.12822-1-Tianyu.Lan@microsoft.com>
Date:   Mon, 30 Mar 2020 17:09:00 +0200
Message-ID: <87d08t3mnn.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ltykernel@gmail.com writes:

> From: Tianyu Lan <Tianyu.Lan@microsoft.com>
>
> Current code initializes clock event data structure for syn timer
> even when it's not available. Fix it.
>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> ---
> - Fix the wrong title.

The new one is ... weird too :-)

I think it was supposed to be something like "x86/Hyper-V: don't
allocate clockevent device when synthetic timer is unavailable"

>  
>  drivers/hv/hv.c | 15 +++++++++------

Which tree is this patch for? Upstream clockevent allocation has moved
to drivers/clocksource/hyperv_timer.c 

>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
> index 632d25674e7f..2e893768fc76 100644
> --- a/drivers/hv/hv.c
> +++ b/drivers/hv/hv.c
> @@ -212,13 +212,16 @@ int hv_synic_alloc(void)
>  		tasklet_init(&hv_cpu->msg_dpc,
>  			     vmbus_on_msg_dpc, (unsigned long) hv_cpu);
>  
> -		hv_cpu->clk_evt = kzalloc(sizeof(struct clock_event_device),
> -					  GFP_KERNEL);
> -		if (hv_cpu->clk_evt == NULL) {
> -			pr_err("Unable to allocate clock event device\n");
> -			goto err;
> +		if (ms_hyperv.features & HV_MSR_SYNTIMER_AVAILABLE) {
> +			hv_cpu->clk_evt =
> +				kzalloc(sizeof(struct clock_event_device),
> +						  GFP_KERNEL);
> +			if (hv_cpu->clk_evt == NULL) {
> +				pr_err("Unable to allocate clock event device\n");
> +				goto err;
> +			}
> +			hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>  		}
> -		hv_init_clockevent_device(hv_cpu->clk_evt, cpu);
>  
>  		hv_cpu->synic_message_page =
>  			(void *)get_zeroed_page(GFP_ATOMIC);

-- 
Vitaly

