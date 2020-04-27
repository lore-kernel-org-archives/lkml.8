Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB63C54FCB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:49:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC6122084D
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 16:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRK7TdGO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726435AbgD0QtE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 12:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgD0QtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 12:49:02 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 641AAC03C1A7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:49:02 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id w20so18370061ljj.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 09:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DggTYojfEhSzNZzSt4p++E5JdlZHCZXJc0ROh9SzVlM=;
        b=GRK7TdGOAvGylag4wlIODdJrhvjeHh+CNCtIcuSjrjRzmjvA/4gHODiRDIqS3Ni+Ul
         xbrVAAQCFm0TrYX2gS2hmjsvmryyRHakKtro88oW5d8as36di5wAZi4QB0mVNrt3VYKC
         +mpM0biKQt1OtPZuP6KA+c31n0Icc3RDkS0F9D8RbdChUBCSxHizssgw5UMLXNS+Ozdv
         GhMLcbyKMjipz7hWcnUogsA5mxtEQ9HhUWk5UBJ4M7FpLiEWL82tfvSHuemxUMjA3T9k
         HQEcjwjSO8dW822QXi8v5ESAjxm5SgtUzR6RIF8ybNX7oWNscelNzVp5wj+yo9QkGQtH
         XR7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DggTYojfEhSzNZzSt4p++E5JdlZHCZXJc0ROh9SzVlM=;
        b=mhfP6UgX2dZJxDip/ysNKepqvEFCvQi4be9sbCgvLiKmNyrQ7sP7fZUTuAPuWQ0YVR
         Y1jM97JATPRnhu/Q2zg+Fv+B7k5LIDw0uADk8zAanF/NBr2aSCx2fvaRFe3FWag5ZNUR
         rTxcXD6QosnYGvq/AbOCPqM5zZTo37Is0dzhgM92uQsWlmesEaGb5muRoNKdp4uSgJ4V
         eVgPxN9puQ4u9k+GGCqepKLlX+TV7TLQoHrw0MjJPgVe6NLk1ynbIqy1oXgm7/dfVYms
         4IZl76LT5YJK5DjXitEsLjLPjm3BqRuisJkeHtIaKgRc7Xxou+58LmbEaGNpROxJ2/NP
         TPCg==
X-Gm-Message-State: AGi0PuYSO8ROELuZJ80+9xP4Vjppqgk816dp/F5RkiGiDwuVImQOGWGa
        4x0r03TaNJp8mjRmPt2ji+v0DJRdV2asEChoY+k=
X-Google-Smtp-Source: APiQypKOZlel+ggVdbFyIPtgHGZpVrDz6ne1COTeLPmgW0WeAhG5IdM5qWoDEvfl/ilzflIttY+StL0Az1RFGIsqSuw=
X-Received: by 2002:a2e:7613:: with SMTP id r19mr4909107ljc.29.1588006140845;
 Mon, 27 Apr 2020 09:49:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191018161033.261971-1-samitolvanen@google.com>
 <20200427160018.243569-1-samitolvanen@google.com> <20200427160018.243569-2-samitolvanen@google.com>
In-Reply-To: <20200427160018.243569-2-samitolvanen@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 27 Apr 2020 18:48:49 +0200
Message-ID: <CANiq72=vvRcjWCON7zbaCTxLA2wP_-5zrnLyymR4g9b1gwc5kg@mail.gmail.com>
Subject: Re: [PATCH v13 01/12] add support for Clang's Shadow Call Stack (SCS)
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Morse <james.morse@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <labbott@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Jann Horn <jannh@google.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 6:00 PM Sami Tolvanen <samitolvanen@google.com> wrote:
>
> diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
> index 333a6695a918..18fc4d29ef27 100644
> --- a/include/linux/compiler-clang.h
> +++ b/include/linux/compiler-clang.h
> @@ -42,3 +42,9 @@
>   * compilers, like ICC.
>   */
>  #define barrier() __asm__ __volatile__("" : : : "memory")
> +
> +#if __has_feature(shadow_call_stack)
> +# define __noscs       __attribute__((__no_sanitize__("shadow-call-stack")))
> +#else
> +# define __noscs
> +#endif

Can we remove the `#else` branch? compiler_types.h [*] has to care
anyway about that case for other compilers anyway, no?

> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index e970f97a7fcb..97b62f47a80d 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -193,6 +193,10 @@ struct ftrace_likely_data {
>  # define randomized_struct_fields_end
>  #endif
>
> +#ifndef __noscs
> +# define __noscs
> +#endif

[*] Here

Cheers,
Miguel
