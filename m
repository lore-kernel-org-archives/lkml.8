Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BC4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98B34206F6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 22:08:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U2H/VWrT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbgEUWI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 18:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729308AbgEUWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 18:08:56 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A386C061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:08:56 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n15so4006862pjt.4
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 15:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GtfF1PcFRLZRINro9WPSaeOm8Nx91WCKHudobnn5ez4=;
        b=U2H/VWrTg3ckpsXcrfExBsz4faobo0lqWWAugTNpy4JGANZ5sx6iCTmUzSNhyZeKmR
         XobQyf9IqamEtDYQULc1263svrHUJ4DJ1pQwgKeMVOm0piGb9T8RZYplp1I1C3snwNjs
         iz12AxVAZ/3q2XXfMpBuj/DpJsNYBOJ8Q+Imk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GtfF1PcFRLZRINro9WPSaeOm8Nx91WCKHudobnn5ez4=;
        b=aEWEaaUBkR7t9EGPWuCpFK49ovvlCb4V5z8Y7dpOArX9Q25u0YSyLlVr0YoYcH0TZK
         L6yhhqOYZ8VERwCyIuE7KejiuRgcCDfAQQMRGa/f7Y2zpRf5Er+Q2yA4b/Ouc9JWbwiQ
         xhxY0O7VxDNN53LW4tkalDSHeGwdg3gzbQDBYLf63FstEv6lJaj1L/VnPW+fwycjfa6a
         2xUuCE1cxU3aiC7AXpLv25EGdJ+cBBjS6/VaLTtP5VU73VxylT7hYRQTxV85U4Ts6zIy
         1Ni/JOMJyYgh5Yn5c5FueasmYKR2ssAG446x7Ezlmceuu6+WJfbhgtFGct3IEWys9naW
         UGPw==
X-Gm-Message-State: AOAM532ULffnhxAiPwVcW6RGd7TkvGOws78Jftthm4Hs0G1MnkS1cYnC
        rN8Tn8nVIcUI17YXsoNHjy61DGuWmIg3qg==
X-Google-Smtp-Source: ABdhPJztMyB2N+44/pXohJLaLbkQ4tvVSkv+rL90DrIcJzTW8uDJ1cum87EQ4SM7yIrxuKufV9FZlg==
X-Received: by 2002:a17:902:bf43:: with SMTP id u3mr11389268pls.240.1590098935533;
        Thu, 21 May 2020 15:08:55 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t21sm4790454pgu.39.2020.05.21.15.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 15:08:54 -0700 (PDT)
Date:   Thu, 21 May 2020 15:08:53 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kbuild: reuse vmlinux.o in vmlinux_link
Message-ID: <202005211506.2700F86@keescook>
References: <20200521202716.193316-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202716.193316-1-samitolvanen@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 01:27:16PM -0700, Sami Tolvanen wrote:
> Instead of linking all compilation units again each time vmlinux_link is
> called, reuse vmlinux.o from modpost_link.
> 
> With x86_64 allyesconfig, vmlinux_link is called three times and reusing
> vmlinux.o reduces the build time ~38 seconds on my system (59% reduction
> in the time spent in vmlinux_link).

Nice! Any time savings at final link is a big cumulative win.

> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> ---
>  scripts/link-vmlinux.sh | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index d09ab4afbda4..c6cc4305950c 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh
> @@ -77,11 +77,8 @@ vmlinux_link()
>  
>  	if [ "${SRCARCH}" != "um" ]; then
>  		objects="--whole-archive			\
> -			${KBUILD_VMLINUX_OBJS}			\
> +			vmlinux.o				\
>  			--no-whole-archive			\
> -			--start-group				\
> -			${KBUILD_VMLINUX_LIBS}			\
> -			--end-group				\
>  			${@}"
>  
>  		${LD} ${KBUILD_LDFLAGS} ${LDFLAGS_vmlinux}	\

I think the "um" case can be updated as well too, yes?

Also, I think the comment above modpost_link() needs to be updated now
to reflect the nature of how vmlinux.o gets used after this patch.

-- 
Kees Cook
