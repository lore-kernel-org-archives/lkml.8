Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5BAC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1362320774
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWyq109a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbgCXPtl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:49:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:40486 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728555AbgCXPtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:49:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585064979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gDeYcAUSbBq7ywkS5vACQpnT9b7hAluwSzLUAQ2Mkuo=;
        b=UWyq109aARiETWzOJF2nSEcrF78b/fpxAMDOEblWVBaKVZRkAvuh9FgICyU5P3OL/PIKGY
        d2aZaLMp4lkQ5L64NdKbuj0fWXA6ZBciuJaAV+xpFr2fcWLCSghBhfH7GDI19QyqB3ykfW
        1mu6ajt+nzYY4jbimbsOy67zr+Yg5gg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-105-4OmS1QYJMHWRFLqq5-9pww-1; Tue, 24 Mar 2020 11:49:35 -0400
X-MC-Unique: 4OmS1QYJMHWRFLqq5-9pww-1
Received: by mail-wr1-f71.google.com with SMTP id v14so832991wrq.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Mar 2020 08:49:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=gDeYcAUSbBq7ywkS5vACQpnT9b7hAluwSzLUAQ2Mkuo=;
        b=G7WvxHCugCULHpN+LIlmvx83GsQe78BnHSkX3FRgOqv4AGGMx9AT6Acef6rdjJD6lu
         gFD5jwc8cjhRkWjIX2vbaEbNPgxqGR/4+azuuDp1OydL88+722ZOnIcaL0IalUbGVDVl
         4KiYpouFTtblX8TM7JW33HX77OgBrDmAKCZLRz6+s/eBYwISQbhp154Ugmz+oYBjchCQ
         9p00o4SLYsY0VPjfgQuCZ/PMgMAuzmBe6souzPcw8kao/07jBUD/C+VIN/pimMVUaVTo
         6lNh8IdyBMXnHJtiqRaT0j64vPSZYyf7mko4Pe6KyvqESw2Rn2E3YnK78x6U4nadsOeU
         trnA==
X-Gm-Message-State: ANhLgQ0dauKL8cmQ78KKa65t0YAZcKdO6/0xnf2lwo5M1ZyHLeEqAPcK
        PL/1AIz28M/IEruE2c0cA4Arrv+pmd7m7hoMpSmyJkFj4IbP6k6B4LzBBmFs410URTTjrvyK9tS
        yNxlQP+7THGu+QYAxdXssPH8t
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr21284978wrn.253.1585064974714;
        Tue, 24 Mar 2020 08:49:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvieeuVU2W0zTxEOUqjpUVow4Ua37PmuvDaQdo6jPYZN+iJoR9w2Z7lCsv/HlVC3WP9EqY7jg==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr21284953wrn.253.1585064974406;
        Tue, 24 Mar 2020 08:49:34 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y7sm6862882wrq.54.2020.03.24.08.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 08:49:33 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Yubo Xie <ltykernel@gmail.com>
Cc:     Yubo Xie <yuboxie@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        michael.h.kelley@microsoft.com
Subject: Re: [PATCH] x86/Hyper-V: Fix hv sched clock function return wrong time unit
In-Reply-To: <20200324151935.15814-1-yuboxie@microsoft.com>
References: <20200324151935.15814-1-yuboxie@microsoft.com>
Date:   Tue, 24 Mar 2020 16:49:32 +0100
Message-ID: <87ftdx7nxv.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yubo Xie <ltykernel@gmail.com> writes:

> sched clock callback should return time with nano second as unit
> but current hv callback returns time with 100ns. Fix it.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Yubo Xie <yuboxie@microsoft.com>
> Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Fixes: adb87ff4f96c ("clocksource/drivers/hyperv: Allocate Hyper-V TSC page statically")

I don't think this is the right commit to reference, 

commit bd00cd52d5be655a2f217e2ed74b91a71cb2b14f
Author: Tianyu Lan <Tianyu.Lan@microsoft.com>
Date:   Wed Aug 14 20:32:16 2019 +0800

    clocksource/drivers/hyperv: Add Hyper-V specific sched clock function

looks like the one.

> ---
>  drivers/clocksource/hyperv_timer.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index 9d808d595ca8..662ed978fa24 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -343,7 +343,8 @@ static u64 notrace read_hv_clock_tsc_cs(struct clocksource *arg)
>  
>  static u64 read_hv_sched_clock_tsc(void)
>  {
> -	return read_hv_clock_tsc() - hv_sched_clock_offset;
> +	return (read_hv_clock_tsc() - hv_sched_clock_offset)
> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>  }
>  
>  static void suspend_hv_clock_tsc(struct clocksource *arg)
> @@ -398,7 +399,8 @@ static u64 notrace read_hv_clock_msr_cs(struct clocksource *arg)
>  
>  static u64 read_hv_sched_clock_msr(void)
>  {
> -	return read_hv_clock_msr() - hv_sched_clock_offset;
> +	return (read_hv_clock_msr() - hv_sched_clock_offset)
> +		* (NSEC_PER_SEC / HV_CLOCK_HZ);
>  }

kvmclock seems to have the same (pre-patch) code ...

>  
>  static struct clocksource hyperv_cs_msr = {

-- 
Vitaly

