Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5332C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:22:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7CDD22469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 07:22:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DqCPFLqa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgB1HWp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 02:22:45 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:45900 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbgB1HWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 02:22:45 -0500
Received: by mail-pl1-f196.google.com with SMTP id b22so882909pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 23:22:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s3S+hpLp5sIHa629tQ1zsw+Nl29dkCf3S5rCd+p6od0=;
        b=DqCPFLqaEV3M2s53qW4elKNy8mZ/LySa/GTkoXsaZ38GB0BNEZFMAuIuyfxvFtj/fV
         1g3uI/JWkqGyNoLF4Jt3NsTHuDB+RMx/j7XseHQMBe/Fo4TDmtC3fAXKshQbQFlO4I6m
         cfAb+BHfSIpKCiRExZ/REITPXUg8Ahf6KlY7hUZxYCbDUAGHkv2zb27FSz1461MYHIde
         Wq8p2AhQjWWTUZiXgUSLT2DwWlAOjA4gGIOkWQmdNpR/flJG4LDdvW+y9oOf02bqCy7e
         u7AnfPxh6Lw4KW1xH4BwHLfqkTQUps9lJ6oIgi+BkaAHfCRgVIu3ZC9L0DtHvm+sZdef
         AsMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s3S+hpLp5sIHa629tQ1zsw+Nl29dkCf3S5rCd+p6od0=;
        b=A0uFDIeWI+iL9KBnEOq/b+FknlTlYzk2jzeHJcIetznzJJ05Zjx9ctCoGX/d1jFFSJ
         ZzqeKYZhgHMTe2nkiQTmH+0W4Af6tzQxfcM4N76t0HrDwlVDJbUOv3p9sG1/yQl4AAqg
         RpGQm117FFGfKU3axgfqX8MDybc4vpOUZ7ifqk/yoxtozo+UUkaiDmpH8NFxcNdEQgTf
         EqsqQeBW1PW+TuqzIj20l2LX+7MqZ+/zDR+zGyCEsi2Gn+e70mXUpMtqkfoS9zGMQhoJ
         qPk65P1dMTLBAoViZrkKUXbTWvFy9WQdPqM0lJY+rOj6Z2XXOvGt7DEP+8yoIC+BCNRi
         GyLw==
X-Gm-Message-State: APjAAAWQdG1xdusV73aBo01skST/5JDCWEEXlErd19Eyw5xWRepUJyGL
        t4J/ww6GQeOq4eXqwutVF/8/Li5Nt8qzv/EnKD/XHQ==
X-Google-Smtp-Source: APXvYqzfHO2LjscgalGnPNvJuZJRHFvR5JKj+K4ArJrMoTSjQKwCXbbVKSMib1WlxPMb5cTcx8UR195T8BgeHwMobFY=
X-Received: by 2002:a17:902:8ec1:: with SMTP id x1mr2808157plo.325.1582874562327;
 Thu, 27 Feb 2020 23:22:42 -0800 (PST)
MIME-Version: 1.0
References: <20200228012036.15682-1-brendanhiggins@google.com> <20200228012036.15682-2-brendanhiggins@google.com>
In-Reply-To: <20200228012036.15682-2-brendanhiggins@google.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 27 Feb 2020 23:22:31 -0800
Message-ID: <CAFd5g46dVaV18=5mPLTHh06KQ6nDh4Xw4r8PAZDfSXASi=Qpmg@mail.gmail.com>
Subject: Re: [PATCH v3 1/7] vmlinux.lds.h: add linker section for KUnit test suites
To:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Alan Maguire <alan.maguire@oracle.com>,
        Iurii Zaikin <yzaikin@google.com>,
        David Gow <davidgow@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, rppt@linux.ibm.com,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-arch@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 5:20 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> Add a linker section where KUnit can put references to its test suites.
> This patch is the first step in transitioning to dispatching all KUnit
> tests from a centralized executor rather than having each as its own
> separate late_initcall.
>
> Co-developed-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Iurii Zaikin <yzaikin@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  include/asm-generic/vmlinux.lds.h | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
> index e00f41aa8ec4f..99a866f49cb3d 100644
> --- a/include/asm-generic/vmlinux.lds.h
> +++ b/include/asm-generic/vmlinux.lds.h
> @@ -856,6 +856,13 @@
>                 KEEP(*(.con_initcall.init))                             \
>                 __con_initcall_end = .;
>
> +/* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
> +#define KUNIT_TEST_SUITES                                              \
> +               . = ALIGN(8);                                           \

After posting this, I saw I had gotten an email from 0day[1]. After
some investigation, I discovered that this 8 byte alignment works for
x86 64 bit fine, but only *sometimes* for 32 bit. 4 byte alignment
seems to work in all cases (so far). I am not sure why we went with
such a large alignment in hindsight. In any case, I should have a
fixed revision out pretty soon.

> +               __kunit_suites_start = .;                               \
> +               KEEP(*(.kunit_test_suites))                             \
> +               __kunit_suites_end = .;
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>  #define INIT_RAM_FS                                                    \
>         . = ALIGN(4);                                                   \
> @@ -1024,6 +1031,7 @@
>                 INIT_CALLS                                              \
>                 CON_INITCALL                                            \
>                 INIT_RAM_FS                                             \
> +               KUNIT_TEST_SUITES                                       \
>         }
>
>  #define BSS_SECTION(sbss_align, bss_align, stop_align)                 \
> --

[1] https://lists.01.org/hyperkitty/list/lkp@lists.01.org/thread/4I4UW4OAT63ETMIEUJQTOF3BFTMO6ROD/
