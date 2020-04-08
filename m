Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCFEC2BA1B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB5EE206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AVoQ5g/u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgDHPyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:54:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20623 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729632AbgDHPyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:54:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586361283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0jL6OKsl/vevfcCXL5hEg1wpfnw6jRaU0IgVB/aka5A=;
        b=AVoQ5g/ueJVlFkBs5fPBxag2RIvz9SMLV0y9rh+Pl6vtR6FGYnr85IPnnYmD/3cJXvCwzr
        UQWp2kDRzoGnTkc/ZxxG7GgwBbdqhFIT7jhgcflMw0WSrffrvZSYaPaDZHcD6kkhnB0mPf
        3p/37/Q5Sa6csJ+OQ0VnshPCYOhejzk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-99-x531gaW5NPeoWRiWgTB1xg-1; Wed, 08 Apr 2020 11:54:39 -0400
X-MC-Unique: x531gaW5NPeoWRiWgTB1xg-1
Received: by mail-wr1-f69.google.com with SMTP id q9so4404211wrw.22
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=0jL6OKsl/vevfcCXL5hEg1wpfnw6jRaU0IgVB/aka5A=;
        b=Ifv5bxRn3JU5ljPt3aJ3AFkEk8DfMyTB/qZ1nli68QrrYtcBES7LXD60CAoOA749pe
         2/Z0Arpy8ar4CEijjq0rQea+zoAPb9poAurof0k08w3BsfyMNBNaZHDNQDZoZnboUuG9
         IcASDeB6zgEmFIL9D7S/MyVZEsd8iK+tHMDgqalKKo2ZqOu3jsUyinHLBNwXXPoO7nnx
         No1ZwZvsFHzzFbxXrVOJ1TmuiOMatukWFlHD4ntAmea/Qdu7tmA0jH3crrQtjWcwiJWa
         qIX2olsk1u3sz+fTXYmUUb3+WgXC7vNU9U0kHKlQLls86paz7f4s0C9q7ilYmSNaEbbo
         OqQw==
X-Gm-Message-State: AGi0PuaTqNsXLfX/wCZ/I+Cc/TBGJArEC2ttHu38664j75Eic+X2IMT7
        RKUDXo6ahWFbIBzS4DoVT2lniLYJY5gkplyIlSmagPJj/Y1kNkOToJoxNkuamD7CikZWh/Qj7ux
        Ft4+IJVGFveYYKARyE0Mzm50w
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr5719265wmj.156.1586361278158;
        Wed, 08 Apr 2020 08:54:38 -0700 (PDT)
X-Google-Smtp-Source: APiQypJT6MzUUAi0MLdhAAZpBiuYK6o2gfpFrbxz3473qX+5EK7JCJ7DwjwpPhSkpGBI/UrWHw25Mg==
X-Received: by 2002:a7b:ce81:: with SMTP id q1mr5719247wmj.156.1586361277827;
        Wed, 08 Apr 2020 08:54:37 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id u17sm41238777wra.63.2020.04.08.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:54:36 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Olaf Hering <olaf@aepfle.de>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Subject: Re: [PATCH v1] x86: hyperv: report value of misc_features
In-Reply-To: <20200407172739.31371-1-olaf@aepfle.de>
References: <20200407172739.31371-1-olaf@aepfle.de>
Date:   Wed, 08 Apr 2020 17:54:35 +0200
Message-ID: <874ktu2csk.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering <olaf@aepfle.de> writes:

> A few kernel features depend on ms_hyperv.misc_features, but unlike its
> siblings ->features and ->hints, the value was never reported during boot.
>
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index caa032ce3fe3..53706fb56433 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -227,8 +227,8 @@ static void __init ms_hyperv_init_platform(void)
>  	ms_hyperv.misc_features = cpuid_edx(HYPERV_CPUID_FEATURES);
>  	ms_hyperv.hints    = cpuid_eax(HYPERV_CPUID_ENLIGHTMENT_INFO);
>  
> -	pr_info("Hyper-V: features 0x%x, hints 0x%x\n",
> -		ms_hyperv.features, ms_hyperv.hints);
> +	pr_info("Hyper-V: features 0x%x, hints 0x%x, misc 0x%x\n",
> +		ms_hyperv.features, ms_hyperv.hints, ms_hyperv.misc_features);

Several spare thoughts:

I'm always struggling to remember what is what here as these names don't
correspond to TLFS, could we maybe come up with better naming, e.g.

"Features.EAX", "Features.EDX", "Recommendations.EAX",...

On the other hand, there is more, e.g. nested virtualization
features. How is it useful for all users to see this in dmesg every
time? If we need it for development purposes, we can always run 'cpuid'
so maybe let's drop this altogether or print only with pr_debug? 

(Honestly: no strong opinion here, deferring to Microsoft folks).

>  
>  	ms_hyperv.max_vp_index = cpuid_eax(HYPERV_CPUID_IMPLEMENT_LIMITS);
>  	ms_hyperv.max_lp_index = cpuid_ebx(HYPERV_CPUID_IMPLEMENT_LIMITS);
>

-- 
Vitaly

