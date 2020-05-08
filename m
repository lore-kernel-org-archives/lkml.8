Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2981C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:11:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 988C020746
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 18:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xp3JSA4X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgEHSLO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHSLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:11:14 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A72EC061A0C
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 11:11:14 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id s20so1083980plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 11:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tYjR6s9cuyjlDmq4sL9p5CobFaXnRJm49suPQ+5q4HE=;
        b=Xp3JSA4X+ZIxT1zQThy/qkGEJyRDKnfVvcVfXPboIn7NwAy+K2LqVERorMVMvLwPNH
         UCCj4jcQkgTZiZxlkhKUoV7GkpBJ4Fd+Ljiz6kyDkg/zK/FFcX/thA9YGheW69jYRRDG
         u3iKAOtFEUrtMFCzx4oZgVPbNek9WWlHHv+GB9iUpQp8aN+is4kNBxOXzvUtx7IKtSz4
         wpO4sFwhJblqi+uQ3t1r2VTdmVfTxdx/jD1yUHtx9PqJGbRqZT2qz6wtxcIYcUQbTcTF
         ei3lVRty1sIijv6JaLmZr8Arwp7GVK0/IM+ZpABWp0ZbzsNqzCQz1vmk0R8+NpiHJj6x
         drNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tYjR6s9cuyjlDmq4sL9p5CobFaXnRJm49suPQ+5q4HE=;
        b=gsQRI1HVVORMOiQ6zgE7nlAOzG7xlGR+vUham/fFAaCaUD9eeGbX3e5TkESiIOieRd
         8m+COo46aHCmMrEoRdUQfJpkiRgB4ENlZDuh2FlDVahOQHogrfHk6Fh2pam1RLYrC2S+
         GAxF6SPfYWtRyQTLSffh6fIb9zCRBnKIPbG7iBeEyt3opqmHILMJPUzcoZNrZ0n4ap5s
         KlJ2CqzYSH4XanzMrri0A4j5yg7hARAuZ812tDwj1Hkr7dEpaUY93YVCxsfwM2JFvfY3
         /c8f5rVFoSwbgbQPoelN5SxvozuOgpEcLyXQ5EM/Riba0AzC/w/CLS/Iz3iGPF6Afgx9
         Axag==
X-Gm-Message-State: AGi0Pua482F6O9K3WPRhU4Iq7eqXDRjZrhSULYhHvy/6nK6ndGwhyVHK
        CRB8Sm3tSPq42DJH/IeKUHOO9A5pcgG1r6Ige49pyg==
X-Google-Smtp-Source: APiQypIYIM9VOOYp5ro1MKdACCeZ5QjjejURIoETZk6jbD9w5jomYTkwA+Xnyz4419TolW8xbVLBKxeTlX2tGLG3yO8=
X-Received: by 2002:a17:90a:6d03:: with SMTP id z3mr7458232pjj.32.1588961473692;
 Fri, 08 May 2020 11:11:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200507213438.1886005-1-arnd@arndb.de>
In-Reply-To: <20200507213438.1886005-1-arnd@arndb.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 8 May 2020 11:11:02 -0700
Message-ID: <CAKwvOdmk0bKNY735KNtB1agDgTwcLNM=DEU7pL3wwZTj7hQh2Q@mail.gmail.com>
Subject: Re: [PATCH] dlm: remove BUG() before panic()
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Steve Whitehouse <swhiteho@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Richard Fontana <rfontana@redhat.com>,
        cluster-devel@redhat.com, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 2:34 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Building a kernel with clang sometimes fails with an objtool error in dlm:
>
> fs/dlm/lock.o: warning: objtool: revert_lock_pc()+0xbd: can't find jump dest instruction at .text+0xd7fc
>
> The problem is that BUG() never returns and the compiler knows
> that anything after it is unreachable, however the panic still
> emits some code that does not get fully eliminated.
>
> Having both BUG() and panic() is really pointless as the BUG()
> kills the current process and the subsequent panic() never hits.
> In most cases, we probably don't really want either and should
> replace the DLM_ASSERT() statements with WARN_ON(), as has
> been done for some of them.
>
> Remove the BUG() here so the user at least sees the panic message
> and we can reliably build randconfig kernels.
>
> Fixes: e7fd41792fc0 ("[DLM] The core of the DLM for GFS2/CLVM")
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: clang-built-linux@googlegroups.com
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> ---
>  fs/dlm/dlm_internal.h | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/dlm/dlm_internal.h b/fs/dlm/dlm_internal.h
> index 416d9de35679..4311d01b02a8 100644
> --- a/fs/dlm/dlm_internal.h
> +++ b/fs/dlm/dlm_internal.h
> @@ -97,7 +97,6 @@ do { \
>                 __LINE__, __FILE__, #x, jiffies); \
>      {do} \
>      printk("\n"); \
> -    BUG(); \
>      panic("DLM:  Record message above and reboot.\n"); \
>    } \
>  }
> --
> 2.26.0


-- 
Thanks,
~Nick Desaulniers
