Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4813C3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7185E2073B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 04:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z9snj2lv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbgCEE1R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 23:27:17 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:34621 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgCEE1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 23:27:16 -0500
Received: by mail-lf1-f68.google.com with SMTP id w27so3429785lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 20:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=sS9dvBtV87gMWUGiIiRGt8RJH5mq+llNqMeBOdVmClE=;
        b=Z9snj2lvrSLPdsNRBeZOWFaNcyEqk6Dwqvz7hhIVeSaaaJCnXCFQaGOKcUx7z48tXu
         SXmKi+SvTc23cCXr4QQtXz1pXBjtoWoTqLJYNZq8zvUDJ9XjbSq8/TVJDQ1QzOUbD9CY
         oFqY4TO8J3rw5ylDKUW8yOktXBimepvIs3uLSniPjraAFxfp9JZZTL68kFSdrbxODRJa
         o9MSbvOXYwncfHefEmYQyrqOD4HlKx2+IgTEnnkV8+8etB4xEzdQYC2z4EMTcki9aQdA
         wv1WpvFnYwlULtXQkq+LSv1i1Hn+LOtYJw2mOlfnJC1UWJoFvVrbf7b5irUxIopu5M92
         iC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=sS9dvBtV87gMWUGiIiRGt8RJH5mq+llNqMeBOdVmClE=;
        b=o/J3iAFQKlaPlj/jmIKhErLRseU0zhmTA9nShOPD4uhKVBmAfMUrNZxD3TrHPjNr7f
         9rqyTIVV/7YyMgN9ndDAfK5fzxlJK9fZA6E/pP6G2i76ZKEULyP1tf31i3JDJh8kzjkw
         BGilpXcjxQPLJNgHKYh/QUczJ3Y4y2n2qcr2SVB/Wi0dPPjXmQkIYTuAZ6NkGHRTgbcU
         DrCLio4yvjS4Bx1t58y51tW7hcJaHHaSANXkDgOkcEhHFVfpMaf8sBVFdkHXuIyubjnE
         10EN2D+poxhMBr9djB63hFumCv0oYDJeRmsRuxDM1mjrCCr9+oquh2DstJVLvfipSDlI
         Y3dg==
X-Gm-Message-State: ANhLgQ2myRaWpXmxTvNzW9+8YdUnkjU93W1xooQhbZZYwMUsjQRtwMNg
        /dcJmGOLC1sEqQXjNzSFJJXE7wqJD8tEmOEjFy0=
X-Google-Smtp-Source: ADFU+vvj68an1VQy2p4AvnAIwRe0iWTeTc/g/rEg7MViupDuWdJ35eXqac0LFWQ9snFVtaSEIz+2tlonbwlmYG8vTf0=
X-Received: by 2002:a05:6512:3188:: with SMTP id i8mr4256307lfe.26.1583382435049;
 Wed, 04 Mar 2020 20:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20200217083223.2011-9-zong.li@sifive.com> <mhng-da89b7a8-70ef-4ac2-9d56-a4ddab325e9c@palmerdabbelt-glaptop1>
In-Reply-To: <mhng-da89b7a8-70ef-4ac2-9d56-a4ddab325e9c@palmerdabbelt-glaptop1>
From:   Zong Li <zongbox@gmail.com>
Date:   Thu, 5 Mar 2020 12:27:03 +0800
Message-ID: <CA+ZOyairbeQaaJw6VcKWvJzPKkE4-g=p3U45s8gZSrBG=K+jGw@mail.gmail.com>
Subject: Re: [PATCH 8/8] riscv: add two hook functions of ftrace
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Palmer Dabbelt <palmer@dabbelt.com> =E6=96=BC 2020=E5=B9=B43=E6=9C=885=E6=
=97=A5 =E9=80=B1=E5=9B=9B =E4=B8=8A=E5=8D=889:44=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, 17 Feb 2020 00:32:23 PST (-0800), zong.li@sifive.com wrote:
> > After the text section be mask as non-writable, the ftrace have to
> > change the permission of text for dynamic patching the intructions.
> > Add ftrace_arch_code_modify_prepare and
> > ftrace_arch_code_modify_post_process to change permission.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/kernel/ftrace.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/arch/riscv/kernel/ftrace.c b/arch/riscv/kernel/ftrace.c
> > index c40fdcdeb950..576df0807200 100644
> > --- a/arch/riscv/kernel/ftrace.c
> > +++ b/arch/riscv/kernel/ftrace.c
> > @@ -7,9 +7,27 @@
> >
> >  #include <linux/ftrace.h>
> >  #include <linux/uaccess.h>
> > +#include <linux/memory.h>
> > +#include <asm/set_memory.h>
> >  #include <asm/cacheflush.h>
> >
> >  #ifdef CONFIG_DYNAMIC_FTRACE
> > +int ftrace_arch_code_modify_prepare(void) __acquires(&text_mutex)
> > +{
> > +     mutex_lock(&text_mutex);
> > +     set_kernel_text_rw();
> > +     set_all_modules_text_rw();
> > +     return 0;
> > +}
>
> None of the other architectures are doing anything remotely like this in =
these
> functions, despite many supporting STRICT_KERNEL_RWX.  Having a function =
that
> maps all text as RW seems super dangerous, as one stack attack means NX i=
s
> gone.
>
> Looks like FIX_TEXT_POKE0 is the magic that makes the other ports work.
>

Your concern is right. Let me change the way.

> > +
> > +int ftrace_arch_code_modify_post_process(void) __releases(&text_mutex)
> > +{
> > +     set_all_modules_text_ro();
> > +     set_kernel_text_ro();
> > +     mutex_unlock(&text_mutex);
> > +     return 0;
> > +}
>
> Presumably this needs a icache flush as well?  Probably better to do so w=
hen
> installing the instructions, though.
>

Yes, I think I lost it. Thanks.

> > +
> >  static int ftrace_check_current_call(unsigned long hook_pos,
> >                                    unsigned int *expected)
> >  {
>
