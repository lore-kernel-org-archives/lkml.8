Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FE2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C2F52072E
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 21:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VrGO2Qoq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730214AbgGUVrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 17:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726658AbgGUVrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:47:20 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A47FC0619DB
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:47:19 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id m16so10832945pls.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 14:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d0qw9X0tNGniS1ZJuNmh3kQo0rHArpwRCY1SdmDzv4o=;
        b=VrGO2Qoq0WqpJ07WYt90MTK0xpEak25oY1oRNPdwVdrOHTnsfYEQIxRsIeb+iWgK3P
         zWcDPnRsirzCdz+Aa6+WWHFeTwLA9DXgueCQChEQUvveKG56nSmSXKas8mvhOhJBXs16
         P6VL0c0jIp/xMthj2/iqyvn36MIhNwy5vzuSc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d0qw9X0tNGniS1ZJuNmh3kQo0rHArpwRCY1SdmDzv4o=;
        b=G7ylzi4ZHRYhtdcdYmWN0bXLCbDuzOVyQNoxTWVjHpyfw1sjC/fJGeZw1yplFdzsyW
         aRBk4Md32H/DkxrVp+lFRACQnSnqG9FgMkUOtArI0lsdVGKUEPPRtIB8yLcMV5FwyYjC
         Y+2KQNeCr6WluFK+00SsSMVJtCy/KsZD+PKt+r94p4+3s447OYjzeU4c70FaCDuV+YV6
         egRxhupsUQHJixCkhctfqwejukf/1qeCl3++eJKZ+HpsCemQkZVDVMqH3NV3J1B3UNIO
         gRLNCpbyxHP7yIRP6xEKHToqcc9v6qa/ecasB3MA6vHG0qaXSo6AfTqBzWrTqhriSFhv
         11Bg==
X-Gm-Message-State: AOAM530s5JUVNziduCSNrqJh7Unmdn9RRbhpMR6o1xv1hxhbA+il2uLf
        TFS17YtjBkCZN6SyTZ+vPq638ReWJRU=
X-Google-Smtp-Source: ABdhPJzsElosVq+XXtJ0Yinun69/6HciJUEIooMKainxABpdEdX6Grphvcj0PD+BYTIgwXAAXapr3w==
X-Received: by 2002:a17:90a:9287:: with SMTP id n7mr6064081pjo.223.1595368039408;
        Tue, 21 Jul 2020 14:47:19 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b15sm4060054pje.52.2020.07.21.14.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 14:47:18 -0700 (PDT)
Date:   Tue, 21 Jul 2020 14:47:17 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [patch V4 10/15] x86/entry: Use generic syscall entry function
Message-ID: <202007211440.BEF76E2@keescook>
References: <20200721105706.030914876@linutronix.de>
 <20200721110809.325060396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721110809.325060396@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 21, 2020 at 12:57:16PM +0200, Thomas Gleixner wrote:
> Replace the syscall entry work handling with the generic version. Provide
> the necessary helper inlines to handle the real architecture specific
> parts, e.g. ptrace.
> 
> Use a temporary define for idtentry_enter_user which will be cleaned up
> seperately.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

Reviewed-by: Kees Cook <keescook@chromium.org>

Though, notes and a comment below...

> +/* Check that the stack and regs on entry from user mode are sane. */
> +static __always_inline void arch_check_user_regs(struct pt_regs *regs)
> +{
> +	if (IS_ENABLED(CONFIG_DEBUG_ENTRY)) {
> +		/*
> +		 * Make sure that the entry code gave us a sensible EFLAGS
> +		 * register.  Native because we want to check the actual CPU
> +		 * state, not the interrupt state as imagined by Xen.
> +		 */
> +		unsigned long flags = native_save_fl();
> +		WARN_ON_ONCE(flags & (X86_EFLAGS_AC | X86_EFLAGS_DF |
> +				      X86_EFLAGS_NT));

push, pop, bit test

> +
> +		/* We think we came from user mode. Make sure pt_regs agrees. */
> +		WARN_ON_ONCE(!user_mode(regs));

memory deref, bit test

> +
> +		/*
> +		 * All entries from user mode (except #DF) should be on the
> +		 * normal thread stack and should have user pt_regs in the
> +		 * correct location.
> +		 */
> +		WARN_ON_ONCE(!on_thread_stack());

per-cpu deref, subtract, test

> +		WARN_ON_ONCE(regs != task_pt_regs(current));

memory deref, test

> +	}
> +}

This doesn't look very expensive, and they certain indicate really bad
conditions. Does this need to be behind a CONFIG? (Whatever the answer,
we can probably make those changes in a later series -- some of these
also look not arch-specific...)

-- 
Kees Cook
