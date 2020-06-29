Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF799C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC7E22072D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 19:33:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oZmPy0NU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733041AbgF2Tdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 15:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733225AbgF2Tcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:32:43 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCABC0307AC
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:53:08 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id o22so3143078pjw.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 08:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fvsxr2HY+SFC+OoeANTJ+FulqBtWNjBDs0tQuiH8cfs=;
        b=oZmPy0NUHejl3XUKBcC5T3FFDms87XvGbeC0msSSdPgVOWFAadeDR6/miZ2dl9X0oA
         Q319OjegRbD3vmA9nQ2psCSPOHtWd89Hxkx5GMw/IZ9phj4eB+Gwb0wLu0gDo2mYiSnZ
         HFsIzTOxuHh9gS4KgXnvVz7NT/cILSiaILCNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fvsxr2HY+SFC+OoeANTJ+FulqBtWNjBDs0tQuiH8cfs=;
        b=H7SQyyZd9SSPajOBENy0uBGQIVHrCiLGV4JM5PmAe3Xdpft1TalqATuG/J3aAGfV0p
         EjMpJUIdXm4wrzjT3POXUrKDZ0M2vW/6XL3PzbWmE9w66VrBAYybYe6mJJvek7QyzuCM
         rdyNL/zIB+7gbye9LJI1u6OthxQWYC3BGwuRdCnYZNinKPbucnCqMXnmkfrZqUhNqHaB
         3LdXARbyScpUtkb8rdWR98PEcdCis+zvlbKPsMh8GR9O+k3966J0pnEp6qNWZ0VmZ8I4
         Ezc9LsTP8X91Tj+tZaMv0fA4WKb9uQiH0vogz4dyw0JfLGUj9DXCrH9T/appkrEZTTuN
         fc7Q==
X-Gm-Message-State: AOAM532QvUML/35Z6pZCk02O8ZYVs+eBYk7tcZaQbqCbK4o+7HpW8js/
        ydSG2XEqpUKRCKvAZKIvABZ/Qw==
X-Google-Smtp-Source: ABdhPJzZI0Yxq2JQ/+q+i3HCyDg9pTmqYoI/unXrrriftrBiDaxzs0XO5BRewTpHOTZ8EJko7BAzog==
X-Received: by 2002:a17:90b:1491:: with SMTP id js17mr18692103pjb.118.1593445988392;
        Mon, 29 Jun 2020 08:53:08 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s6sm47034pjz.2.2020.06.29.08.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 08:53:07 -0700 (PDT)
Date:   Mon, 29 Jun 2020 08:53:06 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Sedat Dilek <sedat.dilek@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] x86/boot/compressed: Get rid of GOT fixup code
Message-ID: <202006290852.8D8CAF38@keescook>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200629140928.858507-4-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629140928.858507-4-nivedita@alum.mit.edu>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 10:09:24AM -0400, Arvind Sankar wrote:
> From: Ard Biesheuvel <ardb@kernel.org>
> 
> In a previous patch, we have eliminated GOT entries from the decompressor
> binary and added an assertion that the .got section is empty. This means
> that the GOT fixup routines that exist in both the 32-bit and 64-bit
> startup routines have become dead code, and can be removed.
> 
> While at it, drop the KEEP() from the linker script, as it has no effect
> on the contents of output sections that are created by the linker itself.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> From: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lore.kernel.org/r/20200523120021.34996-4-ardb@kernel.org
> ---
>  arch/x86/boot/compressed/head_32.S     | 24 ++---------
>  arch/x86/boot/compressed/head_64.S     | 57 --------------------------
>  arch/x86/boot/compressed/vmlinux.lds.S |  4 +-
>  3 files changed, 5 insertions(+), 80 deletions(-)

This makes me very happy! This code always bugged me. ;)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
