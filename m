Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7EBAC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0D68207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:32:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d1aVjd6y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389114AbgFYBcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 21:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388778AbgFYBcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:32:32 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D3FCC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:32:31 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id m62so2644888vsd.4
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XtRqnFKMq7QWn535IlFHjHWcZAxjN0VLjwC/896jlvU=;
        b=d1aVjd6yxFbak1tHbsvs9zmZuPoJr3VYb++bxNsP3u/l0ck+vRZgAJqvzFSjV4ZQap
         515974zSW7VEMAEsxtsT33Qc9Qp0eL9+ldEA9QO9+vKLwBXbOxEvXrXz8ZqkpKgDVSj1
         GdAG9CIDOZ9mBvKspeI3J8f0+9jYSdLLlBodc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XtRqnFKMq7QWn535IlFHjHWcZAxjN0VLjwC/896jlvU=;
        b=ukjNm5hHs/ds+ndU/+FhIgbKoaOTtJz6RrmGFlMYID7aqm2rsOwe/NBBz9GnfRrFMm
         /z9Dln811TymrIwJTPF+G1Vu4FBeJXtPSDLapOZq9N3m9gEOhWPZJhVU8yKDfDLC5vls
         bVizrnjpykQ2BUZs2mzQQQNczclzAoCzPvfoh0RsHlUvWpCKFUF1a+j/YK3GzusZ8IEB
         BQyYH4Aluq3TvL2h6pVid1dB3h8RdOTOZqMAOwBNWbFACdLDejMWTfjlTSf5sWxCKkqB
         qKdi8DAyXodfrA2fNFPRoFOy/iXCU89YArej2WCM2yYsJHf0sQ/GHxpsnex+/W7sqsVG
         Wxcg==
X-Gm-Message-State: AOAM530WUQ7S7BEtq8+uRGvFeEm+Nad9R+utW94L2HZVUicNz8Z5y6EC
        ATA3oFn8WEmdeFgBBfOyBHAniEvcXfg+E4hWFeXDJA==
X-Google-Smtp-Source: ABdhPJzYaB/kCEJd87MiPVqMvYksyxaLqfa4ViJFIWAPpH6tRPKME0t9nHSeC0bgyNtoqzORrDKvdQDWzweZlqq5WUs=
X-Received: by 2002:a67:b405:: with SMTP id x5mr25629621vsl.79.1593048750350;
 Wed, 24 Jun 2020 18:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200624084524.259560-1-drinkcat@chromium.org> <20200624120408.12c8fa0d@oasis.local.home>
In-Reply-To: <20200624120408.12c8fa0d@oasis.local.home>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 25 Jun 2020 09:32:19 +0800
Message-ID: <CANMq1KAVXvMJpNXQoBPMPmSF=vPphvCC_SCFsX03CkR6PY7AKA@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Peter Zijlstra <peterz@infradead.org>,
        Vinod Koul <vkoul@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Guilherme G . Piccoli" <gpiccoli@canonical.com>,
        Will Deacon <will@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 12:04 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 24 Jun 2020 16:45:24 +0800
> Nicolas Boichat <drinkcat@chromium.org> wrote:
>
> > trace_printk is only meant as a debugging tool, and should never be
> > compiled into production code without source code changes, as
> > indicated by the warning that shows up on boot if any trace_printk
> > is called:
> >  **   NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE NOTICE   **
> >  **                                                      **
> >  ** trace_printk() being used. Allocating extra memory.  **
> >  **                                                      **
> >  ** This means that this is a DEBUG kernel and it is     **
> >  ** unsafe for production use.                           **
> >
> > If this option is set to n, the kernel will generate a build-time
> > error if trace_printk is used.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
>
> Interesting. Note, this will prevent modules with trace_printk from
> being loaded as well.

Err, all of these changes are in macros (nothing gets built in the
kernel), so this will prevent modules with trace_printk from being
_built_.

Now, if you set the option to =y when building the module (separately,
even though the rest of the kernel has =n) then I don't see why the
module could not be loaded.

>
> -- Steve
