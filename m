Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C654C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6255320706
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 01:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jFpeUDDb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbgFYBNa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 21:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388789AbgFYBNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 21:13:30 -0400
Received: from mail-vk1-xa43.google.com (mail-vk1-xa43.google.com [IPv6:2607:f8b0:4864:20::a43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE35C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:13:29 -0700 (PDT)
Received: by mail-vk1-xa43.google.com with SMTP id x126so1025206vkb.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 18:13:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yd/PU2VuXCyC+PGBfj/tOPhw/fq362LdKGFogKdH6dQ=;
        b=jFpeUDDb3Q12nPIetx9tHwWUXCdCPqmYgqO3AocKZnBHoE2f6aY6srfCjwIS/PyOkI
         EIogltEO+iQ/5vcXFOysuZ0HXTs6lDIWHjk7r4tWk82usu7zIbk87aDe7skzef9GZLSu
         1aliXE9GSq50dJecN6mhX9M9QpFyZhE0bvWPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yd/PU2VuXCyC+PGBfj/tOPhw/fq362LdKGFogKdH6dQ=;
        b=hFBjzWO0B6EhygteM1bNIkR+a50h0gnku6RxUm+40Q4nHw4++DzfAdnSyN+jX8AkTX
         bh7QI1HXE4n6vkIbBcLDex8bqQP2IrPnNItvTRT5/j8k4JicyDHfmmPoPElL3O6VY2mW
         Ktv9QlyH+Wgna19TMiYWTh9uBysowsf4r+MFoj4uL1WzIxxk/dwT7RYliR5i7C2Z1ieS
         /f79d30ATzXZ+rlzZ0EJ7wOoJbvHFpdDM4ae34bMqYAHGVTsIy3HlOpt+CRVM7EM3vhP
         ueBVjKx33dPfc0XZIins4Fp1vqJRr6UegZ2+33XtkNfsZLg+haMV9zNGaNTyJJtgGYgH
         +Bkw==
X-Gm-Message-State: AOAM5337ygzyfLJzl1rCHRDXfGGcRyCBARULPrPRFRWklE7JrwQjZKAo
        jCc7rPnz/pFjFZayrVggHERIZOFk3qPgrCCwbN2hfQ==
X-Google-Smtp-Source: ABdhPJwKiOSWX9SKERkrM02ddjELrE9HWRfnaQ3thn15r5/L7B+jrDl1gYWZS8uFlfu2joMZ4O4rnre+yeq8SvAjf18=
X-Received: by 2002:a1f:3d47:: with SMTP id k68mr13296326vka.68.1593047608816;
 Wed, 24 Jun 2020 18:13:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200624084524.259560-1-drinkcat@chromium.org> <20200624135722.GF6578@ziepe.ca>
In-Reply-To: <20200624135722.GF6578@ziepe.ca>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Thu, 25 Jun 2020 09:13:17 +0800
Message-ID: <CANMq1KB1W77JATT0NmGpKeCCpWrXraoDAH5SgGMgBESRynTBJQ@mail.gmail.com>
Subject: Re: [PATCH] kernel/trace: Add TRACING_ALLOW_PRINTK config option
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
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

On Wed, Jun 24, 2020 at 9:57 PM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>
> On Wed, Jun 24, 2020 at 04:45:24PM +0800, Nicolas Boichat wrote:
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
> >  include/linux/kernel.h | 17 ++++++++++++++++-
> >  kernel/trace/Kconfig   |  9 +++++++++
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/linux/kernel.h b/include/linux/kernel.h
> > index 196607aaf653082..b6addc6ba669e85 100644
> > +++ b/include/linux/kernel.h
> > @@ -721,10 +721,15 @@ do {                                                                    \
> >  #define trace_printk(fmt, ...)                               \
> >  do {                                                 \
> >       char _______STR[] = __stringify((__VA_ARGS__)); \
> > +                                                     \
> > +     __static_assert(                                \
> > +             IS_ENABLED(CONFIG_TRACING_ALLOW_PRINTK),\
> > +             "trace_printk called, please enable CONFIG_TRACING_ALLOW_PRINTK."); \
> > +                                                     \
>
> Why __static_assert not normal static_assert?

Oh, I misread the macro code (and didn't read the comment above in
include/linux/build_bug.h). static_assert would be just fine.

>
> Jason
