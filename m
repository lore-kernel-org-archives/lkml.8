Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C669DC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DBF82467E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 11:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YpyeOcCL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgAWLcx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 06:32:53 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33685 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726194AbgAWLcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 06:32:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579779172;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8xpwabDUT9AeCxzSh2+fjHnI/NjiznPGltneNwagA8c=;
        b=YpyeOcCLgQEYVQRu+CfLwVnrNn17lMc1hO94cyqHJpvDOEEwZXbuA7WJXtSIENlt9ruleg
        f08w+ONWEbSYNh2uKvMuJPm6wgF5pqPqUPER3dwgdMX3Leez85NYYIVHYdt8JeyM6QffoA
        D5ANB05zRjK9n0RgB2ZpNG2wShExXvQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-haE8SUtYPP-2_FzzaeuIpA-1; Thu, 23 Jan 2020 06:32:48 -0500
X-MC-Unique: haE8SUtYPP-2_FzzaeuIpA-1
Received: by mail-wm1-f69.google.com with SMTP id g26so462529wmk.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jan 2020 03:32:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=8xpwabDUT9AeCxzSh2+fjHnI/NjiznPGltneNwagA8c=;
        b=lpP4jWpGdXrlFx/GOaz2MF9rvfw79+nmyVh2mJOrOaU9ZXTlFvUswseMMPgUV/G41L
         Nb+8Cc6whreH0K1qNpa3an7zamHNg1USNaXlhUY/PlfO5ZgYKGo+i52LEWMe++08S28p
         TUYBMfAXoI4lxnl5EvTEhQhq6jqSsKC5QHmd9X3lJ1oox1pg7QmHlrQzMkri10Hf0EJP
         MkuJDeuic+9Dos/KVmFbQtCvGaohIdJe7Huha9dv8WBcr8sjH3ZgrYXm87X9+ROkMQZ1
         tmc+U6jtepbi8yZOIrCLeEcHvaLDaCOZbuLwK96IjhrJtWiepWgtPkrujVlHhUxz3RzG
         ijWg==
X-Gm-Message-State: APjAAAXbCXdSnNdxSYIq2Ymlneg4Q3uA5seSXodZ4dG814J+sxw6rjZB
        32azDddSjpRrYnhxBLBeVgHLubpFUdzSR4kX4rjuk/9dZ2kbIbTEJq+b0lCQQfFlUVuiISONuHI
        XghGgFPuxrduDdd41IDR6KkiT
X-Received: by 2002:adf:fa50:: with SMTP id y16mr16312016wrr.183.1579779167459;
        Thu, 23 Jan 2020 03:32:47 -0800 (PST)
X-Google-Smtp-Source: APXvYqwjx4XjBbNEv6xdmfv7CxRtTLPUvw+HlKG7WH2EnglXtX4rCtufRGwWlTXAZQdTM6mGq1DQjA==
X-Received: by 2002:adf:fa50:: with SMTP id y16mr16311990wrr.183.1579779167185;
        Thu, 23 Jan 2020 03:32:47 -0800 (PST)
Received: from vitty.brq.redhat.com (cst-prg-91-164.cust.vodafone.cz. [46.135.91.164])
        by smtp.gmail.com with ESMTPSA id o16sm2627249wmc.18.2020.01.23.03.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 03:32:46 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     mtosatti@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: x86: reorganize pvclock_gtod_data members
