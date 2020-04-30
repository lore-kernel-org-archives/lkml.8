Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289DBC4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F357E2076D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2IC0BMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgD3Ptd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726350AbgD3Ptc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:49:32 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A916BC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:49:31 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f13so7495606wrm.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 08:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oHm4fy+ZLxCbZPoPq94eRdgDSA3Nknytuwe8uJsLdF4=;
        b=r2IC0BMdrvMLmTNIhoRFaohj8rE6ROROD/SI++ZHKsfJR3Lu3kPJeMzseq5zrHq4zj
         f1rTFV/TxBz1Hnd8sQ4SoPrU07rZLHYJsIpaYUBXeXHDED5MDd/dnq0i0vczTX4PvSkN
         9QrzKN2h5+ay4/p64uU8reoTjvy1ylOJRU5S4uMLf0jY5zPEpCw+RpjMJCr0kCtH8Cvx
         1krTbR8+gGMp0Rxl41DXFgmpBxQDOkJEGDiSHT5Q82OHkzMglPmCdJHdHc+IET5gukwU
         cw+G7SOi3PiNrKInWUsfQjAN5cFB8ywZLgmseYzOC+PjLWLYM8z0FTtk9fKYnPXuLN5w
         drqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oHm4fy+ZLxCbZPoPq94eRdgDSA3Nknytuwe8uJsLdF4=;
        b=IJ9F4cpzHUvA6k7WaT3oBKmGLyCLI5j+4YGDvjFJE/9llnITRMkAg6R/sE1a6mJLVt
         o2a/km+v6QjyE2Guh1BYGYxTz0HwPUywVQSWdzpkf8UxtUn0gqMEoOa4gYS5S6fY7l+f
         /JiaIyMx5Jb6okWLTzoDZ6TWtrYgyFgZRZBPfG+TxicGfS02Vd9nkc+yx2nqZ7pVdyI5
         +b6+bY9vIC9qlNpmEb8GQro1Rc0/7pTE0007YNBzOzR7YFwmRMGgllZarB22GPCBFJ2K
         JBrC2xWV1PsAao2neI41seRCvyZT3NyOMDqAWB8hyvebWRox5cmQJ/mXo53u4msMMlxe
         7R4Q==
X-Gm-Message-State: AGi0PuZSWIPSJkNJ36Q9KBdryD4qtyiTxbgihSw9T4ptt+puOJ7aEJzi
        SwwpOxOi5z3dpvd09lI3gHFNsg==
X-Google-Smtp-Source: APiQypJ6SlONxAl2VrCyPqK4l53N1/WMOfY1UxFBIXSI9NOt7yIOGJ1RUif8f1WEZ9tX9jts4JOv0Q==
X-Received: by 2002:a5d:688f:: with SMTP id h15mr4706411wru.352.1588261770336;
        Thu, 30 Apr 2020 08:49:30 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id f2sm177209wro.59.2020.04.30.08.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 08:49:29 -0700 (PDT)
Date:   Thu, 30 Apr 2020 16:49:27 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     jason.wessel@windriver.com, gregkh@linuxfoundation.org,
        agross@kernel.org, kgdb-bugreport@lists.sourceforge.net,
        catalin.marinas@arm.com, linux-serial@vger.kernel.org,
        sumit.garg@linaro.org, corbet@lwn.net, mingo@redhat.com,
        will@kernel.org, hpa@zytor.com, tglx@linutronix.de,
        frowand.list@gmail.com, bp@alien8.de, bjorn.andersson@linaro.org,
        jslaby@suse.com, Andrew Morton <akpm@linux-foundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v3 04/11] kgdb: Delay "kgdbwait" to dbg_late_init() by
 default
Message-ID: <20200430154927.vhkhoffqwirb2fmm@holly.lan>
References: <20200428211351.85055-1-dianders@chromium.org>
 <20200428141218.v3.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428141218.v3.4.I3113aea1b08d8ce36dc3720209392ae8b815201b@changeid>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 02:13:44PM -0700, Douglas Anderson wrote:
> Using kgdb requires at least some level of architecture-level
> initialization.  If nothing else, it relies on the architecture to
> pass breakpoints / crashes onto kgdb.
> 
> On some architectures this all works super early, specifically it
> starts working at some point in time before Linux parses
> early_params's.  On other architectures it doesn't.  A survey of a few
> platforms:
> 
> a) x86: Presumably it all works early since "ekgdboc" is documented to
>    work here.
> b) arm64: Catching crashes works; with a simple patch breakpoints can
>    also be made to work.
> c) arm: Nothing in kgdb works until
>    paging_init() -> devicemaps_init() -> early_trap_init()
> 
> Let's be conservative and, by default, process "kgdbwait" (which tells
> the kernel to drop into the debugger ASAP at boot) a bit later at
> dbg_late_init() time.  If an architecture has tested it and wants to
> re-enable super early debugging, they can select the
> ARCH_HAS_EARLY_DEBUG KConfig option.  We'll do this for x86 to start.
> It should be noted that dbg_late_init() is still called quite early in
> the system.
> 
> Note that this patch doesn't affect when kgdb runs its init.  If kgdb
> is set to initialize early it will still initialize when parsing
> early_param's.  This patch _only_ inhibits the initial breakpoint from
> "kgdbwait".  This means:
> 
> * Without any extra patches arm64 platforms will at least catch
>   crashes after kgdb inits.
> * arm platforms will catch crashes (and could handle a hardcoded
>   kgdb_breakpoint()) any time after early_trap_init() runs, even
>   before dbg_late_init().
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It looks like this patch is triggering some warnings from the existing
defconfigs (both x86 and arm64). It looks like this:

---
wychelm$ make defconfig
  GEN     Makefile
*** Default configuration is based on 'x86_64_defconfig'

WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
  Depends on [n]: KGDB [=n]
  Selected by [y]:
  - X86 [=y]

WARNING: unmet direct dependencies detected for ARCH_HAS_EARLY_DEBUG
  Depends on [n]: KGDB [=n]
  Selected by [y]:
  - X86 [=y]
#
# No change to .config
#
---


Daniel.
