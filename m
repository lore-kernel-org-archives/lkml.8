Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A5BDC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C65CC2078C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:13:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Hx3rOB44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgDCWNs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:13:48 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:46912 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727879AbgDCWNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:13:48 -0400
Received: by mail-pg1-f196.google.com with SMTP id k191so4204271pgc.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KG760e3FMnxv8FnXQXJos6didPWpKWfKfgbzSvtqHEQ=;
        b=Hx3rOB443eEQZrxZIQBAXikrznjUBLRFhrltR7kyjDb891bPumReNW789UlwuEUILR
         YczEn9OeD6o0ynOM81UErQl1gHBI/u3tlZeUJ/aFmeproIsT3fcupz60ixqLDbjDNyIR
         kWpf8fo0sA204QkwO4hR+Km3wWrmTW9epOzkDJPOseR+qIpyzxTJJ6X6Do4BQdazxf11
         uDrQ7VdEUx8n53KF0t/jkdrU/wbzLfb35fwLwm16VxMd3eJNCwBh4VkcJcxpF2/RdGGu
         Bit7mUrkjHygxMQktAxwhplfZW8QsKK8M3azfO2I0L5mAH4MKsq+OrQRNsFX8Y7rFrDA
         /ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KG760e3FMnxv8FnXQXJos6didPWpKWfKfgbzSvtqHEQ=;
        b=qNcpkNApokguZxIay8yScCsQofZ1Y/SJrgka8PQ2AHx0K8cSmFdA4aRH8vt1Y9K8li
         dKcgrz7cr/8MXOl/NMEevjfmW88DuaKli70Cc+1V0sg8W4eI25BiiibaDsNXK6n7XrlR
         iK1nkx5oKoYv5wYypx+XIOvRnrIqEkC/kdFz76HF5ZzZeOzZ04eipByqC8t6f/cgMhi/
         KWV84d87iKroIY7nmGCi8yx6Yg4HSE3dsUomBuqw/AdKtUzEPMUzw/mzvnJSkTAlwNbw
         wLb3F5QH7m0D0/F27ZGJiWh67BkE9Cai//mkcS1rCQByIaVmY9OeCP9wGTAnYU4vzUfa
         b9IQ==
X-Gm-Message-State: AGi0PuYqw/NrPybfdAw7y6wb/oakXfyMZg9/o16u08d7I1dVLZGzFMv2
        2cc/2CFkEd/WKJGuloemOei+aj3+6WEd0WXN5Fr/8A==
X-Google-Smtp-Source: APiQypK4ieSAMtSmDdk6P9nvKMXJcCzdtCCK8T+0iEQYIgzUsKyQ+yzCIBg+BIwXouZ9MnvBQYHZk4lEIb8/0QKFteQ=
X-Received: by 2002:a63:aa02:: with SMTP id e2mr9458612pgf.263.1585952025437;
 Fri, 03 Apr 2020 15:13:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200325231250.99205-1-ndesaulniers@google.com>
In-Reply-To: <20200325231250.99205-1-ndesaulniers@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 3 Apr 2020 15:13:34 -0700
Message-ID: <CAKwvOdm8tQaa6BW7EQAz4TxFZETnJCS3z9isY4HvcU7UYqWZUA@mail.gmail.com>
Subject: Re: [PATCH] elfnote: mark all .note sections SHF_ALLOC
To:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dropping Jeremy; I got bounceback from the email address. Ping for review?

On Wed, Mar 25, 2020 at 4:13 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> ELFNOTE_START allows callers to specify flags for .pushsection assembler
> directives.  All callsites but ELF_NOTE use "a" for SHF_ALLOC. For
> vdso's that explicitly use ELF_NOTE_START and BUILD_SALT, the same
> section is specified twice after preprocessing, once with "a" flag, once
> without. Example:
>
> .pushsection .note.Linux, "a", @note ;
> .pushsection .note.Linux, "", @note ;
>
> While GNU as allows this ordering, it warns for the opposite ordering,
> making these directives position dependent. We'd prefer not to precisely
> match this behavior in Clang's integrated assembler.  Instead, the non
> __ASSEMBLY__ definition of ELF_NOTE uses
> __attribute__((section(".note.Linux"))) which is created with SHF_ALLOC,
> so let's make the __ASSEMBLY__ definition of ELF_NOTE consistent with C
> and just always use "a" flag.
>
> This allows Clang to assemble a working mainline (5.6) kernel via:
> $ make CC=clang AS=clang
>
> Link: https://github.com/ClangBuiltLinux/linux/issues/913
> Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> Debugged-by: Ilie Halip <ilie.halip@gmail.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> ---
> Ilie has further treewide cleanups:
> https://github.com/ihalip/linux/commits/elfnote
> This patch is the simplest to move us forwards.
>
>  include/linux/elfnote.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
> index 594d4e78654f..69b136e4dd2b 100644
> --- a/include/linux/elfnote.h
> +++ b/include/linux/elfnote.h
> @@ -54,7 +54,7 @@
>  .popsection                            ;
>
>  #define ELFNOTE(name, type, desc)              \
> -       ELFNOTE_START(name, type, "")           \
> +       ELFNOTE_START(name, type, "a")          \
>                 desc                    ;       \
>         ELFNOTE_END
>
> --
> 2.26.0.rc2.310.g2932bb562d-goog
>


-- 
Thanks,
~Nick Desaulniers
