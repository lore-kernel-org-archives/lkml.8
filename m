Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2035BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFB822072D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 06:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586845517;
	bh=tpyZvNMyvZ9PHIJWEWtsgmlwLBBAPX8BScikCpDwRh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MWz5n3cyHO5J82/mV7laSvpfulAF9NnfqZaUr8BLd6LF0wXlAWLAdeTPfRi2Ty7Js
	 H2Q1djl3FrohGtN8sv/x+v8Q2VVS1fnNYDV/lRsmI/OJDmV2g3oekXlnm48o7dD6n2
	 xu8RDLgK88Q8MoWBdrUglE+M3NrFWbfAE6BUfHjQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405952AbgDNGZN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 02:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405926AbgDNGY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 02:24:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C912C0A3BDC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:24:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a81so12592643wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 23:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5gDaraOXlkA/xtwCJ6iLXY9KaVrxo0YP5gI8pwlen5k=;
        b=G8BjWQ+cJ8vn1Bp/mkEQMl7jpOpfpB9g/sOzJ2nrFU7ekd68I1Yqf5QWPEkB0vEsZ1
         BB/yGrhROD/VE0a5KhJI/wbWlUhvInuNpTaaU2yocuHJKLpWsp4V30TiBzmICuJBgjKP
         t92r5Q+67GBUzx1Y7nb8SnDEONddOkEmHYPpaM58yqTfMj5ExgW8TsEs3mO/YXZtkCmj
         OUC+oH3qnMr+eyTaq+f/KbYzxj0cIs2F4cbutKoS5kEB2go657hm5bBbkBEqcD2WMUVG
         LYBXe2usp3jwerxKq4Wk41XZEKvssRGIG+pGPiaQc3+vtUVPku9+510WW3FoQy44WRit
         iFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5gDaraOXlkA/xtwCJ6iLXY9KaVrxo0YP5gI8pwlen5k=;
        b=h0cksP7JygBu9nR10G/aX2aUCdMcDieZx4IZOrSFHRHGeMFV0lEe0Ap15ncp6GcB4n
         nur5u/9Q5XrpniYy8icEK/aod0QvcQjZMnhBJkhB4VFvxuk0l0qyyl5CCTFMCbCyRD73
         nV0fz+hTfTqCOv1pgY8lztCYZmOnTtHZ8Xa8oHL2afitpikJD2P+MBU7mVnJ0fphaafy
         gCJQw93fqHY4ju+BpFM/aLxEz9+XRKPpiLySGoH5VYjXalDF2mcX1zEBckEB16cNZ5eQ
         BUJYsAbeJlG6SB3LI8XKlv/57TJ3oViSBTwu1pOJOPNRIhX5D7nKEyAhNIMjuBpbmhJv
         21iQ==
X-Gm-Message-State: AGi0PuaEwk4CUq3yaCJSCHGzwquUJBO8pGaEQZDNb6Rb/IakKnUGGHj/
        IMYy6TEwNK1q2B0VIvhLiAM=
X-Google-Smtp-Source: APiQypLBxJxImpru3F9x0aQgdW6FGEN8NWHiZYinRaVqtrl1bZSHua4Mcg6ZtSgElDkvCTUmPcyxOg==
X-Received: by 2002:a1c:2383:: with SMTP id j125mr21586371wmj.6.1586845496707;
        Mon, 13 Apr 2020 23:24:56 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id y7sm18504602wmb.43.2020.04.13.23.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 23:24:55 -0700 (PDT)
Date:   Tue, 14 Apr 2020 08:24:54 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86 <x86@kernel.org>,
        Suresh Siddha <suresh.b.siddha@intel.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/apic: Fix circular locking dependency between
 console and hrtimer locks
Message-ID: <20200414062454.GA84326@gmail.com>
References: <20200407170925.1775019-1-leon@kernel.org>
 <20200414054836.GA956407@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414054836.GA956407@unreal>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Leon Romanovsky <leon@kernel.org> wrote:

> Hi,
> 
> Any feedback?
> https://lore.kernel.org/lkml/20200407170925.1775019-1-leon@kernel.org/

The fix definitely looks legit, lockdep is right that we shouldn't take 
the console_sem.lock even under trylock.

It's only a printk_once(), yet I'm wondering why in the last ~8 years 
this never triggered. Nobody ever ran lockdep and debug console level 
enabled on such hardware, or did something else change?

One possibility would be that apic_check_deadline_errata() marked almost 
all Intel systems as broken and the TSC-deadline hardware never actually 
got activated. In that case you have triggered rarely tested code and 
might see other weirdnesses. Just saying. :-)

Or a bootup with "debug" specified is much more rare in production 
systems, hence the 8 years old bug.

> > It is far away from my main expertise and I'm not sure that the solution
> > is correct, but it definitely fixed our regression.
> > ---
> >  arch/x86/kernel/apic/apic.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index d254cebdd3c3..6706b2cd9aec 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -353,7 +353,7 @@ static void __setup_APIC_LVTT(unsigned int clocks, int oneshot, int irqen)
> >  		 */
> >  		asm volatile("mfence" : : : "memory");
> >
> > -		printk_once(KERN_DEBUG "TSC deadline timer enabled\n");
> > +		printk_deferred_once(KERN_DEBUG "TSC deadline timer enabled\n");

I think we should move this essentially initialization-time message much 
earlier during bootup, when we are not holding any hrtimer locks.

One good place would be apic_check_deadline_errata(). This place:

        if (boot_cpu_data.microcode >= rev)
                return;

        setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
        pr_err(FW_BUG "TSC_DEADLINE disabled due to Errata; "
               "please update microcode to version: 0x%x (or later)\n", rev);

Could be something like:

        if (boot_cpu_data.microcode >= rev) {
		pr_debug("x86/apic: TSC deadline timer enabled.\n");
                return;
	}

        setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
        pr_err(FW_BUG "TSC_DEADLINE disabled due to CPU errata, please update microcode to version: 0x%x (or later)\n", rev);

(Note the small fixes I did to the errata message - we should do that and 
also move all user-facing messages into a single line while at it.)

Thanks,

	Ingo
