Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B2AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAE472075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KFYniuhU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgHTVJe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:09:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725859AbgHTVJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:09:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42845C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:09:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 128so1729904pgd.5
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UjiSaglQ75jI6j88glVf44Uda/sc/Nr405Wx3MU9i90=;
        b=KFYniuhUyJt0GJ/A5NuqlGTAZAU0+V6ncRNsqE69SnlvmWq3pPM1dcbNXIRc0yOFfS
         ntNdLnM8VpRXyXQP28VGNro2B+sblcS3igMaecVpFUisMoLpkoaihi/0QtfLnd9fSxle
         qS3nnwfCInkPpXuf33rVOZB3rs20oebdgTRl4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UjiSaglQ75jI6j88glVf44Uda/sc/Nr405Wx3MU9i90=;
        b=fQ+pEJiBuk7jt5txedvEOi3Df1GiWsQyaf/tP68H1pjWxXwWLI5ZgG/eYoOFbK+C4O
         xp5xyBBdYtW/ytHZYDaRmsxyvM0H7Ua0vpi8yQyGOO2oGMyeHH/vibDEK2g5zcHB+wcp
         68rors/TmN20vGeGOAaKtS51qBlhbHsxLdjLDujmdiEsdAEq2Sgd/Hxun8eQ1v4Prbg/
         Pk2YwX71LeeMb5t66xqyGUz5/1anx+c3G1cvQbGRi2duP/kmBqpm/CnMXeAShcpR4172
         ouPue4xUQaOoXXF8a30HJy1PtzJQc8EdkBepJ8LH3ZyHn69pBjfPJ7vZDHqBLcFmVfLm
         87uA==
X-Gm-Message-State: AOAM531/RvKmfCYXKc+Com5dHOYEk4U4V4zx1b1vO/hFhkcbAT4hBKhx
        1n9t6rGjbJ6HH8bzURsrSarfgw==
X-Google-Smtp-Source: ABdhPJzOdlZPLpvYzaIPGI9VzyzZNO0QSe5HCusBzEZ5k6gseQIYvoR42UFn1kWQeXXeIPfqkQAIZw==
X-Received: by 2002:a63:b51a:: with SMTP id y26mr456024pge.376.1597957769546;
        Thu, 20 Aug 2020 14:09:29 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm3824348pfh.168.2020.08.20.14.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 14:09:16 -0700 (PDT)
Date:   Thu, 20 Aug 2020 14:09:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kyle Huey <me@kylehuey.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Keno Fischer <keno@juliacomputing.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: Re: [REGRESSION] x86/entry: Tracer no longer has opportunity to
 change the syscall number at entry via orig_ax
Message-ID: <202008201404.6A0D5736@keescook>
References: <CAP045Arc1Vdh+n2j2ELE3q7XfagLjyqXji9ZD0jqwVB-yuzq-g@mail.gmail.com>
 <87blj6ifo8.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blj6ifo8.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:44:39PM +0200, Thomas Gleixner wrote:
> On Wed, Aug 19 2020 at 10:14, Kyle Huey wrote:
> > tl;dr: after 27d6b4d14f5c3ab21c4aef87dd04055a2d7adf14 ptracer
> > modifications to orig_ax in a syscall entry trace stop are not honored
> > and this breaks our code.
> 
> My fault and I have no idead why none of the silly test cases
> noticed. Fix below.

Hmm, which were you trying? Looking just now, I see that the seccomp
selftests were failing for all their syscall-changing tests.

Regardless, I can confirm both the failure and the fix.

Reported-by: Kyle Huey <me@kylehuey.com>
Tested-by: Kees Cook <keescook@chromium.org>
Acked-by: Kees Cook <keescook@chromium.org>


kernelci.org is *so* close to having the kernel selftests actually
running with their builds. :)

https://github.com/kernelci/kernelci-core/issues/331

-Kees

> 
> Thanks,
> 
>         tglx
> ---
> diff --git a/kernel/entry/common.c b/kernel/entry/common.c
> index 9852e0d62d95..fcae019158ca 100644
> --- a/kernel/entry/common.c
> +++ b/kernel/entry/common.c
> @@ -65,7 +65,8 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
>  
>  	syscall_enter_audit(regs, syscall);
>  
> -	return ret ? : syscall;
> +	/* The above might have changed the syscall number */
> +	return ret ? : syscall_get_nr(current, regs);
>  }
>  
>  noinstr long syscall_enter_from_user_mode(struct pt_regs *regs, long syscall)

-- 
Kees Cook
