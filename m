Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58C3C32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8328324673
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 22:42:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sXsMirn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgAVWmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:42:55 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36676 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 17:42:55 -0500
Received: by mail-qk1-f196.google.com with SMTP id c185so66831qkf.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jan 2020 14:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qXZ/KJrrMkAPxK9w8Fg0vztGHi/SkhbzxaC145NxtJI=;
        b=sXsMirn37CAQ/WB+WKFuEAIE9rk+VQ2NiYsaoPgUVrkYT5ygRY77uSH5dtMWlk7Spb
         pM70fYVBRhYyKoS16BtNSVO7JDUehh7RoXjDWpnlcp6VugOtgzTi1kGfmGT2Ujx99ueW
         ZtKB3+qdh2B9wWgptke0viQ1+dvvbO88HLYRYVY4MjLJ8r7rUF/PfxBH3Y5bY/q2bvkd
         ZWFgE2LgmLP2TpQZd3aTlAvM10FshP8TidT3AZjJhissT5DZykClXukjRndLyPhy4msx
         xjjVWcESp6S5WpX6Jay41tziKW5hVvOQH6Nch/qVIwe/tBdzv0sibN30erGjOWv9Iryj
         CKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=qXZ/KJrrMkAPxK9w8Fg0vztGHi/SkhbzxaC145NxtJI=;
        b=X6VAmUBaiIJAJprdfuYOmlgH0umxkAGvzkmsIB3anYyzfL1dug7kAZQklOR49M9Rtc
         D5ELuEpIpf2tg9U02gS/ZgOyu0aSMpabP8o0S4L4rRCO5ABMLmpCiej0MO1w/Ur7Y+so
         +is7RgAe8pIJ3BnMx7rKXbDTLGovpQiz9zhhEB1+NknFVs3nu83/KDckDLN5IcgL+lje
         F3RxRCuCdC6Gr3YRbRpNH/e95q74F8QB4UzaNQTDu3cHs7wq9nup3EaTwU+io+2OX7M+
         VwVLAcIcI755pVJr/L5IN81xuQkHbhESpzMB6TXREX5F3ipSHWhmpuWl2tAmYXcZwt1X
         1j5A==
X-Gm-Message-State: APjAAAVd87cvXWmPOferNA5OsGuXLUvyscezWQYJaTHNWmZVIE/xqXH3
        QTRMl/6ubh5bfho8fkz/j2s=
X-Google-Smtp-Source: APXvYqw/hdLtiN3lQsZ+DqD7Rhr/SUntOpekfUj4ps1bminRv6mJu+kXF+/RqpQBrS41CGwUr+BP0g==
X-Received: by 2002:a37:62c9:: with SMTP id w192mr179913qkb.391.1579732974037;
        Wed, 22 Jan 2020 14:42:54 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id o187sm16589qkf.26.2020.01.22.14.42.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 14:42:53 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 22 Jan 2020 17:42:51 -0500
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>, x86 <x86@kernel.org>
Subject: Re: [PATCH v12] x86/split_lock: Enable split lock detection by kernel
Message-ID: <20200122224245.GA2331824@rani.riverdale.lan>
References: <20191122105141.GY4114@hirez.programming.kicks-ass.net>
 <20191122152715.GA1909@hirez.programming.kicks-ass.net>
 <20191123003056.GA28761@agluck-desk2.amr.corp.intel.com>
 <20191125161348.GA12178@linux.intel.com>
 <20191212085948.GS2827@hirez.programming.kicks-ass.net>
 <20200110192409.GA23315@agluck-desk2.amr.corp.intel.com>
 <20200114055521.GI14928@linux.intel.com>
 <20200115222754.GA13804@agluck-desk2.amr.corp.intel.com>
 <20200115225724.GA18268@linux.intel.com>
 <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200122185514.GA16010@agluck-desk2.amr.corp.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2020 at 10:55:14AM -0800, Luck, Tony wrote:
> +
> +static enum split_lock_detect_state sld_state = sld_warn;
> +

This sets sld_state to sld_warn even on CPUs that don't support
split-lock detection. split_lock_init will then try to read/write the
MSR to turn it on. Would it be better to initialize it to sld_off and
set it to sld_warn in split_lock_setup instead, which is only called if
the CPU supports the feature?

>  
> +dotraplinkage void do_alignment_check(struct pt_regs *regs, long error_code)
> +{
> +	const char str[] = "alignment check";
> +
> +	RCU_LOCKDEP_WARN(!rcu_is_watching(), "entry code didn't wake RCU");
> +
> +	if (notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_AC, SIGBUS) == NOTIFY_STOP)
> +		return;
> +
> +	if (!split_lock_detect_enabled())
> +		return;

This misses one comment from Sean [1] that this check should be dropped,
otherwise user-space alignment check via EFLAGS.AC will get ignored when
split lock detection is disabled.

[1] https://lore.kernel.org/lkml/20191122184457.GA31235@linux.intel.com/

> +
> +	if (!user_mode(regs))
> +		die("Split lock detected\n", regs, error_code);
> +
> +	cond_local_irq_enable(regs);
> +
> +	if (handle_user_split_lock(regs, error_code))
> +		return;
> +
> +	do_trap(X86_TRAP_AC, SIGBUS, "alignment check", regs,
> +		error_code, BUS_ADRALN, NULL);
> +}
> +

Peter [2] called this a possible DOS vector. If userspace is malicious
rather than buggy, couldn't it simply ignore SIGBUS?

[2] https://lore.kernel.org/lkml/20191121131522.GX5671@hirez.programming.kicks-ass.net/