In-Reply-To: <1579702953-24184-2-git-send-email-pbonzini@redhat.com>
References: <1579702953-24184-1-git-send-email-pbonzini@redhat.com> <1579702953-24184-2-git-send-email-pbonzini@redhat.com>
Date:   Thu, 23 Jan 2020 12:32:44 +0100
Message-ID: <87tv4mqug3.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> We will need a copy of tk->offs_boot in the next patch.  Store it and
> cleanup the struct: instead of storing tk->tkr_xxx.base with the tk->offs_boot
> included, store the raw value in struct pvclock_clock and sum tk->offs_boot
> in do_monotonic_raw and do_realtime.   tk->tkr_xxx.xtime_nsec also moves
> to struct pvclock_clock.
>
> While at it, fix a (usually harmless) typo in do_monotonic_raw, which
> was using gtod->clock.shift instead of gtod->raw_clock.shift.
>
> Fixes: 53fafdbb8b21f ("KVM: x86: switch KVMCLOCK base to monotonic raw clock")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/kvm/x86.c | 29 ++++++++++++-----------------
>  1 file changed, 12 insertions(+), 17 deletions(-)
>
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 89621025577a..1b4273cce63c 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -1532,6 +1532,8 @@ struct pvclock_clock {
>  	u64 mask;
>  	u32 mult;
>  	u32 shift;
> +	u64 base_cycles;
> +	u64 offset;
>  };
>  
>  struct pvclock_gtod_data {
> @@ -1540,11 +1542,8 @@ struct pvclock_gtod_data {
>  	struct pvclock_clock clock; /* extract of a clocksource struct */
>  	struct pvclock_clock raw_clock; /* extract of a clocksource struct */
>  
> -	u64		boot_ns_raw;
> -	u64		boot_ns;
> -	u64		nsec_base;
> +	ktime_t		offs_boot;
>  	u64		wall_time_sec;
> -	u64		monotonic_raw_nsec;
>  };
>  
>  static struct pvclock_gtod_data pvclock_gtod_data;
> @@ -1552,10 +1551,6 @@ struct pvclock_gtod_data {
>  static void update_pvclock_gtod(struct timekeeper *tk)
>  {
>  	struct pvclock_gtod_data *vdata = &pvclock_gtod_data;
> -	u64 boot_ns, boot_ns_raw;
> -
> -	boot_ns = ktime_to_ns(ktime_add(tk->tkr_mono.base, tk->offs_boot));
> -	boot_ns_raw = ktime_to_ns(ktime_add(tk->tkr_raw.base, tk->offs_boot));
>  
>  	write_seqcount_begin(&vdata->seq);
>  
> @@ -1565,20 +1560,20 @@ static void update_pvclock_gtod(struct timekeeper *tk)
>  	vdata->clock.mask		= tk->tkr_mono.mask;
>  	vdata->clock.mult		= tk->tkr_mono.mult;
>  	vdata->clock.shift		= tk->tkr_mono.shift;
> +	vdata->clock.base_cycles	= tk->tkr_mono.xtime_nsec;
> +	vdata->clock.offset		= tk->tkr_mono.base;
>  
>  	vdata->raw_clock.vclock_mode	= tk->tkr_raw.clock->archdata.vclock_mode;
>  	vdata->raw_clock.cycle_last	= tk->tkr_raw.cycle_last;
>  	vdata->raw_clock.mask		= tk->tkr_raw.mask;
>  	vdata->raw_clock.mult		= tk->tkr_raw.mult;
>  	vdata->raw_clock.shift		= tk->tkr_raw.shift;
> -
> -	vdata->boot_ns			= boot_ns;
> -	vdata->nsec_base		= tk->tkr_mono.xtime_nsec;
> +	vdata->raw_clock.base_cycles	= tk->tkr_raw.xtime_nsec;
> +	vdata->raw_clock.offset		= tk->tkr_raw.base;

Likely a personal preference but the suggested naming is a bit
confusing: we use 'base_cycles' to keep 'xtime_nsec' and 'offset' to
keep ... 'base'. Not that I think that 'struct timekeeper' is perfect
but at least it is documented. Should we maybe just stick to it (and
name 'struct pvclock_clock' fields accordingly?)

>  
>  	vdata->wall_time_sec            = tk->xtime_sec;
>  
> -	vdata->boot_ns_raw		= boot_ns_raw;
> -	vdata->monotonic_raw_nsec	= tk->tkr_raw.xtime_nsec;
> +	vdata->offs_boot		= tk->offs_boot;
>  
>  	write_seqcount_end(&vdata->seq);
>  }
> @@ -2048,10 +2043,10 @@ static int do_monotonic_raw(s64 *t, u64 *tsc_timestamp)
>  
>  	do {
>  		seq = read_seqcount_begin(&gtod->seq);
> -		ns = gtod->monotonic_raw_nsec;
> +		ns = gtod->raw_clock.base_cycles;
>  		ns += vgettsc(&gtod->raw_clock, tsc_timestamp, &mode);
> -		ns >>= gtod->clock.shift;
> -		ns += gtod->boot_ns_raw;
> +		ns >>= gtod->raw_clock.shift;
> +		ns += ktime_to_ns(ktime_add(gtod->raw_clock.offset, gtod->offs_boot));
>  	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));
>  	*t = ns;
>  
> @@ -2068,7 +2063,7 @@ static int do_realtime(struct timespec64 *ts, u64 *tsc_timestamp)
>  	do {
>  		seq = read_seqcount_begin(&gtod->seq);
>  		ts->tv_sec = gtod->wall_time_sec;
> -		ns = gtod->nsec_base;
> +		ns = gtod->clock.base_cycles;
>  		ns += vgettsc(&gtod->clock, tsc_timestamp, &mode);
>  		ns >>= gtod->clock.shift;
>  	} while (unlikely(read_seqcount_retry(&gtod->seq, seq)));

FWIW,

Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>

-- 
Vitaly

