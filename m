Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4D8C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:23:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 631C22072C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 19:23:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4Ejzfsi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgCRTXw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 15:23:52 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32814 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726631AbgCRTXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 15:23:52 -0400
Received: by mail-pg1-f194.google.com with SMTP id m5so14234662pgg.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 12:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mx7muvFpVwHYEDvvTglqZzExN2fbeOuxHjC1bhgAdgU=;
        b=V4EjzfsifivBZOeNVuf5E/ZzbAnVnqdfIMiQvM1YbdrGSyKpF5Ml2X/4Az3TaQi+7w
         7dUesMGQ9koBCSta2yamXw51TOIW34jToym2oh9aCFOoM0BIefPs0qwpO2oHp64amlJz
         4An+Bj5TxrdDP80duXSfpjyLydXYYiCIvQLDSiJ5Ll6K4/HLzzqJOdCJmioNEx53LJn8
         jehHbZ9S10lOoiHoDS1fBZEKO+ogq1yJks6GXozGN4KDHFQBhif+shUSGG66civ9LkG5
         p7UEhhcJqoGwNtvnxTH+77ZtvDSuk08Zbi/UXx37nDUIcquagjOFmhml7X2LefyhCXhy
         qpQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mx7muvFpVwHYEDvvTglqZzExN2fbeOuxHjC1bhgAdgU=;
        b=kcpSZLttQOeU3OLTSvXjGOE8T1e6lUAXAc3Fj3KP3QUZS1UA093uEICAPBdilztR/0
         kRZ8RVNbQsWD13WvRyxEXk9HBZBWxJnhm7LFaJdFYv4YcBVV/+34zAgbqO9qLZbFeQkX
         XExb40E2MjaX4YGx2IrQ9PjUWl6TFUa7sXY1acr17/PcJdwniUL83gUyxlkBZ0ahFOt2
         nBExPawup9zIdKrqQVc+KpoMY9gO0QLHOK+FT9n7JZm2ArZXhvoMjRwE02K9j3slo4CZ
         ST2qucuf5Tzhv4bSw86JobgRXd+5QgZw7dRsz1bijYK+4dtnDfHSKz1qDjFBfx7XajNv
         aS2w==
X-Gm-Message-State: ANhLgQ2yLDvB9+LfjH4IpFE+Hi3RRbSL3ZTjXr8bfD+so9AG+FXWz2uj
        YcVDIEBlZRNFWcMXcP+AqUUf05akP7eKHkiMeIA=
X-Google-Smtp-Source: ADFU+vsztW0CPkfoqp5zgMnAbt86npw32Qm1LlSQGgGA6f6ZZBN8DkpiV9F51CfijF1pOJ+F5vM+YRJA3l1N8PERFKA=
X-Received: by 2002:aa7:8149:: with SMTP id d9mr5779069pfn.170.1584559430809;
 Wed, 18 Mar 2020 12:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
In-Reply-To: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 18 Mar 2020 21:23:43 +0200
Message-ID: <CAHp75VezrovVaHOdKoxXvvHr0v7uRT8tJoHLh9BoJYedj=hjHQ@mail.gmail.com>
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of DYNAMIC_DEBUG_CORE
To:     Orson Zhai <orson.unisoc@gmail.com>
Cc:     Jason Baron <jbaron@akamai.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Changbin Du <changbin.du@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gary Hook <Gary.Hook@amd.com>, David Gow <davidgow@google.com>,
        Mark Rutland <mark.rutland@arm.com>, orsonzhai@gmail.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 9:04 PM Orson Zhai <orson.unisoc@gmail.com> wrote:
>
> There is the requirement from new Android that kernel image (GKI) and
> kernel modules are supposed to be built at differnet places. Some people
> want to enable dynamic debug for kernel modules only but not for kernel
> image itself with the consideration of binary size increased or more
> memory being used.
>
> By this patch, dynamic debug is divided into core part (the defination of
> functions) and macro replacement part. We can only have the core part to
> be built-in and do not have to activate the debug output from kenrel image.
>

There are few grammar typos in above...

>  config DYNAMIC_DEBUG
>         bool "Enable dynamic printk() support"
>         default n

> -       depends on PRINTK
> -       depends on DEBUG_FS

You may not touch this. By removing them you effectively removed
dependencies :-(

> +       select DYNAMIC_DEBUG_CORE
>         help
>
>           Compiles debug level messages into the kernel, which would not
> @@ -164,6 +163,21 @@ config DYNAMIC_DEBUG
>           See Documentation/admin-guide/dynamic-debug-howto.rst for additional
>           information.
>
> +config DYNAMIC_DEBUG_CORE
> +       bool "Enable core functions of dynamic debug support"
> +       depends on PRINTK
> +       depends on DEBUG_FS
> +       help
> +         Enable this option to build ddebug_* and __dynamic_* routines
> +         into kernel. If you want enable whole dynamic debug features,
> +         select CONFIG_DYNAMIC_DEBUG directly and this option will be
> +         automatically selected.
> +
> +         This option is selected when you want to enable dynamic debug

> +         for kernel modules only but not for the kernel base. Especailly

Typo.

> +         in the case that kernel modules are built out of the place where
> +         kernel base is built.

Highly recommend to ask somebody to do proof read.

-- 
With Best Regards,
Andy Shevchenko
