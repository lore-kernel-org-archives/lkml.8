Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65AA7C43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:35:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 156D220737
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 17:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DIJgguHk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389989AbgDBRf2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:35:28 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:36127 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389520AbgDBRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 13:35:28 -0400
Received: by mail-pj1-f68.google.com with SMTP id nu11so1783244pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 10:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=guC1fZiSgEL3S0epJpXk9N5uLkHmIuEzGe6F9jNE+kA=;
        b=DIJgguHk3AE09VWT3DJ0sns+lyhLL5Fek9BYoWxSc5CAyxUPHF+0d3SAzh2aoCH+g/
         tdzWagcY2wv1NyirdNP1ougSZVhHIAU3nf+C+k9UAE5QrzKkhWUXY5jaA8WFTh8TXVro
         KmMngX6pdwvGHDuEsGFv+J/XtSwp6DVcObvu7eWpDXubSTbezSR2uwW64ePCmA5lJ5aj
         pNBzC24v4klZBN5zPkGmA4bQsDW/d0iAYlz0j22OcMq8+W5tW90FUxMK6bkblWHlQ46H
         pyiR/AVnm3nJp+REdEuSr+biVXtMYfN3SXd9IZRqOjaxFXnfy/F28VYBjOsjnXPQmoqG
         MrLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=guC1fZiSgEL3S0epJpXk9N5uLkHmIuEzGe6F9jNE+kA=;
        b=gLAo/O5/7kSOEQnynkZp1UYj60mB/h9k7ScSmVvd8GBlDV+XhFTW0Clol3mryZAjRw
         zHzWYUDRqzo4Yc1LQbyKMT/SldxGfWEIQ1K+EKVxAJgyUgQHDbU/NMnKCoEbSFN9Fziq
         aF1J60/lpTkXoSGOojrtPsjgzB0FNGToYZuZ3lFtU/6vuDejx9x1qdtrFgjHA1j2lQ6M
         6uiPLtpeH9bSRfPbtaw59odKXjOQGuvi0KFheQitl3AZvPXMRzoUrVUlKr/ZIP+e0Rbi
         CCkeM+LHJbcpgithVTYV355FCVqMKfK8QkgdxwszL1RsM+oYAz1ag6GxfO/622qw0Aqq
         Z0rA==
X-Gm-Message-State: AGi0PuaTkhwoz6INA7iyY4ejb8tRe9+Mqx3SCDXccfJ/MUSNGnYq69tx
        +wbOY7hbFCyuWfY16e9zd7Zkz/hpaJpdyWSY4t/+yA==
X-Google-Smtp-Source: APiQypKhhA4JgOWnzW9wlptC/W+qeaOvq+oNcufY7wMKg5yeRE+JqU1hM/6XjzCHlWWNA5gkYgZOQdGXMZeGsT4I9PU=
X-Received: by 2002:a17:90a:8085:: with SMTP id c5mr4543968pjn.186.1585848925816;
 Thu, 02 Apr 2020 10:35:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200402085559.24865-1-ilie.halip@gmail.com>
In-Reply-To: <20200402085559.24865-1-ilie.halip@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 2 Apr 2020 10:35:14 -0700
Message-ID: <CAKwvOdnasXV2Uw1r4we_46oGD_0Ybjanm7T_-9J83bdf6jeOAg@mail.gmail.com>
Subject: Re: [PATCH] riscv: fix vdso build with lld
To:     Ilie Halip <ilie.halip@gmail.com>
Cc:     linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mao Han <han_mao@c-sky.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Jordan Rupprecht <rupprecht@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jordan, Fangrui

On Thu, Apr 2, 2020 at 1:56 AM Ilie Halip <ilie.halip@gmail.com> wrote:
>
> When building with the LLVM linker this error occurrs:
>     LD      arch/riscv/kernel/vdso/vdso-syms.o
>   ld.lld: error: no input files
>
> This happens because the lld treats -R as an alias to -rpath, as opposed
> to ld where -R means --just-symbols.
>
> Use the long option name for compatibility between the two.
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/805
> Reported-by: Dmitry Golovin <dima@golovin.in>
> Signed-off-by: Ilie Halip <ilie.halip@gmail.com>
> ---
>  arch/riscv/kernel/vdso/Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/riscv/kernel/vdso/Makefile b/arch/riscv/kernel/vdso/Makefile
> index 33b16f4212f7..19f7b9ea10ab 100644
> --- a/arch/riscv/kernel/vdso/Makefile
> +++ b/arch/riscv/kernel/vdso/Makefile
> @@ -41,7 +41,8 @@ SYSCFLAGS_vdso.so.dbg = -shared -s -Wl,-soname=linux-vdso.so.1 \
>  $(obj)/vdso-dummy.o: $(src)/vdso.lds $(obj)/rt_sigreturn.o FORCE
>         $(call if_changed,vdsold)
>
> -LDFLAGS_vdso-syms.o := -r -R
> +# lld aliases -R to -rpath; use the longer option name

Thanks for the patch.  Maybe the comment can be dropped? It doesn't
make sense if there's no -R in the source file you're touching.  If
someone cares about why `--just-symbols` is spelled out, that's what
`git log` or vim fugitive is for.  Maybe the maintainer would be kind
enough to just drop that line for you when merging?

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

Jordan, Fangrui, thoughts on this? Sounds like something other users
of LLD might run into porting their codebase to LLVM's linker.

$ ld.lld --help | grep \\-R
  -R <value>              Alias for --rpath
$ ld.bfd --help | grep \\-R
  -R FILE, --just-symbols FILE

> +LDFLAGS_vdso-syms.o := -r --just-symbols
>  $(obj)/vdso-syms.o: $(obj)/vdso-dummy.o FORCE
>         $(call if_changed,ld)
>
> --
> 2.17.1
>


-- 
Thanks,
~Nick Desaulniers
