Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42373C47253
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20B4A208DB
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 18:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oaC0AEEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgEASPs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 May 2020 14:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729323AbgEASPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 May 2020 14:15:47 -0400
Received: from mail-ua1-x941.google.com (mail-ua1-x941.google.com [IPv6:2607:f8b0:4864:20::941])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BEAC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  1 May 2020 11:15:47 -0700 (PDT)
Received: by mail-ua1-x941.google.com with SMTP id a7so4048655uak.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jQmYU3E4gYOODd95gkjzTcf5jbM8W800pOSwBE+R0wA=;
        b=oaC0AEEo2NvhOsI+1htozQVv14ZztEttOuywn9a8klUXRc5SUM2IDsg94nxs5EsrKe
         SBeXoZmhWdtBBTpV2fC5XtFyDrbFXDGWf8BuXn8eIBYw3W3S0QYdFU3xlfQfYC6YRXKb
         kC50qTkxWFaj/9fexujt3n9HeaLcXZSicokEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jQmYU3E4gYOODd95gkjzTcf5jbM8W800pOSwBE+R0wA=;
        b=XR52OdJQC4jK5Y0kQviM+tBrep1UNfnnBZzfnPWXbcpw7SZe5vyA64fFkPZ9TRNkYx
         lVPydgopGLAawwvVnZX19C6znOzuTMgdaPiCMuxtWn1JiZ8GILtNk66LCusATipihBCs
         +32VdyKhLnUXtIB2KVtSuneGX6k4G2B+/jWiTj8lIPMzdD1xV6ZFBbZez1eg8yIAk13B
         rtq6BfZBE6lJceVjDx5s2ih8+yIltB2Me6vDS89hrYCWy7VTJ2dlT0FZ81MZ9rVe57vO
         r5t1maU9UKQF48qz/gXi9us/6W3x7rER70vG85abW9kYRB4tIxC/PRn1nv54o4qHDB8n
         Om3w==
X-Gm-Message-State: AGi0PuZInZiAVJ8V6gUYK8ckgjxcxZn1BXFuvxEKw/4mo67vSeLBx/BJ
        ttH+w55TH3iHYIympCiGqrYMFom1f9Y=
X-Google-Smtp-Source: APiQypIxRjK2+adm9LXmHfNML5jDm2dXWVR3zpODg18HMvNyFFyNOR9Iva8Nf80AZl6WXfsnt4YYyw==
X-Received: by 2002:ab0:7845:: with SMTP id y5mr3995226uaq.34.1588356946477;
        Fri, 01 May 2020 11:15:46 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id y84sm897979vsc.14.2020.05.01.11.15.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2020 11:15:45 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id v192so2899437vkd.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 May 2020 11:15:45 -0700 (PDT)
X-Received: by 2002:a1f:5fc3:: with SMTP id t186mr3772515vkb.92.1588356945201;
 Fri, 01 May 2020 11:15:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200501161938.2949443-1-daniel.thompson@linaro.org>
In-Reply-To: <20200501161938.2949443-1-daniel.thompson@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 1 May 2020 11:15:33 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WrdKRfM5ExJnhJBCn1ZBTAviuOSq+judda8YSiwbkREw@mail.gmail.com>
Message-ID: <CAD=FV=WrdKRfM5ExJnhJBCn1ZBTAviuOSq+judda8YSiwbkREw@mail.gmail.com>
Subject: Re: [PATCH] arm64: cacheflush: Fix KGDB trap detection
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Patch Tracking <patches@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 1, 2020 at 9:20 AM Daniel Thompson
<daniel.thompson@linaro.org> wrote:
>
> flush_icache_range() contains a bodge to avoid issuing IPIs when the kgdb
> trap handler is running because issuing IPIs is unsafe (and unnecessary)
> in this exection context. However the current test is flawed: it both

s/exection/execution/

> over-matches (could skip the IPI when the kgdb trap is not running) and
> under-matches (does not skip the IPI for all kgdb cache operations).

Maybe explain why?  I believe this is because "kgdb_connected"
signifies that a host "gdb" is connected.

* If we're sitting at the kdb prompt "kgdb_connected" won't be set but
we might still try to do something with a breakpoint with interrupts
off.

* If we are currently _not_ stopped in the debugger but the host "gdb"
is connected then "kgdb_connected" will continue to be set.  In this
context we will exit early if any other callers happen to try to cache
flush with interrupts disabled.


> Fix by replacing the ad-hoc check with the proper kgdb macro. This also
> allows us to drop the #ifdef wrapper.
>
> Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> ---
>  arch/arm64/include/asm/cacheflush.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Other than the suggestions to the commit message:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
