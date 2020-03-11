Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94935C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B7C82074B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:21:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hBmJYWBf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730606AbgCKRVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:21:42 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:34643 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730441AbgCKRVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:21:24 -0400
Received: by mail-pj1-f65.google.com with SMTP id 39so1759762pjo.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=48QMmtUizH1thzm0jNujCj845cQ2EXOxCkSOb8ufm7M=;
        b=hBmJYWBfK3SX/U+Wa4lao0YnvSduvT0NJG7V47ocA+P7MefK8eMomjpe/u+lfXRu15
         xn2lsBH74aGiSSYjBxFvcQm5wdnJipqlMRNpIOXkiI+AmYbIVDCGXMTkE3S2azr3V/iG
         82LN/7oe0JmAHSXXbhgxIZZvf2n5P7G6lOJCw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=48QMmtUizH1thzm0jNujCj845cQ2EXOxCkSOb8ufm7M=;
        b=l2LGNsQVwYfd7c7Axq34CUu0q4O7WAjU9WkHEb34GazHO++rNCtdlsME3RSAK9O8Hy
         Fnn5bJrzeGwXEACxilvhCcbLt72thhkIbW1Ktq5UEqln0m75LEf/mx+x0BUuIETfgkiu
         JQFwo1StroECOzGlJvWE9B/QjmAeQTLOi7FVbn64bMhV0WO3Usj3RwhC0L5+5pLqzihY
         ih0+6SwBsumWk7YVsARTq7T+wEptAIrpxxnsdaOCQ8D/UdIfjwAEzsSeDF34wMzcKxhA
         Akar1tu79rF9SjI3PpjarYo4jjB6kVUVw/ayCwPH6PzMznVJs+hfsuIQUwCqPgaq7z4m
         0tRg==
X-Gm-Message-State: ANhLgQ01adWN8Kan1cOnf9BBREHEHMC5ZeyTI5XTn6cqUYLm57yjHjjs
        ASwbltgY5nHiwurWGZJPYF/Zdg==
X-Google-Smtp-Source: ADFU+vtS/zoEiYrbfBlqHQlR3ycd/w8ksv3ZJl14F8NXwUqH9zruMZSDylPWrhrRh1sygoxYbEZgXg==
X-Received: by 2002:a17:902:8509:: with SMTP id bj9mr4163017plb.123.1583947282062;
        Wed, 11 Mar 2020 10:21:22 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q187sm51566754pfq.185.2020.03.11.10.21.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:21:21 -0700 (PDT)
Date:   Wed, 11 Mar 2020 10:21:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, Emese Revfy <re.emese@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3] ARM: smp: add support for per-task stack canaries
Message-ID: <202003111020.D543B4332@keescook>
References: <20181206083257.9596-1-ard.biesheuvel@linaro.org>
 <20200309164931.GA23889@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309164931.GA23889@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 09, 2020 at 09:49:31AM -0700, Guenter Roeck wrote:
> On Thu, Dec 06, 2018 at 09:32:57AM +0100, Ard Biesheuvel wrote:
> > On ARM, we currently only change the value of the stack canary when
> > switching tasks if the kernel was built for UP. On SMP kernels, this
> > is impossible since the stack canary value is obtained via a global
> > symbol reference, which means
> > a) all running tasks on all CPUs must use the same value
> > b) we can only modify the value when no kernel stack frames are live
> >    on any CPU, which is effectively never.
> > 
> > So instead, use a GCC plugin to add a RTL pass that replaces each
> > reference to the address of the __stack_chk_guard symbol with an
> > expression that produces the address of the 'stack_canary' field
> > that is added to struct thread_info. This way, each task will use
> > its own randomized value.
> > 
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Emese Revfy <re.emese@gmail.com>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Laura Abbott <labbott@redhat.com>
> > Cc: kernel-hardening@lists.openwall.com
> > Acked-by: Nicolas Pitre <nico@linaro.org>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> Since this patch is in the tree, cc-option no longer works on
> the arm architecture if CONFIG_STACKPROTECTOR_PER_TASK is enabled.
> 
> Any idea how to fix that ? 

I thought Arnd sent a patch to fix it and it got picked up?

-- 
Kees Cook
