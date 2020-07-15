Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB12C433E2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6629B2074B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 01:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KjZxK4Aw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgGOBe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 21:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOBe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 21:34:28 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAC5FC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:34:26 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id o22so1055400pjw.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 18:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zz6sLV8XJxd0lbywoq+z85UDCAeRpW0uEyFQlztJWmw=;
        b=KjZxK4Awqpk1vfXGfBYtI692U7BsBujqOCkBI+QG+yLB2j4Qw3QvteuLd4a70rZ1/c
         yaDe72GoCa2XdEfwiQXcF8IrP6J+bX89NN+6MR8q9jktHJFEmwVxwDVVvmr+PfDGg7Xe
         FDl+SZBUCt2yGQdyLb8rU0QxX4PkdOaDCRikM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zz6sLV8XJxd0lbywoq+z85UDCAeRpW0uEyFQlztJWmw=;
        b=tRPmmfaISsiZAqSOnUqU6hVDqh3UYOhk3UjahjJvnDKWuTi+mgJM5rsNtWBAcBJlmz
         z+ka3bgep6xAFX0pglYrcjsFZiNS8KeDCDlOVIv/wt9LiWZw0ENjqhkOb2O5w2EKn+hN
         Kp40K8/fhQi4GmY9uLh5a2BpIgjRCYjFPhlBd7hIcn39euUwtzzVoRHNV/xaoCDdYWdA
         4AoRXmVblhonpWg6daHs6Z+RswiVWQtl09ZX7W03ALN3ePbZJ0vOawkSxhiyKHm/6TRn
         wToB20aQ964c7u/wBYgL9q8a8w4JccJ9L+GrZndVV8EWZZhyM0eL0gAu1jPiqdU1g4Wz
         UcvA==
X-Gm-Message-State: AOAM533XEWmVtkYn8gtA7Ld8X9pbtwohqxvaZEsPyq5CNHcFDexYzS2i
        SEnSi1n2pt1/GxXE73Qnurn2KA==
X-Google-Smtp-Source: ABdhPJyNqRvX4HpWN93/opBS43GZlWTdZSRq6ybyZkwfnv39UPGj+ErGvx/2WaJfYSwsGuR1sTBmcw==
X-Received: by 2002:a17:90a:1f87:: with SMTP id x7mr7556364pja.101.1594776866202;
        Tue, 14 Jul 2020 18:34:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b18sm276216pju.10.2020.07.14.18.34.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 18:34:25 -0700 (PDT)
Date:   Tue, 14 Jul 2020 18:34:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>, hpa@zytor.com,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Slaby <jslaby@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Juergen Gross <jgross@suse.com>,
        David Rientjes <rientjes@google.com>,
        Cfir Cohen <cfir@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mike Stunes <mstunes@vmware.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Martin Radev <martin.b.radev@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v4 34/75] x86/head/64: Build k/head64.c with
 -fno-stack-protector
Message-ID: <202007141831.F3165F22@keescook>
References: <20200714120917.11253-1-joro@8bytes.org>
 <20200714120917.11253-35-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714120917.11253-35-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 02:08:36PM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The code inserted by the stack protector does not work in the early
> boot environment because it uses the GS segment, at least with memory
> encryption enabled. Make sure the early code is compiled without this
> feature enabled.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  arch/x86/kernel/Makefile | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index e77261db2391..1b166b866059 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -39,6 +39,10 @@ ifdef CONFIG_FRAME_POINTER
>  OBJECT_FILES_NON_STANDARD_ftrace_$(BITS).o		:= y
>  endif
>  
> +# make sure head64.c is built without stack protector
> +nostackp := $(call cc-option, -fno-stack-protector)
> +CFLAGS_head64.o		:= $(nostackp)

Recent refactoring[1] for stack protector suggests this should just
unconditionally be:

CFLAGS_head64.o			+= -fno-stack-protector

But otherwise, yeah, this should be fine here -- it's all early init
stuff.

Reviewed-by: Kees Cook <keescook@chromium.org>

[1] https://lore.kernel.org/lkml/20200626185913.92890-1-masahiroy@kernel.org/

> +
>  # If instrumentation of this dir is enabled, boot hangs during first second.
>  # Probably could be more selective here, but note that files related to irqs,
>  # boot, dumpstack/stacktrace, etc are either non-interesting or can lead to
> -- 
> 2.27.0
> 

-- 
Kees Cook
