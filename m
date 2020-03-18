Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98D1C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE6D52071C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 20:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQdLgK8U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgCRUMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 16:12:01 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35685 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbgCRUMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 16:12:01 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so28587611ljo.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 13:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lm1QAgPbIMGNFjr1hUN2+SfO8MIYTxxJtFHbkC9Id28=;
        b=YQdLgK8UoBk3dQ3VtRVYHg+exZ795xukSZj1NzCefm8BMQti3HA+c2KqtPjHpkd++b
         RSKoiuQJdgKEzB8odoiHL0BlkphTThdOHhJZLl2QBZXqMv9CsRCY0Uts7OOuUF/+qwZH
         x5prkFmi0Uv+HkOfWv8BpK4hSpS42VECt5YPJAZZxSNzQHKh19QydR+fd+WziiiB3Tdo
         EUEDAeFsE1vurWKIYfVKhd+ax3/XSafKHfPjHBHxlYIoc7w5AJduadLhdd1WSSc3/Ygp
         V5/ymZmMssOKfmznvp+M8zYu+GeV7z4tl7mbYu7li06dACrQ4t5zGQhZ8Oxduno3bnBW
         D8lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lm1QAgPbIMGNFjr1hUN2+SfO8MIYTxxJtFHbkC9Id28=;
        b=dAvAq2daUVzyXCUvBECcO8dulAxyvv7f9THdYeVb+BKyGx7YxVTiElnI1oQdw+UNs2
         uB/oQElxsbevZN9Xk4AeUkJqRbwcPRbMyCr6reC4XdwfGvEyP2x7V9iJmq2S3dDSyDdR
         fmmaetTypiF8T//Jko/pFsr4cEBUqcrHyGgNlXwCrekgXC0SC1CYrdi1heRxHkd9zpUI
         MJ5OlodCx5u1dkoEZk3CJ0YLuQvGwDvJLqPOHNk5GFh+RgcdGCYnIhyAWhfdCphsvmAY
         Xa85bZtgsKxG/bpPwFDv04a5qxskstnPZwwm3KEYceosa16jhtVf44Y1c7O5ne4IuOW7
         IXAQ==
X-Gm-Message-State: ANhLgQ33vgrhChjbH0NasA7fdxBBlrp/CAl8lPUyHOpjKTPKJLPLuJlu
        qhY5XojDcCUl93PpZfHwPqUlVCWUwSuCFfB56lM=
X-Google-Smtp-Source: ADFU+vsP7fhOXZEAOXIKuyoQe3h715l8mYeL1/qoE7+T9RDBHDi6bJlu+TLBPCnDCdRZTHPcpdFzdfx/QXJstNmJy3w=
X-Received: by 2002:a2e:9a50:: with SMTP id k16mr3482898ljj.164.1584562318513;
 Wed, 18 Mar 2020 13:11:58 -0700 (PDT)
MIME-Version: 1.0
References: <1584558186-23373-1-git-send-email-orson.unisoc@gmail.com> <CAHp75VezrovVaHOdKoxXvvHr0v7uRT8tJoHLh9BoJYedj=hjHQ@mail.gmail.com>
In-Reply-To: <CAHp75VezrovVaHOdKoxXvvHr0v7uRT8tJoHLh9BoJYedj=hjHQ@mail.gmail.com>
From:   Orson Zhai <orsonzhai@gmail.com>
Date:   Thu, 19 Mar 2020 04:11:45 +0800
Message-ID: <CA+H2tpFj1_3wf9w8uHimi_=vrGXi_u21dU1m3+OKA0ZHmO=WRQ@mail.gmail.com>
Subject: Re: [RFC PATCH] dynamic_debug: Add config option of DYNAMIC_DEBUG_CORE
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Orson Zhai <orson.unisoc@gmail.com>,
        Jason Baron <jbaron@akamai.com>,
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
        Mark Rutland <mark.rutland@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 19, 2020 at 3:23 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Mar 18, 2020 at 9:04 PM Orson Zhai <orson.unisoc@gmail.com> wrote:
> >
> > There is the requirement from new Android that kernel image (GKI) and
> > kernel modules are supposed to be built at differnet places. Some people
> > want to enable dynamic debug for kernel modules only but not for kernel
> > image itself with the consideration of binary size increased or more
> > memory being used.
> >
> > By this patch, dynamic debug is divided into core part (the defination of
> > functions) and macro replacement part. We can only have the core part to
> > be built-in and do not have to activate the debug output from kenrel image.
> >
>
> There are few grammar typos in above...

I am very sorry about this. I though check-patch would remind me, but
it seems not. I'll check this carefully next time.

> >  config DYNAMIC_DEBUG
> >         bool "Enable dynamic printk() support"
> >         default n
>
> > -       depends on PRINTK
> > -       depends on DEBUG_FS
>
> You may not touch this. By removing them you effectively removed
> dependencies :-(

OK. I thought dependencies it could be inherited from the selected one.
But I believe you are right. It's not necessary to be removed.
I will add it back at next version.


>
> > +       select DYNAMIC_DEBUG_CORE
> >         help
> >
> >           Compiles debug level messages into the kernel, which would not
> > @@ -164,6 +163,21 @@ config DYNAMIC_DEBUG
> >           See Documentation/admin-guide/dynamic-debug-howto.rst for additional
> >           information.
> >
> > +config DYNAMIC_DEBUG_CORE
> > +       bool "Enable core functions of dynamic debug support"
> > +       depends on PRINTK
> > +       depends on DEBUG_FS
> > +       help
> > +         Enable this option to build ddebug_* and __dynamic_* routines
> > +         into kernel. If you want enable whole dynamic debug features,
> > +         select CONFIG_DYNAMIC_DEBUG directly and this option will be
> > +         automatically selected.
> > +
> > +         This option is selected when you want to enable dynamic debug
>
> > +         for kernel modules only but not for the kernel base. Especailly
>
> Typo.

Will be fixed next version.

>
> > +         in the case that kernel modules are built out of the place where
> > +         kernel base is built.
>
> Highly recommend to ask somebody to do proof read.

Sorry again.

Thanks for your review.

Best Regards,
-Orson
>
> --
> With Best Regards,
> Andy Shevchenko
